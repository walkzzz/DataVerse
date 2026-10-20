///===
/// extcore/stats_infer_nonparam

pub(all) struct StatsinfernonparamPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_infer_nonparam_make_point(x : Double, y : Double) -> StatsinfernonparamPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_infer_nonparam_make_point3(x : Double, y : Double, z : Double) -> StatsinfernonparamPoint {
  { x, y, z, label: 0 }
}

pub fn StatsinfernonparamPoint::x(self : StatsinfernonparamPoint) -> Double { self.x }

pub fn StatsinfernonparamPoint::y(self : StatsinfernonparamPoint) -> Double { self.y }

pub fn StatsinfernonparamPoint::z(self : StatsinfernonparamPoint) -> Double { self.z }

pub fn StatsinfernonparamPoint::label(self : StatsinfernonparamPoint) -> Int { self.label }

pub fn StatsinfernonparamPoint::dist(self : StatsinfernonparamPoint, other : StatsinfernonparamPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsinfernonparamPoint::add(self : StatsinfernonparamPoint, other : StatsinfernonparamPoint) -> StatsinfernonparamPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsinfernonparamPoint::sub(self : StatsinfernonparamPoint, other : StatsinfernonparamPoint) -> StatsinfernonparamPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsinfernonparamPoint::scale(self : StatsinfernonparamPoint, s : Double) -> StatsinfernonparamPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsinfernonparamPoint::dot(self : StatsinfernonparamPoint, other : StatsinfernonparamPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsinfernonparamPoint::cross(self : StatsinfernonparamPoint, other : StatsinfernonparamPoint) -> StatsinfernonparamPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsinfernonparamPoint::norm(self : StatsinfernonparamPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsinfernonparamPoint::normalize(self : StatsinfernonparamPoint) -> StatsinfernonparamPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsinfernonparamPoint::negate(self : StatsinfernonparamPoint) -> StatsinfernonparamPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsinfernonparamPoint::mid(self : StatsinfernonparamPoint, other : StatsinfernonparamPoint) -> StatsinfernonparamPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsinfernonparamPoint::lerp(self : StatsinfernonparamPoint, other : StatsinfernonparamPoint, t : Double) -> StatsinfernonparamPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsinfernonparamPoint::to_string(self : StatsinfernonparamPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsinfernonparamSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_infer_nonparam_make_series(vals : Array[Double], name : String) -> StatsinfernonparamSeries {
  { vals, name, meta: 0 }
}

pub fn StatsinfernonparamSeries::len(self : StatsinfernonparamSeries) -> Int { self.vals.length() }

pub fn StatsinfernonparamSeries::sum(self : StatsinfernonparamSeries) -> Double { @_common.sum(self.vals) }

pub fn StatsinfernonparamSeries::mean(self : StatsinfernonparamSeries) -> Double { @_common.mean(self.vals) }

pub fn StatsinfernonparamSeries::min(self : StatsinfernonparamSeries) -> Double { @_common.min(self.vals) }

pub fn StatsinfernonparamSeries::max(self : StatsinfernonparamSeries) -> Double { @_common.max(self.vals) }

pub fn StatsinfernonparamSeries::range(self : StatsinfernonparamSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsinfernonparamSeries::variance(self : StatsinfernonparamSeries) -> Double { @_common.variance(self.vals) }

pub fn StatsinfernonparamSeries::std(self : StatsinfernonparamSeries) -> Double { @_common.std(self.vals) }

pub fn StatsinfernonparamSeries::median(self : StatsinfernonparamSeries) -> Double { @_common.median(self.vals) }

pub fn StatsinfernonparamSeries::scale(self : StatsinfernonparamSeries, f : Double) -> StatsinfernonparamSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsinfernonparamSeries::add(self : StatsinfernonparamSeries, other : StatsinfernonparamSeries) -> StatsinfernonparamSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsinfernonparamSeries::sub(self : StatsinfernonparamSeries, other : StatsinfernonparamSeries) -> StatsinfernonparamSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsinfernonparamSeries::normalize(self : StatsinfernonparamSeries) -> StatsinfernonparamSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsinfernonparamSeries::cumsum(self : StatsinfernonparamSeries) -> StatsinfernonparamSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsinfernonparamSeries::to_string(self : StatsinfernonparamSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsinfernonparamMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_infer_nonparam_make_matrix(rows : Int, cols : Int, val : Double) -> StatsinfernonparamMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_infer_nonparam_matrix_identity(n : Int) -> StatsinfernonparamMatrix {
  let m = stats_infer_nonparam_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsinfernonparamMatrix::get(self : StatsinfernonparamMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsinfernonparamMatrix::transpose(self : StatsinfernonparamMatrix) -> StatsinfernonparamMatrix {
  let result = stats_infer_nonparam_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsinfernonparamMatrix::add(self : StatsinfernonparamMatrix, other : StatsinfernonparamMatrix) -> StatsinfernonparamMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_infer_nonparam_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsinfernonparamMatrix::scale(self : StatsinfernonparamMatrix, s : Double) -> StatsinfernonparamMatrix {
  let result = stats_infer_nonparam_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsinfernonparamMatrix::multiply(self : StatsinfernonparamMatrix, other : StatsinfernonparamMatrix) -> StatsinfernonparamMatrix {
  if self.cols != other.rows { return stats_infer_nonparam_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_infer_nonparam_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn StatsinfernonparamMatrix::trace(self : StatsinfernonparamMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsinfernonparamMatrix::det(self : StatsinfernonparamMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsinfernonparamMatrix::norm(self : StatsinfernonparamMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsinfernonparamMatrix::to_string(self : StatsinfernonparamMatrix) -> String {
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

pub(all) struct StatsinfernonparamVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_infer_nonparam_make_vector(comps : Array[Double]) -> StatsinfernonparamVector {
  { comps, dim: comps.length() }
}

pub fn stats_infer_nonparam_vector_zero(dim : Int) -> StatsinfernonparamVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsinfernonparamVector::add(self : StatsinfernonparamVector, other : StatsinfernonparamVector) -> StatsinfernonparamVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsinfernonparamVector::sub(self : StatsinfernonparamVector, other : StatsinfernonparamVector) -> StatsinfernonparamVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsinfernonparamVector::scale(self : StatsinfernonparamVector, s : Double) -> StatsinfernonparamVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsinfernonparamVector::dot(self : StatsinfernonparamVector, other : StatsinfernonparamVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsinfernonparamVector::norm(self : StatsinfernonparamVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsinfernonparamVector::normalize(self : StatsinfernonparamVector) -> StatsinfernonparamVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsinfernonparamVector::dist(self : StatsinfernonparamVector, other : StatsinfernonparamVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsinfernonparamVector::to_string(self : StatsinfernonparamVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_infer_nonparam_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_infer_nonparam_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_infer_nonparam_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_infer_nonparam_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_infer_nonparam_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_infer_nonparam_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_infer_nonparam_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_infer_nonparam_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_infer_nonparam_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_infer_nonparam_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_infer_nonparam_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_infer_nonparam_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_infer_nonparam_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_infer_nonparam_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_infer_nonparam_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_infer_nonparam_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_infer_nonparam_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_infer_nonparam_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_infer_nonparam_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_infer_nonparam_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_infer_nonparam_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_infer_nonparam_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_infer_nonparam_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_infer_nonparam_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_infer_nonparam_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_infer_nonparam_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_infer_nonparam_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_infer_nonparam_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_infer_nonparam_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsinfernonparamFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_nonparam_frame_make(size : Int) -> StatsinfernonparamFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_nonparam_frame_len(s : StatsinfernonparamFrame) -> Int { s.size }

pub fn stats_infer_nonparam_frame_get(s : StatsinfernonparamFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_nonparam_frame_set(s : StatsinfernonparamFrame, i : Int, v : Double) -> StatsinfernonparamFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_frame_sum(s : StatsinfernonparamFrame) -> Double { @_common.sum(s.data) }

pub fn stats_infer_nonparam_frame_mean(s : StatsinfernonparamFrame) -> Double { @_common.mean(s.data) }

pub fn stats_infer_nonparam_frame_scale(s : StatsinfernonparamFrame, f : Double) -> StatsinfernonparamFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_frame_add(a : StatsinfernonparamFrame, b : StatsinfernonparamFrame) -> StatsinfernonparamFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_nonparam_frame_copy(s : StatsinfernonparamFrame) -> StatsinfernonparamFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_frame_fill(s : StatsinfernonparamFrame, v : Double) -> StatsinfernonparamFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_frame_min(s : StatsinfernonparamFrame) -> Double { @_common.min(s.data) }

pub fn stats_infer_nonparam_frame_max(s : StatsinfernonparamFrame) -> Double { @_common.max(s.data) }

pub fn stats_infer_nonparam_frame_to_string(s : StatsinfernonparamFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinfernonparamTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_nonparam_table_make(size : Int) -> StatsinfernonparamTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_nonparam_table_len(s : StatsinfernonparamTable) -> Int { s.size }

pub fn stats_infer_nonparam_table_get(s : StatsinfernonparamTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_nonparam_table_set(s : StatsinfernonparamTable, i : Int, v : Double) -> StatsinfernonparamTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_table_sum(s : StatsinfernonparamTable) -> Double { @_common.sum(s.data) }

pub fn stats_infer_nonparam_table_mean(s : StatsinfernonparamTable) -> Double { @_common.mean(s.data) }

pub fn stats_infer_nonparam_table_scale(s : StatsinfernonparamTable, f : Double) -> StatsinfernonparamTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_table_add(a : StatsinfernonparamTable, b : StatsinfernonparamTable) -> StatsinfernonparamTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_nonparam_table_copy(s : StatsinfernonparamTable) -> StatsinfernonparamTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_table_fill(s : StatsinfernonparamTable, v : Double) -> StatsinfernonparamTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_table_min(s : StatsinfernonparamTable) -> Double { @_common.min(s.data) }

pub fn stats_infer_nonparam_table_max(s : StatsinfernonparamTable) -> Double { @_common.max(s.data) }

pub fn stats_infer_nonparam_table_to_string(s : StatsinfernonparamTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinfernonparamGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_nonparam_graphn_make(size : Int) -> StatsinfernonparamGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_nonparam_graphn_len(s : StatsinfernonparamGraphN) -> Int { s.size }

pub fn stats_infer_nonparam_graphn_get(s : StatsinfernonparamGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_nonparam_graphn_set(s : StatsinfernonparamGraphN, i : Int, v : Double) -> StatsinfernonparamGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_graphn_sum(s : StatsinfernonparamGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_infer_nonparam_graphn_mean(s : StatsinfernonparamGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_infer_nonparam_graphn_scale(s : StatsinfernonparamGraphN, f : Double) -> StatsinfernonparamGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_graphn_add(a : StatsinfernonparamGraphN, b : StatsinfernonparamGraphN) -> StatsinfernonparamGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_nonparam_graphn_copy(s : StatsinfernonparamGraphN) -> StatsinfernonparamGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_graphn_fill(s : StatsinfernonparamGraphN, v : Double) -> StatsinfernonparamGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_graphn_min(s : StatsinfernonparamGraphN) -> Double { @_common.min(s.data) }

pub fn stats_infer_nonparam_graphn_max(s : StatsinfernonparamGraphN) -> Double { @_common.max(s.data) }

pub fn stats_infer_nonparam_graphn_to_string(s : StatsinfernonparamGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinfernonparamNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_nonparam_node_make(size : Int) -> StatsinfernonparamNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_nonparam_node_len(s : StatsinfernonparamNode) -> Int { s.size }

pub fn stats_infer_nonparam_node_get(s : StatsinfernonparamNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_nonparam_node_set(s : StatsinfernonparamNode, i : Int, v : Double) -> StatsinfernonparamNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_node_sum(s : StatsinfernonparamNode) -> Double { @_common.sum(s.data) }

pub fn stats_infer_nonparam_node_mean(s : StatsinfernonparamNode) -> Double { @_common.mean(s.data) }

pub fn stats_infer_nonparam_node_scale(s : StatsinfernonparamNode, f : Double) -> StatsinfernonparamNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_node_add(a : StatsinfernonparamNode, b : StatsinfernonparamNode) -> StatsinfernonparamNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_nonparam_node_copy(s : StatsinfernonparamNode) -> StatsinfernonparamNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_node_fill(s : StatsinfernonparamNode, v : Double) -> StatsinfernonparamNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_node_min(s : StatsinfernonparamNode) -> Double { @_common.min(s.data) }

pub fn stats_infer_nonparam_node_max(s : StatsinfernonparamNode) -> Double { @_common.max(s.data) }

pub fn stats_infer_nonparam_node_to_string(s : StatsinfernonparamNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinfernonparamEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_nonparam_edge_make(size : Int) -> StatsinfernonparamEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_nonparam_edge_len(s : StatsinfernonparamEdge) -> Int { s.size }

pub fn stats_infer_nonparam_edge_get(s : StatsinfernonparamEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_nonparam_edge_set(s : StatsinfernonparamEdge, i : Int, v : Double) -> StatsinfernonparamEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_edge_sum(s : StatsinfernonparamEdge) -> Double { @_common.sum(s.data) }

pub fn stats_infer_nonparam_edge_mean(s : StatsinfernonparamEdge) -> Double { @_common.mean(s.data) }

pub fn stats_infer_nonparam_edge_scale(s : StatsinfernonparamEdge, f : Double) -> StatsinfernonparamEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_edge_add(a : StatsinfernonparamEdge, b : StatsinfernonparamEdge) -> StatsinfernonparamEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_nonparam_edge_copy(s : StatsinfernonparamEdge) -> StatsinfernonparamEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_edge_fill(s : StatsinfernonparamEdge, v : Double) -> StatsinfernonparamEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_edge_min(s : StatsinfernonparamEdge) -> Double { @_common.min(s.data) }

pub fn stats_infer_nonparam_edge_max(s : StatsinfernonparamEdge) -> Double { @_common.max(s.data) }

pub fn stats_infer_nonparam_edge_to_string(s : StatsinfernonparamEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinfernonparamPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_nonparam_path_make(size : Int) -> StatsinfernonparamPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_nonparam_path_len(s : StatsinfernonparamPath) -> Int { s.size }

pub fn stats_infer_nonparam_path_get(s : StatsinfernonparamPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_nonparam_path_set(s : StatsinfernonparamPath, i : Int, v : Double) -> StatsinfernonparamPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_path_sum(s : StatsinfernonparamPath) -> Double { @_common.sum(s.data) }

pub fn stats_infer_nonparam_path_mean(s : StatsinfernonparamPath) -> Double { @_common.mean(s.data) }

pub fn stats_infer_nonparam_path_scale(s : StatsinfernonparamPath, f : Double) -> StatsinfernonparamPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_path_add(a : StatsinfernonparamPath, b : StatsinfernonparamPath) -> StatsinfernonparamPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_nonparam_path_copy(s : StatsinfernonparamPath) -> StatsinfernonparamPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_path_fill(s : StatsinfernonparamPath, v : Double) -> StatsinfernonparamPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_path_min(s : StatsinfernonparamPath) -> Double { @_common.min(s.data) }

pub fn stats_infer_nonparam_path_max(s : StatsinfernonparamPath) -> Double { @_common.max(s.data) }

pub fn stats_infer_nonparam_path_to_string(s : StatsinfernonparamPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinfernonparamCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_nonparam_cluster_make(size : Int) -> StatsinfernonparamCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_nonparam_cluster_len(s : StatsinfernonparamCluster) -> Int { s.size }

pub fn stats_infer_nonparam_cluster_get(s : StatsinfernonparamCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_nonparam_cluster_set(s : StatsinfernonparamCluster, i : Int, v : Double) -> StatsinfernonparamCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_cluster_sum(s : StatsinfernonparamCluster) -> Double { @_common.sum(s.data) }

pub fn stats_infer_nonparam_cluster_mean(s : StatsinfernonparamCluster) -> Double { @_common.mean(s.data) }

pub fn stats_infer_nonparam_cluster_scale(s : StatsinfernonparamCluster, f : Double) -> StatsinfernonparamCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_cluster_add(a : StatsinfernonparamCluster, b : StatsinfernonparamCluster) -> StatsinfernonparamCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_nonparam_cluster_copy(s : StatsinfernonparamCluster) -> StatsinfernonparamCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_cluster_fill(s : StatsinfernonparamCluster, v : Double) -> StatsinfernonparamCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_cluster_min(s : StatsinfernonparamCluster) -> Double { @_common.min(s.data) }

pub fn stats_infer_nonparam_cluster_max(s : StatsinfernonparamCluster) -> Double { @_common.max(s.data) }

pub fn stats_infer_nonparam_cluster_to_string(s : StatsinfernonparamCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinfernonparamModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_nonparam_model_make(size : Int) -> StatsinfernonparamModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_nonparam_model_len(s : StatsinfernonparamModel) -> Int { s.size }

pub fn stats_infer_nonparam_model_get(s : StatsinfernonparamModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_nonparam_model_set(s : StatsinfernonparamModel, i : Int, v : Double) -> StatsinfernonparamModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_model_sum(s : StatsinfernonparamModel) -> Double { @_common.sum(s.data) }

pub fn stats_infer_nonparam_model_mean(s : StatsinfernonparamModel) -> Double { @_common.mean(s.data) }

pub fn stats_infer_nonparam_model_scale(s : StatsinfernonparamModel, f : Double) -> StatsinfernonparamModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_model_add(a : StatsinfernonparamModel, b : StatsinfernonparamModel) -> StatsinfernonparamModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_nonparam_model_copy(s : StatsinfernonparamModel) -> StatsinfernonparamModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_model_fill(s : StatsinfernonparamModel, v : Double) -> StatsinfernonparamModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_model_min(s : StatsinfernonparamModel) -> Double { @_common.min(s.data) }

pub fn stats_infer_nonparam_model_max(s : StatsinfernonparamModel) -> Double { @_common.max(s.data) }

pub fn stats_infer_nonparam_model_to_string(s : StatsinfernonparamModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinfernonparamLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_nonparam_layer_make(size : Int) -> StatsinfernonparamLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_nonparam_layer_len(s : StatsinfernonparamLayer) -> Int { s.size }

pub fn stats_infer_nonparam_layer_get(s : StatsinfernonparamLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_nonparam_layer_set(s : StatsinfernonparamLayer, i : Int, v : Double) -> StatsinfernonparamLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_layer_sum(s : StatsinfernonparamLayer) -> Double { @_common.sum(s.data) }

pub fn stats_infer_nonparam_layer_mean(s : StatsinfernonparamLayer) -> Double { @_common.mean(s.data) }

pub fn stats_infer_nonparam_layer_scale(s : StatsinfernonparamLayer, f : Double) -> StatsinfernonparamLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_layer_add(a : StatsinfernonparamLayer, b : StatsinfernonparamLayer) -> StatsinfernonparamLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_nonparam_layer_copy(s : StatsinfernonparamLayer) -> StatsinfernonparamLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_layer_fill(s : StatsinfernonparamLayer, v : Double) -> StatsinfernonparamLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_layer_min(s : StatsinfernonparamLayer) -> Double { @_common.min(s.data) }

pub fn stats_infer_nonparam_layer_max(s : StatsinfernonparamLayer) -> Double { @_common.max(s.data) }

pub fn stats_infer_nonparam_layer_to_string(s : StatsinfernonparamLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinfernonparamBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_nonparam_buffer_make(size : Int) -> StatsinfernonparamBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_nonparam_buffer_len(s : StatsinfernonparamBuffer) -> Int { s.size }

pub fn stats_infer_nonparam_buffer_get(s : StatsinfernonparamBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_nonparam_buffer_set(s : StatsinfernonparamBuffer, i : Int, v : Double) -> StatsinfernonparamBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_buffer_sum(s : StatsinfernonparamBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_infer_nonparam_buffer_mean(s : StatsinfernonparamBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_infer_nonparam_buffer_scale(s : StatsinfernonparamBuffer, f : Double) -> StatsinfernonparamBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_buffer_add(a : StatsinfernonparamBuffer, b : StatsinfernonparamBuffer) -> StatsinfernonparamBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_nonparam_buffer_copy(s : StatsinfernonparamBuffer) -> StatsinfernonparamBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_buffer_fill(s : StatsinfernonparamBuffer, v : Double) -> StatsinfernonparamBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_buffer_min(s : StatsinfernonparamBuffer) -> Double { @_common.min(s.data) }

pub fn stats_infer_nonparam_buffer_max(s : StatsinfernonparamBuffer) -> Double { @_common.max(s.data) }

pub fn stats_infer_nonparam_buffer_to_string(s : StatsinfernonparamBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinfernonparamCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_nonparam_cursor_make(size : Int) -> StatsinfernonparamCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_nonparam_cursor_len(s : StatsinfernonparamCursor) -> Int { s.size }

pub fn stats_infer_nonparam_cursor_get(s : StatsinfernonparamCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_nonparam_cursor_set(s : StatsinfernonparamCursor, i : Int, v : Double) -> StatsinfernonparamCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_cursor_sum(s : StatsinfernonparamCursor) -> Double { @_common.sum(s.data) }

pub fn stats_infer_nonparam_cursor_mean(s : StatsinfernonparamCursor) -> Double { @_common.mean(s.data) }

pub fn stats_infer_nonparam_cursor_scale(s : StatsinfernonparamCursor, f : Double) -> StatsinfernonparamCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_cursor_add(a : StatsinfernonparamCursor, b : StatsinfernonparamCursor) -> StatsinfernonparamCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_nonparam_cursor_copy(s : StatsinfernonparamCursor) -> StatsinfernonparamCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_cursor_fill(s : StatsinfernonparamCursor, v : Double) -> StatsinfernonparamCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_cursor_min(s : StatsinfernonparamCursor) -> Double { @_common.min(s.data) }

pub fn stats_infer_nonparam_cursor_max(s : StatsinfernonparamCursor) -> Double { @_common.max(s.data) }

pub fn stats_infer_nonparam_cursor_to_string(s : StatsinfernonparamCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinfernonparamView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_nonparam_view_make(size : Int) -> StatsinfernonparamView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_nonparam_view_len(s : StatsinfernonparamView) -> Int { s.size }

pub fn stats_infer_nonparam_view_get(s : StatsinfernonparamView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_nonparam_view_set(s : StatsinfernonparamView, i : Int, v : Double) -> StatsinfernonparamView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_view_sum(s : StatsinfernonparamView) -> Double { @_common.sum(s.data) }

pub fn stats_infer_nonparam_view_mean(s : StatsinfernonparamView) -> Double { @_common.mean(s.data) }

pub fn stats_infer_nonparam_view_scale(s : StatsinfernonparamView, f : Double) -> StatsinfernonparamView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_view_add(a : StatsinfernonparamView, b : StatsinfernonparamView) -> StatsinfernonparamView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_nonparam_view_copy(s : StatsinfernonparamView) -> StatsinfernonparamView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_view_fill(s : StatsinfernonparamView, v : Double) -> StatsinfernonparamView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_view_min(s : StatsinfernonparamView) -> Double { @_common.min(s.data) }

pub fn stats_infer_nonparam_view_max(s : StatsinfernonparamView) -> Double { @_common.max(s.data) }

pub fn stats_infer_nonparam_view_to_string(s : StatsinfernonparamView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinfernonparamRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_nonparam_range_make(size : Int) -> StatsinfernonparamRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_nonparam_range_len(s : StatsinfernonparamRange) -> Int { s.size }

pub fn stats_infer_nonparam_range_get(s : StatsinfernonparamRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_nonparam_range_set(s : StatsinfernonparamRange, i : Int, v : Double) -> StatsinfernonparamRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_range_sum(s : StatsinfernonparamRange) -> Double { @_common.sum(s.data) }

pub fn stats_infer_nonparam_range_mean(s : StatsinfernonparamRange) -> Double { @_common.mean(s.data) }

pub fn stats_infer_nonparam_range_scale(s : StatsinfernonparamRange, f : Double) -> StatsinfernonparamRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_range_add(a : StatsinfernonparamRange, b : StatsinfernonparamRange) -> StatsinfernonparamRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_nonparam_range_copy(s : StatsinfernonparamRange) -> StatsinfernonparamRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_range_fill(s : StatsinfernonparamRange, v : Double) -> StatsinfernonparamRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_range_min(s : StatsinfernonparamRange) -> Double { @_common.min(s.data) }

pub fn stats_infer_nonparam_range_max(s : StatsinfernonparamRange) -> Double { @_common.max(s.data) }

pub fn stats_infer_nonparam_range_to_string(s : StatsinfernonparamRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinfernonparamSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_nonparam_slice_make(size : Int) -> StatsinfernonparamSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_nonparam_slice_len(s : StatsinfernonparamSlice) -> Int { s.size }

pub fn stats_infer_nonparam_slice_get(s : StatsinfernonparamSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_nonparam_slice_set(s : StatsinfernonparamSlice, i : Int, v : Double) -> StatsinfernonparamSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_slice_sum(s : StatsinfernonparamSlice) -> Double { @_common.sum(s.data) }

pub fn stats_infer_nonparam_slice_mean(s : StatsinfernonparamSlice) -> Double { @_common.mean(s.data) }

pub fn stats_infer_nonparam_slice_scale(s : StatsinfernonparamSlice, f : Double) -> StatsinfernonparamSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_slice_add(a : StatsinfernonparamSlice, b : StatsinfernonparamSlice) -> StatsinfernonparamSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_nonparam_slice_copy(s : StatsinfernonparamSlice) -> StatsinfernonparamSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_slice_fill(s : StatsinfernonparamSlice, v : Double) -> StatsinfernonparamSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_nonparam_slice_min(s : StatsinfernonparamSlice) -> Double { @_common.min(s.data) }

pub fn stats_infer_nonparam_slice_max(s : StatsinfernonparamSlice) -> Double { @_common.max(s.data) }

pub fn stats_infer_nonparam_slice_to_string(s : StatsinfernonparamSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

