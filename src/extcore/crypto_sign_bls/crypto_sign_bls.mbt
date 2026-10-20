///===
/// extcore/crypto_sign_bls

pub(all) struct CryptosignblsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sign_bls_make_point(x : Double, y : Double) -> CryptosignblsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sign_bls_make_point3(x : Double, y : Double, z : Double) -> CryptosignblsPoint {
  { x, y, z, label: 0 }
}

pub fn CryptosignblsPoint::x(self : CryptosignblsPoint) -> Double { self.x }

pub fn CryptosignblsPoint::y(self : CryptosignblsPoint) -> Double { self.y }

pub fn CryptosignblsPoint::z(self : CryptosignblsPoint) -> Double { self.z }

pub fn CryptosignblsPoint::label(self : CryptosignblsPoint) -> Int { self.label }

pub fn CryptosignblsPoint::dist(self : CryptosignblsPoint, other : CryptosignblsPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn CryptosignblsPoint::add(self : CryptosignblsPoint, other : CryptosignblsPoint) -> CryptosignblsPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn CryptosignblsPoint::sub(self : CryptosignblsPoint, other : CryptosignblsPoint) -> CryptosignblsPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn CryptosignblsPoint::scale(self : CryptosignblsPoint, s : Double) -> CryptosignblsPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn CryptosignblsPoint::dot(self : CryptosignblsPoint, other : CryptosignblsPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn CryptosignblsPoint::cross(self : CryptosignblsPoint, other : CryptosignblsPoint) -> CryptosignblsPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn CryptosignblsPoint::norm(self : CryptosignblsPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn CryptosignblsPoint::normalize(self : CryptosignblsPoint) -> CryptosignblsPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosignblsPoint::negate(self : CryptosignblsPoint) -> CryptosignblsPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn CryptosignblsPoint::mid(self : CryptosignblsPoint, other : CryptosignblsPoint) -> CryptosignblsPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn CryptosignblsPoint::lerp(self : CryptosignblsPoint, other : CryptosignblsPoint, t : Double) -> CryptosignblsPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn CryptosignblsPoint::to_string(self : CryptosignblsPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct CryptosignblsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sign_bls_make_series(vals : Array[Double], name : String) -> CryptosignblsSeries {
  { vals, name, meta: 0 }
}

pub fn CryptosignblsSeries::len(self : CryptosignblsSeries) -> Int { self.vals.length() }

pub fn CryptosignblsSeries::sum(self : CryptosignblsSeries) -> Double { @_common.sum(self.vals) }

pub fn CryptosignblsSeries::mean(self : CryptosignblsSeries) -> Double { @_common.mean(self.vals) }

pub fn CryptosignblsSeries::min(self : CryptosignblsSeries) -> Double { @_common.min(self.vals) }

pub fn CryptosignblsSeries::max(self : CryptosignblsSeries) -> Double { @_common.max(self.vals) }

pub fn CryptosignblsSeries::range(self : CryptosignblsSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn CryptosignblsSeries::variance(self : CryptosignblsSeries) -> Double { @_common.variance(self.vals) }

pub fn CryptosignblsSeries::std(self : CryptosignblsSeries) -> Double { @_common.std(self.vals) }

pub fn CryptosignblsSeries::median(self : CryptosignblsSeries) -> Double { @_common.median(self.vals) }

pub fn CryptosignblsSeries::scale(self : CryptosignblsSeries, f : Double) -> CryptosignblsSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn CryptosignblsSeries::add(self : CryptosignblsSeries, other : CryptosignblsSeries) -> CryptosignblsSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn CryptosignblsSeries::sub(self : CryptosignblsSeries, other : CryptosignblsSeries) -> CryptosignblsSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn CryptosignblsSeries::normalize(self : CryptosignblsSeries) -> CryptosignblsSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn CryptosignblsSeries::cumsum(self : CryptosignblsSeries) -> CryptosignblsSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn CryptosignblsSeries::to_string(self : CryptosignblsSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosignblsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sign_bls_make_matrix(rows : Int, cols : Int, val : Double) -> CryptosignblsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_sign_bls_matrix_identity(n : Int) -> CryptosignblsMatrix {
  let m = crypto_sign_bls_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn CryptosignblsMatrix::get(self : CryptosignblsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn CryptosignblsMatrix::transpose(self : CryptosignblsMatrix) -> CryptosignblsMatrix {
  let result = crypto_sign_bls_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn CryptosignblsMatrix::add(self : CryptosignblsMatrix, other : CryptosignblsMatrix) -> CryptosignblsMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_sign_bls_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn CryptosignblsMatrix::scale(self : CryptosignblsMatrix, s : Double) -> CryptosignblsMatrix {
  let result = crypto_sign_bls_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn CryptosignblsMatrix::multiply(self : CryptosignblsMatrix, other : CryptosignblsMatrix) -> CryptosignblsMatrix {
  if self.cols != other.rows { return crypto_sign_bls_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_sign_bls_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn CryptosignblsMatrix::trace(self : CryptosignblsMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn CryptosignblsMatrix::det(self : CryptosignblsMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn CryptosignblsMatrix::norm(self : CryptosignblsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn CryptosignblsMatrix::to_string(self : CryptosignblsMatrix) -> String {
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

pub(all) struct CryptosignblsVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sign_bls_make_vector(comps : Array[Double]) -> CryptosignblsVector {
  { comps, dim: comps.length() }
}

pub fn crypto_sign_bls_vector_zero(dim : Int) -> CryptosignblsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn CryptosignblsVector::add(self : CryptosignblsVector, other : CryptosignblsVector) -> CryptosignblsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosignblsVector::sub(self : CryptosignblsVector, other : CryptosignblsVector) -> CryptosignblsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosignblsVector::scale(self : CryptosignblsVector, s : Double) -> CryptosignblsVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn CryptosignblsVector::dot(self : CryptosignblsVector, other : CryptosignblsVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn CryptosignblsVector::norm(self : CryptosignblsVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn CryptosignblsVector::normalize(self : CryptosignblsVector) -> CryptosignblsVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosignblsVector::dist(self : CryptosignblsVector, other : CryptosignblsVector) -> Double {
  self.sub(other).norm()
}

pub fn CryptosignblsVector::to_string(self : CryptosignblsVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_sign_bls_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_sign_bls_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_sign_bls_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_sign_bls_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_sign_bls_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_sign_bls_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_sign_bls_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_sign_bls_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_sign_bls_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_sign_bls_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_sign_bls_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_sign_bls_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_sign_bls_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_sign_bls_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_sign_bls_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_sign_bls_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_sign_bls_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_sign_bls_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_sign_bls_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_sign_bls_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_sign_bls_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_sign_bls_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_sign_bls_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_sign_bls_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_sign_bls_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_sign_bls_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_sign_bls_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_sign_bls_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_sign_bls_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct CryptosignblsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_bls_frame_make(size : Int) -> CryptosignblsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_bls_frame_len(s : CryptosignblsFrame) -> Int { s.size }

pub fn crypto_sign_bls_frame_get(s : CryptosignblsFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_bls_frame_set(s : CryptosignblsFrame, i : Int, v : Double) -> CryptosignblsFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_frame_sum(s : CryptosignblsFrame) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_bls_frame_mean(s : CryptosignblsFrame) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_bls_frame_scale(s : CryptosignblsFrame, f : Double) -> CryptosignblsFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_frame_add(a : CryptosignblsFrame, b : CryptosignblsFrame) -> CryptosignblsFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_bls_frame_copy(s : CryptosignblsFrame) -> CryptosignblsFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_frame_fill(s : CryptosignblsFrame, v : Double) -> CryptosignblsFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_frame_min(s : CryptosignblsFrame) -> Double { @_common.min(s.data) }

pub fn crypto_sign_bls_frame_max(s : CryptosignblsFrame) -> Double { @_common.max(s.data) }

pub fn crypto_sign_bls_frame_to_string(s : CryptosignblsFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignblsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_bls_table_make(size : Int) -> CryptosignblsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_bls_table_len(s : CryptosignblsTable) -> Int { s.size }

pub fn crypto_sign_bls_table_get(s : CryptosignblsTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_bls_table_set(s : CryptosignblsTable, i : Int, v : Double) -> CryptosignblsTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_table_sum(s : CryptosignblsTable) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_bls_table_mean(s : CryptosignblsTable) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_bls_table_scale(s : CryptosignblsTable, f : Double) -> CryptosignblsTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_table_add(a : CryptosignblsTable, b : CryptosignblsTable) -> CryptosignblsTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_bls_table_copy(s : CryptosignblsTable) -> CryptosignblsTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_table_fill(s : CryptosignblsTable, v : Double) -> CryptosignblsTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_table_min(s : CryptosignblsTable) -> Double { @_common.min(s.data) }

pub fn crypto_sign_bls_table_max(s : CryptosignblsTable) -> Double { @_common.max(s.data) }

pub fn crypto_sign_bls_table_to_string(s : CryptosignblsTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignblsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_bls_graphn_make(size : Int) -> CryptosignblsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_bls_graphn_len(s : CryptosignblsGraphN) -> Int { s.size }

pub fn crypto_sign_bls_graphn_get(s : CryptosignblsGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_bls_graphn_set(s : CryptosignblsGraphN, i : Int, v : Double) -> CryptosignblsGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_graphn_sum(s : CryptosignblsGraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_bls_graphn_mean(s : CryptosignblsGraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_bls_graphn_scale(s : CryptosignblsGraphN, f : Double) -> CryptosignblsGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_graphn_add(a : CryptosignblsGraphN, b : CryptosignblsGraphN) -> CryptosignblsGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_bls_graphn_copy(s : CryptosignblsGraphN) -> CryptosignblsGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_graphn_fill(s : CryptosignblsGraphN, v : Double) -> CryptosignblsGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_graphn_min(s : CryptosignblsGraphN) -> Double { @_common.min(s.data) }

pub fn crypto_sign_bls_graphn_max(s : CryptosignblsGraphN) -> Double { @_common.max(s.data) }

pub fn crypto_sign_bls_graphn_to_string(s : CryptosignblsGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignblsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_bls_node_make(size : Int) -> CryptosignblsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_bls_node_len(s : CryptosignblsNode) -> Int { s.size }

pub fn crypto_sign_bls_node_get(s : CryptosignblsNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_bls_node_set(s : CryptosignblsNode, i : Int, v : Double) -> CryptosignblsNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_node_sum(s : CryptosignblsNode) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_bls_node_mean(s : CryptosignblsNode) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_bls_node_scale(s : CryptosignblsNode, f : Double) -> CryptosignblsNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_node_add(a : CryptosignblsNode, b : CryptosignblsNode) -> CryptosignblsNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_bls_node_copy(s : CryptosignblsNode) -> CryptosignblsNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_node_fill(s : CryptosignblsNode, v : Double) -> CryptosignblsNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_node_min(s : CryptosignblsNode) -> Double { @_common.min(s.data) }

pub fn crypto_sign_bls_node_max(s : CryptosignblsNode) -> Double { @_common.max(s.data) }

pub fn crypto_sign_bls_node_to_string(s : CryptosignblsNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignblsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_bls_edge_make(size : Int) -> CryptosignblsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_bls_edge_len(s : CryptosignblsEdge) -> Int { s.size }

pub fn crypto_sign_bls_edge_get(s : CryptosignblsEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_bls_edge_set(s : CryptosignblsEdge, i : Int, v : Double) -> CryptosignblsEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_edge_sum(s : CryptosignblsEdge) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_bls_edge_mean(s : CryptosignblsEdge) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_bls_edge_scale(s : CryptosignblsEdge, f : Double) -> CryptosignblsEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_edge_add(a : CryptosignblsEdge, b : CryptosignblsEdge) -> CryptosignblsEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_bls_edge_copy(s : CryptosignblsEdge) -> CryptosignblsEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_edge_fill(s : CryptosignblsEdge, v : Double) -> CryptosignblsEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_edge_min(s : CryptosignblsEdge) -> Double { @_common.min(s.data) }

pub fn crypto_sign_bls_edge_max(s : CryptosignblsEdge) -> Double { @_common.max(s.data) }

pub fn crypto_sign_bls_edge_to_string(s : CryptosignblsEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignblsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_bls_path_make(size : Int) -> CryptosignblsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_bls_path_len(s : CryptosignblsPath) -> Int { s.size }

pub fn crypto_sign_bls_path_get(s : CryptosignblsPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_bls_path_set(s : CryptosignblsPath, i : Int, v : Double) -> CryptosignblsPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_path_sum(s : CryptosignblsPath) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_bls_path_mean(s : CryptosignblsPath) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_bls_path_scale(s : CryptosignblsPath, f : Double) -> CryptosignblsPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_path_add(a : CryptosignblsPath, b : CryptosignblsPath) -> CryptosignblsPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_bls_path_copy(s : CryptosignblsPath) -> CryptosignblsPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_path_fill(s : CryptosignblsPath, v : Double) -> CryptosignblsPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_path_min(s : CryptosignblsPath) -> Double { @_common.min(s.data) }

pub fn crypto_sign_bls_path_max(s : CryptosignblsPath) -> Double { @_common.max(s.data) }

pub fn crypto_sign_bls_path_to_string(s : CryptosignblsPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignblsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_bls_cluster_make(size : Int) -> CryptosignblsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_bls_cluster_len(s : CryptosignblsCluster) -> Int { s.size }

pub fn crypto_sign_bls_cluster_get(s : CryptosignblsCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_bls_cluster_set(s : CryptosignblsCluster, i : Int, v : Double) -> CryptosignblsCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_cluster_sum(s : CryptosignblsCluster) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_bls_cluster_mean(s : CryptosignblsCluster) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_bls_cluster_scale(s : CryptosignblsCluster, f : Double) -> CryptosignblsCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_cluster_add(a : CryptosignblsCluster, b : CryptosignblsCluster) -> CryptosignblsCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_bls_cluster_copy(s : CryptosignblsCluster) -> CryptosignblsCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_cluster_fill(s : CryptosignblsCluster, v : Double) -> CryptosignblsCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_cluster_min(s : CryptosignblsCluster) -> Double { @_common.min(s.data) }

pub fn crypto_sign_bls_cluster_max(s : CryptosignblsCluster) -> Double { @_common.max(s.data) }

pub fn crypto_sign_bls_cluster_to_string(s : CryptosignblsCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignblsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_bls_model_make(size : Int) -> CryptosignblsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_bls_model_len(s : CryptosignblsModel) -> Int { s.size }

pub fn crypto_sign_bls_model_get(s : CryptosignblsModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_bls_model_set(s : CryptosignblsModel, i : Int, v : Double) -> CryptosignblsModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_model_sum(s : CryptosignblsModel) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_bls_model_mean(s : CryptosignblsModel) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_bls_model_scale(s : CryptosignblsModel, f : Double) -> CryptosignblsModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_model_add(a : CryptosignblsModel, b : CryptosignblsModel) -> CryptosignblsModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_bls_model_copy(s : CryptosignblsModel) -> CryptosignblsModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_model_fill(s : CryptosignblsModel, v : Double) -> CryptosignblsModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_model_min(s : CryptosignblsModel) -> Double { @_common.min(s.data) }

pub fn crypto_sign_bls_model_max(s : CryptosignblsModel) -> Double { @_common.max(s.data) }

pub fn crypto_sign_bls_model_to_string(s : CryptosignblsModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignblsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_bls_layer_make(size : Int) -> CryptosignblsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_bls_layer_len(s : CryptosignblsLayer) -> Int { s.size }

pub fn crypto_sign_bls_layer_get(s : CryptosignblsLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_bls_layer_set(s : CryptosignblsLayer, i : Int, v : Double) -> CryptosignblsLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_layer_sum(s : CryptosignblsLayer) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_bls_layer_mean(s : CryptosignblsLayer) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_bls_layer_scale(s : CryptosignblsLayer, f : Double) -> CryptosignblsLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_layer_add(a : CryptosignblsLayer, b : CryptosignblsLayer) -> CryptosignblsLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_bls_layer_copy(s : CryptosignblsLayer) -> CryptosignblsLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_layer_fill(s : CryptosignblsLayer, v : Double) -> CryptosignblsLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_layer_min(s : CryptosignblsLayer) -> Double { @_common.min(s.data) }

pub fn crypto_sign_bls_layer_max(s : CryptosignblsLayer) -> Double { @_common.max(s.data) }

pub fn crypto_sign_bls_layer_to_string(s : CryptosignblsLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignblsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_bls_buffer_make(size : Int) -> CryptosignblsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_bls_buffer_len(s : CryptosignblsBuffer) -> Int { s.size }

pub fn crypto_sign_bls_buffer_get(s : CryptosignblsBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_bls_buffer_set(s : CryptosignblsBuffer, i : Int, v : Double) -> CryptosignblsBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_buffer_sum(s : CryptosignblsBuffer) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_bls_buffer_mean(s : CryptosignblsBuffer) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_bls_buffer_scale(s : CryptosignblsBuffer, f : Double) -> CryptosignblsBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_buffer_add(a : CryptosignblsBuffer, b : CryptosignblsBuffer) -> CryptosignblsBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_bls_buffer_copy(s : CryptosignblsBuffer) -> CryptosignblsBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_buffer_fill(s : CryptosignblsBuffer, v : Double) -> CryptosignblsBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_buffer_min(s : CryptosignblsBuffer) -> Double { @_common.min(s.data) }

pub fn crypto_sign_bls_buffer_max(s : CryptosignblsBuffer) -> Double { @_common.max(s.data) }

pub fn crypto_sign_bls_buffer_to_string(s : CryptosignblsBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignblsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_bls_cursor_make(size : Int) -> CryptosignblsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_bls_cursor_len(s : CryptosignblsCursor) -> Int { s.size }

pub fn crypto_sign_bls_cursor_get(s : CryptosignblsCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_bls_cursor_set(s : CryptosignblsCursor, i : Int, v : Double) -> CryptosignblsCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_cursor_sum(s : CryptosignblsCursor) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_bls_cursor_mean(s : CryptosignblsCursor) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_bls_cursor_scale(s : CryptosignblsCursor, f : Double) -> CryptosignblsCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_cursor_add(a : CryptosignblsCursor, b : CryptosignblsCursor) -> CryptosignblsCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_bls_cursor_copy(s : CryptosignblsCursor) -> CryptosignblsCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_cursor_fill(s : CryptosignblsCursor, v : Double) -> CryptosignblsCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_cursor_min(s : CryptosignblsCursor) -> Double { @_common.min(s.data) }

pub fn crypto_sign_bls_cursor_max(s : CryptosignblsCursor) -> Double { @_common.max(s.data) }

pub fn crypto_sign_bls_cursor_to_string(s : CryptosignblsCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignblsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_bls_view_make(size : Int) -> CryptosignblsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_bls_view_len(s : CryptosignblsView) -> Int { s.size }

pub fn crypto_sign_bls_view_get(s : CryptosignblsView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_bls_view_set(s : CryptosignblsView, i : Int, v : Double) -> CryptosignblsView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_view_sum(s : CryptosignblsView) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_bls_view_mean(s : CryptosignblsView) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_bls_view_scale(s : CryptosignblsView, f : Double) -> CryptosignblsView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_view_add(a : CryptosignblsView, b : CryptosignblsView) -> CryptosignblsView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_bls_view_copy(s : CryptosignblsView) -> CryptosignblsView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_view_fill(s : CryptosignblsView, v : Double) -> CryptosignblsView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_view_min(s : CryptosignblsView) -> Double { @_common.min(s.data) }

pub fn crypto_sign_bls_view_max(s : CryptosignblsView) -> Double { @_common.max(s.data) }

pub fn crypto_sign_bls_view_to_string(s : CryptosignblsView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignblsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_bls_range_make(size : Int) -> CryptosignblsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_bls_range_len(s : CryptosignblsRange) -> Int { s.size }

pub fn crypto_sign_bls_range_get(s : CryptosignblsRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_bls_range_set(s : CryptosignblsRange, i : Int, v : Double) -> CryptosignblsRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_range_sum(s : CryptosignblsRange) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_bls_range_mean(s : CryptosignblsRange) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_bls_range_scale(s : CryptosignblsRange, f : Double) -> CryptosignblsRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_range_add(a : CryptosignblsRange, b : CryptosignblsRange) -> CryptosignblsRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_bls_range_copy(s : CryptosignblsRange) -> CryptosignblsRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_range_fill(s : CryptosignblsRange, v : Double) -> CryptosignblsRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_range_min(s : CryptosignblsRange) -> Double { @_common.min(s.data) }

pub fn crypto_sign_bls_range_max(s : CryptosignblsRange) -> Double { @_common.max(s.data) }

pub fn crypto_sign_bls_range_to_string(s : CryptosignblsRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignblsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_bls_slice_make(size : Int) -> CryptosignblsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_bls_slice_len(s : CryptosignblsSlice) -> Int { s.size }

pub fn crypto_sign_bls_slice_get(s : CryptosignblsSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_bls_slice_set(s : CryptosignblsSlice, i : Int, v : Double) -> CryptosignblsSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_slice_sum(s : CryptosignblsSlice) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_bls_slice_mean(s : CryptosignblsSlice) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_bls_slice_scale(s : CryptosignblsSlice, f : Double) -> CryptosignblsSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_slice_add(a : CryptosignblsSlice, b : CryptosignblsSlice) -> CryptosignblsSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_bls_slice_copy(s : CryptosignblsSlice) -> CryptosignblsSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_slice_fill(s : CryptosignblsSlice, v : Double) -> CryptosignblsSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_slice_min(s : CryptosignblsSlice) -> Double { @_common.min(s.data) }

pub fn crypto_sign_bls_slice_max(s : CryptosignblsSlice) -> Double { @_common.max(s.data) }

pub fn crypto_sign_bls_slice_to_string(s : CryptosignblsSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

