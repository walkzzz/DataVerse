///===
/// extcore/stats_infer_param

pub(all) struct StatsinferparamPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_infer_param_make_point(x : Double, y : Double) -> StatsinferparamPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_infer_param_make_point3(x : Double, y : Double, z : Double) -> StatsinferparamPoint {
  { x, y, z, label: 0 }
}

pub fn StatsinferparamPoint::x(self : StatsinferparamPoint) -> Double { self.x }

pub fn StatsinferparamPoint::y(self : StatsinferparamPoint) -> Double { self.y }

pub fn StatsinferparamPoint::z(self : StatsinferparamPoint) -> Double { self.z }

pub fn StatsinferparamPoint::label(self : StatsinferparamPoint) -> Int { self.label }

pub fn StatsinferparamPoint::dist(self : StatsinferparamPoint, other : StatsinferparamPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsinferparamPoint::add(self : StatsinferparamPoint, other : StatsinferparamPoint) -> StatsinferparamPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsinferparamPoint::sub(self : StatsinferparamPoint, other : StatsinferparamPoint) -> StatsinferparamPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsinferparamPoint::scale(self : StatsinferparamPoint, s : Double) -> StatsinferparamPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsinferparamPoint::dot(self : StatsinferparamPoint, other : StatsinferparamPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsinferparamPoint::cross(self : StatsinferparamPoint, other : StatsinferparamPoint) -> StatsinferparamPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsinferparamPoint::norm(self : StatsinferparamPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsinferparamPoint::normalize(self : StatsinferparamPoint) -> StatsinferparamPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsinferparamPoint::negate(self : StatsinferparamPoint) -> StatsinferparamPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsinferparamPoint::mid(self : StatsinferparamPoint, other : StatsinferparamPoint) -> StatsinferparamPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsinferparamPoint::lerp(self : StatsinferparamPoint, other : StatsinferparamPoint, t : Double) -> StatsinferparamPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsinferparamPoint::to_string(self : StatsinferparamPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsinferparamSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_infer_param_make_series(vals : Array[Double], name : String) -> StatsinferparamSeries {
  { vals, name, meta: 0 }
}

pub fn StatsinferparamSeries::len(self : StatsinferparamSeries) -> Int { self.vals.length() }

pub fn StatsinferparamSeries::sum(self : StatsinferparamSeries) -> Double { @_common.sum(self.vals) }

pub fn StatsinferparamSeries::mean(self : StatsinferparamSeries) -> Double { @_common.mean(self.vals) }

pub fn StatsinferparamSeries::min(self : StatsinferparamSeries) -> Double { @_common.min(self.vals) }

pub fn StatsinferparamSeries::max(self : StatsinferparamSeries) -> Double { @_common.max(self.vals) }

pub fn StatsinferparamSeries::range(self : StatsinferparamSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsinferparamSeries::variance(self : StatsinferparamSeries) -> Double { @_common.variance(self.vals) }

pub fn StatsinferparamSeries::std(self : StatsinferparamSeries) -> Double { @_common.std(self.vals) }

pub fn StatsinferparamSeries::median(self : StatsinferparamSeries) -> Double { @_common.median(self.vals) }

pub fn StatsinferparamSeries::scale(self : StatsinferparamSeries, f : Double) -> StatsinferparamSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsinferparamSeries::add(self : StatsinferparamSeries, other : StatsinferparamSeries) -> StatsinferparamSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsinferparamSeries::sub(self : StatsinferparamSeries, other : StatsinferparamSeries) -> StatsinferparamSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsinferparamSeries::normalize(self : StatsinferparamSeries) -> StatsinferparamSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsinferparamSeries::cumsum(self : StatsinferparamSeries) -> StatsinferparamSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsinferparamSeries::to_string(self : StatsinferparamSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsinferparamMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_infer_param_make_matrix(rows : Int, cols : Int, val : Double) -> StatsinferparamMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_infer_param_matrix_identity(n : Int) -> StatsinferparamMatrix {
  let m = stats_infer_param_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsinferparamMatrix::get(self : StatsinferparamMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsinferparamMatrix::transpose(self : StatsinferparamMatrix) -> StatsinferparamMatrix {
  let result = stats_infer_param_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsinferparamMatrix::add(self : StatsinferparamMatrix, other : StatsinferparamMatrix) -> StatsinferparamMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_infer_param_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsinferparamMatrix::scale(self : StatsinferparamMatrix, s : Double) -> StatsinferparamMatrix {
  let result = stats_infer_param_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsinferparamMatrix::multiply(self : StatsinferparamMatrix, other : StatsinferparamMatrix) -> StatsinferparamMatrix {
  if self.cols != other.rows { return stats_infer_param_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_infer_param_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn StatsinferparamMatrix::trace(self : StatsinferparamMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsinferparamMatrix::det(self : StatsinferparamMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsinferparamMatrix::norm(self : StatsinferparamMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsinferparamMatrix::to_string(self : StatsinferparamMatrix) -> String {
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

pub(all) struct StatsinferparamVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_infer_param_make_vector(comps : Array[Double]) -> StatsinferparamVector {
  { comps, dim: comps.length() }
}

pub fn stats_infer_param_vector_zero(dim : Int) -> StatsinferparamVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsinferparamVector::add(self : StatsinferparamVector, other : StatsinferparamVector) -> StatsinferparamVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsinferparamVector::sub(self : StatsinferparamVector, other : StatsinferparamVector) -> StatsinferparamVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsinferparamVector::scale(self : StatsinferparamVector, s : Double) -> StatsinferparamVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsinferparamVector::dot(self : StatsinferparamVector, other : StatsinferparamVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsinferparamVector::norm(self : StatsinferparamVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsinferparamVector::normalize(self : StatsinferparamVector) -> StatsinferparamVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsinferparamVector::dist(self : StatsinferparamVector, other : StatsinferparamVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsinferparamVector::to_string(self : StatsinferparamVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_infer_param_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_infer_param_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_infer_param_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_infer_param_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_infer_param_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_infer_param_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_infer_param_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_infer_param_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_infer_param_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_infer_param_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_infer_param_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_infer_param_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_infer_param_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_infer_param_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_infer_param_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_infer_param_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_infer_param_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_infer_param_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_infer_param_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_infer_param_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_infer_param_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_infer_param_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_infer_param_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_infer_param_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_infer_param_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_infer_param_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_infer_param_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_infer_param_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_infer_param_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsinferparamFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_frame_make(size : Int) -> StatsinferparamFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_param_frame_len(s : StatsinferparamFrame) -> Int { s.size }

pub fn stats_infer_param_frame_get(s : StatsinferparamFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_param_frame_set(s : StatsinferparamFrame, i : Int, v : Double) -> StatsinferparamFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_param_frame_sum(s : StatsinferparamFrame) -> Double { @_common.sum(s.data) }

pub fn stats_infer_param_frame_mean(s : StatsinferparamFrame) -> Double { @_common.mean(s.data) }

pub fn stats_infer_param_frame_scale(s : StatsinferparamFrame, f : Double) -> StatsinferparamFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_frame_add(a : StatsinferparamFrame, b : StatsinferparamFrame) -> StatsinferparamFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_param_frame_copy(s : StatsinferparamFrame) -> StatsinferparamFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_frame_fill(s : StatsinferparamFrame, v : Double) -> StatsinferparamFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_frame_min(s : StatsinferparamFrame) -> Double { @_common.min(s.data) }

pub fn stats_infer_param_frame_max(s : StatsinferparamFrame) -> Double { @_common.max(s.data) }

pub fn stats_infer_param_frame_to_string(s : StatsinferparamFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferparamTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_table_make(size : Int) -> StatsinferparamTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_param_table_len(s : StatsinferparamTable) -> Int { s.size }

pub fn stats_infer_param_table_get(s : StatsinferparamTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_param_table_set(s : StatsinferparamTable, i : Int, v : Double) -> StatsinferparamTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_param_table_sum(s : StatsinferparamTable) -> Double { @_common.sum(s.data) }

pub fn stats_infer_param_table_mean(s : StatsinferparamTable) -> Double { @_common.mean(s.data) }

pub fn stats_infer_param_table_scale(s : StatsinferparamTable, f : Double) -> StatsinferparamTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_table_add(a : StatsinferparamTable, b : StatsinferparamTable) -> StatsinferparamTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_param_table_copy(s : StatsinferparamTable) -> StatsinferparamTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_table_fill(s : StatsinferparamTable, v : Double) -> StatsinferparamTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_table_min(s : StatsinferparamTable) -> Double { @_common.min(s.data) }

pub fn stats_infer_param_table_max(s : StatsinferparamTable) -> Double { @_common.max(s.data) }

pub fn stats_infer_param_table_to_string(s : StatsinferparamTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferparamGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_graphn_make(size : Int) -> StatsinferparamGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_param_graphn_len(s : StatsinferparamGraphN) -> Int { s.size }

pub fn stats_infer_param_graphn_get(s : StatsinferparamGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_param_graphn_set(s : StatsinferparamGraphN, i : Int, v : Double) -> StatsinferparamGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_param_graphn_sum(s : StatsinferparamGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_infer_param_graphn_mean(s : StatsinferparamGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_infer_param_graphn_scale(s : StatsinferparamGraphN, f : Double) -> StatsinferparamGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_graphn_add(a : StatsinferparamGraphN, b : StatsinferparamGraphN) -> StatsinferparamGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_param_graphn_copy(s : StatsinferparamGraphN) -> StatsinferparamGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_graphn_fill(s : StatsinferparamGraphN, v : Double) -> StatsinferparamGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_graphn_min(s : StatsinferparamGraphN) -> Double { @_common.min(s.data) }

pub fn stats_infer_param_graphn_max(s : StatsinferparamGraphN) -> Double { @_common.max(s.data) }

pub fn stats_infer_param_graphn_to_string(s : StatsinferparamGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferparamNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_node_make(size : Int) -> StatsinferparamNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_param_node_len(s : StatsinferparamNode) -> Int { s.size }

pub fn stats_infer_param_node_get(s : StatsinferparamNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_param_node_set(s : StatsinferparamNode, i : Int, v : Double) -> StatsinferparamNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_param_node_sum(s : StatsinferparamNode) -> Double { @_common.sum(s.data) }

pub fn stats_infer_param_node_mean(s : StatsinferparamNode) -> Double { @_common.mean(s.data) }

pub fn stats_infer_param_node_scale(s : StatsinferparamNode, f : Double) -> StatsinferparamNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_node_add(a : StatsinferparamNode, b : StatsinferparamNode) -> StatsinferparamNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_param_node_copy(s : StatsinferparamNode) -> StatsinferparamNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_node_fill(s : StatsinferparamNode, v : Double) -> StatsinferparamNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_node_min(s : StatsinferparamNode) -> Double { @_common.min(s.data) }

pub fn stats_infer_param_node_max(s : StatsinferparamNode) -> Double { @_common.max(s.data) }

pub fn stats_infer_param_node_to_string(s : StatsinferparamNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferparamEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_edge_make(size : Int) -> StatsinferparamEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_param_edge_len(s : StatsinferparamEdge) -> Int { s.size }

pub fn stats_infer_param_edge_get(s : StatsinferparamEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_param_edge_set(s : StatsinferparamEdge, i : Int, v : Double) -> StatsinferparamEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_param_edge_sum(s : StatsinferparamEdge) -> Double { @_common.sum(s.data) }

pub fn stats_infer_param_edge_mean(s : StatsinferparamEdge) -> Double { @_common.mean(s.data) }

pub fn stats_infer_param_edge_scale(s : StatsinferparamEdge, f : Double) -> StatsinferparamEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_edge_add(a : StatsinferparamEdge, b : StatsinferparamEdge) -> StatsinferparamEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_param_edge_copy(s : StatsinferparamEdge) -> StatsinferparamEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_edge_fill(s : StatsinferparamEdge, v : Double) -> StatsinferparamEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_edge_min(s : StatsinferparamEdge) -> Double { @_common.min(s.data) }

pub fn stats_infer_param_edge_max(s : StatsinferparamEdge) -> Double { @_common.max(s.data) }

pub fn stats_infer_param_edge_to_string(s : StatsinferparamEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferparamPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_path_make(size : Int) -> StatsinferparamPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_param_path_len(s : StatsinferparamPath) -> Int { s.size }

pub fn stats_infer_param_path_get(s : StatsinferparamPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_param_path_set(s : StatsinferparamPath, i : Int, v : Double) -> StatsinferparamPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_param_path_sum(s : StatsinferparamPath) -> Double { @_common.sum(s.data) }

pub fn stats_infer_param_path_mean(s : StatsinferparamPath) -> Double { @_common.mean(s.data) }

pub fn stats_infer_param_path_scale(s : StatsinferparamPath, f : Double) -> StatsinferparamPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_path_add(a : StatsinferparamPath, b : StatsinferparamPath) -> StatsinferparamPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_param_path_copy(s : StatsinferparamPath) -> StatsinferparamPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_path_fill(s : StatsinferparamPath, v : Double) -> StatsinferparamPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_path_min(s : StatsinferparamPath) -> Double { @_common.min(s.data) }

pub fn stats_infer_param_path_max(s : StatsinferparamPath) -> Double { @_common.max(s.data) }

pub fn stats_infer_param_path_to_string(s : StatsinferparamPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferparamCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_cluster_make(size : Int) -> StatsinferparamCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_param_cluster_len(s : StatsinferparamCluster) -> Int { s.size }

pub fn stats_infer_param_cluster_get(s : StatsinferparamCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_param_cluster_set(s : StatsinferparamCluster, i : Int, v : Double) -> StatsinferparamCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_param_cluster_sum(s : StatsinferparamCluster) -> Double { @_common.sum(s.data) }

pub fn stats_infer_param_cluster_mean(s : StatsinferparamCluster) -> Double { @_common.mean(s.data) }

pub fn stats_infer_param_cluster_scale(s : StatsinferparamCluster, f : Double) -> StatsinferparamCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_cluster_add(a : StatsinferparamCluster, b : StatsinferparamCluster) -> StatsinferparamCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_param_cluster_copy(s : StatsinferparamCluster) -> StatsinferparamCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_cluster_fill(s : StatsinferparamCluster, v : Double) -> StatsinferparamCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_cluster_min(s : StatsinferparamCluster) -> Double { @_common.min(s.data) }

pub fn stats_infer_param_cluster_max(s : StatsinferparamCluster) -> Double { @_common.max(s.data) }

pub fn stats_infer_param_cluster_to_string(s : StatsinferparamCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferparamModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_model_make(size : Int) -> StatsinferparamModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_param_model_len(s : StatsinferparamModel) -> Int { s.size }

pub fn stats_infer_param_model_get(s : StatsinferparamModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_param_model_set(s : StatsinferparamModel, i : Int, v : Double) -> StatsinferparamModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_param_model_sum(s : StatsinferparamModel) -> Double { @_common.sum(s.data) }

pub fn stats_infer_param_model_mean(s : StatsinferparamModel) -> Double { @_common.mean(s.data) }

pub fn stats_infer_param_model_scale(s : StatsinferparamModel, f : Double) -> StatsinferparamModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_model_add(a : StatsinferparamModel, b : StatsinferparamModel) -> StatsinferparamModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_param_model_copy(s : StatsinferparamModel) -> StatsinferparamModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_model_fill(s : StatsinferparamModel, v : Double) -> StatsinferparamModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_model_min(s : StatsinferparamModel) -> Double { @_common.min(s.data) }

pub fn stats_infer_param_model_max(s : StatsinferparamModel) -> Double { @_common.max(s.data) }

pub fn stats_infer_param_model_to_string(s : StatsinferparamModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferparamLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_layer_make(size : Int) -> StatsinferparamLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_param_layer_len(s : StatsinferparamLayer) -> Int { s.size }

pub fn stats_infer_param_layer_get(s : StatsinferparamLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_param_layer_set(s : StatsinferparamLayer, i : Int, v : Double) -> StatsinferparamLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_param_layer_sum(s : StatsinferparamLayer) -> Double { @_common.sum(s.data) }

pub fn stats_infer_param_layer_mean(s : StatsinferparamLayer) -> Double { @_common.mean(s.data) }

pub fn stats_infer_param_layer_scale(s : StatsinferparamLayer, f : Double) -> StatsinferparamLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_layer_add(a : StatsinferparamLayer, b : StatsinferparamLayer) -> StatsinferparamLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_param_layer_copy(s : StatsinferparamLayer) -> StatsinferparamLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_layer_fill(s : StatsinferparamLayer, v : Double) -> StatsinferparamLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_layer_min(s : StatsinferparamLayer) -> Double { @_common.min(s.data) }

pub fn stats_infer_param_layer_max(s : StatsinferparamLayer) -> Double { @_common.max(s.data) }

pub fn stats_infer_param_layer_to_string(s : StatsinferparamLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferparamBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_buffer_make(size : Int) -> StatsinferparamBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_param_buffer_len(s : StatsinferparamBuffer) -> Int { s.size }

pub fn stats_infer_param_buffer_get(s : StatsinferparamBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_param_buffer_set(s : StatsinferparamBuffer, i : Int, v : Double) -> StatsinferparamBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_param_buffer_sum(s : StatsinferparamBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_infer_param_buffer_mean(s : StatsinferparamBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_infer_param_buffer_scale(s : StatsinferparamBuffer, f : Double) -> StatsinferparamBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_buffer_add(a : StatsinferparamBuffer, b : StatsinferparamBuffer) -> StatsinferparamBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_param_buffer_copy(s : StatsinferparamBuffer) -> StatsinferparamBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_buffer_fill(s : StatsinferparamBuffer, v : Double) -> StatsinferparamBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_buffer_min(s : StatsinferparamBuffer) -> Double { @_common.min(s.data) }

pub fn stats_infer_param_buffer_max(s : StatsinferparamBuffer) -> Double { @_common.max(s.data) }

pub fn stats_infer_param_buffer_to_string(s : StatsinferparamBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferparamCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_cursor_make(size : Int) -> StatsinferparamCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_param_cursor_len(s : StatsinferparamCursor) -> Int { s.size }

pub fn stats_infer_param_cursor_get(s : StatsinferparamCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_param_cursor_set(s : StatsinferparamCursor, i : Int, v : Double) -> StatsinferparamCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_param_cursor_sum(s : StatsinferparamCursor) -> Double { @_common.sum(s.data) }

pub fn stats_infer_param_cursor_mean(s : StatsinferparamCursor) -> Double { @_common.mean(s.data) }

pub fn stats_infer_param_cursor_scale(s : StatsinferparamCursor, f : Double) -> StatsinferparamCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_cursor_add(a : StatsinferparamCursor, b : StatsinferparamCursor) -> StatsinferparamCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_param_cursor_copy(s : StatsinferparamCursor) -> StatsinferparamCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_cursor_fill(s : StatsinferparamCursor, v : Double) -> StatsinferparamCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_cursor_min(s : StatsinferparamCursor) -> Double { @_common.min(s.data) }

pub fn stats_infer_param_cursor_max(s : StatsinferparamCursor) -> Double { @_common.max(s.data) }

pub fn stats_infer_param_cursor_to_string(s : StatsinferparamCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferparamView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_view_make(size : Int) -> StatsinferparamView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_param_view_len(s : StatsinferparamView) -> Int { s.size }

pub fn stats_infer_param_view_get(s : StatsinferparamView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_param_view_set(s : StatsinferparamView, i : Int, v : Double) -> StatsinferparamView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_param_view_sum(s : StatsinferparamView) -> Double { @_common.sum(s.data) }

pub fn stats_infer_param_view_mean(s : StatsinferparamView) -> Double { @_common.mean(s.data) }

pub fn stats_infer_param_view_scale(s : StatsinferparamView, f : Double) -> StatsinferparamView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_view_add(a : StatsinferparamView, b : StatsinferparamView) -> StatsinferparamView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_param_view_copy(s : StatsinferparamView) -> StatsinferparamView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_view_fill(s : StatsinferparamView, v : Double) -> StatsinferparamView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_view_min(s : StatsinferparamView) -> Double { @_common.min(s.data) }

pub fn stats_infer_param_view_max(s : StatsinferparamView) -> Double { @_common.max(s.data) }

pub fn stats_infer_param_view_to_string(s : StatsinferparamView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferparamRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_range_make(size : Int) -> StatsinferparamRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_param_range_len(s : StatsinferparamRange) -> Int { s.size }

pub fn stats_infer_param_range_get(s : StatsinferparamRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_param_range_set(s : StatsinferparamRange, i : Int, v : Double) -> StatsinferparamRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_param_range_sum(s : StatsinferparamRange) -> Double { @_common.sum(s.data) }

pub fn stats_infer_param_range_mean(s : StatsinferparamRange) -> Double { @_common.mean(s.data) }

pub fn stats_infer_param_range_scale(s : StatsinferparamRange, f : Double) -> StatsinferparamRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_range_add(a : StatsinferparamRange, b : StatsinferparamRange) -> StatsinferparamRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_param_range_copy(s : StatsinferparamRange) -> StatsinferparamRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_range_fill(s : StatsinferparamRange, v : Double) -> StatsinferparamRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_range_min(s : StatsinferparamRange) -> Double { @_common.min(s.data) }

pub fn stats_infer_param_range_max(s : StatsinferparamRange) -> Double { @_common.max(s.data) }

pub fn stats_infer_param_range_to_string(s : StatsinferparamRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferparamSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_slice_make(size : Int) -> StatsinferparamSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_param_slice_len(s : StatsinferparamSlice) -> Int { s.size }

pub fn stats_infer_param_slice_get(s : StatsinferparamSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_param_slice_set(s : StatsinferparamSlice, i : Int, v : Double) -> StatsinferparamSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_param_slice_sum(s : StatsinferparamSlice) -> Double { @_common.sum(s.data) }

pub fn stats_infer_param_slice_mean(s : StatsinferparamSlice) -> Double { @_common.mean(s.data) }

pub fn stats_infer_param_slice_scale(s : StatsinferparamSlice, f : Double) -> StatsinferparamSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_slice_add(a : StatsinferparamSlice, b : StatsinferparamSlice) -> StatsinferparamSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_param_slice_copy(s : StatsinferparamSlice) -> StatsinferparamSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_slice_fill(s : StatsinferparamSlice, v : Double) -> StatsinferparamSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_param_slice_min(s : StatsinferparamSlice) -> Double { @_common.min(s.data) }

pub fn stats_infer_param_slice_max(s : StatsinferparamSlice) -> Double { @_common.max(s.data) }

pub fn stats_infer_param_slice_to_string(s : StatsinferparamSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

