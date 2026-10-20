///===
/// extcore/net_sec_rate_limit

pub(all) struct NetsecratelimitPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_sec_rate_limit_make_point(x : Double, y : Double) -> NetsecratelimitPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_sec_rate_limit_make_point3(x : Double, y : Double, z : Double) -> NetsecratelimitPoint {
  { x, y, z, label: 0 }
}

pub fn NetsecratelimitPoint::x(self : NetsecratelimitPoint) -> Double { self.x }

pub fn NetsecratelimitPoint::y(self : NetsecratelimitPoint) -> Double { self.y }

pub fn NetsecratelimitPoint::z(self : NetsecratelimitPoint) -> Double { self.z }

pub fn NetsecratelimitPoint::label(self : NetsecratelimitPoint) -> Int { self.label }

pub fn NetsecratelimitPoint::dist(self : NetsecratelimitPoint, other : NetsecratelimitPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetsecratelimitPoint::add(self : NetsecratelimitPoint, other : NetsecratelimitPoint) -> NetsecratelimitPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetsecratelimitPoint::sub(self : NetsecratelimitPoint, other : NetsecratelimitPoint) -> NetsecratelimitPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetsecratelimitPoint::scale(self : NetsecratelimitPoint, s : Double) -> NetsecratelimitPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetsecratelimitPoint::dot(self : NetsecratelimitPoint, other : NetsecratelimitPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetsecratelimitPoint::cross(self : NetsecratelimitPoint, other : NetsecratelimitPoint) -> NetsecratelimitPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetsecratelimitPoint::norm(self : NetsecratelimitPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetsecratelimitPoint::normalize(self : NetsecratelimitPoint) -> NetsecratelimitPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetsecratelimitPoint::negate(self : NetsecratelimitPoint) -> NetsecratelimitPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetsecratelimitPoint::mid(self : NetsecratelimitPoint, other : NetsecratelimitPoint) -> NetsecratelimitPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetsecratelimitPoint::lerp(self : NetsecratelimitPoint, other : NetsecratelimitPoint, t : Double) -> NetsecratelimitPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetsecratelimitPoint::to_string(self : NetsecratelimitPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetsecratelimitSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_sec_rate_limit_make_series(vals : Array[Double], name : String) -> NetsecratelimitSeries {
  { vals, name, meta: 0 }
}

pub fn NetsecratelimitSeries::len(self : NetsecratelimitSeries) -> Int { self.vals.length() }

pub fn NetsecratelimitSeries::sum(self : NetsecratelimitSeries) -> Double { @_common.sum(self.vals) }

pub fn NetsecratelimitSeries::mean(self : NetsecratelimitSeries) -> Double { @_common.mean(self.vals) }

pub fn NetsecratelimitSeries::min(self : NetsecratelimitSeries) -> Double { @_common.min(self.vals) }

pub fn NetsecratelimitSeries::max(self : NetsecratelimitSeries) -> Double { @_common.max(self.vals) }

pub fn NetsecratelimitSeries::range(self : NetsecratelimitSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetsecratelimitSeries::variance(self : NetsecratelimitSeries) -> Double { @_common.variance(self.vals) }

pub fn NetsecratelimitSeries::std(self : NetsecratelimitSeries) -> Double { @_common.std(self.vals) }

pub fn NetsecratelimitSeries::median(self : NetsecratelimitSeries) -> Double { @_common.median(self.vals) }

pub fn NetsecratelimitSeries::scale(self : NetsecratelimitSeries, f : Double) -> NetsecratelimitSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetsecratelimitSeries::add(self : NetsecratelimitSeries, other : NetsecratelimitSeries) -> NetsecratelimitSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetsecratelimitSeries::sub(self : NetsecratelimitSeries, other : NetsecratelimitSeries) -> NetsecratelimitSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetsecratelimitSeries::normalize(self : NetsecratelimitSeries) -> NetsecratelimitSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetsecratelimitSeries::cumsum(self : NetsecratelimitSeries) -> NetsecratelimitSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetsecratelimitSeries::to_string(self : NetsecratelimitSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetsecratelimitMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_sec_rate_limit_make_matrix(rows : Int, cols : Int, val : Double) -> NetsecratelimitMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_sec_rate_limit_matrix_identity(n : Int) -> NetsecratelimitMatrix {
  let m = net_sec_rate_limit_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetsecratelimitMatrix::get(self : NetsecratelimitMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetsecratelimitMatrix::transpose(self : NetsecratelimitMatrix) -> NetsecratelimitMatrix {
  let result = net_sec_rate_limit_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetsecratelimitMatrix::add(self : NetsecratelimitMatrix, other : NetsecratelimitMatrix) -> NetsecratelimitMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_sec_rate_limit_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetsecratelimitMatrix::scale(self : NetsecratelimitMatrix, s : Double) -> NetsecratelimitMatrix {
  let result = net_sec_rate_limit_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetsecratelimitMatrix::multiply(self : NetsecratelimitMatrix, other : NetsecratelimitMatrix) -> NetsecratelimitMatrix {
  if self.cols != other.rows { return net_sec_rate_limit_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_sec_rate_limit_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NetsecratelimitMatrix::trace(self : NetsecratelimitMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetsecratelimitMatrix::det(self : NetsecratelimitMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetsecratelimitMatrix::norm(self : NetsecratelimitMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetsecratelimitMatrix::to_string(self : NetsecratelimitMatrix) -> String {
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

pub(all) struct NetsecratelimitVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_sec_rate_limit_make_vector(comps : Array[Double]) -> NetsecratelimitVector {
  { comps, dim: comps.length() }
}

pub fn net_sec_rate_limit_vector_zero(dim : Int) -> NetsecratelimitVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetsecratelimitVector::add(self : NetsecratelimitVector, other : NetsecratelimitVector) -> NetsecratelimitVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetsecratelimitVector::sub(self : NetsecratelimitVector, other : NetsecratelimitVector) -> NetsecratelimitVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetsecratelimitVector::scale(self : NetsecratelimitVector, s : Double) -> NetsecratelimitVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetsecratelimitVector::dot(self : NetsecratelimitVector, other : NetsecratelimitVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetsecratelimitVector::norm(self : NetsecratelimitVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetsecratelimitVector::normalize(self : NetsecratelimitVector) -> NetsecratelimitVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetsecratelimitVector::dist(self : NetsecratelimitVector, other : NetsecratelimitVector) -> Double {
  self.sub(other).norm()
}

pub fn NetsecratelimitVector::to_string(self : NetsecratelimitVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_sec_rate_limit_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_sec_rate_limit_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_sec_rate_limit_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_sec_rate_limit_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_sec_rate_limit_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_sec_rate_limit_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_sec_rate_limit_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_sec_rate_limit_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_sec_rate_limit_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_sec_rate_limit_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_sec_rate_limit_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_sec_rate_limit_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_sec_rate_limit_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_sec_rate_limit_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_sec_rate_limit_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_sec_rate_limit_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_sec_rate_limit_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_sec_rate_limit_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_sec_rate_limit_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_sec_rate_limit_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_sec_rate_limit_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_sec_rate_limit_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_sec_rate_limit_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_sec_rate_limit_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_sec_rate_limit_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_sec_rate_limit_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_sec_rate_limit_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_sec_rate_limit_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_sec_rate_limit_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetsecratelimitFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_rate_limit_frame_make(size : Int) -> NetsecratelimitFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_rate_limit_frame_len(s : NetsecratelimitFrame) -> Int { s.size }

pub fn net_sec_rate_limit_frame_get(s : NetsecratelimitFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_rate_limit_frame_set(s : NetsecratelimitFrame, i : Int, v : Double) -> NetsecratelimitFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_frame_sum(s : NetsecratelimitFrame) -> Double { @_common.sum(s.data) }

pub fn net_sec_rate_limit_frame_mean(s : NetsecratelimitFrame) -> Double { @_common.mean(s.data) }

pub fn net_sec_rate_limit_frame_scale(s : NetsecratelimitFrame, f : Double) -> NetsecratelimitFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_frame_add(a : NetsecratelimitFrame, b : NetsecratelimitFrame) -> NetsecratelimitFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_rate_limit_frame_copy(s : NetsecratelimitFrame) -> NetsecratelimitFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_frame_fill(s : NetsecratelimitFrame, v : Double) -> NetsecratelimitFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_frame_min(s : NetsecratelimitFrame) -> Double { @_common.min(s.data) }

pub fn net_sec_rate_limit_frame_max(s : NetsecratelimitFrame) -> Double { @_common.max(s.data) }

pub fn net_sec_rate_limit_frame_to_string(s : NetsecratelimitFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecratelimitTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_rate_limit_table_make(size : Int) -> NetsecratelimitTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_rate_limit_table_len(s : NetsecratelimitTable) -> Int { s.size }

pub fn net_sec_rate_limit_table_get(s : NetsecratelimitTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_rate_limit_table_set(s : NetsecratelimitTable, i : Int, v : Double) -> NetsecratelimitTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_table_sum(s : NetsecratelimitTable) -> Double { @_common.sum(s.data) }

pub fn net_sec_rate_limit_table_mean(s : NetsecratelimitTable) -> Double { @_common.mean(s.data) }

pub fn net_sec_rate_limit_table_scale(s : NetsecratelimitTable, f : Double) -> NetsecratelimitTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_table_add(a : NetsecratelimitTable, b : NetsecratelimitTable) -> NetsecratelimitTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_rate_limit_table_copy(s : NetsecratelimitTable) -> NetsecratelimitTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_table_fill(s : NetsecratelimitTable, v : Double) -> NetsecratelimitTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_table_min(s : NetsecratelimitTable) -> Double { @_common.min(s.data) }

pub fn net_sec_rate_limit_table_max(s : NetsecratelimitTable) -> Double { @_common.max(s.data) }

pub fn net_sec_rate_limit_table_to_string(s : NetsecratelimitTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecratelimitGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_rate_limit_graphn_make(size : Int) -> NetsecratelimitGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_rate_limit_graphn_len(s : NetsecratelimitGraphN) -> Int { s.size }

pub fn net_sec_rate_limit_graphn_get(s : NetsecratelimitGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_rate_limit_graphn_set(s : NetsecratelimitGraphN, i : Int, v : Double) -> NetsecratelimitGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_graphn_sum(s : NetsecratelimitGraphN) -> Double { @_common.sum(s.data) }

pub fn net_sec_rate_limit_graphn_mean(s : NetsecratelimitGraphN) -> Double { @_common.mean(s.data) }

pub fn net_sec_rate_limit_graphn_scale(s : NetsecratelimitGraphN, f : Double) -> NetsecratelimitGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_graphn_add(a : NetsecratelimitGraphN, b : NetsecratelimitGraphN) -> NetsecratelimitGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_rate_limit_graphn_copy(s : NetsecratelimitGraphN) -> NetsecratelimitGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_graphn_fill(s : NetsecratelimitGraphN, v : Double) -> NetsecratelimitGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_graphn_min(s : NetsecratelimitGraphN) -> Double { @_common.min(s.data) }

pub fn net_sec_rate_limit_graphn_max(s : NetsecratelimitGraphN) -> Double { @_common.max(s.data) }

pub fn net_sec_rate_limit_graphn_to_string(s : NetsecratelimitGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecratelimitNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_rate_limit_node_make(size : Int) -> NetsecratelimitNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_rate_limit_node_len(s : NetsecratelimitNode) -> Int { s.size }

pub fn net_sec_rate_limit_node_get(s : NetsecratelimitNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_rate_limit_node_set(s : NetsecratelimitNode, i : Int, v : Double) -> NetsecratelimitNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_node_sum(s : NetsecratelimitNode) -> Double { @_common.sum(s.data) }

pub fn net_sec_rate_limit_node_mean(s : NetsecratelimitNode) -> Double { @_common.mean(s.data) }

pub fn net_sec_rate_limit_node_scale(s : NetsecratelimitNode, f : Double) -> NetsecratelimitNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_node_add(a : NetsecratelimitNode, b : NetsecratelimitNode) -> NetsecratelimitNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_rate_limit_node_copy(s : NetsecratelimitNode) -> NetsecratelimitNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_node_fill(s : NetsecratelimitNode, v : Double) -> NetsecratelimitNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_node_min(s : NetsecratelimitNode) -> Double { @_common.min(s.data) }

pub fn net_sec_rate_limit_node_max(s : NetsecratelimitNode) -> Double { @_common.max(s.data) }

pub fn net_sec_rate_limit_node_to_string(s : NetsecratelimitNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecratelimitEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_rate_limit_edge_make(size : Int) -> NetsecratelimitEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_rate_limit_edge_len(s : NetsecratelimitEdge) -> Int { s.size }

pub fn net_sec_rate_limit_edge_get(s : NetsecratelimitEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_rate_limit_edge_set(s : NetsecratelimitEdge, i : Int, v : Double) -> NetsecratelimitEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_edge_sum(s : NetsecratelimitEdge) -> Double { @_common.sum(s.data) }

pub fn net_sec_rate_limit_edge_mean(s : NetsecratelimitEdge) -> Double { @_common.mean(s.data) }

pub fn net_sec_rate_limit_edge_scale(s : NetsecratelimitEdge, f : Double) -> NetsecratelimitEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_edge_add(a : NetsecratelimitEdge, b : NetsecratelimitEdge) -> NetsecratelimitEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_rate_limit_edge_copy(s : NetsecratelimitEdge) -> NetsecratelimitEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_edge_fill(s : NetsecratelimitEdge, v : Double) -> NetsecratelimitEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_edge_min(s : NetsecratelimitEdge) -> Double { @_common.min(s.data) }

pub fn net_sec_rate_limit_edge_max(s : NetsecratelimitEdge) -> Double { @_common.max(s.data) }

pub fn net_sec_rate_limit_edge_to_string(s : NetsecratelimitEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecratelimitPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_rate_limit_path_make(size : Int) -> NetsecratelimitPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_rate_limit_path_len(s : NetsecratelimitPath) -> Int { s.size }

pub fn net_sec_rate_limit_path_get(s : NetsecratelimitPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_rate_limit_path_set(s : NetsecratelimitPath, i : Int, v : Double) -> NetsecratelimitPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_path_sum(s : NetsecratelimitPath) -> Double { @_common.sum(s.data) }

pub fn net_sec_rate_limit_path_mean(s : NetsecratelimitPath) -> Double { @_common.mean(s.data) }

pub fn net_sec_rate_limit_path_scale(s : NetsecratelimitPath, f : Double) -> NetsecratelimitPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_path_add(a : NetsecratelimitPath, b : NetsecratelimitPath) -> NetsecratelimitPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_rate_limit_path_copy(s : NetsecratelimitPath) -> NetsecratelimitPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_path_fill(s : NetsecratelimitPath, v : Double) -> NetsecratelimitPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_path_min(s : NetsecratelimitPath) -> Double { @_common.min(s.data) }

pub fn net_sec_rate_limit_path_max(s : NetsecratelimitPath) -> Double { @_common.max(s.data) }

pub fn net_sec_rate_limit_path_to_string(s : NetsecratelimitPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecratelimitCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_rate_limit_cluster_make(size : Int) -> NetsecratelimitCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_rate_limit_cluster_len(s : NetsecratelimitCluster) -> Int { s.size }

pub fn net_sec_rate_limit_cluster_get(s : NetsecratelimitCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_rate_limit_cluster_set(s : NetsecratelimitCluster, i : Int, v : Double) -> NetsecratelimitCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_cluster_sum(s : NetsecratelimitCluster) -> Double { @_common.sum(s.data) }

pub fn net_sec_rate_limit_cluster_mean(s : NetsecratelimitCluster) -> Double { @_common.mean(s.data) }

pub fn net_sec_rate_limit_cluster_scale(s : NetsecratelimitCluster, f : Double) -> NetsecratelimitCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_cluster_add(a : NetsecratelimitCluster, b : NetsecratelimitCluster) -> NetsecratelimitCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_rate_limit_cluster_copy(s : NetsecratelimitCluster) -> NetsecratelimitCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_cluster_fill(s : NetsecratelimitCluster, v : Double) -> NetsecratelimitCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_cluster_min(s : NetsecratelimitCluster) -> Double { @_common.min(s.data) }

pub fn net_sec_rate_limit_cluster_max(s : NetsecratelimitCluster) -> Double { @_common.max(s.data) }

pub fn net_sec_rate_limit_cluster_to_string(s : NetsecratelimitCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecratelimitModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_rate_limit_model_make(size : Int) -> NetsecratelimitModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_rate_limit_model_len(s : NetsecratelimitModel) -> Int { s.size }

pub fn net_sec_rate_limit_model_get(s : NetsecratelimitModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_rate_limit_model_set(s : NetsecratelimitModel, i : Int, v : Double) -> NetsecratelimitModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_model_sum(s : NetsecratelimitModel) -> Double { @_common.sum(s.data) }

pub fn net_sec_rate_limit_model_mean(s : NetsecratelimitModel) -> Double { @_common.mean(s.data) }

pub fn net_sec_rate_limit_model_scale(s : NetsecratelimitModel, f : Double) -> NetsecratelimitModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_model_add(a : NetsecratelimitModel, b : NetsecratelimitModel) -> NetsecratelimitModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_rate_limit_model_copy(s : NetsecratelimitModel) -> NetsecratelimitModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_model_fill(s : NetsecratelimitModel, v : Double) -> NetsecratelimitModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_model_min(s : NetsecratelimitModel) -> Double { @_common.min(s.data) }

pub fn net_sec_rate_limit_model_max(s : NetsecratelimitModel) -> Double { @_common.max(s.data) }

pub fn net_sec_rate_limit_model_to_string(s : NetsecratelimitModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecratelimitLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_rate_limit_layer_make(size : Int) -> NetsecratelimitLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_rate_limit_layer_len(s : NetsecratelimitLayer) -> Int { s.size }

pub fn net_sec_rate_limit_layer_get(s : NetsecratelimitLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_rate_limit_layer_set(s : NetsecratelimitLayer, i : Int, v : Double) -> NetsecratelimitLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_layer_sum(s : NetsecratelimitLayer) -> Double { @_common.sum(s.data) }

pub fn net_sec_rate_limit_layer_mean(s : NetsecratelimitLayer) -> Double { @_common.mean(s.data) }

pub fn net_sec_rate_limit_layer_scale(s : NetsecratelimitLayer, f : Double) -> NetsecratelimitLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_layer_add(a : NetsecratelimitLayer, b : NetsecratelimitLayer) -> NetsecratelimitLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_rate_limit_layer_copy(s : NetsecratelimitLayer) -> NetsecratelimitLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_layer_fill(s : NetsecratelimitLayer, v : Double) -> NetsecratelimitLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_layer_min(s : NetsecratelimitLayer) -> Double { @_common.min(s.data) }

pub fn net_sec_rate_limit_layer_max(s : NetsecratelimitLayer) -> Double { @_common.max(s.data) }

pub fn net_sec_rate_limit_layer_to_string(s : NetsecratelimitLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecratelimitBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_rate_limit_buffer_make(size : Int) -> NetsecratelimitBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_rate_limit_buffer_len(s : NetsecratelimitBuffer) -> Int { s.size }

pub fn net_sec_rate_limit_buffer_get(s : NetsecratelimitBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_rate_limit_buffer_set(s : NetsecratelimitBuffer, i : Int, v : Double) -> NetsecratelimitBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_buffer_sum(s : NetsecratelimitBuffer) -> Double { @_common.sum(s.data) }

pub fn net_sec_rate_limit_buffer_mean(s : NetsecratelimitBuffer) -> Double { @_common.mean(s.data) }

pub fn net_sec_rate_limit_buffer_scale(s : NetsecratelimitBuffer, f : Double) -> NetsecratelimitBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_buffer_add(a : NetsecratelimitBuffer, b : NetsecratelimitBuffer) -> NetsecratelimitBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_rate_limit_buffer_copy(s : NetsecratelimitBuffer) -> NetsecratelimitBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_buffer_fill(s : NetsecratelimitBuffer, v : Double) -> NetsecratelimitBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_buffer_min(s : NetsecratelimitBuffer) -> Double { @_common.min(s.data) }

pub fn net_sec_rate_limit_buffer_max(s : NetsecratelimitBuffer) -> Double { @_common.max(s.data) }

pub fn net_sec_rate_limit_buffer_to_string(s : NetsecratelimitBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecratelimitCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_rate_limit_cursor_make(size : Int) -> NetsecratelimitCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_rate_limit_cursor_len(s : NetsecratelimitCursor) -> Int { s.size }

pub fn net_sec_rate_limit_cursor_get(s : NetsecratelimitCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_rate_limit_cursor_set(s : NetsecratelimitCursor, i : Int, v : Double) -> NetsecratelimitCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_cursor_sum(s : NetsecratelimitCursor) -> Double { @_common.sum(s.data) }

pub fn net_sec_rate_limit_cursor_mean(s : NetsecratelimitCursor) -> Double { @_common.mean(s.data) }

pub fn net_sec_rate_limit_cursor_scale(s : NetsecratelimitCursor, f : Double) -> NetsecratelimitCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_cursor_add(a : NetsecratelimitCursor, b : NetsecratelimitCursor) -> NetsecratelimitCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_rate_limit_cursor_copy(s : NetsecratelimitCursor) -> NetsecratelimitCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_cursor_fill(s : NetsecratelimitCursor, v : Double) -> NetsecratelimitCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_cursor_min(s : NetsecratelimitCursor) -> Double { @_common.min(s.data) }

pub fn net_sec_rate_limit_cursor_max(s : NetsecratelimitCursor) -> Double { @_common.max(s.data) }

pub fn net_sec_rate_limit_cursor_to_string(s : NetsecratelimitCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecratelimitView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_rate_limit_view_make(size : Int) -> NetsecratelimitView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_rate_limit_view_len(s : NetsecratelimitView) -> Int { s.size }

pub fn net_sec_rate_limit_view_get(s : NetsecratelimitView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_rate_limit_view_set(s : NetsecratelimitView, i : Int, v : Double) -> NetsecratelimitView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_view_sum(s : NetsecratelimitView) -> Double { @_common.sum(s.data) }

pub fn net_sec_rate_limit_view_mean(s : NetsecratelimitView) -> Double { @_common.mean(s.data) }

pub fn net_sec_rate_limit_view_scale(s : NetsecratelimitView, f : Double) -> NetsecratelimitView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_view_add(a : NetsecratelimitView, b : NetsecratelimitView) -> NetsecratelimitView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_rate_limit_view_copy(s : NetsecratelimitView) -> NetsecratelimitView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_view_fill(s : NetsecratelimitView, v : Double) -> NetsecratelimitView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_view_min(s : NetsecratelimitView) -> Double { @_common.min(s.data) }

pub fn net_sec_rate_limit_view_max(s : NetsecratelimitView) -> Double { @_common.max(s.data) }

pub fn net_sec_rate_limit_view_to_string(s : NetsecratelimitView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecratelimitRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_rate_limit_range_make(size : Int) -> NetsecratelimitRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_rate_limit_range_len(s : NetsecratelimitRange) -> Int { s.size }

pub fn net_sec_rate_limit_range_get(s : NetsecratelimitRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_rate_limit_range_set(s : NetsecratelimitRange, i : Int, v : Double) -> NetsecratelimitRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_range_sum(s : NetsecratelimitRange) -> Double { @_common.sum(s.data) }

pub fn net_sec_rate_limit_range_mean(s : NetsecratelimitRange) -> Double { @_common.mean(s.data) }

pub fn net_sec_rate_limit_range_scale(s : NetsecratelimitRange, f : Double) -> NetsecratelimitRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_range_add(a : NetsecratelimitRange, b : NetsecratelimitRange) -> NetsecratelimitRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_rate_limit_range_copy(s : NetsecratelimitRange) -> NetsecratelimitRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_range_fill(s : NetsecratelimitRange, v : Double) -> NetsecratelimitRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_range_min(s : NetsecratelimitRange) -> Double { @_common.min(s.data) }

pub fn net_sec_rate_limit_range_max(s : NetsecratelimitRange) -> Double { @_common.max(s.data) }

pub fn net_sec_rate_limit_range_to_string(s : NetsecratelimitRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecratelimitSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_rate_limit_slice_make(size : Int) -> NetsecratelimitSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_rate_limit_slice_len(s : NetsecratelimitSlice) -> Int { s.size }

pub fn net_sec_rate_limit_slice_get(s : NetsecratelimitSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_rate_limit_slice_set(s : NetsecratelimitSlice, i : Int, v : Double) -> NetsecratelimitSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_slice_sum(s : NetsecratelimitSlice) -> Double { @_common.sum(s.data) }

pub fn net_sec_rate_limit_slice_mean(s : NetsecratelimitSlice) -> Double { @_common.mean(s.data) }

pub fn net_sec_rate_limit_slice_scale(s : NetsecratelimitSlice, f : Double) -> NetsecratelimitSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_slice_add(a : NetsecratelimitSlice, b : NetsecratelimitSlice) -> NetsecratelimitSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_rate_limit_slice_copy(s : NetsecratelimitSlice) -> NetsecratelimitSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_slice_fill(s : NetsecratelimitSlice, v : Double) -> NetsecratelimitSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_rate_limit_slice_min(s : NetsecratelimitSlice) -> Double { @_common.min(s.data) }

pub fn net_sec_rate_limit_slice_max(s : NetsecratelimitSlice) -> Double { @_common.max(s.data) }

pub fn net_sec_rate_limit_slice_to_string(s : NetsecratelimitSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

