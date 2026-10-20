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

pub fn chem_desc_atompair_frame_len(s : ChemdescatompairFrame) -> Int { s.size }

pub fn chem_desc_atompair_frame_get(s : ChemdescatompairFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_atompair_frame_set(s : ChemdescatompairFrame, i : Int, v : Double) -> ChemdescatompairFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_frame_sum(s : ChemdescatompairFrame) -> Double { @_common.sum(s.data) }

pub fn chem_desc_atompair_frame_mean(s : ChemdescatompairFrame) -> Double { @_common.mean(s.data) }

pub fn chem_desc_atompair_frame_scale(s : ChemdescatompairFrame, f : Double) -> ChemdescatompairFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_frame_add(a : ChemdescatompairFrame, b : ChemdescatompairFrame) -> ChemdescatompairFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_atompair_frame_copy(s : ChemdescatompairFrame) -> ChemdescatompairFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_frame_fill(s : ChemdescatompairFrame, v : Double) -> ChemdescatompairFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_frame_min(s : ChemdescatompairFrame) -> Double { @_common.min(s.data) }

pub fn chem_desc_atompair_frame_max(s : ChemdescatompairFrame) -> Double { @_common.max(s.data) }

pub fn chem_desc_atompair_frame_to_string(s : ChemdescatompairFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescatompairTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_atompair_table_make(size : Int) -> ChemdescatompairTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_atompair_table_len(s : ChemdescatompairTable) -> Int { s.size }

pub fn chem_desc_atompair_table_get(s : ChemdescatompairTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_atompair_table_set(s : ChemdescatompairTable, i : Int, v : Double) -> ChemdescatompairTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_table_sum(s : ChemdescatompairTable) -> Double { @_common.sum(s.data) }

pub fn chem_desc_atompair_table_mean(s : ChemdescatompairTable) -> Double { @_common.mean(s.data) }

pub fn chem_desc_atompair_table_scale(s : ChemdescatompairTable, f : Double) -> ChemdescatompairTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_table_add(a : ChemdescatompairTable, b : ChemdescatompairTable) -> ChemdescatompairTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_atompair_table_copy(s : ChemdescatompairTable) -> ChemdescatompairTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_table_fill(s : ChemdescatompairTable, v : Double) -> ChemdescatompairTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_table_min(s : ChemdescatompairTable) -> Double { @_common.min(s.data) }

pub fn chem_desc_atompair_table_max(s : ChemdescatompairTable) -> Double { @_common.max(s.data) }

pub fn chem_desc_atompair_table_to_string(s : ChemdescatompairTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescatompairGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_atompair_graphn_make(size : Int) -> ChemdescatompairGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_atompair_graphn_len(s : ChemdescatompairGraphN) -> Int { s.size }

pub fn chem_desc_atompair_graphn_get(s : ChemdescatompairGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_atompair_graphn_set(s : ChemdescatompairGraphN, i : Int, v : Double) -> ChemdescatompairGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_graphn_sum(s : ChemdescatompairGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_desc_atompair_graphn_mean(s : ChemdescatompairGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_desc_atompair_graphn_scale(s : ChemdescatompairGraphN, f : Double) -> ChemdescatompairGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_graphn_add(a : ChemdescatompairGraphN, b : ChemdescatompairGraphN) -> ChemdescatompairGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_atompair_graphn_copy(s : ChemdescatompairGraphN) -> ChemdescatompairGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_graphn_fill(s : ChemdescatompairGraphN, v : Double) -> ChemdescatompairGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_graphn_min(s : ChemdescatompairGraphN) -> Double { @_common.min(s.data) }

pub fn chem_desc_atompair_graphn_max(s : ChemdescatompairGraphN) -> Double { @_common.max(s.data) }

pub fn chem_desc_atompair_graphn_to_string(s : ChemdescatompairGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescatompairNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_atompair_node_make(size : Int) -> ChemdescatompairNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_atompair_node_len(s : ChemdescatompairNode) -> Int { s.size }

pub fn chem_desc_atompair_node_get(s : ChemdescatompairNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_atompair_node_set(s : ChemdescatompairNode, i : Int, v : Double) -> ChemdescatompairNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_node_sum(s : ChemdescatompairNode) -> Double { @_common.sum(s.data) }

pub fn chem_desc_atompair_node_mean(s : ChemdescatompairNode) -> Double { @_common.mean(s.data) }

pub fn chem_desc_atompair_node_scale(s : ChemdescatompairNode, f : Double) -> ChemdescatompairNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_node_add(a : ChemdescatompairNode, b : ChemdescatompairNode) -> ChemdescatompairNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_atompair_node_copy(s : ChemdescatompairNode) -> ChemdescatompairNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_node_fill(s : ChemdescatompairNode, v : Double) -> ChemdescatompairNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_node_min(s : ChemdescatompairNode) -> Double { @_common.min(s.data) }

pub fn chem_desc_atompair_node_max(s : ChemdescatompairNode) -> Double { @_common.max(s.data) }

pub fn chem_desc_atompair_node_to_string(s : ChemdescatompairNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescatompairEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_atompair_edge_make(size : Int) -> ChemdescatompairEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_atompair_edge_len(s : ChemdescatompairEdge) -> Int { s.size }

pub fn chem_desc_atompair_edge_get(s : ChemdescatompairEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_atompair_edge_set(s : ChemdescatompairEdge, i : Int, v : Double) -> ChemdescatompairEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_edge_sum(s : ChemdescatompairEdge) -> Double { @_common.sum(s.data) }

pub fn chem_desc_atompair_edge_mean(s : ChemdescatompairEdge) -> Double { @_common.mean(s.data) }

pub fn chem_desc_atompair_edge_scale(s : ChemdescatompairEdge, f : Double) -> ChemdescatompairEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_edge_add(a : ChemdescatompairEdge, b : ChemdescatompairEdge) -> ChemdescatompairEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_atompair_edge_copy(s : ChemdescatompairEdge) -> ChemdescatompairEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_edge_fill(s : ChemdescatompairEdge, v : Double) -> ChemdescatompairEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_edge_min(s : ChemdescatompairEdge) -> Double { @_common.min(s.data) }

pub fn chem_desc_atompair_edge_max(s : ChemdescatompairEdge) -> Double { @_common.max(s.data) }

pub fn chem_desc_atompair_edge_to_string(s : ChemdescatompairEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescatompairPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_atompair_path_make(size : Int) -> ChemdescatompairPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_atompair_path_len(s : ChemdescatompairPath) -> Int { s.size }

pub fn chem_desc_atompair_path_get(s : ChemdescatompairPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_atompair_path_set(s : ChemdescatompairPath, i : Int, v : Double) -> ChemdescatompairPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_path_sum(s : ChemdescatompairPath) -> Double { @_common.sum(s.data) }

pub fn chem_desc_atompair_path_mean(s : ChemdescatompairPath) -> Double { @_common.mean(s.data) }

pub fn chem_desc_atompair_path_scale(s : ChemdescatompairPath, f : Double) -> ChemdescatompairPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_path_add(a : ChemdescatompairPath, b : ChemdescatompairPath) -> ChemdescatompairPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_atompair_path_copy(s : ChemdescatompairPath) -> ChemdescatompairPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_path_fill(s : ChemdescatompairPath, v : Double) -> ChemdescatompairPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_path_min(s : ChemdescatompairPath) -> Double { @_common.min(s.data) }

pub fn chem_desc_atompair_path_max(s : ChemdescatompairPath) -> Double { @_common.max(s.data) }

pub fn chem_desc_atompair_path_to_string(s : ChemdescatompairPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescatompairCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_atompair_cluster_make(size : Int) -> ChemdescatompairCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_atompair_cluster_len(s : ChemdescatompairCluster) -> Int { s.size }

pub fn chem_desc_atompair_cluster_get(s : ChemdescatompairCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_atompair_cluster_set(s : ChemdescatompairCluster, i : Int, v : Double) -> ChemdescatompairCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_cluster_sum(s : ChemdescatompairCluster) -> Double { @_common.sum(s.data) }

pub fn chem_desc_atompair_cluster_mean(s : ChemdescatompairCluster) -> Double { @_common.mean(s.data) }

pub fn chem_desc_atompair_cluster_scale(s : ChemdescatompairCluster, f : Double) -> ChemdescatompairCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_cluster_add(a : ChemdescatompairCluster, b : ChemdescatompairCluster) -> ChemdescatompairCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_atompair_cluster_copy(s : ChemdescatompairCluster) -> ChemdescatompairCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_cluster_fill(s : ChemdescatompairCluster, v : Double) -> ChemdescatompairCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_cluster_min(s : ChemdescatompairCluster) -> Double { @_common.min(s.data) }

pub fn chem_desc_atompair_cluster_max(s : ChemdescatompairCluster) -> Double { @_common.max(s.data) }

pub fn chem_desc_atompair_cluster_to_string(s : ChemdescatompairCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescatompairModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_atompair_model_make(size : Int) -> ChemdescatompairModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_atompair_model_len(s : ChemdescatompairModel) -> Int { s.size }

pub fn chem_desc_atompair_model_get(s : ChemdescatompairModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_atompair_model_set(s : ChemdescatompairModel, i : Int, v : Double) -> ChemdescatompairModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_model_sum(s : ChemdescatompairModel) -> Double { @_common.sum(s.data) }

pub fn chem_desc_atompair_model_mean(s : ChemdescatompairModel) -> Double { @_common.mean(s.data) }

pub fn chem_desc_atompair_model_scale(s : ChemdescatompairModel, f : Double) -> ChemdescatompairModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_model_add(a : ChemdescatompairModel, b : ChemdescatompairModel) -> ChemdescatompairModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_atompair_model_copy(s : ChemdescatompairModel) -> ChemdescatompairModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_model_fill(s : ChemdescatompairModel, v : Double) -> ChemdescatompairModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_model_min(s : ChemdescatompairModel) -> Double { @_common.min(s.data) }

pub fn chem_desc_atompair_model_max(s : ChemdescatompairModel) -> Double { @_common.max(s.data) }

pub fn chem_desc_atompair_model_to_string(s : ChemdescatompairModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescatompairLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_atompair_layer_make(size : Int) -> ChemdescatompairLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_atompair_layer_len(s : ChemdescatompairLayer) -> Int { s.size }

pub fn chem_desc_atompair_layer_get(s : ChemdescatompairLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_atompair_layer_set(s : ChemdescatompairLayer, i : Int, v : Double) -> ChemdescatompairLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_layer_sum(s : ChemdescatompairLayer) -> Double { @_common.sum(s.data) }

pub fn chem_desc_atompair_layer_mean(s : ChemdescatompairLayer) -> Double { @_common.mean(s.data) }

pub fn chem_desc_atompair_layer_scale(s : ChemdescatompairLayer, f : Double) -> ChemdescatompairLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_layer_add(a : ChemdescatompairLayer, b : ChemdescatompairLayer) -> ChemdescatompairLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_atompair_layer_copy(s : ChemdescatompairLayer) -> ChemdescatompairLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_layer_fill(s : ChemdescatompairLayer, v : Double) -> ChemdescatompairLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_layer_min(s : ChemdescatompairLayer) -> Double { @_common.min(s.data) }

pub fn chem_desc_atompair_layer_max(s : ChemdescatompairLayer) -> Double { @_common.max(s.data) }

pub fn chem_desc_atompair_layer_to_string(s : ChemdescatompairLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescatompairBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_atompair_buffer_make(size : Int) -> ChemdescatompairBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_atompair_buffer_len(s : ChemdescatompairBuffer) -> Int { s.size }

pub fn chem_desc_atompair_buffer_get(s : ChemdescatompairBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_atompair_buffer_set(s : ChemdescatompairBuffer, i : Int, v : Double) -> ChemdescatompairBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_buffer_sum(s : ChemdescatompairBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_desc_atompair_buffer_mean(s : ChemdescatompairBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_desc_atompair_buffer_scale(s : ChemdescatompairBuffer, f : Double) -> ChemdescatompairBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_buffer_add(a : ChemdescatompairBuffer, b : ChemdescatompairBuffer) -> ChemdescatompairBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_atompair_buffer_copy(s : ChemdescatompairBuffer) -> ChemdescatompairBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_buffer_fill(s : ChemdescatompairBuffer, v : Double) -> ChemdescatompairBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_buffer_min(s : ChemdescatompairBuffer) -> Double { @_common.min(s.data) }

pub fn chem_desc_atompair_buffer_max(s : ChemdescatompairBuffer) -> Double { @_common.max(s.data) }

pub fn chem_desc_atompair_buffer_to_string(s : ChemdescatompairBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescatompairCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_atompair_cursor_make(size : Int) -> ChemdescatompairCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_atompair_cursor_len(s : ChemdescatompairCursor) -> Int { s.size }

pub fn chem_desc_atompair_cursor_get(s : ChemdescatompairCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_atompair_cursor_set(s : ChemdescatompairCursor, i : Int, v : Double) -> ChemdescatompairCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_cursor_sum(s : ChemdescatompairCursor) -> Double { @_common.sum(s.data) }

pub fn chem_desc_atompair_cursor_mean(s : ChemdescatompairCursor) -> Double { @_common.mean(s.data) }

pub fn chem_desc_atompair_cursor_scale(s : ChemdescatompairCursor, f : Double) -> ChemdescatompairCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_cursor_add(a : ChemdescatompairCursor, b : ChemdescatompairCursor) -> ChemdescatompairCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_atompair_cursor_copy(s : ChemdescatompairCursor) -> ChemdescatompairCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_cursor_fill(s : ChemdescatompairCursor, v : Double) -> ChemdescatompairCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_cursor_min(s : ChemdescatompairCursor) -> Double { @_common.min(s.data) }

pub fn chem_desc_atompair_cursor_max(s : ChemdescatompairCursor) -> Double { @_common.max(s.data) }

pub fn chem_desc_atompair_cursor_to_string(s : ChemdescatompairCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescatompairView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_atompair_view_make(size : Int) -> ChemdescatompairView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_atompair_view_len(s : ChemdescatompairView) -> Int { s.size }

pub fn chem_desc_atompair_view_get(s : ChemdescatompairView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_atompair_view_set(s : ChemdescatompairView, i : Int, v : Double) -> ChemdescatompairView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_view_sum(s : ChemdescatompairView) -> Double { @_common.sum(s.data) }

pub fn chem_desc_atompair_view_mean(s : ChemdescatompairView) -> Double { @_common.mean(s.data) }

pub fn chem_desc_atompair_view_scale(s : ChemdescatompairView, f : Double) -> ChemdescatompairView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_view_add(a : ChemdescatompairView, b : ChemdescatompairView) -> ChemdescatompairView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_atompair_view_copy(s : ChemdescatompairView) -> ChemdescatompairView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_view_fill(s : ChemdescatompairView, v : Double) -> ChemdescatompairView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_view_min(s : ChemdescatompairView) -> Double { @_common.min(s.data) }

pub fn chem_desc_atompair_view_max(s : ChemdescatompairView) -> Double { @_common.max(s.data) }

pub fn chem_desc_atompair_view_to_string(s : ChemdescatompairView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescatompairRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_atompair_range_make(size : Int) -> ChemdescatompairRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_atompair_range_len(s : ChemdescatompairRange) -> Int { s.size }

pub fn chem_desc_atompair_range_get(s : ChemdescatompairRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_atompair_range_set(s : ChemdescatompairRange, i : Int, v : Double) -> ChemdescatompairRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_range_sum(s : ChemdescatompairRange) -> Double { @_common.sum(s.data) }

pub fn chem_desc_atompair_range_mean(s : ChemdescatompairRange) -> Double { @_common.mean(s.data) }

pub fn chem_desc_atompair_range_scale(s : ChemdescatompairRange, f : Double) -> ChemdescatompairRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_range_add(a : ChemdescatompairRange, b : ChemdescatompairRange) -> ChemdescatompairRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_atompair_range_copy(s : ChemdescatompairRange) -> ChemdescatompairRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_range_fill(s : ChemdescatompairRange, v : Double) -> ChemdescatompairRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_range_min(s : ChemdescatompairRange) -> Double { @_common.min(s.data) }

pub fn chem_desc_atompair_range_max(s : ChemdescatompairRange) -> Double { @_common.max(s.data) }

pub fn chem_desc_atompair_range_to_string(s : ChemdescatompairRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescatompairSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_atompair_slice_make(size : Int) -> ChemdescatompairSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_atompair_slice_len(s : ChemdescatompairSlice) -> Int { s.size }

pub fn chem_desc_atompair_slice_get(s : ChemdescatompairSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_atompair_slice_set(s : ChemdescatompairSlice, i : Int, v : Double) -> ChemdescatompairSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_slice_sum(s : ChemdescatompairSlice) -> Double { @_common.sum(s.data) }

pub fn chem_desc_atompair_slice_mean(s : ChemdescatompairSlice) -> Double { @_common.mean(s.data) }

pub fn chem_desc_atompair_slice_scale(s : ChemdescatompairSlice, f : Double) -> ChemdescatompairSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_slice_add(a : ChemdescatompairSlice, b : ChemdescatompairSlice) -> ChemdescatompairSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_atompair_slice_copy(s : ChemdescatompairSlice) -> ChemdescatompairSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_slice_fill(s : ChemdescatompairSlice, v : Double) -> ChemdescatompairSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_atompair_slice_min(s : ChemdescatompairSlice) -> Double { @_common.min(s.data) }

pub fn chem_desc_atompair_slice_max(s : ChemdescatompairSlice) -> Double { @_common.max(s.data) }

pub fn chem_desc_atompair_slice_to_string(s : ChemdescatompairSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

