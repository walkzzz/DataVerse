///===
/// extcore/crypto_sym_aes

pub(all) struct CryptosymaesPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sym_aes_make_point(x : Double, y : Double) -> CryptosymaesPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sym_aes_make_point3(x : Double, y : Double, z : Double) -> CryptosymaesPoint {
  { x, y, z, label: 0 }
}

pub fn CryptosymaesPoint::x(self : CryptosymaesPoint) -> Double { self.x }

pub fn CryptosymaesPoint::y(self : CryptosymaesPoint) -> Double { self.y }

pub fn CryptosymaesPoint::z(self : CryptosymaesPoint) -> Double { self.z }

pub fn CryptosymaesPoint::label(self : CryptosymaesPoint) -> Int { self.label }

pub fn CryptosymaesPoint::dist(self : CryptosymaesPoint, other : CryptosymaesPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn CryptosymaesPoint::add(self : CryptosymaesPoint, other : CryptosymaesPoint) -> CryptosymaesPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn CryptosymaesPoint::sub(self : CryptosymaesPoint, other : CryptosymaesPoint) -> CryptosymaesPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn CryptosymaesPoint::scale(self : CryptosymaesPoint, s : Double) -> CryptosymaesPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn CryptosymaesPoint::dot(self : CryptosymaesPoint, other : CryptosymaesPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn CryptosymaesPoint::cross(self : CryptosymaesPoint, other : CryptosymaesPoint) -> CryptosymaesPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn CryptosymaesPoint::norm(self : CryptosymaesPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn CryptosymaesPoint::normalize(self : CryptosymaesPoint) -> CryptosymaesPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosymaesPoint::negate(self : CryptosymaesPoint) -> CryptosymaesPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn CryptosymaesPoint::mid(self : CryptosymaesPoint, other : CryptosymaesPoint) -> CryptosymaesPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn CryptosymaesPoint::lerp(self : CryptosymaesPoint, other : CryptosymaesPoint, t : Double) -> CryptosymaesPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn CryptosymaesPoint::to_string(self : CryptosymaesPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct CryptosymaesSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sym_aes_make_series(vals : Array[Double], name : String) -> CryptosymaesSeries {
  { vals, name, meta: 0 }
}

pub fn CryptosymaesSeries::len(self : CryptosymaesSeries) -> Int { self.vals.length() }

pub fn CryptosymaesSeries::sum(self : CryptosymaesSeries) -> Double { @_common.sum(self.vals) }

pub fn CryptosymaesSeries::mean(self : CryptosymaesSeries) -> Double { @_common.mean(self.vals) }

pub fn CryptosymaesSeries::min(self : CryptosymaesSeries) -> Double { @_common.min(self.vals) }

pub fn CryptosymaesSeries::max(self : CryptosymaesSeries) -> Double { @_common.max(self.vals) }

pub fn CryptosymaesSeries::range(self : CryptosymaesSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn CryptosymaesSeries::variance(self : CryptosymaesSeries) -> Double { @_common.variance(self.vals) }

pub fn CryptosymaesSeries::std(self : CryptosymaesSeries) -> Double { @_common.std(self.vals) }

pub fn CryptosymaesSeries::median(self : CryptosymaesSeries) -> Double { @_common.median(self.vals) }

pub fn CryptosymaesSeries::scale(self : CryptosymaesSeries, f : Double) -> CryptosymaesSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn CryptosymaesSeries::add(self : CryptosymaesSeries, other : CryptosymaesSeries) -> CryptosymaesSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn CryptosymaesSeries::sub(self : CryptosymaesSeries, other : CryptosymaesSeries) -> CryptosymaesSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn CryptosymaesSeries::normalize(self : CryptosymaesSeries) -> CryptosymaesSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn CryptosymaesSeries::cumsum(self : CryptosymaesSeries) -> CryptosymaesSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn CryptosymaesSeries::to_string(self : CryptosymaesSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosymaesMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sym_aes_make_matrix(rows : Int, cols : Int, val : Double) -> CryptosymaesMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_sym_aes_matrix_identity(n : Int) -> CryptosymaesMatrix {
  let m = crypto_sym_aes_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn CryptosymaesMatrix::get(self : CryptosymaesMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn CryptosymaesMatrix::transpose(self : CryptosymaesMatrix) -> CryptosymaesMatrix {
  let result = crypto_sym_aes_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn CryptosymaesMatrix::add(self : CryptosymaesMatrix, other : CryptosymaesMatrix) -> CryptosymaesMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_sym_aes_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn CryptosymaesMatrix::scale(self : CryptosymaesMatrix, s : Double) -> CryptosymaesMatrix {
  let result = crypto_sym_aes_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn CryptosymaesMatrix::multiply(self : CryptosymaesMatrix, other : CryptosymaesMatrix) -> CryptosymaesMatrix {
  if self.cols != other.rows { return crypto_sym_aes_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_sym_aes_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn CryptosymaesMatrix::trace(self : CryptosymaesMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn CryptosymaesMatrix::det(self : CryptosymaesMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn CryptosymaesMatrix::norm(self : CryptosymaesMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn CryptosymaesMatrix::to_string(self : CryptosymaesMatrix) -> String {
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

pub(all) struct CryptosymaesVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sym_aes_make_vector(comps : Array[Double]) -> CryptosymaesVector {
  { comps, dim: comps.length() }
}

pub fn crypto_sym_aes_vector_zero(dim : Int) -> CryptosymaesVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn CryptosymaesVector::add(self : CryptosymaesVector, other : CryptosymaesVector) -> CryptosymaesVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosymaesVector::sub(self : CryptosymaesVector, other : CryptosymaesVector) -> CryptosymaesVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosymaesVector::scale(self : CryptosymaesVector, s : Double) -> CryptosymaesVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn CryptosymaesVector::dot(self : CryptosymaesVector, other : CryptosymaesVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn CryptosymaesVector::norm(self : CryptosymaesVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn CryptosymaesVector::normalize(self : CryptosymaesVector) -> CryptosymaesVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosymaesVector::dist(self : CryptosymaesVector, other : CryptosymaesVector) -> Double {
  self.sub(other).norm()
}

pub fn CryptosymaesVector::to_string(self : CryptosymaesVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_sym_aes_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_sym_aes_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_sym_aes_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_sym_aes_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_sym_aes_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_sym_aes_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_sym_aes_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_sym_aes_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_sym_aes_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_sym_aes_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_sym_aes_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_sym_aes_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_sym_aes_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_sym_aes_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_sym_aes_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_sym_aes_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_sym_aes_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_sym_aes_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_sym_aes_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_sym_aes_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_sym_aes_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_sym_aes_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_sym_aes_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_sym_aes_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_sym_aes_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_sym_aes_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_sym_aes_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_sym_aes_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_sym_aes_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct CryptosymaesFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_aes_frame_make(size : Int) -> CryptosymaesFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymaesFrame::len(self : CryptosymaesFrame) -> Int { self.size }

pub fn CryptosymaesFrame::get(self : CryptosymaesFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymaesFrame::set(self : CryptosymaesFrame, i : Int, v : Double) -> CryptosymaesFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymaesFrame::sum(self : CryptosymaesFrame) -> Double { @_common.sum(self.data) }

pub fn CryptosymaesFrame::mean(self : CryptosymaesFrame) -> Double { @_common.mean(self.data) }

pub fn CryptosymaesFrame::scale(self : CryptosymaesFrame, f : Double) -> CryptosymaesFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymaesFrame::add(self : CryptosymaesFrame, other : CryptosymaesFrame) -> CryptosymaesFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymaesFrame::copy(self : CryptosymaesFrame) -> CryptosymaesFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymaesFrame::fill(self : CryptosymaesFrame, v : Double) -> CryptosymaesFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymaesFrame::min(self : CryptosymaesFrame) -> Double { @_common.min(self.data) }

pub fn CryptosymaesFrame::max(self : CryptosymaesFrame) -> Double { @_common.max(self.data) }

pub fn CryptosymaesFrame::to_string(self : CryptosymaesFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymaesTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_aes_table_make(size : Int) -> CryptosymaesTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymaesTable::len(self : CryptosymaesTable) -> Int { self.size }

pub fn CryptosymaesTable::get(self : CryptosymaesTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymaesTable::set(self : CryptosymaesTable, i : Int, v : Double) -> CryptosymaesTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymaesTable::sum(self : CryptosymaesTable) -> Double { @_common.sum(self.data) }

pub fn CryptosymaesTable::mean(self : CryptosymaesTable) -> Double { @_common.mean(self.data) }

pub fn CryptosymaesTable::scale(self : CryptosymaesTable, f : Double) -> CryptosymaesTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymaesTable::add(self : CryptosymaesTable, other : CryptosymaesTable) -> CryptosymaesTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymaesTable::copy(self : CryptosymaesTable) -> CryptosymaesTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymaesTable::fill(self : CryptosymaesTable, v : Double) -> CryptosymaesTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymaesTable::min(self : CryptosymaesTable) -> Double { @_common.min(self.data) }

pub fn CryptosymaesTable::max(self : CryptosymaesTable) -> Double { @_common.max(self.data) }

pub fn CryptosymaesTable::to_string(self : CryptosymaesTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymaesGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_aes_graphn_make(size : Int) -> CryptosymaesGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymaesGraphN::len(self : CryptosymaesGraphN) -> Int { self.size }

pub fn CryptosymaesGraphN::get(self : CryptosymaesGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymaesGraphN::set(self : CryptosymaesGraphN, i : Int, v : Double) -> CryptosymaesGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymaesGraphN::sum(self : CryptosymaesGraphN) -> Double { @_common.sum(self.data) }

pub fn CryptosymaesGraphN::mean(self : CryptosymaesGraphN) -> Double { @_common.mean(self.data) }

pub fn CryptosymaesGraphN::scale(self : CryptosymaesGraphN, f : Double) -> CryptosymaesGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymaesGraphN::add(self : CryptosymaesGraphN, other : CryptosymaesGraphN) -> CryptosymaesGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymaesGraphN::copy(self : CryptosymaesGraphN) -> CryptosymaesGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymaesGraphN::fill(self : CryptosymaesGraphN, v : Double) -> CryptosymaesGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymaesGraphN::min(self : CryptosymaesGraphN) -> Double { @_common.min(self.data) }

pub fn CryptosymaesGraphN::max(self : CryptosymaesGraphN) -> Double { @_common.max(self.data) }

pub fn CryptosymaesGraphN::to_string(self : CryptosymaesGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymaesNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_aes_node_make(size : Int) -> CryptosymaesNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymaesNode::len(self : CryptosymaesNode) -> Int { self.size }

pub fn CryptosymaesNode::get(self : CryptosymaesNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymaesNode::set(self : CryptosymaesNode, i : Int, v : Double) -> CryptosymaesNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymaesNode::sum(self : CryptosymaesNode) -> Double { @_common.sum(self.data) }

pub fn CryptosymaesNode::mean(self : CryptosymaesNode) -> Double { @_common.mean(self.data) }

pub fn CryptosymaesNode::scale(self : CryptosymaesNode, f : Double) -> CryptosymaesNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymaesNode::add(self : CryptosymaesNode, other : CryptosymaesNode) -> CryptosymaesNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymaesNode::copy(self : CryptosymaesNode) -> CryptosymaesNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymaesNode::fill(self : CryptosymaesNode, v : Double) -> CryptosymaesNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymaesNode::min(self : CryptosymaesNode) -> Double { @_common.min(self.data) }

pub fn CryptosymaesNode::max(self : CryptosymaesNode) -> Double { @_common.max(self.data) }

pub fn CryptosymaesNode::to_string(self : CryptosymaesNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymaesEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_aes_edge_make(size : Int) -> CryptosymaesEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymaesEdge::len(self : CryptosymaesEdge) -> Int { self.size }

pub fn CryptosymaesEdge::get(self : CryptosymaesEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymaesEdge::set(self : CryptosymaesEdge, i : Int, v : Double) -> CryptosymaesEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymaesEdge::sum(self : CryptosymaesEdge) -> Double { @_common.sum(self.data) }

pub fn CryptosymaesEdge::mean(self : CryptosymaesEdge) -> Double { @_common.mean(self.data) }

pub fn CryptosymaesEdge::scale(self : CryptosymaesEdge, f : Double) -> CryptosymaesEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymaesEdge::add(self : CryptosymaesEdge, other : CryptosymaesEdge) -> CryptosymaesEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymaesEdge::copy(self : CryptosymaesEdge) -> CryptosymaesEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymaesEdge::fill(self : CryptosymaesEdge, v : Double) -> CryptosymaesEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymaesEdge::min(self : CryptosymaesEdge) -> Double { @_common.min(self.data) }

pub fn CryptosymaesEdge::max(self : CryptosymaesEdge) -> Double { @_common.max(self.data) }

pub fn CryptosymaesEdge::to_string(self : CryptosymaesEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymaesPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_aes_path_make(size : Int) -> CryptosymaesPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymaesPath::len(self : CryptosymaesPath) -> Int { self.size }

pub fn CryptosymaesPath::get(self : CryptosymaesPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymaesPath::set(self : CryptosymaesPath, i : Int, v : Double) -> CryptosymaesPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymaesPath::sum(self : CryptosymaesPath) -> Double { @_common.sum(self.data) }

pub fn CryptosymaesPath::mean(self : CryptosymaesPath) -> Double { @_common.mean(self.data) }

pub fn CryptosymaesPath::scale(self : CryptosymaesPath, f : Double) -> CryptosymaesPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymaesPath::add(self : CryptosymaesPath, other : CryptosymaesPath) -> CryptosymaesPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymaesPath::copy(self : CryptosymaesPath) -> CryptosymaesPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymaesPath::fill(self : CryptosymaesPath, v : Double) -> CryptosymaesPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymaesPath::min(self : CryptosymaesPath) -> Double { @_common.min(self.data) }

pub fn CryptosymaesPath::max(self : CryptosymaesPath) -> Double { @_common.max(self.data) }

pub fn CryptosymaesPath::to_string(self : CryptosymaesPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymaesCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_aes_cluster_make(size : Int) -> CryptosymaesCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymaesCluster::len(self : CryptosymaesCluster) -> Int { self.size }

pub fn CryptosymaesCluster::get(self : CryptosymaesCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymaesCluster::set(self : CryptosymaesCluster, i : Int, v : Double) -> CryptosymaesCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymaesCluster::sum(self : CryptosymaesCluster) -> Double { @_common.sum(self.data) }

pub fn CryptosymaesCluster::mean(self : CryptosymaesCluster) -> Double { @_common.mean(self.data) }

pub fn CryptosymaesCluster::scale(self : CryptosymaesCluster, f : Double) -> CryptosymaesCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymaesCluster::add(self : CryptosymaesCluster, other : CryptosymaesCluster) -> CryptosymaesCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymaesCluster::copy(self : CryptosymaesCluster) -> CryptosymaesCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymaesCluster::fill(self : CryptosymaesCluster, v : Double) -> CryptosymaesCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymaesCluster::min(self : CryptosymaesCluster) -> Double { @_common.min(self.data) }

pub fn CryptosymaesCluster::max(self : CryptosymaesCluster) -> Double { @_common.max(self.data) }

pub fn CryptosymaesCluster::to_string(self : CryptosymaesCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymaesModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_aes_model_make(size : Int) -> CryptosymaesModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymaesModel::len(self : CryptosymaesModel) -> Int { self.size }

pub fn CryptosymaesModel::get(self : CryptosymaesModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymaesModel::set(self : CryptosymaesModel, i : Int, v : Double) -> CryptosymaesModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymaesModel::sum(self : CryptosymaesModel) -> Double { @_common.sum(self.data) }

pub fn CryptosymaesModel::mean(self : CryptosymaesModel) -> Double { @_common.mean(self.data) }

pub fn CryptosymaesModel::scale(self : CryptosymaesModel, f : Double) -> CryptosymaesModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymaesModel::add(self : CryptosymaesModel, other : CryptosymaesModel) -> CryptosymaesModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymaesModel::copy(self : CryptosymaesModel) -> CryptosymaesModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymaesModel::fill(self : CryptosymaesModel, v : Double) -> CryptosymaesModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymaesModel::min(self : CryptosymaesModel) -> Double { @_common.min(self.data) }

pub fn CryptosymaesModel::max(self : CryptosymaesModel) -> Double { @_common.max(self.data) }

pub fn CryptosymaesModel::to_string(self : CryptosymaesModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymaesLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_aes_layer_make(size : Int) -> CryptosymaesLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymaesLayer::len(self : CryptosymaesLayer) -> Int { self.size }

pub fn CryptosymaesLayer::get(self : CryptosymaesLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymaesLayer::set(self : CryptosymaesLayer, i : Int, v : Double) -> CryptosymaesLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymaesLayer::sum(self : CryptosymaesLayer) -> Double { @_common.sum(self.data) }

pub fn CryptosymaesLayer::mean(self : CryptosymaesLayer) -> Double { @_common.mean(self.data) }

pub fn CryptosymaesLayer::scale(self : CryptosymaesLayer, f : Double) -> CryptosymaesLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymaesLayer::add(self : CryptosymaesLayer, other : CryptosymaesLayer) -> CryptosymaesLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymaesLayer::copy(self : CryptosymaesLayer) -> CryptosymaesLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymaesLayer::fill(self : CryptosymaesLayer, v : Double) -> CryptosymaesLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymaesLayer::min(self : CryptosymaesLayer) -> Double { @_common.min(self.data) }

pub fn CryptosymaesLayer::max(self : CryptosymaesLayer) -> Double { @_common.max(self.data) }

pub fn CryptosymaesLayer::to_string(self : CryptosymaesLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymaesBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_aes_buffer_make(size : Int) -> CryptosymaesBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymaesBuffer::len(self : CryptosymaesBuffer) -> Int { self.size }

pub fn CryptosymaesBuffer::get(self : CryptosymaesBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymaesBuffer::set(self : CryptosymaesBuffer, i : Int, v : Double) -> CryptosymaesBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymaesBuffer::sum(self : CryptosymaesBuffer) -> Double { @_common.sum(self.data) }

pub fn CryptosymaesBuffer::mean(self : CryptosymaesBuffer) -> Double { @_common.mean(self.data) }

pub fn CryptosymaesBuffer::scale(self : CryptosymaesBuffer, f : Double) -> CryptosymaesBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymaesBuffer::add(self : CryptosymaesBuffer, other : CryptosymaesBuffer) -> CryptosymaesBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymaesBuffer::copy(self : CryptosymaesBuffer) -> CryptosymaesBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymaesBuffer::fill(self : CryptosymaesBuffer, v : Double) -> CryptosymaesBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymaesBuffer::min(self : CryptosymaesBuffer) -> Double { @_common.min(self.data) }

pub fn CryptosymaesBuffer::max(self : CryptosymaesBuffer) -> Double { @_common.max(self.data) }

pub fn CryptosymaesBuffer::to_string(self : CryptosymaesBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymaesCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_aes_cursor_make(size : Int) -> CryptosymaesCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymaesCursor::len(self : CryptosymaesCursor) -> Int { self.size }

pub fn CryptosymaesCursor::get(self : CryptosymaesCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymaesCursor::set(self : CryptosymaesCursor, i : Int, v : Double) -> CryptosymaesCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymaesCursor::sum(self : CryptosymaesCursor) -> Double { @_common.sum(self.data) }

pub fn CryptosymaesCursor::mean(self : CryptosymaesCursor) -> Double { @_common.mean(self.data) }

pub fn CryptosymaesCursor::scale(self : CryptosymaesCursor, f : Double) -> CryptosymaesCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymaesCursor::add(self : CryptosymaesCursor, other : CryptosymaesCursor) -> CryptosymaesCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymaesCursor::copy(self : CryptosymaesCursor) -> CryptosymaesCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymaesCursor::fill(self : CryptosymaesCursor, v : Double) -> CryptosymaesCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymaesCursor::min(self : CryptosymaesCursor) -> Double { @_common.min(self.data) }

pub fn CryptosymaesCursor::max(self : CryptosymaesCursor) -> Double { @_common.max(self.data) }

pub fn CryptosymaesCursor::to_string(self : CryptosymaesCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymaesView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_aes_view_make(size : Int) -> CryptosymaesView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymaesView::len(self : CryptosymaesView) -> Int { self.size }

pub fn CryptosymaesView::get(self : CryptosymaesView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymaesView::set(self : CryptosymaesView, i : Int, v : Double) -> CryptosymaesView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymaesView::sum(self : CryptosymaesView) -> Double { @_common.sum(self.data) }

pub fn CryptosymaesView::mean(self : CryptosymaesView) -> Double { @_common.mean(self.data) }

pub fn CryptosymaesView::scale(self : CryptosymaesView, f : Double) -> CryptosymaesView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymaesView::add(self : CryptosymaesView, other : CryptosymaesView) -> CryptosymaesView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymaesView::copy(self : CryptosymaesView) -> CryptosymaesView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymaesView::fill(self : CryptosymaesView, v : Double) -> CryptosymaesView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymaesView::min(self : CryptosymaesView) -> Double { @_common.min(self.data) }

pub fn CryptosymaesView::max(self : CryptosymaesView) -> Double { @_common.max(self.data) }

pub fn CryptosymaesView::to_string(self : CryptosymaesView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymaesRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_aes_range_make(size : Int) -> CryptosymaesRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymaesRange::len(self : CryptosymaesRange) -> Int { self.size }

pub fn CryptosymaesRange::get(self : CryptosymaesRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymaesRange::set(self : CryptosymaesRange, i : Int, v : Double) -> CryptosymaesRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymaesRange::sum(self : CryptosymaesRange) -> Double { @_common.sum(self.data) }

pub fn CryptosymaesRange::mean(self : CryptosymaesRange) -> Double { @_common.mean(self.data) }

pub fn CryptosymaesRange::scale(self : CryptosymaesRange, f : Double) -> CryptosymaesRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymaesRange::add(self : CryptosymaesRange, other : CryptosymaesRange) -> CryptosymaesRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymaesRange::copy(self : CryptosymaesRange) -> CryptosymaesRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymaesRange::fill(self : CryptosymaesRange, v : Double) -> CryptosymaesRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymaesRange::min(self : CryptosymaesRange) -> Double { @_common.min(self.data) }

pub fn CryptosymaesRange::max(self : CryptosymaesRange) -> Double { @_common.max(self.data) }

pub fn CryptosymaesRange::to_string(self : CryptosymaesRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymaesSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_aes_slice_make(size : Int) -> CryptosymaesSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymaesSlice::len(self : CryptosymaesSlice) -> Int { self.size }

pub fn CryptosymaesSlice::get(self : CryptosymaesSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymaesSlice::set(self : CryptosymaesSlice, i : Int, v : Double) -> CryptosymaesSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymaesSlice::sum(self : CryptosymaesSlice) -> Double { @_common.sum(self.data) }

pub fn CryptosymaesSlice::mean(self : CryptosymaesSlice) -> Double { @_common.mean(self.data) }

pub fn CryptosymaesSlice::scale(self : CryptosymaesSlice, f : Double) -> CryptosymaesSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymaesSlice::add(self : CryptosymaesSlice, other : CryptosymaesSlice) -> CryptosymaesSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymaesSlice::copy(self : CryptosymaesSlice) -> CryptosymaesSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymaesSlice::fill(self : CryptosymaesSlice, v : Double) -> CryptosymaesSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymaesSlice::min(self : CryptosymaesSlice) -> Double { @_common.min(self.data) }

pub fn CryptosymaesSlice::max(self : CryptosymaesSlice) -> Double { @_common.max(self.data) }

pub fn CryptosymaesSlice::to_string(self : CryptosymaesSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

