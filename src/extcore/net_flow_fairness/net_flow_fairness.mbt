///===
/// extcore/net_flow_fairness

pub(all) struct NetflowfairnessPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_flow_fairness_make_point(x : Double, y : Double) -> NetflowfairnessPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_flow_fairness_make_point3(x : Double, y : Double, z : Double) -> NetflowfairnessPoint {
  { x, y, z, label: 0 }
}

pub fn NetflowfairnessPoint::x(self : NetflowfairnessPoint) -> Double { self.x }

pub fn NetflowfairnessPoint::y(self : NetflowfairnessPoint) -> Double { self.y }

pub fn NetflowfairnessPoint::z(self : NetflowfairnessPoint) -> Double { self.z }

pub fn NetflowfairnessPoint::label(self : NetflowfairnessPoint) -> Int { self.label }

pub fn NetflowfairnessPoint::dist(self : NetflowfairnessPoint, other : NetflowfairnessPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetflowfairnessPoint::add(self : NetflowfairnessPoint, other : NetflowfairnessPoint) -> NetflowfairnessPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetflowfairnessPoint::sub(self : NetflowfairnessPoint, other : NetflowfairnessPoint) -> NetflowfairnessPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetflowfairnessPoint::scale(self : NetflowfairnessPoint, s : Double) -> NetflowfairnessPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetflowfairnessPoint::dot(self : NetflowfairnessPoint, other : NetflowfairnessPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetflowfairnessPoint::cross(self : NetflowfairnessPoint, other : NetflowfairnessPoint) -> NetflowfairnessPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetflowfairnessPoint::norm(self : NetflowfairnessPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetflowfairnessPoint::normalize(self : NetflowfairnessPoint) -> NetflowfairnessPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetflowfairnessPoint::negate(self : NetflowfairnessPoint) -> NetflowfairnessPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetflowfairnessPoint::mid(self : NetflowfairnessPoint, other : NetflowfairnessPoint) -> NetflowfairnessPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetflowfairnessPoint::lerp(self : NetflowfairnessPoint, other : NetflowfairnessPoint, t : Double) -> NetflowfairnessPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetflowfairnessPoint::to_string(self : NetflowfairnessPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetflowfairnessSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_flow_fairness_make_series(vals : Array[Double], name : String) -> NetflowfairnessSeries {
  { vals, name, meta: 0 }
}

pub fn NetflowfairnessSeries::len(self : NetflowfairnessSeries) -> Int { self.vals.length() }

pub fn NetflowfairnessSeries::sum(self : NetflowfairnessSeries) -> Double { @_common.sum(self.vals) }

pub fn NetflowfairnessSeries::mean(self : NetflowfairnessSeries) -> Double { @_common.mean(self.vals) }

pub fn NetflowfairnessSeries::min(self : NetflowfairnessSeries) -> Double { @_common.min(self.vals) }

pub fn NetflowfairnessSeries::max(self : NetflowfairnessSeries) -> Double { @_common.max(self.vals) }

pub fn NetflowfairnessSeries::range(self : NetflowfairnessSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetflowfairnessSeries::variance(self : NetflowfairnessSeries) -> Double { @_common.variance(self.vals) }

pub fn NetflowfairnessSeries::std(self : NetflowfairnessSeries) -> Double { @_common.std(self.vals) }

pub fn NetflowfairnessSeries::median(self : NetflowfairnessSeries) -> Double { @_common.median(self.vals) }

pub fn NetflowfairnessSeries::scale(self : NetflowfairnessSeries, f : Double) -> NetflowfairnessSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetflowfairnessSeries::add(self : NetflowfairnessSeries, other : NetflowfairnessSeries) -> NetflowfairnessSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetflowfairnessSeries::sub(self : NetflowfairnessSeries, other : NetflowfairnessSeries) -> NetflowfairnessSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetflowfairnessSeries::normalize(self : NetflowfairnessSeries) -> NetflowfairnessSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetflowfairnessSeries::cumsum(self : NetflowfairnessSeries) -> NetflowfairnessSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetflowfairnessSeries::to_string(self : NetflowfairnessSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetflowfairnessMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_flow_fairness_make_matrix(rows : Int, cols : Int, val : Double) -> NetflowfairnessMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_flow_fairness_matrix_identity(n : Int) -> NetflowfairnessMatrix {
  let m = net_flow_fairness_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetflowfairnessMatrix::get(self : NetflowfairnessMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetflowfairnessMatrix::transpose(self : NetflowfairnessMatrix) -> NetflowfairnessMatrix {
  let result = net_flow_fairness_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetflowfairnessMatrix::add(self : NetflowfairnessMatrix, other : NetflowfairnessMatrix) -> NetflowfairnessMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_flow_fairness_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetflowfairnessMatrix::scale(self : NetflowfairnessMatrix, s : Double) -> NetflowfairnessMatrix {
  let result = net_flow_fairness_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetflowfairnessMatrix::multiply(self : NetflowfairnessMatrix, other : NetflowfairnessMatrix) -> NetflowfairnessMatrix {
  if self.cols != other.rows { return net_flow_fairness_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_flow_fairness_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NetflowfairnessMatrix::trace(self : NetflowfairnessMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetflowfairnessMatrix::det(self : NetflowfairnessMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetflowfairnessMatrix::norm(self : NetflowfairnessMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetflowfairnessMatrix::to_string(self : NetflowfairnessMatrix) -> String {
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

pub(all) struct NetflowfairnessVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_flow_fairness_make_vector(comps : Array[Double]) -> NetflowfairnessVector {
  { comps, dim: comps.length() }
}

pub fn net_flow_fairness_vector_zero(dim : Int) -> NetflowfairnessVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetflowfairnessVector::add(self : NetflowfairnessVector, other : NetflowfairnessVector) -> NetflowfairnessVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetflowfairnessVector::sub(self : NetflowfairnessVector, other : NetflowfairnessVector) -> NetflowfairnessVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetflowfairnessVector::scale(self : NetflowfairnessVector, s : Double) -> NetflowfairnessVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetflowfairnessVector::dot(self : NetflowfairnessVector, other : NetflowfairnessVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetflowfairnessVector::norm(self : NetflowfairnessVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetflowfairnessVector::normalize(self : NetflowfairnessVector) -> NetflowfairnessVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetflowfairnessVector::dist(self : NetflowfairnessVector, other : NetflowfairnessVector) -> Double {
  self.sub(other).norm()
}

pub fn NetflowfairnessVector::to_string(self : NetflowfairnessVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_flow_fairness_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_flow_fairness_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_flow_fairness_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_flow_fairness_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_flow_fairness_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_flow_fairness_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_flow_fairness_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_flow_fairness_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_flow_fairness_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_flow_fairness_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_flow_fairness_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_flow_fairness_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_flow_fairness_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_flow_fairness_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_flow_fairness_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_flow_fairness_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_flow_fairness_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_flow_fairness_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_flow_fairness_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_flow_fairness_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_flow_fairness_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_flow_fairness_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_flow_fairness_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_flow_fairness_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_flow_fairness_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_flow_fairness_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_flow_fairness_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_flow_fairness_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_flow_fairness_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetflowfairnessFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_fairness_frame_make(size : Int) -> NetflowfairnessFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_fairness_frame_len(s : NetflowfairnessFrame) -> Int { s.size }

pub fn net_flow_fairness_frame_get(s : NetflowfairnessFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_fairness_frame_set(s : NetflowfairnessFrame, i : Int, v : Double) -> NetflowfairnessFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_frame_sum(s : NetflowfairnessFrame) -> Double { @_common.sum(s.data) }

pub fn net_flow_fairness_frame_mean(s : NetflowfairnessFrame) -> Double { @_common.mean(s.data) }

pub fn net_flow_fairness_frame_scale(s : NetflowfairnessFrame, f : Double) -> NetflowfairnessFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_frame_add(a : NetflowfairnessFrame, b : NetflowfairnessFrame) -> NetflowfairnessFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_fairness_frame_copy(s : NetflowfairnessFrame) -> NetflowfairnessFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_frame_fill(s : NetflowfairnessFrame, v : Double) -> NetflowfairnessFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_frame_min(s : NetflowfairnessFrame) -> Double { @_common.min(s.data) }

pub fn net_flow_fairness_frame_max(s : NetflowfairnessFrame) -> Double { @_common.max(s.data) }

pub fn net_flow_fairness_frame_to_string(s : NetflowfairnessFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowfairnessTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_fairness_table_make(size : Int) -> NetflowfairnessTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_fairness_table_len(s : NetflowfairnessTable) -> Int { s.size }

pub fn net_flow_fairness_table_get(s : NetflowfairnessTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_fairness_table_set(s : NetflowfairnessTable, i : Int, v : Double) -> NetflowfairnessTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_table_sum(s : NetflowfairnessTable) -> Double { @_common.sum(s.data) }

pub fn net_flow_fairness_table_mean(s : NetflowfairnessTable) -> Double { @_common.mean(s.data) }

pub fn net_flow_fairness_table_scale(s : NetflowfairnessTable, f : Double) -> NetflowfairnessTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_table_add(a : NetflowfairnessTable, b : NetflowfairnessTable) -> NetflowfairnessTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_fairness_table_copy(s : NetflowfairnessTable) -> NetflowfairnessTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_table_fill(s : NetflowfairnessTable, v : Double) -> NetflowfairnessTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_table_min(s : NetflowfairnessTable) -> Double { @_common.min(s.data) }

pub fn net_flow_fairness_table_max(s : NetflowfairnessTable) -> Double { @_common.max(s.data) }

pub fn net_flow_fairness_table_to_string(s : NetflowfairnessTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowfairnessGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_fairness_graphn_make(size : Int) -> NetflowfairnessGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_fairness_graphn_len(s : NetflowfairnessGraphN) -> Int { s.size }

pub fn net_flow_fairness_graphn_get(s : NetflowfairnessGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_fairness_graphn_set(s : NetflowfairnessGraphN, i : Int, v : Double) -> NetflowfairnessGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_graphn_sum(s : NetflowfairnessGraphN) -> Double { @_common.sum(s.data) }

pub fn net_flow_fairness_graphn_mean(s : NetflowfairnessGraphN) -> Double { @_common.mean(s.data) }

pub fn net_flow_fairness_graphn_scale(s : NetflowfairnessGraphN, f : Double) -> NetflowfairnessGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_graphn_add(a : NetflowfairnessGraphN, b : NetflowfairnessGraphN) -> NetflowfairnessGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_fairness_graphn_copy(s : NetflowfairnessGraphN) -> NetflowfairnessGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_graphn_fill(s : NetflowfairnessGraphN, v : Double) -> NetflowfairnessGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_graphn_min(s : NetflowfairnessGraphN) -> Double { @_common.min(s.data) }

pub fn net_flow_fairness_graphn_max(s : NetflowfairnessGraphN) -> Double { @_common.max(s.data) }

pub fn net_flow_fairness_graphn_to_string(s : NetflowfairnessGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowfairnessNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_fairness_node_make(size : Int) -> NetflowfairnessNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_fairness_node_len(s : NetflowfairnessNode) -> Int { s.size }

pub fn net_flow_fairness_node_get(s : NetflowfairnessNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_fairness_node_set(s : NetflowfairnessNode, i : Int, v : Double) -> NetflowfairnessNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_node_sum(s : NetflowfairnessNode) -> Double { @_common.sum(s.data) }

pub fn net_flow_fairness_node_mean(s : NetflowfairnessNode) -> Double { @_common.mean(s.data) }

pub fn net_flow_fairness_node_scale(s : NetflowfairnessNode, f : Double) -> NetflowfairnessNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_node_add(a : NetflowfairnessNode, b : NetflowfairnessNode) -> NetflowfairnessNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_fairness_node_copy(s : NetflowfairnessNode) -> NetflowfairnessNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_node_fill(s : NetflowfairnessNode, v : Double) -> NetflowfairnessNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_node_min(s : NetflowfairnessNode) -> Double { @_common.min(s.data) }

pub fn net_flow_fairness_node_max(s : NetflowfairnessNode) -> Double { @_common.max(s.data) }

pub fn net_flow_fairness_node_to_string(s : NetflowfairnessNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowfairnessEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_fairness_edge_make(size : Int) -> NetflowfairnessEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_fairness_edge_len(s : NetflowfairnessEdge) -> Int { s.size }

pub fn net_flow_fairness_edge_get(s : NetflowfairnessEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_fairness_edge_set(s : NetflowfairnessEdge, i : Int, v : Double) -> NetflowfairnessEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_edge_sum(s : NetflowfairnessEdge) -> Double { @_common.sum(s.data) }

pub fn net_flow_fairness_edge_mean(s : NetflowfairnessEdge) -> Double { @_common.mean(s.data) }

pub fn net_flow_fairness_edge_scale(s : NetflowfairnessEdge, f : Double) -> NetflowfairnessEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_edge_add(a : NetflowfairnessEdge, b : NetflowfairnessEdge) -> NetflowfairnessEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_fairness_edge_copy(s : NetflowfairnessEdge) -> NetflowfairnessEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_edge_fill(s : NetflowfairnessEdge, v : Double) -> NetflowfairnessEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_edge_min(s : NetflowfairnessEdge) -> Double { @_common.min(s.data) }

pub fn net_flow_fairness_edge_max(s : NetflowfairnessEdge) -> Double { @_common.max(s.data) }

pub fn net_flow_fairness_edge_to_string(s : NetflowfairnessEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowfairnessPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_fairness_path_make(size : Int) -> NetflowfairnessPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_fairness_path_len(s : NetflowfairnessPath) -> Int { s.size }

pub fn net_flow_fairness_path_get(s : NetflowfairnessPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_fairness_path_set(s : NetflowfairnessPath, i : Int, v : Double) -> NetflowfairnessPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_path_sum(s : NetflowfairnessPath) -> Double { @_common.sum(s.data) }

pub fn net_flow_fairness_path_mean(s : NetflowfairnessPath) -> Double { @_common.mean(s.data) }

pub fn net_flow_fairness_path_scale(s : NetflowfairnessPath, f : Double) -> NetflowfairnessPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_path_add(a : NetflowfairnessPath, b : NetflowfairnessPath) -> NetflowfairnessPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_fairness_path_copy(s : NetflowfairnessPath) -> NetflowfairnessPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_path_fill(s : NetflowfairnessPath, v : Double) -> NetflowfairnessPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_path_min(s : NetflowfairnessPath) -> Double { @_common.min(s.data) }

pub fn net_flow_fairness_path_max(s : NetflowfairnessPath) -> Double { @_common.max(s.data) }

pub fn net_flow_fairness_path_to_string(s : NetflowfairnessPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowfairnessCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_fairness_cluster_make(size : Int) -> NetflowfairnessCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_fairness_cluster_len(s : NetflowfairnessCluster) -> Int { s.size }

pub fn net_flow_fairness_cluster_get(s : NetflowfairnessCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_fairness_cluster_set(s : NetflowfairnessCluster, i : Int, v : Double) -> NetflowfairnessCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_cluster_sum(s : NetflowfairnessCluster) -> Double { @_common.sum(s.data) }

pub fn net_flow_fairness_cluster_mean(s : NetflowfairnessCluster) -> Double { @_common.mean(s.data) }

pub fn net_flow_fairness_cluster_scale(s : NetflowfairnessCluster, f : Double) -> NetflowfairnessCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_cluster_add(a : NetflowfairnessCluster, b : NetflowfairnessCluster) -> NetflowfairnessCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_fairness_cluster_copy(s : NetflowfairnessCluster) -> NetflowfairnessCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_cluster_fill(s : NetflowfairnessCluster, v : Double) -> NetflowfairnessCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_cluster_min(s : NetflowfairnessCluster) -> Double { @_common.min(s.data) }

pub fn net_flow_fairness_cluster_max(s : NetflowfairnessCluster) -> Double { @_common.max(s.data) }

pub fn net_flow_fairness_cluster_to_string(s : NetflowfairnessCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowfairnessModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_fairness_model_make(size : Int) -> NetflowfairnessModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_fairness_model_len(s : NetflowfairnessModel) -> Int { s.size }

pub fn net_flow_fairness_model_get(s : NetflowfairnessModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_fairness_model_set(s : NetflowfairnessModel, i : Int, v : Double) -> NetflowfairnessModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_model_sum(s : NetflowfairnessModel) -> Double { @_common.sum(s.data) }

pub fn net_flow_fairness_model_mean(s : NetflowfairnessModel) -> Double { @_common.mean(s.data) }

pub fn net_flow_fairness_model_scale(s : NetflowfairnessModel, f : Double) -> NetflowfairnessModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_model_add(a : NetflowfairnessModel, b : NetflowfairnessModel) -> NetflowfairnessModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_fairness_model_copy(s : NetflowfairnessModel) -> NetflowfairnessModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_model_fill(s : NetflowfairnessModel, v : Double) -> NetflowfairnessModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_model_min(s : NetflowfairnessModel) -> Double { @_common.min(s.data) }

pub fn net_flow_fairness_model_max(s : NetflowfairnessModel) -> Double { @_common.max(s.data) }

pub fn net_flow_fairness_model_to_string(s : NetflowfairnessModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowfairnessLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_fairness_layer_make(size : Int) -> NetflowfairnessLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_fairness_layer_len(s : NetflowfairnessLayer) -> Int { s.size }

pub fn net_flow_fairness_layer_get(s : NetflowfairnessLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_fairness_layer_set(s : NetflowfairnessLayer, i : Int, v : Double) -> NetflowfairnessLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_layer_sum(s : NetflowfairnessLayer) -> Double { @_common.sum(s.data) }

pub fn net_flow_fairness_layer_mean(s : NetflowfairnessLayer) -> Double { @_common.mean(s.data) }

pub fn net_flow_fairness_layer_scale(s : NetflowfairnessLayer, f : Double) -> NetflowfairnessLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_layer_add(a : NetflowfairnessLayer, b : NetflowfairnessLayer) -> NetflowfairnessLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_fairness_layer_copy(s : NetflowfairnessLayer) -> NetflowfairnessLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_layer_fill(s : NetflowfairnessLayer, v : Double) -> NetflowfairnessLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_layer_min(s : NetflowfairnessLayer) -> Double { @_common.min(s.data) }

pub fn net_flow_fairness_layer_max(s : NetflowfairnessLayer) -> Double { @_common.max(s.data) }

pub fn net_flow_fairness_layer_to_string(s : NetflowfairnessLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowfairnessBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_fairness_buffer_make(size : Int) -> NetflowfairnessBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_fairness_buffer_len(s : NetflowfairnessBuffer) -> Int { s.size }

pub fn net_flow_fairness_buffer_get(s : NetflowfairnessBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_fairness_buffer_set(s : NetflowfairnessBuffer, i : Int, v : Double) -> NetflowfairnessBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_buffer_sum(s : NetflowfairnessBuffer) -> Double { @_common.sum(s.data) }

pub fn net_flow_fairness_buffer_mean(s : NetflowfairnessBuffer) -> Double { @_common.mean(s.data) }

pub fn net_flow_fairness_buffer_scale(s : NetflowfairnessBuffer, f : Double) -> NetflowfairnessBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_buffer_add(a : NetflowfairnessBuffer, b : NetflowfairnessBuffer) -> NetflowfairnessBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_fairness_buffer_copy(s : NetflowfairnessBuffer) -> NetflowfairnessBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_buffer_fill(s : NetflowfairnessBuffer, v : Double) -> NetflowfairnessBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_buffer_min(s : NetflowfairnessBuffer) -> Double { @_common.min(s.data) }

pub fn net_flow_fairness_buffer_max(s : NetflowfairnessBuffer) -> Double { @_common.max(s.data) }

pub fn net_flow_fairness_buffer_to_string(s : NetflowfairnessBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowfairnessCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_fairness_cursor_make(size : Int) -> NetflowfairnessCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_fairness_cursor_len(s : NetflowfairnessCursor) -> Int { s.size }

pub fn net_flow_fairness_cursor_get(s : NetflowfairnessCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_fairness_cursor_set(s : NetflowfairnessCursor, i : Int, v : Double) -> NetflowfairnessCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_cursor_sum(s : NetflowfairnessCursor) -> Double { @_common.sum(s.data) }

pub fn net_flow_fairness_cursor_mean(s : NetflowfairnessCursor) -> Double { @_common.mean(s.data) }

pub fn net_flow_fairness_cursor_scale(s : NetflowfairnessCursor, f : Double) -> NetflowfairnessCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_cursor_add(a : NetflowfairnessCursor, b : NetflowfairnessCursor) -> NetflowfairnessCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_fairness_cursor_copy(s : NetflowfairnessCursor) -> NetflowfairnessCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_cursor_fill(s : NetflowfairnessCursor, v : Double) -> NetflowfairnessCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_cursor_min(s : NetflowfairnessCursor) -> Double { @_common.min(s.data) }

pub fn net_flow_fairness_cursor_max(s : NetflowfairnessCursor) -> Double { @_common.max(s.data) }

pub fn net_flow_fairness_cursor_to_string(s : NetflowfairnessCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowfairnessView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_fairness_view_make(size : Int) -> NetflowfairnessView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_fairness_view_len(s : NetflowfairnessView) -> Int { s.size }

pub fn net_flow_fairness_view_get(s : NetflowfairnessView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_fairness_view_set(s : NetflowfairnessView, i : Int, v : Double) -> NetflowfairnessView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_view_sum(s : NetflowfairnessView) -> Double { @_common.sum(s.data) }

pub fn net_flow_fairness_view_mean(s : NetflowfairnessView) -> Double { @_common.mean(s.data) }

pub fn net_flow_fairness_view_scale(s : NetflowfairnessView, f : Double) -> NetflowfairnessView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_view_add(a : NetflowfairnessView, b : NetflowfairnessView) -> NetflowfairnessView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_fairness_view_copy(s : NetflowfairnessView) -> NetflowfairnessView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_view_fill(s : NetflowfairnessView, v : Double) -> NetflowfairnessView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_view_min(s : NetflowfairnessView) -> Double { @_common.min(s.data) }

pub fn net_flow_fairness_view_max(s : NetflowfairnessView) -> Double { @_common.max(s.data) }

pub fn net_flow_fairness_view_to_string(s : NetflowfairnessView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowfairnessRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_fairness_range_make(size : Int) -> NetflowfairnessRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_fairness_range_len(s : NetflowfairnessRange) -> Int { s.size }

pub fn net_flow_fairness_range_get(s : NetflowfairnessRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_fairness_range_set(s : NetflowfairnessRange, i : Int, v : Double) -> NetflowfairnessRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_range_sum(s : NetflowfairnessRange) -> Double { @_common.sum(s.data) }

pub fn net_flow_fairness_range_mean(s : NetflowfairnessRange) -> Double { @_common.mean(s.data) }

pub fn net_flow_fairness_range_scale(s : NetflowfairnessRange, f : Double) -> NetflowfairnessRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_range_add(a : NetflowfairnessRange, b : NetflowfairnessRange) -> NetflowfairnessRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_fairness_range_copy(s : NetflowfairnessRange) -> NetflowfairnessRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_range_fill(s : NetflowfairnessRange, v : Double) -> NetflowfairnessRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_range_min(s : NetflowfairnessRange) -> Double { @_common.min(s.data) }

pub fn net_flow_fairness_range_max(s : NetflowfairnessRange) -> Double { @_common.max(s.data) }

pub fn net_flow_fairness_range_to_string(s : NetflowfairnessRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowfairnessSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_fairness_slice_make(size : Int) -> NetflowfairnessSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_fairness_slice_len(s : NetflowfairnessSlice) -> Int { s.size }

pub fn net_flow_fairness_slice_get(s : NetflowfairnessSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_fairness_slice_set(s : NetflowfairnessSlice, i : Int, v : Double) -> NetflowfairnessSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_slice_sum(s : NetflowfairnessSlice) -> Double { @_common.sum(s.data) }

pub fn net_flow_fairness_slice_mean(s : NetflowfairnessSlice) -> Double { @_common.mean(s.data) }

pub fn net_flow_fairness_slice_scale(s : NetflowfairnessSlice, f : Double) -> NetflowfairnessSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_slice_add(a : NetflowfairnessSlice, b : NetflowfairnessSlice) -> NetflowfairnessSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_fairness_slice_copy(s : NetflowfairnessSlice) -> NetflowfairnessSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_slice_fill(s : NetflowfairnessSlice, v : Double) -> NetflowfairnessSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_fairness_slice_min(s : NetflowfairnessSlice) -> Double { @_common.min(s.data) }

pub fn net_flow_fairness_slice_max(s : NetflowfairnessSlice) -> Double { @_common.max(s.data) }

pub fn net_flow_fairness_slice_to_string(s : NetflowfairnessSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

