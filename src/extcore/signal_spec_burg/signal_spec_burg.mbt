///===
/// extcore/signal_spec_burg

pub(all) struct SignalspecburgPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_spec_burg_make_point(x : Double, y : Double) -> SignalspecburgPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_spec_burg_make_point3(x : Double, y : Double, z : Double) -> SignalspecburgPoint {
  { x, y, z, label: 0 }
}

pub fn SignalspecburgPoint::x(self : SignalspecburgPoint) -> Double { self.x }

pub fn SignalspecburgPoint::y(self : SignalspecburgPoint) -> Double { self.y }

pub fn SignalspecburgPoint::z(self : SignalspecburgPoint) -> Double { self.z }

pub fn SignalspecburgPoint::label(self : SignalspecburgPoint) -> Int { self.label }

pub fn SignalspecburgPoint::dist(self : SignalspecburgPoint, other : SignalspecburgPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignalspecburgPoint::add(self : SignalspecburgPoint, other : SignalspecburgPoint) -> SignalspecburgPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignalspecburgPoint::sub(self : SignalspecburgPoint, other : SignalspecburgPoint) -> SignalspecburgPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignalspecburgPoint::scale(self : SignalspecburgPoint, s : Double) -> SignalspecburgPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignalspecburgPoint::dot(self : SignalspecburgPoint, other : SignalspecburgPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignalspecburgPoint::cross(self : SignalspecburgPoint, other : SignalspecburgPoint) -> SignalspecburgPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignalspecburgPoint::norm(self : SignalspecburgPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignalspecburgPoint::normalize(self : SignalspecburgPoint) -> SignalspecburgPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalspecburgPoint::negate(self : SignalspecburgPoint) -> SignalspecburgPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignalspecburgPoint::mid(self : SignalspecburgPoint, other : SignalspecburgPoint) -> SignalspecburgPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignalspecburgPoint::lerp(self : SignalspecburgPoint, other : SignalspecburgPoint, t : Double) -> SignalspecburgPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignalspecburgPoint::to_string(self : SignalspecburgPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignalspecburgSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_spec_burg_make_series(vals : Array[Double], name : String) -> SignalspecburgSeries {
  { vals, name, meta: 0 }
}

pub fn SignalspecburgSeries::len(self : SignalspecburgSeries) -> Int { self.vals.length() }

pub fn SignalspecburgSeries::sum(self : SignalspecburgSeries) -> Double { @_common.sum(self.vals) }

pub fn SignalspecburgSeries::mean(self : SignalspecburgSeries) -> Double { @_common.mean(self.vals) }

pub fn SignalspecburgSeries::min(self : SignalspecburgSeries) -> Double { @_common.min(self.vals) }

pub fn SignalspecburgSeries::max(self : SignalspecburgSeries) -> Double { @_common.max(self.vals) }

pub fn SignalspecburgSeries::range(self : SignalspecburgSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignalspecburgSeries::variance(self : SignalspecburgSeries) -> Double { @_common.variance(self.vals) }

pub fn SignalspecburgSeries::std(self : SignalspecburgSeries) -> Double { @_common.std(self.vals) }

pub fn SignalspecburgSeries::median(self : SignalspecburgSeries) -> Double { @_common.median(self.vals) }

pub fn SignalspecburgSeries::scale(self : SignalspecburgSeries, f : Double) -> SignalspecburgSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignalspecburgSeries::add(self : SignalspecburgSeries, other : SignalspecburgSeries) -> SignalspecburgSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignalspecburgSeries::sub(self : SignalspecburgSeries, other : SignalspecburgSeries) -> SignalspecburgSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignalspecburgSeries::normalize(self : SignalspecburgSeries) -> SignalspecburgSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignalspecburgSeries::cumsum(self : SignalspecburgSeries) -> SignalspecburgSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignalspecburgSeries::to_string(self : SignalspecburgSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalspecburgMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_spec_burg_make_matrix(rows : Int, cols : Int, val : Double) -> SignalspecburgMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_spec_burg_matrix_identity(n : Int) -> SignalspecburgMatrix {
  let m = signal_spec_burg_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignalspecburgMatrix::get(self : SignalspecburgMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignalspecburgMatrix::transpose(self : SignalspecburgMatrix) -> SignalspecburgMatrix {
  let result = signal_spec_burg_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignalspecburgMatrix::add(self : SignalspecburgMatrix, other : SignalspecburgMatrix) -> SignalspecburgMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_spec_burg_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignalspecburgMatrix::scale(self : SignalspecburgMatrix, s : Double) -> SignalspecburgMatrix {
  let result = signal_spec_burg_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignalspecburgMatrix::multiply(self : SignalspecburgMatrix, other : SignalspecburgMatrix) -> SignalspecburgMatrix {
  if self.cols != other.rows { return signal_spec_burg_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_spec_burg_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SignalspecburgMatrix::trace(self : SignalspecburgMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignalspecburgMatrix::det(self : SignalspecburgMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignalspecburgMatrix::norm(self : SignalspecburgMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignalspecburgMatrix::to_string(self : SignalspecburgMatrix) -> String {
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

pub(all) struct SignalspecburgVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_spec_burg_make_vector(comps : Array[Double]) -> SignalspecburgVector {
  { comps, dim: comps.length() }
}

pub fn signal_spec_burg_vector_zero(dim : Int) -> SignalspecburgVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignalspecburgVector::add(self : SignalspecburgVector, other : SignalspecburgVector) -> SignalspecburgVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignalspecburgVector::sub(self : SignalspecburgVector, other : SignalspecburgVector) -> SignalspecburgVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignalspecburgVector::scale(self : SignalspecburgVector, s : Double) -> SignalspecburgVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignalspecburgVector::dot(self : SignalspecburgVector, other : SignalspecburgVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignalspecburgVector::norm(self : SignalspecburgVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignalspecburgVector::normalize(self : SignalspecburgVector) -> SignalspecburgVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalspecburgVector::dist(self : SignalspecburgVector, other : SignalspecburgVector) -> Double {
  self.sub(other).norm()
}

pub fn SignalspecburgVector::to_string(self : SignalspecburgVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_spec_burg_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_spec_burg_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_spec_burg_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_spec_burg_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_spec_burg_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_spec_burg_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_spec_burg_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_spec_burg_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_spec_burg_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_spec_burg_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_spec_burg_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_spec_burg_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_spec_burg_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_spec_burg_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_spec_burg_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_spec_burg_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_spec_burg_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_spec_burg_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_spec_burg_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_spec_burg_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_spec_burg_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_spec_burg_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_spec_burg_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_spec_burg_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_spec_burg_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_spec_burg_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_spec_burg_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_spec_burg_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_spec_burg_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignalspecburgFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_burg_frame_make(size : Int) -> SignalspecburgFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_burg_frame_len(s : SignalspecburgFrame) -> Int { s.size }

pub fn signal_spec_burg_frame_get(s : SignalspecburgFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_burg_frame_set(s : SignalspecburgFrame, i : Int, v : Double) -> SignalspecburgFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_frame_sum(s : SignalspecburgFrame) -> Double { @_common.sum(s.data) }

pub fn signal_spec_burg_frame_mean(s : SignalspecburgFrame) -> Double { @_common.mean(s.data) }

pub fn signal_spec_burg_frame_scale(s : SignalspecburgFrame, f : Double) -> SignalspecburgFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_frame_add(a : SignalspecburgFrame, b : SignalspecburgFrame) -> SignalspecburgFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_burg_frame_copy(s : SignalspecburgFrame) -> SignalspecburgFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_frame_fill(s : SignalspecburgFrame, v : Double) -> SignalspecburgFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_frame_min(s : SignalspecburgFrame) -> Double { @_common.min(s.data) }

pub fn signal_spec_burg_frame_max(s : SignalspecburgFrame) -> Double { @_common.max(s.data) }

pub fn signal_spec_burg_frame_to_string(s : SignalspecburgFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecburgTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_burg_table_make(size : Int) -> SignalspecburgTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_burg_table_len(s : SignalspecburgTable) -> Int { s.size }

pub fn signal_spec_burg_table_get(s : SignalspecburgTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_burg_table_set(s : SignalspecburgTable, i : Int, v : Double) -> SignalspecburgTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_table_sum(s : SignalspecburgTable) -> Double { @_common.sum(s.data) }

pub fn signal_spec_burg_table_mean(s : SignalspecburgTable) -> Double { @_common.mean(s.data) }

pub fn signal_spec_burg_table_scale(s : SignalspecburgTable, f : Double) -> SignalspecburgTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_table_add(a : SignalspecburgTable, b : SignalspecburgTable) -> SignalspecburgTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_burg_table_copy(s : SignalspecburgTable) -> SignalspecburgTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_table_fill(s : SignalspecburgTable, v : Double) -> SignalspecburgTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_table_min(s : SignalspecburgTable) -> Double { @_common.min(s.data) }

pub fn signal_spec_burg_table_max(s : SignalspecburgTable) -> Double { @_common.max(s.data) }

pub fn signal_spec_burg_table_to_string(s : SignalspecburgTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecburgGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_burg_graphn_make(size : Int) -> SignalspecburgGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_burg_graphn_len(s : SignalspecburgGraphN) -> Int { s.size }

pub fn signal_spec_burg_graphn_get(s : SignalspecburgGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_burg_graphn_set(s : SignalspecburgGraphN, i : Int, v : Double) -> SignalspecburgGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_graphn_sum(s : SignalspecburgGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_spec_burg_graphn_mean(s : SignalspecburgGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_spec_burg_graphn_scale(s : SignalspecburgGraphN, f : Double) -> SignalspecburgGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_graphn_add(a : SignalspecburgGraphN, b : SignalspecburgGraphN) -> SignalspecburgGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_burg_graphn_copy(s : SignalspecburgGraphN) -> SignalspecburgGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_graphn_fill(s : SignalspecburgGraphN, v : Double) -> SignalspecburgGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_graphn_min(s : SignalspecburgGraphN) -> Double { @_common.min(s.data) }

pub fn signal_spec_burg_graphn_max(s : SignalspecburgGraphN) -> Double { @_common.max(s.data) }

pub fn signal_spec_burg_graphn_to_string(s : SignalspecburgGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecburgNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_burg_node_make(size : Int) -> SignalspecburgNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_burg_node_len(s : SignalspecburgNode) -> Int { s.size }

pub fn signal_spec_burg_node_get(s : SignalspecburgNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_burg_node_set(s : SignalspecburgNode, i : Int, v : Double) -> SignalspecburgNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_node_sum(s : SignalspecburgNode) -> Double { @_common.sum(s.data) }

pub fn signal_spec_burg_node_mean(s : SignalspecburgNode) -> Double { @_common.mean(s.data) }

pub fn signal_spec_burg_node_scale(s : SignalspecburgNode, f : Double) -> SignalspecburgNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_node_add(a : SignalspecburgNode, b : SignalspecburgNode) -> SignalspecburgNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_burg_node_copy(s : SignalspecburgNode) -> SignalspecburgNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_node_fill(s : SignalspecburgNode, v : Double) -> SignalspecburgNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_node_min(s : SignalspecburgNode) -> Double { @_common.min(s.data) }

pub fn signal_spec_burg_node_max(s : SignalspecburgNode) -> Double { @_common.max(s.data) }

pub fn signal_spec_burg_node_to_string(s : SignalspecburgNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecburgEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_burg_edge_make(size : Int) -> SignalspecburgEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_burg_edge_len(s : SignalspecburgEdge) -> Int { s.size }

pub fn signal_spec_burg_edge_get(s : SignalspecburgEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_burg_edge_set(s : SignalspecburgEdge, i : Int, v : Double) -> SignalspecburgEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_edge_sum(s : SignalspecburgEdge) -> Double { @_common.sum(s.data) }

pub fn signal_spec_burg_edge_mean(s : SignalspecburgEdge) -> Double { @_common.mean(s.data) }

pub fn signal_spec_burg_edge_scale(s : SignalspecburgEdge, f : Double) -> SignalspecburgEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_edge_add(a : SignalspecburgEdge, b : SignalspecburgEdge) -> SignalspecburgEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_burg_edge_copy(s : SignalspecburgEdge) -> SignalspecburgEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_edge_fill(s : SignalspecburgEdge, v : Double) -> SignalspecburgEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_edge_min(s : SignalspecburgEdge) -> Double { @_common.min(s.data) }

pub fn signal_spec_burg_edge_max(s : SignalspecburgEdge) -> Double { @_common.max(s.data) }

pub fn signal_spec_burg_edge_to_string(s : SignalspecburgEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecburgPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_burg_path_make(size : Int) -> SignalspecburgPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_burg_path_len(s : SignalspecburgPath) -> Int { s.size }

pub fn signal_spec_burg_path_get(s : SignalspecburgPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_burg_path_set(s : SignalspecburgPath, i : Int, v : Double) -> SignalspecburgPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_path_sum(s : SignalspecburgPath) -> Double { @_common.sum(s.data) }

pub fn signal_spec_burg_path_mean(s : SignalspecburgPath) -> Double { @_common.mean(s.data) }

pub fn signal_spec_burg_path_scale(s : SignalspecburgPath, f : Double) -> SignalspecburgPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_path_add(a : SignalspecburgPath, b : SignalspecburgPath) -> SignalspecburgPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_burg_path_copy(s : SignalspecburgPath) -> SignalspecburgPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_path_fill(s : SignalspecburgPath, v : Double) -> SignalspecburgPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_path_min(s : SignalspecburgPath) -> Double { @_common.min(s.data) }

pub fn signal_spec_burg_path_max(s : SignalspecburgPath) -> Double { @_common.max(s.data) }

pub fn signal_spec_burg_path_to_string(s : SignalspecburgPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecburgCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_burg_cluster_make(size : Int) -> SignalspecburgCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_burg_cluster_len(s : SignalspecburgCluster) -> Int { s.size }

pub fn signal_spec_burg_cluster_get(s : SignalspecburgCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_burg_cluster_set(s : SignalspecburgCluster, i : Int, v : Double) -> SignalspecburgCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_cluster_sum(s : SignalspecburgCluster) -> Double { @_common.sum(s.data) }

pub fn signal_spec_burg_cluster_mean(s : SignalspecburgCluster) -> Double { @_common.mean(s.data) }

pub fn signal_spec_burg_cluster_scale(s : SignalspecburgCluster, f : Double) -> SignalspecburgCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_cluster_add(a : SignalspecburgCluster, b : SignalspecburgCluster) -> SignalspecburgCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_burg_cluster_copy(s : SignalspecburgCluster) -> SignalspecburgCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_cluster_fill(s : SignalspecburgCluster, v : Double) -> SignalspecburgCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_cluster_min(s : SignalspecburgCluster) -> Double { @_common.min(s.data) }

pub fn signal_spec_burg_cluster_max(s : SignalspecburgCluster) -> Double { @_common.max(s.data) }

pub fn signal_spec_burg_cluster_to_string(s : SignalspecburgCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecburgModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_burg_model_make(size : Int) -> SignalspecburgModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_burg_model_len(s : SignalspecburgModel) -> Int { s.size }

pub fn signal_spec_burg_model_get(s : SignalspecburgModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_burg_model_set(s : SignalspecburgModel, i : Int, v : Double) -> SignalspecburgModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_model_sum(s : SignalspecburgModel) -> Double { @_common.sum(s.data) }

pub fn signal_spec_burg_model_mean(s : SignalspecburgModel) -> Double { @_common.mean(s.data) }

pub fn signal_spec_burg_model_scale(s : SignalspecburgModel, f : Double) -> SignalspecburgModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_model_add(a : SignalspecburgModel, b : SignalspecburgModel) -> SignalspecburgModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_burg_model_copy(s : SignalspecburgModel) -> SignalspecburgModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_model_fill(s : SignalspecburgModel, v : Double) -> SignalspecburgModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_model_min(s : SignalspecburgModel) -> Double { @_common.min(s.data) }

pub fn signal_spec_burg_model_max(s : SignalspecburgModel) -> Double { @_common.max(s.data) }

pub fn signal_spec_burg_model_to_string(s : SignalspecburgModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecburgLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_burg_layer_make(size : Int) -> SignalspecburgLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_burg_layer_len(s : SignalspecburgLayer) -> Int { s.size }

pub fn signal_spec_burg_layer_get(s : SignalspecburgLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_burg_layer_set(s : SignalspecburgLayer, i : Int, v : Double) -> SignalspecburgLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_layer_sum(s : SignalspecburgLayer) -> Double { @_common.sum(s.data) }

pub fn signal_spec_burg_layer_mean(s : SignalspecburgLayer) -> Double { @_common.mean(s.data) }

pub fn signal_spec_burg_layer_scale(s : SignalspecburgLayer, f : Double) -> SignalspecburgLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_layer_add(a : SignalspecburgLayer, b : SignalspecburgLayer) -> SignalspecburgLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_burg_layer_copy(s : SignalspecburgLayer) -> SignalspecburgLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_layer_fill(s : SignalspecburgLayer, v : Double) -> SignalspecburgLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_layer_min(s : SignalspecburgLayer) -> Double { @_common.min(s.data) }

pub fn signal_spec_burg_layer_max(s : SignalspecburgLayer) -> Double { @_common.max(s.data) }

pub fn signal_spec_burg_layer_to_string(s : SignalspecburgLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecburgBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_burg_buffer_make(size : Int) -> SignalspecburgBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_burg_buffer_len(s : SignalspecburgBuffer) -> Int { s.size }

pub fn signal_spec_burg_buffer_get(s : SignalspecburgBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_burg_buffer_set(s : SignalspecburgBuffer, i : Int, v : Double) -> SignalspecburgBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_buffer_sum(s : SignalspecburgBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_spec_burg_buffer_mean(s : SignalspecburgBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_spec_burg_buffer_scale(s : SignalspecburgBuffer, f : Double) -> SignalspecburgBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_buffer_add(a : SignalspecburgBuffer, b : SignalspecburgBuffer) -> SignalspecburgBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_burg_buffer_copy(s : SignalspecburgBuffer) -> SignalspecburgBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_buffer_fill(s : SignalspecburgBuffer, v : Double) -> SignalspecburgBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_buffer_min(s : SignalspecburgBuffer) -> Double { @_common.min(s.data) }

pub fn signal_spec_burg_buffer_max(s : SignalspecburgBuffer) -> Double { @_common.max(s.data) }

pub fn signal_spec_burg_buffer_to_string(s : SignalspecburgBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecburgCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_burg_cursor_make(size : Int) -> SignalspecburgCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_burg_cursor_len(s : SignalspecburgCursor) -> Int { s.size }

pub fn signal_spec_burg_cursor_get(s : SignalspecburgCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_burg_cursor_set(s : SignalspecburgCursor, i : Int, v : Double) -> SignalspecburgCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_cursor_sum(s : SignalspecburgCursor) -> Double { @_common.sum(s.data) }

pub fn signal_spec_burg_cursor_mean(s : SignalspecburgCursor) -> Double { @_common.mean(s.data) }

pub fn signal_spec_burg_cursor_scale(s : SignalspecburgCursor, f : Double) -> SignalspecburgCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_cursor_add(a : SignalspecburgCursor, b : SignalspecburgCursor) -> SignalspecburgCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_burg_cursor_copy(s : SignalspecburgCursor) -> SignalspecburgCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_cursor_fill(s : SignalspecburgCursor, v : Double) -> SignalspecburgCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_cursor_min(s : SignalspecburgCursor) -> Double { @_common.min(s.data) }

pub fn signal_spec_burg_cursor_max(s : SignalspecburgCursor) -> Double { @_common.max(s.data) }

pub fn signal_spec_burg_cursor_to_string(s : SignalspecburgCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecburgView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_burg_view_make(size : Int) -> SignalspecburgView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_burg_view_len(s : SignalspecburgView) -> Int { s.size }

pub fn signal_spec_burg_view_get(s : SignalspecburgView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_burg_view_set(s : SignalspecburgView, i : Int, v : Double) -> SignalspecburgView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_view_sum(s : SignalspecburgView) -> Double { @_common.sum(s.data) }

pub fn signal_spec_burg_view_mean(s : SignalspecburgView) -> Double { @_common.mean(s.data) }

pub fn signal_spec_burg_view_scale(s : SignalspecburgView, f : Double) -> SignalspecburgView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_view_add(a : SignalspecburgView, b : SignalspecburgView) -> SignalspecburgView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_burg_view_copy(s : SignalspecburgView) -> SignalspecburgView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_view_fill(s : SignalspecburgView, v : Double) -> SignalspecburgView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_view_min(s : SignalspecburgView) -> Double { @_common.min(s.data) }

pub fn signal_spec_burg_view_max(s : SignalspecburgView) -> Double { @_common.max(s.data) }

pub fn signal_spec_burg_view_to_string(s : SignalspecburgView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecburgRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_burg_range_make(size : Int) -> SignalspecburgRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_burg_range_len(s : SignalspecburgRange) -> Int { s.size }

pub fn signal_spec_burg_range_get(s : SignalspecburgRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_burg_range_set(s : SignalspecburgRange, i : Int, v : Double) -> SignalspecburgRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_range_sum(s : SignalspecburgRange) -> Double { @_common.sum(s.data) }

pub fn signal_spec_burg_range_mean(s : SignalspecburgRange) -> Double { @_common.mean(s.data) }

pub fn signal_spec_burg_range_scale(s : SignalspecburgRange, f : Double) -> SignalspecburgRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_range_add(a : SignalspecburgRange, b : SignalspecburgRange) -> SignalspecburgRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_burg_range_copy(s : SignalspecburgRange) -> SignalspecburgRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_range_fill(s : SignalspecburgRange, v : Double) -> SignalspecburgRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_range_min(s : SignalspecburgRange) -> Double { @_common.min(s.data) }

pub fn signal_spec_burg_range_max(s : SignalspecburgRange) -> Double { @_common.max(s.data) }

pub fn signal_spec_burg_range_to_string(s : SignalspecburgRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecburgSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_burg_slice_make(size : Int) -> SignalspecburgSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_burg_slice_len(s : SignalspecburgSlice) -> Int { s.size }

pub fn signal_spec_burg_slice_get(s : SignalspecburgSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_burg_slice_set(s : SignalspecburgSlice, i : Int, v : Double) -> SignalspecburgSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_slice_sum(s : SignalspecburgSlice) -> Double { @_common.sum(s.data) }

pub fn signal_spec_burg_slice_mean(s : SignalspecburgSlice) -> Double { @_common.mean(s.data) }

pub fn signal_spec_burg_slice_scale(s : SignalspecburgSlice, f : Double) -> SignalspecburgSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_slice_add(a : SignalspecburgSlice, b : SignalspecburgSlice) -> SignalspecburgSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_burg_slice_copy(s : SignalspecburgSlice) -> SignalspecburgSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_slice_fill(s : SignalspecburgSlice, v : Double) -> SignalspecburgSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_slice_min(s : SignalspecburgSlice) -> Double { @_common.min(s.data) }

pub fn signal_spec_burg_slice_max(s : SignalspecburgSlice) -> Double { @_common.max(s.data) }

pub fn signal_spec_burg_slice_to_string(s : SignalspecburgSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

