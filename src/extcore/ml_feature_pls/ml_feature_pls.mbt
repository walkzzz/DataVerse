///===
/// extcore/ml_feature_pls

pub(all) struct MlfeatureplsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_feature_pls_make_point(x : Double, y : Double) -> MlfeatureplsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_feature_pls_make_point3(x : Double, y : Double, z : Double) -> MlfeatureplsPoint {
  { x, y, z, label: 0 }
}

pub fn MlfeatureplsPoint::x(self : MlfeatureplsPoint) -> Double { self.x }

pub fn MlfeatureplsPoint::y(self : MlfeatureplsPoint) -> Double { self.y }

pub fn MlfeatureplsPoint::z(self : MlfeatureplsPoint) -> Double { self.z }

pub fn MlfeatureplsPoint::label(self : MlfeatureplsPoint) -> Int { self.label }

pub fn MlfeatureplsPoint::dist(self : MlfeatureplsPoint, other : MlfeatureplsPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlfeatureplsPoint::add(self : MlfeatureplsPoint, other : MlfeatureplsPoint) -> MlfeatureplsPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlfeatureplsPoint::sub(self : MlfeatureplsPoint, other : MlfeatureplsPoint) -> MlfeatureplsPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlfeatureplsPoint::scale(self : MlfeatureplsPoint, s : Double) -> MlfeatureplsPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlfeatureplsPoint::dot(self : MlfeatureplsPoint, other : MlfeatureplsPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlfeatureplsPoint::cross(self : MlfeatureplsPoint, other : MlfeatureplsPoint) -> MlfeatureplsPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlfeatureplsPoint::norm(self : MlfeatureplsPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlfeatureplsPoint::normalize(self : MlfeatureplsPoint) -> MlfeatureplsPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlfeatureplsPoint::negate(self : MlfeatureplsPoint) -> MlfeatureplsPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlfeatureplsPoint::mid(self : MlfeatureplsPoint, other : MlfeatureplsPoint) -> MlfeatureplsPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlfeatureplsPoint::lerp(self : MlfeatureplsPoint, other : MlfeatureplsPoint, t : Double) -> MlfeatureplsPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlfeatureplsPoint::to_string(self : MlfeatureplsPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlfeatureplsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_feature_pls_make_series(vals : Array[Double], name : String) -> MlfeatureplsSeries {
  { vals, name, meta: 0 }
}

pub fn MlfeatureplsSeries::len(self : MlfeatureplsSeries) -> Int { self.vals.length() }

pub fn MlfeatureplsSeries::sum(self : MlfeatureplsSeries) -> Double { @_common.sum(self.vals) }

pub fn MlfeatureplsSeries::mean(self : MlfeatureplsSeries) -> Double { @_common.mean(self.vals) }

pub fn MlfeatureplsSeries::min(self : MlfeatureplsSeries) -> Double { @_common.min(self.vals) }

pub fn MlfeatureplsSeries::max(self : MlfeatureplsSeries) -> Double { @_common.max(self.vals) }

pub fn MlfeatureplsSeries::range(self : MlfeatureplsSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlfeatureplsSeries::variance(self : MlfeatureplsSeries) -> Double { @_common.variance(self.vals) }

pub fn MlfeatureplsSeries::std(self : MlfeatureplsSeries) -> Double { @_common.std(self.vals) }

pub fn MlfeatureplsSeries::median(self : MlfeatureplsSeries) -> Double { @_common.median(self.vals) }

pub fn MlfeatureplsSeries::scale(self : MlfeatureplsSeries, f : Double) -> MlfeatureplsSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlfeatureplsSeries::add(self : MlfeatureplsSeries, other : MlfeatureplsSeries) -> MlfeatureplsSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlfeatureplsSeries::sub(self : MlfeatureplsSeries, other : MlfeatureplsSeries) -> MlfeatureplsSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlfeatureplsSeries::normalize(self : MlfeatureplsSeries) -> MlfeatureplsSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlfeatureplsSeries::cumsum(self : MlfeatureplsSeries) -> MlfeatureplsSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlfeatureplsSeries::to_string(self : MlfeatureplsSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlfeatureplsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_feature_pls_make_matrix(rows : Int, cols : Int, val : Double) -> MlfeatureplsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_feature_pls_matrix_identity(n : Int) -> MlfeatureplsMatrix {
  let m = ml_feature_pls_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlfeatureplsMatrix::get(self : MlfeatureplsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlfeatureplsMatrix::transpose(self : MlfeatureplsMatrix) -> MlfeatureplsMatrix {
  let result = ml_feature_pls_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlfeatureplsMatrix::add(self : MlfeatureplsMatrix, other : MlfeatureplsMatrix) -> MlfeatureplsMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_feature_pls_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlfeatureplsMatrix::scale(self : MlfeatureplsMatrix, s : Double) -> MlfeatureplsMatrix {
  let result = ml_feature_pls_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlfeatureplsMatrix::multiply(self : MlfeatureplsMatrix, other : MlfeatureplsMatrix) -> MlfeatureplsMatrix {
  if self.cols != other.rows { return ml_feature_pls_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_feature_pls_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlfeatureplsMatrix::trace(self : MlfeatureplsMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlfeatureplsMatrix::det(self : MlfeatureplsMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlfeatureplsMatrix::norm(self : MlfeatureplsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlfeatureplsMatrix::to_string(self : MlfeatureplsMatrix) -> String {
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

pub(all) struct MlfeatureplsVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_feature_pls_make_vector(comps : Array[Double]) -> MlfeatureplsVector {
  { comps, dim: comps.length() }
}

pub fn ml_feature_pls_vector_zero(dim : Int) -> MlfeatureplsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlfeatureplsVector::add(self : MlfeatureplsVector, other : MlfeatureplsVector) -> MlfeatureplsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlfeatureplsVector::sub(self : MlfeatureplsVector, other : MlfeatureplsVector) -> MlfeatureplsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlfeatureplsVector::scale(self : MlfeatureplsVector, s : Double) -> MlfeatureplsVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlfeatureplsVector::dot(self : MlfeatureplsVector, other : MlfeatureplsVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlfeatureplsVector::norm(self : MlfeatureplsVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlfeatureplsVector::normalize(self : MlfeatureplsVector) -> MlfeatureplsVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlfeatureplsVector::dist(self : MlfeatureplsVector, other : MlfeatureplsVector) -> Double {
  self.sub(other).norm()
}

pub fn MlfeatureplsVector::to_string(self : MlfeatureplsVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_feature_pls_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_feature_pls_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_feature_pls_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_feature_pls_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_feature_pls_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_feature_pls_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_feature_pls_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_feature_pls_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_feature_pls_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_feature_pls_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_feature_pls_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_feature_pls_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_feature_pls_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_feature_pls_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_feature_pls_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_feature_pls_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_feature_pls_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_feature_pls_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_feature_pls_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_feature_pls_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_feature_pls_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_feature_pls_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_feature_pls_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_feature_pls_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_feature_pls_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_feature_pls_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_feature_pls_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_feature_pls_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_feature_pls_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlfeatureplsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pls_frame_make(size : Int) -> MlfeatureplsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pls_frame_len(s : MlfeatureplsFrame) -> Int { s.size }

pub fn ml_feature_pls_frame_get(s : MlfeatureplsFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pls_frame_set(s : MlfeatureplsFrame, i : Int, v : Double) -> MlfeatureplsFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_frame_sum(s : MlfeatureplsFrame) -> Double { @_common.sum(s.data) }

pub fn ml_feature_pls_frame_mean(s : MlfeatureplsFrame) -> Double { @_common.mean(s.data) }

pub fn ml_feature_pls_frame_scale(s : MlfeatureplsFrame, f : Double) -> MlfeatureplsFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_frame_add(a : MlfeatureplsFrame, b : MlfeatureplsFrame) -> MlfeatureplsFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_pls_frame_copy(s : MlfeatureplsFrame) -> MlfeatureplsFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_frame_fill(s : MlfeatureplsFrame, v : Double) -> MlfeatureplsFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_frame_min(s : MlfeatureplsFrame) -> Double { @_common.min(s.data) }

pub fn ml_feature_pls_frame_max(s : MlfeatureplsFrame) -> Double { @_common.max(s.data) }

pub fn ml_feature_pls_frame_to_string(s : MlfeatureplsFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureplsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pls_table_make(size : Int) -> MlfeatureplsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pls_table_len(s : MlfeatureplsTable) -> Int { s.size }

pub fn ml_feature_pls_table_get(s : MlfeatureplsTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pls_table_set(s : MlfeatureplsTable, i : Int, v : Double) -> MlfeatureplsTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_table_sum(s : MlfeatureplsTable) -> Double { @_common.sum(s.data) }

pub fn ml_feature_pls_table_mean(s : MlfeatureplsTable) -> Double { @_common.mean(s.data) }

pub fn ml_feature_pls_table_scale(s : MlfeatureplsTable, f : Double) -> MlfeatureplsTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_table_add(a : MlfeatureplsTable, b : MlfeatureplsTable) -> MlfeatureplsTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_pls_table_copy(s : MlfeatureplsTable) -> MlfeatureplsTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_table_fill(s : MlfeatureplsTable, v : Double) -> MlfeatureplsTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_table_min(s : MlfeatureplsTable) -> Double { @_common.min(s.data) }

pub fn ml_feature_pls_table_max(s : MlfeatureplsTable) -> Double { @_common.max(s.data) }

pub fn ml_feature_pls_table_to_string(s : MlfeatureplsTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureplsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pls_graphn_make(size : Int) -> MlfeatureplsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pls_graphn_len(s : MlfeatureplsGraphN) -> Int { s.size }

pub fn ml_feature_pls_graphn_get(s : MlfeatureplsGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pls_graphn_set(s : MlfeatureplsGraphN, i : Int, v : Double) -> MlfeatureplsGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_graphn_sum(s : MlfeatureplsGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_feature_pls_graphn_mean(s : MlfeatureplsGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_feature_pls_graphn_scale(s : MlfeatureplsGraphN, f : Double) -> MlfeatureplsGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_graphn_add(a : MlfeatureplsGraphN, b : MlfeatureplsGraphN) -> MlfeatureplsGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_pls_graphn_copy(s : MlfeatureplsGraphN) -> MlfeatureplsGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_graphn_fill(s : MlfeatureplsGraphN, v : Double) -> MlfeatureplsGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_graphn_min(s : MlfeatureplsGraphN) -> Double { @_common.min(s.data) }

pub fn ml_feature_pls_graphn_max(s : MlfeatureplsGraphN) -> Double { @_common.max(s.data) }

pub fn ml_feature_pls_graphn_to_string(s : MlfeatureplsGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureplsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pls_node_make(size : Int) -> MlfeatureplsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pls_node_len(s : MlfeatureplsNode) -> Int { s.size }

pub fn ml_feature_pls_node_get(s : MlfeatureplsNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pls_node_set(s : MlfeatureplsNode, i : Int, v : Double) -> MlfeatureplsNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_node_sum(s : MlfeatureplsNode) -> Double { @_common.sum(s.data) }

pub fn ml_feature_pls_node_mean(s : MlfeatureplsNode) -> Double { @_common.mean(s.data) }

pub fn ml_feature_pls_node_scale(s : MlfeatureplsNode, f : Double) -> MlfeatureplsNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_node_add(a : MlfeatureplsNode, b : MlfeatureplsNode) -> MlfeatureplsNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_pls_node_copy(s : MlfeatureplsNode) -> MlfeatureplsNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_node_fill(s : MlfeatureplsNode, v : Double) -> MlfeatureplsNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_node_min(s : MlfeatureplsNode) -> Double { @_common.min(s.data) }

pub fn ml_feature_pls_node_max(s : MlfeatureplsNode) -> Double { @_common.max(s.data) }

pub fn ml_feature_pls_node_to_string(s : MlfeatureplsNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureplsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pls_edge_make(size : Int) -> MlfeatureplsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pls_edge_len(s : MlfeatureplsEdge) -> Int { s.size }

pub fn ml_feature_pls_edge_get(s : MlfeatureplsEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pls_edge_set(s : MlfeatureplsEdge, i : Int, v : Double) -> MlfeatureplsEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_edge_sum(s : MlfeatureplsEdge) -> Double { @_common.sum(s.data) }

pub fn ml_feature_pls_edge_mean(s : MlfeatureplsEdge) -> Double { @_common.mean(s.data) }

pub fn ml_feature_pls_edge_scale(s : MlfeatureplsEdge, f : Double) -> MlfeatureplsEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_edge_add(a : MlfeatureplsEdge, b : MlfeatureplsEdge) -> MlfeatureplsEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_pls_edge_copy(s : MlfeatureplsEdge) -> MlfeatureplsEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_edge_fill(s : MlfeatureplsEdge, v : Double) -> MlfeatureplsEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_edge_min(s : MlfeatureplsEdge) -> Double { @_common.min(s.data) }

pub fn ml_feature_pls_edge_max(s : MlfeatureplsEdge) -> Double { @_common.max(s.data) }

pub fn ml_feature_pls_edge_to_string(s : MlfeatureplsEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureplsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pls_path_make(size : Int) -> MlfeatureplsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pls_path_len(s : MlfeatureplsPath) -> Int { s.size }

pub fn ml_feature_pls_path_get(s : MlfeatureplsPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pls_path_set(s : MlfeatureplsPath, i : Int, v : Double) -> MlfeatureplsPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_path_sum(s : MlfeatureplsPath) -> Double { @_common.sum(s.data) }

pub fn ml_feature_pls_path_mean(s : MlfeatureplsPath) -> Double { @_common.mean(s.data) }

pub fn ml_feature_pls_path_scale(s : MlfeatureplsPath, f : Double) -> MlfeatureplsPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_path_add(a : MlfeatureplsPath, b : MlfeatureplsPath) -> MlfeatureplsPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_pls_path_copy(s : MlfeatureplsPath) -> MlfeatureplsPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_path_fill(s : MlfeatureplsPath, v : Double) -> MlfeatureplsPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_path_min(s : MlfeatureplsPath) -> Double { @_common.min(s.data) }

pub fn ml_feature_pls_path_max(s : MlfeatureplsPath) -> Double { @_common.max(s.data) }

pub fn ml_feature_pls_path_to_string(s : MlfeatureplsPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureplsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pls_cluster_make(size : Int) -> MlfeatureplsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pls_cluster_len(s : MlfeatureplsCluster) -> Int { s.size }

pub fn ml_feature_pls_cluster_get(s : MlfeatureplsCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pls_cluster_set(s : MlfeatureplsCluster, i : Int, v : Double) -> MlfeatureplsCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_cluster_sum(s : MlfeatureplsCluster) -> Double { @_common.sum(s.data) }

pub fn ml_feature_pls_cluster_mean(s : MlfeatureplsCluster) -> Double { @_common.mean(s.data) }

pub fn ml_feature_pls_cluster_scale(s : MlfeatureplsCluster, f : Double) -> MlfeatureplsCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_cluster_add(a : MlfeatureplsCluster, b : MlfeatureplsCluster) -> MlfeatureplsCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_pls_cluster_copy(s : MlfeatureplsCluster) -> MlfeatureplsCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_cluster_fill(s : MlfeatureplsCluster, v : Double) -> MlfeatureplsCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_cluster_min(s : MlfeatureplsCluster) -> Double { @_common.min(s.data) }

pub fn ml_feature_pls_cluster_max(s : MlfeatureplsCluster) -> Double { @_common.max(s.data) }

pub fn ml_feature_pls_cluster_to_string(s : MlfeatureplsCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureplsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pls_model_make(size : Int) -> MlfeatureplsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pls_model_len(s : MlfeatureplsModel) -> Int { s.size }

pub fn ml_feature_pls_model_get(s : MlfeatureplsModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pls_model_set(s : MlfeatureplsModel, i : Int, v : Double) -> MlfeatureplsModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_model_sum(s : MlfeatureplsModel) -> Double { @_common.sum(s.data) }

pub fn ml_feature_pls_model_mean(s : MlfeatureplsModel) -> Double { @_common.mean(s.data) }

pub fn ml_feature_pls_model_scale(s : MlfeatureplsModel, f : Double) -> MlfeatureplsModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_model_add(a : MlfeatureplsModel, b : MlfeatureplsModel) -> MlfeatureplsModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_pls_model_copy(s : MlfeatureplsModel) -> MlfeatureplsModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_model_fill(s : MlfeatureplsModel, v : Double) -> MlfeatureplsModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_model_min(s : MlfeatureplsModel) -> Double { @_common.min(s.data) }

pub fn ml_feature_pls_model_max(s : MlfeatureplsModel) -> Double { @_common.max(s.data) }

pub fn ml_feature_pls_model_to_string(s : MlfeatureplsModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureplsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pls_layer_make(size : Int) -> MlfeatureplsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pls_layer_len(s : MlfeatureplsLayer) -> Int { s.size }

pub fn ml_feature_pls_layer_get(s : MlfeatureplsLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pls_layer_set(s : MlfeatureplsLayer, i : Int, v : Double) -> MlfeatureplsLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_layer_sum(s : MlfeatureplsLayer) -> Double { @_common.sum(s.data) }

pub fn ml_feature_pls_layer_mean(s : MlfeatureplsLayer) -> Double { @_common.mean(s.data) }

pub fn ml_feature_pls_layer_scale(s : MlfeatureplsLayer, f : Double) -> MlfeatureplsLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_layer_add(a : MlfeatureplsLayer, b : MlfeatureplsLayer) -> MlfeatureplsLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_pls_layer_copy(s : MlfeatureplsLayer) -> MlfeatureplsLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_layer_fill(s : MlfeatureplsLayer, v : Double) -> MlfeatureplsLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_layer_min(s : MlfeatureplsLayer) -> Double { @_common.min(s.data) }

pub fn ml_feature_pls_layer_max(s : MlfeatureplsLayer) -> Double { @_common.max(s.data) }

pub fn ml_feature_pls_layer_to_string(s : MlfeatureplsLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureplsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pls_buffer_make(size : Int) -> MlfeatureplsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pls_buffer_len(s : MlfeatureplsBuffer) -> Int { s.size }

pub fn ml_feature_pls_buffer_get(s : MlfeatureplsBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pls_buffer_set(s : MlfeatureplsBuffer, i : Int, v : Double) -> MlfeatureplsBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_buffer_sum(s : MlfeatureplsBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_feature_pls_buffer_mean(s : MlfeatureplsBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_feature_pls_buffer_scale(s : MlfeatureplsBuffer, f : Double) -> MlfeatureplsBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_buffer_add(a : MlfeatureplsBuffer, b : MlfeatureplsBuffer) -> MlfeatureplsBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_pls_buffer_copy(s : MlfeatureplsBuffer) -> MlfeatureplsBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_buffer_fill(s : MlfeatureplsBuffer, v : Double) -> MlfeatureplsBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_buffer_min(s : MlfeatureplsBuffer) -> Double { @_common.min(s.data) }

pub fn ml_feature_pls_buffer_max(s : MlfeatureplsBuffer) -> Double { @_common.max(s.data) }

pub fn ml_feature_pls_buffer_to_string(s : MlfeatureplsBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureplsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pls_cursor_make(size : Int) -> MlfeatureplsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pls_cursor_len(s : MlfeatureplsCursor) -> Int { s.size }

pub fn ml_feature_pls_cursor_get(s : MlfeatureplsCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pls_cursor_set(s : MlfeatureplsCursor, i : Int, v : Double) -> MlfeatureplsCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_cursor_sum(s : MlfeatureplsCursor) -> Double { @_common.sum(s.data) }

pub fn ml_feature_pls_cursor_mean(s : MlfeatureplsCursor) -> Double { @_common.mean(s.data) }

pub fn ml_feature_pls_cursor_scale(s : MlfeatureplsCursor, f : Double) -> MlfeatureplsCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_cursor_add(a : MlfeatureplsCursor, b : MlfeatureplsCursor) -> MlfeatureplsCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_pls_cursor_copy(s : MlfeatureplsCursor) -> MlfeatureplsCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_cursor_fill(s : MlfeatureplsCursor, v : Double) -> MlfeatureplsCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_cursor_min(s : MlfeatureplsCursor) -> Double { @_common.min(s.data) }

pub fn ml_feature_pls_cursor_max(s : MlfeatureplsCursor) -> Double { @_common.max(s.data) }

pub fn ml_feature_pls_cursor_to_string(s : MlfeatureplsCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureplsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pls_view_make(size : Int) -> MlfeatureplsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pls_view_len(s : MlfeatureplsView) -> Int { s.size }

pub fn ml_feature_pls_view_get(s : MlfeatureplsView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pls_view_set(s : MlfeatureplsView, i : Int, v : Double) -> MlfeatureplsView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_view_sum(s : MlfeatureplsView) -> Double { @_common.sum(s.data) }

pub fn ml_feature_pls_view_mean(s : MlfeatureplsView) -> Double { @_common.mean(s.data) }

pub fn ml_feature_pls_view_scale(s : MlfeatureplsView, f : Double) -> MlfeatureplsView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_view_add(a : MlfeatureplsView, b : MlfeatureplsView) -> MlfeatureplsView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_pls_view_copy(s : MlfeatureplsView) -> MlfeatureplsView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_view_fill(s : MlfeatureplsView, v : Double) -> MlfeatureplsView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_view_min(s : MlfeatureplsView) -> Double { @_common.min(s.data) }

pub fn ml_feature_pls_view_max(s : MlfeatureplsView) -> Double { @_common.max(s.data) }

pub fn ml_feature_pls_view_to_string(s : MlfeatureplsView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureplsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pls_range_make(size : Int) -> MlfeatureplsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pls_range_len(s : MlfeatureplsRange) -> Int { s.size }

pub fn ml_feature_pls_range_get(s : MlfeatureplsRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pls_range_set(s : MlfeatureplsRange, i : Int, v : Double) -> MlfeatureplsRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_range_sum(s : MlfeatureplsRange) -> Double { @_common.sum(s.data) }

pub fn ml_feature_pls_range_mean(s : MlfeatureplsRange) -> Double { @_common.mean(s.data) }

pub fn ml_feature_pls_range_scale(s : MlfeatureplsRange, f : Double) -> MlfeatureplsRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_range_add(a : MlfeatureplsRange, b : MlfeatureplsRange) -> MlfeatureplsRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_pls_range_copy(s : MlfeatureplsRange) -> MlfeatureplsRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_range_fill(s : MlfeatureplsRange, v : Double) -> MlfeatureplsRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_range_min(s : MlfeatureplsRange) -> Double { @_common.min(s.data) }

pub fn ml_feature_pls_range_max(s : MlfeatureplsRange) -> Double { @_common.max(s.data) }

pub fn ml_feature_pls_range_to_string(s : MlfeatureplsRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureplsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pls_slice_make(size : Int) -> MlfeatureplsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pls_slice_len(s : MlfeatureplsSlice) -> Int { s.size }

pub fn ml_feature_pls_slice_get(s : MlfeatureplsSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pls_slice_set(s : MlfeatureplsSlice, i : Int, v : Double) -> MlfeatureplsSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_slice_sum(s : MlfeatureplsSlice) -> Double { @_common.sum(s.data) }

pub fn ml_feature_pls_slice_mean(s : MlfeatureplsSlice) -> Double { @_common.mean(s.data) }

pub fn ml_feature_pls_slice_scale(s : MlfeatureplsSlice, f : Double) -> MlfeatureplsSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_slice_add(a : MlfeatureplsSlice, b : MlfeatureplsSlice) -> MlfeatureplsSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_pls_slice_copy(s : MlfeatureplsSlice) -> MlfeatureplsSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_slice_fill(s : MlfeatureplsSlice, v : Double) -> MlfeatureplsSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_pls_slice_min(s : MlfeatureplsSlice) -> Double { @_common.min(s.data) }

pub fn ml_feature_pls_slice_max(s : MlfeatureplsSlice) -> Double { @_common.max(s.data) }

pub fn ml_feature_pls_slice_to_string(s : MlfeatureplsSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

