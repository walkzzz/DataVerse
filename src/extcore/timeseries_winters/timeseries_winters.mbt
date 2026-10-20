///===
/// extcore/timeseries_winters

pub(all) struct TimeserieswintersPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_winters_make_point(x : Double, y : Double) -> TimeserieswintersPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_winters_make_point3(x : Double, y : Double, z : Double) -> TimeserieswintersPoint {
  { x, y, z, label: 0 }
}

pub fn TimeserieswintersPoint::x(self : TimeserieswintersPoint) -> Double { self.x }

pub fn TimeserieswintersPoint::y(self : TimeserieswintersPoint) -> Double { self.y }

pub fn TimeserieswintersPoint::z(self : TimeserieswintersPoint) -> Double { self.z }

pub fn TimeserieswintersPoint::label(self : TimeserieswintersPoint) -> Int { self.label }

pub fn TimeserieswintersPoint::dist(self : TimeserieswintersPoint, other : TimeserieswintersPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeserieswintersPoint::add(self : TimeserieswintersPoint, other : TimeserieswintersPoint) -> TimeserieswintersPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeserieswintersPoint::sub(self : TimeserieswintersPoint, other : TimeserieswintersPoint) -> TimeserieswintersPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeserieswintersPoint::scale(self : TimeserieswintersPoint, s : Double) -> TimeserieswintersPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeserieswintersPoint::dot(self : TimeserieswintersPoint, other : TimeserieswintersPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeserieswintersPoint::cross(self : TimeserieswintersPoint, other : TimeserieswintersPoint) -> TimeserieswintersPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeserieswintersPoint::norm(self : TimeserieswintersPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeserieswintersPoint::normalize(self : TimeserieswintersPoint) -> TimeserieswintersPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeserieswintersPoint::negate(self : TimeserieswintersPoint) -> TimeserieswintersPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeserieswintersPoint::mid(self : TimeserieswintersPoint, other : TimeserieswintersPoint) -> TimeserieswintersPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeserieswintersPoint::lerp(self : TimeserieswintersPoint, other : TimeserieswintersPoint, t : Double) -> TimeserieswintersPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeserieswintersPoint::to_string(self : TimeserieswintersPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeserieswintersSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_winters_make_series(vals : Array[Double], name : String) -> TimeserieswintersSeries {
  { vals, name, meta: 0 }
}

pub fn TimeserieswintersSeries::len(self : TimeserieswintersSeries) -> Int { self.vals.length() }

pub fn TimeserieswintersSeries::sum(self : TimeserieswintersSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeserieswintersSeries::mean(self : TimeserieswintersSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeserieswintersSeries::min(self : TimeserieswintersSeries) -> Double { @_common.min(self.vals) }

pub fn TimeserieswintersSeries::max(self : TimeserieswintersSeries) -> Double { @_common.max(self.vals) }

pub fn TimeserieswintersSeries::range(self : TimeserieswintersSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeserieswintersSeries::variance(self : TimeserieswintersSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeserieswintersSeries::std(self : TimeserieswintersSeries) -> Double { @_common.std(self.vals) }

pub fn TimeserieswintersSeries::median(self : TimeserieswintersSeries) -> Double { @_common.median(self.vals) }

pub fn TimeserieswintersSeries::scale(self : TimeserieswintersSeries, f : Double) -> TimeserieswintersSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeserieswintersSeries::add(self : TimeserieswintersSeries, other : TimeserieswintersSeries) -> TimeserieswintersSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeserieswintersSeries::sub(self : TimeserieswintersSeries, other : TimeserieswintersSeries) -> TimeserieswintersSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeserieswintersSeries::normalize(self : TimeserieswintersSeries) -> TimeserieswintersSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeserieswintersSeries::cumsum(self : TimeserieswintersSeries) -> TimeserieswintersSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeserieswintersSeries::to_string(self : TimeserieswintersSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeserieswintersMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_winters_make_matrix(rows : Int, cols : Int, val : Double) -> TimeserieswintersMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_winters_matrix_identity(n : Int) -> TimeserieswintersMatrix {
  let m = timeseries_winters_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeserieswintersMatrix::get(self : TimeserieswintersMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeserieswintersMatrix::transpose(self : TimeserieswintersMatrix) -> TimeserieswintersMatrix {
  let result = timeseries_winters_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeserieswintersMatrix::add(self : TimeserieswintersMatrix, other : TimeserieswintersMatrix) -> TimeserieswintersMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_winters_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeserieswintersMatrix::scale(self : TimeserieswintersMatrix, s : Double) -> TimeserieswintersMatrix {
  let result = timeseries_winters_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeserieswintersMatrix::multiply(self : TimeserieswintersMatrix, other : TimeserieswintersMatrix) -> TimeserieswintersMatrix {
  if self.cols != other.rows { return timeseries_winters_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_winters_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn TimeserieswintersMatrix::trace(self : TimeserieswintersMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeserieswintersMatrix::det(self : TimeserieswintersMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeserieswintersMatrix::norm(self : TimeserieswintersMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeserieswintersMatrix::to_string(self : TimeserieswintersMatrix) -> String {
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

pub(all) struct TimeserieswintersVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_winters_make_vector(comps : Array[Double]) -> TimeserieswintersVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_winters_vector_zero(dim : Int) -> TimeserieswintersVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeserieswintersVector::add(self : TimeserieswintersVector, other : TimeserieswintersVector) -> TimeserieswintersVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeserieswintersVector::sub(self : TimeserieswintersVector, other : TimeserieswintersVector) -> TimeserieswintersVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeserieswintersVector::scale(self : TimeserieswintersVector, s : Double) -> TimeserieswintersVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeserieswintersVector::dot(self : TimeserieswintersVector, other : TimeserieswintersVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeserieswintersVector::norm(self : TimeserieswintersVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeserieswintersVector::normalize(self : TimeserieswintersVector) -> TimeserieswintersVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeserieswintersVector::dist(self : TimeserieswintersVector, other : TimeserieswintersVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeserieswintersVector::to_string(self : TimeserieswintersVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_winters_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_winters_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_winters_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_winters_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_winters_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_winters_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_winters_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_winters_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_winters_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_winters_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_winters_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_winters_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_winters_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_winters_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_winters_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_winters_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_winters_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_winters_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_winters_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_winters_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_winters_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_winters_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_winters_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_winters_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_winters_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_winters_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_winters_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_winters_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_winters_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeserieswintersFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_winters_frame_make(size : Int) -> TimeserieswintersFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_winters_frame_len(s : TimeserieswintersFrame) -> Int { s.size }

pub fn timeseries_winters_frame_get(s : TimeserieswintersFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_winters_frame_set(s : TimeserieswintersFrame, i : Int, v : Double) -> TimeserieswintersFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_winters_frame_sum(s : TimeserieswintersFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_winters_frame_mean(s : TimeserieswintersFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_winters_frame_scale(s : TimeserieswintersFrame, f : Double) -> TimeserieswintersFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_winters_frame_add(a : TimeserieswintersFrame, b : TimeserieswintersFrame) -> TimeserieswintersFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_winters_frame_copy(s : TimeserieswintersFrame) -> TimeserieswintersFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_winters_frame_fill(s : TimeserieswintersFrame, v : Double) -> TimeserieswintersFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_winters_frame_min(s : TimeserieswintersFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_winters_frame_max(s : TimeserieswintersFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_winters_frame_to_string(s : TimeserieswintersFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeserieswintersTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_winters_table_make(size : Int) -> TimeserieswintersTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_winters_table_len(s : TimeserieswintersTable) -> Int { s.size }

pub fn timeseries_winters_table_get(s : TimeserieswintersTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_winters_table_set(s : TimeserieswintersTable, i : Int, v : Double) -> TimeserieswintersTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_winters_table_sum(s : TimeserieswintersTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_winters_table_mean(s : TimeserieswintersTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_winters_table_scale(s : TimeserieswintersTable, f : Double) -> TimeserieswintersTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_winters_table_add(a : TimeserieswintersTable, b : TimeserieswintersTable) -> TimeserieswintersTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_winters_table_copy(s : TimeserieswintersTable) -> TimeserieswintersTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_winters_table_fill(s : TimeserieswintersTable, v : Double) -> TimeserieswintersTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_winters_table_min(s : TimeserieswintersTable) -> Double { @_common.min(s.data) }

pub fn timeseries_winters_table_max(s : TimeserieswintersTable) -> Double { @_common.max(s.data) }

pub fn timeseries_winters_table_to_string(s : TimeserieswintersTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeserieswintersGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_winters_graphn_make(size : Int) -> TimeserieswintersGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_winters_graphn_len(s : TimeserieswintersGraphN) -> Int { s.size }

pub fn timeseries_winters_graphn_get(s : TimeserieswintersGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_winters_graphn_set(s : TimeserieswintersGraphN, i : Int, v : Double) -> TimeserieswintersGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_winters_graphn_sum(s : TimeserieswintersGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_winters_graphn_mean(s : TimeserieswintersGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_winters_graphn_scale(s : TimeserieswintersGraphN, f : Double) -> TimeserieswintersGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_winters_graphn_add(a : TimeserieswintersGraphN, b : TimeserieswintersGraphN) -> TimeserieswintersGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_winters_graphn_copy(s : TimeserieswintersGraphN) -> TimeserieswintersGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_winters_graphn_fill(s : TimeserieswintersGraphN, v : Double) -> TimeserieswintersGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_winters_graphn_min(s : TimeserieswintersGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_winters_graphn_max(s : TimeserieswintersGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_winters_graphn_to_string(s : TimeserieswintersGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeserieswintersNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_winters_node_make(size : Int) -> TimeserieswintersNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_winters_node_len(s : TimeserieswintersNode) -> Int { s.size }

pub fn timeseries_winters_node_get(s : TimeserieswintersNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_winters_node_set(s : TimeserieswintersNode, i : Int, v : Double) -> TimeserieswintersNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_winters_node_sum(s : TimeserieswintersNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_winters_node_mean(s : TimeserieswintersNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_winters_node_scale(s : TimeserieswintersNode, f : Double) -> TimeserieswintersNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_winters_node_add(a : TimeserieswintersNode, b : TimeserieswintersNode) -> TimeserieswintersNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_winters_node_copy(s : TimeserieswintersNode) -> TimeserieswintersNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_winters_node_fill(s : TimeserieswintersNode, v : Double) -> TimeserieswintersNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_winters_node_min(s : TimeserieswintersNode) -> Double { @_common.min(s.data) }

pub fn timeseries_winters_node_max(s : TimeserieswintersNode) -> Double { @_common.max(s.data) }

pub fn timeseries_winters_node_to_string(s : TimeserieswintersNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeserieswintersEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_winters_edge_make(size : Int) -> TimeserieswintersEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_winters_edge_len(s : TimeserieswintersEdge) -> Int { s.size }

pub fn timeseries_winters_edge_get(s : TimeserieswintersEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_winters_edge_set(s : TimeserieswintersEdge, i : Int, v : Double) -> TimeserieswintersEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_winters_edge_sum(s : TimeserieswintersEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_winters_edge_mean(s : TimeserieswintersEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_winters_edge_scale(s : TimeserieswintersEdge, f : Double) -> TimeserieswintersEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_winters_edge_add(a : TimeserieswintersEdge, b : TimeserieswintersEdge) -> TimeserieswintersEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_winters_edge_copy(s : TimeserieswintersEdge) -> TimeserieswintersEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_winters_edge_fill(s : TimeserieswintersEdge, v : Double) -> TimeserieswintersEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_winters_edge_min(s : TimeserieswintersEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_winters_edge_max(s : TimeserieswintersEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_winters_edge_to_string(s : TimeserieswintersEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeserieswintersPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_winters_path_make(size : Int) -> TimeserieswintersPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_winters_path_len(s : TimeserieswintersPath) -> Int { s.size }

pub fn timeseries_winters_path_get(s : TimeserieswintersPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_winters_path_set(s : TimeserieswintersPath, i : Int, v : Double) -> TimeserieswintersPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_winters_path_sum(s : TimeserieswintersPath) -> Double { @_common.sum(s.data) }

pub fn timeseries_winters_path_mean(s : TimeserieswintersPath) -> Double { @_common.mean(s.data) }

pub fn timeseries_winters_path_scale(s : TimeserieswintersPath, f : Double) -> TimeserieswintersPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_winters_path_add(a : TimeserieswintersPath, b : TimeserieswintersPath) -> TimeserieswintersPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_winters_path_copy(s : TimeserieswintersPath) -> TimeserieswintersPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_winters_path_fill(s : TimeserieswintersPath, v : Double) -> TimeserieswintersPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_winters_path_min(s : TimeserieswintersPath) -> Double { @_common.min(s.data) }

pub fn timeseries_winters_path_max(s : TimeserieswintersPath) -> Double { @_common.max(s.data) }

pub fn timeseries_winters_path_to_string(s : TimeserieswintersPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeserieswintersCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_winters_cluster_make(size : Int) -> TimeserieswintersCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_winters_cluster_len(s : TimeserieswintersCluster) -> Int { s.size }

pub fn timeseries_winters_cluster_get(s : TimeserieswintersCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_winters_cluster_set(s : TimeserieswintersCluster, i : Int, v : Double) -> TimeserieswintersCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_winters_cluster_sum(s : TimeserieswintersCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_winters_cluster_mean(s : TimeserieswintersCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_winters_cluster_scale(s : TimeserieswintersCluster, f : Double) -> TimeserieswintersCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_winters_cluster_add(a : TimeserieswintersCluster, b : TimeserieswintersCluster) -> TimeserieswintersCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_winters_cluster_copy(s : TimeserieswintersCluster) -> TimeserieswintersCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_winters_cluster_fill(s : TimeserieswintersCluster, v : Double) -> TimeserieswintersCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_winters_cluster_min(s : TimeserieswintersCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_winters_cluster_max(s : TimeserieswintersCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_winters_cluster_to_string(s : TimeserieswintersCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeserieswintersModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_winters_model_make(size : Int) -> TimeserieswintersModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_winters_model_len(s : TimeserieswintersModel) -> Int { s.size }

pub fn timeseries_winters_model_get(s : TimeserieswintersModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_winters_model_set(s : TimeserieswintersModel, i : Int, v : Double) -> TimeserieswintersModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_winters_model_sum(s : TimeserieswintersModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_winters_model_mean(s : TimeserieswintersModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_winters_model_scale(s : TimeserieswintersModel, f : Double) -> TimeserieswintersModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_winters_model_add(a : TimeserieswintersModel, b : TimeserieswintersModel) -> TimeserieswintersModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_winters_model_copy(s : TimeserieswintersModel) -> TimeserieswintersModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_winters_model_fill(s : TimeserieswintersModel, v : Double) -> TimeserieswintersModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_winters_model_min(s : TimeserieswintersModel) -> Double { @_common.min(s.data) }

pub fn timeseries_winters_model_max(s : TimeserieswintersModel) -> Double { @_common.max(s.data) }

pub fn timeseries_winters_model_to_string(s : TimeserieswintersModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeserieswintersLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_winters_layer_make(size : Int) -> TimeserieswintersLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_winters_layer_len(s : TimeserieswintersLayer) -> Int { s.size }

pub fn timeseries_winters_layer_get(s : TimeserieswintersLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_winters_layer_set(s : TimeserieswintersLayer, i : Int, v : Double) -> TimeserieswintersLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_winters_layer_sum(s : TimeserieswintersLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_winters_layer_mean(s : TimeserieswintersLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_winters_layer_scale(s : TimeserieswintersLayer, f : Double) -> TimeserieswintersLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_winters_layer_add(a : TimeserieswintersLayer, b : TimeserieswintersLayer) -> TimeserieswintersLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_winters_layer_copy(s : TimeserieswintersLayer) -> TimeserieswintersLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_winters_layer_fill(s : TimeserieswintersLayer, v : Double) -> TimeserieswintersLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_winters_layer_min(s : TimeserieswintersLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_winters_layer_max(s : TimeserieswintersLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_winters_layer_to_string(s : TimeserieswintersLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeserieswintersBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_winters_buffer_make(size : Int) -> TimeserieswintersBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_winters_buffer_len(s : TimeserieswintersBuffer) -> Int { s.size }

pub fn timeseries_winters_buffer_get(s : TimeserieswintersBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_winters_buffer_set(s : TimeserieswintersBuffer, i : Int, v : Double) -> TimeserieswintersBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_winters_buffer_sum(s : TimeserieswintersBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_winters_buffer_mean(s : TimeserieswintersBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_winters_buffer_scale(s : TimeserieswintersBuffer, f : Double) -> TimeserieswintersBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_winters_buffer_add(a : TimeserieswintersBuffer, b : TimeserieswintersBuffer) -> TimeserieswintersBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_winters_buffer_copy(s : TimeserieswintersBuffer) -> TimeserieswintersBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_winters_buffer_fill(s : TimeserieswintersBuffer, v : Double) -> TimeserieswintersBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_winters_buffer_min(s : TimeserieswintersBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_winters_buffer_max(s : TimeserieswintersBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_winters_buffer_to_string(s : TimeserieswintersBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeserieswintersCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_winters_cursor_make(size : Int) -> TimeserieswintersCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_winters_cursor_len(s : TimeserieswintersCursor) -> Int { s.size }

pub fn timeseries_winters_cursor_get(s : TimeserieswintersCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_winters_cursor_set(s : TimeserieswintersCursor, i : Int, v : Double) -> TimeserieswintersCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_winters_cursor_sum(s : TimeserieswintersCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_winters_cursor_mean(s : TimeserieswintersCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_winters_cursor_scale(s : TimeserieswintersCursor, f : Double) -> TimeserieswintersCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_winters_cursor_add(a : TimeserieswintersCursor, b : TimeserieswintersCursor) -> TimeserieswintersCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_winters_cursor_copy(s : TimeserieswintersCursor) -> TimeserieswintersCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_winters_cursor_fill(s : TimeserieswintersCursor, v : Double) -> TimeserieswintersCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_winters_cursor_min(s : TimeserieswintersCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_winters_cursor_max(s : TimeserieswintersCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_winters_cursor_to_string(s : TimeserieswintersCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeserieswintersView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_winters_view_make(size : Int) -> TimeserieswintersView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_winters_view_len(s : TimeserieswintersView) -> Int { s.size }

pub fn timeseries_winters_view_get(s : TimeserieswintersView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_winters_view_set(s : TimeserieswintersView, i : Int, v : Double) -> TimeserieswintersView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_winters_view_sum(s : TimeserieswintersView) -> Double { @_common.sum(s.data) }

pub fn timeseries_winters_view_mean(s : TimeserieswintersView) -> Double { @_common.mean(s.data) }

pub fn timeseries_winters_view_scale(s : TimeserieswintersView, f : Double) -> TimeserieswintersView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_winters_view_add(a : TimeserieswintersView, b : TimeserieswintersView) -> TimeserieswintersView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_winters_view_copy(s : TimeserieswintersView) -> TimeserieswintersView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_winters_view_fill(s : TimeserieswintersView, v : Double) -> TimeserieswintersView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_winters_view_min(s : TimeserieswintersView) -> Double { @_common.min(s.data) }

pub fn timeseries_winters_view_max(s : TimeserieswintersView) -> Double { @_common.max(s.data) }

pub fn timeseries_winters_view_to_string(s : TimeserieswintersView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeserieswintersRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_winters_range_make(size : Int) -> TimeserieswintersRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_winters_range_len(s : TimeserieswintersRange) -> Int { s.size }

pub fn timeseries_winters_range_get(s : TimeserieswintersRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_winters_range_set(s : TimeserieswintersRange, i : Int, v : Double) -> TimeserieswintersRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_winters_range_sum(s : TimeserieswintersRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_winters_range_mean(s : TimeserieswintersRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_winters_range_scale(s : TimeserieswintersRange, f : Double) -> TimeserieswintersRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_winters_range_add(a : TimeserieswintersRange, b : TimeserieswintersRange) -> TimeserieswintersRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_winters_range_copy(s : TimeserieswintersRange) -> TimeserieswintersRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_winters_range_fill(s : TimeserieswintersRange, v : Double) -> TimeserieswintersRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_winters_range_min(s : TimeserieswintersRange) -> Double { @_common.min(s.data) }

pub fn timeseries_winters_range_max(s : TimeserieswintersRange) -> Double { @_common.max(s.data) }

pub fn timeseries_winters_range_to_string(s : TimeserieswintersRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeserieswintersSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_winters_slice_make(size : Int) -> TimeserieswintersSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_winters_slice_len(s : TimeserieswintersSlice) -> Int { s.size }

pub fn timeseries_winters_slice_get(s : TimeserieswintersSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_winters_slice_set(s : TimeserieswintersSlice, i : Int, v : Double) -> TimeserieswintersSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_winters_slice_sum(s : TimeserieswintersSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_winters_slice_mean(s : TimeserieswintersSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_winters_slice_scale(s : TimeserieswintersSlice, f : Double) -> TimeserieswintersSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_winters_slice_add(a : TimeserieswintersSlice, b : TimeserieswintersSlice) -> TimeserieswintersSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_winters_slice_copy(s : TimeserieswintersSlice) -> TimeserieswintersSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_winters_slice_fill(s : TimeserieswintersSlice, v : Double) -> TimeserieswintersSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_winters_slice_min(s : TimeserieswintersSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_winters_slice_max(s : TimeserieswintersSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_winters_slice_to_string(s : TimeserieswintersSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

