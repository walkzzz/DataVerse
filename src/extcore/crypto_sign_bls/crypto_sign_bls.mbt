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

pub fn CryptosignblsFrame::len(self : CryptosignblsFrame) -> Int { self.size }

pub fn CryptosignblsFrame::get(self : CryptosignblsFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignblsFrame::set(self : CryptosignblsFrame, i : Int, v : Double) -> CryptosignblsFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignblsFrame::sum(self : CryptosignblsFrame) -> Double { @_common.sum(self.data) }

pub fn CryptosignblsFrame::mean(self : CryptosignblsFrame) -> Double { @_common.mean(self.data) }

pub fn CryptosignblsFrame::scale(self : CryptosignblsFrame, f : Double) -> CryptosignblsFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignblsFrame::add(self : CryptosignblsFrame, other : CryptosignblsFrame) -> CryptosignblsFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignblsFrame::copy(self : CryptosignblsFrame) -> CryptosignblsFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignblsFrame::fill(self : CryptosignblsFrame, v : Double) -> CryptosignblsFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignblsFrame::min(self : CryptosignblsFrame) -> Double { @_common.min(self.data) }

pub fn CryptosignblsFrame::max(self : CryptosignblsFrame) -> Double { @_common.max(self.data) }

pub fn CryptosignblsFrame::to_string(self : CryptosignblsFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignblsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_bls_table_make(size : Int) -> CryptosignblsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignblsTable::len(self : CryptosignblsTable) -> Int { self.size }

pub fn CryptosignblsTable::get(self : CryptosignblsTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignblsTable::set(self : CryptosignblsTable, i : Int, v : Double) -> CryptosignblsTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignblsTable::sum(self : CryptosignblsTable) -> Double { @_common.sum(self.data) }

pub fn CryptosignblsTable::mean(self : CryptosignblsTable) -> Double { @_common.mean(self.data) }

pub fn CryptosignblsTable::scale(self : CryptosignblsTable, f : Double) -> CryptosignblsTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignblsTable::add(self : CryptosignblsTable, other : CryptosignblsTable) -> CryptosignblsTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignblsTable::copy(self : CryptosignblsTable) -> CryptosignblsTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignblsTable::fill(self : CryptosignblsTable, v : Double) -> CryptosignblsTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignblsTable::min(self : CryptosignblsTable) -> Double { @_common.min(self.data) }

pub fn CryptosignblsTable::max(self : CryptosignblsTable) -> Double { @_common.max(self.data) }

pub fn CryptosignblsTable::to_string(self : CryptosignblsTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignblsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_bls_graphn_make(size : Int) -> CryptosignblsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignblsGraphN::len(self : CryptosignblsGraphN) -> Int { self.size }

pub fn CryptosignblsGraphN::get(self : CryptosignblsGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignblsGraphN::set(self : CryptosignblsGraphN, i : Int, v : Double) -> CryptosignblsGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignblsGraphN::sum(self : CryptosignblsGraphN) -> Double { @_common.sum(self.data) }

pub fn CryptosignblsGraphN::mean(self : CryptosignblsGraphN) -> Double { @_common.mean(self.data) }

pub fn CryptosignblsGraphN::scale(self : CryptosignblsGraphN, f : Double) -> CryptosignblsGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignblsGraphN::add(self : CryptosignblsGraphN, other : CryptosignblsGraphN) -> CryptosignblsGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignblsGraphN::copy(self : CryptosignblsGraphN) -> CryptosignblsGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignblsGraphN::fill(self : CryptosignblsGraphN, v : Double) -> CryptosignblsGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignblsGraphN::min(self : CryptosignblsGraphN) -> Double { @_common.min(self.data) }

pub fn CryptosignblsGraphN::max(self : CryptosignblsGraphN) -> Double { @_common.max(self.data) }

pub fn CryptosignblsGraphN::to_string(self : CryptosignblsGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignblsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_bls_node_make(size : Int) -> CryptosignblsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignblsNode::len(self : CryptosignblsNode) -> Int { self.size }

pub fn CryptosignblsNode::get(self : CryptosignblsNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignblsNode::set(self : CryptosignblsNode, i : Int, v : Double) -> CryptosignblsNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignblsNode::sum(self : CryptosignblsNode) -> Double { @_common.sum(self.data) }

pub fn CryptosignblsNode::mean(self : CryptosignblsNode) -> Double { @_common.mean(self.data) }

pub fn CryptosignblsNode::scale(self : CryptosignblsNode, f : Double) -> CryptosignblsNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignblsNode::add(self : CryptosignblsNode, other : CryptosignblsNode) -> CryptosignblsNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignblsNode::copy(self : CryptosignblsNode) -> CryptosignblsNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignblsNode::fill(self : CryptosignblsNode, v : Double) -> CryptosignblsNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignblsNode::min(self : CryptosignblsNode) -> Double { @_common.min(self.data) }

pub fn CryptosignblsNode::max(self : CryptosignblsNode) -> Double { @_common.max(self.data) }

pub fn CryptosignblsNode::to_string(self : CryptosignblsNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignblsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_bls_edge_make(size : Int) -> CryptosignblsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignblsEdge::len(self : CryptosignblsEdge) -> Int { self.size }

pub fn CryptosignblsEdge::get(self : CryptosignblsEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignblsEdge::set(self : CryptosignblsEdge, i : Int, v : Double) -> CryptosignblsEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignblsEdge::sum(self : CryptosignblsEdge) -> Double { @_common.sum(self.data) }

pub fn CryptosignblsEdge::mean(self : CryptosignblsEdge) -> Double { @_common.mean(self.data) }

pub fn CryptosignblsEdge::scale(self : CryptosignblsEdge, f : Double) -> CryptosignblsEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignblsEdge::add(self : CryptosignblsEdge, other : CryptosignblsEdge) -> CryptosignblsEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignblsEdge::copy(self : CryptosignblsEdge) -> CryptosignblsEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignblsEdge::fill(self : CryptosignblsEdge, v : Double) -> CryptosignblsEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignblsEdge::min(self : CryptosignblsEdge) -> Double { @_common.min(self.data) }

pub fn CryptosignblsEdge::max(self : CryptosignblsEdge) -> Double { @_common.max(self.data) }

pub fn CryptosignblsEdge::to_string(self : CryptosignblsEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignblsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_bls_path_make(size : Int) -> CryptosignblsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignblsPath::len(self : CryptosignblsPath) -> Int { self.size }

pub fn CryptosignblsPath::get(self : CryptosignblsPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignblsPath::set(self : CryptosignblsPath, i : Int, v : Double) -> CryptosignblsPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignblsPath::sum(self : CryptosignblsPath) -> Double { @_common.sum(self.data) }

pub fn CryptosignblsPath::mean(self : CryptosignblsPath) -> Double { @_common.mean(self.data) }

pub fn CryptosignblsPath::scale(self : CryptosignblsPath, f : Double) -> CryptosignblsPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignblsPath::add(self : CryptosignblsPath, other : CryptosignblsPath) -> CryptosignblsPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignblsPath::copy(self : CryptosignblsPath) -> CryptosignblsPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignblsPath::fill(self : CryptosignblsPath, v : Double) -> CryptosignblsPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignblsPath::min(self : CryptosignblsPath) -> Double { @_common.min(self.data) }

pub fn CryptosignblsPath::max(self : CryptosignblsPath) -> Double { @_common.max(self.data) }

pub fn CryptosignblsPath::to_string(self : CryptosignblsPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignblsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_bls_cluster_make(size : Int) -> CryptosignblsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignblsCluster::len(self : CryptosignblsCluster) -> Int { self.size }

pub fn CryptosignblsCluster::get(self : CryptosignblsCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignblsCluster::set(self : CryptosignblsCluster, i : Int, v : Double) -> CryptosignblsCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignblsCluster::sum(self : CryptosignblsCluster) -> Double { @_common.sum(self.data) }

pub fn CryptosignblsCluster::mean(self : CryptosignblsCluster) -> Double { @_common.mean(self.data) }

pub fn CryptosignblsCluster::scale(self : CryptosignblsCluster, f : Double) -> CryptosignblsCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignblsCluster::add(self : CryptosignblsCluster, other : CryptosignblsCluster) -> CryptosignblsCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignblsCluster::copy(self : CryptosignblsCluster) -> CryptosignblsCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignblsCluster::fill(self : CryptosignblsCluster, v : Double) -> CryptosignblsCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignblsCluster::min(self : CryptosignblsCluster) -> Double { @_common.min(self.data) }

pub fn CryptosignblsCluster::max(self : CryptosignblsCluster) -> Double { @_common.max(self.data) }

pub fn CryptosignblsCluster::to_string(self : CryptosignblsCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignblsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_bls_model_make(size : Int) -> CryptosignblsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignblsModel::len(self : CryptosignblsModel) -> Int { self.size }

pub fn CryptosignblsModel::get(self : CryptosignblsModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignblsModel::set(self : CryptosignblsModel, i : Int, v : Double) -> CryptosignblsModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignblsModel::sum(self : CryptosignblsModel) -> Double { @_common.sum(self.data) }

pub fn CryptosignblsModel::mean(self : CryptosignblsModel) -> Double { @_common.mean(self.data) }

pub fn CryptosignblsModel::scale(self : CryptosignblsModel, f : Double) -> CryptosignblsModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignblsModel::add(self : CryptosignblsModel, other : CryptosignblsModel) -> CryptosignblsModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignblsModel::copy(self : CryptosignblsModel) -> CryptosignblsModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignblsModel::fill(self : CryptosignblsModel, v : Double) -> CryptosignblsModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignblsModel::min(self : CryptosignblsModel) -> Double { @_common.min(self.data) }

pub fn CryptosignblsModel::max(self : CryptosignblsModel) -> Double { @_common.max(self.data) }

pub fn CryptosignblsModel::to_string(self : CryptosignblsModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignblsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_bls_layer_make(size : Int) -> CryptosignblsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignblsLayer::len(self : CryptosignblsLayer) -> Int { self.size }

pub fn CryptosignblsLayer::get(self : CryptosignblsLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignblsLayer::set(self : CryptosignblsLayer, i : Int, v : Double) -> CryptosignblsLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignblsLayer::sum(self : CryptosignblsLayer) -> Double { @_common.sum(self.data) }

pub fn CryptosignblsLayer::mean(self : CryptosignblsLayer) -> Double { @_common.mean(self.data) }

pub fn CryptosignblsLayer::scale(self : CryptosignblsLayer, f : Double) -> CryptosignblsLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignblsLayer::add(self : CryptosignblsLayer, other : CryptosignblsLayer) -> CryptosignblsLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignblsLayer::copy(self : CryptosignblsLayer) -> CryptosignblsLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignblsLayer::fill(self : CryptosignblsLayer, v : Double) -> CryptosignblsLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignblsLayer::min(self : CryptosignblsLayer) -> Double { @_common.min(self.data) }

pub fn CryptosignblsLayer::max(self : CryptosignblsLayer) -> Double { @_common.max(self.data) }

pub fn CryptosignblsLayer::to_string(self : CryptosignblsLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignblsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_bls_buffer_make(size : Int) -> CryptosignblsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignblsBuffer::len(self : CryptosignblsBuffer) -> Int { self.size }

pub fn CryptosignblsBuffer::get(self : CryptosignblsBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignblsBuffer::set(self : CryptosignblsBuffer, i : Int, v : Double) -> CryptosignblsBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignblsBuffer::sum(self : CryptosignblsBuffer) -> Double { @_common.sum(self.data) }

pub fn CryptosignblsBuffer::mean(self : CryptosignblsBuffer) -> Double { @_common.mean(self.data) }

pub fn CryptosignblsBuffer::scale(self : CryptosignblsBuffer, f : Double) -> CryptosignblsBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignblsBuffer::add(self : CryptosignblsBuffer, other : CryptosignblsBuffer) -> CryptosignblsBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignblsBuffer::copy(self : CryptosignblsBuffer) -> CryptosignblsBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignblsBuffer::fill(self : CryptosignblsBuffer, v : Double) -> CryptosignblsBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignblsBuffer::min(self : CryptosignblsBuffer) -> Double { @_common.min(self.data) }

pub fn CryptosignblsBuffer::max(self : CryptosignblsBuffer) -> Double { @_common.max(self.data) }

pub fn CryptosignblsBuffer::to_string(self : CryptosignblsBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignblsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_bls_cursor_make(size : Int) -> CryptosignblsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignblsCursor::len(self : CryptosignblsCursor) -> Int { self.size }

pub fn CryptosignblsCursor::get(self : CryptosignblsCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignblsCursor::set(self : CryptosignblsCursor, i : Int, v : Double) -> CryptosignblsCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignblsCursor::sum(self : CryptosignblsCursor) -> Double { @_common.sum(self.data) }

pub fn CryptosignblsCursor::mean(self : CryptosignblsCursor) -> Double { @_common.mean(self.data) }

pub fn CryptosignblsCursor::scale(self : CryptosignblsCursor, f : Double) -> CryptosignblsCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignblsCursor::add(self : CryptosignblsCursor, other : CryptosignblsCursor) -> CryptosignblsCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignblsCursor::copy(self : CryptosignblsCursor) -> CryptosignblsCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignblsCursor::fill(self : CryptosignblsCursor, v : Double) -> CryptosignblsCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignblsCursor::min(self : CryptosignblsCursor) -> Double { @_common.min(self.data) }

pub fn CryptosignblsCursor::max(self : CryptosignblsCursor) -> Double { @_common.max(self.data) }

pub fn CryptosignblsCursor::to_string(self : CryptosignblsCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignblsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_bls_view_make(size : Int) -> CryptosignblsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignblsView::len(self : CryptosignblsView) -> Int { self.size }

pub fn CryptosignblsView::get(self : CryptosignblsView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignblsView::set(self : CryptosignblsView, i : Int, v : Double) -> CryptosignblsView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignblsView::sum(self : CryptosignblsView) -> Double { @_common.sum(self.data) }

pub fn CryptosignblsView::mean(self : CryptosignblsView) -> Double { @_common.mean(self.data) }

pub fn CryptosignblsView::scale(self : CryptosignblsView, f : Double) -> CryptosignblsView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignblsView::add(self : CryptosignblsView, other : CryptosignblsView) -> CryptosignblsView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignblsView::copy(self : CryptosignblsView) -> CryptosignblsView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignblsView::fill(self : CryptosignblsView, v : Double) -> CryptosignblsView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignblsView::min(self : CryptosignblsView) -> Double { @_common.min(self.data) }

pub fn CryptosignblsView::max(self : CryptosignblsView) -> Double { @_common.max(self.data) }

pub fn CryptosignblsView::to_string(self : CryptosignblsView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignblsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_bls_range_make(size : Int) -> CryptosignblsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignblsRange::len(self : CryptosignblsRange) -> Int { self.size }

pub fn CryptosignblsRange::get(self : CryptosignblsRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignblsRange::set(self : CryptosignblsRange, i : Int, v : Double) -> CryptosignblsRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignblsRange::sum(self : CryptosignblsRange) -> Double { @_common.sum(self.data) }

pub fn CryptosignblsRange::mean(self : CryptosignblsRange) -> Double { @_common.mean(self.data) }

pub fn CryptosignblsRange::scale(self : CryptosignblsRange, f : Double) -> CryptosignblsRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignblsRange::add(self : CryptosignblsRange, other : CryptosignblsRange) -> CryptosignblsRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignblsRange::copy(self : CryptosignblsRange) -> CryptosignblsRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignblsRange::fill(self : CryptosignblsRange, v : Double) -> CryptosignblsRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignblsRange::min(self : CryptosignblsRange) -> Double { @_common.min(self.data) }

pub fn CryptosignblsRange::max(self : CryptosignblsRange) -> Double { @_common.max(self.data) }

pub fn CryptosignblsRange::to_string(self : CryptosignblsRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignblsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_bls_slice_make(size : Int) -> CryptosignblsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignblsSlice::len(self : CryptosignblsSlice) -> Int { self.size }

pub fn CryptosignblsSlice::get(self : CryptosignblsSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignblsSlice::set(self : CryptosignblsSlice, i : Int, v : Double) -> CryptosignblsSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignblsSlice::sum(self : CryptosignblsSlice) -> Double { @_common.sum(self.data) }

pub fn CryptosignblsSlice::mean(self : CryptosignblsSlice) -> Double { @_common.mean(self.data) }

pub fn CryptosignblsSlice::scale(self : CryptosignblsSlice, f : Double) -> CryptosignblsSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignblsSlice::add(self : CryptosignblsSlice, other : CryptosignblsSlice) -> CryptosignblsSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignblsSlice::copy(self : CryptosignblsSlice) -> CryptosignblsSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignblsSlice::fill(self : CryptosignblsSlice, v : Double) -> CryptosignblsSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignblsSlice::min(self : CryptosignblsSlice) -> Double { @_common.min(self.data) }

pub fn CryptosignblsSlice::max(self : CryptosignblsSlice) -> Double { @_common.max(self.data) }

pub fn CryptosignblsSlice::to_string(self : CryptosignblsSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

