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

pub fn crypto_sym_aes_frame_len(s : CryptosymaesFrame) -> Int { s.size }

pub fn crypto_sym_aes_frame_get(s : CryptosymaesFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_aes_frame_set(s : CryptosymaesFrame, i : Int, v : Double) -> CryptosymaesFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_frame_sum(s : CryptosymaesFrame) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_aes_frame_mean(s : CryptosymaesFrame) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_aes_frame_scale(s : CryptosymaesFrame, f : Double) -> CryptosymaesFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_frame_add(a : CryptosymaesFrame, b : CryptosymaesFrame) -> CryptosymaesFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_aes_frame_copy(s : CryptosymaesFrame) -> CryptosymaesFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_frame_fill(s : CryptosymaesFrame, v : Double) -> CryptosymaesFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_frame_min(s : CryptosymaesFrame) -> Double { @_common.min(s.data) }

pub fn crypto_sym_aes_frame_max(s : CryptosymaesFrame) -> Double { @_common.max(s.data) }

pub fn crypto_sym_aes_frame_to_string(s : CryptosymaesFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymaesTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_aes_table_make(size : Int) -> CryptosymaesTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_aes_table_len(s : CryptosymaesTable) -> Int { s.size }

pub fn crypto_sym_aes_table_get(s : CryptosymaesTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_aes_table_set(s : CryptosymaesTable, i : Int, v : Double) -> CryptosymaesTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_table_sum(s : CryptosymaesTable) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_aes_table_mean(s : CryptosymaesTable) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_aes_table_scale(s : CryptosymaesTable, f : Double) -> CryptosymaesTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_table_add(a : CryptosymaesTable, b : CryptosymaesTable) -> CryptosymaesTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_aes_table_copy(s : CryptosymaesTable) -> CryptosymaesTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_table_fill(s : CryptosymaesTable, v : Double) -> CryptosymaesTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_table_min(s : CryptosymaesTable) -> Double { @_common.min(s.data) }

pub fn crypto_sym_aes_table_max(s : CryptosymaesTable) -> Double { @_common.max(s.data) }

pub fn crypto_sym_aes_table_to_string(s : CryptosymaesTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymaesGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_aes_graphn_make(size : Int) -> CryptosymaesGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_aes_graphn_len(s : CryptosymaesGraphN) -> Int { s.size }

pub fn crypto_sym_aes_graphn_get(s : CryptosymaesGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_aes_graphn_set(s : CryptosymaesGraphN, i : Int, v : Double) -> CryptosymaesGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_graphn_sum(s : CryptosymaesGraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_aes_graphn_mean(s : CryptosymaesGraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_aes_graphn_scale(s : CryptosymaesGraphN, f : Double) -> CryptosymaesGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_graphn_add(a : CryptosymaesGraphN, b : CryptosymaesGraphN) -> CryptosymaesGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_aes_graphn_copy(s : CryptosymaesGraphN) -> CryptosymaesGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_graphn_fill(s : CryptosymaesGraphN, v : Double) -> CryptosymaesGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_graphn_min(s : CryptosymaesGraphN) -> Double { @_common.min(s.data) }

pub fn crypto_sym_aes_graphn_max(s : CryptosymaesGraphN) -> Double { @_common.max(s.data) }

pub fn crypto_sym_aes_graphn_to_string(s : CryptosymaesGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymaesNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_aes_node_make(size : Int) -> CryptosymaesNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_aes_node_len(s : CryptosymaesNode) -> Int { s.size }

pub fn crypto_sym_aes_node_get(s : CryptosymaesNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_aes_node_set(s : CryptosymaesNode, i : Int, v : Double) -> CryptosymaesNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_node_sum(s : CryptosymaesNode) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_aes_node_mean(s : CryptosymaesNode) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_aes_node_scale(s : CryptosymaesNode, f : Double) -> CryptosymaesNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_node_add(a : CryptosymaesNode, b : CryptosymaesNode) -> CryptosymaesNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_aes_node_copy(s : CryptosymaesNode) -> CryptosymaesNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_node_fill(s : CryptosymaesNode, v : Double) -> CryptosymaesNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_node_min(s : CryptosymaesNode) -> Double { @_common.min(s.data) }

pub fn crypto_sym_aes_node_max(s : CryptosymaesNode) -> Double { @_common.max(s.data) }

pub fn crypto_sym_aes_node_to_string(s : CryptosymaesNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymaesEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_aes_edge_make(size : Int) -> CryptosymaesEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_aes_edge_len(s : CryptosymaesEdge) -> Int { s.size }

pub fn crypto_sym_aes_edge_get(s : CryptosymaesEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_aes_edge_set(s : CryptosymaesEdge, i : Int, v : Double) -> CryptosymaesEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_edge_sum(s : CryptosymaesEdge) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_aes_edge_mean(s : CryptosymaesEdge) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_aes_edge_scale(s : CryptosymaesEdge, f : Double) -> CryptosymaesEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_edge_add(a : CryptosymaesEdge, b : CryptosymaesEdge) -> CryptosymaesEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_aes_edge_copy(s : CryptosymaesEdge) -> CryptosymaesEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_edge_fill(s : CryptosymaesEdge, v : Double) -> CryptosymaesEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_edge_min(s : CryptosymaesEdge) -> Double { @_common.min(s.data) }

pub fn crypto_sym_aes_edge_max(s : CryptosymaesEdge) -> Double { @_common.max(s.data) }

pub fn crypto_sym_aes_edge_to_string(s : CryptosymaesEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymaesPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_aes_path_make(size : Int) -> CryptosymaesPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_aes_path_len(s : CryptosymaesPath) -> Int { s.size }

pub fn crypto_sym_aes_path_get(s : CryptosymaesPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_aes_path_set(s : CryptosymaesPath, i : Int, v : Double) -> CryptosymaesPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_path_sum(s : CryptosymaesPath) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_aes_path_mean(s : CryptosymaesPath) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_aes_path_scale(s : CryptosymaesPath, f : Double) -> CryptosymaesPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_path_add(a : CryptosymaesPath, b : CryptosymaesPath) -> CryptosymaesPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_aes_path_copy(s : CryptosymaesPath) -> CryptosymaesPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_path_fill(s : CryptosymaesPath, v : Double) -> CryptosymaesPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_path_min(s : CryptosymaesPath) -> Double { @_common.min(s.data) }

pub fn crypto_sym_aes_path_max(s : CryptosymaesPath) -> Double { @_common.max(s.data) }

pub fn crypto_sym_aes_path_to_string(s : CryptosymaesPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymaesCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_aes_cluster_make(size : Int) -> CryptosymaesCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_aes_cluster_len(s : CryptosymaesCluster) -> Int { s.size }

pub fn crypto_sym_aes_cluster_get(s : CryptosymaesCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_aes_cluster_set(s : CryptosymaesCluster, i : Int, v : Double) -> CryptosymaesCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_cluster_sum(s : CryptosymaesCluster) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_aes_cluster_mean(s : CryptosymaesCluster) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_aes_cluster_scale(s : CryptosymaesCluster, f : Double) -> CryptosymaesCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_cluster_add(a : CryptosymaesCluster, b : CryptosymaesCluster) -> CryptosymaesCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_aes_cluster_copy(s : CryptosymaesCluster) -> CryptosymaesCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_cluster_fill(s : CryptosymaesCluster, v : Double) -> CryptosymaesCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_cluster_min(s : CryptosymaesCluster) -> Double { @_common.min(s.data) }

pub fn crypto_sym_aes_cluster_max(s : CryptosymaesCluster) -> Double { @_common.max(s.data) }

pub fn crypto_sym_aes_cluster_to_string(s : CryptosymaesCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymaesModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_aes_model_make(size : Int) -> CryptosymaesModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_aes_model_len(s : CryptosymaesModel) -> Int { s.size }

pub fn crypto_sym_aes_model_get(s : CryptosymaesModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_aes_model_set(s : CryptosymaesModel, i : Int, v : Double) -> CryptosymaesModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_model_sum(s : CryptosymaesModel) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_aes_model_mean(s : CryptosymaesModel) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_aes_model_scale(s : CryptosymaesModel, f : Double) -> CryptosymaesModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_model_add(a : CryptosymaesModel, b : CryptosymaesModel) -> CryptosymaesModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_aes_model_copy(s : CryptosymaesModel) -> CryptosymaesModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_model_fill(s : CryptosymaesModel, v : Double) -> CryptosymaesModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_model_min(s : CryptosymaesModel) -> Double { @_common.min(s.data) }

pub fn crypto_sym_aes_model_max(s : CryptosymaesModel) -> Double { @_common.max(s.data) }

pub fn crypto_sym_aes_model_to_string(s : CryptosymaesModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymaesLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_aes_layer_make(size : Int) -> CryptosymaesLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_aes_layer_len(s : CryptosymaesLayer) -> Int { s.size }

pub fn crypto_sym_aes_layer_get(s : CryptosymaesLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_aes_layer_set(s : CryptosymaesLayer, i : Int, v : Double) -> CryptosymaesLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_layer_sum(s : CryptosymaesLayer) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_aes_layer_mean(s : CryptosymaesLayer) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_aes_layer_scale(s : CryptosymaesLayer, f : Double) -> CryptosymaesLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_layer_add(a : CryptosymaesLayer, b : CryptosymaesLayer) -> CryptosymaesLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_aes_layer_copy(s : CryptosymaesLayer) -> CryptosymaesLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_layer_fill(s : CryptosymaesLayer, v : Double) -> CryptosymaesLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_layer_min(s : CryptosymaesLayer) -> Double { @_common.min(s.data) }

pub fn crypto_sym_aes_layer_max(s : CryptosymaesLayer) -> Double { @_common.max(s.data) }

pub fn crypto_sym_aes_layer_to_string(s : CryptosymaesLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymaesBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_aes_buffer_make(size : Int) -> CryptosymaesBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_aes_buffer_len(s : CryptosymaesBuffer) -> Int { s.size }

pub fn crypto_sym_aes_buffer_get(s : CryptosymaesBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_aes_buffer_set(s : CryptosymaesBuffer, i : Int, v : Double) -> CryptosymaesBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_buffer_sum(s : CryptosymaesBuffer) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_aes_buffer_mean(s : CryptosymaesBuffer) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_aes_buffer_scale(s : CryptosymaesBuffer, f : Double) -> CryptosymaesBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_buffer_add(a : CryptosymaesBuffer, b : CryptosymaesBuffer) -> CryptosymaesBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_aes_buffer_copy(s : CryptosymaesBuffer) -> CryptosymaesBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_buffer_fill(s : CryptosymaesBuffer, v : Double) -> CryptosymaesBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_buffer_min(s : CryptosymaesBuffer) -> Double { @_common.min(s.data) }

pub fn crypto_sym_aes_buffer_max(s : CryptosymaesBuffer) -> Double { @_common.max(s.data) }

pub fn crypto_sym_aes_buffer_to_string(s : CryptosymaesBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymaesCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_aes_cursor_make(size : Int) -> CryptosymaesCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_aes_cursor_len(s : CryptosymaesCursor) -> Int { s.size }

pub fn crypto_sym_aes_cursor_get(s : CryptosymaesCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_aes_cursor_set(s : CryptosymaesCursor, i : Int, v : Double) -> CryptosymaesCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_cursor_sum(s : CryptosymaesCursor) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_aes_cursor_mean(s : CryptosymaesCursor) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_aes_cursor_scale(s : CryptosymaesCursor, f : Double) -> CryptosymaesCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_cursor_add(a : CryptosymaesCursor, b : CryptosymaesCursor) -> CryptosymaesCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_aes_cursor_copy(s : CryptosymaesCursor) -> CryptosymaesCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_cursor_fill(s : CryptosymaesCursor, v : Double) -> CryptosymaesCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_cursor_min(s : CryptosymaesCursor) -> Double { @_common.min(s.data) }

pub fn crypto_sym_aes_cursor_max(s : CryptosymaesCursor) -> Double { @_common.max(s.data) }

pub fn crypto_sym_aes_cursor_to_string(s : CryptosymaesCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymaesView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_aes_view_make(size : Int) -> CryptosymaesView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_aes_view_len(s : CryptosymaesView) -> Int { s.size }

pub fn crypto_sym_aes_view_get(s : CryptosymaesView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_aes_view_set(s : CryptosymaesView, i : Int, v : Double) -> CryptosymaesView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_view_sum(s : CryptosymaesView) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_aes_view_mean(s : CryptosymaesView) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_aes_view_scale(s : CryptosymaesView, f : Double) -> CryptosymaesView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_view_add(a : CryptosymaesView, b : CryptosymaesView) -> CryptosymaesView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_aes_view_copy(s : CryptosymaesView) -> CryptosymaesView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_view_fill(s : CryptosymaesView, v : Double) -> CryptosymaesView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_view_min(s : CryptosymaesView) -> Double { @_common.min(s.data) }

pub fn crypto_sym_aes_view_max(s : CryptosymaesView) -> Double { @_common.max(s.data) }

pub fn crypto_sym_aes_view_to_string(s : CryptosymaesView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymaesRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_aes_range_make(size : Int) -> CryptosymaesRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_aes_range_len(s : CryptosymaesRange) -> Int { s.size }

pub fn crypto_sym_aes_range_get(s : CryptosymaesRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_aes_range_set(s : CryptosymaesRange, i : Int, v : Double) -> CryptosymaesRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_range_sum(s : CryptosymaesRange) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_aes_range_mean(s : CryptosymaesRange) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_aes_range_scale(s : CryptosymaesRange, f : Double) -> CryptosymaesRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_range_add(a : CryptosymaesRange, b : CryptosymaesRange) -> CryptosymaesRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_aes_range_copy(s : CryptosymaesRange) -> CryptosymaesRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_range_fill(s : CryptosymaesRange, v : Double) -> CryptosymaesRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_range_min(s : CryptosymaesRange) -> Double { @_common.min(s.data) }

pub fn crypto_sym_aes_range_max(s : CryptosymaesRange) -> Double { @_common.max(s.data) }

pub fn crypto_sym_aes_range_to_string(s : CryptosymaesRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymaesSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_aes_slice_make(size : Int) -> CryptosymaesSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_aes_slice_len(s : CryptosymaesSlice) -> Int { s.size }

pub fn crypto_sym_aes_slice_get(s : CryptosymaesSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_aes_slice_set(s : CryptosymaesSlice, i : Int, v : Double) -> CryptosymaesSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_slice_sum(s : CryptosymaesSlice) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_aes_slice_mean(s : CryptosymaesSlice) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_aes_slice_scale(s : CryptosymaesSlice, f : Double) -> CryptosymaesSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_slice_add(a : CryptosymaesSlice, b : CryptosymaesSlice) -> CryptosymaesSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_aes_slice_copy(s : CryptosymaesSlice) -> CryptosymaesSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_slice_fill(s : CryptosymaesSlice, v : Double) -> CryptosymaesSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_aes_slice_min(s : CryptosymaesSlice) -> Double { @_common.min(s.data) }

pub fn crypto_sym_aes_slice_max(s : CryptosymaesSlice) -> Double { @_common.max(s.data) }

pub fn crypto_sym_aes_slice_to_string(s : CryptosymaesSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

