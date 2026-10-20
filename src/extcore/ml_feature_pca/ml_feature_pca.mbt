///===
/// extcore/ml_feature_pca

pub(all) struct MlfeaturepcaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_feature_pca_make_point(x : Double, y : Double) -> MlfeaturepcaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_feature_pca_make_point3(x : Double, y : Double, z : Double) -> MlfeaturepcaPoint {
  { x, y, z, label: 0 }
}

pub fn MlfeaturepcaPoint::x(self : MlfeaturepcaPoint) -> Double { self.x }

pub fn MlfeaturepcaPoint::y(self : MlfeaturepcaPoint) -> Double { self.y }

pub fn MlfeaturepcaPoint::z(self : MlfeaturepcaPoint) -> Double { self.z }

pub fn MlfeaturepcaPoint::label(self : MlfeaturepcaPoint) -> Int { self.label }

pub fn MlfeaturepcaPoint::dist(self : MlfeaturepcaPoint, other : MlfeaturepcaPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlfeaturepcaPoint::add(self : MlfeaturepcaPoint, other : MlfeaturepcaPoint) -> MlfeaturepcaPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlfeaturepcaPoint::sub(self : MlfeaturepcaPoint, other : MlfeaturepcaPoint) -> MlfeaturepcaPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlfeaturepcaPoint::scale(self : MlfeaturepcaPoint, s : Double) -> MlfeaturepcaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlfeaturepcaPoint::dot(self : MlfeaturepcaPoint, other : MlfeaturepcaPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlfeaturepcaPoint::cross(self : MlfeaturepcaPoint, other : MlfeaturepcaPoint) -> MlfeaturepcaPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlfeaturepcaPoint::norm(self : MlfeaturepcaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlfeaturepcaPoint::normalize(self : MlfeaturepcaPoint) -> MlfeaturepcaPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlfeaturepcaPoint::negate(self : MlfeaturepcaPoint) -> MlfeaturepcaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlfeaturepcaPoint::mid(self : MlfeaturepcaPoint, other : MlfeaturepcaPoint) -> MlfeaturepcaPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlfeaturepcaPoint::lerp(self : MlfeaturepcaPoint, other : MlfeaturepcaPoint, t : Double) -> MlfeaturepcaPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlfeaturepcaPoint::to_string(self : MlfeaturepcaPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlfeaturepcaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_feature_pca_make_series(vals : Array[Double], name : String) -> MlfeaturepcaSeries {
  { vals, name, meta: 0 }
}

pub fn MlfeaturepcaSeries::len(self : MlfeaturepcaSeries) -> Int { self.vals.length() }

pub fn MlfeaturepcaSeries::sum(self : MlfeaturepcaSeries) -> Double { @_common.sum(self.vals) }

pub fn MlfeaturepcaSeries::mean(self : MlfeaturepcaSeries) -> Double { @_common.mean(self.vals) }

pub fn MlfeaturepcaSeries::min(self : MlfeaturepcaSeries) -> Double { @_common.min(self.vals) }

pub fn MlfeaturepcaSeries::max(self : MlfeaturepcaSeries) -> Double { @_common.max(self.vals) }

pub fn MlfeaturepcaSeries::range(self : MlfeaturepcaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlfeaturepcaSeries::variance(self : MlfeaturepcaSeries) -> Double { @_common.variance(self.vals) }

pub fn MlfeaturepcaSeries::std(self : MlfeaturepcaSeries) -> Double { @_common.std(self.vals) }

pub fn MlfeaturepcaSeries::median(self : MlfeaturepcaSeries) -> Double { @_common.median(self.vals) }

pub fn MlfeaturepcaSeries::scale(self : MlfeaturepcaSeries, f : Double) -> MlfeaturepcaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlfeaturepcaSeries::add(self : MlfeaturepcaSeries, other : MlfeaturepcaSeries) -> MlfeaturepcaSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlfeaturepcaSeries::sub(self : MlfeaturepcaSeries, other : MlfeaturepcaSeries) -> MlfeaturepcaSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlfeaturepcaSeries::normalize(self : MlfeaturepcaSeries) -> MlfeaturepcaSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlfeaturepcaSeries::cumsum(self : MlfeaturepcaSeries) -> MlfeaturepcaSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlfeaturepcaSeries::to_string(self : MlfeaturepcaSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlfeaturepcaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_feature_pca_make_matrix(rows : Int, cols : Int, val : Double) -> MlfeaturepcaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_feature_pca_matrix_identity(n : Int) -> MlfeaturepcaMatrix {
  let m = ml_feature_pca_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlfeaturepcaMatrix::get(self : MlfeaturepcaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlfeaturepcaMatrix::transpose(self : MlfeaturepcaMatrix) -> MlfeaturepcaMatrix {
  let result = ml_feature_pca_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlfeaturepcaMatrix::add(self : MlfeaturepcaMatrix, other : MlfeaturepcaMatrix) -> MlfeaturepcaMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_feature_pca_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlfeaturepcaMatrix::scale(self : MlfeaturepcaMatrix, s : Double) -> MlfeaturepcaMatrix {
  let result = ml_feature_pca_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlfeaturepcaMatrix::multiply(self : MlfeaturepcaMatrix, other : MlfeaturepcaMatrix) -> MlfeaturepcaMatrix {
  if self.cols != other.rows { return ml_feature_pca_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_feature_pca_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlfeaturepcaMatrix::trace(self : MlfeaturepcaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlfeaturepcaMatrix::det(self : MlfeaturepcaMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlfeaturepcaMatrix::norm(self : MlfeaturepcaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlfeaturepcaMatrix::to_string(self : MlfeaturepcaMatrix) -> String {
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

pub(all) struct MlfeaturepcaVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_feature_pca_make_vector(comps : Array[Double]) -> MlfeaturepcaVector {
  { comps, dim: comps.length() }
}

pub fn ml_feature_pca_vector_zero(dim : Int) -> MlfeaturepcaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlfeaturepcaVector::add(self : MlfeaturepcaVector, other : MlfeaturepcaVector) -> MlfeaturepcaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlfeaturepcaVector::sub(self : MlfeaturepcaVector, other : MlfeaturepcaVector) -> MlfeaturepcaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlfeaturepcaVector::scale(self : MlfeaturepcaVector, s : Double) -> MlfeaturepcaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlfeaturepcaVector::dot(self : MlfeaturepcaVector, other : MlfeaturepcaVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlfeaturepcaVector::norm(self : MlfeaturepcaVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlfeaturepcaVector::normalize(self : MlfeaturepcaVector) -> MlfeaturepcaVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlfeaturepcaVector::dist(self : MlfeaturepcaVector, other : MlfeaturepcaVector) -> Double {
  self.sub(other).norm()
}

pub fn MlfeaturepcaVector::to_string(self : MlfeaturepcaVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_feature_pca_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_feature_pca_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_feature_pca_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_feature_pca_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_feature_pca_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_feature_pca_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_feature_pca_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_feature_pca_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_feature_pca_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_feature_pca_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_feature_pca_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_feature_pca_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_feature_pca_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_feature_pca_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_feature_pca_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_feature_pca_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_feature_pca_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_feature_pca_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_feature_pca_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_feature_pca_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_feature_pca_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_feature_pca_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_feature_pca_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_feature_pca_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_feature_pca_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_feature_pca_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_feature_pca_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_feature_pca_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_feature_pca_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlfeaturepcaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_frame_make(size : Int) -> MlfeaturepcaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pca_frame_len(s : MlfeaturepcaFrame) -> Int { s.size }

pub fn ml_feature_pca_frame_get(s : MlfeaturepcaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pca_frame_set(s : MlfeaturepcaFrame, i : Int, v : Double) -> MlfeaturepcaFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_frame_sum(s : MlfeaturepcaFrame) -> Double { @_common.sum(s.data) }

pub fn ml_feature_pca_frame_mean(s : MlfeaturepcaFrame) -> Double { @_common.mean(s.data) }

pub fn ml_feature_pca_frame_scale(s : MlfeaturepcaFrame, f : Double) -> MlfeaturepcaFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_frame_add(a : MlfeaturepcaFrame, b : MlfeaturepcaFrame) -> MlfeaturepcaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_pca_frame_copy(s : MlfeaturepcaFrame) -> MlfeaturepcaFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_frame_fill(s : MlfeaturepcaFrame, v : Double) -> MlfeaturepcaFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_frame_min(s : MlfeaturepcaFrame) -> Double { @_common.min(s.data) }

pub fn ml_feature_pca_frame_max(s : MlfeaturepcaFrame) -> Double { @_common.max(s.data) }

pub fn ml_feature_pca_frame_to_string(s : MlfeaturepcaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_table_make(size : Int) -> MlfeaturepcaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pca_table_len(s : MlfeaturepcaTable) -> Int { s.size }

pub fn ml_feature_pca_table_get(s : MlfeaturepcaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pca_table_set(s : MlfeaturepcaTable, i : Int, v : Double) -> MlfeaturepcaTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_table_sum(s : MlfeaturepcaTable) -> Double { @_common.sum(s.data) }

pub fn ml_feature_pca_table_mean(s : MlfeaturepcaTable) -> Double { @_common.mean(s.data) }

pub fn ml_feature_pca_table_scale(s : MlfeaturepcaTable, f : Double) -> MlfeaturepcaTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_table_add(a : MlfeaturepcaTable, b : MlfeaturepcaTable) -> MlfeaturepcaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_pca_table_copy(s : MlfeaturepcaTable) -> MlfeaturepcaTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_table_fill(s : MlfeaturepcaTable, v : Double) -> MlfeaturepcaTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_table_min(s : MlfeaturepcaTable) -> Double { @_common.min(s.data) }

pub fn ml_feature_pca_table_max(s : MlfeaturepcaTable) -> Double { @_common.max(s.data) }

pub fn ml_feature_pca_table_to_string(s : MlfeaturepcaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_graphn_make(size : Int) -> MlfeaturepcaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pca_graphn_len(s : MlfeaturepcaGraphN) -> Int { s.size }

pub fn ml_feature_pca_graphn_get(s : MlfeaturepcaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pca_graphn_set(s : MlfeaturepcaGraphN, i : Int, v : Double) -> MlfeaturepcaGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_graphn_sum(s : MlfeaturepcaGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_feature_pca_graphn_mean(s : MlfeaturepcaGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_feature_pca_graphn_scale(s : MlfeaturepcaGraphN, f : Double) -> MlfeaturepcaGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_graphn_add(a : MlfeaturepcaGraphN, b : MlfeaturepcaGraphN) -> MlfeaturepcaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_pca_graphn_copy(s : MlfeaturepcaGraphN) -> MlfeaturepcaGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_graphn_fill(s : MlfeaturepcaGraphN, v : Double) -> MlfeaturepcaGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_graphn_min(s : MlfeaturepcaGraphN) -> Double { @_common.min(s.data) }

pub fn ml_feature_pca_graphn_max(s : MlfeaturepcaGraphN) -> Double { @_common.max(s.data) }

pub fn ml_feature_pca_graphn_to_string(s : MlfeaturepcaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_node_make(size : Int) -> MlfeaturepcaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pca_node_len(s : MlfeaturepcaNode) -> Int { s.size }

pub fn ml_feature_pca_node_get(s : MlfeaturepcaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pca_node_set(s : MlfeaturepcaNode, i : Int, v : Double) -> MlfeaturepcaNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_node_sum(s : MlfeaturepcaNode) -> Double { @_common.sum(s.data) }

pub fn ml_feature_pca_node_mean(s : MlfeaturepcaNode) -> Double { @_common.mean(s.data) }

pub fn ml_feature_pca_node_scale(s : MlfeaturepcaNode, f : Double) -> MlfeaturepcaNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_node_add(a : MlfeaturepcaNode, b : MlfeaturepcaNode) -> MlfeaturepcaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_pca_node_copy(s : MlfeaturepcaNode) -> MlfeaturepcaNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_node_fill(s : MlfeaturepcaNode, v : Double) -> MlfeaturepcaNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_node_min(s : MlfeaturepcaNode) -> Double { @_common.min(s.data) }

pub fn ml_feature_pca_node_max(s : MlfeaturepcaNode) -> Double { @_common.max(s.data) }

pub fn ml_feature_pca_node_to_string(s : MlfeaturepcaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_edge_make(size : Int) -> MlfeaturepcaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pca_edge_len(s : MlfeaturepcaEdge) -> Int { s.size }

pub fn ml_feature_pca_edge_get(s : MlfeaturepcaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pca_edge_set(s : MlfeaturepcaEdge, i : Int, v : Double) -> MlfeaturepcaEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_edge_sum(s : MlfeaturepcaEdge) -> Double { @_common.sum(s.data) }

pub fn ml_feature_pca_edge_mean(s : MlfeaturepcaEdge) -> Double { @_common.mean(s.data) }

pub fn ml_feature_pca_edge_scale(s : MlfeaturepcaEdge, f : Double) -> MlfeaturepcaEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_edge_add(a : MlfeaturepcaEdge, b : MlfeaturepcaEdge) -> MlfeaturepcaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_pca_edge_copy(s : MlfeaturepcaEdge) -> MlfeaturepcaEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_edge_fill(s : MlfeaturepcaEdge, v : Double) -> MlfeaturepcaEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_edge_min(s : MlfeaturepcaEdge) -> Double { @_common.min(s.data) }

pub fn ml_feature_pca_edge_max(s : MlfeaturepcaEdge) -> Double { @_common.max(s.data) }

pub fn ml_feature_pca_edge_to_string(s : MlfeaturepcaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_path_make(size : Int) -> MlfeaturepcaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pca_path_len(s : MlfeaturepcaPath) -> Int { s.size }

pub fn ml_feature_pca_path_get(s : MlfeaturepcaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pca_path_set(s : MlfeaturepcaPath, i : Int, v : Double) -> MlfeaturepcaPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_path_sum(s : MlfeaturepcaPath) -> Double { @_common.sum(s.data) }

pub fn ml_feature_pca_path_mean(s : MlfeaturepcaPath) -> Double { @_common.mean(s.data) }

pub fn ml_feature_pca_path_scale(s : MlfeaturepcaPath, f : Double) -> MlfeaturepcaPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_path_add(a : MlfeaturepcaPath, b : MlfeaturepcaPath) -> MlfeaturepcaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_pca_path_copy(s : MlfeaturepcaPath) -> MlfeaturepcaPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_path_fill(s : MlfeaturepcaPath, v : Double) -> MlfeaturepcaPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_path_min(s : MlfeaturepcaPath) -> Double { @_common.min(s.data) }

pub fn ml_feature_pca_path_max(s : MlfeaturepcaPath) -> Double { @_common.max(s.data) }

pub fn ml_feature_pca_path_to_string(s : MlfeaturepcaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_cluster_make(size : Int) -> MlfeaturepcaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pca_cluster_len(s : MlfeaturepcaCluster) -> Int { s.size }

pub fn ml_feature_pca_cluster_get(s : MlfeaturepcaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pca_cluster_set(s : MlfeaturepcaCluster, i : Int, v : Double) -> MlfeaturepcaCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_cluster_sum(s : MlfeaturepcaCluster) -> Double { @_common.sum(s.data) }

pub fn ml_feature_pca_cluster_mean(s : MlfeaturepcaCluster) -> Double { @_common.mean(s.data) }

pub fn ml_feature_pca_cluster_scale(s : MlfeaturepcaCluster, f : Double) -> MlfeaturepcaCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_cluster_add(a : MlfeaturepcaCluster, b : MlfeaturepcaCluster) -> MlfeaturepcaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_pca_cluster_copy(s : MlfeaturepcaCluster) -> MlfeaturepcaCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_cluster_fill(s : MlfeaturepcaCluster, v : Double) -> MlfeaturepcaCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_cluster_min(s : MlfeaturepcaCluster) -> Double { @_common.min(s.data) }

pub fn ml_feature_pca_cluster_max(s : MlfeaturepcaCluster) -> Double { @_common.max(s.data) }

pub fn ml_feature_pca_cluster_to_string(s : MlfeaturepcaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_model_make(size : Int) -> MlfeaturepcaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pca_model_len(s : MlfeaturepcaModel) -> Int { s.size }

pub fn ml_feature_pca_model_get(s : MlfeaturepcaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pca_model_set(s : MlfeaturepcaModel, i : Int, v : Double) -> MlfeaturepcaModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_model_sum(s : MlfeaturepcaModel) -> Double { @_common.sum(s.data) }

pub fn ml_feature_pca_model_mean(s : MlfeaturepcaModel) -> Double { @_common.mean(s.data) }

pub fn ml_feature_pca_model_scale(s : MlfeaturepcaModel, f : Double) -> MlfeaturepcaModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_model_add(a : MlfeaturepcaModel, b : MlfeaturepcaModel) -> MlfeaturepcaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_pca_model_copy(s : MlfeaturepcaModel) -> MlfeaturepcaModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_model_fill(s : MlfeaturepcaModel, v : Double) -> MlfeaturepcaModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_model_min(s : MlfeaturepcaModel) -> Double { @_common.min(s.data) }

pub fn ml_feature_pca_model_max(s : MlfeaturepcaModel) -> Double { @_common.max(s.data) }

pub fn ml_feature_pca_model_to_string(s : MlfeaturepcaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_layer_make(size : Int) -> MlfeaturepcaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pca_layer_len(s : MlfeaturepcaLayer) -> Int { s.size }

pub fn ml_feature_pca_layer_get(s : MlfeaturepcaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pca_layer_set(s : MlfeaturepcaLayer, i : Int, v : Double) -> MlfeaturepcaLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_layer_sum(s : MlfeaturepcaLayer) -> Double { @_common.sum(s.data) }

pub fn ml_feature_pca_layer_mean(s : MlfeaturepcaLayer) -> Double { @_common.mean(s.data) }

pub fn ml_feature_pca_layer_scale(s : MlfeaturepcaLayer, f : Double) -> MlfeaturepcaLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_layer_add(a : MlfeaturepcaLayer, b : MlfeaturepcaLayer) -> MlfeaturepcaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_pca_layer_copy(s : MlfeaturepcaLayer) -> MlfeaturepcaLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_layer_fill(s : MlfeaturepcaLayer, v : Double) -> MlfeaturepcaLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_layer_min(s : MlfeaturepcaLayer) -> Double { @_common.min(s.data) }

pub fn ml_feature_pca_layer_max(s : MlfeaturepcaLayer) -> Double { @_common.max(s.data) }

pub fn ml_feature_pca_layer_to_string(s : MlfeaturepcaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_buffer_make(size : Int) -> MlfeaturepcaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pca_buffer_len(s : MlfeaturepcaBuffer) -> Int { s.size }

pub fn ml_feature_pca_buffer_get(s : MlfeaturepcaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pca_buffer_set(s : MlfeaturepcaBuffer, i : Int, v : Double) -> MlfeaturepcaBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_buffer_sum(s : MlfeaturepcaBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_feature_pca_buffer_mean(s : MlfeaturepcaBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_feature_pca_buffer_scale(s : MlfeaturepcaBuffer, f : Double) -> MlfeaturepcaBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_buffer_add(a : MlfeaturepcaBuffer, b : MlfeaturepcaBuffer) -> MlfeaturepcaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_pca_buffer_copy(s : MlfeaturepcaBuffer) -> MlfeaturepcaBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_buffer_fill(s : MlfeaturepcaBuffer, v : Double) -> MlfeaturepcaBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_buffer_min(s : MlfeaturepcaBuffer) -> Double { @_common.min(s.data) }

pub fn ml_feature_pca_buffer_max(s : MlfeaturepcaBuffer) -> Double { @_common.max(s.data) }

pub fn ml_feature_pca_buffer_to_string(s : MlfeaturepcaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_cursor_make(size : Int) -> MlfeaturepcaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pca_cursor_len(s : MlfeaturepcaCursor) -> Int { s.size }

pub fn ml_feature_pca_cursor_get(s : MlfeaturepcaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pca_cursor_set(s : MlfeaturepcaCursor, i : Int, v : Double) -> MlfeaturepcaCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_cursor_sum(s : MlfeaturepcaCursor) -> Double { @_common.sum(s.data) }

pub fn ml_feature_pca_cursor_mean(s : MlfeaturepcaCursor) -> Double { @_common.mean(s.data) }

pub fn ml_feature_pca_cursor_scale(s : MlfeaturepcaCursor, f : Double) -> MlfeaturepcaCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_cursor_add(a : MlfeaturepcaCursor, b : MlfeaturepcaCursor) -> MlfeaturepcaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_pca_cursor_copy(s : MlfeaturepcaCursor) -> MlfeaturepcaCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_cursor_fill(s : MlfeaturepcaCursor, v : Double) -> MlfeaturepcaCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_cursor_min(s : MlfeaturepcaCursor) -> Double { @_common.min(s.data) }

pub fn ml_feature_pca_cursor_max(s : MlfeaturepcaCursor) -> Double { @_common.max(s.data) }

pub fn ml_feature_pca_cursor_to_string(s : MlfeaturepcaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_view_make(size : Int) -> MlfeaturepcaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pca_view_len(s : MlfeaturepcaView) -> Int { s.size }

pub fn ml_feature_pca_view_get(s : MlfeaturepcaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pca_view_set(s : MlfeaturepcaView, i : Int, v : Double) -> MlfeaturepcaView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_view_sum(s : MlfeaturepcaView) -> Double { @_common.sum(s.data) }

pub fn ml_feature_pca_view_mean(s : MlfeaturepcaView) -> Double { @_common.mean(s.data) }

pub fn ml_feature_pca_view_scale(s : MlfeaturepcaView, f : Double) -> MlfeaturepcaView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_view_add(a : MlfeaturepcaView, b : MlfeaturepcaView) -> MlfeaturepcaView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_pca_view_copy(s : MlfeaturepcaView) -> MlfeaturepcaView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_view_fill(s : MlfeaturepcaView, v : Double) -> MlfeaturepcaView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_view_min(s : MlfeaturepcaView) -> Double { @_common.min(s.data) }

pub fn ml_feature_pca_view_max(s : MlfeaturepcaView) -> Double { @_common.max(s.data) }

pub fn ml_feature_pca_view_to_string(s : MlfeaturepcaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_range_make(size : Int) -> MlfeaturepcaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pca_range_len(s : MlfeaturepcaRange) -> Int { s.size }

pub fn ml_feature_pca_range_get(s : MlfeaturepcaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pca_range_set(s : MlfeaturepcaRange, i : Int, v : Double) -> MlfeaturepcaRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_range_sum(s : MlfeaturepcaRange) -> Double { @_common.sum(s.data) }

pub fn ml_feature_pca_range_mean(s : MlfeaturepcaRange) -> Double { @_common.mean(s.data) }

pub fn ml_feature_pca_range_scale(s : MlfeaturepcaRange, f : Double) -> MlfeaturepcaRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_range_add(a : MlfeaturepcaRange, b : MlfeaturepcaRange) -> MlfeaturepcaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_pca_range_copy(s : MlfeaturepcaRange) -> MlfeaturepcaRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_range_fill(s : MlfeaturepcaRange, v : Double) -> MlfeaturepcaRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_range_min(s : MlfeaturepcaRange) -> Double { @_common.min(s.data) }

pub fn ml_feature_pca_range_max(s : MlfeaturepcaRange) -> Double { @_common.max(s.data) }

pub fn ml_feature_pca_range_to_string(s : MlfeaturepcaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_slice_make(size : Int) -> MlfeaturepcaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pca_slice_len(s : MlfeaturepcaSlice) -> Int { s.size }

pub fn ml_feature_pca_slice_get(s : MlfeaturepcaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pca_slice_set(s : MlfeaturepcaSlice, i : Int, v : Double) -> MlfeaturepcaSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_slice_sum(s : MlfeaturepcaSlice) -> Double { @_common.sum(s.data) }

pub fn ml_feature_pca_slice_mean(s : MlfeaturepcaSlice) -> Double { @_common.mean(s.data) }

pub fn ml_feature_pca_slice_scale(s : MlfeaturepcaSlice, f : Double) -> MlfeaturepcaSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_slice_add(a : MlfeaturepcaSlice, b : MlfeaturepcaSlice) -> MlfeaturepcaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_pca_slice_copy(s : MlfeaturepcaSlice) -> MlfeaturepcaSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_slice_fill(s : MlfeaturepcaSlice, v : Double) -> MlfeaturepcaSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_pca_slice_min(s : MlfeaturepcaSlice) -> Double { @_common.min(s.data) }

pub fn ml_feature_pca_slice_max(s : MlfeaturepcaSlice) -> Double { @_common.max(s.data) }

pub fn ml_feature_pca_slice_to_string(s : MlfeaturepcaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

