///===
/// extcore/ml_feature_nmf

pub(all) struct MlfeaturenmfPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_feature_nmf_make_point(x : Double, y : Double) -> MlfeaturenmfPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_feature_nmf_make_point3(x : Double, y : Double, z : Double) -> MlfeaturenmfPoint {
  { x, y, z, label: 0 }
}

pub fn MlfeaturenmfPoint::x(self : MlfeaturenmfPoint) -> Double { self.x }

pub fn MlfeaturenmfPoint::y(self : MlfeaturenmfPoint) -> Double { self.y }

pub fn MlfeaturenmfPoint::z(self : MlfeaturenmfPoint) -> Double { self.z }

pub fn MlfeaturenmfPoint::label(self : MlfeaturenmfPoint) -> Int { self.label }

pub fn MlfeaturenmfPoint::dist(self : MlfeaturenmfPoint, other : MlfeaturenmfPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlfeaturenmfPoint::add(self : MlfeaturenmfPoint, other : MlfeaturenmfPoint) -> MlfeaturenmfPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlfeaturenmfPoint::sub(self : MlfeaturenmfPoint, other : MlfeaturenmfPoint) -> MlfeaturenmfPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlfeaturenmfPoint::scale(self : MlfeaturenmfPoint, s : Double) -> MlfeaturenmfPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlfeaturenmfPoint::dot(self : MlfeaturenmfPoint, other : MlfeaturenmfPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlfeaturenmfPoint::cross(self : MlfeaturenmfPoint, other : MlfeaturenmfPoint) -> MlfeaturenmfPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlfeaturenmfPoint::norm(self : MlfeaturenmfPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlfeaturenmfPoint::normalize(self : MlfeaturenmfPoint) -> MlfeaturenmfPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlfeaturenmfPoint::negate(self : MlfeaturenmfPoint) -> MlfeaturenmfPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlfeaturenmfPoint::mid(self : MlfeaturenmfPoint, other : MlfeaturenmfPoint) -> MlfeaturenmfPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlfeaturenmfPoint::lerp(self : MlfeaturenmfPoint, other : MlfeaturenmfPoint, t : Double) -> MlfeaturenmfPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlfeaturenmfPoint::to_string(self : MlfeaturenmfPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlfeaturenmfSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_feature_nmf_make_series(vals : Array[Double], name : String) -> MlfeaturenmfSeries {
  { vals, name, meta: 0 }
}

pub fn MlfeaturenmfSeries::len(self : MlfeaturenmfSeries) -> Int { self.vals.length() }

pub fn MlfeaturenmfSeries::sum(self : MlfeaturenmfSeries) -> Double { @_common.sum(self.vals) }

pub fn MlfeaturenmfSeries::mean(self : MlfeaturenmfSeries) -> Double { @_common.mean(self.vals) }

pub fn MlfeaturenmfSeries::min(self : MlfeaturenmfSeries) -> Double { @_common.min(self.vals) }

pub fn MlfeaturenmfSeries::max(self : MlfeaturenmfSeries) -> Double { @_common.max(self.vals) }

pub fn MlfeaturenmfSeries::range(self : MlfeaturenmfSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlfeaturenmfSeries::variance(self : MlfeaturenmfSeries) -> Double { @_common.variance(self.vals) }

pub fn MlfeaturenmfSeries::std(self : MlfeaturenmfSeries) -> Double { @_common.std(self.vals) }

pub fn MlfeaturenmfSeries::median(self : MlfeaturenmfSeries) -> Double { @_common.median(self.vals) }

pub fn MlfeaturenmfSeries::scale(self : MlfeaturenmfSeries, f : Double) -> MlfeaturenmfSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlfeaturenmfSeries::add(self : MlfeaturenmfSeries, other : MlfeaturenmfSeries) -> MlfeaturenmfSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlfeaturenmfSeries::sub(self : MlfeaturenmfSeries, other : MlfeaturenmfSeries) -> MlfeaturenmfSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlfeaturenmfSeries::normalize(self : MlfeaturenmfSeries) -> MlfeaturenmfSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlfeaturenmfSeries::cumsum(self : MlfeaturenmfSeries) -> MlfeaturenmfSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlfeaturenmfSeries::to_string(self : MlfeaturenmfSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlfeaturenmfMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_feature_nmf_make_matrix(rows : Int, cols : Int, val : Double) -> MlfeaturenmfMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_feature_nmf_matrix_identity(n : Int) -> MlfeaturenmfMatrix {
  let m = ml_feature_nmf_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlfeaturenmfMatrix::get(self : MlfeaturenmfMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlfeaturenmfMatrix::transpose(self : MlfeaturenmfMatrix) -> MlfeaturenmfMatrix {
  let result = ml_feature_nmf_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlfeaturenmfMatrix::add(self : MlfeaturenmfMatrix, other : MlfeaturenmfMatrix) -> MlfeaturenmfMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_feature_nmf_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlfeaturenmfMatrix::scale(self : MlfeaturenmfMatrix, s : Double) -> MlfeaturenmfMatrix {
  let result = ml_feature_nmf_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlfeaturenmfMatrix::multiply(self : MlfeaturenmfMatrix, other : MlfeaturenmfMatrix) -> MlfeaturenmfMatrix {
  if self.cols != other.rows { return ml_feature_nmf_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_feature_nmf_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlfeaturenmfMatrix::trace(self : MlfeaturenmfMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlfeaturenmfMatrix::det(self : MlfeaturenmfMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlfeaturenmfMatrix::norm(self : MlfeaturenmfMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlfeaturenmfMatrix::to_string(self : MlfeaturenmfMatrix) -> String {
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

pub(all) struct MlfeaturenmfVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_feature_nmf_make_vector(comps : Array[Double]) -> MlfeaturenmfVector {
  { comps, dim: comps.length() }
}

pub fn ml_feature_nmf_vector_zero(dim : Int) -> MlfeaturenmfVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlfeaturenmfVector::add(self : MlfeaturenmfVector, other : MlfeaturenmfVector) -> MlfeaturenmfVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlfeaturenmfVector::sub(self : MlfeaturenmfVector, other : MlfeaturenmfVector) -> MlfeaturenmfVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlfeaturenmfVector::scale(self : MlfeaturenmfVector, s : Double) -> MlfeaturenmfVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlfeaturenmfVector::dot(self : MlfeaturenmfVector, other : MlfeaturenmfVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlfeaturenmfVector::norm(self : MlfeaturenmfVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlfeaturenmfVector::normalize(self : MlfeaturenmfVector) -> MlfeaturenmfVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlfeaturenmfVector::dist(self : MlfeaturenmfVector, other : MlfeaturenmfVector) -> Double {
  self.sub(other).norm()
}

pub fn MlfeaturenmfVector::to_string(self : MlfeaturenmfVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_feature_nmf_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_feature_nmf_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_feature_nmf_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_feature_nmf_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_feature_nmf_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_feature_nmf_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_feature_nmf_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_feature_nmf_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_feature_nmf_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_feature_nmf_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_feature_nmf_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_feature_nmf_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_feature_nmf_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_feature_nmf_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_feature_nmf_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_feature_nmf_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_feature_nmf_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_feature_nmf_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_feature_nmf_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_feature_nmf_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_feature_nmf_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_feature_nmf_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_feature_nmf_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_feature_nmf_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_feature_nmf_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_feature_nmf_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_feature_nmf_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_feature_nmf_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_feature_nmf_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlfeaturenmfFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_nmf_frame_make(size : Int) -> MlfeaturenmfFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_nmf_frame_len(s : MlfeaturenmfFrame) -> Int { s.size }

pub fn ml_feature_nmf_frame_get(s : MlfeaturenmfFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_nmf_frame_set(s : MlfeaturenmfFrame, i : Int, v : Double) -> MlfeaturenmfFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_frame_sum(s : MlfeaturenmfFrame) -> Double { @_common.sum(s.data) }

pub fn ml_feature_nmf_frame_mean(s : MlfeaturenmfFrame) -> Double { @_common.mean(s.data) }

pub fn ml_feature_nmf_frame_scale(s : MlfeaturenmfFrame, f : Double) -> MlfeaturenmfFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_frame_add(a : MlfeaturenmfFrame, b : MlfeaturenmfFrame) -> MlfeaturenmfFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_nmf_frame_copy(s : MlfeaturenmfFrame) -> MlfeaturenmfFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_frame_fill(s : MlfeaturenmfFrame, v : Double) -> MlfeaturenmfFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_frame_min(s : MlfeaturenmfFrame) -> Double { @_common.min(s.data) }

pub fn ml_feature_nmf_frame_max(s : MlfeaturenmfFrame) -> Double { @_common.max(s.data) }

pub fn ml_feature_nmf_frame_to_string(s : MlfeaturenmfFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturenmfTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_nmf_table_make(size : Int) -> MlfeaturenmfTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_nmf_table_len(s : MlfeaturenmfTable) -> Int { s.size }

pub fn ml_feature_nmf_table_get(s : MlfeaturenmfTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_nmf_table_set(s : MlfeaturenmfTable, i : Int, v : Double) -> MlfeaturenmfTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_table_sum(s : MlfeaturenmfTable) -> Double { @_common.sum(s.data) }

pub fn ml_feature_nmf_table_mean(s : MlfeaturenmfTable) -> Double { @_common.mean(s.data) }

pub fn ml_feature_nmf_table_scale(s : MlfeaturenmfTable, f : Double) -> MlfeaturenmfTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_table_add(a : MlfeaturenmfTable, b : MlfeaturenmfTable) -> MlfeaturenmfTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_nmf_table_copy(s : MlfeaturenmfTable) -> MlfeaturenmfTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_table_fill(s : MlfeaturenmfTable, v : Double) -> MlfeaturenmfTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_table_min(s : MlfeaturenmfTable) -> Double { @_common.min(s.data) }

pub fn ml_feature_nmf_table_max(s : MlfeaturenmfTable) -> Double { @_common.max(s.data) }

pub fn ml_feature_nmf_table_to_string(s : MlfeaturenmfTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturenmfGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_nmf_graphn_make(size : Int) -> MlfeaturenmfGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_nmf_graphn_len(s : MlfeaturenmfGraphN) -> Int { s.size }

pub fn ml_feature_nmf_graphn_get(s : MlfeaturenmfGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_nmf_graphn_set(s : MlfeaturenmfGraphN, i : Int, v : Double) -> MlfeaturenmfGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_graphn_sum(s : MlfeaturenmfGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_feature_nmf_graphn_mean(s : MlfeaturenmfGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_feature_nmf_graphn_scale(s : MlfeaturenmfGraphN, f : Double) -> MlfeaturenmfGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_graphn_add(a : MlfeaturenmfGraphN, b : MlfeaturenmfGraphN) -> MlfeaturenmfGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_nmf_graphn_copy(s : MlfeaturenmfGraphN) -> MlfeaturenmfGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_graphn_fill(s : MlfeaturenmfGraphN, v : Double) -> MlfeaturenmfGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_graphn_min(s : MlfeaturenmfGraphN) -> Double { @_common.min(s.data) }

pub fn ml_feature_nmf_graphn_max(s : MlfeaturenmfGraphN) -> Double { @_common.max(s.data) }

pub fn ml_feature_nmf_graphn_to_string(s : MlfeaturenmfGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturenmfNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_nmf_node_make(size : Int) -> MlfeaturenmfNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_nmf_node_len(s : MlfeaturenmfNode) -> Int { s.size }

pub fn ml_feature_nmf_node_get(s : MlfeaturenmfNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_nmf_node_set(s : MlfeaturenmfNode, i : Int, v : Double) -> MlfeaturenmfNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_node_sum(s : MlfeaturenmfNode) -> Double { @_common.sum(s.data) }

pub fn ml_feature_nmf_node_mean(s : MlfeaturenmfNode) -> Double { @_common.mean(s.data) }

pub fn ml_feature_nmf_node_scale(s : MlfeaturenmfNode, f : Double) -> MlfeaturenmfNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_node_add(a : MlfeaturenmfNode, b : MlfeaturenmfNode) -> MlfeaturenmfNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_nmf_node_copy(s : MlfeaturenmfNode) -> MlfeaturenmfNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_node_fill(s : MlfeaturenmfNode, v : Double) -> MlfeaturenmfNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_node_min(s : MlfeaturenmfNode) -> Double { @_common.min(s.data) }

pub fn ml_feature_nmf_node_max(s : MlfeaturenmfNode) -> Double { @_common.max(s.data) }

pub fn ml_feature_nmf_node_to_string(s : MlfeaturenmfNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturenmfEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_nmf_edge_make(size : Int) -> MlfeaturenmfEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_nmf_edge_len(s : MlfeaturenmfEdge) -> Int { s.size }

pub fn ml_feature_nmf_edge_get(s : MlfeaturenmfEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_nmf_edge_set(s : MlfeaturenmfEdge, i : Int, v : Double) -> MlfeaturenmfEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_edge_sum(s : MlfeaturenmfEdge) -> Double { @_common.sum(s.data) }

pub fn ml_feature_nmf_edge_mean(s : MlfeaturenmfEdge) -> Double { @_common.mean(s.data) }

pub fn ml_feature_nmf_edge_scale(s : MlfeaturenmfEdge, f : Double) -> MlfeaturenmfEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_edge_add(a : MlfeaturenmfEdge, b : MlfeaturenmfEdge) -> MlfeaturenmfEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_nmf_edge_copy(s : MlfeaturenmfEdge) -> MlfeaturenmfEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_edge_fill(s : MlfeaturenmfEdge, v : Double) -> MlfeaturenmfEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_edge_min(s : MlfeaturenmfEdge) -> Double { @_common.min(s.data) }

pub fn ml_feature_nmf_edge_max(s : MlfeaturenmfEdge) -> Double { @_common.max(s.data) }

pub fn ml_feature_nmf_edge_to_string(s : MlfeaturenmfEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturenmfPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_nmf_path_make(size : Int) -> MlfeaturenmfPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_nmf_path_len(s : MlfeaturenmfPath) -> Int { s.size }

pub fn ml_feature_nmf_path_get(s : MlfeaturenmfPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_nmf_path_set(s : MlfeaturenmfPath, i : Int, v : Double) -> MlfeaturenmfPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_path_sum(s : MlfeaturenmfPath) -> Double { @_common.sum(s.data) }

pub fn ml_feature_nmf_path_mean(s : MlfeaturenmfPath) -> Double { @_common.mean(s.data) }

pub fn ml_feature_nmf_path_scale(s : MlfeaturenmfPath, f : Double) -> MlfeaturenmfPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_path_add(a : MlfeaturenmfPath, b : MlfeaturenmfPath) -> MlfeaturenmfPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_nmf_path_copy(s : MlfeaturenmfPath) -> MlfeaturenmfPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_path_fill(s : MlfeaturenmfPath, v : Double) -> MlfeaturenmfPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_path_min(s : MlfeaturenmfPath) -> Double { @_common.min(s.data) }

pub fn ml_feature_nmf_path_max(s : MlfeaturenmfPath) -> Double { @_common.max(s.data) }

pub fn ml_feature_nmf_path_to_string(s : MlfeaturenmfPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturenmfCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_nmf_cluster_make(size : Int) -> MlfeaturenmfCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_nmf_cluster_len(s : MlfeaturenmfCluster) -> Int { s.size }

pub fn ml_feature_nmf_cluster_get(s : MlfeaturenmfCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_nmf_cluster_set(s : MlfeaturenmfCluster, i : Int, v : Double) -> MlfeaturenmfCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_cluster_sum(s : MlfeaturenmfCluster) -> Double { @_common.sum(s.data) }

pub fn ml_feature_nmf_cluster_mean(s : MlfeaturenmfCluster) -> Double { @_common.mean(s.data) }

pub fn ml_feature_nmf_cluster_scale(s : MlfeaturenmfCluster, f : Double) -> MlfeaturenmfCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_cluster_add(a : MlfeaturenmfCluster, b : MlfeaturenmfCluster) -> MlfeaturenmfCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_nmf_cluster_copy(s : MlfeaturenmfCluster) -> MlfeaturenmfCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_cluster_fill(s : MlfeaturenmfCluster, v : Double) -> MlfeaturenmfCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_cluster_min(s : MlfeaturenmfCluster) -> Double { @_common.min(s.data) }

pub fn ml_feature_nmf_cluster_max(s : MlfeaturenmfCluster) -> Double { @_common.max(s.data) }

pub fn ml_feature_nmf_cluster_to_string(s : MlfeaturenmfCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturenmfModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_nmf_model_make(size : Int) -> MlfeaturenmfModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_nmf_model_len(s : MlfeaturenmfModel) -> Int { s.size }

pub fn ml_feature_nmf_model_get(s : MlfeaturenmfModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_nmf_model_set(s : MlfeaturenmfModel, i : Int, v : Double) -> MlfeaturenmfModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_model_sum(s : MlfeaturenmfModel) -> Double { @_common.sum(s.data) }

pub fn ml_feature_nmf_model_mean(s : MlfeaturenmfModel) -> Double { @_common.mean(s.data) }

pub fn ml_feature_nmf_model_scale(s : MlfeaturenmfModel, f : Double) -> MlfeaturenmfModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_model_add(a : MlfeaturenmfModel, b : MlfeaturenmfModel) -> MlfeaturenmfModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_nmf_model_copy(s : MlfeaturenmfModel) -> MlfeaturenmfModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_model_fill(s : MlfeaturenmfModel, v : Double) -> MlfeaturenmfModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_model_min(s : MlfeaturenmfModel) -> Double { @_common.min(s.data) }

pub fn ml_feature_nmf_model_max(s : MlfeaturenmfModel) -> Double { @_common.max(s.data) }

pub fn ml_feature_nmf_model_to_string(s : MlfeaturenmfModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturenmfLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_nmf_layer_make(size : Int) -> MlfeaturenmfLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_nmf_layer_len(s : MlfeaturenmfLayer) -> Int { s.size }

pub fn ml_feature_nmf_layer_get(s : MlfeaturenmfLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_nmf_layer_set(s : MlfeaturenmfLayer, i : Int, v : Double) -> MlfeaturenmfLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_layer_sum(s : MlfeaturenmfLayer) -> Double { @_common.sum(s.data) }

pub fn ml_feature_nmf_layer_mean(s : MlfeaturenmfLayer) -> Double { @_common.mean(s.data) }

pub fn ml_feature_nmf_layer_scale(s : MlfeaturenmfLayer, f : Double) -> MlfeaturenmfLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_layer_add(a : MlfeaturenmfLayer, b : MlfeaturenmfLayer) -> MlfeaturenmfLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_nmf_layer_copy(s : MlfeaturenmfLayer) -> MlfeaturenmfLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_layer_fill(s : MlfeaturenmfLayer, v : Double) -> MlfeaturenmfLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_layer_min(s : MlfeaturenmfLayer) -> Double { @_common.min(s.data) }

pub fn ml_feature_nmf_layer_max(s : MlfeaturenmfLayer) -> Double { @_common.max(s.data) }

pub fn ml_feature_nmf_layer_to_string(s : MlfeaturenmfLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturenmfBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_nmf_buffer_make(size : Int) -> MlfeaturenmfBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_nmf_buffer_len(s : MlfeaturenmfBuffer) -> Int { s.size }

pub fn ml_feature_nmf_buffer_get(s : MlfeaturenmfBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_nmf_buffer_set(s : MlfeaturenmfBuffer, i : Int, v : Double) -> MlfeaturenmfBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_buffer_sum(s : MlfeaturenmfBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_feature_nmf_buffer_mean(s : MlfeaturenmfBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_feature_nmf_buffer_scale(s : MlfeaturenmfBuffer, f : Double) -> MlfeaturenmfBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_buffer_add(a : MlfeaturenmfBuffer, b : MlfeaturenmfBuffer) -> MlfeaturenmfBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_nmf_buffer_copy(s : MlfeaturenmfBuffer) -> MlfeaturenmfBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_buffer_fill(s : MlfeaturenmfBuffer, v : Double) -> MlfeaturenmfBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_buffer_min(s : MlfeaturenmfBuffer) -> Double { @_common.min(s.data) }

pub fn ml_feature_nmf_buffer_max(s : MlfeaturenmfBuffer) -> Double { @_common.max(s.data) }

pub fn ml_feature_nmf_buffer_to_string(s : MlfeaturenmfBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturenmfCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_nmf_cursor_make(size : Int) -> MlfeaturenmfCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_nmf_cursor_len(s : MlfeaturenmfCursor) -> Int { s.size }

pub fn ml_feature_nmf_cursor_get(s : MlfeaturenmfCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_nmf_cursor_set(s : MlfeaturenmfCursor, i : Int, v : Double) -> MlfeaturenmfCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_cursor_sum(s : MlfeaturenmfCursor) -> Double { @_common.sum(s.data) }

pub fn ml_feature_nmf_cursor_mean(s : MlfeaturenmfCursor) -> Double { @_common.mean(s.data) }

pub fn ml_feature_nmf_cursor_scale(s : MlfeaturenmfCursor, f : Double) -> MlfeaturenmfCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_cursor_add(a : MlfeaturenmfCursor, b : MlfeaturenmfCursor) -> MlfeaturenmfCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_nmf_cursor_copy(s : MlfeaturenmfCursor) -> MlfeaturenmfCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_cursor_fill(s : MlfeaturenmfCursor, v : Double) -> MlfeaturenmfCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_cursor_min(s : MlfeaturenmfCursor) -> Double { @_common.min(s.data) }

pub fn ml_feature_nmf_cursor_max(s : MlfeaturenmfCursor) -> Double { @_common.max(s.data) }

pub fn ml_feature_nmf_cursor_to_string(s : MlfeaturenmfCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturenmfView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_nmf_view_make(size : Int) -> MlfeaturenmfView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_nmf_view_len(s : MlfeaturenmfView) -> Int { s.size }

pub fn ml_feature_nmf_view_get(s : MlfeaturenmfView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_nmf_view_set(s : MlfeaturenmfView, i : Int, v : Double) -> MlfeaturenmfView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_view_sum(s : MlfeaturenmfView) -> Double { @_common.sum(s.data) }

pub fn ml_feature_nmf_view_mean(s : MlfeaturenmfView) -> Double { @_common.mean(s.data) }

pub fn ml_feature_nmf_view_scale(s : MlfeaturenmfView, f : Double) -> MlfeaturenmfView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_view_add(a : MlfeaturenmfView, b : MlfeaturenmfView) -> MlfeaturenmfView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_nmf_view_copy(s : MlfeaturenmfView) -> MlfeaturenmfView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_view_fill(s : MlfeaturenmfView, v : Double) -> MlfeaturenmfView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_view_min(s : MlfeaturenmfView) -> Double { @_common.min(s.data) }

pub fn ml_feature_nmf_view_max(s : MlfeaturenmfView) -> Double { @_common.max(s.data) }

pub fn ml_feature_nmf_view_to_string(s : MlfeaturenmfView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturenmfRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_nmf_range_make(size : Int) -> MlfeaturenmfRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_nmf_range_len(s : MlfeaturenmfRange) -> Int { s.size }

pub fn ml_feature_nmf_range_get(s : MlfeaturenmfRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_nmf_range_set(s : MlfeaturenmfRange, i : Int, v : Double) -> MlfeaturenmfRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_range_sum(s : MlfeaturenmfRange) -> Double { @_common.sum(s.data) }

pub fn ml_feature_nmf_range_mean(s : MlfeaturenmfRange) -> Double { @_common.mean(s.data) }

pub fn ml_feature_nmf_range_scale(s : MlfeaturenmfRange, f : Double) -> MlfeaturenmfRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_range_add(a : MlfeaturenmfRange, b : MlfeaturenmfRange) -> MlfeaturenmfRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_nmf_range_copy(s : MlfeaturenmfRange) -> MlfeaturenmfRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_range_fill(s : MlfeaturenmfRange, v : Double) -> MlfeaturenmfRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_range_min(s : MlfeaturenmfRange) -> Double { @_common.min(s.data) }

pub fn ml_feature_nmf_range_max(s : MlfeaturenmfRange) -> Double { @_common.max(s.data) }

pub fn ml_feature_nmf_range_to_string(s : MlfeaturenmfRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturenmfSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_nmf_slice_make(size : Int) -> MlfeaturenmfSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_nmf_slice_len(s : MlfeaturenmfSlice) -> Int { s.size }

pub fn ml_feature_nmf_slice_get(s : MlfeaturenmfSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_nmf_slice_set(s : MlfeaturenmfSlice, i : Int, v : Double) -> MlfeaturenmfSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_slice_sum(s : MlfeaturenmfSlice) -> Double { @_common.sum(s.data) }

pub fn ml_feature_nmf_slice_mean(s : MlfeaturenmfSlice) -> Double { @_common.mean(s.data) }

pub fn ml_feature_nmf_slice_scale(s : MlfeaturenmfSlice, f : Double) -> MlfeaturenmfSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_slice_add(a : MlfeaturenmfSlice, b : MlfeaturenmfSlice) -> MlfeaturenmfSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_nmf_slice_copy(s : MlfeaturenmfSlice) -> MlfeaturenmfSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_slice_fill(s : MlfeaturenmfSlice, v : Double) -> MlfeaturenmfSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_nmf_slice_min(s : MlfeaturenmfSlice) -> Double { @_common.min(s.data) }

pub fn ml_feature_nmf_slice_max(s : MlfeaturenmfSlice) -> Double { @_common.max(s.data) }

pub fn ml_feature_nmf_slice_to_string(s : MlfeaturenmfSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

