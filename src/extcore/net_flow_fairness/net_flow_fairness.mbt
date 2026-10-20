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

pub fn NetflowfairnessFrame::len(self : NetflowfairnessFrame) -> Int { self.size }

pub fn NetflowfairnessFrame::get(self : NetflowfairnessFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowfairnessFrame::set(self : NetflowfairnessFrame, i : Int, v : Double) -> NetflowfairnessFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowfairnessFrame::sum(self : NetflowfairnessFrame) -> Double { @_common.sum(self.data) }

pub fn NetflowfairnessFrame::mean(self : NetflowfairnessFrame) -> Double { @_common.mean(self.data) }

pub fn NetflowfairnessFrame::scale(self : NetflowfairnessFrame, f : Double) -> NetflowfairnessFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowfairnessFrame::add(self : NetflowfairnessFrame, other : NetflowfairnessFrame) -> NetflowfairnessFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowfairnessFrame::copy(self : NetflowfairnessFrame) -> NetflowfairnessFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowfairnessFrame::fill(self : NetflowfairnessFrame, v : Double) -> NetflowfairnessFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowfairnessFrame::min(self : NetflowfairnessFrame) -> Double { @_common.min(self.data) }

pub fn NetflowfairnessFrame::max(self : NetflowfairnessFrame) -> Double { @_common.max(self.data) }

pub fn NetflowfairnessFrame::to_string(self : NetflowfairnessFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowfairnessTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_fairness_table_make(size : Int) -> NetflowfairnessTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowfairnessTable::len(self : NetflowfairnessTable) -> Int { self.size }

pub fn NetflowfairnessTable::get(self : NetflowfairnessTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowfairnessTable::set(self : NetflowfairnessTable, i : Int, v : Double) -> NetflowfairnessTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowfairnessTable::sum(self : NetflowfairnessTable) -> Double { @_common.sum(self.data) }

pub fn NetflowfairnessTable::mean(self : NetflowfairnessTable) -> Double { @_common.mean(self.data) }

pub fn NetflowfairnessTable::scale(self : NetflowfairnessTable, f : Double) -> NetflowfairnessTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowfairnessTable::add(self : NetflowfairnessTable, other : NetflowfairnessTable) -> NetflowfairnessTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowfairnessTable::copy(self : NetflowfairnessTable) -> NetflowfairnessTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowfairnessTable::fill(self : NetflowfairnessTable, v : Double) -> NetflowfairnessTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowfairnessTable::min(self : NetflowfairnessTable) -> Double { @_common.min(self.data) }

pub fn NetflowfairnessTable::max(self : NetflowfairnessTable) -> Double { @_common.max(self.data) }

pub fn NetflowfairnessTable::to_string(self : NetflowfairnessTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowfairnessGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_fairness_graphn_make(size : Int) -> NetflowfairnessGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowfairnessGraphN::len(self : NetflowfairnessGraphN) -> Int { self.size }

pub fn NetflowfairnessGraphN::get(self : NetflowfairnessGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowfairnessGraphN::set(self : NetflowfairnessGraphN, i : Int, v : Double) -> NetflowfairnessGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowfairnessGraphN::sum(self : NetflowfairnessGraphN) -> Double { @_common.sum(self.data) }

pub fn NetflowfairnessGraphN::mean(self : NetflowfairnessGraphN) -> Double { @_common.mean(self.data) }

pub fn NetflowfairnessGraphN::scale(self : NetflowfairnessGraphN, f : Double) -> NetflowfairnessGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowfairnessGraphN::add(self : NetflowfairnessGraphN, other : NetflowfairnessGraphN) -> NetflowfairnessGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowfairnessGraphN::copy(self : NetflowfairnessGraphN) -> NetflowfairnessGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowfairnessGraphN::fill(self : NetflowfairnessGraphN, v : Double) -> NetflowfairnessGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowfairnessGraphN::min(self : NetflowfairnessGraphN) -> Double { @_common.min(self.data) }

pub fn NetflowfairnessGraphN::max(self : NetflowfairnessGraphN) -> Double { @_common.max(self.data) }

pub fn NetflowfairnessGraphN::to_string(self : NetflowfairnessGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowfairnessNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_fairness_node_make(size : Int) -> NetflowfairnessNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowfairnessNode::len(self : NetflowfairnessNode) -> Int { self.size }

pub fn NetflowfairnessNode::get(self : NetflowfairnessNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowfairnessNode::set(self : NetflowfairnessNode, i : Int, v : Double) -> NetflowfairnessNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowfairnessNode::sum(self : NetflowfairnessNode) -> Double { @_common.sum(self.data) }

pub fn NetflowfairnessNode::mean(self : NetflowfairnessNode) -> Double { @_common.mean(self.data) }

pub fn NetflowfairnessNode::scale(self : NetflowfairnessNode, f : Double) -> NetflowfairnessNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowfairnessNode::add(self : NetflowfairnessNode, other : NetflowfairnessNode) -> NetflowfairnessNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowfairnessNode::copy(self : NetflowfairnessNode) -> NetflowfairnessNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowfairnessNode::fill(self : NetflowfairnessNode, v : Double) -> NetflowfairnessNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowfairnessNode::min(self : NetflowfairnessNode) -> Double { @_common.min(self.data) }

pub fn NetflowfairnessNode::max(self : NetflowfairnessNode) -> Double { @_common.max(self.data) }

pub fn NetflowfairnessNode::to_string(self : NetflowfairnessNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowfairnessEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_fairness_edge_make(size : Int) -> NetflowfairnessEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowfairnessEdge::len(self : NetflowfairnessEdge) -> Int { self.size }

pub fn NetflowfairnessEdge::get(self : NetflowfairnessEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowfairnessEdge::set(self : NetflowfairnessEdge, i : Int, v : Double) -> NetflowfairnessEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowfairnessEdge::sum(self : NetflowfairnessEdge) -> Double { @_common.sum(self.data) }

pub fn NetflowfairnessEdge::mean(self : NetflowfairnessEdge) -> Double { @_common.mean(self.data) }

pub fn NetflowfairnessEdge::scale(self : NetflowfairnessEdge, f : Double) -> NetflowfairnessEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowfairnessEdge::add(self : NetflowfairnessEdge, other : NetflowfairnessEdge) -> NetflowfairnessEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowfairnessEdge::copy(self : NetflowfairnessEdge) -> NetflowfairnessEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowfairnessEdge::fill(self : NetflowfairnessEdge, v : Double) -> NetflowfairnessEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowfairnessEdge::min(self : NetflowfairnessEdge) -> Double { @_common.min(self.data) }

pub fn NetflowfairnessEdge::max(self : NetflowfairnessEdge) -> Double { @_common.max(self.data) }

pub fn NetflowfairnessEdge::to_string(self : NetflowfairnessEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowfairnessPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_fairness_path_make(size : Int) -> NetflowfairnessPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowfairnessPath::len(self : NetflowfairnessPath) -> Int { self.size }

pub fn NetflowfairnessPath::get(self : NetflowfairnessPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowfairnessPath::set(self : NetflowfairnessPath, i : Int, v : Double) -> NetflowfairnessPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowfairnessPath::sum(self : NetflowfairnessPath) -> Double { @_common.sum(self.data) }

pub fn NetflowfairnessPath::mean(self : NetflowfairnessPath) -> Double { @_common.mean(self.data) }

pub fn NetflowfairnessPath::scale(self : NetflowfairnessPath, f : Double) -> NetflowfairnessPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowfairnessPath::add(self : NetflowfairnessPath, other : NetflowfairnessPath) -> NetflowfairnessPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowfairnessPath::copy(self : NetflowfairnessPath) -> NetflowfairnessPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowfairnessPath::fill(self : NetflowfairnessPath, v : Double) -> NetflowfairnessPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowfairnessPath::min(self : NetflowfairnessPath) -> Double { @_common.min(self.data) }

pub fn NetflowfairnessPath::max(self : NetflowfairnessPath) -> Double { @_common.max(self.data) }

pub fn NetflowfairnessPath::to_string(self : NetflowfairnessPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowfairnessCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_fairness_cluster_make(size : Int) -> NetflowfairnessCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowfairnessCluster::len(self : NetflowfairnessCluster) -> Int { self.size }

pub fn NetflowfairnessCluster::get(self : NetflowfairnessCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowfairnessCluster::set(self : NetflowfairnessCluster, i : Int, v : Double) -> NetflowfairnessCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowfairnessCluster::sum(self : NetflowfairnessCluster) -> Double { @_common.sum(self.data) }

pub fn NetflowfairnessCluster::mean(self : NetflowfairnessCluster) -> Double { @_common.mean(self.data) }

pub fn NetflowfairnessCluster::scale(self : NetflowfairnessCluster, f : Double) -> NetflowfairnessCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowfairnessCluster::add(self : NetflowfairnessCluster, other : NetflowfairnessCluster) -> NetflowfairnessCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowfairnessCluster::copy(self : NetflowfairnessCluster) -> NetflowfairnessCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowfairnessCluster::fill(self : NetflowfairnessCluster, v : Double) -> NetflowfairnessCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowfairnessCluster::min(self : NetflowfairnessCluster) -> Double { @_common.min(self.data) }

pub fn NetflowfairnessCluster::max(self : NetflowfairnessCluster) -> Double { @_common.max(self.data) }

pub fn NetflowfairnessCluster::to_string(self : NetflowfairnessCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowfairnessModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_fairness_model_make(size : Int) -> NetflowfairnessModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowfairnessModel::len(self : NetflowfairnessModel) -> Int { self.size }

pub fn NetflowfairnessModel::get(self : NetflowfairnessModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowfairnessModel::set(self : NetflowfairnessModel, i : Int, v : Double) -> NetflowfairnessModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowfairnessModel::sum(self : NetflowfairnessModel) -> Double { @_common.sum(self.data) }

pub fn NetflowfairnessModel::mean(self : NetflowfairnessModel) -> Double { @_common.mean(self.data) }

pub fn NetflowfairnessModel::scale(self : NetflowfairnessModel, f : Double) -> NetflowfairnessModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowfairnessModel::add(self : NetflowfairnessModel, other : NetflowfairnessModel) -> NetflowfairnessModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowfairnessModel::copy(self : NetflowfairnessModel) -> NetflowfairnessModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowfairnessModel::fill(self : NetflowfairnessModel, v : Double) -> NetflowfairnessModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowfairnessModel::min(self : NetflowfairnessModel) -> Double { @_common.min(self.data) }

pub fn NetflowfairnessModel::max(self : NetflowfairnessModel) -> Double { @_common.max(self.data) }

pub fn NetflowfairnessModel::to_string(self : NetflowfairnessModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowfairnessLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_fairness_layer_make(size : Int) -> NetflowfairnessLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowfairnessLayer::len(self : NetflowfairnessLayer) -> Int { self.size }

pub fn NetflowfairnessLayer::get(self : NetflowfairnessLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowfairnessLayer::set(self : NetflowfairnessLayer, i : Int, v : Double) -> NetflowfairnessLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowfairnessLayer::sum(self : NetflowfairnessLayer) -> Double { @_common.sum(self.data) }

pub fn NetflowfairnessLayer::mean(self : NetflowfairnessLayer) -> Double { @_common.mean(self.data) }

pub fn NetflowfairnessLayer::scale(self : NetflowfairnessLayer, f : Double) -> NetflowfairnessLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowfairnessLayer::add(self : NetflowfairnessLayer, other : NetflowfairnessLayer) -> NetflowfairnessLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowfairnessLayer::copy(self : NetflowfairnessLayer) -> NetflowfairnessLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowfairnessLayer::fill(self : NetflowfairnessLayer, v : Double) -> NetflowfairnessLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowfairnessLayer::min(self : NetflowfairnessLayer) -> Double { @_common.min(self.data) }

pub fn NetflowfairnessLayer::max(self : NetflowfairnessLayer) -> Double { @_common.max(self.data) }

pub fn NetflowfairnessLayer::to_string(self : NetflowfairnessLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowfairnessBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_fairness_buffer_make(size : Int) -> NetflowfairnessBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowfairnessBuffer::len(self : NetflowfairnessBuffer) -> Int { self.size }

pub fn NetflowfairnessBuffer::get(self : NetflowfairnessBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowfairnessBuffer::set(self : NetflowfairnessBuffer, i : Int, v : Double) -> NetflowfairnessBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowfairnessBuffer::sum(self : NetflowfairnessBuffer) -> Double { @_common.sum(self.data) }

pub fn NetflowfairnessBuffer::mean(self : NetflowfairnessBuffer) -> Double { @_common.mean(self.data) }

pub fn NetflowfairnessBuffer::scale(self : NetflowfairnessBuffer, f : Double) -> NetflowfairnessBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowfairnessBuffer::add(self : NetflowfairnessBuffer, other : NetflowfairnessBuffer) -> NetflowfairnessBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowfairnessBuffer::copy(self : NetflowfairnessBuffer) -> NetflowfairnessBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowfairnessBuffer::fill(self : NetflowfairnessBuffer, v : Double) -> NetflowfairnessBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowfairnessBuffer::min(self : NetflowfairnessBuffer) -> Double { @_common.min(self.data) }

pub fn NetflowfairnessBuffer::max(self : NetflowfairnessBuffer) -> Double { @_common.max(self.data) }

pub fn NetflowfairnessBuffer::to_string(self : NetflowfairnessBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowfairnessCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_fairness_cursor_make(size : Int) -> NetflowfairnessCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowfairnessCursor::len(self : NetflowfairnessCursor) -> Int { self.size }

pub fn NetflowfairnessCursor::get(self : NetflowfairnessCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowfairnessCursor::set(self : NetflowfairnessCursor, i : Int, v : Double) -> NetflowfairnessCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowfairnessCursor::sum(self : NetflowfairnessCursor) -> Double { @_common.sum(self.data) }

pub fn NetflowfairnessCursor::mean(self : NetflowfairnessCursor) -> Double { @_common.mean(self.data) }

pub fn NetflowfairnessCursor::scale(self : NetflowfairnessCursor, f : Double) -> NetflowfairnessCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowfairnessCursor::add(self : NetflowfairnessCursor, other : NetflowfairnessCursor) -> NetflowfairnessCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowfairnessCursor::copy(self : NetflowfairnessCursor) -> NetflowfairnessCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowfairnessCursor::fill(self : NetflowfairnessCursor, v : Double) -> NetflowfairnessCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowfairnessCursor::min(self : NetflowfairnessCursor) -> Double { @_common.min(self.data) }

pub fn NetflowfairnessCursor::max(self : NetflowfairnessCursor) -> Double { @_common.max(self.data) }

pub fn NetflowfairnessCursor::to_string(self : NetflowfairnessCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowfairnessView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_fairness_view_make(size : Int) -> NetflowfairnessView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowfairnessView::len(self : NetflowfairnessView) -> Int { self.size }

pub fn NetflowfairnessView::get(self : NetflowfairnessView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowfairnessView::set(self : NetflowfairnessView, i : Int, v : Double) -> NetflowfairnessView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowfairnessView::sum(self : NetflowfairnessView) -> Double { @_common.sum(self.data) }

pub fn NetflowfairnessView::mean(self : NetflowfairnessView) -> Double { @_common.mean(self.data) }

pub fn NetflowfairnessView::scale(self : NetflowfairnessView, f : Double) -> NetflowfairnessView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowfairnessView::add(self : NetflowfairnessView, other : NetflowfairnessView) -> NetflowfairnessView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowfairnessView::copy(self : NetflowfairnessView) -> NetflowfairnessView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowfairnessView::fill(self : NetflowfairnessView, v : Double) -> NetflowfairnessView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowfairnessView::min(self : NetflowfairnessView) -> Double { @_common.min(self.data) }

pub fn NetflowfairnessView::max(self : NetflowfairnessView) -> Double { @_common.max(self.data) }

pub fn NetflowfairnessView::to_string(self : NetflowfairnessView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowfairnessRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_fairness_range_make(size : Int) -> NetflowfairnessRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowfairnessRange::len(self : NetflowfairnessRange) -> Int { self.size }

pub fn NetflowfairnessRange::get(self : NetflowfairnessRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowfairnessRange::set(self : NetflowfairnessRange, i : Int, v : Double) -> NetflowfairnessRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowfairnessRange::sum(self : NetflowfairnessRange) -> Double { @_common.sum(self.data) }

pub fn NetflowfairnessRange::mean(self : NetflowfairnessRange) -> Double { @_common.mean(self.data) }

pub fn NetflowfairnessRange::scale(self : NetflowfairnessRange, f : Double) -> NetflowfairnessRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowfairnessRange::add(self : NetflowfairnessRange, other : NetflowfairnessRange) -> NetflowfairnessRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowfairnessRange::copy(self : NetflowfairnessRange) -> NetflowfairnessRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowfairnessRange::fill(self : NetflowfairnessRange, v : Double) -> NetflowfairnessRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowfairnessRange::min(self : NetflowfairnessRange) -> Double { @_common.min(self.data) }

pub fn NetflowfairnessRange::max(self : NetflowfairnessRange) -> Double { @_common.max(self.data) }

pub fn NetflowfairnessRange::to_string(self : NetflowfairnessRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowfairnessSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_fairness_slice_make(size : Int) -> NetflowfairnessSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowfairnessSlice::len(self : NetflowfairnessSlice) -> Int { self.size }

pub fn NetflowfairnessSlice::get(self : NetflowfairnessSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowfairnessSlice::set(self : NetflowfairnessSlice, i : Int, v : Double) -> NetflowfairnessSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowfairnessSlice::sum(self : NetflowfairnessSlice) -> Double { @_common.sum(self.data) }

pub fn NetflowfairnessSlice::mean(self : NetflowfairnessSlice) -> Double { @_common.mean(self.data) }

pub fn NetflowfairnessSlice::scale(self : NetflowfairnessSlice, f : Double) -> NetflowfairnessSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowfairnessSlice::add(self : NetflowfairnessSlice, other : NetflowfairnessSlice) -> NetflowfairnessSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowfairnessSlice::copy(self : NetflowfairnessSlice) -> NetflowfairnessSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowfairnessSlice::fill(self : NetflowfairnessSlice, v : Double) -> NetflowfairnessSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowfairnessSlice::min(self : NetflowfairnessSlice) -> Double { @_common.min(self.data) }

pub fn NetflowfairnessSlice::max(self : NetflowfairnessSlice) -> Double { @_common.max(self.data) }

pub fn NetflowfairnessSlice::to_string(self : NetflowfairnessSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

