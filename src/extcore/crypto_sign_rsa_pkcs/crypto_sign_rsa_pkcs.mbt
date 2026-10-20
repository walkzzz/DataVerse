///===
/// extcore/crypto_sign_rsa_pkcs

pub(all) struct CryptosignrsapkcsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sign_rsa_pkcs_make_point(x : Double, y : Double) -> CryptosignrsapkcsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sign_rsa_pkcs_make_point3(x : Double, y : Double, z : Double) -> CryptosignrsapkcsPoint {
  { x, y, z, label: 0 }
}

pub fn CryptosignrsapkcsPoint::x(self : CryptosignrsapkcsPoint) -> Double { self.x }

pub fn CryptosignrsapkcsPoint::y(self : CryptosignrsapkcsPoint) -> Double { self.y }

pub fn CryptosignrsapkcsPoint::z(self : CryptosignrsapkcsPoint) -> Double { self.z }

pub fn CryptosignrsapkcsPoint::label(self : CryptosignrsapkcsPoint) -> Int { self.label }

pub fn CryptosignrsapkcsPoint::dist(self : CryptosignrsapkcsPoint, other : CryptosignrsapkcsPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn CryptosignrsapkcsPoint::add(self : CryptosignrsapkcsPoint, other : CryptosignrsapkcsPoint) -> CryptosignrsapkcsPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn CryptosignrsapkcsPoint::sub(self : CryptosignrsapkcsPoint, other : CryptosignrsapkcsPoint) -> CryptosignrsapkcsPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn CryptosignrsapkcsPoint::scale(self : CryptosignrsapkcsPoint, s : Double) -> CryptosignrsapkcsPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn CryptosignrsapkcsPoint::dot(self : CryptosignrsapkcsPoint, other : CryptosignrsapkcsPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn CryptosignrsapkcsPoint::cross(self : CryptosignrsapkcsPoint, other : CryptosignrsapkcsPoint) -> CryptosignrsapkcsPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn CryptosignrsapkcsPoint::norm(self : CryptosignrsapkcsPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn CryptosignrsapkcsPoint::normalize(self : CryptosignrsapkcsPoint) -> CryptosignrsapkcsPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosignrsapkcsPoint::negate(self : CryptosignrsapkcsPoint) -> CryptosignrsapkcsPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn CryptosignrsapkcsPoint::mid(self : CryptosignrsapkcsPoint, other : CryptosignrsapkcsPoint) -> CryptosignrsapkcsPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn CryptosignrsapkcsPoint::lerp(self : CryptosignrsapkcsPoint, other : CryptosignrsapkcsPoint, t : Double) -> CryptosignrsapkcsPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn CryptosignrsapkcsPoint::to_string(self : CryptosignrsapkcsPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct CryptosignrsapkcsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sign_rsa_pkcs_make_series(vals : Array[Double], name : String) -> CryptosignrsapkcsSeries {
  { vals, name, meta: 0 }
}

pub fn CryptosignrsapkcsSeries::len(self : CryptosignrsapkcsSeries) -> Int { self.vals.length() }

pub fn CryptosignrsapkcsSeries::sum(self : CryptosignrsapkcsSeries) -> Double { @_common.sum(self.vals) }

pub fn CryptosignrsapkcsSeries::mean(self : CryptosignrsapkcsSeries) -> Double { @_common.mean(self.vals) }

pub fn CryptosignrsapkcsSeries::min(self : CryptosignrsapkcsSeries) -> Double { @_common.min(self.vals) }

pub fn CryptosignrsapkcsSeries::max(self : CryptosignrsapkcsSeries) -> Double { @_common.max(self.vals) }

pub fn CryptosignrsapkcsSeries::range(self : CryptosignrsapkcsSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn CryptosignrsapkcsSeries::variance(self : CryptosignrsapkcsSeries) -> Double { @_common.variance(self.vals) }

pub fn CryptosignrsapkcsSeries::std(self : CryptosignrsapkcsSeries) -> Double { @_common.std(self.vals) }

pub fn CryptosignrsapkcsSeries::median(self : CryptosignrsapkcsSeries) -> Double { @_common.median(self.vals) }

pub fn CryptosignrsapkcsSeries::scale(self : CryptosignrsapkcsSeries, f : Double) -> CryptosignrsapkcsSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn CryptosignrsapkcsSeries::add(self : CryptosignrsapkcsSeries, other : CryptosignrsapkcsSeries) -> CryptosignrsapkcsSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn CryptosignrsapkcsSeries::sub(self : CryptosignrsapkcsSeries, other : CryptosignrsapkcsSeries) -> CryptosignrsapkcsSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn CryptosignrsapkcsSeries::normalize(self : CryptosignrsapkcsSeries) -> CryptosignrsapkcsSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn CryptosignrsapkcsSeries::cumsum(self : CryptosignrsapkcsSeries) -> CryptosignrsapkcsSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn CryptosignrsapkcsSeries::to_string(self : CryptosignrsapkcsSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosignrsapkcsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sign_rsa_pkcs_make_matrix(rows : Int, cols : Int, val : Double) -> CryptosignrsapkcsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_sign_rsa_pkcs_matrix_identity(n : Int) -> CryptosignrsapkcsMatrix {
  let m = crypto_sign_rsa_pkcs_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn CryptosignrsapkcsMatrix::get(self : CryptosignrsapkcsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn CryptosignrsapkcsMatrix::transpose(self : CryptosignrsapkcsMatrix) -> CryptosignrsapkcsMatrix {
  let result = crypto_sign_rsa_pkcs_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn CryptosignrsapkcsMatrix::add(self : CryptosignrsapkcsMatrix, other : CryptosignrsapkcsMatrix) -> CryptosignrsapkcsMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_sign_rsa_pkcs_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn CryptosignrsapkcsMatrix::scale(self : CryptosignrsapkcsMatrix, s : Double) -> CryptosignrsapkcsMatrix {
  let result = crypto_sign_rsa_pkcs_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn CryptosignrsapkcsMatrix::multiply(self : CryptosignrsapkcsMatrix, other : CryptosignrsapkcsMatrix) -> CryptosignrsapkcsMatrix {
  if self.cols != other.rows { return crypto_sign_rsa_pkcs_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_sign_rsa_pkcs_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn CryptosignrsapkcsMatrix::trace(self : CryptosignrsapkcsMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn CryptosignrsapkcsMatrix::det(self : CryptosignrsapkcsMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn CryptosignrsapkcsMatrix::norm(self : CryptosignrsapkcsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn CryptosignrsapkcsMatrix::to_string(self : CryptosignrsapkcsMatrix) -> String {
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

pub(all) struct CryptosignrsapkcsVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sign_rsa_pkcs_make_vector(comps : Array[Double]) -> CryptosignrsapkcsVector {
  { comps, dim: comps.length() }
}

pub fn crypto_sign_rsa_pkcs_vector_zero(dim : Int) -> CryptosignrsapkcsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn CryptosignrsapkcsVector::add(self : CryptosignrsapkcsVector, other : CryptosignrsapkcsVector) -> CryptosignrsapkcsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosignrsapkcsVector::sub(self : CryptosignrsapkcsVector, other : CryptosignrsapkcsVector) -> CryptosignrsapkcsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosignrsapkcsVector::scale(self : CryptosignrsapkcsVector, s : Double) -> CryptosignrsapkcsVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn CryptosignrsapkcsVector::dot(self : CryptosignrsapkcsVector, other : CryptosignrsapkcsVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn CryptosignrsapkcsVector::norm(self : CryptosignrsapkcsVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn CryptosignrsapkcsVector::normalize(self : CryptosignrsapkcsVector) -> CryptosignrsapkcsVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosignrsapkcsVector::dist(self : CryptosignrsapkcsVector, other : CryptosignrsapkcsVector) -> Double {
  self.sub(other).norm()
}

pub fn CryptosignrsapkcsVector::to_string(self : CryptosignrsapkcsVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_sign_rsa_pkcs_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_sign_rsa_pkcs_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_sign_rsa_pkcs_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_sign_rsa_pkcs_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_sign_rsa_pkcs_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_sign_rsa_pkcs_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_sign_rsa_pkcs_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_sign_rsa_pkcs_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_sign_rsa_pkcs_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_sign_rsa_pkcs_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_sign_rsa_pkcs_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_sign_rsa_pkcs_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_sign_rsa_pkcs_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_sign_rsa_pkcs_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_sign_rsa_pkcs_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_sign_rsa_pkcs_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_sign_rsa_pkcs_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_sign_rsa_pkcs_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_sign_rsa_pkcs_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_sign_rsa_pkcs_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_sign_rsa_pkcs_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_sign_rsa_pkcs_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_sign_rsa_pkcs_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_sign_rsa_pkcs_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_sign_rsa_pkcs_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_sign_rsa_pkcs_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_sign_rsa_pkcs_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_sign_rsa_pkcs_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_sign_rsa_pkcs_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct CryptosignrsapkcsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pkcs_frame_make(size : Int) -> CryptosignrsapkcsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_rsa_pkcs_frame_len(s : CryptosignrsapkcsFrame) -> Int { s.size }

pub fn crypto_sign_rsa_pkcs_frame_get(s : CryptosignrsapkcsFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_rsa_pkcs_frame_set(s : CryptosignrsapkcsFrame, i : Int, v : Double) -> CryptosignrsapkcsFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_frame_sum(s : CryptosignrsapkcsFrame) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_rsa_pkcs_frame_mean(s : CryptosignrsapkcsFrame) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_rsa_pkcs_frame_scale(s : CryptosignrsapkcsFrame, f : Double) -> CryptosignrsapkcsFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_frame_add(a : CryptosignrsapkcsFrame, b : CryptosignrsapkcsFrame) -> CryptosignrsapkcsFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_rsa_pkcs_frame_copy(s : CryptosignrsapkcsFrame) -> CryptosignrsapkcsFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_frame_fill(s : CryptosignrsapkcsFrame, v : Double) -> CryptosignrsapkcsFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_frame_min(s : CryptosignrsapkcsFrame) -> Double { @_common.min(s.data) }

pub fn crypto_sign_rsa_pkcs_frame_max(s : CryptosignrsapkcsFrame) -> Double { @_common.max(s.data) }

pub fn crypto_sign_rsa_pkcs_frame_to_string(s : CryptosignrsapkcsFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapkcsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pkcs_table_make(size : Int) -> CryptosignrsapkcsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_rsa_pkcs_table_len(s : CryptosignrsapkcsTable) -> Int { s.size }

pub fn crypto_sign_rsa_pkcs_table_get(s : CryptosignrsapkcsTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_rsa_pkcs_table_set(s : CryptosignrsapkcsTable, i : Int, v : Double) -> CryptosignrsapkcsTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_table_sum(s : CryptosignrsapkcsTable) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_rsa_pkcs_table_mean(s : CryptosignrsapkcsTable) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_rsa_pkcs_table_scale(s : CryptosignrsapkcsTable, f : Double) -> CryptosignrsapkcsTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_table_add(a : CryptosignrsapkcsTable, b : CryptosignrsapkcsTable) -> CryptosignrsapkcsTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_rsa_pkcs_table_copy(s : CryptosignrsapkcsTable) -> CryptosignrsapkcsTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_table_fill(s : CryptosignrsapkcsTable, v : Double) -> CryptosignrsapkcsTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_table_min(s : CryptosignrsapkcsTable) -> Double { @_common.min(s.data) }

pub fn crypto_sign_rsa_pkcs_table_max(s : CryptosignrsapkcsTable) -> Double { @_common.max(s.data) }

pub fn crypto_sign_rsa_pkcs_table_to_string(s : CryptosignrsapkcsTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapkcsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pkcs_graphn_make(size : Int) -> CryptosignrsapkcsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_rsa_pkcs_graphn_len(s : CryptosignrsapkcsGraphN) -> Int { s.size }

pub fn crypto_sign_rsa_pkcs_graphn_get(s : CryptosignrsapkcsGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_rsa_pkcs_graphn_set(s : CryptosignrsapkcsGraphN, i : Int, v : Double) -> CryptosignrsapkcsGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_graphn_sum(s : CryptosignrsapkcsGraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_rsa_pkcs_graphn_mean(s : CryptosignrsapkcsGraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_rsa_pkcs_graphn_scale(s : CryptosignrsapkcsGraphN, f : Double) -> CryptosignrsapkcsGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_graphn_add(a : CryptosignrsapkcsGraphN, b : CryptosignrsapkcsGraphN) -> CryptosignrsapkcsGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_rsa_pkcs_graphn_copy(s : CryptosignrsapkcsGraphN) -> CryptosignrsapkcsGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_graphn_fill(s : CryptosignrsapkcsGraphN, v : Double) -> CryptosignrsapkcsGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_graphn_min(s : CryptosignrsapkcsGraphN) -> Double { @_common.min(s.data) }

pub fn crypto_sign_rsa_pkcs_graphn_max(s : CryptosignrsapkcsGraphN) -> Double { @_common.max(s.data) }

pub fn crypto_sign_rsa_pkcs_graphn_to_string(s : CryptosignrsapkcsGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapkcsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pkcs_node_make(size : Int) -> CryptosignrsapkcsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_rsa_pkcs_node_len(s : CryptosignrsapkcsNode) -> Int { s.size }

pub fn crypto_sign_rsa_pkcs_node_get(s : CryptosignrsapkcsNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_rsa_pkcs_node_set(s : CryptosignrsapkcsNode, i : Int, v : Double) -> CryptosignrsapkcsNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_node_sum(s : CryptosignrsapkcsNode) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_rsa_pkcs_node_mean(s : CryptosignrsapkcsNode) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_rsa_pkcs_node_scale(s : CryptosignrsapkcsNode, f : Double) -> CryptosignrsapkcsNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_node_add(a : CryptosignrsapkcsNode, b : CryptosignrsapkcsNode) -> CryptosignrsapkcsNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_rsa_pkcs_node_copy(s : CryptosignrsapkcsNode) -> CryptosignrsapkcsNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_node_fill(s : CryptosignrsapkcsNode, v : Double) -> CryptosignrsapkcsNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_node_min(s : CryptosignrsapkcsNode) -> Double { @_common.min(s.data) }

pub fn crypto_sign_rsa_pkcs_node_max(s : CryptosignrsapkcsNode) -> Double { @_common.max(s.data) }

pub fn crypto_sign_rsa_pkcs_node_to_string(s : CryptosignrsapkcsNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapkcsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pkcs_edge_make(size : Int) -> CryptosignrsapkcsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_rsa_pkcs_edge_len(s : CryptosignrsapkcsEdge) -> Int { s.size }

pub fn crypto_sign_rsa_pkcs_edge_get(s : CryptosignrsapkcsEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_rsa_pkcs_edge_set(s : CryptosignrsapkcsEdge, i : Int, v : Double) -> CryptosignrsapkcsEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_edge_sum(s : CryptosignrsapkcsEdge) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_rsa_pkcs_edge_mean(s : CryptosignrsapkcsEdge) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_rsa_pkcs_edge_scale(s : CryptosignrsapkcsEdge, f : Double) -> CryptosignrsapkcsEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_edge_add(a : CryptosignrsapkcsEdge, b : CryptosignrsapkcsEdge) -> CryptosignrsapkcsEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_rsa_pkcs_edge_copy(s : CryptosignrsapkcsEdge) -> CryptosignrsapkcsEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_edge_fill(s : CryptosignrsapkcsEdge, v : Double) -> CryptosignrsapkcsEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_edge_min(s : CryptosignrsapkcsEdge) -> Double { @_common.min(s.data) }

pub fn crypto_sign_rsa_pkcs_edge_max(s : CryptosignrsapkcsEdge) -> Double { @_common.max(s.data) }

pub fn crypto_sign_rsa_pkcs_edge_to_string(s : CryptosignrsapkcsEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapkcsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pkcs_path_make(size : Int) -> CryptosignrsapkcsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_rsa_pkcs_path_len(s : CryptosignrsapkcsPath) -> Int { s.size }

pub fn crypto_sign_rsa_pkcs_path_get(s : CryptosignrsapkcsPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_rsa_pkcs_path_set(s : CryptosignrsapkcsPath, i : Int, v : Double) -> CryptosignrsapkcsPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_path_sum(s : CryptosignrsapkcsPath) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_rsa_pkcs_path_mean(s : CryptosignrsapkcsPath) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_rsa_pkcs_path_scale(s : CryptosignrsapkcsPath, f : Double) -> CryptosignrsapkcsPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_path_add(a : CryptosignrsapkcsPath, b : CryptosignrsapkcsPath) -> CryptosignrsapkcsPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_rsa_pkcs_path_copy(s : CryptosignrsapkcsPath) -> CryptosignrsapkcsPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_path_fill(s : CryptosignrsapkcsPath, v : Double) -> CryptosignrsapkcsPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_path_min(s : CryptosignrsapkcsPath) -> Double { @_common.min(s.data) }

pub fn crypto_sign_rsa_pkcs_path_max(s : CryptosignrsapkcsPath) -> Double { @_common.max(s.data) }

pub fn crypto_sign_rsa_pkcs_path_to_string(s : CryptosignrsapkcsPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapkcsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pkcs_cluster_make(size : Int) -> CryptosignrsapkcsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_rsa_pkcs_cluster_len(s : CryptosignrsapkcsCluster) -> Int { s.size }

pub fn crypto_sign_rsa_pkcs_cluster_get(s : CryptosignrsapkcsCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_rsa_pkcs_cluster_set(s : CryptosignrsapkcsCluster, i : Int, v : Double) -> CryptosignrsapkcsCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_cluster_sum(s : CryptosignrsapkcsCluster) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_rsa_pkcs_cluster_mean(s : CryptosignrsapkcsCluster) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_rsa_pkcs_cluster_scale(s : CryptosignrsapkcsCluster, f : Double) -> CryptosignrsapkcsCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_cluster_add(a : CryptosignrsapkcsCluster, b : CryptosignrsapkcsCluster) -> CryptosignrsapkcsCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_rsa_pkcs_cluster_copy(s : CryptosignrsapkcsCluster) -> CryptosignrsapkcsCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_cluster_fill(s : CryptosignrsapkcsCluster, v : Double) -> CryptosignrsapkcsCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_cluster_min(s : CryptosignrsapkcsCluster) -> Double { @_common.min(s.data) }

pub fn crypto_sign_rsa_pkcs_cluster_max(s : CryptosignrsapkcsCluster) -> Double { @_common.max(s.data) }

pub fn crypto_sign_rsa_pkcs_cluster_to_string(s : CryptosignrsapkcsCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapkcsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pkcs_model_make(size : Int) -> CryptosignrsapkcsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_rsa_pkcs_model_len(s : CryptosignrsapkcsModel) -> Int { s.size }

pub fn crypto_sign_rsa_pkcs_model_get(s : CryptosignrsapkcsModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_rsa_pkcs_model_set(s : CryptosignrsapkcsModel, i : Int, v : Double) -> CryptosignrsapkcsModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_model_sum(s : CryptosignrsapkcsModel) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_rsa_pkcs_model_mean(s : CryptosignrsapkcsModel) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_rsa_pkcs_model_scale(s : CryptosignrsapkcsModel, f : Double) -> CryptosignrsapkcsModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_model_add(a : CryptosignrsapkcsModel, b : CryptosignrsapkcsModel) -> CryptosignrsapkcsModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_rsa_pkcs_model_copy(s : CryptosignrsapkcsModel) -> CryptosignrsapkcsModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_model_fill(s : CryptosignrsapkcsModel, v : Double) -> CryptosignrsapkcsModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_model_min(s : CryptosignrsapkcsModel) -> Double { @_common.min(s.data) }

pub fn crypto_sign_rsa_pkcs_model_max(s : CryptosignrsapkcsModel) -> Double { @_common.max(s.data) }

pub fn crypto_sign_rsa_pkcs_model_to_string(s : CryptosignrsapkcsModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapkcsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pkcs_layer_make(size : Int) -> CryptosignrsapkcsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_rsa_pkcs_layer_len(s : CryptosignrsapkcsLayer) -> Int { s.size }

pub fn crypto_sign_rsa_pkcs_layer_get(s : CryptosignrsapkcsLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_rsa_pkcs_layer_set(s : CryptosignrsapkcsLayer, i : Int, v : Double) -> CryptosignrsapkcsLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_layer_sum(s : CryptosignrsapkcsLayer) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_rsa_pkcs_layer_mean(s : CryptosignrsapkcsLayer) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_rsa_pkcs_layer_scale(s : CryptosignrsapkcsLayer, f : Double) -> CryptosignrsapkcsLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_layer_add(a : CryptosignrsapkcsLayer, b : CryptosignrsapkcsLayer) -> CryptosignrsapkcsLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_rsa_pkcs_layer_copy(s : CryptosignrsapkcsLayer) -> CryptosignrsapkcsLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_layer_fill(s : CryptosignrsapkcsLayer, v : Double) -> CryptosignrsapkcsLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_layer_min(s : CryptosignrsapkcsLayer) -> Double { @_common.min(s.data) }

pub fn crypto_sign_rsa_pkcs_layer_max(s : CryptosignrsapkcsLayer) -> Double { @_common.max(s.data) }

pub fn crypto_sign_rsa_pkcs_layer_to_string(s : CryptosignrsapkcsLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapkcsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pkcs_buffer_make(size : Int) -> CryptosignrsapkcsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_rsa_pkcs_buffer_len(s : CryptosignrsapkcsBuffer) -> Int { s.size }

pub fn crypto_sign_rsa_pkcs_buffer_get(s : CryptosignrsapkcsBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_rsa_pkcs_buffer_set(s : CryptosignrsapkcsBuffer, i : Int, v : Double) -> CryptosignrsapkcsBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_buffer_sum(s : CryptosignrsapkcsBuffer) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_rsa_pkcs_buffer_mean(s : CryptosignrsapkcsBuffer) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_rsa_pkcs_buffer_scale(s : CryptosignrsapkcsBuffer, f : Double) -> CryptosignrsapkcsBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_buffer_add(a : CryptosignrsapkcsBuffer, b : CryptosignrsapkcsBuffer) -> CryptosignrsapkcsBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_rsa_pkcs_buffer_copy(s : CryptosignrsapkcsBuffer) -> CryptosignrsapkcsBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_buffer_fill(s : CryptosignrsapkcsBuffer, v : Double) -> CryptosignrsapkcsBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_buffer_min(s : CryptosignrsapkcsBuffer) -> Double { @_common.min(s.data) }

pub fn crypto_sign_rsa_pkcs_buffer_max(s : CryptosignrsapkcsBuffer) -> Double { @_common.max(s.data) }

pub fn crypto_sign_rsa_pkcs_buffer_to_string(s : CryptosignrsapkcsBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapkcsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pkcs_cursor_make(size : Int) -> CryptosignrsapkcsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_rsa_pkcs_cursor_len(s : CryptosignrsapkcsCursor) -> Int { s.size }

pub fn crypto_sign_rsa_pkcs_cursor_get(s : CryptosignrsapkcsCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_rsa_pkcs_cursor_set(s : CryptosignrsapkcsCursor, i : Int, v : Double) -> CryptosignrsapkcsCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_cursor_sum(s : CryptosignrsapkcsCursor) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_rsa_pkcs_cursor_mean(s : CryptosignrsapkcsCursor) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_rsa_pkcs_cursor_scale(s : CryptosignrsapkcsCursor, f : Double) -> CryptosignrsapkcsCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_cursor_add(a : CryptosignrsapkcsCursor, b : CryptosignrsapkcsCursor) -> CryptosignrsapkcsCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_rsa_pkcs_cursor_copy(s : CryptosignrsapkcsCursor) -> CryptosignrsapkcsCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_cursor_fill(s : CryptosignrsapkcsCursor, v : Double) -> CryptosignrsapkcsCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_cursor_min(s : CryptosignrsapkcsCursor) -> Double { @_common.min(s.data) }

pub fn crypto_sign_rsa_pkcs_cursor_max(s : CryptosignrsapkcsCursor) -> Double { @_common.max(s.data) }

pub fn crypto_sign_rsa_pkcs_cursor_to_string(s : CryptosignrsapkcsCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapkcsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pkcs_view_make(size : Int) -> CryptosignrsapkcsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_rsa_pkcs_view_len(s : CryptosignrsapkcsView) -> Int { s.size }

pub fn crypto_sign_rsa_pkcs_view_get(s : CryptosignrsapkcsView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_rsa_pkcs_view_set(s : CryptosignrsapkcsView, i : Int, v : Double) -> CryptosignrsapkcsView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_view_sum(s : CryptosignrsapkcsView) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_rsa_pkcs_view_mean(s : CryptosignrsapkcsView) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_rsa_pkcs_view_scale(s : CryptosignrsapkcsView, f : Double) -> CryptosignrsapkcsView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_view_add(a : CryptosignrsapkcsView, b : CryptosignrsapkcsView) -> CryptosignrsapkcsView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_rsa_pkcs_view_copy(s : CryptosignrsapkcsView) -> CryptosignrsapkcsView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_view_fill(s : CryptosignrsapkcsView, v : Double) -> CryptosignrsapkcsView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_view_min(s : CryptosignrsapkcsView) -> Double { @_common.min(s.data) }

pub fn crypto_sign_rsa_pkcs_view_max(s : CryptosignrsapkcsView) -> Double { @_common.max(s.data) }

pub fn crypto_sign_rsa_pkcs_view_to_string(s : CryptosignrsapkcsView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapkcsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pkcs_range_make(size : Int) -> CryptosignrsapkcsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_rsa_pkcs_range_len(s : CryptosignrsapkcsRange) -> Int { s.size }

pub fn crypto_sign_rsa_pkcs_range_get(s : CryptosignrsapkcsRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_rsa_pkcs_range_set(s : CryptosignrsapkcsRange, i : Int, v : Double) -> CryptosignrsapkcsRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_range_sum(s : CryptosignrsapkcsRange) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_rsa_pkcs_range_mean(s : CryptosignrsapkcsRange) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_rsa_pkcs_range_scale(s : CryptosignrsapkcsRange, f : Double) -> CryptosignrsapkcsRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_range_add(a : CryptosignrsapkcsRange, b : CryptosignrsapkcsRange) -> CryptosignrsapkcsRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_rsa_pkcs_range_copy(s : CryptosignrsapkcsRange) -> CryptosignrsapkcsRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_range_fill(s : CryptosignrsapkcsRange, v : Double) -> CryptosignrsapkcsRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_range_min(s : CryptosignrsapkcsRange) -> Double { @_common.min(s.data) }

pub fn crypto_sign_rsa_pkcs_range_max(s : CryptosignrsapkcsRange) -> Double { @_common.max(s.data) }

pub fn crypto_sign_rsa_pkcs_range_to_string(s : CryptosignrsapkcsRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapkcsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pkcs_slice_make(size : Int) -> CryptosignrsapkcsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_rsa_pkcs_slice_len(s : CryptosignrsapkcsSlice) -> Int { s.size }

pub fn crypto_sign_rsa_pkcs_slice_get(s : CryptosignrsapkcsSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_rsa_pkcs_slice_set(s : CryptosignrsapkcsSlice, i : Int, v : Double) -> CryptosignrsapkcsSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_slice_sum(s : CryptosignrsapkcsSlice) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_rsa_pkcs_slice_mean(s : CryptosignrsapkcsSlice) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_rsa_pkcs_slice_scale(s : CryptosignrsapkcsSlice, f : Double) -> CryptosignrsapkcsSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_slice_add(a : CryptosignrsapkcsSlice, b : CryptosignrsapkcsSlice) -> CryptosignrsapkcsSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_rsa_pkcs_slice_copy(s : CryptosignrsapkcsSlice) -> CryptosignrsapkcsSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_slice_fill(s : CryptosignrsapkcsSlice, v : Double) -> CryptosignrsapkcsSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_rsa_pkcs_slice_min(s : CryptosignrsapkcsSlice) -> Double { @_common.min(s.data) }

pub fn crypto_sign_rsa_pkcs_slice_max(s : CryptosignrsapkcsSlice) -> Double { @_common.max(s.data) }

pub fn crypto_sign_rsa_pkcs_slice_to_string(s : CryptosignrsapkcsSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

