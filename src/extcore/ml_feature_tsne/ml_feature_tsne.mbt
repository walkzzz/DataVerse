///===
/// extcore/ml_feature_tsne

pub(all) struct MlfeaturetsnePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_feature_tsne_make_point(x : Double, y : Double) -> MlfeaturetsnePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_feature_tsne_make_point3(x : Double, y : Double, z : Double) -> MlfeaturetsnePoint {
  { x, y, z, label: 0 }
}

pub fn MlfeaturetsnePoint::x(self : MlfeaturetsnePoint) -> Double { self.x }

pub fn MlfeaturetsnePoint::y(self : MlfeaturetsnePoint) -> Double { self.y }

pub fn MlfeaturetsnePoint::z(self : MlfeaturetsnePoint) -> Double { self.z }

pub fn MlfeaturetsnePoint::label(self : MlfeaturetsnePoint) -> Int { self.label }

pub fn MlfeaturetsnePoint::dist(self : MlfeaturetsnePoint, other : MlfeaturetsnePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlfeaturetsnePoint::add(self : MlfeaturetsnePoint, other : MlfeaturetsnePoint) -> MlfeaturetsnePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlfeaturetsnePoint::sub(self : MlfeaturetsnePoint, other : MlfeaturetsnePoint) -> MlfeaturetsnePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlfeaturetsnePoint::scale(self : MlfeaturetsnePoint, s : Double) -> MlfeaturetsnePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlfeaturetsnePoint::dot(self : MlfeaturetsnePoint, other : MlfeaturetsnePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlfeaturetsnePoint::cross(self : MlfeaturetsnePoint, other : MlfeaturetsnePoint) -> MlfeaturetsnePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlfeaturetsnePoint::norm(self : MlfeaturetsnePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlfeaturetsnePoint::normalize(self : MlfeaturetsnePoint) -> MlfeaturetsnePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlfeaturetsnePoint::negate(self : MlfeaturetsnePoint) -> MlfeaturetsnePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlfeaturetsnePoint::mid(self : MlfeaturetsnePoint, other : MlfeaturetsnePoint) -> MlfeaturetsnePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlfeaturetsnePoint::lerp(self : MlfeaturetsnePoint, other : MlfeaturetsnePoint, t : Double) -> MlfeaturetsnePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlfeaturetsnePoint::to_string(self : MlfeaturetsnePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlfeaturetsneSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_feature_tsne_make_series(vals : Array[Double], name : String) -> MlfeaturetsneSeries {
  { vals, name, meta: 0 }
}

pub fn MlfeaturetsneSeries::len(self : MlfeaturetsneSeries) -> Int { self.vals.length() }

pub fn MlfeaturetsneSeries::sum(self : MlfeaturetsneSeries) -> Double { @_common.sum(self.vals) }

pub fn MlfeaturetsneSeries::mean(self : MlfeaturetsneSeries) -> Double { @_common.mean(self.vals) }

pub fn MlfeaturetsneSeries::min(self : MlfeaturetsneSeries) -> Double { @_common.min(self.vals) }

pub fn MlfeaturetsneSeries::max(self : MlfeaturetsneSeries) -> Double { @_common.max(self.vals) }

pub fn MlfeaturetsneSeries::range(self : MlfeaturetsneSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlfeaturetsneSeries::variance(self : MlfeaturetsneSeries) -> Double { @_common.variance(self.vals) }

pub fn MlfeaturetsneSeries::std(self : MlfeaturetsneSeries) -> Double { @_common.std(self.vals) }

pub fn MlfeaturetsneSeries::median(self : MlfeaturetsneSeries) -> Double { @_common.median(self.vals) }

pub fn MlfeaturetsneSeries::scale(self : MlfeaturetsneSeries, f : Double) -> MlfeaturetsneSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlfeaturetsneSeries::add(self : MlfeaturetsneSeries, other : MlfeaturetsneSeries) -> MlfeaturetsneSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlfeaturetsneSeries::sub(self : MlfeaturetsneSeries, other : MlfeaturetsneSeries) -> MlfeaturetsneSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlfeaturetsneSeries::normalize(self : MlfeaturetsneSeries) -> MlfeaturetsneSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlfeaturetsneSeries::cumsum(self : MlfeaturetsneSeries) -> MlfeaturetsneSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlfeaturetsneSeries::to_string(self : MlfeaturetsneSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlfeaturetsneMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_feature_tsne_make_matrix(rows : Int, cols : Int, val : Double) -> MlfeaturetsneMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_feature_tsne_matrix_identity(n : Int) -> MlfeaturetsneMatrix {
  let m = ml_feature_tsne_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlfeaturetsneMatrix::get(self : MlfeaturetsneMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlfeaturetsneMatrix::transpose(self : MlfeaturetsneMatrix) -> MlfeaturetsneMatrix {
  let result = ml_feature_tsne_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlfeaturetsneMatrix::add(self : MlfeaturetsneMatrix, other : MlfeaturetsneMatrix) -> MlfeaturetsneMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_feature_tsne_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlfeaturetsneMatrix::scale(self : MlfeaturetsneMatrix, s : Double) -> MlfeaturetsneMatrix {
  let result = ml_feature_tsne_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlfeaturetsneMatrix::multiply(self : MlfeaturetsneMatrix, other : MlfeaturetsneMatrix) -> MlfeaturetsneMatrix {
  if self.cols != other.rows { return ml_feature_tsne_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_feature_tsne_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlfeaturetsneMatrix::trace(self : MlfeaturetsneMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlfeaturetsneMatrix::det(self : MlfeaturetsneMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlfeaturetsneMatrix::norm(self : MlfeaturetsneMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlfeaturetsneMatrix::to_string(self : MlfeaturetsneMatrix) -> String {
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

pub(all) struct MlfeaturetsneVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_feature_tsne_make_vector(comps : Array[Double]) -> MlfeaturetsneVector {
  { comps, dim: comps.length() }
}

pub fn ml_feature_tsne_vector_zero(dim : Int) -> MlfeaturetsneVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlfeaturetsneVector::add(self : MlfeaturetsneVector, other : MlfeaturetsneVector) -> MlfeaturetsneVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlfeaturetsneVector::sub(self : MlfeaturetsneVector, other : MlfeaturetsneVector) -> MlfeaturetsneVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlfeaturetsneVector::scale(self : MlfeaturetsneVector, s : Double) -> MlfeaturetsneVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlfeaturetsneVector::dot(self : MlfeaturetsneVector, other : MlfeaturetsneVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlfeaturetsneVector::norm(self : MlfeaturetsneVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlfeaturetsneVector::normalize(self : MlfeaturetsneVector) -> MlfeaturetsneVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlfeaturetsneVector::dist(self : MlfeaturetsneVector, other : MlfeaturetsneVector) -> Double {
  self.sub(other).norm()
}

pub fn MlfeaturetsneVector::to_string(self : MlfeaturetsneVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_feature_tsne_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_feature_tsne_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_feature_tsne_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_feature_tsne_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_feature_tsne_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_feature_tsne_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_feature_tsne_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_feature_tsne_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_feature_tsne_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_feature_tsne_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_feature_tsne_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_feature_tsne_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_feature_tsne_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_feature_tsne_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_feature_tsne_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_feature_tsne_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_feature_tsne_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_feature_tsne_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_feature_tsne_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_feature_tsne_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_feature_tsne_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_feature_tsne_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_feature_tsne_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_feature_tsne_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_feature_tsne_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_feature_tsne_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_feature_tsne_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_feature_tsne_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_feature_tsne_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlfeaturetsneFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_tsne_frame_make(size : Int) -> MlfeaturetsneFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_tsne_frame_len(s : MlfeaturetsneFrame) -> Int { s.size }

pub fn ml_feature_tsne_frame_get(s : MlfeaturetsneFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_tsne_frame_set(s : MlfeaturetsneFrame, i : Int, v : Double) -> MlfeaturetsneFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_frame_sum(s : MlfeaturetsneFrame) -> Double { @_common.sum(s.data) }

pub fn ml_feature_tsne_frame_mean(s : MlfeaturetsneFrame) -> Double { @_common.mean(s.data) }

pub fn ml_feature_tsne_frame_scale(s : MlfeaturetsneFrame, f : Double) -> MlfeaturetsneFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_frame_add(a : MlfeaturetsneFrame, b : MlfeaturetsneFrame) -> MlfeaturetsneFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_tsne_frame_copy(s : MlfeaturetsneFrame) -> MlfeaturetsneFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_frame_fill(s : MlfeaturetsneFrame, v : Double) -> MlfeaturetsneFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_frame_min(s : MlfeaturetsneFrame) -> Double { @_common.min(s.data) }

pub fn ml_feature_tsne_frame_max(s : MlfeaturetsneFrame) -> Double { @_common.max(s.data) }

pub fn ml_feature_tsne_frame_to_string(s : MlfeaturetsneFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturetsneTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_tsne_table_make(size : Int) -> MlfeaturetsneTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_tsne_table_len(s : MlfeaturetsneTable) -> Int { s.size }

pub fn ml_feature_tsne_table_get(s : MlfeaturetsneTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_tsne_table_set(s : MlfeaturetsneTable, i : Int, v : Double) -> MlfeaturetsneTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_table_sum(s : MlfeaturetsneTable) -> Double { @_common.sum(s.data) }

pub fn ml_feature_tsne_table_mean(s : MlfeaturetsneTable) -> Double { @_common.mean(s.data) }

pub fn ml_feature_tsne_table_scale(s : MlfeaturetsneTable, f : Double) -> MlfeaturetsneTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_table_add(a : MlfeaturetsneTable, b : MlfeaturetsneTable) -> MlfeaturetsneTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_tsne_table_copy(s : MlfeaturetsneTable) -> MlfeaturetsneTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_table_fill(s : MlfeaturetsneTable, v : Double) -> MlfeaturetsneTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_table_min(s : MlfeaturetsneTable) -> Double { @_common.min(s.data) }

pub fn ml_feature_tsne_table_max(s : MlfeaturetsneTable) -> Double { @_common.max(s.data) }

pub fn ml_feature_tsne_table_to_string(s : MlfeaturetsneTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturetsneGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_tsne_graphn_make(size : Int) -> MlfeaturetsneGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_tsne_graphn_len(s : MlfeaturetsneGraphN) -> Int { s.size }

pub fn ml_feature_tsne_graphn_get(s : MlfeaturetsneGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_tsne_graphn_set(s : MlfeaturetsneGraphN, i : Int, v : Double) -> MlfeaturetsneGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_graphn_sum(s : MlfeaturetsneGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_feature_tsne_graphn_mean(s : MlfeaturetsneGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_feature_tsne_graphn_scale(s : MlfeaturetsneGraphN, f : Double) -> MlfeaturetsneGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_graphn_add(a : MlfeaturetsneGraphN, b : MlfeaturetsneGraphN) -> MlfeaturetsneGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_tsne_graphn_copy(s : MlfeaturetsneGraphN) -> MlfeaturetsneGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_graphn_fill(s : MlfeaturetsneGraphN, v : Double) -> MlfeaturetsneGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_graphn_min(s : MlfeaturetsneGraphN) -> Double { @_common.min(s.data) }

pub fn ml_feature_tsne_graphn_max(s : MlfeaturetsneGraphN) -> Double { @_common.max(s.data) }

pub fn ml_feature_tsne_graphn_to_string(s : MlfeaturetsneGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturetsneNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_tsne_node_make(size : Int) -> MlfeaturetsneNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_tsne_node_len(s : MlfeaturetsneNode) -> Int { s.size }

pub fn ml_feature_tsne_node_get(s : MlfeaturetsneNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_tsne_node_set(s : MlfeaturetsneNode, i : Int, v : Double) -> MlfeaturetsneNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_node_sum(s : MlfeaturetsneNode) -> Double { @_common.sum(s.data) }

pub fn ml_feature_tsne_node_mean(s : MlfeaturetsneNode) -> Double { @_common.mean(s.data) }

pub fn ml_feature_tsne_node_scale(s : MlfeaturetsneNode, f : Double) -> MlfeaturetsneNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_node_add(a : MlfeaturetsneNode, b : MlfeaturetsneNode) -> MlfeaturetsneNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_tsne_node_copy(s : MlfeaturetsneNode) -> MlfeaturetsneNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_node_fill(s : MlfeaturetsneNode, v : Double) -> MlfeaturetsneNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_node_min(s : MlfeaturetsneNode) -> Double { @_common.min(s.data) }

pub fn ml_feature_tsne_node_max(s : MlfeaturetsneNode) -> Double { @_common.max(s.data) }

pub fn ml_feature_tsne_node_to_string(s : MlfeaturetsneNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturetsneEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_tsne_edge_make(size : Int) -> MlfeaturetsneEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_tsne_edge_len(s : MlfeaturetsneEdge) -> Int { s.size }

pub fn ml_feature_tsne_edge_get(s : MlfeaturetsneEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_tsne_edge_set(s : MlfeaturetsneEdge, i : Int, v : Double) -> MlfeaturetsneEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_edge_sum(s : MlfeaturetsneEdge) -> Double { @_common.sum(s.data) }

pub fn ml_feature_tsne_edge_mean(s : MlfeaturetsneEdge) -> Double { @_common.mean(s.data) }

pub fn ml_feature_tsne_edge_scale(s : MlfeaturetsneEdge, f : Double) -> MlfeaturetsneEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_edge_add(a : MlfeaturetsneEdge, b : MlfeaturetsneEdge) -> MlfeaturetsneEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_tsne_edge_copy(s : MlfeaturetsneEdge) -> MlfeaturetsneEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_edge_fill(s : MlfeaturetsneEdge, v : Double) -> MlfeaturetsneEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_edge_min(s : MlfeaturetsneEdge) -> Double { @_common.min(s.data) }

pub fn ml_feature_tsne_edge_max(s : MlfeaturetsneEdge) -> Double { @_common.max(s.data) }

pub fn ml_feature_tsne_edge_to_string(s : MlfeaturetsneEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturetsnePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_tsne_path_make(size : Int) -> MlfeaturetsnePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_tsne_path_len(s : MlfeaturetsnePath) -> Int { s.size }

pub fn ml_feature_tsne_path_get(s : MlfeaturetsnePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_tsne_path_set(s : MlfeaturetsnePath, i : Int, v : Double) -> MlfeaturetsnePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_path_sum(s : MlfeaturetsnePath) -> Double { @_common.sum(s.data) }

pub fn ml_feature_tsne_path_mean(s : MlfeaturetsnePath) -> Double { @_common.mean(s.data) }

pub fn ml_feature_tsne_path_scale(s : MlfeaturetsnePath, f : Double) -> MlfeaturetsnePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_path_add(a : MlfeaturetsnePath, b : MlfeaturetsnePath) -> MlfeaturetsnePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_tsne_path_copy(s : MlfeaturetsnePath) -> MlfeaturetsnePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_path_fill(s : MlfeaturetsnePath, v : Double) -> MlfeaturetsnePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_path_min(s : MlfeaturetsnePath) -> Double { @_common.min(s.data) }

pub fn ml_feature_tsne_path_max(s : MlfeaturetsnePath) -> Double { @_common.max(s.data) }

pub fn ml_feature_tsne_path_to_string(s : MlfeaturetsnePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturetsneCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_tsne_cluster_make(size : Int) -> MlfeaturetsneCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_tsne_cluster_len(s : MlfeaturetsneCluster) -> Int { s.size }

pub fn ml_feature_tsne_cluster_get(s : MlfeaturetsneCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_tsne_cluster_set(s : MlfeaturetsneCluster, i : Int, v : Double) -> MlfeaturetsneCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_cluster_sum(s : MlfeaturetsneCluster) -> Double { @_common.sum(s.data) }

pub fn ml_feature_tsne_cluster_mean(s : MlfeaturetsneCluster) -> Double { @_common.mean(s.data) }

pub fn ml_feature_tsne_cluster_scale(s : MlfeaturetsneCluster, f : Double) -> MlfeaturetsneCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_cluster_add(a : MlfeaturetsneCluster, b : MlfeaturetsneCluster) -> MlfeaturetsneCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_tsne_cluster_copy(s : MlfeaturetsneCluster) -> MlfeaturetsneCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_cluster_fill(s : MlfeaturetsneCluster, v : Double) -> MlfeaturetsneCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_cluster_min(s : MlfeaturetsneCluster) -> Double { @_common.min(s.data) }

pub fn ml_feature_tsne_cluster_max(s : MlfeaturetsneCluster) -> Double { @_common.max(s.data) }

pub fn ml_feature_tsne_cluster_to_string(s : MlfeaturetsneCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturetsneModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_tsne_model_make(size : Int) -> MlfeaturetsneModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_tsne_model_len(s : MlfeaturetsneModel) -> Int { s.size }

pub fn ml_feature_tsne_model_get(s : MlfeaturetsneModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_tsne_model_set(s : MlfeaturetsneModel, i : Int, v : Double) -> MlfeaturetsneModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_model_sum(s : MlfeaturetsneModel) -> Double { @_common.sum(s.data) }

pub fn ml_feature_tsne_model_mean(s : MlfeaturetsneModel) -> Double { @_common.mean(s.data) }

pub fn ml_feature_tsne_model_scale(s : MlfeaturetsneModel, f : Double) -> MlfeaturetsneModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_model_add(a : MlfeaturetsneModel, b : MlfeaturetsneModel) -> MlfeaturetsneModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_tsne_model_copy(s : MlfeaturetsneModel) -> MlfeaturetsneModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_model_fill(s : MlfeaturetsneModel, v : Double) -> MlfeaturetsneModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_model_min(s : MlfeaturetsneModel) -> Double { @_common.min(s.data) }

pub fn ml_feature_tsne_model_max(s : MlfeaturetsneModel) -> Double { @_common.max(s.data) }

pub fn ml_feature_tsne_model_to_string(s : MlfeaturetsneModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturetsneLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_tsne_layer_make(size : Int) -> MlfeaturetsneLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_tsne_layer_len(s : MlfeaturetsneLayer) -> Int { s.size }

pub fn ml_feature_tsne_layer_get(s : MlfeaturetsneLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_tsne_layer_set(s : MlfeaturetsneLayer, i : Int, v : Double) -> MlfeaturetsneLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_layer_sum(s : MlfeaturetsneLayer) -> Double { @_common.sum(s.data) }

pub fn ml_feature_tsne_layer_mean(s : MlfeaturetsneLayer) -> Double { @_common.mean(s.data) }

pub fn ml_feature_tsne_layer_scale(s : MlfeaturetsneLayer, f : Double) -> MlfeaturetsneLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_layer_add(a : MlfeaturetsneLayer, b : MlfeaturetsneLayer) -> MlfeaturetsneLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_tsne_layer_copy(s : MlfeaturetsneLayer) -> MlfeaturetsneLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_layer_fill(s : MlfeaturetsneLayer, v : Double) -> MlfeaturetsneLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_layer_min(s : MlfeaturetsneLayer) -> Double { @_common.min(s.data) }

pub fn ml_feature_tsne_layer_max(s : MlfeaturetsneLayer) -> Double { @_common.max(s.data) }

pub fn ml_feature_tsne_layer_to_string(s : MlfeaturetsneLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturetsneBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_tsne_buffer_make(size : Int) -> MlfeaturetsneBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_tsne_buffer_len(s : MlfeaturetsneBuffer) -> Int { s.size }

pub fn ml_feature_tsne_buffer_get(s : MlfeaturetsneBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_tsne_buffer_set(s : MlfeaturetsneBuffer, i : Int, v : Double) -> MlfeaturetsneBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_buffer_sum(s : MlfeaturetsneBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_feature_tsne_buffer_mean(s : MlfeaturetsneBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_feature_tsne_buffer_scale(s : MlfeaturetsneBuffer, f : Double) -> MlfeaturetsneBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_buffer_add(a : MlfeaturetsneBuffer, b : MlfeaturetsneBuffer) -> MlfeaturetsneBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_tsne_buffer_copy(s : MlfeaturetsneBuffer) -> MlfeaturetsneBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_buffer_fill(s : MlfeaturetsneBuffer, v : Double) -> MlfeaturetsneBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_buffer_min(s : MlfeaturetsneBuffer) -> Double { @_common.min(s.data) }

pub fn ml_feature_tsne_buffer_max(s : MlfeaturetsneBuffer) -> Double { @_common.max(s.data) }

pub fn ml_feature_tsne_buffer_to_string(s : MlfeaturetsneBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturetsneCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_tsne_cursor_make(size : Int) -> MlfeaturetsneCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_tsne_cursor_len(s : MlfeaturetsneCursor) -> Int { s.size }

pub fn ml_feature_tsne_cursor_get(s : MlfeaturetsneCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_tsne_cursor_set(s : MlfeaturetsneCursor, i : Int, v : Double) -> MlfeaturetsneCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_cursor_sum(s : MlfeaturetsneCursor) -> Double { @_common.sum(s.data) }

pub fn ml_feature_tsne_cursor_mean(s : MlfeaturetsneCursor) -> Double { @_common.mean(s.data) }

pub fn ml_feature_tsne_cursor_scale(s : MlfeaturetsneCursor, f : Double) -> MlfeaturetsneCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_cursor_add(a : MlfeaturetsneCursor, b : MlfeaturetsneCursor) -> MlfeaturetsneCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_tsne_cursor_copy(s : MlfeaturetsneCursor) -> MlfeaturetsneCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_cursor_fill(s : MlfeaturetsneCursor, v : Double) -> MlfeaturetsneCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_cursor_min(s : MlfeaturetsneCursor) -> Double { @_common.min(s.data) }

pub fn ml_feature_tsne_cursor_max(s : MlfeaturetsneCursor) -> Double { @_common.max(s.data) }

pub fn ml_feature_tsne_cursor_to_string(s : MlfeaturetsneCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturetsneView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_tsne_view_make(size : Int) -> MlfeaturetsneView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_tsne_view_len(s : MlfeaturetsneView) -> Int { s.size }

pub fn ml_feature_tsne_view_get(s : MlfeaturetsneView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_tsne_view_set(s : MlfeaturetsneView, i : Int, v : Double) -> MlfeaturetsneView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_view_sum(s : MlfeaturetsneView) -> Double { @_common.sum(s.data) }

pub fn ml_feature_tsne_view_mean(s : MlfeaturetsneView) -> Double { @_common.mean(s.data) }

pub fn ml_feature_tsne_view_scale(s : MlfeaturetsneView, f : Double) -> MlfeaturetsneView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_view_add(a : MlfeaturetsneView, b : MlfeaturetsneView) -> MlfeaturetsneView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_tsne_view_copy(s : MlfeaturetsneView) -> MlfeaturetsneView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_view_fill(s : MlfeaturetsneView, v : Double) -> MlfeaturetsneView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_view_min(s : MlfeaturetsneView) -> Double { @_common.min(s.data) }

pub fn ml_feature_tsne_view_max(s : MlfeaturetsneView) -> Double { @_common.max(s.data) }

pub fn ml_feature_tsne_view_to_string(s : MlfeaturetsneView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturetsneRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_tsne_range_make(size : Int) -> MlfeaturetsneRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_tsne_range_len(s : MlfeaturetsneRange) -> Int { s.size }

pub fn ml_feature_tsne_range_get(s : MlfeaturetsneRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_tsne_range_set(s : MlfeaturetsneRange, i : Int, v : Double) -> MlfeaturetsneRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_range_sum(s : MlfeaturetsneRange) -> Double { @_common.sum(s.data) }

pub fn ml_feature_tsne_range_mean(s : MlfeaturetsneRange) -> Double { @_common.mean(s.data) }

pub fn ml_feature_tsne_range_scale(s : MlfeaturetsneRange, f : Double) -> MlfeaturetsneRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_range_add(a : MlfeaturetsneRange, b : MlfeaturetsneRange) -> MlfeaturetsneRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_tsne_range_copy(s : MlfeaturetsneRange) -> MlfeaturetsneRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_range_fill(s : MlfeaturetsneRange, v : Double) -> MlfeaturetsneRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_range_min(s : MlfeaturetsneRange) -> Double { @_common.min(s.data) }

pub fn ml_feature_tsne_range_max(s : MlfeaturetsneRange) -> Double { @_common.max(s.data) }

pub fn ml_feature_tsne_range_to_string(s : MlfeaturetsneRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturetsneSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_tsne_slice_make(size : Int) -> MlfeaturetsneSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_tsne_slice_len(s : MlfeaturetsneSlice) -> Int { s.size }

pub fn ml_feature_tsne_slice_get(s : MlfeaturetsneSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_tsne_slice_set(s : MlfeaturetsneSlice, i : Int, v : Double) -> MlfeaturetsneSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_slice_sum(s : MlfeaturetsneSlice) -> Double { @_common.sum(s.data) }

pub fn ml_feature_tsne_slice_mean(s : MlfeaturetsneSlice) -> Double { @_common.mean(s.data) }

pub fn ml_feature_tsne_slice_scale(s : MlfeaturetsneSlice, f : Double) -> MlfeaturetsneSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_slice_add(a : MlfeaturetsneSlice, b : MlfeaturetsneSlice) -> MlfeaturetsneSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_tsne_slice_copy(s : MlfeaturetsneSlice) -> MlfeaturetsneSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_slice_fill(s : MlfeaturetsneSlice, v : Double) -> MlfeaturetsneSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_tsne_slice_min(s : MlfeaturetsneSlice) -> Double { @_common.min(s.data) }

pub fn ml_feature_tsne_slice_max(s : MlfeaturetsneSlice) -> Double { @_common.max(s.data) }

pub fn ml_feature_tsne_slice_to_string(s : MlfeaturetsneSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

