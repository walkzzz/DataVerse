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

pub fn StatsmodelgamFrame::len(self : StatsmodelgamFrame) -> Int { self.size }

pub fn StatsmodelgamFrame::get(self : StatsmodelgamFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsmodelgamFrame::set(self : StatsmodelgamFrame, i : Int, v : Double) -> StatsmodelgamFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsmodelgamFrame::sum(self : StatsmodelgamFrame) -> Double { @_common.sum(self.data) }

pub fn StatsmodelgamFrame::mean(self : StatsmodelgamFrame) -> Double { @_common.mean(self.data) }

pub fn StatsmodelgamFrame::scale(self : StatsmodelgamFrame, f : Double) -> StatsmodelgamFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsmodelgamFrame::add(self : StatsmodelgamFrame, other : StatsmodelgamFrame) -> StatsmodelgamFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsmodelgamFrame::copy(self : StatsmodelgamFrame) -> StatsmodelgamFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsmodelgamFrame::fill(self : StatsmodelgamFrame, v : Double) -> StatsmodelgamFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsmodelgamFrame::min(self : StatsmodelgamFrame) -> Double { @_common.min(self.data) }

pub fn StatsmodelgamFrame::max(self : StatsmodelgamFrame) -> Double { @_common.max(self.data) }

pub fn StatsmodelgamFrame::to_string(self : StatsmodelgamFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsmodelgamTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_gam_table_make(size : Int) -> StatsmodelgamTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsmodelgamTable::len(self : StatsmodelgamTable) -> Int { self.size }

pub fn StatsmodelgamTable::get(self : StatsmodelgamTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsmodelgamTable::set(self : StatsmodelgamTable, i : Int, v : Double) -> StatsmodelgamTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsmodelgamTable::sum(self : StatsmodelgamTable) -> Double { @_common.sum(self.data) }

pub fn StatsmodelgamTable::mean(self : StatsmodelgamTable) -> Double { @_common.mean(self.data) }

pub fn StatsmodelgamTable::scale(self : StatsmodelgamTable, f : Double) -> StatsmodelgamTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsmodelgamTable::add(self : StatsmodelgamTable, other : StatsmodelgamTable) -> StatsmodelgamTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsmodelgamTable::copy(self : StatsmodelgamTable) -> StatsmodelgamTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsmodelgamTable::fill(self : StatsmodelgamTable, v : Double) -> StatsmodelgamTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsmodelgamTable::min(self : StatsmodelgamTable) -> Double { @_common.min(self.data) }

pub fn StatsmodelgamTable::max(self : StatsmodelgamTable) -> Double { @_common.max(self.data) }

pub fn StatsmodelgamTable::to_string(self : StatsmodelgamTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsmodelgamGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_gam_graphn_make(size : Int) -> StatsmodelgamGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsmodelgamGraphN::len(self : StatsmodelgamGraphN) -> Int { self.size }

pub fn StatsmodelgamGraphN::get(self : StatsmodelgamGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsmodelgamGraphN::set(self : StatsmodelgamGraphN, i : Int, v : Double) -> StatsmodelgamGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsmodelgamGraphN::sum(self : StatsmodelgamGraphN) -> Double { @_common.sum(self.data) }

pub fn StatsmodelgamGraphN::mean(self : StatsmodelgamGraphN) -> Double { @_common.mean(self.data) }

pub fn StatsmodelgamGraphN::scale(self : StatsmodelgamGraphN, f : Double) -> StatsmodelgamGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsmodelgamGraphN::add(self : StatsmodelgamGraphN, other : StatsmodelgamGraphN) -> StatsmodelgamGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsmodelgamGraphN::copy(self : StatsmodelgamGraphN) -> StatsmodelgamGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsmodelgamGraphN::fill(self : StatsmodelgamGraphN, v : Double) -> StatsmodelgamGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsmodelgamGraphN::min(self : StatsmodelgamGraphN) -> Double { @_common.min(self.data) }

pub fn StatsmodelgamGraphN::max(self : StatsmodelgamGraphN) -> Double { @_common.max(self.data) }

pub fn StatsmodelgamGraphN::to_string(self : StatsmodelgamGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsmodelgamNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_gam_node_make(size : Int) -> StatsmodelgamNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsmodelgamNode::len(self : StatsmodelgamNode) -> Int { self.size }

pub fn StatsmodelgamNode::get(self : StatsmodelgamNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsmodelgamNode::set(self : StatsmodelgamNode, i : Int, v : Double) -> StatsmodelgamNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsmodelgamNode::sum(self : StatsmodelgamNode) -> Double { @_common.sum(self.data) }

pub fn StatsmodelgamNode::mean(self : StatsmodelgamNode) -> Double { @_common.mean(self.data) }

pub fn StatsmodelgamNode::scale(self : StatsmodelgamNode, f : Double) -> StatsmodelgamNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsmodelgamNode::add(self : StatsmodelgamNode, other : StatsmodelgamNode) -> StatsmodelgamNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsmodelgamNode::copy(self : StatsmodelgamNode) -> StatsmodelgamNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsmodelgamNode::fill(self : StatsmodelgamNode, v : Double) -> StatsmodelgamNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsmodelgamNode::min(self : StatsmodelgamNode) -> Double { @_common.min(self.data) }

pub fn StatsmodelgamNode::max(self : StatsmodelgamNode) -> Double { @_common.max(self.data) }

pub fn StatsmodelgamNode::to_string(self : StatsmodelgamNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsmodelgamEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_gam_edge_make(size : Int) -> StatsmodelgamEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsmodelgamEdge::len(self : StatsmodelgamEdge) -> Int { self.size }

pub fn StatsmodelgamEdge::get(self : StatsmodelgamEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsmodelgamEdge::set(self : StatsmodelgamEdge, i : Int, v : Double) -> StatsmodelgamEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsmodelgamEdge::sum(self : StatsmodelgamEdge) -> Double { @_common.sum(self.data) }

pub fn StatsmodelgamEdge::mean(self : StatsmodelgamEdge) -> Double { @_common.mean(self.data) }

pub fn StatsmodelgamEdge::scale(self : StatsmodelgamEdge, f : Double) -> StatsmodelgamEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsmodelgamEdge::add(self : StatsmodelgamEdge, other : StatsmodelgamEdge) -> StatsmodelgamEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsmodelgamEdge::copy(self : StatsmodelgamEdge) -> StatsmodelgamEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsmodelgamEdge::fill(self : StatsmodelgamEdge, v : Double) -> StatsmodelgamEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsmodelgamEdge::min(self : StatsmodelgamEdge) -> Double { @_common.min(self.data) }

pub fn StatsmodelgamEdge::max(self : StatsmodelgamEdge) -> Double { @_common.max(self.data) }

pub fn StatsmodelgamEdge::to_string(self : StatsmodelgamEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsmodelgamPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_gam_path_make(size : Int) -> StatsmodelgamPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsmodelgamPath::len(self : StatsmodelgamPath) -> Int { self.size }

pub fn StatsmodelgamPath::get(self : StatsmodelgamPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsmodelgamPath::set(self : StatsmodelgamPath, i : Int, v : Double) -> StatsmodelgamPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsmodelgamPath::sum(self : StatsmodelgamPath) -> Double { @_common.sum(self.data) }

pub fn StatsmodelgamPath::mean(self : StatsmodelgamPath) -> Double { @_common.mean(self.data) }

pub fn StatsmodelgamPath::scale(self : StatsmodelgamPath, f : Double) -> StatsmodelgamPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsmodelgamPath::add(self : StatsmodelgamPath, other : StatsmodelgamPath) -> StatsmodelgamPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsmodelgamPath::copy(self : StatsmodelgamPath) -> StatsmodelgamPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsmodelgamPath::fill(self : StatsmodelgamPath, v : Double) -> StatsmodelgamPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsmodelgamPath::min(self : StatsmodelgamPath) -> Double { @_common.min(self.data) }

pub fn StatsmodelgamPath::max(self : StatsmodelgamPath) -> Double { @_common.max(self.data) }

pub fn StatsmodelgamPath::to_string(self : StatsmodelgamPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsmodelgamCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_gam_cluster_make(size : Int) -> StatsmodelgamCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsmodelgamCluster::len(self : StatsmodelgamCluster) -> Int { self.size }

pub fn StatsmodelgamCluster::get(self : StatsmodelgamCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsmodelgamCluster::set(self : StatsmodelgamCluster, i : Int, v : Double) -> StatsmodelgamCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsmodelgamCluster::sum(self : StatsmodelgamCluster) -> Double { @_common.sum(self.data) }

pub fn StatsmodelgamCluster::mean(self : StatsmodelgamCluster) -> Double { @_common.mean(self.data) }

pub fn StatsmodelgamCluster::scale(self : StatsmodelgamCluster, f : Double) -> StatsmodelgamCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsmodelgamCluster::add(self : StatsmodelgamCluster, other : StatsmodelgamCluster) -> StatsmodelgamCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsmodelgamCluster::copy(self : StatsmodelgamCluster) -> StatsmodelgamCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsmodelgamCluster::fill(self : StatsmodelgamCluster, v : Double) -> StatsmodelgamCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsmodelgamCluster::min(self : StatsmodelgamCluster) -> Double { @_common.min(self.data) }

pub fn StatsmodelgamCluster::max(self : StatsmodelgamCluster) -> Double { @_common.max(self.data) }

pub fn StatsmodelgamCluster::to_string(self : StatsmodelgamCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsmodelgamModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_gam_model_make(size : Int) -> StatsmodelgamModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsmodelgamModel::len(self : StatsmodelgamModel) -> Int { self.size }

pub fn StatsmodelgamModel::get(self : StatsmodelgamModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsmodelgamModel::set(self : StatsmodelgamModel, i : Int, v : Double) -> StatsmodelgamModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsmodelgamModel::sum(self : StatsmodelgamModel) -> Double { @_common.sum(self.data) }

pub fn StatsmodelgamModel::mean(self : StatsmodelgamModel) -> Double { @_common.mean(self.data) }

pub fn StatsmodelgamModel::scale(self : StatsmodelgamModel, f : Double) -> StatsmodelgamModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsmodelgamModel::add(self : StatsmodelgamModel, other : StatsmodelgamModel) -> StatsmodelgamModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsmodelgamModel::copy(self : StatsmodelgamModel) -> StatsmodelgamModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsmodelgamModel::fill(self : StatsmodelgamModel, v : Double) -> StatsmodelgamModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsmodelgamModel::min(self : StatsmodelgamModel) -> Double { @_common.min(self.data) }

pub fn StatsmodelgamModel::max(self : StatsmodelgamModel) -> Double { @_common.max(self.data) }

pub fn StatsmodelgamModel::to_string(self : StatsmodelgamModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsmodelgamLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_gam_layer_make(size : Int) -> StatsmodelgamLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsmodelgamLayer::len(self : StatsmodelgamLayer) -> Int { self.size }

pub fn StatsmodelgamLayer::get(self : StatsmodelgamLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsmodelgamLayer::set(self : StatsmodelgamLayer, i : Int, v : Double) -> StatsmodelgamLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsmodelgamLayer::sum(self : StatsmodelgamLayer) -> Double { @_common.sum(self.data) }

pub fn StatsmodelgamLayer::mean(self : StatsmodelgamLayer) -> Double { @_common.mean(self.data) }

pub fn StatsmodelgamLayer::scale(self : StatsmodelgamLayer, f : Double) -> StatsmodelgamLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsmodelgamLayer::add(self : StatsmodelgamLayer, other : StatsmodelgamLayer) -> StatsmodelgamLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsmodelgamLayer::copy(self : StatsmodelgamLayer) -> StatsmodelgamLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsmodelgamLayer::fill(self : StatsmodelgamLayer, v : Double) -> StatsmodelgamLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsmodelgamLayer::min(self : StatsmodelgamLayer) -> Double { @_common.min(self.data) }

pub fn StatsmodelgamLayer::max(self : StatsmodelgamLayer) -> Double { @_common.max(self.data) }

pub fn StatsmodelgamLayer::to_string(self : StatsmodelgamLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsmodelgamBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_gam_buffer_make(size : Int) -> StatsmodelgamBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsmodelgamBuffer::len(self : StatsmodelgamBuffer) -> Int { self.size }

pub fn StatsmodelgamBuffer::get(self : StatsmodelgamBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsmodelgamBuffer::set(self : StatsmodelgamBuffer, i : Int, v : Double) -> StatsmodelgamBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsmodelgamBuffer::sum(self : StatsmodelgamBuffer) -> Double { @_common.sum(self.data) }

pub fn StatsmodelgamBuffer::mean(self : StatsmodelgamBuffer) -> Double { @_common.mean(self.data) }

pub fn StatsmodelgamBuffer::scale(self : StatsmodelgamBuffer, f : Double) -> StatsmodelgamBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsmodelgamBuffer::add(self : StatsmodelgamBuffer, other : StatsmodelgamBuffer) -> StatsmodelgamBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsmodelgamBuffer::copy(self : StatsmodelgamBuffer) -> StatsmodelgamBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsmodelgamBuffer::fill(self : StatsmodelgamBuffer, v : Double) -> StatsmodelgamBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsmodelgamBuffer::min(self : StatsmodelgamBuffer) -> Double { @_common.min(self.data) }

pub fn StatsmodelgamBuffer::max(self : StatsmodelgamBuffer) -> Double { @_common.max(self.data) }

pub fn StatsmodelgamBuffer::to_string(self : StatsmodelgamBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsmodelgamCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_gam_cursor_make(size : Int) -> StatsmodelgamCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsmodelgamCursor::len(self : StatsmodelgamCursor) -> Int { self.size }

pub fn StatsmodelgamCursor::get(self : StatsmodelgamCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsmodelgamCursor::set(self : StatsmodelgamCursor, i : Int, v : Double) -> StatsmodelgamCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsmodelgamCursor::sum(self : StatsmodelgamCursor) -> Double { @_common.sum(self.data) }

pub fn StatsmodelgamCursor::mean(self : StatsmodelgamCursor) -> Double { @_common.mean(self.data) }

pub fn StatsmodelgamCursor::scale(self : StatsmodelgamCursor, f : Double) -> StatsmodelgamCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsmodelgamCursor::add(self : StatsmodelgamCursor, other : StatsmodelgamCursor) -> StatsmodelgamCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsmodelgamCursor::copy(self : StatsmodelgamCursor) -> StatsmodelgamCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsmodelgamCursor::fill(self : StatsmodelgamCursor, v : Double) -> StatsmodelgamCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsmodelgamCursor::min(self : StatsmodelgamCursor) -> Double { @_common.min(self.data) }

pub fn StatsmodelgamCursor::max(self : StatsmodelgamCursor) -> Double { @_common.max(self.data) }

pub fn StatsmodelgamCursor::to_string(self : StatsmodelgamCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsmodelgamView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_gam_view_make(size : Int) -> StatsmodelgamView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsmodelgamView::len(self : StatsmodelgamView) -> Int { self.size }

pub fn StatsmodelgamView::get(self : StatsmodelgamView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsmodelgamView::set(self : StatsmodelgamView, i : Int, v : Double) -> StatsmodelgamView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsmodelgamView::sum(self : StatsmodelgamView) -> Double { @_common.sum(self.data) }

pub fn StatsmodelgamView::mean(self : StatsmodelgamView) -> Double { @_common.mean(self.data) }

pub fn StatsmodelgamView::scale(self : StatsmodelgamView, f : Double) -> StatsmodelgamView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsmodelgamView::add(self : StatsmodelgamView, other : StatsmodelgamView) -> StatsmodelgamView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsmodelgamView::copy(self : StatsmodelgamView) -> StatsmodelgamView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsmodelgamView::fill(self : StatsmodelgamView, v : Double) -> StatsmodelgamView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsmodelgamView::min(self : StatsmodelgamView) -> Double { @_common.min(self.data) }

pub fn StatsmodelgamView::max(self : StatsmodelgamView) -> Double { @_common.max(self.data) }

pub fn StatsmodelgamView::to_string(self : StatsmodelgamView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsmodelgamRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_gam_range_make(size : Int) -> StatsmodelgamRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsmodelgamRange::len(self : StatsmodelgamRange) -> Int { self.size }

pub fn StatsmodelgamRange::get(self : StatsmodelgamRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsmodelgamRange::set(self : StatsmodelgamRange, i : Int, v : Double) -> StatsmodelgamRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsmodelgamRange::sum(self : StatsmodelgamRange) -> Double { @_common.sum(self.data) }

pub fn StatsmodelgamRange::mean(self : StatsmodelgamRange) -> Double { @_common.mean(self.data) }

pub fn StatsmodelgamRange::scale(self : StatsmodelgamRange, f : Double) -> StatsmodelgamRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsmodelgamRange::add(self : StatsmodelgamRange, other : StatsmodelgamRange) -> StatsmodelgamRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsmodelgamRange::copy(self : StatsmodelgamRange) -> StatsmodelgamRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsmodelgamRange::fill(self : StatsmodelgamRange, v : Double) -> StatsmodelgamRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsmodelgamRange::min(self : StatsmodelgamRange) -> Double { @_common.min(self.data) }

pub fn StatsmodelgamRange::max(self : StatsmodelgamRange) -> Double { @_common.max(self.data) }

pub fn StatsmodelgamRange::to_string(self : StatsmodelgamRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsmodelgamSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_gam_slice_make(size : Int) -> StatsmodelgamSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsmodelgamSlice::len(self : StatsmodelgamSlice) -> Int { self.size }

pub fn StatsmodelgamSlice::get(self : StatsmodelgamSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsmodelgamSlice::set(self : StatsmodelgamSlice, i : Int, v : Double) -> StatsmodelgamSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsmodelgamSlice::sum(self : StatsmodelgamSlice) -> Double { @_common.sum(self.data) }

pub fn StatsmodelgamSlice::mean(self : StatsmodelgamSlice) -> Double { @_common.mean(self.data) }

pub fn StatsmodelgamSlice::scale(self : StatsmodelgamSlice, f : Double) -> StatsmodelgamSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsmodelgamSlice::add(self : StatsmodelgamSlice, other : StatsmodelgamSlice) -> StatsmodelgamSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsmodelgamSlice::copy(self : StatsmodelgamSlice) -> StatsmodelgamSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsmodelgamSlice::fill(self : StatsmodelgamSlice, v : Double) -> StatsmodelgamSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsmodelgamSlice::min(self : StatsmodelgamSlice) -> Double { @_common.min(self.data) }

pub fn StatsmodelgamSlice::max(self : StatsmodelgamSlice) -> Double { @_common.max(self.data) }

pub fn StatsmodelgamSlice::to_string(self : StatsmodelgamSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

