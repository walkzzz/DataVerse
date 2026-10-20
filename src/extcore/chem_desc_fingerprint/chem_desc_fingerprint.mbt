///===
/// extcore/chem_desc_fingerprint

pub(all) struct ChemdescfingerprintPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_desc_fingerprint_make_point(x : Double, y : Double) -> ChemdescfingerprintPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_desc_fingerprint_make_point3(x : Double, y : Double, z : Double) -> ChemdescfingerprintPoint {
  { x, y, z, label: 0 }
}

pub fn ChemdescfingerprintPoint::x(self : ChemdescfingerprintPoint) -> Double { self.x }

pub fn ChemdescfingerprintPoint::y(self : ChemdescfingerprintPoint) -> Double { self.y }

pub fn ChemdescfingerprintPoint::z(self : ChemdescfingerprintPoint) -> Double { self.z }

pub fn ChemdescfingerprintPoint::label(self : ChemdescfingerprintPoint) -> Int { self.label }

pub fn ChemdescfingerprintPoint::dist(self : ChemdescfingerprintPoint, other : ChemdescfingerprintPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemdescfingerprintPoint::add(self : ChemdescfingerprintPoint, other : ChemdescfingerprintPoint) -> ChemdescfingerprintPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemdescfingerprintPoint::sub(self : ChemdescfingerprintPoint, other : ChemdescfingerprintPoint) -> ChemdescfingerprintPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemdescfingerprintPoint::scale(self : ChemdescfingerprintPoint, s : Double) -> ChemdescfingerprintPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemdescfingerprintPoint::dot(self : ChemdescfingerprintPoint, other : ChemdescfingerprintPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemdescfingerprintPoint::cross(self : ChemdescfingerprintPoint, other : ChemdescfingerprintPoint) -> ChemdescfingerprintPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemdescfingerprintPoint::norm(self : ChemdescfingerprintPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemdescfingerprintPoint::normalize(self : ChemdescfingerprintPoint) -> ChemdescfingerprintPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemdescfingerprintPoint::negate(self : ChemdescfingerprintPoint) -> ChemdescfingerprintPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemdescfingerprintPoint::mid(self : ChemdescfingerprintPoint, other : ChemdescfingerprintPoint) -> ChemdescfingerprintPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemdescfingerprintPoint::lerp(self : ChemdescfingerprintPoint, other : ChemdescfingerprintPoint, t : Double) -> ChemdescfingerprintPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemdescfingerprintPoint::to_string(self : ChemdescfingerprintPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemdescfingerprintSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_desc_fingerprint_make_series(vals : Array[Double], name : String) -> ChemdescfingerprintSeries {
  { vals, name, meta: 0 }
}

pub fn ChemdescfingerprintSeries::len(self : ChemdescfingerprintSeries) -> Int { self.vals.length() }

pub fn ChemdescfingerprintSeries::sum(self : ChemdescfingerprintSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemdescfingerprintSeries::mean(self : ChemdescfingerprintSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemdescfingerprintSeries::min(self : ChemdescfingerprintSeries) -> Double { @_common.min(self.vals) }

pub fn ChemdescfingerprintSeries::max(self : ChemdescfingerprintSeries) -> Double { @_common.max(self.vals) }

pub fn ChemdescfingerprintSeries::range(self : ChemdescfingerprintSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemdescfingerprintSeries::variance(self : ChemdescfingerprintSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemdescfingerprintSeries::std(self : ChemdescfingerprintSeries) -> Double { @_common.std(self.vals) }

pub fn ChemdescfingerprintSeries::median(self : ChemdescfingerprintSeries) -> Double { @_common.median(self.vals) }

pub fn ChemdescfingerprintSeries::scale(self : ChemdescfingerprintSeries, f : Double) -> ChemdescfingerprintSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemdescfingerprintSeries::add(self : ChemdescfingerprintSeries, other : ChemdescfingerprintSeries) -> ChemdescfingerprintSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemdescfingerprintSeries::sub(self : ChemdescfingerprintSeries, other : ChemdescfingerprintSeries) -> ChemdescfingerprintSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemdescfingerprintSeries::normalize(self : ChemdescfingerprintSeries) -> ChemdescfingerprintSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemdescfingerprintSeries::cumsum(self : ChemdescfingerprintSeries) -> ChemdescfingerprintSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemdescfingerprintSeries::to_string(self : ChemdescfingerprintSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemdescfingerprintMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_desc_fingerprint_make_matrix(rows : Int, cols : Int, val : Double) -> ChemdescfingerprintMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_desc_fingerprint_matrix_identity(n : Int) -> ChemdescfingerprintMatrix {
  let m = chem_desc_fingerprint_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemdescfingerprintMatrix::get(self : ChemdescfingerprintMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemdescfingerprintMatrix::transpose(self : ChemdescfingerprintMatrix) -> ChemdescfingerprintMatrix {
  let result = chem_desc_fingerprint_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemdescfingerprintMatrix::add(self : ChemdescfingerprintMatrix, other : ChemdescfingerprintMatrix) -> ChemdescfingerprintMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_desc_fingerprint_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemdescfingerprintMatrix::scale(self : ChemdescfingerprintMatrix, s : Double) -> ChemdescfingerprintMatrix {
  let result = chem_desc_fingerprint_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemdescfingerprintMatrix::multiply(self : ChemdescfingerprintMatrix, other : ChemdescfingerprintMatrix) -> ChemdescfingerprintMatrix {
  if self.cols != other.rows { return chem_desc_fingerprint_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_desc_fingerprint_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ChemdescfingerprintMatrix::trace(self : ChemdescfingerprintMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemdescfingerprintMatrix::det(self : ChemdescfingerprintMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemdescfingerprintMatrix::norm(self : ChemdescfingerprintMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemdescfingerprintMatrix::to_string(self : ChemdescfingerprintMatrix) -> String {
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

pub(all) struct ChemdescfingerprintVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_desc_fingerprint_make_vector(comps : Array[Double]) -> ChemdescfingerprintVector {
  { comps, dim: comps.length() }
}

pub fn chem_desc_fingerprint_vector_zero(dim : Int) -> ChemdescfingerprintVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemdescfingerprintVector::add(self : ChemdescfingerprintVector, other : ChemdescfingerprintVector) -> ChemdescfingerprintVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemdescfingerprintVector::sub(self : ChemdescfingerprintVector, other : ChemdescfingerprintVector) -> ChemdescfingerprintVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemdescfingerprintVector::scale(self : ChemdescfingerprintVector, s : Double) -> ChemdescfingerprintVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemdescfingerprintVector::dot(self : ChemdescfingerprintVector, other : ChemdescfingerprintVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemdescfingerprintVector::norm(self : ChemdescfingerprintVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemdescfingerprintVector::normalize(self : ChemdescfingerprintVector) -> ChemdescfingerprintVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemdescfingerprintVector::dist(self : ChemdescfingerprintVector, other : ChemdescfingerprintVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemdescfingerprintVector::to_string(self : ChemdescfingerprintVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_desc_fingerprint_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_desc_fingerprint_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_desc_fingerprint_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_desc_fingerprint_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_desc_fingerprint_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_desc_fingerprint_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_desc_fingerprint_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_desc_fingerprint_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_desc_fingerprint_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_desc_fingerprint_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_desc_fingerprint_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_desc_fingerprint_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_desc_fingerprint_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_desc_fingerprint_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_desc_fingerprint_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_desc_fingerprint_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_desc_fingerprint_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_desc_fingerprint_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_desc_fingerprint_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_desc_fingerprint_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_desc_fingerprint_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_desc_fingerprint_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_desc_fingerprint_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_desc_fingerprint_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_desc_fingerprint_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_desc_fingerprint_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_desc_fingerprint_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_desc_fingerprint_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_desc_fingerprint_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemdescfingerprintFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fingerprint_frame_make(size : Int) -> ChemdescfingerprintFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fingerprint_frame_len(s : ChemdescfingerprintFrame) -> Int { s.size }

pub fn chem_desc_fingerprint_frame_get(s : ChemdescfingerprintFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fingerprint_frame_set(s : ChemdescfingerprintFrame, i : Int, v : Double) -> ChemdescfingerprintFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_frame_sum(s : ChemdescfingerprintFrame) -> Double { @_common.sum(s.data) }

pub fn chem_desc_fingerprint_frame_mean(s : ChemdescfingerprintFrame) -> Double { @_common.mean(s.data) }

pub fn chem_desc_fingerprint_frame_scale(s : ChemdescfingerprintFrame, f : Double) -> ChemdescfingerprintFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_frame_add(a : ChemdescfingerprintFrame, b : ChemdescfingerprintFrame) -> ChemdescfingerprintFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_fingerprint_frame_copy(s : ChemdescfingerprintFrame) -> ChemdescfingerprintFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_frame_fill(s : ChemdescfingerprintFrame, v : Double) -> ChemdescfingerprintFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_frame_min(s : ChemdescfingerprintFrame) -> Double { @_common.min(s.data) }

pub fn chem_desc_fingerprint_frame_max(s : ChemdescfingerprintFrame) -> Double { @_common.max(s.data) }

pub fn chem_desc_fingerprint_frame_to_string(s : ChemdescfingerprintFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfingerprintTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fingerprint_table_make(size : Int) -> ChemdescfingerprintTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fingerprint_table_len(s : ChemdescfingerprintTable) -> Int { s.size }

pub fn chem_desc_fingerprint_table_get(s : ChemdescfingerprintTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fingerprint_table_set(s : ChemdescfingerprintTable, i : Int, v : Double) -> ChemdescfingerprintTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_table_sum(s : ChemdescfingerprintTable) -> Double { @_common.sum(s.data) }

pub fn chem_desc_fingerprint_table_mean(s : ChemdescfingerprintTable) -> Double { @_common.mean(s.data) }

pub fn chem_desc_fingerprint_table_scale(s : ChemdescfingerprintTable, f : Double) -> ChemdescfingerprintTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_table_add(a : ChemdescfingerprintTable, b : ChemdescfingerprintTable) -> ChemdescfingerprintTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_fingerprint_table_copy(s : ChemdescfingerprintTable) -> ChemdescfingerprintTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_table_fill(s : ChemdescfingerprintTable, v : Double) -> ChemdescfingerprintTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_table_min(s : ChemdescfingerprintTable) -> Double { @_common.min(s.data) }

pub fn chem_desc_fingerprint_table_max(s : ChemdescfingerprintTable) -> Double { @_common.max(s.data) }

pub fn chem_desc_fingerprint_table_to_string(s : ChemdescfingerprintTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfingerprintGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fingerprint_graphn_make(size : Int) -> ChemdescfingerprintGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fingerprint_graphn_len(s : ChemdescfingerprintGraphN) -> Int { s.size }

pub fn chem_desc_fingerprint_graphn_get(s : ChemdescfingerprintGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fingerprint_graphn_set(s : ChemdescfingerprintGraphN, i : Int, v : Double) -> ChemdescfingerprintGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_graphn_sum(s : ChemdescfingerprintGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_desc_fingerprint_graphn_mean(s : ChemdescfingerprintGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_desc_fingerprint_graphn_scale(s : ChemdescfingerprintGraphN, f : Double) -> ChemdescfingerprintGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_graphn_add(a : ChemdescfingerprintGraphN, b : ChemdescfingerprintGraphN) -> ChemdescfingerprintGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_fingerprint_graphn_copy(s : ChemdescfingerprintGraphN) -> ChemdescfingerprintGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_graphn_fill(s : ChemdescfingerprintGraphN, v : Double) -> ChemdescfingerprintGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_graphn_min(s : ChemdescfingerprintGraphN) -> Double { @_common.min(s.data) }

pub fn chem_desc_fingerprint_graphn_max(s : ChemdescfingerprintGraphN) -> Double { @_common.max(s.data) }

pub fn chem_desc_fingerprint_graphn_to_string(s : ChemdescfingerprintGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfingerprintNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fingerprint_node_make(size : Int) -> ChemdescfingerprintNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fingerprint_node_len(s : ChemdescfingerprintNode) -> Int { s.size }

pub fn chem_desc_fingerprint_node_get(s : ChemdescfingerprintNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fingerprint_node_set(s : ChemdescfingerprintNode, i : Int, v : Double) -> ChemdescfingerprintNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_node_sum(s : ChemdescfingerprintNode) -> Double { @_common.sum(s.data) }

pub fn chem_desc_fingerprint_node_mean(s : ChemdescfingerprintNode) -> Double { @_common.mean(s.data) }

pub fn chem_desc_fingerprint_node_scale(s : ChemdescfingerprintNode, f : Double) -> ChemdescfingerprintNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_node_add(a : ChemdescfingerprintNode, b : ChemdescfingerprintNode) -> ChemdescfingerprintNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_fingerprint_node_copy(s : ChemdescfingerprintNode) -> ChemdescfingerprintNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_node_fill(s : ChemdescfingerprintNode, v : Double) -> ChemdescfingerprintNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_node_min(s : ChemdescfingerprintNode) -> Double { @_common.min(s.data) }

pub fn chem_desc_fingerprint_node_max(s : ChemdescfingerprintNode) -> Double { @_common.max(s.data) }

pub fn chem_desc_fingerprint_node_to_string(s : ChemdescfingerprintNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfingerprintEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fingerprint_edge_make(size : Int) -> ChemdescfingerprintEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fingerprint_edge_len(s : ChemdescfingerprintEdge) -> Int { s.size }

pub fn chem_desc_fingerprint_edge_get(s : ChemdescfingerprintEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fingerprint_edge_set(s : ChemdescfingerprintEdge, i : Int, v : Double) -> ChemdescfingerprintEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_edge_sum(s : ChemdescfingerprintEdge) -> Double { @_common.sum(s.data) }

pub fn chem_desc_fingerprint_edge_mean(s : ChemdescfingerprintEdge) -> Double { @_common.mean(s.data) }

pub fn chem_desc_fingerprint_edge_scale(s : ChemdescfingerprintEdge, f : Double) -> ChemdescfingerprintEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_edge_add(a : ChemdescfingerprintEdge, b : ChemdescfingerprintEdge) -> ChemdescfingerprintEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_fingerprint_edge_copy(s : ChemdescfingerprintEdge) -> ChemdescfingerprintEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_edge_fill(s : ChemdescfingerprintEdge, v : Double) -> ChemdescfingerprintEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_edge_min(s : ChemdescfingerprintEdge) -> Double { @_common.min(s.data) }

pub fn chem_desc_fingerprint_edge_max(s : ChemdescfingerprintEdge) -> Double { @_common.max(s.data) }

pub fn chem_desc_fingerprint_edge_to_string(s : ChemdescfingerprintEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfingerprintPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fingerprint_path_make(size : Int) -> ChemdescfingerprintPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fingerprint_path_len(s : ChemdescfingerprintPath) -> Int { s.size }

pub fn chem_desc_fingerprint_path_get(s : ChemdescfingerprintPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fingerprint_path_set(s : ChemdescfingerprintPath, i : Int, v : Double) -> ChemdescfingerprintPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_path_sum(s : ChemdescfingerprintPath) -> Double { @_common.sum(s.data) }

pub fn chem_desc_fingerprint_path_mean(s : ChemdescfingerprintPath) -> Double { @_common.mean(s.data) }

pub fn chem_desc_fingerprint_path_scale(s : ChemdescfingerprintPath, f : Double) -> ChemdescfingerprintPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_path_add(a : ChemdescfingerprintPath, b : ChemdescfingerprintPath) -> ChemdescfingerprintPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_fingerprint_path_copy(s : ChemdescfingerprintPath) -> ChemdescfingerprintPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_path_fill(s : ChemdescfingerprintPath, v : Double) -> ChemdescfingerprintPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_path_min(s : ChemdescfingerprintPath) -> Double { @_common.min(s.data) }

pub fn chem_desc_fingerprint_path_max(s : ChemdescfingerprintPath) -> Double { @_common.max(s.data) }

pub fn chem_desc_fingerprint_path_to_string(s : ChemdescfingerprintPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfingerprintCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fingerprint_cluster_make(size : Int) -> ChemdescfingerprintCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fingerprint_cluster_len(s : ChemdescfingerprintCluster) -> Int { s.size }

pub fn chem_desc_fingerprint_cluster_get(s : ChemdescfingerprintCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fingerprint_cluster_set(s : ChemdescfingerprintCluster, i : Int, v : Double) -> ChemdescfingerprintCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_cluster_sum(s : ChemdescfingerprintCluster) -> Double { @_common.sum(s.data) }

pub fn chem_desc_fingerprint_cluster_mean(s : ChemdescfingerprintCluster) -> Double { @_common.mean(s.data) }

pub fn chem_desc_fingerprint_cluster_scale(s : ChemdescfingerprintCluster, f : Double) -> ChemdescfingerprintCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_cluster_add(a : ChemdescfingerprintCluster, b : ChemdescfingerprintCluster) -> ChemdescfingerprintCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_fingerprint_cluster_copy(s : ChemdescfingerprintCluster) -> ChemdescfingerprintCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_cluster_fill(s : ChemdescfingerprintCluster, v : Double) -> ChemdescfingerprintCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_cluster_min(s : ChemdescfingerprintCluster) -> Double { @_common.min(s.data) }

pub fn chem_desc_fingerprint_cluster_max(s : ChemdescfingerprintCluster) -> Double { @_common.max(s.data) }

pub fn chem_desc_fingerprint_cluster_to_string(s : ChemdescfingerprintCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfingerprintModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fingerprint_model_make(size : Int) -> ChemdescfingerprintModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fingerprint_model_len(s : ChemdescfingerprintModel) -> Int { s.size }

pub fn chem_desc_fingerprint_model_get(s : ChemdescfingerprintModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fingerprint_model_set(s : ChemdescfingerprintModel, i : Int, v : Double) -> ChemdescfingerprintModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_model_sum(s : ChemdescfingerprintModel) -> Double { @_common.sum(s.data) }

pub fn chem_desc_fingerprint_model_mean(s : ChemdescfingerprintModel) -> Double { @_common.mean(s.data) }

pub fn chem_desc_fingerprint_model_scale(s : ChemdescfingerprintModel, f : Double) -> ChemdescfingerprintModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_model_add(a : ChemdescfingerprintModel, b : ChemdescfingerprintModel) -> ChemdescfingerprintModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_fingerprint_model_copy(s : ChemdescfingerprintModel) -> ChemdescfingerprintModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_model_fill(s : ChemdescfingerprintModel, v : Double) -> ChemdescfingerprintModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_model_min(s : ChemdescfingerprintModel) -> Double { @_common.min(s.data) }

pub fn chem_desc_fingerprint_model_max(s : ChemdescfingerprintModel) -> Double { @_common.max(s.data) }

pub fn chem_desc_fingerprint_model_to_string(s : ChemdescfingerprintModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfingerprintLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fingerprint_layer_make(size : Int) -> ChemdescfingerprintLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fingerprint_layer_len(s : ChemdescfingerprintLayer) -> Int { s.size }

pub fn chem_desc_fingerprint_layer_get(s : ChemdescfingerprintLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fingerprint_layer_set(s : ChemdescfingerprintLayer, i : Int, v : Double) -> ChemdescfingerprintLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_layer_sum(s : ChemdescfingerprintLayer) -> Double { @_common.sum(s.data) }

pub fn chem_desc_fingerprint_layer_mean(s : ChemdescfingerprintLayer) -> Double { @_common.mean(s.data) }

pub fn chem_desc_fingerprint_layer_scale(s : ChemdescfingerprintLayer, f : Double) -> ChemdescfingerprintLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_layer_add(a : ChemdescfingerprintLayer, b : ChemdescfingerprintLayer) -> ChemdescfingerprintLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_fingerprint_layer_copy(s : ChemdescfingerprintLayer) -> ChemdescfingerprintLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_layer_fill(s : ChemdescfingerprintLayer, v : Double) -> ChemdescfingerprintLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_layer_min(s : ChemdescfingerprintLayer) -> Double { @_common.min(s.data) }

pub fn chem_desc_fingerprint_layer_max(s : ChemdescfingerprintLayer) -> Double { @_common.max(s.data) }

pub fn chem_desc_fingerprint_layer_to_string(s : ChemdescfingerprintLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfingerprintBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fingerprint_buffer_make(size : Int) -> ChemdescfingerprintBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fingerprint_buffer_len(s : ChemdescfingerprintBuffer) -> Int { s.size }

pub fn chem_desc_fingerprint_buffer_get(s : ChemdescfingerprintBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fingerprint_buffer_set(s : ChemdescfingerprintBuffer, i : Int, v : Double) -> ChemdescfingerprintBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_buffer_sum(s : ChemdescfingerprintBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_desc_fingerprint_buffer_mean(s : ChemdescfingerprintBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_desc_fingerprint_buffer_scale(s : ChemdescfingerprintBuffer, f : Double) -> ChemdescfingerprintBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_buffer_add(a : ChemdescfingerprintBuffer, b : ChemdescfingerprintBuffer) -> ChemdescfingerprintBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_fingerprint_buffer_copy(s : ChemdescfingerprintBuffer) -> ChemdescfingerprintBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_buffer_fill(s : ChemdescfingerprintBuffer, v : Double) -> ChemdescfingerprintBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_buffer_min(s : ChemdescfingerprintBuffer) -> Double { @_common.min(s.data) }

pub fn chem_desc_fingerprint_buffer_max(s : ChemdescfingerprintBuffer) -> Double { @_common.max(s.data) }

pub fn chem_desc_fingerprint_buffer_to_string(s : ChemdescfingerprintBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfingerprintCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fingerprint_cursor_make(size : Int) -> ChemdescfingerprintCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fingerprint_cursor_len(s : ChemdescfingerprintCursor) -> Int { s.size }

pub fn chem_desc_fingerprint_cursor_get(s : ChemdescfingerprintCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fingerprint_cursor_set(s : ChemdescfingerprintCursor, i : Int, v : Double) -> ChemdescfingerprintCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_cursor_sum(s : ChemdescfingerprintCursor) -> Double { @_common.sum(s.data) }

pub fn chem_desc_fingerprint_cursor_mean(s : ChemdescfingerprintCursor) -> Double { @_common.mean(s.data) }

pub fn chem_desc_fingerprint_cursor_scale(s : ChemdescfingerprintCursor, f : Double) -> ChemdescfingerprintCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_cursor_add(a : ChemdescfingerprintCursor, b : ChemdescfingerprintCursor) -> ChemdescfingerprintCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_fingerprint_cursor_copy(s : ChemdescfingerprintCursor) -> ChemdescfingerprintCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_cursor_fill(s : ChemdescfingerprintCursor, v : Double) -> ChemdescfingerprintCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_cursor_min(s : ChemdescfingerprintCursor) -> Double { @_common.min(s.data) }

pub fn chem_desc_fingerprint_cursor_max(s : ChemdescfingerprintCursor) -> Double { @_common.max(s.data) }

pub fn chem_desc_fingerprint_cursor_to_string(s : ChemdescfingerprintCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfingerprintView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fingerprint_view_make(size : Int) -> ChemdescfingerprintView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fingerprint_view_len(s : ChemdescfingerprintView) -> Int { s.size }

pub fn chem_desc_fingerprint_view_get(s : ChemdescfingerprintView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fingerprint_view_set(s : ChemdescfingerprintView, i : Int, v : Double) -> ChemdescfingerprintView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_view_sum(s : ChemdescfingerprintView) -> Double { @_common.sum(s.data) }

pub fn chem_desc_fingerprint_view_mean(s : ChemdescfingerprintView) -> Double { @_common.mean(s.data) }

pub fn chem_desc_fingerprint_view_scale(s : ChemdescfingerprintView, f : Double) -> ChemdescfingerprintView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_view_add(a : ChemdescfingerprintView, b : ChemdescfingerprintView) -> ChemdescfingerprintView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_fingerprint_view_copy(s : ChemdescfingerprintView) -> ChemdescfingerprintView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_view_fill(s : ChemdescfingerprintView, v : Double) -> ChemdescfingerprintView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_view_min(s : ChemdescfingerprintView) -> Double { @_common.min(s.data) }

pub fn chem_desc_fingerprint_view_max(s : ChemdescfingerprintView) -> Double { @_common.max(s.data) }

pub fn chem_desc_fingerprint_view_to_string(s : ChemdescfingerprintView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfingerprintRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fingerprint_range_make(size : Int) -> ChemdescfingerprintRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fingerprint_range_len(s : ChemdescfingerprintRange) -> Int { s.size }

pub fn chem_desc_fingerprint_range_get(s : ChemdescfingerprintRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fingerprint_range_set(s : ChemdescfingerprintRange, i : Int, v : Double) -> ChemdescfingerprintRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_range_sum(s : ChemdescfingerprintRange) -> Double { @_common.sum(s.data) }

pub fn chem_desc_fingerprint_range_mean(s : ChemdescfingerprintRange) -> Double { @_common.mean(s.data) }

pub fn chem_desc_fingerprint_range_scale(s : ChemdescfingerprintRange, f : Double) -> ChemdescfingerprintRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_range_add(a : ChemdescfingerprintRange, b : ChemdescfingerprintRange) -> ChemdescfingerprintRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_fingerprint_range_copy(s : ChemdescfingerprintRange) -> ChemdescfingerprintRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_range_fill(s : ChemdescfingerprintRange, v : Double) -> ChemdescfingerprintRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_range_min(s : ChemdescfingerprintRange) -> Double { @_common.min(s.data) }

pub fn chem_desc_fingerprint_range_max(s : ChemdescfingerprintRange) -> Double { @_common.max(s.data) }

pub fn chem_desc_fingerprint_range_to_string(s : ChemdescfingerprintRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfingerprintSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fingerprint_slice_make(size : Int) -> ChemdescfingerprintSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fingerprint_slice_len(s : ChemdescfingerprintSlice) -> Int { s.size }

pub fn chem_desc_fingerprint_slice_get(s : ChemdescfingerprintSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fingerprint_slice_set(s : ChemdescfingerprintSlice, i : Int, v : Double) -> ChemdescfingerprintSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_slice_sum(s : ChemdescfingerprintSlice) -> Double { @_common.sum(s.data) }

pub fn chem_desc_fingerprint_slice_mean(s : ChemdescfingerprintSlice) -> Double { @_common.mean(s.data) }

pub fn chem_desc_fingerprint_slice_scale(s : ChemdescfingerprintSlice, f : Double) -> ChemdescfingerprintSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_slice_add(a : ChemdescfingerprintSlice, b : ChemdescfingerprintSlice) -> ChemdescfingerprintSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_fingerprint_slice_copy(s : ChemdescfingerprintSlice) -> ChemdescfingerprintSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_slice_fill(s : ChemdescfingerprintSlice, v : Double) -> ChemdescfingerprintSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_fingerprint_slice_min(s : ChemdescfingerprintSlice) -> Double { @_common.min(s.data) }

pub fn chem_desc_fingerprint_slice_max(s : ChemdescfingerprintSlice) -> Double { @_common.max(s.data) }

pub fn chem_desc_fingerprint_slice_to_string(s : ChemdescfingerprintSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

