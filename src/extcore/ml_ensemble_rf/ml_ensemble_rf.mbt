///===
/// extcore/ml_ensemble_rf

pub(all) struct MlensemblerfPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_ensemble_rf_make_point(x : Double, y : Double) -> MlensemblerfPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_ensemble_rf_make_point3(x : Double, y : Double, z : Double) -> MlensemblerfPoint {
  { x, y, z, label: 0 }
}

pub fn MlensemblerfPoint::x(self : MlensemblerfPoint) -> Double { self.x }

pub fn MlensemblerfPoint::y(self : MlensemblerfPoint) -> Double { self.y }

pub fn MlensemblerfPoint::z(self : MlensemblerfPoint) -> Double { self.z }

pub fn MlensemblerfPoint::label(self : MlensemblerfPoint) -> Int { self.label }

pub fn MlensemblerfPoint::dist(self : MlensemblerfPoint, other : MlensemblerfPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlensemblerfPoint::add(self : MlensemblerfPoint, other : MlensemblerfPoint) -> MlensemblerfPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlensemblerfPoint::sub(self : MlensemblerfPoint, other : MlensemblerfPoint) -> MlensemblerfPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlensemblerfPoint::scale(self : MlensemblerfPoint, s : Double) -> MlensemblerfPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlensemblerfPoint::dot(self : MlensemblerfPoint, other : MlensemblerfPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlensemblerfPoint::cross(self : MlensemblerfPoint, other : MlensemblerfPoint) -> MlensemblerfPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlensemblerfPoint::norm(self : MlensemblerfPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlensemblerfPoint::normalize(self : MlensemblerfPoint) -> MlensemblerfPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlensemblerfPoint::negate(self : MlensemblerfPoint) -> MlensemblerfPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlensemblerfPoint::mid(self : MlensemblerfPoint, other : MlensemblerfPoint) -> MlensemblerfPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlensemblerfPoint::lerp(self : MlensemblerfPoint, other : MlensemblerfPoint, t : Double) -> MlensemblerfPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlensemblerfPoint::to_string(self : MlensemblerfPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlensemblerfSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_ensemble_rf_make_series(vals : Array[Double], name : String) -> MlensemblerfSeries {
  { vals, name, meta: 0 }
}

pub fn MlensemblerfSeries::len(self : MlensemblerfSeries) -> Int { self.vals.length() }

pub fn MlensemblerfSeries::sum(self : MlensemblerfSeries) -> Double { @_common.sum(self.vals) }

pub fn MlensemblerfSeries::mean(self : MlensemblerfSeries) -> Double { @_common.mean(self.vals) }

pub fn MlensemblerfSeries::min(self : MlensemblerfSeries) -> Double { @_common.min(self.vals) }

pub fn MlensemblerfSeries::max(self : MlensemblerfSeries) -> Double { @_common.max(self.vals) }

pub fn MlensemblerfSeries::range(self : MlensemblerfSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlensemblerfSeries::variance(self : MlensemblerfSeries) -> Double { @_common.variance(self.vals) }

pub fn MlensemblerfSeries::std(self : MlensemblerfSeries) -> Double { @_common.std(self.vals) }

pub fn MlensemblerfSeries::median(self : MlensemblerfSeries) -> Double { @_common.median(self.vals) }

pub fn MlensemblerfSeries::scale(self : MlensemblerfSeries, f : Double) -> MlensemblerfSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlensemblerfSeries::add(self : MlensemblerfSeries, other : MlensemblerfSeries) -> MlensemblerfSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlensemblerfSeries::sub(self : MlensemblerfSeries, other : MlensemblerfSeries) -> MlensemblerfSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlensemblerfSeries::normalize(self : MlensemblerfSeries) -> MlensemblerfSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlensemblerfSeries::cumsum(self : MlensemblerfSeries) -> MlensemblerfSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlensemblerfSeries::to_string(self : MlensemblerfSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlensemblerfMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_ensemble_rf_make_matrix(rows : Int, cols : Int, val : Double) -> MlensemblerfMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_ensemble_rf_matrix_identity(n : Int) -> MlensemblerfMatrix {
  let m = ml_ensemble_rf_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlensemblerfMatrix::get(self : MlensemblerfMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlensemblerfMatrix::transpose(self : MlensemblerfMatrix) -> MlensemblerfMatrix {
  let result = ml_ensemble_rf_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlensemblerfMatrix::add(self : MlensemblerfMatrix, other : MlensemblerfMatrix) -> MlensemblerfMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_ensemble_rf_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlensemblerfMatrix::scale(self : MlensemblerfMatrix, s : Double) -> MlensemblerfMatrix {
  let result = ml_ensemble_rf_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlensemblerfMatrix::multiply(self : MlensemblerfMatrix, other : MlensemblerfMatrix) -> MlensemblerfMatrix {
  if self.cols != other.rows { return ml_ensemble_rf_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_ensemble_rf_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlensemblerfMatrix::trace(self : MlensemblerfMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlensemblerfMatrix::det(self : MlensemblerfMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlensemblerfMatrix::norm(self : MlensemblerfMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlensemblerfMatrix::to_string(self : MlensemblerfMatrix) -> String {
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

pub(all) struct MlensemblerfVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_ensemble_rf_make_vector(comps : Array[Double]) -> MlensemblerfVector {
  { comps, dim: comps.length() }
}

pub fn ml_ensemble_rf_vector_zero(dim : Int) -> MlensemblerfVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlensemblerfVector::add(self : MlensemblerfVector, other : MlensemblerfVector) -> MlensemblerfVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlensemblerfVector::sub(self : MlensemblerfVector, other : MlensemblerfVector) -> MlensemblerfVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlensemblerfVector::scale(self : MlensemblerfVector, s : Double) -> MlensemblerfVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlensemblerfVector::dot(self : MlensemblerfVector, other : MlensemblerfVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlensemblerfVector::norm(self : MlensemblerfVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlensemblerfVector::normalize(self : MlensemblerfVector) -> MlensemblerfVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlensemblerfVector::dist(self : MlensemblerfVector, other : MlensemblerfVector) -> Double {
  self.sub(other).norm()
}

pub fn MlensemblerfVector::to_string(self : MlensemblerfVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_ensemble_rf_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_ensemble_rf_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_ensemble_rf_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_ensemble_rf_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_ensemble_rf_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_ensemble_rf_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_ensemble_rf_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_ensemble_rf_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_ensemble_rf_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_ensemble_rf_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_ensemble_rf_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_ensemble_rf_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_ensemble_rf_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_ensemble_rf_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_ensemble_rf_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_ensemble_rf_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_ensemble_rf_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_ensemble_rf_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_ensemble_rf_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_ensemble_rf_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_ensemble_rf_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_ensemble_rf_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_ensemble_rf_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_ensemble_rf_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_ensemble_rf_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_ensemble_rf_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_ensemble_rf_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_ensemble_rf_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_ensemble_rf_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlensemblerfFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_rf_frame_make(size : Int) -> MlensemblerfFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_rf_frame_len(s : MlensemblerfFrame) -> Int { s.size }

pub fn ml_ensemble_rf_frame_get(s : MlensemblerfFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_rf_frame_set(s : MlensemblerfFrame, i : Int, v : Double) -> MlensemblerfFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_frame_sum(s : MlensemblerfFrame) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_rf_frame_mean(s : MlensemblerfFrame) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_rf_frame_scale(s : MlensemblerfFrame, f : Double) -> MlensemblerfFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_frame_add(a : MlensemblerfFrame, b : MlensemblerfFrame) -> MlensemblerfFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_rf_frame_copy(s : MlensemblerfFrame) -> MlensemblerfFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_frame_fill(s : MlensemblerfFrame, v : Double) -> MlensemblerfFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_frame_min(s : MlensemblerfFrame) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_rf_frame_max(s : MlensemblerfFrame) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_rf_frame_to_string(s : MlensemblerfFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblerfTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_rf_table_make(size : Int) -> MlensemblerfTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_rf_table_len(s : MlensemblerfTable) -> Int { s.size }

pub fn ml_ensemble_rf_table_get(s : MlensemblerfTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_rf_table_set(s : MlensemblerfTable, i : Int, v : Double) -> MlensemblerfTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_table_sum(s : MlensemblerfTable) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_rf_table_mean(s : MlensemblerfTable) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_rf_table_scale(s : MlensemblerfTable, f : Double) -> MlensemblerfTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_table_add(a : MlensemblerfTable, b : MlensemblerfTable) -> MlensemblerfTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_rf_table_copy(s : MlensemblerfTable) -> MlensemblerfTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_table_fill(s : MlensemblerfTable, v : Double) -> MlensemblerfTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_table_min(s : MlensemblerfTable) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_rf_table_max(s : MlensemblerfTable) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_rf_table_to_string(s : MlensemblerfTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblerfGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_rf_graphn_make(size : Int) -> MlensemblerfGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_rf_graphn_len(s : MlensemblerfGraphN) -> Int { s.size }

pub fn ml_ensemble_rf_graphn_get(s : MlensemblerfGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_rf_graphn_set(s : MlensemblerfGraphN, i : Int, v : Double) -> MlensemblerfGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_graphn_sum(s : MlensemblerfGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_rf_graphn_mean(s : MlensemblerfGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_rf_graphn_scale(s : MlensemblerfGraphN, f : Double) -> MlensemblerfGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_graphn_add(a : MlensemblerfGraphN, b : MlensemblerfGraphN) -> MlensemblerfGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_rf_graphn_copy(s : MlensemblerfGraphN) -> MlensemblerfGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_graphn_fill(s : MlensemblerfGraphN, v : Double) -> MlensemblerfGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_graphn_min(s : MlensemblerfGraphN) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_rf_graphn_max(s : MlensemblerfGraphN) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_rf_graphn_to_string(s : MlensemblerfGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblerfNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_rf_node_make(size : Int) -> MlensemblerfNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_rf_node_len(s : MlensemblerfNode) -> Int { s.size }

pub fn ml_ensemble_rf_node_get(s : MlensemblerfNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_rf_node_set(s : MlensemblerfNode, i : Int, v : Double) -> MlensemblerfNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_node_sum(s : MlensemblerfNode) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_rf_node_mean(s : MlensemblerfNode) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_rf_node_scale(s : MlensemblerfNode, f : Double) -> MlensemblerfNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_node_add(a : MlensemblerfNode, b : MlensemblerfNode) -> MlensemblerfNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_rf_node_copy(s : MlensemblerfNode) -> MlensemblerfNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_node_fill(s : MlensemblerfNode, v : Double) -> MlensemblerfNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_node_min(s : MlensemblerfNode) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_rf_node_max(s : MlensemblerfNode) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_rf_node_to_string(s : MlensemblerfNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblerfEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_rf_edge_make(size : Int) -> MlensemblerfEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_rf_edge_len(s : MlensemblerfEdge) -> Int { s.size }

pub fn ml_ensemble_rf_edge_get(s : MlensemblerfEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_rf_edge_set(s : MlensemblerfEdge, i : Int, v : Double) -> MlensemblerfEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_edge_sum(s : MlensemblerfEdge) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_rf_edge_mean(s : MlensemblerfEdge) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_rf_edge_scale(s : MlensemblerfEdge, f : Double) -> MlensemblerfEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_edge_add(a : MlensemblerfEdge, b : MlensemblerfEdge) -> MlensemblerfEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_rf_edge_copy(s : MlensemblerfEdge) -> MlensemblerfEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_edge_fill(s : MlensemblerfEdge, v : Double) -> MlensemblerfEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_edge_min(s : MlensemblerfEdge) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_rf_edge_max(s : MlensemblerfEdge) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_rf_edge_to_string(s : MlensemblerfEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblerfPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_rf_path_make(size : Int) -> MlensemblerfPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_rf_path_len(s : MlensemblerfPath) -> Int { s.size }

pub fn ml_ensemble_rf_path_get(s : MlensemblerfPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_rf_path_set(s : MlensemblerfPath, i : Int, v : Double) -> MlensemblerfPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_path_sum(s : MlensemblerfPath) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_rf_path_mean(s : MlensemblerfPath) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_rf_path_scale(s : MlensemblerfPath, f : Double) -> MlensemblerfPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_path_add(a : MlensemblerfPath, b : MlensemblerfPath) -> MlensemblerfPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_rf_path_copy(s : MlensemblerfPath) -> MlensemblerfPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_path_fill(s : MlensemblerfPath, v : Double) -> MlensemblerfPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_path_min(s : MlensemblerfPath) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_rf_path_max(s : MlensemblerfPath) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_rf_path_to_string(s : MlensemblerfPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblerfCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_rf_cluster_make(size : Int) -> MlensemblerfCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_rf_cluster_len(s : MlensemblerfCluster) -> Int { s.size }

pub fn ml_ensemble_rf_cluster_get(s : MlensemblerfCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_rf_cluster_set(s : MlensemblerfCluster, i : Int, v : Double) -> MlensemblerfCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_cluster_sum(s : MlensemblerfCluster) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_rf_cluster_mean(s : MlensemblerfCluster) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_rf_cluster_scale(s : MlensemblerfCluster, f : Double) -> MlensemblerfCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_cluster_add(a : MlensemblerfCluster, b : MlensemblerfCluster) -> MlensemblerfCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_rf_cluster_copy(s : MlensemblerfCluster) -> MlensemblerfCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_cluster_fill(s : MlensemblerfCluster, v : Double) -> MlensemblerfCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_cluster_min(s : MlensemblerfCluster) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_rf_cluster_max(s : MlensemblerfCluster) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_rf_cluster_to_string(s : MlensemblerfCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblerfModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_rf_model_make(size : Int) -> MlensemblerfModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_rf_model_len(s : MlensemblerfModel) -> Int { s.size }

pub fn ml_ensemble_rf_model_get(s : MlensemblerfModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_rf_model_set(s : MlensemblerfModel, i : Int, v : Double) -> MlensemblerfModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_model_sum(s : MlensemblerfModel) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_rf_model_mean(s : MlensemblerfModel) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_rf_model_scale(s : MlensemblerfModel, f : Double) -> MlensemblerfModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_model_add(a : MlensemblerfModel, b : MlensemblerfModel) -> MlensemblerfModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_rf_model_copy(s : MlensemblerfModel) -> MlensemblerfModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_model_fill(s : MlensemblerfModel, v : Double) -> MlensemblerfModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_model_min(s : MlensemblerfModel) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_rf_model_max(s : MlensemblerfModel) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_rf_model_to_string(s : MlensemblerfModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblerfLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_rf_layer_make(size : Int) -> MlensemblerfLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_rf_layer_len(s : MlensemblerfLayer) -> Int { s.size }

pub fn ml_ensemble_rf_layer_get(s : MlensemblerfLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_rf_layer_set(s : MlensemblerfLayer, i : Int, v : Double) -> MlensemblerfLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_layer_sum(s : MlensemblerfLayer) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_rf_layer_mean(s : MlensemblerfLayer) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_rf_layer_scale(s : MlensemblerfLayer, f : Double) -> MlensemblerfLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_layer_add(a : MlensemblerfLayer, b : MlensemblerfLayer) -> MlensemblerfLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_rf_layer_copy(s : MlensemblerfLayer) -> MlensemblerfLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_layer_fill(s : MlensemblerfLayer, v : Double) -> MlensemblerfLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_layer_min(s : MlensemblerfLayer) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_rf_layer_max(s : MlensemblerfLayer) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_rf_layer_to_string(s : MlensemblerfLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblerfBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_rf_buffer_make(size : Int) -> MlensemblerfBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_rf_buffer_len(s : MlensemblerfBuffer) -> Int { s.size }

pub fn ml_ensemble_rf_buffer_get(s : MlensemblerfBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_rf_buffer_set(s : MlensemblerfBuffer, i : Int, v : Double) -> MlensemblerfBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_buffer_sum(s : MlensemblerfBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_rf_buffer_mean(s : MlensemblerfBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_rf_buffer_scale(s : MlensemblerfBuffer, f : Double) -> MlensemblerfBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_buffer_add(a : MlensemblerfBuffer, b : MlensemblerfBuffer) -> MlensemblerfBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_rf_buffer_copy(s : MlensemblerfBuffer) -> MlensemblerfBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_buffer_fill(s : MlensemblerfBuffer, v : Double) -> MlensemblerfBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_buffer_min(s : MlensemblerfBuffer) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_rf_buffer_max(s : MlensemblerfBuffer) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_rf_buffer_to_string(s : MlensemblerfBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblerfCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_rf_cursor_make(size : Int) -> MlensemblerfCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_rf_cursor_len(s : MlensemblerfCursor) -> Int { s.size }

pub fn ml_ensemble_rf_cursor_get(s : MlensemblerfCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_rf_cursor_set(s : MlensemblerfCursor, i : Int, v : Double) -> MlensemblerfCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_cursor_sum(s : MlensemblerfCursor) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_rf_cursor_mean(s : MlensemblerfCursor) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_rf_cursor_scale(s : MlensemblerfCursor, f : Double) -> MlensemblerfCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_cursor_add(a : MlensemblerfCursor, b : MlensemblerfCursor) -> MlensemblerfCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_rf_cursor_copy(s : MlensemblerfCursor) -> MlensemblerfCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_cursor_fill(s : MlensemblerfCursor, v : Double) -> MlensemblerfCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_cursor_min(s : MlensemblerfCursor) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_rf_cursor_max(s : MlensemblerfCursor) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_rf_cursor_to_string(s : MlensemblerfCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblerfView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_rf_view_make(size : Int) -> MlensemblerfView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_rf_view_len(s : MlensemblerfView) -> Int { s.size }

pub fn ml_ensemble_rf_view_get(s : MlensemblerfView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_rf_view_set(s : MlensemblerfView, i : Int, v : Double) -> MlensemblerfView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_view_sum(s : MlensemblerfView) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_rf_view_mean(s : MlensemblerfView) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_rf_view_scale(s : MlensemblerfView, f : Double) -> MlensemblerfView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_view_add(a : MlensemblerfView, b : MlensemblerfView) -> MlensemblerfView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_rf_view_copy(s : MlensemblerfView) -> MlensemblerfView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_view_fill(s : MlensemblerfView, v : Double) -> MlensemblerfView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_view_min(s : MlensemblerfView) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_rf_view_max(s : MlensemblerfView) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_rf_view_to_string(s : MlensemblerfView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblerfRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_rf_range_make(size : Int) -> MlensemblerfRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_rf_range_len(s : MlensemblerfRange) -> Int { s.size }

pub fn ml_ensemble_rf_range_get(s : MlensemblerfRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_rf_range_set(s : MlensemblerfRange, i : Int, v : Double) -> MlensemblerfRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_range_sum(s : MlensemblerfRange) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_rf_range_mean(s : MlensemblerfRange) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_rf_range_scale(s : MlensemblerfRange, f : Double) -> MlensemblerfRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_range_add(a : MlensemblerfRange, b : MlensemblerfRange) -> MlensemblerfRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_rf_range_copy(s : MlensemblerfRange) -> MlensemblerfRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_range_fill(s : MlensemblerfRange, v : Double) -> MlensemblerfRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_range_min(s : MlensemblerfRange) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_rf_range_max(s : MlensemblerfRange) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_rf_range_to_string(s : MlensemblerfRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblerfSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_rf_slice_make(size : Int) -> MlensemblerfSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_rf_slice_len(s : MlensemblerfSlice) -> Int { s.size }

pub fn ml_ensemble_rf_slice_get(s : MlensemblerfSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_rf_slice_set(s : MlensemblerfSlice, i : Int, v : Double) -> MlensemblerfSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_slice_sum(s : MlensemblerfSlice) -> Double { @_common.sum(s.data) }

pub fn ml_ensemble_rf_slice_mean(s : MlensemblerfSlice) -> Double { @_common.mean(s.data) }

pub fn ml_ensemble_rf_slice_scale(s : MlensemblerfSlice, f : Double) -> MlensemblerfSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_slice_add(a : MlensemblerfSlice, b : MlensemblerfSlice) -> MlensemblerfSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_ensemble_rf_slice_copy(s : MlensemblerfSlice) -> MlensemblerfSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_slice_fill(s : MlensemblerfSlice, v : Double) -> MlensemblerfSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_ensemble_rf_slice_min(s : MlensemblerfSlice) -> Double { @_common.min(s.data) }

pub fn ml_ensemble_rf_slice_max(s : MlensemblerfSlice) -> Double { @_common.max(s.data) }

pub fn ml_ensemble_rf_slice_to_string(s : MlensemblerfSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

