///===
/// extcore/chem_desc_atompair

pub(all) struct ChemdescatompairPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_desc_atompair_make_point(x : Double, y : Double) -> ChemdescatompairPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_desc_atompair_make_point3(x : Double, y : Double, z : Double) -> ChemdescatompairPoint {
  { x, y, z, label: 0 }
}

pub fn ChemdescatompairPoint::x(self : ChemdescatompairPoint) -> Double { self.x }

pub fn ChemdescatompairPoint::y(self : ChemdescatompairPoint) -> Double { self.y }

pub fn ChemdescatompairPoint::z(self : ChemdescatompairPoint) -> Double { self.z }

pub fn ChemdescatompairPoint::label(self : ChemdescatompairPoint) -> Int { self.label }

pub fn ChemdescatompairPoint::dist(self : ChemdescatompairPoint, other : ChemdescatompairPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemdescatompairPoint::add(self : ChemdescatompairPoint, other : ChemdescatompairPoint) -> ChemdescatompairPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemdescatompairPoint::sub(self : ChemdescatompairPoint, other : ChemdescatompairPoint) -> ChemdescatompairPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemdescatompairPoint::scale(self : ChemdescatompairPoint, s : Double) -> ChemdescatompairPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemdescatompairPoint::dot(self : ChemdescatompairPoint, other : ChemdescatompairPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemdescatompairPoint::cross(self : ChemdescatompairPoint, other : ChemdescatompairPoint) -> ChemdescatompairPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemdescatompairPoint::norm(self : ChemdescatompairPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemdescatompairPoint::normalize(self : ChemdescatompairPoint) -> ChemdescatompairPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemdescatompairPoint::negate(self : ChemdescatompairPoint) -> ChemdescatompairPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemdescatompairPoint::mid(self : ChemdescatompairPoint, other : ChemdescatompairPoint) -> ChemdescatompairPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemdescatompairPoint::lerp(self : ChemdescatompairPoint, other : ChemdescatompairPoint, t : Double) -> ChemdescatompairPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemdescatompairPoint::to_string(self : ChemdescatompairPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemdescatompairSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_desc_atompair_make_series(vals : Array[Double], name : String) -> ChemdescatompairSeries {
  { vals, name, meta: 0 }
}

pub fn ChemdescatompairSeries::len(self : ChemdescatompairSeries) -> Int { self.vals.length() }

pub fn ChemdescatompairSeries::sum(self : ChemdescatompairSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemdescatompairSeries::mean(self : ChemdescatompairSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemdescatompairSeries::min(self : ChemdescatompairSeries) -> Double { @_common.min(self.vals) }

pub fn ChemdescatompairSeries::max(self : ChemdescatompairSeries) -> Double { @_common.max(self.vals) }

pub fn ChemdescatompairSeries::range(self : ChemdescatompairSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemdescatompairSeries::variance(self : ChemdescatompairSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemdescatompairSeries::std(self : ChemdescatompairSeries) -> Double { @_common.std(self.vals) }

pub fn ChemdescatompairSeries::median(self : ChemdescatompairSeries) -> Double { @_common.median(self.vals) }

pub fn ChemdescatompairSeries::scale(self : ChemdescatompairSeries, f : Double) -> ChemdescatompairSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemdescatompairSeries::add(self : ChemdescatompairSeries, other : ChemdescatompairSeries) -> ChemdescatompairSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemdescatompairSeries::sub(self : ChemdescatompairSeries, other : ChemdescatompairSeries) -> ChemdescatompairSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemdescatompairSeries::normalize(self : ChemdescatompairSeries) -> ChemdescatompairSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemdescatompairSeries::cumsum(self : ChemdescatompairSeries) -> ChemdescatompairSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemdescatompairSeries::to_string(self : ChemdescatompairSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemdescatompairMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_desc_atompair_make_matrix(rows : Int, cols : Int, val : Double) -> ChemdescatompairMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_desc_atompair_matrix_identity(n : Int) -> ChemdescatompairMatrix {
  let m = chem_desc_atompair_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemdescatompairMatrix::get(self : ChemdescatompairMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemdescatompairMatrix::transpose(self : ChemdescatompairMatrix) -> ChemdescatompairMatrix {
  let result = chem_desc_atompair_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemdescatompairMatrix::add(self : ChemdescatompairMatrix, other : ChemdescatompairMatrix) -> ChemdescatompairMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_desc_atompair_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemdescatompairMatrix::scale(self : ChemdescatompairMatrix, s : Double) -> ChemdescatompairMatrix {
  let result = chem_desc_atompair_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemdescatompairMatrix::multiply(self : ChemdescatompairMatrix, other : ChemdescatompairMatrix) -> ChemdescatompairMatrix {
  if self.cols != other.rows { return chem_desc_atompair_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_desc_atompair_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ChemdescatompairMatrix::trace(self : ChemdescatompairMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemdescatompairMatrix::det(self : ChemdescatompairMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemdescatompairMatrix::norm(self : ChemdescatompairMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemdescatompairMatrix::to_string(self : ChemdescatompairMatrix) -> String {
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

pub(all) struct ChemdescatompairVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_desc_atompair_make_vector(comps : Array[Double]) -> ChemdescatompairVector {
  { comps, dim: comps.length() }
}

pub fn chem_desc_atompair_vector_zero(dim : Int) -> ChemdescatompairVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemdescatompairVector::add(self : ChemdescatompairVector, other : ChemdescatompairVector) -> ChemdescatompairVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemdescatompairVector::sub(self : ChemdescatompairVector, other : ChemdescatompairVector) -> ChemdescatompairVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemdescatompairVector::scale(self : ChemdescatompairVector, s : Double) -> ChemdescatompairVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemdescatompairVector::dot(self : ChemdescatompairVector, other : ChemdescatompairVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemdescatompairVector::norm(self : ChemdescatompairVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemdescatompairVector::normalize(self : ChemdescatompairVector) -> ChemdescatompairVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemdescatompairVector::dist(self : ChemdescatompairVector, other : ChemdescatompairVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemdescatompairVector::to_string(self : ChemdescatompairVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_desc_atompair_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_desc_atompair_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_desc_atompair_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_desc_atompair_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_desc_atompair_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_desc_atompair_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_desc_atompair_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_desc_atompair_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_desc_atompair_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_desc_atompair_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_desc_atompair_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_desc_atompair_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_desc_atompair_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_desc_atompair_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_desc_atompair_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_desc_atompair_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_desc_atompair_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_desc_atompair_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_desc_atompair_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_desc_atompair_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_desc_atompair_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_desc_atompair_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_desc_atompair_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_desc_atompair_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_desc_atompair_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_desc_atompair_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_desc_atompair_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_desc_atompair_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_desc_atompair_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemdescatompairFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_atompair_frame_make(size : Int) -> ChemdescatompairFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescatompairFrame::len(self : ChemdescatompairFrame) -> Int { self.size }

pub fn ChemdescatompairFrame::get(self : ChemdescatompairFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescatompairFrame::set(self : ChemdescatompairFrame, i : Int, v : Double) -> ChemdescatompairFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescatompairFrame::sum(self : ChemdescatompairFrame) -> Double { @_common.sum(self.data) }

pub fn ChemdescatompairFrame::mean(self : ChemdescatompairFrame) -> Double { @_common.mean(self.data) }

pub fn ChemdescatompairFrame::scale(self : ChemdescatompairFrame, f : Double) -> ChemdescatompairFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescatompairFrame::add(self : ChemdescatompairFrame, other : ChemdescatompairFrame) -> ChemdescatompairFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescatompairFrame::copy(self : ChemdescatompairFrame) -> ChemdescatompairFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescatompairFrame::fill(self : ChemdescatompairFrame, v : Double) -> ChemdescatompairFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescatompairFrame::min(self : ChemdescatompairFrame) -> Double { @_common.min(self.data) }

pub fn ChemdescatompairFrame::max(self : ChemdescatompairFrame) -> Double { @_common.max(self.data) }

pub fn ChemdescatompairFrame::to_string(self : ChemdescatompairFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescatompairTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_atompair_table_make(size : Int) -> ChemdescatompairTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescatompairTable::len(self : ChemdescatompairTable) -> Int { self.size }

pub fn ChemdescatompairTable::get(self : ChemdescatompairTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescatompairTable::set(self : ChemdescatompairTable, i : Int, v : Double) -> ChemdescatompairTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescatompairTable::sum(self : ChemdescatompairTable) -> Double { @_common.sum(self.data) }

pub fn ChemdescatompairTable::mean(self : ChemdescatompairTable) -> Double { @_common.mean(self.data) }

pub fn ChemdescatompairTable::scale(self : ChemdescatompairTable, f : Double) -> ChemdescatompairTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescatompairTable::add(self : ChemdescatompairTable, other : ChemdescatompairTable) -> ChemdescatompairTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescatompairTable::copy(self : ChemdescatompairTable) -> ChemdescatompairTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescatompairTable::fill(self : ChemdescatompairTable, v : Double) -> ChemdescatompairTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescatompairTable::min(self : ChemdescatompairTable) -> Double { @_common.min(self.data) }

pub fn ChemdescatompairTable::max(self : ChemdescatompairTable) -> Double { @_common.max(self.data) }

pub fn ChemdescatompairTable::to_string(self : ChemdescatompairTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescatompairGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_atompair_graphn_make(size : Int) -> ChemdescatompairGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescatompairGraphN::len(self : ChemdescatompairGraphN) -> Int { self.size }

pub fn ChemdescatompairGraphN::get(self : ChemdescatompairGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescatompairGraphN::set(self : ChemdescatompairGraphN, i : Int, v : Double) -> ChemdescatompairGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescatompairGraphN::sum(self : ChemdescatompairGraphN) -> Double { @_common.sum(self.data) }

pub fn ChemdescatompairGraphN::mean(self : ChemdescatompairGraphN) -> Double { @_common.mean(self.data) }

pub fn ChemdescatompairGraphN::scale(self : ChemdescatompairGraphN, f : Double) -> ChemdescatompairGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescatompairGraphN::add(self : ChemdescatompairGraphN, other : ChemdescatompairGraphN) -> ChemdescatompairGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescatompairGraphN::copy(self : ChemdescatompairGraphN) -> ChemdescatompairGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescatompairGraphN::fill(self : ChemdescatompairGraphN, v : Double) -> ChemdescatompairGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescatompairGraphN::min(self : ChemdescatompairGraphN) -> Double { @_common.min(self.data) }

pub fn ChemdescatompairGraphN::max(self : ChemdescatompairGraphN) -> Double { @_common.max(self.data) }

pub fn ChemdescatompairGraphN::to_string(self : ChemdescatompairGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescatompairNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_atompair_node_make(size : Int) -> ChemdescatompairNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescatompairNode::len(self : ChemdescatompairNode) -> Int { self.size }

pub fn ChemdescatompairNode::get(self : ChemdescatompairNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescatompairNode::set(self : ChemdescatompairNode, i : Int, v : Double) -> ChemdescatompairNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescatompairNode::sum(self : ChemdescatompairNode) -> Double { @_common.sum(self.data) }

pub fn ChemdescatompairNode::mean(self : ChemdescatompairNode) -> Double { @_common.mean(self.data) }

pub fn ChemdescatompairNode::scale(self : ChemdescatompairNode, f : Double) -> ChemdescatompairNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescatompairNode::add(self : ChemdescatompairNode, other : ChemdescatompairNode) -> ChemdescatompairNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescatompairNode::copy(self : ChemdescatompairNode) -> ChemdescatompairNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescatompairNode::fill(self : ChemdescatompairNode, v : Double) -> ChemdescatompairNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescatompairNode::min(self : ChemdescatompairNode) -> Double { @_common.min(self.data) }

pub fn ChemdescatompairNode::max(self : ChemdescatompairNode) -> Double { @_common.max(self.data) }

pub fn ChemdescatompairNode::to_string(self : ChemdescatompairNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescatompairEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_atompair_edge_make(size : Int) -> ChemdescatompairEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescatompairEdge::len(self : ChemdescatompairEdge) -> Int { self.size }

pub fn ChemdescatompairEdge::get(self : ChemdescatompairEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescatompairEdge::set(self : ChemdescatompairEdge, i : Int, v : Double) -> ChemdescatompairEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescatompairEdge::sum(self : ChemdescatompairEdge) -> Double { @_common.sum(self.data) }

pub fn ChemdescatompairEdge::mean(self : ChemdescatompairEdge) -> Double { @_common.mean(self.data) }

pub fn ChemdescatompairEdge::scale(self : ChemdescatompairEdge, f : Double) -> ChemdescatompairEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescatompairEdge::add(self : ChemdescatompairEdge, other : ChemdescatompairEdge) -> ChemdescatompairEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescatompairEdge::copy(self : ChemdescatompairEdge) -> ChemdescatompairEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescatompairEdge::fill(self : ChemdescatompairEdge, v : Double) -> ChemdescatompairEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescatompairEdge::min(self : ChemdescatompairEdge) -> Double { @_common.min(self.data) }

pub fn ChemdescatompairEdge::max(self : ChemdescatompairEdge) -> Double { @_common.max(self.data) }

pub fn ChemdescatompairEdge::to_string(self : ChemdescatompairEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescatompairPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_atompair_path_make(size : Int) -> ChemdescatompairPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescatompairPath::len(self : ChemdescatompairPath) -> Int { self.size }

pub fn ChemdescatompairPath::get(self : ChemdescatompairPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescatompairPath::set(self : ChemdescatompairPath, i : Int, v : Double) -> ChemdescatompairPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescatompairPath::sum(self : ChemdescatompairPath) -> Double { @_common.sum(self.data) }

pub fn ChemdescatompairPath::mean(self : ChemdescatompairPath) -> Double { @_common.mean(self.data) }

pub fn ChemdescatompairPath::scale(self : ChemdescatompairPath, f : Double) -> ChemdescatompairPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescatompairPath::add(self : ChemdescatompairPath, other : ChemdescatompairPath) -> ChemdescatompairPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescatompairPath::copy(self : ChemdescatompairPath) -> ChemdescatompairPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescatompairPath::fill(self : ChemdescatompairPath, v : Double) -> ChemdescatompairPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescatompairPath::min(self : ChemdescatompairPath) -> Double { @_common.min(self.data) }

pub fn ChemdescatompairPath::max(self : ChemdescatompairPath) -> Double { @_common.max(self.data) }

pub fn ChemdescatompairPath::to_string(self : ChemdescatompairPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescatompairCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_atompair_cluster_make(size : Int) -> ChemdescatompairCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescatompairCluster::len(self : ChemdescatompairCluster) -> Int { self.size }

pub fn ChemdescatompairCluster::get(self : ChemdescatompairCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescatompairCluster::set(self : ChemdescatompairCluster, i : Int, v : Double) -> ChemdescatompairCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescatompairCluster::sum(self : ChemdescatompairCluster) -> Double { @_common.sum(self.data) }

pub fn ChemdescatompairCluster::mean(self : ChemdescatompairCluster) -> Double { @_common.mean(self.data) }

pub fn ChemdescatompairCluster::scale(self : ChemdescatompairCluster, f : Double) -> ChemdescatompairCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescatompairCluster::add(self : ChemdescatompairCluster, other : ChemdescatompairCluster) -> ChemdescatompairCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescatompairCluster::copy(self : ChemdescatompairCluster) -> ChemdescatompairCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescatompairCluster::fill(self : ChemdescatompairCluster, v : Double) -> ChemdescatompairCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescatompairCluster::min(self : ChemdescatompairCluster) -> Double { @_common.min(self.data) }

pub fn ChemdescatompairCluster::max(self : ChemdescatompairCluster) -> Double { @_common.max(self.data) }

pub fn ChemdescatompairCluster::to_string(self : ChemdescatompairCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescatompairModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_atompair_model_make(size : Int) -> ChemdescatompairModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescatompairModel::len(self : ChemdescatompairModel) -> Int { self.size }

pub fn ChemdescatompairModel::get(self : ChemdescatompairModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescatompairModel::set(self : ChemdescatompairModel, i : Int, v : Double) -> ChemdescatompairModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescatompairModel::sum(self : ChemdescatompairModel) -> Double { @_common.sum(self.data) }

pub fn ChemdescatompairModel::mean(self : ChemdescatompairModel) -> Double { @_common.mean(self.data) }

pub fn ChemdescatompairModel::scale(self : ChemdescatompairModel, f : Double) -> ChemdescatompairModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescatompairModel::add(self : ChemdescatompairModel, other : ChemdescatompairModel) -> ChemdescatompairModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescatompairModel::copy(self : ChemdescatompairModel) -> ChemdescatompairModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescatompairModel::fill(self : ChemdescatompairModel, v : Double) -> ChemdescatompairModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescatompairModel::min(self : ChemdescatompairModel) -> Double { @_common.min(self.data) }

pub fn ChemdescatompairModel::max(self : ChemdescatompairModel) -> Double { @_common.max(self.data) }

pub fn ChemdescatompairModel::to_string(self : ChemdescatompairModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescatompairLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_atompair_layer_make(size : Int) -> ChemdescatompairLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescatompairLayer::len(self : ChemdescatompairLayer) -> Int { self.size }

pub fn ChemdescatompairLayer::get(self : ChemdescatompairLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescatompairLayer::set(self : ChemdescatompairLayer, i : Int, v : Double) -> ChemdescatompairLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescatompairLayer::sum(self : ChemdescatompairLayer) -> Double { @_common.sum(self.data) }

pub fn ChemdescatompairLayer::mean(self : ChemdescatompairLayer) -> Double { @_common.mean(self.data) }

pub fn ChemdescatompairLayer::scale(self : ChemdescatompairLayer, f : Double) -> ChemdescatompairLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescatompairLayer::add(self : ChemdescatompairLayer, other : ChemdescatompairLayer) -> ChemdescatompairLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescatompairLayer::copy(self : ChemdescatompairLayer) -> ChemdescatompairLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescatompairLayer::fill(self : ChemdescatompairLayer, v : Double) -> ChemdescatompairLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescatompairLayer::min(self : ChemdescatompairLayer) -> Double { @_common.min(self.data) }

pub fn ChemdescatompairLayer::max(self : ChemdescatompairLayer) -> Double { @_common.max(self.data) }

pub fn ChemdescatompairLayer::to_string(self : ChemdescatompairLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescatompairBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_atompair_buffer_make(size : Int) -> ChemdescatompairBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescatompairBuffer::len(self : ChemdescatompairBuffer) -> Int { self.size }

pub fn ChemdescatompairBuffer::get(self : ChemdescatompairBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescatompairBuffer::set(self : ChemdescatompairBuffer, i : Int, v : Double) -> ChemdescatompairBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescatompairBuffer::sum(self : ChemdescatompairBuffer) -> Double { @_common.sum(self.data) }

pub fn ChemdescatompairBuffer::mean(self : ChemdescatompairBuffer) -> Double { @_common.mean(self.data) }

pub fn ChemdescatompairBuffer::scale(self : ChemdescatompairBuffer, f : Double) -> ChemdescatompairBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescatompairBuffer::add(self : ChemdescatompairBuffer, other : ChemdescatompairBuffer) -> ChemdescatompairBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescatompairBuffer::copy(self : ChemdescatompairBuffer) -> ChemdescatompairBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescatompairBuffer::fill(self : ChemdescatompairBuffer, v : Double) -> ChemdescatompairBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescatompairBuffer::min(self : ChemdescatompairBuffer) -> Double { @_common.min(self.data) }

pub fn ChemdescatompairBuffer::max(self : ChemdescatompairBuffer) -> Double { @_common.max(self.data) }

pub fn ChemdescatompairBuffer::to_string(self : ChemdescatompairBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescatompairCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_atompair_cursor_make(size : Int) -> ChemdescatompairCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescatompairCursor::len(self : ChemdescatompairCursor) -> Int { self.size }

pub fn ChemdescatompairCursor::get(self : ChemdescatompairCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescatompairCursor::set(self : ChemdescatompairCursor, i : Int, v : Double) -> ChemdescatompairCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescatompairCursor::sum(self : ChemdescatompairCursor) -> Double { @_common.sum(self.data) }

pub fn ChemdescatompairCursor::mean(self : ChemdescatompairCursor) -> Double { @_common.mean(self.data) }

pub fn ChemdescatompairCursor::scale(self : ChemdescatompairCursor, f : Double) -> ChemdescatompairCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescatompairCursor::add(self : ChemdescatompairCursor, other : ChemdescatompairCursor) -> ChemdescatompairCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescatompairCursor::copy(self : ChemdescatompairCursor) -> ChemdescatompairCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescatompairCursor::fill(self : ChemdescatompairCursor, v : Double) -> ChemdescatompairCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescatompairCursor::min(self : ChemdescatompairCursor) -> Double { @_common.min(self.data) }

pub fn ChemdescatompairCursor::max(self : ChemdescatompairCursor) -> Double { @_common.max(self.data) }

pub fn ChemdescatompairCursor::to_string(self : ChemdescatompairCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescatompairView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_atompair_view_make(size : Int) -> ChemdescatompairView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescatompairView::len(self : ChemdescatompairView) -> Int { self.size }

pub fn ChemdescatompairView::get(self : ChemdescatompairView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescatompairView::set(self : ChemdescatompairView, i : Int, v : Double) -> ChemdescatompairView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescatompairView::sum(self : ChemdescatompairView) -> Double { @_common.sum(self.data) }

pub fn ChemdescatompairView::mean(self : ChemdescatompairView) -> Double { @_common.mean(self.data) }

pub fn ChemdescatompairView::scale(self : ChemdescatompairView, f : Double) -> ChemdescatompairView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescatompairView::add(self : ChemdescatompairView, other : ChemdescatompairView) -> ChemdescatompairView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescatompairView::copy(self : ChemdescatompairView) -> ChemdescatompairView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescatompairView::fill(self : ChemdescatompairView, v : Double) -> ChemdescatompairView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescatompairView::min(self : ChemdescatompairView) -> Double { @_common.min(self.data) }

pub fn ChemdescatompairView::max(self : ChemdescatompairView) -> Double { @_common.max(self.data) }

pub fn ChemdescatompairView::to_string(self : ChemdescatompairView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescatompairRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_atompair_range_make(size : Int) -> ChemdescatompairRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescatompairRange::len(self : ChemdescatompairRange) -> Int { self.size }

pub fn ChemdescatompairRange::get(self : ChemdescatompairRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescatompairRange::set(self : ChemdescatompairRange, i : Int, v : Double) -> ChemdescatompairRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescatompairRange::sum(self : ChemdescatompairRange) -> Double { @_common.sum(self.data) }

pub fn ChemdescatompairRange::mean(self : ChemdescatompairRange) -> Double { @_common.mean(self.data) }

pub fn ChemdescatompairRange::scale(self : ChemdescatompairRange, f : Double) -> ChemdescatompairRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescatompairRange::add(self : ChemdescatompairRange, other : ChemdescatompairRange) -> ChemdescatompairRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescatompairRange::copy(self : ChemdescatompairRange) -> ChemdescatompairRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescatompairRange::fill(self : ChemdescatompairRange, v : Double) -> ChemdescatompairRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescatompairRange::min(self : ChemdescatompairRange) -> Double { @_common.min(self.data) }

pub fn ChemdescatompairRange::max(self : ChemdescatompairRange) -> Double { @_common.max(self.data) }

pub fn ChemdescatompairRange::to_string(self : ChemdescatompairRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescatompairSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_atompair_slice_make(size : Int) -> ChemdescatompairSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescatompairSlice::len(self : ChemdescatompairSlice) -> Int { self.size }

pub fn ChemdescatompairSlice::get(self : ChemdescatompairSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescatompairSlice::set(self : ChemdescatompairSlice, i : Int, v : Double) -> ChemdescatompairSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescatompairSlice::sum(self : ChemdescatompairSlice) -> Double { @_common.sum(self.data) }

pub fn ChemdescatompairSlice::mean(self : ChemdescatompairSlice) -> Double { @_common.mean(self.data) }

pub fn ChemdescatompairSlice::scale(self : ChemdescatompairSlice, f : Double) -> ChemdescatompairSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescatompairSlice::add(self : ChemdescatompairSlice, other : ChemdescatompairSlice) -> ChemdescatompairSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescatompairSlice::copy(self : ChemdescatompairSlice) -> ChemdescatompairSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescatompairSlice::fill(self : ChemdescatompairSlice, v : Double) -> ChemdescatompairSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescatompairSlice::min(self : ChemdescatompairSlice) -> Double { @_common.min(self.data) }

pub fn ChemdescatompairSlice::max(self : ChemdescatompairSlice) -> Double { @_common.max(self.data) }

pub fn ChemdescatompairSlice::to_string(self : ChemdescatompairSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

