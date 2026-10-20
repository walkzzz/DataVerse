///===
/// extcore/ml_rl_actor_critic

pub(all) struct MlrlactorcriticPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_rl_actor_critic_make_point(x : Double, y : Double) -> MlrlactorcriticPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_rl_actor_critic_make_point3(x : Double, y : Double, z : Double) -> MlrlactorcriticPoint {
  { x, y, z, label: 0 }
}

pub fn MlrlactorcriticPoint::x(self : MlrlactorcriticPoint) -> Double { self.x }

pub fn MlrlactorcriticPoint::y(self : MlrlactorcriticPoint) -> Double { self.y }

pub fn MlrlactorcriticPoint::z(self : MlrlactorcriticPoint) -> Double { self.z }

pub fn MlrlactorcriticPoint::label(self : MlrlactorcriticPoint) -> Int { self.label }

pub fn MlrlactorcriticPoint::dist(self : MlrlactorcriticPoint, other : MlrlactorcriticPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlrlactorcriticPoint::add(self : MlrlactorcriticPoint, other : MlrlactorcriticPoint) -> MlrlactorcriticPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlrlactorcriticPoint::sub(self : MlrlactorcriticPoint, other : MlrlactorcriticPoint) -> MlrlactorcriticPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlrlactorcriticPoint::scale(self : MlrlactorcriticPoint, s : Double) -> MlrlactorcriticPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlrlactorcriticPoint::dot(self : MlrlactorcriticPoint, other : MlrlactorcriticPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlrlactorcriticPoint::cross(self : MlrlactorcriticPoint, other : MlrlactorcriticPoint) -> MlrlactorcriticPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlrlactorcriticPoint::norm(self : MlrlactorcriticPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlrlactorcriticPoint::normalize(self : MlrlactorcriticPoint) -> MlrlactorcriticPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlrlactorcriticPoint::negate(self : MlrlactorcriticPoint) -> MlrlactorcriticPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlrlactorcriticPoint::mid(self : MlrlactorcriticPoint, other : MlrlactorcriticPoint) -> MlrlactorcriticPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlrlactorcriticPoint::lerp(self : MlrlactorcriticPoint, other : MlrlactorcriticPoint, t : Double) -> MlrlactorcriticPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlrlactorcriticPoint::to_string(self : MlrlactorcriticPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlrlactorcriticSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_rl_actor_critic_make_series(vals : Array[Double], name : String) -> MlrlactorcriticSeries {
  { vals, name, meta: 0 }
}

pub fn MlrlactorcriticSeries::len(self : MlrlactorcriticSeries) -> Int { self.vals.length() }

pub fn MlrlactorcriticSeries::sum(self : MlrlactorcriticSeries) -> Double { @_common.sum(self.vals) }

pub fn MlrlactorcriticSeries::mean(self : MlrlactorcriticSeries) -> Double { @_common.mean(self.vals) }

pub fn MlrlactorcriticSeries::min(self : MlrlactorcriticSeries) -> Double { @_common.min(self.vals) }

pub fn MlrlactorcriticSeries::max(self : MlrlactorcriticSeries) -> Double { @_common.max(self.vals) }

pub fn MlrlactorcriticSeries::range(self : MlrlactorcriticSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlrlactorcriticSeries::variance(self : MlrlactorcriticSeries) -> Double { @_common.variance(self.vals) }

pub fn MlrlactorcriticSeries::std(self : MlrlactorcriticSeries) -> Double { @_common.std(self.vals) }

pub fn MlrlactorcriticSeries::median(self : MlrlactorcriticSeries) -> Double { @_common.median(self.vals) }

pub fn MlrlactorcriticSeries::scale(self : MlrlactorcriticSeries, f : Double) -> MlrlactorcriticSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlrlactorcriticSeries::add(self : MlrlactorcriticSeries, other : MlrlactorcriticSeries) -> MlrlactorcriticSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlrlactorcriticSeries::sub(self : MlrlactorcriticSeries, other : MlrlactorcriticSeries) -> MlrlactorcriticSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlrlactorcriticSeries::normalize(self : MlrlactorcriticSeries) -> MlrlactorcriticSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlrlactorcriticSeries::cumsum(self : MlrlactorcriticSeries) -> MlrlactorcriticSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlrlactorcriticSeries::to_string(self : MlrlactorcriticSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlrlactorcriticMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_rl_actor_critic_make_matrix(rows : Int, cols : Int, val : Double) -> MlrlactorcriticMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_rl_actor_critic_matrix_identity(n : Int) -> MlrlactorcriticMatrix {
  let m = ml_rl_actor_critic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlrlactorcriticMatrix::get(self : MlrlactorcriticMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlrlactorcriticMatrix::transpose(self : MlrlactorcriticMatrix) -> MlrlactorcriticMatrix {
  let result = ml_rl_actor_critic_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlrlactorcriticMatrix::add(self : MlrlactorcriticMatrix, other : MlrlactorcriticMatrix) -> MlrlactorcriticMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_rl_actor_critic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlrlactorcriticMatrix::scale(self : MlrlactorcriticMatrix, s : Double) -> MlrlactorcriticMatrix {
  let result = ml_rl_actor_critic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlrlactorcriticMatrix::multiply(self : MlrlactorcriticMatrix, other : MlrlactorcriticMatrix) -> MlrlactorcriticMatrix {
  if self.cols != other.rows { return ml_rl_actor_critic_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_rl_actor_critic_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlrlactorcriticMatrix::trace(self : MlrlactorcriticMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlrlactorcriticMatrix::det(self : MlrlactorcriticMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlrlactorcriticMatrix::norm(self : MlrlactorcriticMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlrlactorcriticMatrix::to_string(self : MlrlactorcriticMatrix) -> String {
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

pub(all) struct MlrlactorcriticVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_rl_actor_critic_make_vector(comps : Array[Double]) -> MlrlactorcriticVector {
  { comps, dim: comps.length() }
}

pub fn ml_rl_actor_critic_vector_zero(dim : Int) -> MlrlactorcriticVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlrlactorcriticVector::add(self : MlrlactorcriticVector, other : MlrlactorcriticVector) -> MlrlactorcriticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlrlactorcriticVector::sub(self : MlrlactorcriticVector, other : MlrlactorcriticVector) -> MlrlactorcriticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlrlactorcriticVector::scale(self : MlrlactorcriticVector, s : Double) -> MlrlactorcriticVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlrlactorcriticVector::dot(self : MlrlactorcriticVector, other : MlrlactorcriticVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlrlactorcriticVector::norm(self : MlrlactorcriticVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlrlactorcriticVector::normalize(self : MlrlactorcriticVector) -> MlrlactorcriticVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlrlactorcriticVector::dist(self : MlrlactorcriticVector, other : MlrlactorcriticVector) -> Double {
  self.sub(other).norm()
}

pub fn MlrlactorcriticVector::to_string(self : MlrlactorcriticVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_rl_actor_critic_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_rl_actor_critic_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_rl_actor_critic_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_rl_actor_critic_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_rl_actor_critic_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_rl_actor_critic_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_rl_actor_critic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_rl_actor_critic_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_rl_actor_critic_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_rl_actor_critic_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_rl_actor_critic_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_rl_actor_critic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_rl_actor_critic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_rl_actor_critic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_rl_actor_critic_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_rl_actor_critic_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_rl_actor_critic_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_rl_actor_critic_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_rl_actor_critic_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_rl_actor_critic_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_rl_actor_critic_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_rl_actor_critic_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_rl_actor_critic_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_rl_actor_critic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_rl_actor_critic_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_rl_actor_critic_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_rl_actor_critic_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_rl_actor_critic_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_rl_actor_critic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlrlactorcriticFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_frame_make(size : Int) -> MlrlactorcriticFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_actor_critic_frame_len(s : MlrlactorcriticFrame) -> Int { s.size }

pub fn ml_rl_actor_critic_frame_get(s : MlrlactorcriticFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_actor_critic_frame_set(s : MlrlactorcriticFrame, i : Int, v : Double) -> MlrlactorcriticFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_frame_sum(s : MlrlactorcriticFrame) -> Double { @_common.sum(s.data) }

pub fn ml_rl_actor_critic_frame_mean(s : MlrlactorcriticFrame) -> Double { @_common.mean(s.data) }

pub fn ml_rl_actor_critic_frame_scale(s : MlrlactorcriticFrame, f : Double) -> MlrlactorcriticFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_frame_add(a : MlrlactorcriticFrame, b : MlrlactorcriticFrame) -> MlrlactorcriticFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_actor_critic_frame_copy(s : MlrlactorcriticFrame) -> MlrlactorcriticFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_frame_fill(s : MlrlactorcriticFrame, v : Double) -> MlrlactorcriticFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_frame_min(s : MlrlactorcriticFrame) -> Double { @_common.min(s.data) }

pub fn ml_rl_actor_critic_frame_max(s : MlrlactorcriticFrame) -> Double { @_common.max(s.data) }

pub fn ml_rl_actor_critic_frame_to_string(s : MlrlactorcriticFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_table_make(size : Int) -> MlrlactorcriticTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_actor_critic_table_len(s : MlrlactorcriticTable) -> Int { s.size }

pub fn ml_rl_actor_critic_table_get(s : MlrlactorcriticTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_actor_critic_table_set(s : MlrlactorcriticTable, i : Int, v : Double) -> MlrlactorcriticTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_table_sum(s : MlrlactorcriticTable) -> Double { @_common.sum(s.data) }

pub fn ml_rl_actor_critic_table_mean(s : MlrlactorcriticTable) -> Double { @_common.mean(s.data) }

pub fn ml_rl_actor_critic_table_scale(s : MlrlactorcriticTable, f : Double) -> MlrlactorcriticTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_table_add(a : MlrlactorcriticTable, b : MlrlactorcriticTable) -> MlrlactorcriticTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_actor_critic_table_copy(s : MlrlactorcriticTable) -> MlrlactorcriticTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_table_fill(s : MlrlactorcriticTable, v : Double) -> MlrlactorcriticTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_table_min(s : MlrlactorcriticTable) -> Double { @_common.min(s.data) }

pub fn ml_rl_actor_critic_table_max(s : MlrlactorcriticTable) -> Double { @_common.max(s.data) }

pub fn ml_rl_actor_critic_table_to_string(s : MlrlactorcriticTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_graphn_make(size : Int) -> MlrlactorcriticGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_actor_critic_graphn_len(s : MlrlactorcriticGraphN) -> Int { s.size }

pub fn ml_rl_actor_critic_graphn_get(s : MlrlactorcriticGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_actor_critic_graphn_set(s : MlrlactorcriticGraphN, i : Int, v : Double) -> MlrlactorcriticGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_graphn_sum(s : MlrlactorcriticGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_rl_actor_critic_graphn_mean(s : MlrlactorcriticGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_rl_actor_critic_graphn_scale(s : MlrlactorcriticGraphN, f : Double) -> MlrlactorcriticGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_graphn_add(a : MlrlactorcriticGraphN, b : MlrlactorcriticGraphN) -> MlrlactorcriticGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_actor_critic_graphn_copy(s : MlrlactorcriticGraphN) -> MlrlactorcriticGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_graphn_fill(s : MlrlactorcriticGraphN, v : Double) -> MlrlactorcriticGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_graphn_min(s : MlrlactorcriticGraphN) -> Double { @_common.min(s.data) }

pub fn ml_rl_actor_critic_graphn_max(s : MlrlactorcriticGraphN) -> Double { @_common.max(s.data) }

pub fn ml_rl_actor_critic_graphn_to_string(s : MlrlactorcriticGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_node_make(size : Int) -> MlrlactorcriticNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_actor_critic_node_len(s : MlrlactorcriticNode) -> Int { s.size }

pub fn ml_rl_actor_critic_node_get(s : MlrlactorcriticNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_actor_critic_node_set(s : MlrlactorcriticNode, i : Int, v : Double) -> MlrlactorcriticNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_node_sum(s : MlrlactorcriticNode) -> Double { @_common.sum(s.data) }

pub fn ml_rl_actor_critic_node_mean(s : MlrlactorcriticNode) -> Double { @_common.mean(s.data) }

pub fn ml_rl_actor_critic_node_scale(s : MlrlactorcriticNode, f : Double) -> MlrlactorcriticNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_node_add(a : MlrlactorcriticNode, b : MlrlactorcriticNode) -> MlrlactorcriticNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_actor_critic_node_copy(s : MlrlactorcriticNode) -> MlrlactorcriticNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_node_fill(s : MlrlactorcriticNode, v : Double) -> MlrlactorcriticNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_node_min(s : MlrlactorcriticNode) -> Double { @_common.min(s.data) }

pub fn ml_rl_actor_critic_node_max(s : MlrlactorcriticNode) -> Double { @_common.max(s.data) }

pub fn ml_rl_actor_critic_node_to_string(s : MlrlactorcriticNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_edge_make(size : Int) -> MlrlactorcriticEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_actor_critic_edge_len(s : MlrlactorcriticEdge) -> Int { s.size }

pub fn ml_rl_actor_critic_edge_get(s : MlrlactorcriticEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_actor_critic_edge_set(s : MlrlactorcriticEdge, i : Int, v : Double) -> MlrlactorcriticEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_edge_sum(s : MlrlactorcriticEdge) -> Double { @_common.sum(s.data) }

pub fn ml_rl_actor_critic_edge_mean(s : MlrlactorcriticEdge) -> Double { @_common.mean(s.data) }

pub fn ml_rl_actor_critic_edge_scale(s : MlrlactorcriticEdge, f : Double) -> MlrlactorcriticEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_edge_add(a : MlrlactorcriticEdge, b : MlrlactorcriticEdge) -> MlrlactorcriticEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_actor_critic_edge_copy(s : MlrlactorcriticEdge) -> MlrlactorcriticEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_edge_fill(s : MlrlactorcriticEdge, v : Double) -> MlrlactorcriticEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_edge_min(s : MlrlactorcriticEdge) -> Double { @_common.min(s.data) }

pub fn ml_rl_actor_critic_edge_max(s : MlrlactorcriticEdge) -> Double { @_common.max(s.data) }

pub fn ml_rl_actor_critic_edge_to_string(s : MlrlactorcriticEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_path_make(size : Int) -> MlrlactorcriticPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_actor_critic_path_len(s : MlrlactorcriticPath) -> Int { s.size }

pub fn ml_rl_actor_critic_path_get(s : MlrlactorcriticPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_actor_critic_path_set(s : MlrlactorcriticPath, i : Int, v : Double) -> MlrlactorcriticPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_path_sum(s : MlrlactorcriticPath) -> Double { @_common.sum(s.data) }

pub fn ml_rl_actor_critic_path_mean(s : MlrlactorcriticPath) -> Double { @_common.mean(s.data) }

pub fn ml_rl_actor_critic_path_scale(s : MlrlactorcriticPath, f : Double) -> MlrlactorcriticPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_path_add(a : MlrlactorcriticPath, b : MlrlactorcriticPath) -> MlrlactorcriticPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_actor_critic_path_copy(s : MlrlactorcriticPath) -> MlrlactorcriticPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_path_fill(s : MlrlactorcriticPath, v : Double) -> MlrlactorcriticPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_path_min(s : MlrlactorcriticPath) -> Double { @_common.min(s.data) }

pub fn ml_rl_actor_critic_path_max(s : MlrlactorcriticPath) -> Double { @_common.max(s.data) }

pub fn ml_rl_actor_critic_path_to_string(s : MlrlactorcriticPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_cluster_make(size : Int) -> MlrlactorcriticCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_actor_critic_cluster_len(s : MlrlactorcriticCluster) -> Int { s.size }

pub fn ml_rl_actor_critic_cluster_get(s : MlrlactorcriticCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_actor_critic_cluster_set(s : MlrlactorcriticCluster, i : Int, v : Double) -> MlrlactorcriticCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_cluster_sum(s : MlrlactorcriticCluster) -> Double { @_common.sum(s.data) }

pub fn ml_rl_actor_critic_cluster_mean(s : MlrlactorcriticCluster) -> Double { @_common.mean(s.data) }

pub fn ml_rl_actor_critic_cluster_scale(s : MlrlactorcriticCluster, f : Double) -> MlrlactorcriticCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_cluster_add(a : MlrlactorcriticCluster, b : MlrlactorcriticCluster) -> MlrlactorcriticCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_actor_critic_cluster_copy(s : MlrlactorcriticCluster) -> MlrlactorcriticCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_cluster_fill(s : MlrlactorcriticCluster, v : Double) -> MlrlactorcriticCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_cluster_min(s : MlrlactorcriticCluster) -> Double { @_common.min(s.data) }

pub fn ml_rl_actor_critic_cluster_max(s : MlrlactorcriticCluster) -> Double { @_common.max(s.data) }

pub fn ml_rl_actor_critic_cluster_to_string(s : MlrlactorcriticCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_model_make(size : Int) -> MlrlactorcriticModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_actor_critic_model_len(s : MlrlactorcriticModel) -> Int { s.size }

pub fn ml_rl_actor_critic_model_get(s : MlrlactorcriticModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_actor_critic_model_set(s : MlrlactorcriticModel, i : Int, v : Double) -> MlrlactorcriticModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_model_sum(s : MlrlactorcriticModel) -> Double { @_common.sum(s.data) }

pub fn ml_rl_actor_critic_model_mean(s : MlrlactorcriticModel) -> Double { @_common.mean(s.data) }

pub fn ml_rl_actor_critic_model_scale(s : MlrlactorcriticModel, f : Double) -> MlrlactorcriticModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_model_add(a : MlrlactorcriticModel, b : MlrlactorcriticModel) -> MlrlactorcriticModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_actor_critic_model_copy(s : MlrlactorcriticModel) -> MlrlactorcriticModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_model_fill(s : MlrlactorcriticModel, v : Double) -> MlrlactorcriticModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_model_min(s : MlrlactorcriticModel) -> Double { @_common.min(s.data) }

pub fn ml_rl_actor_critic_model_max(s : MlrlactorcriticModel) -> Double { @_common.max(s.data) }

pub fn ml_rl_actor_critic_model_to_string(s : MlrlactorcriticModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_layer_make(size : Int) -> MlrlactorcriticLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_actor_critic_layer_len(s : MlrlactorcriticLayer) -> Int { s.size }

pub fn ml_rl_actor_critic_layer_get(s : MlrlactorcriticLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_actor_critic_layer_set(s : MlrlactorcriticLayer, i : Int, v : Double) -> MlrlactorcriticLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_layer_sum(s : MlrlactorcriticLayer) -> Double { @_common.sum(s.data) }

pub fn ml_rl_actor_critic_layer_mean(s : MlrlactorcriticLayer) -> Double { @_common.mean(s.data) }

pub fn ml_rl_actor_critic_layer_scale(s : MlrlactorcriticLayer, f : Double) -> MlrlactorcriticLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_layer_add(a : MlrlactorcriticLayer, b : MlrlactorcriticLayer) -> MlrlactorcriticLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_actor_critic_layer_copy(s : MlrlactorcriticLayer) -> MlrlactorcriticLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_layer_fill(s : MlrlactorcriticLayer, v : Double) -> MlrlactorcriticLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_layer_min(s : MlrlactorcriticLayer) -> Double { @_common.min(s.data) }

pub fn ml_rl_actor_critic_layer_max(s : MlrlactorcriticLayer) -> Double { @_common.max(s.data) }

pub fn ml_rl_actor_critic_layer_to_string(s : MlrlactorcriticLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_buffer_make(size : Int) -> MlrlactorcriticBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_actor_critic_buffer_len(s : MlrlactorcriticBuffer) -> Int { s.size }

pub fn ml_rl_actor_critic_buffer_get(s : MlrlactorcriticBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_actor_critic_buffer_set(s : MlrlactorcriticBuffer, i : Int, v : Double) -> MlrlactorcriticBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_buffer_sum(s : MlrlactorcriticBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_rl_actor_critic_buffer_mean(s : MlrlactorcriticBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_rl_actor_critic_buffer_scale(s : MlrlactorcriticBuffer, f : Double) -> MlrlactorcriticBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_buffer_add(a : MlrlactorcriticBuffer, b : MlrlactorcriticBuffer) -> MlrlactorcriticBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_actor_critic_buffer_copy(s : MlrlactorcriticBuffer) -> MlrlactorcriticBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_buffer_fill(s : MlrlactorcriticBuffer, v : Double) -> MlrlactorcriticBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_buffer_min(s : MlrlactorcriticBuffer) -> Double { @_common.min(s.data) }

pub fn ml_rl_actor_critic_buffer_max(s : MlrlactorcriticBuffer) -> Double { @_common.max(s.data) }

pub fn ml_rl_actor_critic_buffer_to_string(s : MlrlactorcriticBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_cursor_make(size : Int) -> MlrlactorcriticCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_actor_critic_cursor_len(s : MlrlactorcriticCursor) -> Int { s.size }

pub fn ml_rl_actor_critic_cursor_get(s : MlrlactorcriticCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_actor_critic_cursor_set(s : MlrlactorcriticCursor, i : Int, v : Double) -> MlrlactorcriticCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_cursor_sum(s : MlrlactorcriticCursor) -> Double { @_common.sum(s.data) }

pub fn ml_rl_actor_critic_cursor_mean(s : MlrlactorcriticCursor) -> Double { @_common.mean(s.data) }

pub fn ml_rl_actor_critic_cursor_scale(s : MlrlactorcriticCursor, f : Double) -> MlrlactorcriticCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_cursor_add(a : MlrlactorcriticCursor, b : MlrlactorcriticCursor) -> MlrlactorcriticCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_actor_critic_cursor_copy(s : MlrlactorcriticCursor) -> MlrlactorcriticCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_cursor_fill(s : MlrlactorcriticCursor, v : Double) -> MlrlactorcriticCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_cursor_min(s : MlrlactorcriticCursor) -> Double { @_common.min(s.data) }

pub fn ml_rl_actor_critic_cursor_max(s : MlrlactorcriticCursor) -> Double { @_common.max(s.data) }

pub fn ml_rl_actor_critic_cursor_to_string(s : MlrlactorcriticCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_view_make(size : Int) -> MlrlactorcriticView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_actor_critic_view_len(s : MlrlactorcriticView) -> Int { s.size }

pub fn ml_rl_actor_critic_view_get(s : MlrlactorcriticView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_actor_critic_view_set(s : MlrlactorcriticView, i : Int, v : Double) -> MlrlactorcriticView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_view_sum(s : MlrlactorcriticView) -> Double { @_common.sum(s.data) }

pub fn ml_rl_actor_critic_view_mean(s : MlrlactorcriticView) -> Double { @_common.mean(s.data) }

pub fn ml_rl_actor_critic_view_scale(s : MlrlactorcriticView, f : Double) -> MlrlactorcriticView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_view_add(a : MlrlactorcriticView, b : MlrlactorcriticView) -> MlrlactorcriticView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_actor_critic_view_copy(s : MlrlactorcriticView) -> MlrlactorcriticView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_view_fill(s : MlrlactorcriticView, v : Double) -> MlrlactorcriticView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_view_min(s : MlrlactorcriticView) -> Double { @_common.min(s.data) }

pub fn ml_rl_actor_critic_view_max(s : MlrlactorcriticView) -> Double { @_common.max(s.data) }

pub fn ml_rl_actor_critic_view_to_string(s : MlrlactorcriticView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_range_make(size : Int) -> MlrlactorcriticRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_actor_critic_range_len(s : MlrlactorcriticRange) -> Int { s.size }

pub fn ml_rl_actor_critic_range_get(s : MlrlactorcriticRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_actor_critic_range_set(s : MlrlactorcriticRange, i : Int, v : Double) -> MlrlactorcriticRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_range_sum(s : MlrlactorcriticRange) -> Double { @_common.sum(s.data) }

pub fn ml_rl_actor_critic_range_mean(s : MlrlactorcriticRange) -> Double { @_common.mean(s.data) }

pub fn ml_rl_actor_critic_range_scale(s : MlrlactorcriticRange, f : Double) -> MlrlactorcriticRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_range_add(a : MlrlactorcriticRange, b : MlrlactorcriticRange) -> MlrlactorcriticRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_actor_critic_range_copy(s : MlrlactorcriticRange) -> MlrlactorcriticRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_range_fill(s : MlrlactorcriticRange, v : Double) -> MlrlactorcriticRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_range_min(s : MlrlactorcriticRange) -> Double { @_common.min(s.data) }

pub fn ml_rl_actor_critic_range_max(s : MlrlactorcriticRange) -> Double { @_common.max(s.data) }

pub fn ml_rl_actor_critic_range_to_string(s : MlrlactorcriticRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_slice_make(size : Int) -> MlrlactorcriticSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_actor_critic_slice_len(s : MlrlactorcriticSlice) -> Int { s.size }

pub fn ml_rl_actor_critic_slice_get(s : MlrlactorcriticSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_actor_critic_slice_set(s : MlrlactorcriticSlice, i : Int, v : Double) -> MlrlactorcriticSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_slice_sum(s : MlrlactorcriticSlice) -> Double { @_common.sum(s.data) }

pub fn ml_rl_actor_critic_slice_mean(s : MlrlactorcriticSlice) -> Double { @_common.mean(s.data) }

pub fn ml_rl_actor_critic_slice_scale(s : MlrlactorcriticSlice, f : Double) -> MlrlactorcriticSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_slice_add(a : MlrlactorcriticSlice, b : MlrlactorcriticSlice) -> MlrlactorcriticSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_actor_critic_slice_copy(s : MlrlactorcriticSlice) -> MlrlactorcriticSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_slice_fill(s : MlrlactorcriticSlice, v : Double) -> MlrlactorcriticSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_actor_critic_slice_min(s : MlrlactorcriticSlice) -> Double { @_common.min(s.data) }

pub fn ml_rl_actor_critic_slice_max(s : MlrlactorcriticSlice) -> Double { @_common.max(s.data) }

pub fn ml_rl_actor_critic_slice_to_string(s : MlrlactorcriticSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

