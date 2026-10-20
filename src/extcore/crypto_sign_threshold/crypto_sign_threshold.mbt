///===
/// extcore/crypto_sign_threshold

pub(all) struct CryptosignthresholdPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sign_threshold_make_point(x : Double, y : Double) -> CryptosignthresholdPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sign_threshold_make_point3(x : Double, y : Double, z : Double) -> CryptosignthresholdPoint {
  { x, y, z, label: 0 }
}

pub fn CryptosignthresholdPoint::x(self : CryptosignthresholdPoint) -> Double { self.x }

pub fn CryptosignthresholdPoint::y(self : CryptosignthresholdPoint) -> Double { self.y }

pub fn CryptosignthresholdPoint::z(self : CryptosignthresholdPoint) -> Double { self.z }

pub fn CryptosignthresholdPoint::label(self : CryptosignthresholdPoint) -> Int { self.label }

pub fn CryptosignthresholdPoint::dist(self : CryptosignthresholdPoint, other : CryptosignthresholdPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn CryptosignthresholdPoint::add(self : CryptosignthresholdPoint, other : CryptosignthresholdPoint) -> CryptosignthresholdPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn CryptosignthresholdPoint::sub(self : CryptosignthresholdPoint, other : CryptosignthresholdPoint) -> CryptosignthresholdPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn CryptosignthresholdPoint::scale(self : CryptosignthresholdPoint, s : Double) -> CryptosignthresholdPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn CryptosignthresholdPoint::dot(self : CryptosignthresholdPoint, other : CryptosignthresholdPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn CryptosignthresholdPoint::cross(self : CryptosignthresholdPoint, other : CryptosignthresholdPoint) -> CryptosignthresholdPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn CryptosignthresholdPoint::norm(self : CryptosignthresholdPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn CryptosignthresholdPoint::normalize(self : CryptosignthresholdPoint) -> CryptosignthresholdPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosignthresholdPoint::negate(self : CryptosignthresholdPoint) -> CryptosignthresholdPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn CryptosignthresholdPoint::mid(self : CryptosignthresholdPoint, other : CryptosignthresholdPoint) -> CryptosignthresholdPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn CryptosignthresholdPoint::lerp(self : CryptosignthresholdPoint, other : CryptosignthresholdPoint, t : Double) -> CryptosignthresholdPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn CryptosignthresholdPoint::to_string(self : CryptosignthresholdPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct CryptosignthresholdSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sign_threshold_make_series(vals : Array[Double], name : String) -> CryptosignthresholdSeries {
  { vals, name, meta: 0 }
}

pub fn CryptosignthresholdSeries::len(self : CryptosignthresholdSeries) -> Int { self.vals.length() }

pub fn CryptosignthresholdSeries::sum(self : CryptosignthresholdSeries) -> Double { @_common.sum(self.vals) }

pub fn CryptosignthresholdSeries::mean(self : CryptosignthresholdSeries) -> Double { @_common.mean(self.vals) }

pub fn CryptosignthresholdSeries::min(self : CryptosignthresholdSeries) -> Double { @_common.min(self.vals) }

pub fn CryptosignthresholdSeries::max(self : CryptosignthresholdSeries) -> Double { @_common.max(self.vals) }

pub fn CryptosignthresholdSeries::range(self : CryptosignthresholdSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn CryptosignthresholdSeries::variance(self : CryptosignthresholdSeries) -> Double { @_common.variance(self.vals) }

pub fn CryptosignthresholdSeries::std(self : CryptosignthresholdSeries) -> Double { @_common.std(self.vals) }

pub fn CryptosignthresholdSeries::median(self : CryptosignthresholdSeries) -> Double { @_common.median(self.vals) }

pub fn CryptosignthresholdSeries::scale(self : CryptosignthresholdSeries, f : Double) -> CryptosignthresholdSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn CryptosignthresholdSeries::add(self : CryptosignthresholdSeries, other : CryptosignthresholdSeries) -> CryptosignthresholdSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn CryptosignthresholdSeries::sub(self : CryptosignthresholdSeries, other : CryptosignthresholdSeries) -> CryptosignthresholdSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn CryptosignthresholdSeries::normalize(self : CryptosignthresholdSeries) -> CryptosignthresholdSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn CryptosignthresholdSeries::cumsum(self : CryptosignthresholdSeries) -> CryptosignthresholdSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn CryptosignthresholdSeries::to_string(self : CryptosignthresholdSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosignthresholdMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sign_threshold_make_matrix(rows : Int, cols : Int, val : Double) -> CryptosignthresholdMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_sign_threshold_matrix_identity(n : Int) -> CryptosignthresholdMatrix {
  let m = crypto_sign_threshold_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn CryptosignthresholdMatrix::get(self : CryptosignthresholdMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn CryptosignthresholdMatrix::transpose(self : CryptosignthresholdMatrix) -> CryptosignthresholdMatrix {
  let result = crypto_sign_threshold_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn CryptosignthresholdMatrix::add(self : CryptosignthresholdMatrix, other : CryptosignthresholdMatrix) -> CryptosignthresholdMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_sign_threshold_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn CryptosignthresholdMatrix::scale(self : CryptosignthresholdMatrix, s : Double) -> CryptosignthresholdMatrix {
  let result = crypto_sign_threshold_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn CryptosignthresholdMatrix::multiply(self : CryptosignthresholdMatrix, other : CryptosignthresholdMatrix) -> CryptosignthresholdMatrix {
  if self.cols != other.rows { return crypto_sign_threshold_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_sign_threshold_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn CryptosignthresholdMatrix::trace(self : CryptosignthresholdMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn CryptosignthresholdMatrix::det(self : CryptosignthresholdMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn CryptosignthresholdMatrix::norm(self : CryptosignthresholdMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn CryptosignthresholdMatrix::to_string(self : CryptosignthresholdMatrix) -> String {
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

pub(all) struct CryptosignthresholdVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sign_threshold_make_vector(comps : Array[Double]) -> CryptosignthresholdVector {
  { comps, dim: comps.length() }
}

pub fn crypto_sign_threshold_vector_zero(dim : Int) -> CryptosignthresholdVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn CryptosignthresholdVector::add(self : CryptosignthresholdVector, other : CryptosignthresholdVector) -> CryptosignthresholdVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosignthresholdVector::sub(self : CryptosignthresholdVector, other : CryptosignthresholdVector) -> CryptosignthresholdVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosignthresholdVector::scale(self : CryptosignthresholdVector, s : Double) -> CryptosignthresholdVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn CryptosignthresholdVector::dot(self : CryptosignthresholdVector, other : CryptosignthresholdVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn CryptosignthresholdVector::norm(self : CryptosignthresholdVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn CryptosignthresholdVector::normalize(self : CryptosignthresholdVector) -> CryptosignthresholdVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosignthresholdVector::dist(self : CryptosignthresholdVector, other : CryptosignthresholdVector) -> Double {
  self.sub(other).norm()
}

pub fn CryptosignthresholdVector::to_string(self : CryptosignthresholdVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_sign_threshold_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_sign_threshold_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_sign_threshold_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_sign_threshold_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_sign_threshold_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_sign_threshold_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_sign_threshold_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_sign_threshold_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_sign_threshold_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_sign_threshold_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_sign_threshold_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_sign_threshold_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_sign_threshold_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_sign_threshold_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_sign_threshold_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_sign_threshold_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_sign_threshold_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_sign_threshold_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_sign_threshold_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_sign_threshold_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_sign_threshold_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_sign_threshold_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_sign_threshold_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_sign_threshold_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_sign_threshold_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_sign_threshold_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_sign_threshold_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_sign_threshold_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_sign_threshold_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct CryptosignthresholdFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_threshold_frame_make(size : Int) -> CryptosignthresholdFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_threshold_frame_len(s : CryptosignthresholdFrame) -> Int { s.size }

pub fn crypto_sign_threshold_frame_get(s : CryptosignthresholdFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_threshold_frame_set(s : CryptosignthresholdFrame, i : Int, v : Double) -> CryptosignthresholdFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_frame_sum(s : CryptosignthresholdFrame) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_threshold_frame_mean(s : CryptosignthresholdFrame) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_threshold_frame_scale(s : CryptosignthresholdFrame, f : Double) -> CryptosignthresholdFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_frame_add(a : CryptosignthresholdFrame, b : CryptosignthresholdFrame) -> CryptosignthresholdFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_threshold_frame_copy(s : CryptosignthresholdFrame) -> CryptosignthresholdFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_frame_fill(s : CryptosignthresholdFrame, v : Double) -> CryptosignthresholdFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_frame_min(s : CryptosignthresholdFrame) -> Double { @_common.min(s.data) }

pub fn crypto_sign_threshold_frame_max(s : CryptosignthresholdFrame) -> Double { @_common.max(s.data) }

pub fn crypto_sign_threshold_frame_to_string(s : CryptosignthresholdFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignthresholdTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_threshold_table_make(size : Int) -> CryptosignthresholdTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_threshold_table_len(s : CryptosignthresholdTable) -> Int { s.size }

pub fn crypto_sign_threshold_table_get(s : CryptosignthresholdTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_threshold_table_set(s : CryptosignthresholdTable, i : Int, v : Double) -> CryptosignthresholdTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_table_sum(s : CryptosignthresholdTable) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_threshold_table_mean(s : CryptosignthresholdTable) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_threshold_table_scale(s : CryptosignthresholdTable, f : Double) -> CryptosignthresholdTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_table_add(a : CryptosignthresholdTable, b : CryptosignthresholdTable) -> CryptosignthresholdTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_threshold_table_copy(s : CryptosignthresholdTable) -> CryptosignthresholdTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_table_fill(s : CryptosignthresholdTable, v : Double) -> CryptosignthresholdTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_table_min(s : CryptosignthresholdTable) -> Double { @_common.min(s.data) }

pub fn crypto_sign_threshold_table_max(s : CryptosignthresholdTable) -> Double { @_common.max(s.data) }

pub fn crypto_sign_threshold_table_to_string(s : CryptosignthresholdTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignthresholdGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_threshold_graphn_make(size : Int) -> CryptosignthresholdGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_threshold_graphn_len(s : CryptosignthresholdGraphN) -> Int { s.size }

pub fn crypto_sign_threshold_graphn_get(s : CryptosignthresholdGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_threshold_graphn_set(s : CryptosignthresholdGraphN, i : Int, v : Double) -> CryptosignthresholdGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_graphn_sum(s : CryptosignthresholdGraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_threshold_graphn_mean(s : CryptosignthresholdGraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_threshold_graphn_scale(s : CryptosignthresholdGraphN, f : Double) -> CryptosignthresholdGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_graphn_add(a : CryptosignthresholdGraphN, b : CryptosignthresholdGraphN) -> CryptosignthresholdGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_threshold_graphn_copy(s : CryptosignthresholdGraphN) -> CryptosignthresholdGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_graphn_fill(s : CryptosignthresholdGraphN, v : Double) -> CryptosignthresholdGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_graphn_min(s : CryptosignthresholdGraphN) -> Double { @_common.min(s.data) }

pub fn crypto_sign_threshold_graphn_max(s : CryptosignthresholdGraphN) -> Double { @_common.max(s.data) }

pub fn crypto_sign_threshold_graphn_to_string(s : CryptosignthresholdGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignthresholdNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_threshold_node_make(size : Int) -> CryptosignthresholdNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_threshold_node_len(s : CryptosignthresholdNode) -> Int { s.size }

pub fn crypto_sign_threshold_node_get(s : CryptosignthresholdNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_threshold_node_set(s : CryptosignthresholdNode, i : Int, v : Double) -> CryptosignthresholdNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_node_sum(s : CryptosignthresholdNode) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_threshold_node_mean(s : CryptosignthresholdNode) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_threshold_node_scale(s : CryptosignthresholdNode, f : Double) -> CryptosignthresholdNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_node_add(a : CryptosignthresholdNode, b : CryptosignthresholdNode) -> CryptosignthresholdNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_threshold_node_copy(s : CryptosignthresholdNode) -> CryptosignthresholdNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_node_fill(s : CryptosignthresholdNode, v : Double) -> CryptosignthresholdNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_node_min(s : CryptosignthresholdNode) -> Double { @_common.min(s.data) }

pub fn crypto_sign_threshold_node_max(s : CryptosignthresholdNode) -> Double { @_common.max(s.data) }

pub fn crypto_sign_threshold_node_to_string(s : CryptosignthresholdNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignthresholdEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_threshold_edge_make(size : Int) -> CryptosignthresholdEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_threshold_edge_len(s : CryptosignthresholdEdge) -> Int { s.size }

pub fn crypto_sign_threshold_edge_get(s : CryptosignthresholdEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_threshold_edge_set(s : CryptosignthresholdEdge, i : Int, v : Double) -> CryptosignthresholdEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_edge_sum(s : CryptosignthresholdEdge) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_threshold_edge_mean(s : CryptosignthresholdEdge) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_threshold_edge_scale(s : CryptosignthresholdEdge, f : Double) -> CryptosignthresholdEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_edge_add(a : CryptosignthresholdEdge, b : CryptosignthresholdEdge) -> CryptosignthresholdEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_threshold_edge_copy(s : CryptosignthresholdEdge) -> CryptosignthresholdEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_edge_fill(s : CryptosignthresholdEdge, v : Double) -> CryptosignthresholdEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_edge_min(s : CryptosignthresholdEdge) -> Double { @_common.min(s.data) }

pub fn crypto_sign_threshold_edge_max(s : CryptosignthresholdEdge) -> Double { @_common.max(s.data) }

pub fn crypto_sign_threshold_edge_to_string(s : CryptosignthresholdEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignthresholdPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_threshold_path_make(size : Int) -> CryptosignthresholdPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_threshold_path_len(s : CryptosignthresholdPath) -> Int { s.size }

pub fn crypto_sign_threshold_path_get(s : CryptosignthresholdPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_threshold_path_set(s : CryptosignthresholdPath, i : Int, v : Double) -> CryptosignthresholdPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_path_sum(s : CryptosignthresholdPath) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_threshold_path_mean(s : CryptosignthresholdPath) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_threshold_path_scale(s : CryptosignthresholdPath, f : Double) -> CryptosignthresholdPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_path_add(a : CryptosignthresholdPath, b : CryptosignthresholdPath) -> CryptosignthresholdPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_threshold_path_copy(s : CryptosignthresholdPath) -> CryptosignthresholdPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_path_fill(s : CryptosignthresholdPath, v : Double) -> CryptosignthresholdPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_path_min(s : CryptosignthresholdPath) -> Double { @_common.min(s.data) }

pub fn crypto_sign_threshold_path_max(s : CryptosignthresholdPath) -> Double { @_common.max(s.data) }

pub fn crypto_sign_threshold_path_to_string(s : CryptosignthresholdPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignthresholdCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_threshold_cluster_make(size : Int) -> CryptosignthresholdCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_threshold_cluster_len(s : CryptosignthresholdCluster) -> Int { s.size }

pub fn crypto_sign_threshold_cluster_get(s : CryptosignthresholdCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_threshold_cluster_set(s : CryptosignthresholdCluster, i : Int, v : Double) -> CryptosignthresholdCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_cluster_sum(s : CryptosignthresholdCluster) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_threshold_cluster_mean(s : CryptosignthresholdCluster) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_threshold_cluster_scale(s : CryptosignthresholdCluster, f : Double) -> CryptosignthresholdCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_cluster_add(a : CryptosignthresholdCluster, b : CryptosignthresholdCluster) -> CryptosignthresholdCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_threshold_cluster_copy(s : CryptosignthresholdCluster) -> CryptosignthresholdCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_cluster_fill(s : CryptosignthresholdCluster, v : Double) -> CryptosignthresholdCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_cluster_min(s : CryptosignthresholdCluster) -> Double { @_common.min(s.data) }

pub fn crypto_sign_threshold_cluster_max(s : CryptosignthresholdCluster) -> Double { @_common.max(s.data) }

pub fn crypto_sign_threshold_cluster_to_string(s : CryptosignthresholdCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignthresholdModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_threshold_model_make(size : Int) -> CryptosignthresholdModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_threshold_model_len(s : CryptosignthresholdModel) -> Int { s.size }

pub fn crypto_sign_threshold_model_get(s : CryptosignthresholdModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_threshold_model_set(s : CryptosignthresholdModel, i : Int, v : Double) -> CryptosignthresholdModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_model_sum(s : CryptosignthresholdModel) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_threshold_model_mean(s : CryptosignthresholdModel) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_threshold_model_scale(s : CryptosignthresholdModel, f : Double) -> CryptosignthresholdModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_model_add(a : CryptosignthresholdModel, b : CryptosignthresholdModel) -> CryptosignthresholdModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_threshold_model_copy(s : CryptosignthresholdModel) -> CryptosignthresholdModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_model_fill(s : CryptosignthresholdModel, v : Double) -> CryptosignthresholdModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_model_min(s : CryptosignthresholdModel) -> Double { @_common.min(s.data) }

pub fn crypto_sign_threshold_model_max(s : CryptosignthresholdModel) -> Double { @_common.max(s.data) }

pub fn crypto_sign_threshold_model_to_string(s : CryptosignthresholdModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignthresholdLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_threshold_layer_make(size : Int) -> CryptosignthresholdLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_threshold_layer_len(s : CryptosignthresholdLayer) -> Int { s.size }

pub fn crypto_sign_threshold_layer_get(s : CryptosignthresholdLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_threshold_layer_set(s : CryptosignthresholdLayer, i : Int, v : Double) -> CryptosignthresholdLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_layer_sum(s : CryptosignthresholdLayer) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_threshold_layer_mean(s : CryptosignthresholdLayer) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_threshold_layer_scale(s : CryptosignthresholdLayer, f : Double) -> CryptosignthresholdLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_layer_add(a : CryptosignthresholdLayer, b : CryptosignthresholdLayer) -> CryptosignthresholdLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_threshold_layer_copy(s : CryptosignthresholdLayer) -> CryptosignthresholdLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_layer_fill(s : CryptosignthresholdLayer, v : Double) -> CryptosignthresholdLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_layer_min(s : CryptosignthresholdLayer) -> Double { @_common.min(s.data) }

pub fn crypto_sign_threshold_layer_max(s : CryptosignthresholdLayer) -> Double { @_common.max(s.data) }

pub fn crypto_sign_threshold_layer_to_string(s : CryptosignthresholdLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignthresholdBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_threshold_buffer_make(size : Int) -> CryptosignthresholdBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_threshold_buffer_len(s : CryptosignthresholdBuffer) -> Int { s.size }

pub fn crypto_sign_threshold_buffer_get(s : CryptosignthresholdBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_threshold_buffer_set(s : CryptosignthresholdBuffer, i : Int, v : Double) -> CryptosignthresholdBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_buffer_sum(s : CryptosignthresholdBuffer) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_threshold_buffer_mean(s : CryptosignthresholdBuffer) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_threshold_buffer_scale(s : CryptosignthresholdBuffer, f : Double) -> CryptosignthresholdBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_buffer_add(a : CryptosignthresholdBuffer, b : CryptosignthresholdBuffer) -> CryptosignthresholdBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_threshold_buffer_copy(s : CryptosignthresholdBuffer) -> CryptosignthresholdBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_buffer_fill(s : CryptosignthresholdBuffer, v : Double) -> CryptosignthresholdBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_buffer_min(s : CryptosignthresholdBuffer) -> Double { @_common.min(s.data) }

pub fn crypto_sign_threshold_buffer_max(s : CryptosignthresholdBuffer) -> Double { @_common.max(s.data) }

pub fn crypto_sign_threshold_buffer_to_string(s : CryptosignthresholdBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignthresholdCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_threshold_cursor_make(size : Int) -> CryptosignthresholdCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_threshold_cursor_len(s : CryptosignthresholdCursor) -> Int { s.size }

pub fn crypto_sign_threshold_cursor_get(s : CryptosignthresholdCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_threshold_cursor_set(s : CryptosignthresholdCursor, i : Int, v : Double) -> CryptosignthresholdCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_cursor_sum(s : CryptosignthresholdCursor) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_threshold_cursor_mean(s : CryptosignthresholdCursor) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_threshold_cursor_scale(s : CryptosignthresholdCursor, f : Double) -> CryptosignthresholdCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_cursor_add(a : CryptosignthresholdCursor, b : CryptosignthresholdCursor) -> CryptosignthresholdCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_threshold_cursor_copy(s : CryptosignthresholdCursor) -> CryptosignthresholdCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_cursor_fill(s : CryptosignthresholdCursor, v : Double) -> CryptosignthresholdCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_cursor_min(s : CryptosignthresholdCursor) -> Double { @_common.min(s.data) }

pub fn crypto_sign_threshold_cursor_max(s : CryptosignthresholdCursor) -> Double { @_common.max(s.data) }

pub fn crypto_sign_threshold_cursor_to_string(s : CryptosignthresholdCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignthresholdView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_threshold_view_make(size : Int) -> CryptosignthresholdView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_threshold_view_len(s : CryptosignthresholdView) -> Int { s.size }

pub fn crypto_sign_threshold_view_get(s : CryptosignthresholdView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_threshold_view_set(s : CryptosignthresholdView, i : Int, v : Double) -> CryptosignthresholdView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_view_sum(s : CryptosignthresholdView) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_threshold_view_mean(s : CryptosignthresholdView) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_threshold_view_scale(s : CryptosignthresholdView, f : Double) -> CryptosignthresholdView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_view_add(a : CryptosignthresholdView, b : CryptosignthresholdView) -> CryptosignthresholdView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_threshold_view_copy(s : CryptosignthresholdView) -> CryptosignthresholdView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_view_fill(s : CryptosignthresholdView, v : Double) -> CryptosignthresholdView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_view_min(s : CryptosignthresholdView) -> Double { @_common.min(s.data) }

pub fn crypto_sign_threshold_view_max(s : CryptosignthresholdView) -> Double { @_common.max(s.data) }

pub fn crypto_sign_threshold_view_to_string(s : CryptosignthresholdView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignthresholdRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_threshold_range_make(size : Int) -> CryptosignthresholdRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_threshold_range_len(s : CryptosignthresholdRange) -> Int { s.size }

pub fn crypto_sign_threshold_range_get(s : CryptosignthresholdRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_threshold_range_set(s : CryptosignthresholdRange, i : Int, v : Double) -> CryptosignthresholdRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_range_sum(s : CryptosignthresholdRange) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_threshold_range_mean(s : CryptosignthresholdRange) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_threshold_range_scale(s : CryptosignthresholdRange, f : Double) -> CryptosignthresholdRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_range_add(a : CryptosignthresholdRange, b : CryptosignthresholdRange) -> CryptosignthresholdRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_threshold_range_copy(s : CryptosignthresholdRange) -> CryptosignthresholdRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_range_fill(s : CryptosignthresholdRange, v : Double) -> CryptosignthresholdRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_range_min(s : CryptosignthresholdRange) -> Double { @_common.min(s.data) }

pub fn crypto_sign_threshold_range_max(s : CryptosignthresholdRange) -> Double { @_common.max(s.data) }

pub fn crypto_sign_threshold_range_to_string(s : CryptosignthresholdRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignthresholdSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_threshold_slice_make(size : Int) -> CryptosignthresholdSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_threshold_slice_len(s : CryptosignthresholdSlice) -> Int { s.size }

pub fn crypto_sign_threshold_slice_get(s : CryptosignthresholdSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_threshold_slice_set(s : CryptosignthresholdSlice, i : Int, v : Double) -> CryptosignthresholdSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_slice_sum(s : CryptosignthresholdSlice) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_threshold_slice_mean(s : CryptosignthresholdSlice) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_threshold_slice_scale(s : CryptosignthresholdSlice, f : Double) -> CryptosignthresholdSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_slice_add(a : CryptosignthresholdSlice, b : CryptosignthresholdSlice) -> CryptosignthresholdSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_threshold_slice_copy(s : CryptosignthresholdSlice) -> CryptosignthresholdSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_slice_fill(s : CryptosignthresholdSlice, v : Double) -> CryptosignthresholdSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_threshold_slice_min(s : CryptosignthresholdSlice) -> Double { @_common.min(s.data) }

pub fn crypto_sign_threshold_slice_max(s : CryptosignthresholdSlice) -> Double { @_common.max(s.data) }

pub fn crypto_sign_threshold_slice_to_string(s : CryptosignthresholdSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

