///===
/// extcore/chem_rxn_balance

pub(all) struct ChemrxnbalancePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_rxn_balance_make_point(x : Double, y : Double) -> ChemrxnbalancePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_rxn_balance_make_point3(x : Double, y : Double, z : Double) -> ChemrxnbalancePoint {
  { x, y, z, label: 0 }
}

pub fn ChemrxnbalancePoint::x(self : ChemrxnbalancePoint) -> Double { self.x }

pub fn ChemrxnbalancePoint::y(self : ChemrxnbalancePoint) -> Double { self.y }

pub fn ChemrxnbalancePoint::z(self : ChemrxnbalancePoint) -> Double { self.z }

pub fn ChemrxnbalancePoint::label(self : ChemrxnbalancePoint) -> Int { self.label }

pub fn ChemrxnbalancePoint::dist(self : ChemrxnbalancePoint, other : ChemrxnbalancePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemrxnbalancePoint::add(self : ChemrxnbalancePoint, other : ChemrxnbalancePoint) -> ChemrxnbalancePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemrxnbalancePoint::sub(self : ChemrxnbalancePoint, other : ChemrxnbalancePoint) -> ChemrxnbalancePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemrxnbalancePoint::scale(self : ChemrxnbalancePoint, s : Double) -> ChemrxnbalancePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemrxnbalancePoint::dot(self : ChemrxnbalancePoint, other : ChemrxnbalancePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemrxnbalancePoint::cross(self : ChemrxnbalancePoint, other : ChemrxnbalancePoint) -> ChemrxnbalancePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemrxnbalancePoint::norm(self : ChemrxnbalancePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemrxnbalancePoint::normalize(self : ChemrxnbalancePoint) -> ChemrxnbalancePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemrxnbalancePoint::negate(self : ChemrxnbalancePoint) -> ChemrxnbalancePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemrxnbalancePoint::mid(self : ChemrxnbalancePoint, other : ChemrxnbalancePoint) -> ChemrxnbalancePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemrxnbalancePoint::lerp(self : ChemrxnbalancePoint, other : ChemrxnbalancePoint, t : Double) -> ChemrxnbalancePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemrxnbalancePoint::to_string(self : ChemrxnbalancePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemrxnbalanceSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_rxn_balance_make_series(vals : Array[Double], name : String) -> ChemrxnbalanceSeries {
  { vals, name, meta: 0 }
}

pub fn ChemrxnbalanceSeries::len(self : ChemrxnbalanceSeries) -> Int { self.vals.length() }

pub fn ChemrxnbalanceSeries::sum(self : ChemrxnbalanceSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemrxnbalanceSeries::mean(self : ChemrxnbalanceSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemrxnbalanceSeries::min(self : ChemrxnbalanceSeries) -> Double { @_common.min(self.vals) }

pub fn ChemrxnbalanceSeries::max(self : ChemrxnbalanceSeries) -> Double { @_common.max(self.vals) }

pub fn ChemrxnbalanceSeries::range(self : ChemrxnbalanceSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemrxnbalanceSeries::variance(self : ChemrxnbalanceSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemrxnbalanceSeries::std(self : ChemrxnbalanceSeries) -> Double { @_common.std(self.vals) }

pub fn ChemrxnbalanceSeries::median(self : ChemrxnbalanceSeries) -> Double { @_common.median(self.vals) }

pub fn ChemrxnbalanceSeries::scale(self : ChemrxnbalanceSeries, f : Double) -> ChemrxnbalanceSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemrxnbalanceSeries::add(self : ChemrxnbalanceSeries, other : ChemrxnbalanceSeries) -> ChemrxnbalanceSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemrxnbalanceSeries::sub(self : ChemrxnbalanceSeries, other : ChemrxnbalanceSeries) -> ChemrxnbalanceSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemrxnbalanceSeries::normalize(self : ChemrxnbalanceSeries) -> ChemrxnbalanceSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemrxnbalanceSeries::cumsum(self : ChemrxnbalanceSeries) -> ChemrxnbalanceSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemrxnbalanceSeries::to_string(self : ChemrxnbalanceSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemrxnbalanceMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_rxn_balance_make_matrix(rows : Int, cols : Int, val : Double) -> ChemrxnbalanceMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_rxn_balance_matrix_identity(n : Int) -> ChemrxnbalanceMatrix {
  let m = chem_rxn_balance_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemrxnbalanceMatrix::get(self : ChemrxnbalanceMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemrxnbalanceMatrix::transpose(self : ChemrxnbalanceMatrix) -> ChemrxnbalanceMatrix {
  let result = chem_rxn_balance_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemrxnbalanceMatrix::add(self : ChemrxnbalanceMatrix, other : ChemrxnbalanceMatrix) -> ChemrxnbalanceMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_rxn_balance_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemrxnbalanceMatrix::scale(self : ChemrxnbalanceMatrix, s : Double) -> ChemrxnbalanceMatrix {
  let result = chem_rxn_balance_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemrxnbalanceMatrix::multiply(self : ChemrxnbalanceMatrix, other : ChemrxnbalanceMatrix) -> ChemrxnbalanceMatrix {
  if self.cols != other.rows { return chem_rxn_balance_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_rxn_balance_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ChemrxnbalanceMatrix::trace(self : ChemrxnbalanceMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemrxnbalanceMatrix::det(self : ChemrxnbalanceMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemrxnbalanceMatrix::norm(self : ChemrxnbalanceMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemrxnbalanceMatrix::to_string(self : ChemrxnbalanceMatrix) -> String {
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

pub(all) struct ChemrxnbalanceVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_rxn_balance_make_vector(comps : Array[Double]) -> ChemrxnbalanceVector {
  { comps, dim: comps.length() }
}

pub fn chem_rxn_balance_vector_zero(dim : Int) -> ChemrxnbalanceVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemrxnbalanceVector::add(self : ChemrxnbalanceVector, other : ChemrxnbalanceVector) -> ChemrxnbalanceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemrxnbalanceVector::sub(self : ChemrxnbalanceVector, other : ChemrxnbalanceVector) -> ChemrxnbalanceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemrxnbalanceVector::scale(self : ChemrxnbalanceVector, s : Double) -> ChemrxnbalanceVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemrxnbalanceVector::dot(self : ChemrxnbalanceVector, other : ChemrxnbalanceVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemrxnbalanceVector::norm(self : ChemrxnbalanceVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemrxnbalanceVector::normalize(self : ChemrxnbalanceVector) -> ChemrxnbalanceVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemrxnbalanceVector::dist(self : ChemrxnbalanceVector, other : ChemrxnbalanceVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemrxnbalanceVector::to_string(self : ChemrxnbalanceVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_rxn_balance_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_rxn_balance_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_rxn_balance_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_rxn_balance_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_rxn_balance_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_rxn_balance_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_rxn_balance_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_rxn_balance_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_rxn_balance_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_rxn_balance_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_rxn_balance_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_rxn_balance_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_rxn_balance_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_rxn_balance_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_rxn_balance_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_rxn_balance_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_rxn_balance_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_rxn_balance_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_rxn_balance_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_rxn_balance_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_rxn_balance_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_rxn_balance_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_rxn_balance_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_rxn_balance_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_rxn_balance_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_rxn_balance_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_rxn_balance_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_rxn_balance_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_rxn_balance_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemrxnbalanceFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_balance_frame_make(size : Int) -> ChemrxnbalanceFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_balance_frame_len(s : ChemrxnbalanceFrame) -> Int { s.size }

pub fn chem_rxn_balance_frame_get(s : ChemrxnbalanceFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_balance_frame_set(s : ChemrxnbalanceFrame, i : Int, v : Double) -> ChemrxnbalanceFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_frame_sum(s : ChemrxnbalanceFrame) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_balance_frame_mean(s : ChemrxnbalanceFrame) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_balance_frame_scale(s : ChemrxnbalanceFrame, f : Double) -> ChemrxnbalanceFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_frame_add(a : ChemrxnbalanceFrame, b : ChemrxnbalanceFrame) -> ChemrxnbalanceFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_balance_frame_copy(s : ChemrxnbalanceFrame) -> ChemrxnbalanceFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_frame_fill(s : ChemrxnbalanceFrame, v : Double) -> ChemrxnbalanceFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_frame_min(s : ChemrxnbalanceFrame) -> Double { @_common.min(s.data) }

pub fn chem_rxn_balance_frame_max(s : ChemrxnbalanceFrame) -> Double { @_common.max(s.data) }

pub fn chem_rxn_balance_frame_to_string(s : ChemrxnbalanceFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnbalanceTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_balance_table_make(size : Int) -> ChemrxnbalanceTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_balance_table_len(s : ChemrxnbalanceTable) -> Int { s.size }

pub fn chem_rxn_balance_table_get(s : ChemrxnbalanceTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_balance_table_set(s : ChemrxnbalanceTable, i : Int, v : Double) -> ChemrxnbalanceTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_table_sum(s : ChemrxnbalanceTable) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_balance_table_mean(s : ChemrxnbalanceTable) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_balance_table_scale(s : ChemrxnbalanceTable, f : Double) -> ChemrxnbalanceTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_table_add(a : ChemrxnbalanceTable, b : ChemrxnbalanceTable) -> ChemrxnbalanceTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_balance_table_copy(s : ChemrxnbalanceTable) -> ChemrxnbalanceTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_table_fill(s : ChemrxnbalanceTable, v : Double) -> ChemrxnbalanceTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_table_min(s : ChemrxnbalanceTable) -> Double { @_common.min(s.data) }

pub fn chem_rxn_balance_table_max(s : ChemrxnbalanceTable) -> Double { @_common.max(s.data) }

pub fn chem_rxn_balance_table_to_string(s : ChemrxnbalanceTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnbalanceGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_balance_graphn_make(size : Int) -> ChemrxnbalanceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_balance_graphn_len(s : ChemrxnbalanceGraphN) -> Int { s.size }

pub fn chem_rxn_balance_graphn_get(s : ChemrxnbalanceGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_balance_graphn_set(s : ChemrxnbalanceGraphN, i : Int, v : Double) -> ChemrxnbalanceGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_graphn_sum(s : ChemrxnbalanceGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_balance_graphn_mean(s : ChemrxnbalanceGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_balance_graphn_scale(s : ChemrxnbalanceGraphN, f : Double) -> ChemrxnbalanceGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_graphn_add(a : ChemrxnbalanceGraphN, b : ChemrxnbalanceGraphN) -> ChemrxnbalanceGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_balance_graphn_copy(s : ChemrxnbalanceGraphN) -> ChemrxnbalanceGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_graphn_fill(s : ChemrxnbalanceGraphN, v : Double) -> ChemrxnbalanceGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_graphn_min(s : ChemrxnbalanceGraphN) -> Double { @_common.min(s.data) }

pub fn chem_rxn_balance_graphn_max(s : ChemrxnbalanceGraphN) -> Double { @_common.max(s.data) }

pub fn chem_rxn_balance_graphn_to_string(s : ChemrxnbalanceGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnbalanceNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_balance_node_make(size : Int) -> ChemrxnbalanceNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_balance_node_len(s : ChemrxnbalanceNode) -> Int { s.size }

pub fn chem_rxn_balance_node_get(s : ChemrxnbalanceNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_balance_node_set(s : ChemrxnbalanceNode, i : Int, v : Double) -> ChemrxnbalanceNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_node_sum(s : ChemrxnbalanceNode) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_balance_node_mean(s : ChemrxnbalanceNode) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_balance_node_scale(s : ChemrxnbalanceNode, f : Double) -> ChemrxnbalanceNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_node_add(a : ChemrxnbalanceNode, b : ChemrxnbalanceNode) -> ChemrxnbalanceNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_balance_node_copy(s : ChemrxnbalanceNode) -> ChemrxnbalanceNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_node_fill(s : ChemrxnbalanceNode, v : Double) -> ChemrxnbalanceNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_node_min(s : ChemrxnbalanceNode) -> Double { @_common.min(s.data) }

pub fn chem_rxn_balance_node_max(s : ChemrxnbalanceNode) -> Double { @_common.max(s.data) }

pub fn chem_rxn_balance_node_to_string(s : ChemrxnbalanceNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnbalanceEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_balance_edge_make(size : Int) -> ChemrxnbalanceEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_balance_edge_len(s : ChemrxnbalanceEdge) -> Int { s.size }

pub fn chem_rxn_balance_edge_get(s : ChemrxnbalanceEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_balance_edge_set(s : ChemrxnbalanceEdge, i : Int, v : Double) -> ChemrxnbalanceEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_edge_sum(s : ChemrxnbalanceEdge) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_balance_edge_mean(s : ChemrxnbalanceEdge) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_balance_edge_scale(s : ChemrxnbalanceEdge, f : Double) -> ChemrxnbalanceEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_edge_add(a : ChemrxnbalanceEdge, b : ChemrxnbalanceEdge) -> ChemrxnbalanceEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_balance_edge_copy(s : ChemrxnbalanceEdge) -> ChemrxnbalanceEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_edge_fill(s : ChemrxnbalanceEdge, v : Double) -> ChemrxnbalanceEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_edge_min(s : ChemrxnbalanceEdge) -> Double { @_common.min(s.data) }

pub fn chem_rxn_balance_edge_max(s : ChemrxnbalanceEdge) -> Double { @_common.max(s.data) }

pub fn chem_rxn_balance_edge_to_string(s : ChemrxnbalanceEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnbalancePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_balance_path_make(size : Int) -> ChemrxnbalancePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_balance_path_len(s : ChemrxnbalancePath) -> Int { s.size }

pub fn chem_rxn_balance_path_get(s : ChemrxnbalancePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_balance_path_set(s : ChemrxnbalancePath, i : Int, v : Double) -> ChemrxnbalancePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_path_sum(s : ChemrxnbalancePath) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_balance_path_mean(s : ChemrxnbalancePath) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_balance_path_scale(s : ChemrxnbalancePath, f : Double) -> ChemrxnbalancePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_path_add(a : ChemrxnbalancePath, b : ChemrxnbalancePath) -> ChemrxnbalancePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_balance_path_copy(s : ChemrxnbalancePath) -> ChemrxnbalancePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_path_fill(s : ChemrxnbalancePath, v : Double) -> ChemrxnbalancePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_path_min(s : ChemrxnbalancePath) -> Double { @_common.min(s.data) }

pub fn chem_rxn_balance_path_max(s : ChemrxnbalancePath) -> Double { @_common.max(s.data) }

pub fn chem_rxn_balance_path_to_string(s : ChemrxnbalancePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnbalanceCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_balance_cluster_make(size : Int) -> ChemrxnbalanceCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_balance_cluster_len(s : ChemrxnbalanceCluster) -> Int { s.size }

pub fn chem_rxn_balance_cluster_get(s : ChemrxnbalanceCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_balance_cluster_set(s : ChemrxnbalanceCluster, i : Int, v : Double) -> ChemrxnbalanceCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_cluster_sum(s : ChemrxnbalanceCluster) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_balance_cluster_mean(s : ChemrxnbalanceCluster) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_balance_cluster_scale(s : ChemrxnbalanceCluster, f : Double) -> ChemrxnbalanceCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_cluster_add(a : ChemrxnbalanceCluster, b : ChemrxnbalanceCluster) -> ChemrxnbalanceCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_balance_cluster_copy(s : ChemrxnbalanceCluster) -> ChemrxnbalanceCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_cluster_fill(s : ChemrxnbalanceCluster, v : Double) -> ChemrxnbalanceCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_cluster_min(s : ChemrxnbalanceCluster) -> Double { @_common.min(s.data) }

pub fn chem_rxn_balance_cluster_max(s : ChemrxnbalanceCluster) -> Double { @_common.max(s.data) }

pub fn chem_rxn_balance_cluster_to_string(s : ChemrxnbalanceCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnbalanceModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_balance_model_make(size : Int) -> ChemrxnbalanceModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_balance_model_len(s : ChemrxnbalanceModel) -> Int { s.size }

pub fn chem_rxn_balance_model_get(s : ChemrxnbalanceModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_balance_model_set(s : ChemrxnbalanceModel, i : Int, v : Double) -> ChemrxnbalanceModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_model_sum(s : ChemrxnbalanceModel) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_balance_model_mean(s : ChemrxnbalanceModel) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_balance_model_scale(s : ChemrxnbalanceModel, f : Double) -> ChemrxnbalanceModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_model_add(a : ChemrxnbalanceModel, b : ChemrxnbalanceModel) -> ChemrxnbalanceModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_balance_model_copy(s : ChemrxnbalanceModel) -> ChemrxnbalanceModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_model_fill(s : ChemrxnbalanceModel, v : Double) -> ChemrxnbalanceModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_model_min(s : ChemrxnbalanceModel) -> Double { @_common.min(s.data) }

pub fn chem_rxn_balance_model_max(s : ChemrxnbalanceModel) -> Double { @_common.max(s.data) }

pub fn chem_rxn_balance_model_to_string(s : ChemrxnbalanceModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnbalanceLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_balance_layer_make(size : Int) -> ChemrxnbalanceLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_balance_layer_len(s : ChemrxnbalanceLayer) -> Int { s.size }

pub fn chem_rxn_balance_layer_get(s : ChemrxnbalanceLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_balance_layer_set(s : ChemrxnbalanceLayer, i : Int, v : Double) -> ChemrxnbalanceLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_layer_sum(s : ChemrxnbalanceLayer) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_balance_layer_mean(s : ChemrxnbalanceLayer) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_balance_layer_scale(s : ChemrxnbalanceLayer, f : Double) -> ChemrxnbalanceLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_layer_add(a : ChemrxnbalanceLayer, b : ChemrxnbalanceLayer) -> ChemrxnbalanceLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_balance_layer_copy(s : ChemrxnbalanceLayer) -> ChemrxnbalanceLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_layer_fill(s : ChemrxnbalanceLayer, v : Double) -> ChemrxnbalanceLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_layer_min(s : ChemrxnbalanceLayer) -> Double { @_common.min(s.data) }

pub fn chem_rxn_balance_layer_max(s : ChemrxnbalanceLayer) -> Double { @_common.max(s.data) }

pub fn chem_rxn_balance_layer_to_string(s : ChemrxnbalanceLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnbalanceBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_balance_buffer_make(size : Int) -> ChemrxnbalanceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_balance_buffer_len(s : ChemrxnbalanceBuffer) -> Int { s.size }

pub fn chem_rxn_balance_buffer_get(s : ChemrxnbalanceBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_balance_buffer_set(s : ChemrxnbalanceBuffer, i : Int, v : Double) -> ChemrxnbalanceBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_buffer_sum(s : ChemrxnbalanceBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_balance_buffer_mean(s : ChemrxnbalanceBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_balance_buffer_scale(s : ChemrxnbalanceBuffer, f : Double) -> ChemrxnbalanceBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_buffer_add(a : ChemrxnbalanceBuffer, b : ChemrxnbalanceBuffer) -> ChemrxnbalanceBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_balance_buffer_copy(s : ChemrxnbalanceBuffer) -> ChemrxnbalanceBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_buffer_fill(s : ChemrxnbalanceBuffer, v : Double) -> ChemrxnbalanceBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_buffer_min(s : ChemrxnbalanceBuffer) -> Double { @_common.min(s.data) }

pub fn chem_rxn_balance_buffer_max(s : ChemrxnbalanceBuffer) -> Double { @_common.max(s.data) }

pub fn chem_rxn_balance_buffer_to_string(s : ChemrxnbalanceBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnbalanceCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_balance_cursor_make(size : Int) -> ChemrxnbalanceCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_balance_cursor_len(s : ChemrxnbalanceCursor) -> Int { s.size }

pub fn chem_rxn_balance_cursor_get(s : ChemrxnbalanceCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_balance_cursor_set(s : ChemrxnbalanceCursor, i : Int, v : Double) -> ChemrxnbalanceCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_cursor_sum(s : ChemrxnbalanceCursor) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_balance_cursor_mean(s : ChemrxnbalanceCursor) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_balance_cursor_scale(s : ChemrxnbalanceCursor, f : Double) -> ChemrxnbalanceCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_cursor_add(a : ChemrxnbalanceCursor, b : ChemrxnbalanceCursor) -> ChemrxnbalanceCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_balance_cursor_copy(s : ChemrxnbalanceCursor) -> ChemrxnbalanceCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_cursor_fill(s : ChemrxnbalanceCursor, v : Double) -> ChemrxnbalanceCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_cursor_min(s : ChemrxnbalanceCursor) -> Double { @_common.min(s.data) }

pub fn chem_rxn_balance_cursor_max(s : ChemrxnbalanceCursor) -> Double { @_common.max(s.data) }

pub fn chem_rxn_balance_cursor_to_string(s : ChemrxnbalanceCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnbalanceView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_balance_view_make(size : Int) -> ChemrxnbalanceView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_balance_view_len(s : ChemrxnbalanceView) -> Int { s.size }

pub fn chem_rxn_balance_view_get(s : ChemrxnbalanceView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_balance_view_set(s : ChemrxnbalanceView, i : Int, v : Double) -> ChemrxnbalanceView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_view_sum(s : ChemrxnbalanceView) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_balance_view_mean(s : ChemrxnbalanceView) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_balance_view_scale(s : ChemrxnbalanceView, f : Double) -> ChemrxnbalanceView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_view_add(a : ChemrxnbalanceView, b : ChemrxnbalanceView) -> ChemrxnbalanceView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_balance_view_copy(s : ChemrxnbalanceView) -> ChemrxnbalanceView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_view_fill(s : ChemrxnbalanceView, v : Double) -> ChemrxnbalanceView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_view_min(s : ChemrxnbalanceView) -> Double { @_common.min(s.data) }

pub fn chem_rxn_balance_view_max(s : ChemrxnbalanceView) -> Double { @_common.max(s.data) }

pub fn chem_rxn_balance_view_to_string(s : ChemrxnbalanceView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnbalanceRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_balance_range_make(size : Int) -> ChemrxnbalanceRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_balance_range_len(s : ChemrxnbalanceRange) -> Int { s.size }

pub fn chem_rxn_balance_range_get(s : ChemrxnbalanceRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_balance_range_set(s : ChemrxnbalanceRange, i : Int, v : Double) -> ChemrxnbalanceRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_range_sum(s : ChemrxnbalanceRange) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_balance_range_mean(s : ChemrxnbalanceRange) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_balance_range_scale(s : ChemrxnbalanceRange, f : Double) -> ChemrxnbalanceRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_range_add(a : ChemrxnbalanceRange, b : ChemrxnbalanceRange) -> ChemrxnbalanceRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_balance_range_copy(s : ChemrxnbalanceRange) -> ChemrxnbalanceRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_range_fill(s : ChemrxnbalanceRange, v : Double) -> ChemrxnbalanceRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_range_min(s : ChemrxnbalanceRange) -> Double { @_common.min(s.data) }

pub fn chem_rxn_balance_range_max(s : ChemrxnbalanceRange) -> Double { @_common.max(s.data) }

pub fn chem_rxn_balance_range_to_string(s : ChemrxnbalanceRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnbalanceSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_balance_slice_make(size : Int) -> ChemrxnbalanceSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_balance_slice_len(s : ChemrxnbalanceSlice) -> Int { s.size }

pub fn chem_rxn_balance_slice_get(s : ChemrxnbalanceSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_balance_slice_set(s : ChemrxnbalanceSlice, i : Int, v : Double) -> ChemrxnbalanceSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_slice_sum(s : ChemrxnbalanceSlice) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_balance_slice_mean(s : ChemrxnbalanceSlice) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_balance_slice_scale(s : ChemrxnbalanceSlice, f : Double) -> ChemrxnbalanceSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_slice_add(a : ChemrxnbalanceSlice, b : ChemrxnbalanceSlice) -> ChemrxnbalanceSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_balance_slice_copy(s : ChemrxnbalanceSlice) -> ChemrxnbalanceSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_slice_fill(s : ChemrxnbalanceSlice, v : Double) -> ChemrxnbalanceSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_balance_slice_min(s : ChemrxnbalanceSlice) -> Double { @_common.min(s.data) }

pub fn chem_rxn_balance_slice_max(s : ChemrxnbalanceSlice) -> Double { @_common.max(s.data) }

pub fn chem_rxn_balance_slice_to_string(s : ChemrxnbalanceSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

