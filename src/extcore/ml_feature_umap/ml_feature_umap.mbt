///===
/// extcore/ml_feature_umap

pub(all) struct MlfeatureumapPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_feature_umap_make_point(x : Double, y : Double) -> MlfeatureumapPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_feature_umap_make_point3(x : Double, y : Double, z : Double) -> MlfeatureumapPoint {
  { x, y, z, label: 0 }
}

pub fn MlfeatureumapPoint::x(self : MlfeatureumapPoint) -> Double { self.x }

pub fn MlfeatureumapPoint::y(self : MlfeatureumapPoint) -> Double { self.y }

pub fn MlfeatureumapPoint::z(self : MlfeatureumapPoint) -> Double { self.z }

pub fn MlfeatureumapPoint::label(self : MlfeatureumapPoint) -> Int { self.label }

pub fn MlfeatureumapPoint::dist(self : MlfeatureumapPoint, other : MlfeatureumapPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlfeatureumapPoint::add(self : MlfeatureumapPoint, other : MlfeatureumapPoint) -> MlfeatureumapPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlfeatureumapPoint::sub(self : MlfeatureumapPoint, other : MlfeatureumapPoint) -> MlfeatureumapPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlfeatureumapPoint::scale(self : MlfeatureumapPoint, s : Double) -> MlfeatureumapPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlfeatureumapPoint::dot(self : MlfeatureumapPoint, other : MlfeatureumapPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlfeatureumapPoint::cross(self : MlfeatureumapPoint, other : MlfeatureumapPoint) -> MlfeatureumapPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlfeatureumapPoint::norm(self : MlfeatureumapPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlfeatureumapPoint::normalize(self : MlfeatureumapPoint) -> MlfeatureumapPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlfeatureumapPoint::negate(self : MlfeatureumapPoint) -> MlfeatureumapPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlfeatureumapPoint::mid(self : MlfeatureumapPoint, other : MlfeatureumapPoint) -> MlfeatureumapPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlfeatureumapPoint::lerp(self : MlfeatureumapPoint, other : MlfeatureumapPoint, t : Double) -> MlfeatureumapPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlfeatureumapPoint::to_string(self : MlfeatureumapPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlfeatureumapSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_feature_umap_make_series(vals : Array[Double], name : String) -> MlfeatureumapSeries {
  { vals, name, meta: 0 }
}

pub fn MlfeatureumapSeries::len(self : MlfeatureumapSeries) -> Int { self.vals.length() }

pub fn MlfeatureumapSeries::sum(self : MlfeatureumapSeries) -> Double { @_common.sum(self.vals) }

pub fn MlfeatureumapSeries::mean(self : MlfeatureumapSeries) -> Double { @_common.mean(self.vals) }

pub fn MlfeatureumapSeries::min(self : MlfeatureumapSeries) -> Double { @_common.min(self.vals) }

pub fn MlfeatureumapSeries::max(self : MlfeatureumapSeries) -> Double { @_common.max(self.vals) }

pub fn MlfeatureumapSeries::range(self : MlfeatureumapSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlfeatureumapSeries::variance(self : MlfeatureumapSeries) -> Double { @_common.variance(self.vals) }

pub fn MlfeatureumapSeries::std(self : MlfeatureumapSeries) -> Double { @_common.std(self.vals) }

pub fn MlfeatureumapSeries::median(self : MlfeatureumapSeries) -> Double { @_common.median(self.vals) }

pub fn MlfeatureumapSeries::scale(self : MlfeatureumapSeries, f : Double) -> MlfeatureumapSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlfeatureumapSeries::add(self : MlfeatureumapSeries, other : MlfeatureumapSeries) -> MlfeatureumapSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlfeatureumapSeries::sub(self : MlfeatureumapSeries, other : MlfeatureumapSeries) -> MlfeatureumapSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlfeatureumapSeries::normalize(self : MlfeatureumapSeries) -> MlfeatureumapSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlfeatureumapSeries::cumsum(self : MlfeatureumapSeries) -> MlfeatureumapSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlfeatureumapSeries::to_string(self : MlfeatureumapSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlfeatureumapMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_feature_umap_make_matrix(rows : Int, cols : Int, val : Double) -> MlfeatureumapMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_feature_umap_matrix_identity(n : Int) -> MlfeatureumapMatrix {
  let m = ml_feature_umap_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlfeatureumapMatrix::get(self : MlfeatureumapMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlfeatureumapMatrix::transpose(self : MlfeatureumapMatrix) -> MlfeatureumapMatrix {
  let result = ml_feature_umap_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlfeatureumapMatrix::add(self : MlfeatureumapMatrix, other : MlfeatureumapMatrix) -> MlfeatureumapMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_feature_umap_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlfeatureumapMatrix::scale(self : MlfeatureumapMatrix, s : Double) -> MlfeatureumapMatrix {
  let result = ml_feature_umap_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlfeatureumapMatrix::multiply(self : MlfeatureumapMatrix, other : MlfeatureumapMatrix) -> MlfeatureumapMatrix {
  if self.cols != other.rows { return ml_feature_umap_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_feature_umap_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlfeatureumapMatrix::trace(self : MlfeatureumapMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlfeatureumapMatrix::det(self : MlfeatureumapMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlfeatureumapMatrix::norm(self : MlfeatureumapMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlfeatureumapMatrix::to_string(self : MlfeatureumapMatrix) -> String {
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

pub(all) struct MlfeatureumapVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_feature_umap_make_vector(comps : Array[Double]) -> MlfeatureumapVector {
  { comps, dim: comps.length() }
}

pub fn ml_feature_umap_vector_zero(dim : Int) -> MlfeatureumapVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlfeatureumapVector::add(self : MlfeatureumapVector, other : MlfeatureumapVector) -> MlfeatureumapVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlfeatureumapVector::sub(self : MlfeatureumapVector, other : MlfeatureumapVector) -> MlfeatureumapVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlfeatureumapVector::scale(self : MlfeatureumapVector, s : Double) -> MlfeatureumapVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlfeatureumapVector::dot(self : MlfeatureumapVector, other : MlfeatureumapVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlfeatureumapVector::norm(self : MlfeatureumapVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlfeatureumapVector::normalize(self : MlfeatureumapVector) -> MlfeatureumapVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlfeatureumapVector::dist(self : MlfeatureumapVector, other : MlfeatureumapVector) -> Double {
  self.sub(other).norm()
}

pub fn MlfeatureumapVector::to_string(self : MlfeatureumapVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_feature_umap_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_feature_umap_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_feature_umap_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_feature_umap_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_feature_umap_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_feature_umap_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_feature_umap_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_feature_umap_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_feature_umap_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_feature_umap_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_feature_umap_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_feature_umap_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_feature_umap_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_feature_umap_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_feature_umap_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_feature_umap_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_feature_umap_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_feature_umap_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_feature_umap_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_feature_umap_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_feature_umap_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_feature_umap_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_feature_umap_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_feature_umap_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_feature_umap_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_feature_umap_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_feature_umap_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_feature_umap_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_feature_umap_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlfeatureumapFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_umap_frame_make(size : Int) -> MlfeatureumapFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_umap_frame_len(s : MlfeatureumapFrame) -> Int { s.size }

pub fn ml_feature_umap_frame_get(s : MlfeatureumapFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_umap_frame_set(s : MlfeatureumapFrame, i : Int, v : Double) -> MlfeatureumapFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_frame_sum(s : MlfeatureumapFrame) -> Double { @_common.sum(s.data) }

pub fn ml_feature_umap_frame_mean(s : MlfeatureumapFrame) -> Double { @_common.mean(s.data) }

pub fn ml_feature_umap_frame_scale(s : MlfeatureumapFrame, f : Double) -> MlfeatureumapFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_frame_add(a : MlfeatureumapFrame, b : MlfeatureumapFrame) -> MlfeatureumapFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_umap_frame_copy(s : MlfeatureumapFrame) -> MlfeatureumapFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_frame_fill(s : MlfeatureumapFrame, v : Double) -> MlfeatureumapFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_frame_min(s : MlfeatureumapFrame) -> Double { @_common.min(s.data) }

pub fn ml_feature_umap_frame_max(s : MlfeatureumapFrame) -> Double { @_common.max(s.data) }

pub fn ml_feature_umap_frame_to_string(s : MlfeatureumapFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureumapTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_umap_table_make(size : Int) -> MlfeatureumapTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_umap_table_len(s : MlfeatureumapTable) -> Int { s.size }

pub fn ml_feature_umap_table_get(s : MlfeatureumapTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_umap_table_set(s : MlfeatureumapTable, i : Int, v : Double) -> MlfeatureumapTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_table_sum(s : MlfeatureumapTable) -> Double { @_common.sum(s.data) }

pub fn ml_feature_umap_table_mean(s : MlfeatureumapTable) -> Double { @_common.mean(s.data) }

pub fn ml_feature_umap_table_scale(s : MlfeatureumapTable, f : Double) -> MlfeatureumapTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_table_add(a : MlfeatureumapTable, b : MlfeatureumapTable) -> MlfeatureumapTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_umap_table_copy(s : MlfeatureumapTable) -> MlfeatureumapTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_table_fill(s : MlfeatureumapTable, v : Double) -> MlfeatureumapTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_table_min(s : MlfeatureumapTable) -> Double { @_common.min(s.data) }

pub fn ml_feature_umap_table_max(s : MlfeatureumapTable) -> Double { @_common.max(s.data) }

pub fn ml_feature_umap_table_to_string(s : MlfeatureumapTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureumapGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_umap_graphn_make(size : Int) -> MlfeatureumapGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_umap_graphn_len(s : MlfeatureumapGraphN) -> Int { s.size }

pub fn ml_feature_umap_graphn_get(s : MlfeatureumapGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_umap_graphn_set(s : MlfeatureumapGraphN, i : Int, v : Double) -> MlfeatureumapGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_graphn_sum(s : MlfeatureumapGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_feature_umap_graphn_mean(s : MlfeatureumapGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_feature_umap_graphn_scale(s : MlfeatureumapGraphN, f : Double) -> MlfeatureumapGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_graphn_add(a : MlfeatureumapGraphN, b : MlfeatureumapGraphN) -> MlfeatureumapGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_umap_graphn_copy(s : MlfeatureumapGraphN) -> MlfeatureumapGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_graphn_fill(s : MlfeatureumapGraphN, v : Double) -> MlfeatureumapGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_graphn_min(s : MlfeatureumapGraphN) -> Double { @_common.min(s.data) }

pub fn ml_feature_umap_graphn_max(s : MlfeatureumapGraphN) -> Double { @_common.max(s.data) }

pub fn ml_feature_umap_graphn_to_string(s : MlfeatureumapGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureumapNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_umap_node_make(size : Int) -> MlfeatureumapNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_umap_node_len(s : MlfeatureumapNode) -> Int { s.size }

pub fn ml_feature_umap_node_get(s : MlfeatureumapNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_umap_node_set(s : MlfeatureumapNode, i : Int, v : Double) -> MlfeatureumapNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_node_sum(s : MlfeatureumapNode) -> Double { @_common.sum(s.data) }

pub fn ml_feature_umap_node_mean(s : MlfeatureumapNode) -> Double { @_common.mean(s.data) }

pub fn ml_feature_umap_node_scale(s : MlfeatureumapNode, f : Double) -> MlfeatureumapNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_node_add(a : MlfeatureumapNode, b : MlfeatureumapNode) -> MlfeatureumapNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_umap_node_copy(s : MlfeatureumapNode) -> MlfeatureumapNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_node_fill(s : MlfeatureumapNode, v : Double) -> MlfeatureumapNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_node_min(s : MlfeatureumapNode) -> Double { @_common.min(s.data) }

pub fn ml_feature_umap_node_max(s : MlfeatureumapNode) -> Double { @_common.max(s.data) }

pub fn ml_feature_umap_node_to_string(s : MlfeatureumapNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureumapEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_umap_edge_make(size : Int) -> MlfeatureumapEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_umap_edge_len(s : MlfeatureumapEdge) -> Int { s.size }

pub fn ml_feature_umap_edge_get(s : MlfeatureumapEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_umap_edge_set(s : MlfeatureumapEdge, i : Int, v : Double) -> MlfeatureumapEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_edge_sum(s : MlfeatureumapEdge) -> Double { @_common.sum(s.data) }

pub fn ml_feature_umap_edge_mean(s : MlfeatureumapEdge) -> Double { @_common.mean(s.data) }

pub fn ml_feature_umap_edge_scale(s : MlfeatureumapEdge, f : Double) -> MlfeatureumapEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_edge_add(a : MlfeatureumapEdge, b : MlfeatureumapEdge) -> MlfeatureumapEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_umap_edge_copy(s : MlfeatureumapEdge) -> MlfeatureumapEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_edge_fill(s : MlfeatureumapEdge, v : Double) -> MlfeatureumapEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_edge_min(s : MlfeatureumapEdge) -> Double { @_common.min(s.data) }

pub fn ml_feature_umap_edge_max(s : MlfeatureumapEdge) -> Double { @_common.max(s.data) }

pub fn ml_feature_umap_edge_to_string(s : MlfeatureumapEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureumapPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_umap_path_make(size : Int) -> MlfeatureumapPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_umap_path_len(s : MlfeatureumapPath) -> Int { s.size }

pub fn ml_feature_umap_path_get(s : MlfeatureumapPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_umap_path_set(s : MlfeatureumapPath, i : Int, v : Double) -> MlfeatureumapPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_path_sum(s : MlfeatureumapPath) -> Double { @_common.sum(s.data) }

pub fn ml_feature_umap_path_mean(s : MlfeatureumapPath) -> Double { @_common.mean(s.data) }

pub fn ml_feature_umap_path_scale(s : MlfeatureumapPath, f : Double) -> MlfeatureumapPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_path_add(a : MlfeatureumapPath, b : MlfeatureumapPath) -> MlfeatureumapPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_umap_path_copy(s : MlfeatureumapPath) -> MlfeatureumapPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_path_fill(s : MlfeatureumapPath, v : Double) -> MlfeatureumapPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_path_min(s : MlfeatureumapPath) -> Double { @_common.min(s.data) }

pub fn ml_feature_umap_path_max(s : MlfeatureumapPath) -> Double { @_common.max(s.data) }

pub fn ml_feature_umap_path_to_string(s : MlfeatureumapPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureumapCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_umap_cluster_make(size : Int) -> MlfeatureumapCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_umap_cluster_len(s : MlfeatureumapCluster) -> Int { s.size }

pub fn ml_feature_umap_cluster_get(s : MlfeatureumapCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_umap_cluster_set(s : MlfeatureumapCluster, i : Int, v : Double) -> MlfeatureumapCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_cluster_sum(s : MlfeatureumapCluster) -> Double { @_common.sum(s.data) }

pub fn ml_feature_umap_cluster_mean(s : MlfeatureumapCluster) -> Double { @_common.mean(s.data) }

pub fn ml_feature_umap_cluster_scale(s : MlfeatureumapCluster, f : Double) -> MlfeatureumapCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_cluster_add(a : MlfeatureumapCluster, b : MlfeatureumapCluster) -> MlfeatureumapCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_umap_cluster_copy(s : MlfeatureumapCluster) -> MlfeatureumapCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_cluster_fill(s : MlfeatureumapCluster, v : Double) -> MlfeatureumapCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_cluster_min(s : MlfeatureumapCluster) -> Double { @_common.min(s.data) }

pub fn ml_feature_umap_cluster_max(s : MlfeatureumapCluster) -> Double { @_common.max(s.data) }

pub fn ml_feature_umap_cluster_to_string(s : MlfeatureumapCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureumapModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_umap_model_make(size : Int) -> MlfeatureumapModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_umap_model_len(s : MlfeatureumapModel) -> Int { s.size }

pub fn ml_feature_umap_model_get(s : MlfeatureumapModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_umap_model_set(s : MlfeatureumapModel, i : Int, v : Double) -> MlfeatureumapModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_model_sum(s : MlfeatureumapModel) -> Double { @_common.sum(s.data) }

pub fn ml_feature_umap_model_mean(s : MlfeatureumapModel) -> Double { @_common.mean(s.data) }

pub fn ml_feature_umap_model_scale(s : MlfeatureumapModel, f : Double) -> MlfeatureumapModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_model_add(a : MlfeatureumapModel, b : MlfeatureumapModel) -> MlfeatureumapModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_umap_model_copy(s : MlfeatureumapModel) -> MlfeatureumapModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_model_fill(s : MlfeatureumapModel, v : Double) -> MlfeatureumapModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_model_min(s : MlfeatureumapModel) -> Double { @_common.min(s.data) }

pub fn ml_feature_umap_model_max(s : MlfeatureumapModel) -> Double { @_common.max(s.data) }

pub fn ml_feature_umap_model_to_string(s : MlfeatureumapModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureumapLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_umap_layer_make(size : Int) -> MlfeatureumapLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_umap_layer_len(s : MlfeatureumapLayer) -> Int { s.size }

pub fn ml_feature_umap_layer_get(s : MlfeatureumapLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_umap_layer_set(s : MlfeatureumapLayer, i : Int, v : Double) -> MlfeatureumapLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_layer_sum(s : MlfeatureumapLayer) -> Double { @_common.sum(s.data) }

pub fn ml_feature_umap_layer_mean(s : MlfeatureumapLayer) -> Double { @_common.mean(s.data) }

pub fn ml_feature_umap_layer_scale(s : MlfeatureumapLayer, f : Double) -> MlfeatureumapLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_layer_add(a : MlfeatureumapLayer, b : MlfeatureumapLayer) -> MlfeatureumapLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_umap_layer_copy(s : MlfeatureumapLayer) -> MlfeatureumapLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_layer_fill(s : MlfeatureumapLayer, v : Double) -> MlfeatureumapLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_layer_min(s : MlfeatureumapLayer) -> Double { @_common.min(s.data) }

pub fn ml_feature_umap_layer_max(s : MlfeatureumapLayer) -> Double { @_common.max(s.data) }

pub fn ml_feature_umap_layer_to_string(s : MlfeatureumapLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureumapBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_umap_buffer_make(size : Int) -> MlfeatureumapBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_umap_buffer_len(s : MlfeatureumapBuffer) -> Int { s.size }

pub fn ml_feature_umap_buffer_get(s : MlfeatureumapBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_umap_buffer_set(s : MlfeatureumapBuffer, i : Int, v : Double) -> MlfeatureumapBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_buffer_sum(s : MlfeatureumapBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_feature_umap_buffer_mean(s : MlfeatureumapBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_feature_umap_buffer_scale(s : MlfeatureumapBuffer, f : Double) -> MlfeatureumapBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_buffer_add(a : MlfeatureumapBuffer, b : MlfeatureumapBuffer) -> MlfeatureumapBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_umap_buffer_copy(s : MlfeatureumapBuffer) -> MlfeatureumapBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_buffer_fill(s : MlfeatureumapBuffer, v : Double) -> MlfeatureumapBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_buffer_min(s : MlfeatureumapBuffer) -> Double { @_common.min(s.data) }

pub fn ml_feature_umap_buffer_max(s : MlfeatureumapBuffer) -> Double { @_common.max(s.data) }

pub fn ml_feature_umap_buffer_to_string(s : MlfeatureumapBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureumapCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_umap_cursor_make(size : Int) -> MlfeatureumapCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_umap_cursor_len(s : MlfeatureumapCursor) -> Int { s.size }

pub fn ml_feature_umap_cursor_get(s : MlfeatureumapCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_umap_cursor_set(s : MlfeatureumapCursor, i : Int, v : Double) -> MlfeatureumapCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_cursor_sum(s : MlfeatureumapCursor) -> Double { @_common.sum(s.data) }

pub fn ml_feature_umap_cursor_mean(s : MlfeatureumapCursor) -> Double { @_common.mean(s.data) }

pub fn ml_feature_umap_cursor_scale(s : MlfeatureumapCursor, f : Double) -> MlfeatureumapCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_cursor_add(a : MlfeatureumapCursor, b : MlfeatureumapCursor) -> MlfeatureumapCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_umap_cursor_copy(s : MlfeatureumapCursor) -> MlfeatureumapCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_cursor_fill(s : MlfeatureumapCursor, v : Double) -> MlfeatureumapCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_cursor_min(s : MlfeatureumapCursor) -> Double { @_common.min(s.data) }

pub fn ml_feature_umap_cursor_max(s : MlfeatureumapCursor) -> Double { @_common.max(s.data) }

pub fn ml_feature_umap_cursor_to_string(s : MlfeatureumapCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureumapView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_umap_view_make(size : Int) -> MlfeatureumapView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_umap_view_len(s : MlfeatureumapView) -> Int { s.size }

pub fn ml_feature_umap_view_get(s : MlfeatureumapView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_umap_view_set(s : MlfeatureumapView, i : Int, v : Double) -> MlfeatureumapView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_view_sum(s : MlfeatureumapView) -> Double { @_common.sum(s.data) }

pub fn ml_feature_umap_view_mean(s : MlfeatureumapView) -> Double { @_common.mean(s.data) }

pub fn ml_feature_umap_view_scale(s : MlfeatureumapView, f : Double) -> MlfeatureumapView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_view_add(a : MlfeatureumapView, b : MlfeatureumapView) -> MlfeatureumapView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_umap_view_copy(s : MlfeatureumapView) -> MlfeatureumapView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_view_fill(s : MlfeatureumapView, v : Double) -> MlfeatureumapView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_view_min(s : MlfeatureumapView) -> Double { @_common.min(s.data) }

pub fn ml_feature_umap_view_max(s : MlfeatureumapView) -> Double { @_common.max(s.data) }

pub fn ml_feature_umap_view_to_string(s : MlfeatureumapView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureumapRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_umap_range_make(size : Int) -> MlfeatureumapRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_umap_range_len(s : MlfeatureumapRange) -> Int { s.size }

pub fn ml_feature_umap_range_get(s : MlfeatureumapRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_umap_range_set(s : MlfeatureumapRange, i : Int, v : Double) -> MlfeatureumapRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_range_sum(s : MlfeatureumapRange) -> Double { @_common.sum(s.data) }

pub fn ml_feature_umap_range_mean(s : MlfeatureumapRange) -> Double { @_common.mean(s.data) }

pub fn ml_feature_umap_range_scale(s : MlfeatureumapRange, f : Double) -> MlfeatureumapRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_range_add(a : MlfeatureumapRange, b : MlfeatureumapRange) -> MlfeatureumapRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_umap_range_copy(s : MlfeatureumapRange) -> MlfeatureumapRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_range_fill(s : MlfeatureumapRange, v : Double) -> MlfeatureumapRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_range_min(s : MlfeatureumapRange) -> Double { @_common.min(s.data) }

pub fn ml_feature_umap_range_max(s : MlfeatureumapRange) -> Double { @_common.max(s.data) }

pub fn ml_feature_umap_range_to_string(s : MlfeatureumapRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureumapSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_umap_slice_make(size : Int) -> MlfeatureumapSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_umap_slice_len(s : MlfeatureumapSlice) -> Int { s.size }

pub fn ml_feature_umap_slice_get(s : MlfeatureumapSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_umap_slice_set(s : MlfeatureumapSlice, i : Int, v : Double) -> MlfeatureumapSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_slice_sum(s : MlfeatureumapSlice) -> Double { @_common.sum(s.data) }

pub fn ml_feature_umap_slice_mean(s : MlfeatureumapSlice) -> Double { @_common.mean(s.data) }

pub fn ml_feature_umap_slice_scale(s : MlfeatureumapSlice, f : Double) -> MlfeatureumapSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_slice_add(a : MlfeatureumapSlice, b : MlfeatureumapSlice) -> MlfeatureumapSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_umap_slice_copy(s : MlfeatureumapSlice) -> MlfeatureumapSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_slice_fill(s : MlfeatureumapSlice, v : Double) -> MlfeatureumapSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_umap_slice_min(s : MlfeatureumapSlice) -> Double { @_common.min(s.data) }

pub fn ml_feature_umap_slice_max(s : MlfeatureumapSlice) -> Double { @_common.max(s.data) }

pub fn ml_feature_umap_slice_to_string(s : MlfeatureumapSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

