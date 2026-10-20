///===
/// extcore/ml_rl_dqn

pub(all) struct MlrldqnPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_rl_dqn_make_point(x : Double, y : Double) -> MlrldqnPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_rl_dqn_make_point3(x : Double, y : Double, z : Double) -> MlrldqnPoint {
  { x, y, z, label: 0 }
}

pub fn MlrldqnPoint::x(self : MlrldqnPoint) -> Double { self.x }

pub fn MlrldqnPoint::y(self : MlrldqnPoint) -> Double { self.y }

pub fn MlrldqnPoint::z(self : MlrldqnPoint) -> Double { self.z }

pub fn MlrldqnPoint::label(self : MlrldqnPoint) -> Int { self.label }

pub fn MlrldqnPoint::dist(self : MlrldqnPoint, other : MlrldqnPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlrldqnPoint::add(self : MlrldqnPoint, other : MlrldqnPoint) -> MlrldqnPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlrldqnPoint::sub(self : MlrldqnPoint, other : MlrldqnPoint) -> MlrldqnPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlrldqnPoint::scale(self : MlrldqnPoint, s : Double) -> MlrldqnPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlrldqnPoint::dot(self : MlrldqnPoint, other : MlrldqnPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlrldqnPoint::cross(self : MlrldqnPoint, other : MlrldqnPoint) -> MlrldqnPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlrldqnPoint::norm(self : MlrldqnPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlrldqnPoint::normalize(self : MlrldqnPoint) -> MlrldqnPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlrldqnPoint::negate(self : MlrldqnPoint) -> MlrldqnPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlrldqnPoint::mid(self : MlrldqnPoint, other : MlrldqnPoint) -> MlrldqnPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlrldqnPoint::lerp(self : MlrldqnPoint, other : MlrldqnPoint, t : Double) -> MlrldqnPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlrldqnPoint::to_string(self : MlrldqnPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlrldqnSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_rl_dqn_make_series(vals : Array[Double], name : String) -> MlrldqnSeries {
  { vals, name, meta: 0 }
}

pub fn MlrldqnSeries::len(self : MlrldqnSeries) -> Int { self.vals.length() }

pub fn MlrldqnSeries::sum(self : MlrldqnSeries) -> Double { @_common.sum(self.vals) }

pub fn MlrldqnSeries::mean(self : MlrldqnSeries) -> Double { @_common.mean(self.vals) }

pub fn MlrldqnSeries::min(self : MlrldqnSeries) -> Double { @_common.min(self.vals) }

pub fn MlrldqnSeries::max(self : MlrldqnSeries) -> Double { @_common.max(self.vals) }

pub fn MlrldqnSeries::range(self : MlrldqnSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlrldqnSeries::variance(self : MlrldqnSeries) -> Double { @_common.variance(self.vals) }

pub fn MlrldqnSeries::std(self : MlrldqnSeries) -> Double { @_common.std(self.vals) }

pub fn MlrldqnSeries::median(self : MlrldqnSeries) -> Double { @_common.median(self.vals) }

pub fn MlrldqnSeries::scale(self : MlrldqnSeries, f : Double) -> MlrldqnSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlrldqnSeries::add(self : MlrldqnSeries, other : MlrldqnSeries) -> MlrldqnSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlrldqnSeries::sub(self : MlrldqnSeries, other : MlrldqnSeries) -> MlrldqnSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlrldqnSeries::normalize(self : MlrldqnSeries) -> MlrldqnSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlrldqnSeries::cumsum(self : MlrldqnSeries) -> MlrldqnSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlrldqnSeries::to_string(self : MlrldqnSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlrldqnMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_rl_dqn_make_matrix(rows : Int, cols : Int, val : Double) -> MlrldqnMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_rl_dqn_matrix_identity(n : Int) -> MlrldqnMatrix {
  let m = ml_rl_dqn_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlrldqnMatrix::get(self : MlrldqnMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlrldqnMatrix::transpose(self : MlrldqnMatrix) -> MlrldqnMatrix {
  let result = ml_rl_dqn_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlrldqnMatrix::add(self : MlrldqnMatrix, other : MlrldqnMatrix) -> MlrldqnMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_rl_dqn_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlrldqnMatrix::scale(self : MlrldqnMatrix, s : Double) -> MlrldqnMatrix {
  let result = ml_rl_dqn_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlrldqnMatrix::multiply(self : MlrldqnMatrix, other : MlrldqnMatrix) -> MlrldqnMatrix {
  if self.cols != other.rows { return ml_rl_dqn_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_rl_dqn_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlrldqnMatrix::trace(self : MlrldqnMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlrldqnMatrix::det(self : MlrldqnMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlrldqnMatrix::norm(self : MlrldqnMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlrldqnMatrix::to_string(self : MlrldqnMatrix) -> String {
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

pub(all) struct MlrldqnVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_rl_dqn_make_vector(comps : Array[Double]) -> MlrldqnVector {
  { comps, dim: comps.length() }
}

pub fn ml_rl_dqn_vector_zero(dim : Int) -> MlrldqnVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlrldqnVector::add(self : MlrldqnVector, other : MlrldqnVector) -> MlrldqnVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlrldqnVector::sub(self : MlrldqnVector, other : MlrldqnVector) -> MlrldqnVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlrldqnVector::scale(self : MlrldqnVector, s : Double) -> MlrldqnVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlrldqnVector::dot(self : MlrldqnVector, other : MlrldqnVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlrldqnVector::norm(self : MlrldqnVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlrldqnVector::normalize(self : MlrldqnVector) -> MlrldqnVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlrldqnVector::dist(self : MlrldqnVector, other : MlrldqnVector) -> Double {
  self.sub(other).norm()
}

pub fn MlrldqnVector::to_string(self : MlrldqnVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_rl_dqn_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_rl_dqn_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_rl_dqn_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_rl_dqn_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_rl_dqn_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_rl_dqn_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_rl_dqn_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_rl_dqn_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_rl_dqn_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_rl_dqn_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_rl_dqn_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_rl_dqn_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_rl_dqn_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_rl_dqn_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_rl_dqn_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_rl_dqn_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_rl_dqn_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_rl_dqn_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_rl_dqn_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_rl_dqn_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_rl_dqn_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_rl_dqn_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_rl_dqn_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_rl_dqn_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_rl_dqn_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_rl_dqn_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_rl_dqn_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_rl_dqn_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_rl_dqn_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlrldqnFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_dqn_frame_make(size : Int) -> MlrldqnFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_dqn_frame_len(s : MlrldqnFrame) -> Int { s.size }

pub fn ml_rl_dqn_frame_get(s : MlrldqnFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_dqn_frame_set(s : MlrldqnFrame, i : Int, v : Double) -> MlrldqnFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_frame_sum(s : MlrldqnFrame) -> Double { @_common.sum(s.data) }

pub fn ml_rl_dqn_frame_mean(s : MlrldqnFrame) -> Double { @_common.mean(s.data) }

pub fn ml_rl_dqn_frame_scale(s : MlrldqnFrame, f : Double) -> MlrldqnFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_frame_add(a : MlrldqnFrame, b : MlrldqnFrame) -> MlrldqnFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_dqn_frame_copy(s : MlrldqnFrame) -> MlrldqnFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_frame_fill(s : MlrldqnFrame, v : Double) -> MlrldqnFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_frame_min(s : MlrldqnFrame) -> Double { @_common.min(s.data) }

pub fn ml_rl_dqn_frame_max(s : MlrldqnFrame) -> Double { @_common.max(s.data) }

pub fn ml_rl_dqn_frame_to_string(s : MlrldqnFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrldqnTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_dqn_table_make(size : Int) -> MlrldqnTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_dqn_table_len(s : MlrldqnTable) -> Int { s.size }

pub fn ml_rl_dqn_table_get(s : MlrldqnTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_dqn_table_set(s : MlrldqnTable, i : Int, v : Double) -> MlrldqnTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_table_sum(s : MlrldqnTable) -> Double { @_common.sum(s.data) }

pub fn ml_rl_dqn_table_mean(s : MlrldqnTable) -> Double { @_common.mean(s.data) }

pub fn ml_rl_dqn_table_scale(s : MlrldqnTable, f : Double) -> MlrldqnTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_table_add(a : MlrldqnTable, b : MlrldqnTable) -> MlrldqnTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_dqn_table_copy(s : MlrldqnTable) -> MlrldqnTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_table_fill(s : MlrldqnTable, v : Double) -> MlrldqnTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_table_min(s : MlrldqnTable) -> Double { @_common.min(s.data) }

pub fn ml_rl_dqn_table_max(s : MlrldqnTable) -> Double { @_common.max(s.data) }

pub fn ml_rl_dqn_table_to_string(s : MlrldqnTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrldqnGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_dqn_graphn_make(size : Int) -> MlrldqnGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_dqn_graphn_len(s : MlrldqnGraphN) -> Int { s.size }

pub fn ml_rl_dqn_graphn_get(s : MlrldqnGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_dqn_graphn_set(s : MlrldqnGraphN, i : Int, v : Double) -> MlrldqnGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_graphn_sum(s : MlrldqnGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_rl_dqn_graphn_mean(s : MlrldqnGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_rl_dqn_graphn_scale(s : MlrldqnGraphN, f : Double) -> MlrldqnGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_graphn_add(a : MlrldqnGraphN, b : MlrldqnGraphN) -> MlrldqnGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_dqn_graphn_copy(s : MlrldqnGraphN) -> MlrldqnGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_graphn_fill(s : MlrldqnGraphN, v : Double) -> MlrldqnGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_graphn_min(s : MlrldqnGraphN) -> Double { @_common.min(s.data) }

pub fn ml_rl_dqn_graphn_max(s : MlrldqnGraphN) -> Double { @_common.max(s.data) }

pub fn ml_rl_dqn_graphn_to_string(s : MlrldqnGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrldqnNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_dqn_node_make(size : Int) -> MlrldqnNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_dqn_node_len(s : MlrldqnNode) -> Int { s.size }

pub fn ml_rl_dqn_node_get(s : MlrldqnNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_dqn_node_set(s : MlrldqnNode, i : Int, v : Double) -> MlrldqnNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_node_sum(s : MlrldqnNode) -> Double { @_common.sum(s.data) }

pub fn ml_rl_dqn_node_mean(s : MlrldqnNode) -> Double { @_common.mean(s.data) }

pub fn ml_rl_dqn_node_scale(s : MlrldqnNode, f : Double) -> MlrldqnNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_node_add(a : MlrldqnNode, b : MlrldqnNode) -> MlrldqnNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_dqn_node_copy(s : MlrldqnNode) -> MlrldqnNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_node_fill(s : MlrldqnNode, v : Double) -> MlrldqnNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_node_min(s : MlrldqnNode) -> Double { @_common.min(s.data) }

pub fn ml_rl_dqn_node_max(s : MlrldqnNode) -> Double { @_common.max(s.data) }

pub fn ml_rl_dqn_node_to_string(s : MlrldqnNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrldqnEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_dqn_edge_make(size : Int) -> MlrldqnEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_dqn_edge_len(s : MlrldqnEdge) -> Int { s.size }

pub fn ml_rl_dqn_edge_get(s : MlrldqnEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_dqn_edge_set(s : MlrldqnEdge, i : Int, v : Double) -> MlrldqnEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_edge_sum(s : MlrldqnEdge) -> Double { @_common.sum(s.data) }

pub fn ml_rl_dqn_edge_mean(s : MlrldqnEdge) -> Double { @_common.mean(s.data) }

pub fn ml_rl_dqn_edge_scale(s : MlrldqnEdge, f : Double) -> MlrldqnEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_edge_add(a : MlrldqnEdge, b : MlrldqnEdge) -> MlrldqnEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_dqn_edge_copy(s : MlrldqnEdge) -> MlrldqnEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_edge_fill(s : MlrldqnEdge, v : Double) -> MlrldqnEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_edge_min(s : MlrldqnEdge) -> Double { @_common.min(s.data) }

pub fn ml_rl_dqn_edge_max(s : MlrldqnEdge) -> Double { @_common.max(s.data) }

pub fn ml_rl_dqn_edge_to_string(s : MlrldqnEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrldqnPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_dqn_path_make(size : Int) -> MlrldqnPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_dqn_path_len(s : MlrldqnPath) -> Int { s.size }

pub fn ml_rl_dqn_path_get(s : MlrldqnPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_dqn_path_set(s : MlrldqnPath, i : Int, v : Double) -> MlrldqnPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_path_sum(s : MlrldqnPath) -> Double { @_common.sum(s.data) }

pub fn ml_rl_dqn_path_mean(s : MlrldqnPath) -> Double { @_common.mean(s.data) }

pub fn ml_rl_dqn_path_scale(s : MlrldqnPath, f : Double) -> MlrldqnPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_path_add(a : MlrldqnPath, b : MlrldqnPath) -> MlrldqnPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_dqn_path_copy(s : MlrldqnPath) -> MlrldqnPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_path_fill(s : MlrldqnPath, v : Double) -> MlrldqnPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_path_min(s : MlrldqnPath) -> Double { @_common.min(s.data) }

pub fn ml_rl_dqn_path_max(s : MlrldqnPath) -> Double { @_common.max(s.data) }

pub fn ml_rl_dqn_path_to_string(s : MlrldqnPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrldqnCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_dqn_cluster_make(size : Int) -> MlrldqnCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_dqn_cluster_len(s : MlrldqnCluster) -> Int { s.size }

pub fn ml_rl_dqn_cluster_get(s : MlrldqnCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_dqn_cluster_set(s : MlrldqnCluster, i : Int, v : Double) -> MlrldqnCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_cluster_sum(s : MlrldqnCluster) -> Double { @_common.sum(s.data) }

pub fn ml_rl_dqn_cluster_mean(s : MlrldqnCluster) -> Double { @_common.mean(s.data) }

pub fn ml_rl_dqn_cluster_scale(s : MlrldqnCluster, f : Double) -> MlrldqnCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_cluster_add(a : MlrldqnCluster, b : MlrldqnCluster) -> MlrldqnCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_dqn_cluster_copy(s : MlrldqnCluster) -> MlrldqnCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_cluster_fill(s : MlrldqnCluster, v : Double) -> MlrldqnCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_cluster_min(s : MlrldqnCluster) -> Double { @_common.min(s.data) }

pub fn ml_rl_dqn_cluster_max(s : MlrldqnCluster) -> Double { @_common.max(s.data) }

pub fn ml_rl_dqn_cluster_to_string(s : MlrldqnCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrldqnModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_dqn_model_make(size : Int) -> MlrldqnModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_dqn_model_len(s : MlrldqnModel) -> Int { s.size }

pub fn ml_rl_dqn_model_get(s : MlrldqnModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_dqn_model_set(s : MlrldqnModel, i : Int, v : Double) -> MlrldqnModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_model_sum(s : MlrldqnModel) -> Double { @_common.sum(s.data) }

pub fn ml_rl_dqn_model_mean(s : MlrldqnModel) -> Double { @_common.mean(s.data) }

pub fn ml_rl_dqn_model_scale(s : MlrldqnModel, f : Double) -> MlrldqnModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_model_add(a : MlrldqnModel, b : MlrldqnModel) -> MlrldqnModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_dqn_model_copy(s : MlrldqnModel) -> MlrldqnModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_model_fill(s : MlrldqnModel, v : Double) -> MlrldqnModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_model_min(s : MlrldqnModel) -> Double { @_common.min(s.data) }

pub fn ml_rl_dqn_model_max(s : MlrldqnModel) -> Double { @_common.max(s.data) }

pub fn ml_rl_dqn_model_to_string(s : MlrldqnModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrldqnLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_dqn_layer_make(size : Int) -> MlrldqnLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_dqn_layer_len(s : MlrldqnLayer) -> Int { s.size }

pub fn ml_rl_dqn_layer_get(s : MlrldqnLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_dqn_layer_set(s : MlrldqnLayer, i : Int, v : Double) -> MlrldqnLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_layer_sum(s : MlrldqnLayer) -> Double { @_common.sum(s.data) }

pub fn ml_rl_dqn_layer_mean(s : MlrldqnLayer) -> Double { @_common.mean(s.data) }

pub fn ml_rl_dqn_layer_scale(s : MlrldqnLayer, f : Double) -> MlrldqnLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_layer_add(a : MlrldqnLayer, b : MlrldqnLayer) -> MlrldqnLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_dqn_layer_copy(s : MlrldqnLayer) -> MlrldqnLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_layer_fill(s : MlrldqnLayer, v : Double) -> MlrldqnLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_layer_min(s : MlrldqnLayer) -> Double { @_common.min(s.data) }

pub fn ml_rl_dqn_layer_max(s : MlrldqnLayer) -> Double { @_common.max(s.data) }

pub fn ml_rl_dqn_layer_to_string(s : MlrldqnLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrldqnBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_dqn_buffer_make(size : Int) -> MlrldqnBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_dqn_buffer_len(s : MlrldqnBuffer) -> Int { s.size }

pub fn ml_rl_dqn_buffer_get(s : MlrldqnBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_dqn_buffer_set(s : MlrldqnBuffer, i : Int, v : Double) -> MlrldqnBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_buffer_sum(s : MlrldqnBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_rl_dqn_buffer_mean(s : MlrldqnBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_rl_dqn_buffer_scale(s : MlrldqnBuffer, f : Double) -> MlrldqnBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_buffer_add(a : MlrldqnBuffer, b : MlrldqnBuffer) -> MlrldqnBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_dqn_buffer_copy(s : MlrldqnBuffer) -> MlrldqnBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_buffer_fill(s : MlrldqnBuffer, v : Double) -> MlrldqnBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_buffer_min(s : MlrldqnBuffer) -> Double { @_common.min(s.data) }

pub fn ml_rl_dqn_buffer_max(s : MlrldqnBuffer) -> Double { @_common.max(s.data) }

pub fn ml_rl_dqn_buffer_to_string(s : MlrldqnBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrldqnCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_dqn_cursor_make(size : Int) -> MlrldqnCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_dqn_cursor_len(s : MlrldqnCursor) -> Int { s.size }

pub fn ml_rl_dqn_cursor_get(s : MlrldqnCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_dqn_cursor_set(s : MlrldqnCursor, i : Int, v : Double) -> MlrldqnCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_cursor_sum(s : MlrldqnCursor) -> Double { @_common.sum(s.data) }

pub fn ml_rl_dqn_cursor_mean(s : MlrldqnCursor) -> Double { @_common.mean(s.data) }

pub fn ml_rl_dqn_cursor_scale(s : MlrldqnCursor, f : Double) -> MlrldqnCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_cursor_add(a : MlrldqnCursor, b : MlrldqnCursor) -> MlrldqnCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_dqn_cursor_copy(s : MlrldqnCursor) -> MlrldqnCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_cursor_fill(s : MlrldqnCursor, v : Double) -> MlrldqnCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_cursor_min(s : MlrldqnCursor) -> Double { @_common.min(s.data) }

pub fn ml_rl_dqn_cursor_max(s : MlrldqnCursor) -> Double { @_common.max(s.data) }

pub fn ml_rl_dqn_cursor_to_string(s : MlrldqnCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrldqnView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_dqn_view_make(size : Int) -> MlrldqnView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_dqn_view_len(s : MlrldqnView) -> Int { s.size }

pub fn ml_rl_dqn_view_get(s : MlrldqnView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_dqn_view_set(s : MlrldqnView, i : Int, v : Double) -> MlrldqnView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_view_sum(s : MlrldqnView) -> Double { @_common.sum(s.data) }

pub fn ml_rl_dqn_view_mean(s : MlrldqnView) -> Double { @_common.mean(s.data) }

pub fn ml_rl_dqn_view_scale(s : MlrldqnView, f : Double) -> MlrldqnView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_view_add(a : MlrldqnView, b : MlrldqnView) -> MlrldqnView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_dqn_view_copy(s : MlrldqnView) -> MlrldqnView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_view_fill(s : MlrldqnView, v : Double) -> MlrldqnView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_view_min(s : MlrldqnView) -> Double { @_common.min(s.data) }

pub fn ml_rl_dqn_view_max(s : MlrldqnView) -> Double { @_common.max(s.data) }

pub fn ml_rl_dqn_view_to_string(s : MlrldqnView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrldqnRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_dqn_range_make(size : Int) -> MlrldqnRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_dqn_range_len(s : MlrldqnRange) -> Int { s.size }

pub fn ml_rl_dqn_range_get(s : MlrldqnRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_dqn_range_set(s : MlrldqnRange, i : Int, v : Double) -> MlrldqnRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_range_sum(s : MlrldqnRange) -> Double { @_common.sum(s.data) }

pub fn ml_rl_dqn_range_mean(s : MlrldqnRange) -> Double { @_common.mean(s.data) }

pub fn ml_rl_dqn_range_scale(s : MlrldqnRange, f : Double) -> MlrldqnRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_range_add(a : MlrldqnRange, b : MlrldqnRange) -> MlrldqnRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_dqn_range_copy(s : MlrldqnRange) -> MlrldqnRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_range_fill(s : MlrldqnRange, v : Double) -> MlrldqnRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_range_min(s : MlrldqnRange) -> Double { @_common.min(s.data) }

pub fn ml_rl_dqn_range_max(s : MlrldqnRange) -> Double { @_common.max(s.data) }

pub fn ml_rl_dqn_range_to_string(s : MlrldqnRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrldqnSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_dqn_slice_make(size : Int) -> MlrldqnSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_dqn_slice_len(s : MlrldqnSlice) -> Int { s.size }

pub fn ml_rl_dqn_slice_get(s : MlrldqnSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_dqn_slice_set(s : MlrldqnSlice, i : Int, v : Double) -> MlrldqnSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_slice_sum(s : MlrldqnSlice) -> Double { @_common.sum(s.data) }

pub fn ml_rl_dqn_slice_mean(s : MlrldqnSlice) -> Double { @_common.mean(s.data) }

pub fn ml_rl_dqn_slice_scale(s : MlrldqnSlice, f : Double) -> MlrldqnSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_slice_add(a : MlrldqnSlice, b : MlrldqnSlice) -> MlrldqnSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_dqn_slice_copy(s : MlrldqnSlice) -> MlrldqnSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_slice_fill(s : MlrldqnSlice, v : Double) -> MlrldqnSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_dqn_slice_min(s : MlrldqnSlice) -> Double { @_common.min(s.data) }

pub fn ml_rl_dqn_slice_max(s : MlrldqnSlice) -> Double { @_common.max(s.data) }

pub fn ml_rl_dqn_slice_to_string(s : MlrldqnSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

