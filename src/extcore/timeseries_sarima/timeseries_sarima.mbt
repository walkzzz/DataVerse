///===
/// extcore/timeseries_sarima

pub(all) struct TimeseriessarimaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_sarima_make_point(x : Double, y : Double) -> TimeseriessarimaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_sarima_make_point3(x : Double, y : Double, z : Double) -> TimeseriessarimaPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriessarimaPoint::x(self : TimeseriessarimaPoint) -> Double { self.x }

pub fn TimeseriessarimaPoint::y(self : TimeseriessarimaPoint) -> Double { self.y }

pub fn TimeseriessarimaPoint::z(self : TimeseriessarimaPoint) -> Double { self.z }

pub fn TimeseriessarimaPoint::label(self : TimeseriessarimaPoint) -> Int { self.label }

pub fn TimeseriessarimaPoint::dist(self : TimeseriessarimaPoint, other : TimeseriessarimaPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriessarimaPoint::add(self : TimeseriessarimaPoint, other : TimeseriessarimaPoint) -> TimeseriessarimaPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriessarimaPoint::sub(self : TimeseriessarimaPoint, other : TimeseriessarimaPoint) -> TimeseriessarimaPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriessarimaPoint::scale(self : TimeseriessarimaPoint, s : Double) -> TimeseriessarimaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriessarimaPoint::dot(self : TimeseriessarimaPoint, other : TimeseriessarimaPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriessarimaPoint::cross(self : TimeseriessarimaPoint, other : TimeseriessarimaPoint) -> TimeseriessarimaPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriessarimaPoint::norm(self : TimeseriessarimaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriessarimaPoint::normalize(self : TimeseriessarimaPoint) -> TimeseriessarimaPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriessarimaPoint::negate(self : TimeseriessarimaPoint) -> TimeseriessarimaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriessarimaPoint::mid(self : TimeseriessarimaPoint, other : TimeseriessarimaPoint) -> TimeseriessarimaPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriessarimaPoint::lerp(self : TimeseriessarimaPoint, other : TimeseriessarimaPoint, t : Double) -> TimeseriessarimaPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriessarimaPoint::to_string(self : TimeseriessarimaPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriessarimaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_sarima_make_series(vals : Array[Double], name : String) -> TimeseriessarimaSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriessarimaSeries::len(self : TimeseriessarimaSeries) -> Int { self.vals.length() }

pub fn TimeseriessarimaSeries::sum(self : TimeseriessarimaSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriessarimaSeries::mean(self : TimeseriessarimaSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriessarimaSeries::min(self : TimeseriessarimaSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriessarimaSeries::max(self : TimeseriessarimaSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriessarimaSeries::range(self : TimeseriessarimaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriessarimaSeries::variance(self : TimeseriessarimaSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriessarimaSeries::std(self : TimeseriessarimaSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriessarimaSeries::median(self : TimeseriessarimaSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriessarimaSeries::scale(self : TimeseriessarimaSeries, f : Double) -> TimeseriessarimaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriessarimaSeries::add(self : TimeseriessarimaSeries, other : TimeseriessarimaSeries) -> TimeseriessarimaSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriessarimaSeries::sub(self : TimeseriessarimaSeries, other : TimeseriessarimaSeries) -> TimeseriessarimaSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriessarimaSeries::normalize(self : TimeseriessarimaSeries) -> TimeseriessarimaSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriessarimaSeries::cumsum(self : TimeseriessarimaSeries) -> TimeseriessarimaSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriessarimaSeries::to_string(self : TimeseriessarimaSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriessarimaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_sarima_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriessarimaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_sarima_matrix_identity(n : Int) -> TimeseriessarimaMatrix {
  let m = timeseries_sarima_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriessarimaMatrix::get(self : TimeseriessarimaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriessarimaMatrix::transpose(self : TimeseriessarimaMatrix) -> TimeseriessarimaMatrix {
  let result = timeseries_sarima_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriessarimaMatrix::add(self : TimeseriessarimaMatrix, other : TimeseriessarimaMatrix) -> TimeseriessarimaMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_sarima_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriessarimaMatrix::scale(self : TimeseriessarimaMatrix, s : Double) -> TimeseriessarimaMatrix {
  let result = timeseries_sarima_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriessarimaMatrix::multiply(self : TimeseriessarimaMatrix, other : TimeseriessarimaMatrix) -> TimeseriessarimaMatrix {
  if self.cols != other.rows { return timeseries_sarima_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_sarima_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn TimeseriessarimaMatrix::trace(self : TimeseriessarimaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriessarimaMatrix::det(self : TimeseriessarimaMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriessarimaMatrix::norm(self : TimeseriessarimaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriessarimaMatrix::to_string(self : TimeseriessarimaMatrix) -> String {
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

pub(all) struct TimeseriessarimaVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_sarima_make_vector(comps : Array[Double]) -> TimeseriessarimaVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_sarima_vector_zero(dim : Int) -> TimeseriessarimaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriessarimaVector::add(self : TimeseriessarimaVector, other : TimeseriessarimaVector) -> TimeseriessarimaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriessarimaVector::sub(self : TimeseriessarimaVector, other : TimeseriessarimaVector) -> TimeseriessarimaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriessarimaVector::scale(self : TimeseriessarimaVector, s : Double) -> TimeseriessarimaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriessarimaVector::dot(self : TimeseriessarimaVector, other : TimeseriessarimaVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriessarimaVector::norm(self : TimeseriessarimaVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriessarimaVector::normalize(self : TimeseriessarimaVector) -> TimeseriessarimaVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriessarimaVector::dist(self : TimeseriessarimaVector, other : TimeseriessarimaVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriessarimaVector::to_string(self : TimeseriessarimaVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_sarima_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_sarima_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_sarima_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_sarima_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_sarima_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_sarima_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_sarima_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_sarima_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_sarima_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_sarima_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_sarima_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_sarima_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_sarima_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_sarima_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_sarima_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_sarima_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_sarima_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_sarima_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_sarima_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_sarima_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_sarima_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_sarima_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_sarima_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_sarima_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_sarima_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_sarima_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_sarima_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_sarima_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_sarima_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriessarimaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_sarima_frame_make(size : Int) -> TimeseriessarimaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_sarima_frame_len(s : TimeseriessarimaFrame) -> Int { s.size }

pub fn timeseries_sarima_frame_get(s : TimeseriessarimaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_sarima_frame_set(s : TimeseriessarimaFrame, i : Int, v : Double) -> TimeseriessarimaFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_frame_sum(s : TimeseriessarimaFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_sarima_frame_mean(s : TimeseriessarimaFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_sarima_frame_scale(s : TimeseriessarimaFrame, f : Double) -> TimeseriessarimaFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_frame_add(a : TimeseriessarimaFrame, b : TimeseriessarimaFrame) -> TimeseriessarimaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_sarima_frame_copy(s : TimeseriessarimaFrame) -> TimeseriessarimaFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_frame_fill(s : TimeseriessarimaFrame, v : Double) -> TimeseriessarimaFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_frame_min(s : TimeseriessarimaFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_sarima_frame_max(s : TimeseriessarimaFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_sarima_frame_to_string(s : TimeseriessarimaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriessarimaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_sarima_table_make(size : Int) -> TimeseriessarimaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_sarima_table_len(s : TimeseriessarimaTable) -> Int { s.size }

pub fn timeseries_sarima_table_get(s : TimeseriessarimaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_sarima_table_set(s : TimeseriessarimaTable, i : Int, v : Double) -> TimeseriessarimaTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_table_sum(s : TimeseriessarimaTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_sarima_table_mean(s : TimeseriessarimaTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_sarima_table_scale(s : TimeseriessarimaTable, f : Double) -> TimeseriessarimaTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_table_add(a : TimeseriessarimaTable, b : TimeseriessarimaTable) -> TimeseriessarimaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_sarima_table_copy(s : TimeseriessarimaTable) -> TimeseriessarimaTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_table_fill(s : TimeseriessarimaTable, v : Double) -> TimeseriessarimaTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_table_min(s : TimeseriessarimaTable) -> Double { @_common.min(s.data) }

pub fn timeseries_sarima_table_max(s : TimeseriessarimaTable) -> Double { @_common.max(s.data) }

pub fn timeseries_sarima_table_to_string(s : TimeseriessarimaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriessarimaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_sarima_graphn_make(size : Int) -> TimeseriessarimaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_sarima_graphn_len(s : TimeseriessarimaGraphN) -> Int { s.size }

pub fn timeseries_sarima_graphn_get(s : TimeseriessarimaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_sarima_graphn_set(s : TimeseriessarimaGraphN, i : Int, v : Double) -> TimeseriessarimaGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_graphn_sum(s : TimeseriessarimaGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_sarima_graphn_mean(s : TimeseriessarimaGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_sarima_graphn_scale(s : TimeseriessarimaGraphN, f : Double) -> TimeseriessarimaGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_graphn_add(a : TimeseriessarimaGraphN, b : TimeseriessarimaGraphN) -> TimeseriessarimaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_sarima_graphn_copy(s : TimeseriessarimaGraphN) -> TimeseriessarimaGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_graphn_fill(s : TimeseriessarimaGraphN, v : Double) -> TimeseriessarimaGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_graphn_min(s : TimeseriessarimaGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_sarima_graphn_max(s : TimeseriessarimaGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_sarima_graphn_to_string(s : TimeseriessarimaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriessarimaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_sarima_node_make(size : Int) -> TimeseriessarimaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_sarima_node_len(s : TimeseriessarimaNode) -> Int { s.size }

pub fn timeseries_sarima_node_get(s : TimeseriessarimaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_sarima_node_set(s : TimeseriessarimaNode, i : Int, v : Double) -> TimeseriessarimaNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_node_sum(s : TimeseriessarimaNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_sarima_node_mean(s : TimeseriessarimaNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_sarima_node_scale(s : TimeseriessarimaNode, f : Double) -> TimeseriessarimaNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_node_add(a : TimeseriessarimaNode, b : TimeseriessarimaNode) -> TimeseriessarimaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_sarima_node_copy(s : TimeseriessarimaNode) -> TimeseriessarimaNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_node_fill(s : TimeseriessarimaNode, v : Double) -> TimeseriessarimaNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_node_min(s : TimeseriessarimaNode) -> Double { @_common.min(s.data) }

pub fn timeseries_sarima_node_max(s : TimeseriessarimaNode) -> Double { @_common.max(s.data) }

pub fn timeseries_sarima_node_to_string(s : TimeseriessarimaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriessarimaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_sarima_edge_make(size : Int) -> TimeseriessarimaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_sarima_edge_len(s : TimeseriessarimaEdge) -> Int { s.size }

pub fn timeseries_sarima_edge_get(s : TimeseriessarimaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_sarima_edge_set(s : TimeseriessarimaEdge, i : Int, v : Double) -> TimeseriessarimaEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_edge_sum(s : TimeseriessarimaEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_sarima_edge_mean(s : TimeseriessarimaEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_sarima_edge_scale(s : TimeseriessarimaEdge, f : Double) -> TimeseriessarimaEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_edge_add(a : TimeseriessarimaEdge, b : TimeseriessarimaEdge) -> TimeseriessarimaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_sarima_edge_copy(s : TimeseriessarimaEdge) -> TimeseriessarimaEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_edge_fill(s : TimeseriessarimaEdge, v : Double) -> TimeseriessarimaEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_edge_min(s : TimeseriessarimaEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_sarima_edge_max(s : TimeseriessarimaEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_sarima_edge_to_string(s : TimeseriessarimaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriessarimaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_sarima_path_make(size : Int) -> TimeseriessarimaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_sarima_path_len(s : TimeseriessarimaPath) -> Int { s.size }

pub fn timeseries_sarima_path_get(s : TimeseriessarimaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_sarima_path_set(s : TimeseriessarimaPath, i : Int, v : Double) -> TimeseriessarimaPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_path_sum(s : TimeseriessarimaPath) -> Double { @_common.sum(s.data) }

pub fn timeseries_sarima_path_mean(s : TimeseriessarimaPath) -> Double { @_common.mean(s.data) }

pub fn timeseries_sarima_path_scale(s : TimeseriessarimaPath, f : Double) -> TimeseriessarimaPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_path_add(a : TimeseriessarimaPath, b : TimeseriessarimaPath) -> TimeseriessarimaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_sarima_path_copy(s : TimeseriessarimaPath) -> TimeseriessarimaPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_path_fill(s : TimeseriessarimaPath, v : Double) -> TimeseriessarimaPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_path_min(s : TimeseriessarimaPath) -> Double { @_common.min(s.data) }

pub fn timeseries_sarima_path_max(s : TimeseriessarimaPath) -> Double { @_common.max(s.data) }

pub fn timeseries_sarima_path_to_string(s : TimeseriessarimaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriessarimaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_sarima_cluster_make(size : Int) -> TimeseriessarimaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_sarima_cluster_len(s : TimeseriessarimaCluster) -> Int { s.size }

pub fn timeseries_sarima_cluster_get(s : TimeseriessarimaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_sarima_cluster_set(s : TimeseriessarimaCluster, i : Int, v : Double) -> TimeseriessarimaCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_cluster_sum(s : TimeseriessarimaCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_sarima_cluster_mean(s : TimeseriessarimaCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_sarima_cluster_scale(s : TimeseriessarimaCluster, f : Double) -> TimeseriessarimaCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_cluster_add(a : TimeseriessarimaCluster, b : TimeseriessarimaCluster) -> TimeseriessarimaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_sarima_cluster_copy(s : TimeseriessarimaCluster) -> TimeseriessarimaCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_cluster_fill(s : TimeseriessarimaCluster, v : Double) -> TimeseriessarimaCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_cluster_min(s : TimeseriessarimaCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_sarima_cluster_max(s : TimeseriessarimaCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_sarima_cluster_to_string(s : TimeseriessarimaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriessarimaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_sarima_model_make(size : Int) -> TimeseriessarimaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_sarima_model_len(s : TimeseriessarimaModel) -> Int { s.size }

pub fn timeseries_sarima_model_get(s : TimeseriessarimaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_sarima_model_set(s : TimeseriessarimaModel, i : Int, v : Double) -> TimeseriessarimaModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_model_sum(s : TimeseriessarimaModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_sarima_model_mean(s : TimeseriessarimaModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_sarima_model_scale(s : TimeseriessarimaModel, f : Double) -> TimeseriessarimaModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_model_add(a : TimeseriessarimaModel, b : TimeseriessarimaModel) -> TimeseriessarimaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_sarima_model_copy(s : TimeseriessarimaModel) -> TimeseriessarimaModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_model_fill(s : TimeseriessarimaModel, v : Double) -> TimeseriessarimaModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_model_min(s : TimeseriessarimaModel) -> Double { @_common.min(s.data) }

pub fn timeseries_sarima_model_max(s : TimeseriessarimaModel) -> Double { @_common.max(s.data) }

pub fn timeseries_sarima_model_to_string(s : TimeseriessarimaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriessarimaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_sarima_layer_make(size : Int) -> TimeseriessarimaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_sarima_layer_len(s : TimeseriessarimaLayer) -> Int { s.size }

pub fn timeseries_sarima_layer_get(s : TimeseriessarimaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_sarima_layer_set(s : TimeseriessarimaLayer, i : Int, v : Double) -> TimeseriessarimaLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_layer_sum(s : TimeseriessarimaLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_sarima_layer_mean(s : TimeseriessarimaLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_sarima_layer_scale(s : TimeseriessarimaLayer, f : Double) -> TimeseriessarimaLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_layer_add(a : TimeseriessarimaLayer, b : TimeseriessarimaLayer) -> TimeseriessarimaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_sarima_layer_copy(s : TimeseriessarimaLayer) -> TimeseriessarimaLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_layer_fill(s : TimeseriessarimaLayer, v : Double) -> TimeseriessarimaLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_layer_min(s : TimeseriessarimaLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_sarima_layer_max(s : TimeseriessarimaLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_sarima_layer_to_string(s : TimeseriessarimaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriessarimaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_sarima_buffer_make(size : Int) -> TimeseriessarimaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_sarima_buffer_len(s : TimeseriessarimaBuffer) -> Int { s.size }

pub fn timeseries_sarima_buffer_get(s : TimeseriessarimaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_sarima_buffer_set(s : TimeseriessarimaBuffer, i : Int, v : Double) -> TimeseriessarimaBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_buffer_sum(s : TimeseriessarimaBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_sarima_buffer_mean(s : TimeseriessarimaBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_sarima_buffer_scale(s : TimeseriessarimaBuffer, f : Double) -> TimeseriessarimaBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_buffer_add(a : TimeseriessarimaBuffer, b : TimeseriessarimaBuffer) -> TimeseriessarimaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_sarima_buffer_copy(s : TimeseriessarimaBuffer) -> TimeseriessarimaBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_buffer_fill(s : TimeseriessarimaBuffer, v : Double) -> TimeseriessarimaBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_buffer_min(s : TimeseriessarimaBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_sarima_buffer_max(s : TimeseriessarimaBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_sarima_buffer_to_string(s : TimeseriessarimaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriessarimaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_sarima_cursor_make(size : Int) -> TimeseriessarimaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_sarima_cursor_len(s : TimeseriessarimaCursor) -> Int { s.size }

pub fn timeseries_sarima_cursor_get(s : TimeseriessarimaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_sarima_cursor_set(s : TimeseriessarimaCursor, i : Int, v : Double) -> TimeseriessarimaCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_cursor_sum(s : TimeseriessarimaCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_sarima_cursor_mean(s : TimeseriessarimaCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_sarima_cursor_scale(s : TimeseriessarimaCursor, f : Double) -> TimeseriessarimaCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_cursor_add(a : TimeseriessarimaCursor, b : TimeseriessarimaCursor) -> TimeseriessarimaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_sarima_cursor_copy(s : TimeseriessarimaCursor) -> TimeseriessarimaCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_cursor_fill(s : TimeseriessarimaCursor, v : Double) -> TimeseriessarimaCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_cursor_min(s : TimeseriessarimaCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_sarima_cursor_max(s : TimeseriessarimaCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_sarima_cursor_to_string(s : TimeseriessarimaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriessarimaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_sarima_view_make(size : Int) -> TimeseriessarimaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_sarima_view_len(s : TimeseriessarimaView) -> Int { s.size }

pub fn timeseries_sarima_view_get(s : TimeseriessarimaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_sarima_view_set(s : TimeseriessarimaView, i : Int, v : Double) -> TimeseriessarimaView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_view_sum(s : TimeseriessarimaView) -> Double { @_common.sum(s.data) }

pub fn timeseries_sarima_view_mean(s : TimeseriessarimaView) -> Double { @_common.mean(s.data) }

pub fn timeseries_sarima_view_scale(s : TimeseriessarimaView, f : Double) -> TimeseriessarimaView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_view_add(a : TimeseriessarimaView, b : TimeseriessarimaView) -> TimeseriessarimaView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_sarima_view_copy(s : TimeseriessarimaView) -> TimeseriessarimaView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_view_fill(s : TimeseriessarimaView, v : Double) -> TimeseriessarimaView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_view_min(s : TimeseriessarimaView) -> Double { @_common.min(s.data) }

pub fn timeseries_sarima_view_max(s : TimeseriessarimaView) -> Double { @_common.max(s.data) }

pub fn timeseries_sarima_view_to_string(s : TimeseriessarimaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriessarimaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_sarima_range_make(size : Int) -> TimeseriessarimaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_sarima_range_len(s : TimeseriessarimaRange) -> Int { s.size }

pub fn timeseries_sarima_range_get(s : TimeseriessarimaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_sarima_range_set(s : TimeseriessarimaRange, i : Int, v : Double) -> TimeseriessarimaRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_range_sum(s : TimeseriessarimaRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_sarima_range_mean(s : TimeseriessarimaRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_sarima_range_scale(s : TimeseriessarimaRange, f : Double) -> TimeseriessarimaRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_range_add(a : TimeseriessarimaRange, b : TimeseriessarimaRange) -> TimeseriessarimaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_sarima_range_copy(s : TimeseriessarimaRange) -> TimeseriessarimaRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_range_fill(s : TimeseriessarimaRange, v : Double) -> TimeseriessarimaRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_range_min(s : TimeseriessarimaRange) -> Double { @_common.min(s.data) }

pub fn timeseries_sarima_range_max(s : TimeseriessarimaRange) -> Double { @_common.max(s.data) }

pub fn timeseries_sarima_range_to_string(s : TimeseriessarimaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriessarimaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_sarima_slice_make(size : Int) -> TimeseriessarimaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_sarima_slice_len(s : TimeseriessarimaSlice) -> Int { s.size }

pub fn timeseries_sarima_slice_get(s : TimeseriessarimaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_sarima_slice_set(s : TimeseriessarimaSlice, i : Int, v : Double) -> TimeseriessarimaSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_slice_sum(s : TimeseriessarimaSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_sarima_slice_mean(s : TimeseriessarimaSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_sarima_slice_scale(s : TimeseriessarimaSlice, f : Double) -> TimeseriessarimaSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_slice_add(a : TimeseriessarimaSlice, b : TimeseriessarimaSlice) -> TimeseriessarimaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_sarima_slice_copy(s : TimeseriessarimaSlice) -> TimeseriessarimaSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_slice_fill(s : TimeseriessarimaSlice, v : Double) -> TimeseriessarimaSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_slice_min(s : TimeseriessarimaSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_sarima_slice_max(s : TimeseriessarimaSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_sarima_slice_to_string(s : TimeseriessarimaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

