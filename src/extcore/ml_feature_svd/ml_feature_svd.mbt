///===
/// extcore/ml_feature_svd

pub(all) struct MlfeaturesvdPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_feature_svd_make_point(x : Double, y : Double) -> MlfeaturesvdPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_feature_svd_make_point3(x : Double, y : Double, z : Double) -> MlfeaturesvdPoint {
  { x, y, z, label: 0 }
}

pub fn MlfeaturesvdPoint::x(self : MlfeaturesvdPoint) -> Double { self.x }

pub fn MlfeaturesvdPoint::y(self : MlfeaturesvdPoint) -> Double { self.y }

pub fn MlfeaturesvdPoint::z(self : MlfeaturesvdPoint) -> Double { self.z }

pub fn MlfeaturesvdPoint::label(self : MlfeaturesvdPoint) -> Int { self.label }

pub fn MlfeaturesvdPoint::dist(self : MlfeaturesvdPoint, other : MlfeaturesvdPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlfeaturesvdPoint::add(self : MlfeaturesvdPoint, other : MlfeaturesvdPoint) -> MlfeaturesvdPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlfeaturesvdPoint::sub(self : MlfeaturesvdPoint, other : MlfeaturesvdPoint) -> MlfeaturesvdPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlfeaturesvdPoint::scale(self : MlfeaturesvdPoint, s : Double) -> MlfeaturesvdPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlfeaturesvdPoint::dot(self : MlfeaturesvdPoint, other : MlfeaturesvdPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlfeaturesvdPoint::cross(self : MlfeaturesvdPoint, other : MlfeaturesvdPoint) -> MlfeaturesvdPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlfeaturesvdPoint::norm(self : MlfeaturesvdPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlfeaturesvdPoint::normalize(self : MlfeaturesvdPoint) -> MlfeaturesvdPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlfeaturesvdPoint::negate(self : MlfeaturesvdPoint) -> MlfeaturesvdPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlfeaturesvdPoint::mid(self : MlfeaturesvdPoint, other : MlfeaturesvdPoint) -> MlfeaturesvdPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlfeaturesvdPoint::lerp(self : MlfeaturesvdPoint, other : MlfeaturesvdPoint, t : Double) -> MlfeaturesvdPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlfeaturesvdPoint::to_string(self : MlfeaturesvdPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlfeaturesvdSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_feature_svd_make_series(vals : Array[Double], name : String) -> MlfeaturesvdSeries {
  { vals, name, meta: 0 }
}

pub fn MlfeaturesvdSeries::len(self : MlfeaturesvdSeries) -> Int { self.vals.length() }

pub fn MlfeaturesvdSeries::sum(self : MlfeaturesvdSeries) -> Double { @_common.sum(self.vals) }

pub fn MlfeaturesvdSeries::mean(self : MlfeaturesvdSeries) -> Double { @_common.mean(self.vals) }

pub fn MlfeaturesvdSeries::min(self : MlfeaturesvdSeries) -> Double { @_common.min(self.vals) }

pub fn MlfeaturesvdSeries::max(self : MlfeaturesvdSeries) -> Double { @_common.max(self.vals) }

pub fn MlfeaturesvdSeries::range(self : MlfeaturesvdSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlfeaturesvdSeries::variance(self : MlfeaturesvdSeries) -> Double { @_common.variance(self.vals) }

pub fn MlfeaturesvdSeries::std(self : MlfeaturesvdSeries) -> Double { @_common.std(self.vals) }

pub fn MlfeaturesvdSeries::median(self : MlfeaturesvdSeries) -> Double { @_common.median(self.vals) }

pub fn MlfeaturesvdSeries::scale(self : MlfeaturesvdSeries, f : Double) -> MlfeaturesvdSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlfeaturesvdSeries::add(self : MlfeaturesvdSeries, other : MlfeaturesvdSeries) -> MlfeaturesvdSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlfeaturesvdSeries::sub(self : MlfeaturesvdSeries, other : MlfeaturesvdSeries) -> MlfeaturesvdSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlfeaturesvdSeries::normalize(self : MlfeaturesvdSeries) -> MlfeaturesvdSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlfeaturesvdSeries::cumsum(self : MlfeaturesvdSeries) -> MlfeaturesvdSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlfeaturesvdSeries::to_string(self : MlfeaturesvdSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlfeaturesvdMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_feature_svd_make_matrix(rows : Int, cols : Int, val : Double) -> MlfeaturesvdMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_feature_svd_matrix_identity(n : Int) -> MlfeaturesvdMatrix {
  let m = ml_feature_svd_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlfeaturesvdMatrix::get(self : MlfeaturesvdMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlfeaturesvdMatrix::transpose(self : MlfeaturesvdMatrix) -> MlfeaturesvdMatrix {
  let result = ml_feature_svd_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlfeaturesvdMatrix::add(self : MlfeaturesvdMatrix, other : MlfeaturesvdMatrix) -> MlfeaturesvdMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_feature_svd_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlfeaturesvdMatrix::scale(self : MlfeaturesvdMatrix, s : Double) -> MlfeaturesvdMatrix {
  let result = ml_feature_svd_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlfeaturesvdMatrix::multiply(self : MlfeaturesvdMatrix, other : MlfeaturesvdMatrix) -> MlfeaturesvdMatrix {
  if self.cols != other.rows { return ml_feature_svd_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_feature_svd_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlfeaturesvdMatrix::trace(self : MlfeaturesvdMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlfeaturesvdMatrix::det(self : MlfeaturesvdMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlfeaturesvdMatrix::norm(self : MlfeaturesvdMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlfeaturesvdMatrix::to_string(self : MlfeaturesvdMatrix) -> String {
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

pub(all) struct MlfeaturesvdVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_feature_svd_make_vector(comps : Array[Double]) -> MlfeaturesvdVector {
  { comps, dim: comps.length() }
}

pub fn ml_feature_svd_vector_zero(dim : Int) -> MlfeaturesvdVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlfeaturesvdVector::add(self : MlfeaturesvdVector, other : MlfeaturesvdVector) -> MlfeaturesvdVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlfeaturesvdVector::sub(self : MlfeaturesvdVector, other : MlfeaturesvdVector) -> MlfeaturesvdVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlfeaturesvdVector::scale(self : MlfeaturesvdVector, s : Double) -> MlfeaturesvdVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlfeaturesvdVector::dot(self : MlfeaturesvdVector, other : MlfeaturesvdVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlfeaturesvdVector::norm(self : MlfeaturesvdVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlfeaturesvdVector::normalize(self : MlfeaturesvdVector) -> MlfeaturesvdVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlfeaturesvdVector::dist(self : MlfeaturesvdVector, other : MlfeaturesvdVector) -> Double {
  self.sub(other).norm()
}

pub fn MlfeaturesvdVector::to_string(self : MlfeaturesvdVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_feature_svd_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_feature_svd_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_feature_svd_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_feature_svd_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_feature_svd_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_feature_svd_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_feature_svd_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_feature_svd_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_feature_svd_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_feature_svd_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_feature_svd_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_feature_svd_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_feature_svd_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_feature_svd_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_feature_svd_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_feature_svd_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_feature_svd_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_feature_svd_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_feature_svd_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_feature_svd_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_feature_svd_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_feature_svd_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_feature_svd_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_feature_svd_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_feature_svd_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_feature_svd_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_feature_svd_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_feature_svd_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_feature_svd_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlfeaturesvdFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_svd_frame_make(size : Int) -> MlfeaturesvdFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_svd_frame_len(s : MlfeaturesvdFrame) -> Int { s.size }

pub fn ml_feature_svd_frame_get(s : MlfeaturesvdFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_svd_frame_set(s : MlfeaturesvdFrame, i : Int, v : Double) -> MlfeaturesvdFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_frame_sum(s : MlfeaturesvdFrame) -> Double { @_common.sum(s.data) }

pub fn ml_feature_svd_frame_mean(s : MlfeaturesvdFrame) -> Double { @_common.mean(s.data) }

pub fn ml_feature_svd_frame_scale(s : MlfeaturesvdFrame, f : Double) -> MlfeaturesvdFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_frame_add(a : MlfeaturesvdFrame, b : MlfeaturesvdFrame) -> MlfeaturesvdFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_svd_frame_copy(s : MlfeaturesvdFrame) -> MlfeaturesvdFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_frame_fill(s : MlfeaturesvdFrame, v : Double) -> MlfeaturesvdFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_frame_min(s : MlfeaturesvdFrame) -> Double { @_common.min(s.data) }

pub fn ml_feature_svd_frame_max(s : MlfeaturesvdFrame) -> Double { @_common.max(s.data) }

pub fn ml_feature_svd_frame_to_string(s : MlfeaturesvdFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturesvdTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_svd_table_make(size : Int) -> MlfeaturesvdTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_svd_table_len(s : MlfeaturesvdTable) -> Int { s.size }

pub fn ml_feature_svd_table_get(s : MlfeaturesvdTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_svd_table_set(s : MlfeaturesvdTable, i : Int, v : Double) -> MlfeaturesvdTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_table_sum(s : MlfeaturesvdTable) -> Double { @_common.sum(s.data) }

pub fn ml_feature_svd_table_mean(s : MlfeaturesvdTable) -> Double { @_common.mean(s.data) }

pub fn ml_feature_svd_table_scale(s : MlfeaturesvdTable, f : Double) -> MlfeaturesvdTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_table_add(a : MlfeaturesvdTable, b : MlfeaturesvdTable) -> MlfeaturesvdTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_svd_table_copy(s : MlfeaturesvdTable) -> MlfeaturesvdTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_table_fill(s : MlfeaturesvdTable, v : Double) -> MlfeaturesvdTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_table_min(s : MlfeaturesvdTable) -> Double { @_common.min(s.data) }

pub fn ml_feature_svd_table_max(s : MlfeaturesvdTable) -> Double { @_common.max(s.data) }

pub fn ml_feature_svd_table_to_string(s : MlfeaturesvdTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturesvdGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_svd_graphn_make(size : Int) -> MlfeaturesvdGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_svd_graphn_len(s : MlfeaturesvdGraphN) -> Int { s.size }

pub fn ml_feature_svd_graphn_get(s : MlfeaturesvdGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_svd_graphn_set(s : MlfeaturesvdGraphN, i : Int, v : Double) -> MlfeaturesvdGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_graphn_sum(s : MlfeaturesvdGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_feature_svd_graphn_mean(s : MlfeaturesvdGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_feature_svd_graphn_scale(s : MlfeaturesvdGraphN, f : Double) -> MlfeaturesvdGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_graphn_add(a : MlfeaturesvdGraphN, b : MlfeaturesvdGraphN) -> MlfeaturesvdGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_svd_graphn_copy(s : MlfeaturesvdGraphN) -> MlfeaturesvdGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_graphn_fill(s : MlfeaturesvdGraphN, v : Double) -> MlfeaturesvdGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_graphn_min(s : MlfeaturesvdGraphN) -> Double { @_common.min(s.data) }

pub fn ml_feature_svd_graphn_max(s : MlfeaturesvdGraphN) -> Double { @_common.max(s.data) }

pub fn ml_feature_svd_graphn_to_string(s : MlfeaturesvdGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturesvdNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_svd_node_make(size : Int) -> MlfeaturesvdNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_svd_node_len(s : MlfeaturesvdNode) -> Int { s.size }

pub fn ml_feature_svd_node_get(s : MlfeaturesvdNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_svd_node_set(s : MlfeaturesvdNode, i : Int, v : Double) -> MlfeaturesvdNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_node_sum(s : MlfeaturesvdNode) -> Double { @_common.sum(s.data) }

pub fn ml_feature_svd_node_mean(s : MlfeaturesvdNode) -> Double { @_common.mean(s.data) }

pub fn ml_feature_svd_node_scale(s : MlfeaturesvdNode, f : Double) -> MlfeaturesvdNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_node_add(a : MlfeaturesvdNode, b : MlfeaturesvdNode) -> MlfeaturesvdNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_svd_node_copy(s : MlfeaturesvdNode) -> MlfeaturesvdNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_node_fill(s : MlfeaturesvdNode, v : Double) -> MlfeaturesvdNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_node_min(s : MlfeaturesvdNode) -> Double { @_common.min(s.data) }

pub fn ml_feature_svd_node_max(s : MlfeaturesvdNode) -> Double { @_common.max(s.data) }

pub fn ml_feature_svd_node_to_string(s : MlfeaturesvdNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturesvdEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_svd_edge_make(size : Int) -> MlfeaturesvdEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_svd_edge_len(s : MlfeaturesvdEdge) -> Int { s.size }

pub fn ml_feature_svd_edge_get(s : MlfeaturesvdEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_svd_edge_set(s : MlfeaturesvdEdge, i : Int, v : Double) -> MlfeaturesvdEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_edge_sum(s : MlfeaturesvdEdge) -> Double { @_common.sum(s.data) }

pub fn ml_feature_svd_edge_mean(s : MlfeaturesvdEdge) -> Double { @_common.mean(s.data) }

pub fn ml_feature_svd_edge_scale(s : MlfeaturesvdEdge, f : Double) -> MlfeaturesvdEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_edge_add(a : MlfeaturesvdEdge, b : MlfeaturesvdEdge) -> MlfeaturesvdEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_svd_edge_copy(s : MlfeaturesvdEdge) -> MlfeaturesvdEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_edge_fill(s : MlfeaturesvdEdge, v : Double) -> MlfeaturesvdEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_edge_min(s : MlfeaturesvdEdge) -> Double { @_common.min(s.data) }

pub fn ml_feature_svd_edge_max(s : MlfeaturesvdEdge) -> Double { @_common.max(s.data) }

pub fn ml_feature_svd_edge_to_string(s : MlfeaturesvdEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturesvdPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_svd_path_make(size : Int) -> MlfeaturesvdPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_svd_path_len(s : MlfeaturesvdPath) -> Int { s.size }

pub fn ml_feature_svd_path_get(s : MlfeaturesvdPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_svd_path_set(s : MlfeaturesvdPath, i : Int, v : Double) -> MlfeaturesvdPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_path_sum(s : MlfeaturesvdPath) -> Double { @_common.sum(s.data) }

pub fn ml_feature_svd_path_mean(s : MlfeaturesvdPath) -> Double { @_common.mean(s.data) }

pub fn ml_feature_svd_path_scale(s : MlfeaturesvdPath, f : Double) -> MlfeaturesvdPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_path_add(a : MlfeaturesvdPath, b : MlfeaturesvdPath) -> MlfeaturesvdPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_svd_path_copy(s : MlfeaturesvdPath) -> MlfeaturesvdPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_path_fill(s : MlfeaturesvdPath, v : Double) -> MlfeaturesvdPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_path_min(s : MlfeaturesvdPath) -> Double { @_common.min(s.data) }

pub fn ml_feature_svd_path_max(s : MlfeaturesvdPath) -> Double { @_common.max(s.data) }

pub fn ml_feature_svd_path_to_string(s : MlfeaturesvdPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturesvdCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_svd_cluster_make(size : Int) -> MlfeaturesvdCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_svd_cluster_len(s : MlfeaturesvdCluster) -> Int { s.size }

pub fn ml_feature_svd_cluster_get(s : MlfeaturesvdCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_svd_cluster_set(s : MlfeaturesvdCluster, i : Int, v : Double) -> MlfeaturesvdCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_cluster_sum(s : MlfeaturesvdCluster) -> Double { @_common.sum(s.data) }

pub fn ml_feature_svd_cluster_mean(s : MlfeaturesvdCluster) -> Double { @_common.mean(s.data) }

pub fn ml_feature_svd_cluster_scale(s : MlfeaturesvdCluster, f : Double) -> MlfeaturesvdCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_cluster_add(a : MlfeaturesvdCluster, b : MlfeaturesvdCluster) -> MlfeaturesvdCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_svd_cluster_copy(s : MlfeaturesvdCluster) -> MlfeaturesvdCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_cluster_fill(s : MlfeaturesvdCluster, v : Double) -> MlfeaturesvdCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_cluster_min(s : MlfeaturesvdCluster) -> Double { @_common.min(s.data) }

pub fn ml_feature_svd_cluster_max(s : MlfeaturesvdCluster) -> Double { @_common.max(s.data) }

pub fn ml_feature_svd_cluster_to_string(s : MlfeaturesvdCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturesvdModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_svd_model_make(size : Int) -> MlfeaturesvdModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_svd_model_len(s : MlfeaturesvdModel) -> Int { s.size }

pub fn ml_feature_svd_model_get(s : MlfeaturesvdModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_svd_model_set(s : MlfeaturesvdModel, i : Int, v : Double) -> MlfeaturesvdModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_model_sum(s : MlfeaturesvdModel) -> Double { @_common.sum(s.data) }

pub fn ml_feature_svd_model_mean(s : MlfeaturesvdModel) -> Double { @_common.mean(s.data) }

pub fn ml_feature_svd_model_scale(s : MlfeaturesvdModel, f : Double) -> MlfeaturesvdModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_model_add(a : MlfeaturesvdModel, b : MlfeaturesvdModel) -> MlfeaturesvdModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_svd_model_copy(s : MlfeaturesvdModel) -> MlfeaturesvdModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_model_fill(s : MlfeaturesvdModel, v : Double) -> MlfeaturesvdModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_model_min(s : MlfeaturesvdModel) -> Double { @_common.min(s.data) }

pub fn ml_feature_svd_model_max(s : MlfeaturesvdModel) -> Double { @_common.max(s.data) }

pub fn ml_feature_svd_model_to_string(s : MlfeaturesvdModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturesvdLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_svd_layer_make(size : Int) -> MlfeaturesvdLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_svd_layer_len(s : MlfeaturesvdLayer) -> Int { s.size }

pub fn ml_feature_svd_layer_get(s : MlfeaturesvdLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_svd_layer_set(s : MlfeaturesvdLayer, i : Int, v : Double) -> MlfeaturesvdLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_layer_sum(s : MlfeaturesvdLayer) -> Double { @_common.sum(s.data) }

pub fn ml_feature_svd_layer_mean(s : MlfeaturesvdLayer) -> Double { @_common.mean(s.data) }

pub fn ml_feature_svd_layer_scale(s : MlfeaturesvdLayer, f : Double) -> MlfeaturesvdLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_layer_add(a : MlfeaturesvdLayer, b : MlfeaturesvdLayer) -> MlfeaturesvdLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_svd_layer_copy(s : MlfeaturesvdLayer) -> MlfeaturesvdLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_layer_fill(s : MlfeaturesvdLayer, v : Double) -> MlfeaturesvdLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_layer_min(s : MlfeaturesvdLayer) -> Double { @_common.min(s.data) }

pub fn ml_feature_svd_layer_max(s : MlfeaturesvdLayer) -> Double { @_common.max(s.data) }

pub fn ml_feature_svd_layer_to_string(s : MlfeaturesvdLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturesvdBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_svd_buffer_make(size : Int) -> MlfeaturesvdBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_svd_buffer_len(s : MlfeaturesvdBuffer) -> Int { s.size }

pub fn ml_feature_svd_buffer_get(s : MlfeaturesvdBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_svd_buffer_set(s : MlfeaturesvdBuffer, i : Int, v : Double) -> MlfeaturesvdBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_buffer_sum(s : MlfeaturesvdBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_feature_svd_buffer_mean(s : MlfeaturesvdBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_feature_svd_buffer_scale(s : MlfeaturesvdBuffer, f : Double) -> MlfeaturesvdBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_buffer_add(a : MlfeaturesvdBuffer, b : MlfeaturesvdBuffer) -> MlfeaturesvdBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_svd_buffer_copy(s : MlfeaturesvdBuffer) -> MlfeaturesvdBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_buffer_fill(s : MlfeaturesvdBuffer, v : Double) -> MlfeaturesvdBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_buffer_min(s : MlfeaturesvdBuffer) -> Double { @_common.min(s.data) }

pub fn ml_feature_svd_buffer_max(s : MlfeaturesvdBuffer) -> Double { @_common.max(s.data) }

pub fn ml_feature_svd_buffer_to_string(s : MlfeaturesvdBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturesvdCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_svd_cursor_make(size : Int) -> MlfeaturesvdCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_svd_cursor_len(s : MlfeaturesvdCursor) -> Int { s.size }

pub fn ml_feature_svd_cursor_get(s : MlfeaturesvdCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_svd_cursor_set(s : MlfeaturesvdCursor, i : Int, v : Double) -> MlfeaturesvdCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_cursor_sum(s : MlfeaturesvdCursor) -> Double { @_common.sum(s.data) }

pub fn ml_feature_svd_cursor_mean(s : MlfeaturesvdCursor) -> Double { @_common.mean(s.data) }

pub fn ml_feature_svd_cursor_scale(s : MlfeaturesvdCursor, f : Double) -> MlfeaturesvdCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_cursor_add(a : MlfeaturesvdCursor, b : MlfeaturesvdCursor) -> MlfeaturesvdCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_svd_cursor_copy(s : MlfeaturesvdCursor) -> MlfeaturesvdCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_cursor_fill(s : MlfeaturesvdCursor, v : Double) -> MlfeaturesvdCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_cursor_min(s : MlfeaturesvdCursor) -> Double { @_common.min(s.data) }

pub fn ml_feature_svd_cursor_max(s : MlfeaturesvdCursor) -> Double { @_common.max(s.data) }

pub fn ml_feature_svd_cursor_to_string(s : MlfeaturesvdCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturesvdView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_svd_view_make(size : Int) -> MlfeaturesvdView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_svd_view_len(s : MlfeaturesvdView) -> Int { s.size }

pub fn ml_feature_svd_view_get(s : MlfeaturesvdView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_svd_view_set(s : MlfeaturesvdView, i : Int, v : Double) -> MlfeaturesvdView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_view_sum(s : MlfeaturesvdView) -> Double { @_common.sum(s.data) }

pub fn ml_feature_svd_view_mean(s : MlfeaturesvdView) -> Double { @_common.mean(s.data) }

pub fn ml_feature_svd_view_scale(s : MlfeaturesvdView, f : Double) -> MlfeaturesvdView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_view_add(a : MlfeaturesvdView, b : MlfeaturesvdView) -> MlfeaturesvdView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_svd_view_copy(s : MlfeaturesvdView) -> MlfeaturesvdView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_view_fill(s : MlfeaturesvdView, v : Double) -> MlfeaturesvdView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_view_min(s : MlfeaturesvdView) -> Double { @_common.min(s.data) }

pub fn ml_feature_svd_view_max(s : MlfeaturesvdView) -> Double { @_common.max(s.data) }

pub fn ml_feature_svd_view_to_string(s : MlfeaturesvdView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturesvdRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_svd_range_make(size : Int) -> MlfeaturesvdRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_svd_range_len(s : MlfeaturesvdRange) -> Int { s.size }

pub fn ml_feature_svd_range_get(s : MlfeaturesvdRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_svd_range_set(s : MlfeaturesvdRange, i : Int, v : Double) -> MlfeaturesvdRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_range_sum(s : MlfeaturesvdRange) -> Double { @_common.sum(s.data) }

pub fn ml_feature_svd_range_mean(s : MlfeaturesvdRange) -> Double { @_common.mean(s.data) }

pub fn ml_feature_svd_range_scale(s : MlfeaturesvdRange, f : Double) -> MlfeaturesvdRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_range_add(a : MlfeaturesvdRange, b : MlfeaturesvdRange) -> MlfeaturesvdRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_svd_range_copy(s : MlfeaturesvdRange) -> MlfeaturesvdRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_range_fill(s : MlfeaturesvdRange, v : Double) -> MlfeaturesvdRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_range_min(s : MlfeaturesvdRange) -> Double { @_common.min(s.data) }

pub fn ml_feature_svd_range_max(s : MlfeaturesvdRange) -> Double { @_common.max(s.data) }

pub fn ml_feature_svd_range_to_string(s : MlfeaturesvdRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturesvdSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_svd_slice_make(size : Int) -> MlfeaturesvdSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_svd_slice_len(s : MlfeaturesvdSlice) -> Int { s.size }

pub fn ml_feature_svd_slice_get(s : MlfeaturesvdSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_svd_slice_set(s : MlfeaturesvdSlice, i : Int, v : Double) -> MlfeaturesvdSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_slice_sum(s : MlfeaturesvdSlice) -> Double { @_common.sum(s.data) }

pub fn ml_feature_svd_slice_mean(s : MlfeaturesvdSlice) -> Double { @_common.mean(s.data) }

pub fn ml_feature_svd_slice_scale(s : MlfeaturesvdSlice, f : Double) -> MlfeaturesvdSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_slice_add(a : MlfeaturesvdSlice, b : MlfeaturesvdSlice) -> MlfeaturesvdSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_svd_slice_copy(s : MlfeaturesvdSlice) -> MlfeaturesvdSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_slice_fill(s : MlfeaturesvdSlice, v : Double) -> MlfeaturesvdSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_svd_slice_min(s : MlfeaturesvdSlice) -> Double { @_common.min(s.data) }

pub fn ml_feature_svd_slice_max(s : MlfeaturesvdSlice) -> Double { @_common.max(s.data) }

pub fn ml_feature_svd_slice_to_string(s : MlfeaturesvdSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

