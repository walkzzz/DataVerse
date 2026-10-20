///===
/// extcore/stats_model_gam

pub(all) struct StatsmodelgamPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_model_gam_make_point(x : Double, y : Double) -> StatsmodelgamPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_model_gam_make_point3(x : Double, y : Double, z : Double) -> StatsmodelgamPoint {
  { x, y, z, label: 0 }
}

pub fn StatsmodelgamPoint::x(self : StatsmodelgamPoint) -> Double { self.x }

pub fn StatsmodelgamPoint::y(self : StatsmodelgamPoint) -> Double { self.y }

pub fn StatsmodelgamPoint::z(self : StatsmodelgamPoint) -> Double { self.z }

pub fn StatsmodelgamPoint::label(self : StatsmodelgamPoint) -> Int { self.label }

pub fn StatsmodelgamPoint::dist(self : StatsmodelgamPoint, other : StatsmodelgamPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsmodelgamPoint::add(self : StatsmodelgamPoint, other : StatsmodelgamPoint) -> StatsmodelgamPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsmodelgamPoint::sub(self : StatsmodelgamPoint, other : StatsmodelgamPoint) -> StatsmodelgamPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsmodelgamPoint::scale(self : StatsmodelgamPoint, s : Double) -> StatsmodelgamPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsmodelgamPoint::dot(self : StatsmodelgamPoint, other : StatsmodelgamPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsmodelgamPoint::cross(self : StatsmodelgamPoint, other : StatsmodelgamPoint) -> StatsmodelgamPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsmodelgamPoint::norm(self : StatsmodelgamPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsmodelgamPoint::normalize(self : StatsmodelgamPoint) -> StatsmodelgamPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsmodelgamPoint::negate(self : StatsmodelgamPoint) -> StatsmodelgamPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsmodelgamPoint::mid(self : StatsmodelgamPoint, other : StatsmodelgamPoint) -> StatsmodelgamPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsmodelgamPoint::lerp(self : StatsmodelgamPoint, other : StatsmodelgamPoint, t : Double) -> StatsmodelgamPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsmodelgamPoint::to_string(self : StatsmodelgamPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsmodelgamSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_model_gam_make_series(vals : Array[Double], name : String) -> StatsmodelgamSeries {
  { vals, name, meta: 0 }
}

pub fn StatsmodelgamSeries::len(self : StatsmodelgamSeries) -> Int { self.vals.length() }

pub fn StatsmodelgamSeries::sum(self : StatsmodelgamSeries) -> Double { @_common.sum(self.vals) }

pub fn StatsmodelgamSeries::mean(self : StatsmodelgamSeries) -> Double { @_common.mean(self.vals) }

pub fn StatsmodelgamSeries::min(self : StatsmodelgamSeries) -> Double { @_common.min(self.vals) }

pub fn StatsmodelgamSeries::max(self : StatsmodelgamSeries) -> Double { @_common.max(self.vals) }

pub fn StatsmodelgamSeries::range(self : StatsmodelgamSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsmodelgamSeries::variance(self : StatsmodelgamSeries) -> Double { @_common.variance(self.vals) }

pub fn StatsmodelgamSeries::std(self : StatsmodelgamSeries) -> Double { @_common.std(self.vals) }

pub fn StatsmodelgamSeries::median(self : StatsmodelgamSeries) -> Double { @_common.median(self.vals) }

pub fn StatsmodelgamSeries::scale(self : StatsmodelgamSeries, f : Double) -> StatsmodelgamSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsmodelgamSeries::add(self : StatsmodelgamSeries, other : StatsmodelgamSeries) -> StatsmodelgamSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsmodelgamSeries::sub(self : StatsmodelgamSeries, other : StatsmodelgamSeries) -> StatsmodelgamSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsmodelgamSeries::normalize(self : StatsmodelgamSeries) -> StatsmodelgamSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsmodelgamSeries::cumsum(self : StatsmodelgamSeries) -> StatsmodelgamSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsmodelgamSeries::to_string(self : StatsmodelgamSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsmodelgamMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_model_gam_make_matrix(rows : Int, cols : Int, val : Double) -> StatsmodelgamMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_model_gam_matrix_identity(n : Int) -> StatsmodelgamMatrix {
  let m = stats_model_gam_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsmodelgamMatrix::get(self : StatsmodelgamMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsmodelgamMatrix::transpose(self : StatsmodelgamMatrix) -> StatsmodelgamMatrix {
  let result = stats_model_gam_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsmodelgamMatrix::add(self : StatsmodelgamMatrix, other : StatsmodelgamMatrix) -> StatsmodelgamMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_model_gam_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsmodelgamMatrix::scale(self : StatsmodelgamMatrix, s : Double) -> StatsmodelgamMatrix {
  let result = stats_model_gam_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsmodelgamMatrix::multiply(self : StatsmodelgamMatrix, other : StatsmodelgamMatrix) -> StatsmodelgamMatrix {
  if self.cols != other.rows { return stats_model_gam_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_model_gam_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn StatsmodelgamMatrix::trace(self : StatsmodelgamMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsmodelgamMatrix::det(self : StatsmodelgamMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsmodelgamMatrix::norm(self : StatsmodelgamMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsmodelgamMatrix::to_string(self : StatsmodelgamMatrix) -> String {
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

pub(all) struct StatsmodelgamVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_model_gam_make_vector(comps : Array[Double]) -> StatsmodelgamVector {
  { comps, dim: comps.length() }
}

pub fn stats_model_gam_vector_zero(dim : Int) -> StatsmodelgamVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsmodelgamVector::add(self : StatsmodelgamVector, other : StatsmodelgamVector) -> StatsmodelgamVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsmodelgamVector::sub(self : StatsmodelgamVector, other : StatsmodelgamVector) -> StatsmodelgamVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsmodelgamVector::scale(self : StatsmodelgamVector, s : Double) -> StatsmodelgamVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsmodelgamVector::dot(self : StatsmodelgamVector, other : StatsmodelgamVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsmodelgamVector::norm(self : StatsmodelgamVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsmodelgamVector::normalize(self : StatsmodelgamVector) -> StatsmodelgamVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsmodelgamVector::dist(self : StatsmodelgamVector, other : StatsmodelgamVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsmodelgamVector::to_string(self : StatsmodelgamVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_model_gam_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_model_gam_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_model_gam_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_model_gam_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_model_gam_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_model_gam_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_model_gam_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_model_gam_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_model_gam_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_model_gam_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_model_gam_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_model_gam_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_model_gam_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_model_gam_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_model_gam_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_model_gam_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_model_gam_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_model_gam_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_model_gam_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_model_gam_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_model_gam_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_model_gam_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_model_gam_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_model_gam_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_model_gam_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_model_gam_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_model_gam_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_model_gam_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_model_gam_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsmodelgamFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_gam_frame_make(size : Int) -> StatsmodelgamFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_gam_frame_len(s : StatsmodelgamFrame) -> Int { s.size }

pub fn stats_model_gam_frame_get(s : StatsmodelgamFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_gam_frame_set(s : StatsmodelgamFrame, i : Int, v : Double) -> StatsmodelgamFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_gam_frame_sum(s : StatsmodelgamFrame) -> Double { @_common.sum(s.data) }

pub fn stats_model_gam_frame_mean(s : StatsmodelgamFrame) -> Double { @_common.mean(s.data) }

pub fn stats_model_gam_frame_scale(s : StatsmodelgamFrame, f : Double) -> StatsmodelgamFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_gam_frame_add(a : StatsmodelgamFrame, b : StatsmodelgamFrame) -> StatsmodelgamFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_gam_frame_copy(s : StatsmodelgamFrame) -> StatsmodelgamFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_gam_frame_fill(s : StatsmodelgamFrame, v : Double) -> StatsmodelgamFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_gam_frame_min(s : StatsmodelgamFrame) -> Double { @_common.min(s.data) }

pub fn stats_model_gam_frame_max(s : StatsmodelgamFrame) -> Double { @_common.max(s.data) }

pub fn stats_model_gam_frame_to_string(s : StatsmodelgamFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelgamTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_gam_table_make(size : Int) -> StatsmodelgamTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_gam_table_len(s : StatsmodelgamTable) -> Int { s.size }

pub fn stats_model_gam_table_get(s : StatsmodelgamTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_gam_table_set(s : StatsmodelgamTable, i : Int, v : Double) -> StatsmodelgamTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_gam_table_sum(s : StatsmodelgamTable) -> Double { @_common.sum(s.data) }

pub fn stats_model_gam_table_mean(s : StatsmodelgamTable) -> Double { @_common.mean(s.data) }

pub fn stats_model_gam_table_scale(s : StatsmodelgamTable, f : Double) -> StatsmodelgamTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_gam_table_add(a : StatsmodelgamTable, b : StatsmodelgamTable) -> StatsmodelgamTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_gam_table_copy(s : StatsmodelgamTable) -> StatsmodelgamTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_gam_table_fill(s : StatsmodelgamTable, v : Double) -> StatsmodelgamTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_gam_table_min(s : StatsmodelgamTable) -> Double { @_common.min(s.data) }

pub fn stats_model_gam_table_max(s : StatsmodelgamTable) -> Double { @_common.max(s.data) }

pub fn stats_model_gam_table_to_string(s : StatsmodelgamTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelgamGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_gam_graphn_make(size : Int) -> StatsmodelgamGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_gam_graphn_len(s : StatsmodelgamGraphN) -> Int { s.size }

pub fn stats_model_gam_graphn_get(s : StatsmodelgamGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_gam_graphn_set(s : StatsmodelgamGraphN, i : Int, v : Double) -> StatsmodelgamGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_gam_graphn_sum(s : StatsmodelgamGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_model_gam_graphn_mean(s : StatsmodelgamGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_model_gam_graphn_scale(s : StatsmodelgamGraphN, f : Double) -> StatsmodelgamGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_gam_graphn_add(a : StatsmodelgamGraphN, b : StatsmodelgamGraphN) -> StatsmodelgamGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_gam_graphn_copy(s : StatsmodelgamGraphN) -> StatsmodelgamGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_gam_graphn_fill(s : StatsmodelgamGraphN, v : Double) -> StatsmodelgamGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_gam_graphn_min(s : StatsmodelgamGraphN) -> Double { @_common.min(s.data) }

pub fn stats_model_gam_graphn_max(s : StatsmodelgamGraphN) -> Double { @_common.max(s.data) }

pub fn stats_model_gam_graphn_to_string(s : StatsmodelgamGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelgamNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_gam_node_make(size : Int) -> StatsmodelgamNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_gam_node_len(s : StatsmodelgamNode) -> Int { s.size }

pub fn stats_model_gam_node_get(s : StatsmodelgamNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_gam_node_set(s : StatsmodelgamNode, i : Int, v : Double) -> StatsmodelgamNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_gam_node_sum(s : StatsmodelgamNode) -> Double { @_common.sum(s.data) }

pub fn stats_model_gam_node_mean(s : StatsmodelgamNode) -> Double { @_common.mean(s.data) }

pub fn stats_model_gam_node_scale(s : StatsmodelgamNode, f : Double) -> StatsmodelgamNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_gam_node_add(a : StatsmodelgamNode, b : StatsmodelgamNode) -> StatsmodelgamNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_gam_node_copy(s : StatsmodelgamNode) -> StatsmodelgamNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_gam_node_fill(s : StatsmodelgamNode, v : Double) -> StatsmodelgamNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_gam_node_min(s : StatsmodelgamNode) -> Double { @_common.min(s.data) }

pub fn stats_model_gam_node_max(s : StatsmodelgamNode) -> Double { @_common.max(s.data) }

pub fn stats_model_gam_node_to_string(s : StatsmodelgamNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelgamEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_gam_edge_make(size : Int) -> StatsmodelgamEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_gam_edge_len(s : StatsmodelgamEdge) -> Int { s.size }

pub fn stats_model_gam_edge_get(s : StatsmodelgamEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_gam_edge_set(s : StatsmodelgamEdge, i : Int, v : Double) -> StatsmodelgamEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_gam_edge_sum(s : StatsmodelgamEdge) -> Double { @_common.sum(s.data) }

pub fn stats_model_gam_edge_mean(s : StatsmodelgamEdge) -> Double { @_common.mean(s.data) }

pub fn stats_model_gam_edge_scale(s : StatsmodelgamEdge, f : Double) -> StatsmodelgamEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_gam_edge_add(a : StatsmodelgamEdge, b : StatsmodelgamEdge) -> StatsmodelgamEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_gam_edge_copy(s : StatsmodelgamEdge) -> StatsmodelgamEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_gam_edge_fill(s : StatsmodelgamEdge, v : Double) -> StatsmodelgamEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_gam_edge_min(s : StatsmodelgamEdge) -> Double { @_common.min(s.data) }

pub fn stats_model_gam_edge_max(s : StatsmodelgamEdge) -> Double { @_common.max(s.data) }

pub fn stats_model_gam_edge_to_string(s : StatsmodelgamEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelgamPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_gam_path_make(size : Int) -> StatsmodelgamPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_gam_path_len(s : StatsmodelgamPath) -> Int { s.size }

pub fn stats_model_gam_path_get(s : StatsmodelgamPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_gam_path_set(s : StatsmodelgamPath, i : Int, v : Double) -> StatsmodelgamPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_gam_path_sum(s : StatsmodelgamPath) -> Double { @_common.sum(s.data) }

pub fn stats_model_gam_path_mean(s : StatsmodelgamPath) -> Double { @_common.mean(s.data) }

pub fn stats_model_gam_path_scale(s : StatsmodelgamPath, f : Double) -> StatsmodelgamPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_gam_path_add(a : StatsmodelgamPath, b : StatsmodelgamPath) -> StatsmodelgamPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_gam_path_copy(s : StatsmodelgamPath) -> StatsmodelgamPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_gam_path_fill(s : StatsmodelgamPath, v : Double) -> StatsmodelgamPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_gam_path_min(s : StatsmodelgamPath) -> Double { @_common.min(s.data) }

pub fn stats_model_gam_path_max(s : StatsmodelgamPath) -> Double { @_common.max(s.data) }

pub fn stats_model_gam_path_to_string(s : StatsmodelgamPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelgamCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_gam_cluster_make(size : Int) -> StatsmodelgamCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_gam_cluster_len(s : StatsmodelgamCluster) -> Int { s.size }

pub fn stats_model_gam_cluster_get(s : StatsmodelgamCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_gam_cluster_set(s : StatsmodelgamCluster, i : Int, v : Double) -> StatsmodelgamCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_gam_cluster_sum(s : StatsmodelgamCluster) -> Double { @_common.sum(s.data) }

pub fn stats_model_gam_cluster_mean(s : StatsmodelgamCluster) -> Double { @_common.mean(s.data) }

pub fn stats_model_gam_cluster_scale(s : StatsmodelgamCluster, f : Double) -> StatsmodelgamCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_gam_cluster_add(a : StatsmodelgamCluster, b : StatsmodelgamCluster) -> StatsmodelgamCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_gam_cluster_copy(s : StatsmodelgamCluster) -> StatsmodelgamCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_gam_cluster_fill(s : StatsmodelgamCluster, v : Double) -> StatsmodelgamCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_gam_cluster_min(s : StatsmodelgamCluster) -> Double { @_common.min(s.data) }

pub fn stats_model_gam_cluster_max(s : StatsmodelgamCluster) -> Double { @_common.max(s.data) }

pub fn stats_model_gam_cluster_to_string(s : StatsmodelgamCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelgamModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_gam_model_make(size : Int) -> StatsmodelgamModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_gam_model_len(s : StatsmodelgamModel) -> Int { s.size }

pub fn stats_model_gam_model_get(s : StatsmodelgamModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_gam_model_set(s : StatsmodelgamModel, i : Int, v : Double) -> StatsmodelgamModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_gam_model_sum(s : StatsmodelgamModel) -> Double { @_common.sum(s.data) }

pub fn stats_model_gam_model_mean(s : StatsmodelgamModel) -> Double { @_common.mean(s.data) }

pub fn stats_model_gam_model_scale(s : StatsmodelgamModel, f : Double) -> StatsmodelgamModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_gam_model_add(a : StatsmodelgamModel, b : StatsmodelgamModel) -> StatsmodelgamModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_gam_model_copy(s : StatsmodelgamModel) -> StatsmodelgamModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_gam_model_fill(s : StatsmodelgamModel, v : Double) -> StatsmodelgamModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_gam_model_min(s : StatsmodelgamModel) -> Double { @_common.min(s.data) }

pub fn stats_model_gam_model_max(s : StatsmodelgamModel) -> Double { @_common.max(s.data) }

pub fn stats_model_gam_model_to_string(s : StatsmodelgamModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelgamLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_gam_layer_make(size : Int) -> StatsmodelgamLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_gam_layer_len(s : StatsmodelgamLayer) -> Int { s.size }

pub fn stats_model_gam_layer_get(s : StatsmodelgamLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_gam_layer_set(s : StatsmodelgamLayer, i : Int, v : Double) -> StatsmodelgamLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_gam_layer_sum(s : StatsmodelgamLayer) -> Double { @_common.sum(s.data) }

pub fn stats_model_gam_layer_mean(s : StatsmodelgamLayer) -> Double { @_common.mean(s.data) }

pub fn stats_model_gam_layer_scale(s : StatsmodelgamLayer, f : Double) -> StatsmodelgamLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_gam_layer_add(a : StatsmodelgamLayer, b : StatsmodelgamLayer) -> StatsmodelgamLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_gam_layer_copy(s : StatsmodelgamLayer) -> StatsmodelgamLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_gam_layer_fill(s : StatsmodelgamLayer, v : Double) -> StatsmodelgamLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_gam_layer_min(s : StatsmodelgamLayer) -> Double { @_common.min(s.data) }

pub fn stats_model_gam_layer_max(s : StatsmodelgamLayer) -> Double { @_common.max(s.data) }

pub fn stats_model_gam_layer_to_string(s : StatsmodelgamLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelgamBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_gam_buffer_make(size : Int) -> StatsmodelgamBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_gam_buffer_len(s : StatsmodelgamBuffer) -> Int { s.size }

pub fn stats_model_gam_buffer_get(s : StatsmodelgamBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_gam_buffer_set(s : StatsmodelgamBuffer, i : Int, v : Double) -> StatsmodelgamBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_gam_buffer_sum(s : StatsmodelgamBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_model_gam_buffer_mean(s : StatsmodelgamBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_model_gam_buffer_scale(s : StatsmodelgamBuffer, f : Double) -> StatsmodelgamBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_gam_buffer_add(a : StatsmodelgamBuffer, b : StatsmodelgamBuffer) -> StatsmodelgamBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_gam_buffer_copy(s : StatsmodelgamBuffer) -> StatsmodelgamBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_gam_buffer_fill(s : StatsmodelgamBuffer, v : Double) -> StatsmodelgamBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_gam_buffer_min(s : StatsmodelgamBuffer) -> Double { @_common.min(s.data) }

pub fn stats_model_gam_buffer_max(s : StatsmodelgamBuffer) -> Double { @_common.max(s.data) }

pub fn stats_model_gam_buffer_to_string(s : StatsmodelgamBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelgamCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_gam_cursor_make(size : Int) -> StatsmodelgamCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_gam_cursor_len(s : StatsmodelgamCursor) -> Int { s.size }

pub fn stats_model_gam_cursor_get(s : StatsmodelgamCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_gam_cursor_set(s : StatsmodelgamCursor, i : Int, v : Double) -> StatsmodelgamCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_gam_cursor_sum(s : StatsmodelgamCursor) -> Double { @_common.sum(s.data) }

pub fn stats_model_gam_cursor_mean(s : StatsmodelgamCursor) -> Double { @_common.mean(s.data) }

pub fn stats_model_gam_cursor_scale(s : StatsmodelgamCursor, f : Double) -> StatsmodelgamCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_gam_cursor_add(a : StatsmodelgamCursor, b : StatsmodelgamCursor) -> StatsmodelgamCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_gam_cursor_copy(s : StatsmodelgamCursor) -> StatsmodelgamCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_gam_cursor_fill(s : StatsmodelgamCursor, v : Double) -> StatsmodelgamCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_gam_cursor_min(s : StatsmodelgamCursor) -> Double { @_common.min(s.data) }

pub fn stats_model_gam_cursor_max(s : StatsmodelgamCursor) -> Double { @_common.max(s.data) }

pub fn stats_model_gam_cursor_to_string(s : StatsmodelgamCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelgamView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_gam_view_make(size : Int) -> StatsmodelgamView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_gam_view_len(s : StatsmodelgamView) -> Int { s.size }

pub fn stats_model_gam_view_get(s : StatsmodelgamView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_gam_view_set(s : StatsmodelgamView, i : Int, v : Double) -> StatsmodelgamView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_gam_view_sum(s : StatsmodelgamView) -> Double { @_common.sum(s.data) }

pub fn stats_model_gam_view_mean(s : StatsmodelgamView) -> Double { @_common.mean(s.data) }

pub fn stats_model_gam_view_scale(s : StatsmodelgamView, f : Double) -> StatsmodelgamView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_gam_view_add(a : StatsmodelgamView, b : StatsmodelgamView) -> StatsmodelgamView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_gam_view_copy(s : StatsmodelgamView) -> StatsmodelgamView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_gam_view_fill(s : StatsmodelgamView, v : Double) -> StatsmodelgamView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_gam_view_min(s : StatsmodelgamView) -> Double { @_common.min(s.data) }

pub fn stats_model_gam_view_max(s : StatsmodelgamView) -> Double { @_common.max(s.data) }

pub fn stats_model_gam_view_to_string(s : StatsmodelgamView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelgamRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_gam_range_make(size : Int) -> StatsmodelgamRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_gam_range_len(s : StatsmodelgamRange) -> Int { s.size }

pub fn stats_model_gam_range_get(s : StatsmodelgamRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_gam_range_set(s : StatsmodelgamRange, i : Int, v : Double) -> StatsmodelgamRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_gam_range_sum(s : StatsmodelgamRange) -> Double { @_common.sum(s.data) }

pub fn stats_model_gam_range_mean(s : StatsmodelgamRange) -> Double { @_common.mean(s.data) }

pub fn stats_model_gam_range_scale(s : StatsmodelgamRange, f : Double) -> StatsmodelgamRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_gam_range_add(a : StatsmodelgamRange, b : StatsmodelgamRange) -> StatsmodelgamRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_gam_range_copy(s : StatsmodelgamRange) -> StatsmodelgamRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_gam_range_fill(s : StatsmodelgamRange, v : Double) -> StatsmodelgamRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_gam_range_min(s : StatsmodelgamRange) -> Double { @_common.min(s.data) }

pub fn stats_model_gam_range_max(s : StatsmodelgamRange) -> Double { @_common.max(s.data) }

pub fn stats_model_gam_range_to_string(s : StatsmodelgamRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelgamSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_gam_slice_make(size : Int) -> StatsmodelgamSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_gam_slice_len(s : StatsmodelgamSlice) -> Int { s.size }

pub fn stats_model_gam_slice_get(s : StatsmodelgamSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_gam_slice_set(s : StatsmodelgamSlice, i : Int, v : Double) -> StatsmodelgamSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_gam_slice_sum(s : StatsmodelgamSlice) -> Double { @_common.sum(s.data) }

pub fn stats_model_gam_slice_mean(s : StatsmodelgamSlice) -> Double { @_common.mean(s.data) }

pub fn stats_model_gam_slice_scale(s : StatsmodelgamSlice, f : Double) -> StatsmodelgamSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_gam_slice_add(a : StatsmodelgamSlice, b : StatsmodelgamSlice) -> StatsmodelgamSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_gam_slice_copy(s : StatsmodelgamSlice) -> StatsmodelgamSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_gam_slice_fill(s : StatsmodelgamSlice, v : Double) -> StatsmodelgamSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_gam_slice_min(s : StatsmodelgamSlice) -> Double { @_common.min(s.data) }

pub fn stats_model_gam_slice_max(s : StatsmodelgamSlice) -> Double { @_common.max(s.data) }

pub fn stats_model_gam_slice_to_string(s : StatsmodelgamSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

