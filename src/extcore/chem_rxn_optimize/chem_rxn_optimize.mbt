///===
/// extcore/chem_rxn_optimize

pub(all) struct ChemrxnoptimizePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_rxn_optimize_make_point(x : Double, y : Double) -> ChemrxnoptimizePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_rxn_optimize_make_point3(x : Double, y : Double, z : Double) -> ChemrxnoptimizePoint {
  { x, y, z, label: 0 }
}

pub fn ChemrxnoptimizePoint::x(self : ChemrxnoptimizePoint) -> Double { self.x }

pub fn ChemrxnoptimizePoint::y(self : ChemrxnoptimizePoint) -> Double { self.y }

pub fn ChemrxnoptimizePoint::z(self : ChemrxnoptimizePoint) -> Double { self.z }

pub fn ChemrxnoptimizePoint::label(self : ChemrxnoptimizePoint) -> Int { self.label }

pub fn ChemrxnoptimizePoint::dist(self : ChemrxnoptimizePoint, other : ChemrxnoptimizePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemrxnoptimizePoint::add(self : ChemrxnoptimizePoint, other : ChemrxnoptimizePoint) -> ChemrxnoptimizePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemrxnoptimizePoint::sub(self : ChemrxnoptimizePoint, other : ChemrxnoptimizePoint) -> ChemrxnoptimizePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemrxnoptimizePoint::scale(self : ChemrxnoptimizePoint, s : Double) -> ChemrxnoptimizePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemrxnoptimizePoint::dot(self : ChemrxnoptimizePoint, other : ChemrxnoptimizePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemrxnoptimizePoint::cross(self : ChemrxnoptimizePoint, other : ChemrxnoptimizePoint) -> ChemrxnoptimizePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemrxnoptimizePoint::norm(self : ChemrxnoptimizePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemrxnoptimizePoint::normalize(self : ChemrxnoptimizePoint) -> ChemrxnoptimizePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemrxnoptimizePoint::negate(self : ChemrxnoptimizePoint) -> ChemrxnoptimizePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemrxnoptimizePoint::mid(self : ChemrxnoptimizePoint, other : ChemrxnoptimizePoint) -> ChemrxnoptimizePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemrxnoptimizePoint::lerp(self : ChemrxnoptimizePoint, other : ChemrxnoptimizePoint, t : Double) -> ChemrxnoptimizePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemrxnoptimizePoint::to_string(self : ChemrxnoptimizePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_rxn_optimize_make_series(vals : Array[Double], name : String) -> ChemrxnoptimizeSeries {
  { vals, name, meta: 0 }
}

pub fn ChemrxnoptimizeSeries::len(self : ChemrxnoptimizeSeries) -> Int { self.vals.length() }

pub fn ChemrxnoptimizeSeries::sum(self : ChemrxnoptimizeSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemrxnoptimizeSeries::mean(self : ChemrxnoptimizeSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemrxnoptimizeSeries::min(self : ChemrxnoptimizeSeries) -> Double { @_common.min(self.vals) }

pub fn ChemrxnoptimizeSeries::max(self : ChemrxnoptimizeSeries) -> Double { @_common.max(self.vals) }

pub fn ChemrxnoptimizeSeries::range(self : ChemrxnoptimizeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemrxnoptimizeSeries::variance(self : ChemrxnoptimizeSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemrxnoptimizeSeries::std(self : ChemrxnoptimizeSeries) -> Double { @_common.std(self.vals) }

pub fn ChemrxnoptimizeSeries::median(self : ChemrxnoptimizeSeries) -> Double { @_common.median(self.vals) }

pub fn ChemrxnoptimizeSeries::scale(self : ChemrxnoptimizeSeries, f : Double) -> ChemrxnoptimizeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemrxnoptimizeSeries::add(self : ChemrxnoptimizeSeries, other : ChemrxnoptimizeSeries) -> ChemrxnoptimizeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemrxnoptimizeSeries::sub(self : ChemrxnoptimizeSeries, other : ChemrxnoptimizeSeries) -> ChemrxnoptimizeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemrxnoptimizeSeries::normalize(self : ChemrxnoptimizeSeries) -> ChemrxnoptimizeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemrxnoptimizeSeries::cumsum(self : ChemrxnoptimizeSeries) -> ChemrxnoptimizeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemrxnoptimizeSeries::to_string(self : ChemrxnoptimizeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemrxnoptimizeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_rxn_optimize_make_matrix(rows : Int, cols : Int, val : Double) -> ChemrxnoptimizeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_rxn_optimize_matrix_identity(n : Int) -> ChemrxnoptimizeMatrix {
  let m = chem_rxn_optimize_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemrxnoptimizeMatrix::get(self : ChemrxnoptimizeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemrxnoptimizeMatrix::transpose(self : ChemrxnoptimizeMatrix) -> ChemrxnoptimizeMatrix {
  let result = chem_rxn_optimize_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemrxnoptimizeMatrix::add(self : ChemrxnoptimizeMatrix, other : ChemrxnoptimizeMatrix) -> ChemrxnoptimizeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_rxn_optimize_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemrxnoptimizeMatrix::scale(self : ChemrxnoptimizeMatrix, s : Double) -> ChemrxnoptimizeMatrix {
  let result = chem_rxn_optimize_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemrxnoptimizeMatrix::multiply(self : ChemrxnoptimizeMatrix, other : ChemrxnoptimizeMatrix) -> ChemrxnoptimizeMatrix {
  if self.cols != other.rows { return chem_rxn_optimize_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_rxn_optimize_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ChemrxnoptimizeMatrix::trace(self : ChemrxnoptimizeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemrxnoptimizeMatrix::det(self : ChemrxnoptimizeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemrxnoptimizeMatrix::norm(self : ChemrxnoptimizeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemrxnoptimizeMatrix::to_string(self : ChemrxnoptimizeMatrix) -> String {
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

pub(all) struct ChemrxnoptimizeVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_rxn_optimize_make_vector(comps : Array[Double]) -> ChemrxnoptimizeVector {
  { comps, dim: comps.length() }
}

pub fn chem_rxn_optimize_vector_zero(dim : Int) -> ChemrxnoptimizeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemrxnoptimizeVector::add(self : ChemrxnoptimizeVector, other : ChemrxnoptimizeVector) -> ChemrxnoptimizeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemrxnoptimizeVector::sub(self : ChemrxnoptimizeVector, other : ChemrxnoptimizeVector) -> ChemrxnoptimizeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemrxnoptimizeVector::scale(self : ChemrxnoptimizeVector, s : Double) -> ChemrxnoptimizeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemrxnoptimizeVector::dot(self : ChemrxnoptimizeVector, other : ChemrxnoptimizeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemrxnoptimizeVector::norm(self : ChemrxnoptimizeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemrxnoptimizeVector::normalize(self : ChemrxnoptimizeVector) -> ChemrxnoptimizeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemrxnoptimizeVector::dist(self : ChemrxnoptimizeVector, other : ChemrxnoptimizeVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemrxnoptimizeVector::to_string(self : ChemrxnoptimizeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_rxn_optimize_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_rxn_optimize_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_rxn_optimize_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_rxn_optimize_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_rxn_optimize_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_rxn_optimize_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_rxn_optimize_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_rxn_optimize_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_rxn_optimize_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_rxn_optimize_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_rxn_optimize_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_rxn_optimize_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_rxn_optimize_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_rxn_optimize_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_rxn_optimize_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_rxn_optimize_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_rxn_optimize_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_rxn_optimize_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_rxn_optimize_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_rxn_optimize_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_rxn_optimize_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_rxn_optimize_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_rxn_optimize_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_rxn_optimize_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_rxn_optimize_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_rxn_optimize_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_rxn_optimize_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_rxn_optimize_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_rxn_optimize_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemrxnoptimizeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_frame_make(size : Int) -> ChemrxnoptimizeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_optimize_frame_len(s : ChemrxnoptimizeFrame) -> Int { s.size }

pub fn chem_rxn_optimize_frame_get(s : ChemrxnoptimizeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_optimize_frame_set(s : ChemrxnoptimizeFrame, i : Int, v : Double) -> ChemrxnoptimizeFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_frame_sum(s : ChemrxnoptimizeFrame) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_optimize_frame_mean(s : ChemrxnoptimizeFrame) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_optimize_frame_scale(s : ChemrxnoptimizeFrame, f : Double) -> ChemrxnoptimizeFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_frame_add(a : ChemrxnoptimizeFrame, b : ChemrxnoptimizeFrame) -> ChemrxnoptimizeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_optimize_frame_copy(s : ChemrxnoptimizeFrame) -> ChemrxnoptimizeFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_frame_fill(s : ChemrxnoptimizeFrame, v : Double) -> ChemrxnoptimizeFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_frame_min(s : ChemrxnoptimizeFrame) -> Double { @_common.min(s.data) }

pub fn chem_rxn_optimize_frame_max(s : ChemrxnoptimizeFrame) -> Double { @_common.max(s.data) }

pub fn chem_rxn_optimize_frame_to_string(s : ChemrxnoptimizeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_table_make(size : Int) -> ChemrxnoptimizeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_optimize_table_len(s : ChemrxnoptimizeTable) -> Int { s.size }

pub fn chem_rxn_optimize_table_get(s : ChemrxnoptimizeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_optimize_table_set(s : ChemrxnoptimizeTable, i : Int, v : Double) -> ChemrxnoptimizeTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_table_sum(s : ChemrxnoptimizeTable) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_optimize_table_mean(s : ChemrxnoptimizeTable) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_optimize_table_scale(s : ChemrxnoptimizeTable, f : Double) -> ChemrxnoptimizeTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_table_add(a : ChemrxnoptimizeTable, b : ChemrxnoptimizeTable) -> ChemrxnoptimizeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_optimize_table_copy(s : ChemrxnoptimizeTable) -> ChemrxnoptimizeTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_table_fill(s : ChemrxnoptimizeTable, v : Double) -> ChemrxnoptimizeTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_table_min(s : ChemrxnoptimizeTable) -> Double { @_common.min(s.data) }

pub fn chem_rxn_optimize_table_max(s : ChemrxnoptimizeTable) -> Double { @_common.max(s.data) }

pub fn chem_rxn_optimize_table_to_string(s : ChemrxnoptimizeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_graphn_make(size : Int) -> ChemrxnoptimizeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_optimize_graphn_len(s : ChemrxnoptimizeGraphN) -> Int { s.size }

pub fn chem_rxn_optimize_graphn_get(s : ChemrxnoptimizeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_optimize_graphn_set(s : ChemrxnoptimizeGraphN, i : Int, v : Double) -> ChemrxnoptimizeGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_graphn_sum(s : ChemrxnoptimizeGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_optimize_graphn_mean(s : ChemrxnoptimizeGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_optimize_graphn_scale(s : ChemrxnoptimizeGraphN, f : Double) -> ChemrxnoptimizeGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_graphn_add(a : ChemrxnoptimizeGraphN, b : ChemrxnoptimizeGraphN) -> ChemrxnoptimizeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_optimize_graphn_copy(s : ChemrxnoptimizeGraphN) -> ChemrxnoptimizeGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_graphn_fill(s : ChemrxnoptimizeGraphN, v : Double) -> ChemrxnoptimizeGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_graphn_min(s : ChemrxnoptimizeGraphN) -> Double { @_common.min(s.data) }

pub fn chem_rxn_optimize_graphn_max(s : ChemrxnoptimizeGraphN) -> Double { @_common.max(s.data) }

pub fn chem_rxn_optimize_graphn_to_string(s : ChemrxnoptimizeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_node_make(size : Int) -> ChemrxnoptimizeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_optimize_node_len(s : ChemrxnoptimizeNode) -> Int { s.size }

pub fn chem_rxn_optimize_node_get(s : ChemrxnoptimizeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_optimize_node_set(s : ChemrxnoptimizeNode, i : Int, v : Double) -> ChemrxnoptimizeNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_node_sum(s : ChemrxnoptimizeNode) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_optimize_node_mean(s : ChemrxnoptimizeNode) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_optimize_node_scale(s : ChemrxnoptimizeNode, f : Double) -> ChemrxnoptimizeNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_node_add(a : ChemrxnoptimizeNode, b : ChemrxnoptimizeNode) -> ChemrxnoptimizeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_optimize_node_copy(s : ChemrxnoptimizeNode) -> ChemrxnoptimizeNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_node_fill(s : ChemrxnoptimizeNode, v : Double) -> ChemrxnoptimizeNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_node_min(s : ChemrxnoptimizeNode) -> Double { @_common.min(s.data) }

pub fn chem_rxn_optimize_node_max(s : ChemrxnoptimizeNode) -> Double { @_common.max(s.data) }

pub fn chem_rxn_optimize_node_to_string(s : ChemrxnoptimizeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_edge_make(size : Int) -> ChemrxnoptimizeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_optimize_edge_len(s : ChemrxnoptimizeEdge) -> Int { s.size }

pub fn chem_rxn_optimize_edge_get(s : ChemrxnoptimizeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_optimize_edge_set(s : ChemrxnoptimizeEdge, i : Int, v : Double) -> ChemrxnoptimizeEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_edge_sum(s : ChemrxnoptimizeEdge) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_optimize_edge_mean(s : ChemrxnoptimizeEdge) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_optimize_edge_scale(s : ChemrxnoptimizeEdge, f : Double) -> ChemrxnoptimizeEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_edge_add(a : ChemrxnoptimizeEdge, b : ChemrxnoptimizeEdge) -> ChemrxnoptimizeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_optimize_edge_copy(s : ChemrxnoptimizeEdge) -> ChemrxnoptimizeEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_edge_fill(s : ChemrxnoptimizeEdge, v : Double) -> ChemrxnoptimizeEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_edge_min(s : ChemrxnoptimizeEdge) -> Double { @_common.min(s.data) }

pub fn chem_rxn_optimize_edge_max(s : ChemrxnoptimizeEdge) -> Double { @_common.max(s.data) }

pub fn chem_rxn_optimize_edge_to_string(s : ChemrxnoptimizeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_path_make(size : Int) -> ChemrxnoptimizePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_optimize_path_len(s : ChemrxnoptimizePath) -> Int { s.size }

pub fn chem_rxn_optimize_path_get(s : ChemrxnoptimizePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_optimize_path_set(s : ChemrxnoptimizePath, i : Int, v : Double) -> ChemrxnoptimizePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_path_sum(s : ChemrxnoptimizePath) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_optimize_path_mean(s : ChemrxnoptimizePath) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_optimize_path_scale(s : ChemrxnoptimizePath, f : Double) -> ChemrxnoptimizePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_path_add(a : ChemrxnoptimizePath, b : ChemrxnoptimizePath) -> ChemrxnoptimizePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_optimize_path_copy(s : ChemrxnoptimizePath) -> ChemrxnoptimizePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_path_fill(s : ChemrxnoptimizePath, v : Double) -> ChemrxnoptimizePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_path_min(s : ChemrxnoptimizePath) -> Double { @_common.min(s.data) }

pub fn chem_rxn_optimize_path_max(s : ChemrxnoptimizePath) -> Double { @_common.max(s.data) }

pub fn chem_rxn_optimize_path_to_string(s : ChemrxnoptimizePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_cluster_make(size : Int) -> ChemrxnoptimizeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_optimize_cluster_len(s : ChemrxnoptimizeCluster) -> Int { s.size }

pub fn chem_rxn_optimize_cluster_get(s : ChemrxnoptimizeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_optimize_cluster_set(s : ChemrxnoptimizeCluster, i : Int, v : Double) -> ChemrxnoptimizeCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_cluster_sum(s : ChemrxnoptimizeCluster) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_optimize_cluster_mean(s : ChemrxnoptimizeCluster) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_optimize_cluster_scale(s : ChemrxnoptimizeCluster, f : Double) -> ChemrxnoptimizeCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_cluster_add(a : ChemrxnoptimizeCluster, b : ChemrxnoptimizeCluster) -> ChemrxnoptimizeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_optimize_cluster_copy(s : ChemrxnoptimizeCluster) -> ChemrxnoptimizeCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_cluster_fill(s : ChemrxnoptimizeCluster, v : Double) -> ChemrxnoptimizeCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_cluster_min(s : ChemrxnoptimizeCluster) -> Double { @_common.min(s.data) }

pub fn chem_rxn_optimize_cluster_max(s : ChemrxnoptimizeCluster) -> Double { @_common.max(s.data) }

pub fn chem_rxn_optimize_cluster_to_string(s : ChemrxnoptimizeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_model_make(size : Int) -> ChemrxnoptimizeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_optimize_model_len(s : ChemrxnoptimizeModel) -> Int { s.size }

pub fn chem_rxn_optimize_model_get(s : ChemrxnoptimizeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_optimize_model_set(s : ChemrxnoptimizeModel, i : Int, v : Double) -> ChemrxnoptimizeModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_model_sum(s : ChemrxnoptimizeModel) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_optimize_model_mean(s : ChemrxnoptimizeModel) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_optimize_model_scale(s : ChemrxnoptimizeModel, f : Double) -> ChemrxnoptimizeModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_model_add(a : ChemrxnoptimizeModel, b : ChemrxnoptimizeModel) -> ChemrxnoptimizeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_optimize_model_copy(s : ChemrxnoptimizeModel) -> ChemrxnoptimizeModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_model_fill(s : ChemrxnoptimizeModel, v : Double) -> ChemrxnoptimizeModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_model_min(s : ChemrxnoptimizeModel) -> Double { @_common.min(s.data) }

pub fn chem_rxn_optimize_model_max(s : ChemrxnoptimizeModel) -> Double { @_common.max(s.data) }

pub fn chem_rxn_optimize_model_to_string(s : ChemrxnoptimizeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_layer_make(size : Int) -> ChemrxnoptimizeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_optimize_layer_len(s : ChemrxnoptimizeLayer) -> Int { s.size }

pub fn chem_rxn_optimize_layer_get(s : ChemrxnoptimizeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_optimize_layer_set(s : ChemrxnoptimizeLayer, i : Int, v : Double) -> ChemrxnoptimizeLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_layer_sum(s : ChemrxnoptimizeLayer) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_optimize_layer_mean(s : ChemrxnoptimizeLayer) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_optimize_layer_scale(s : ChemrxnoptimizeLayer, f : Double) -> ChemrxnoptimizeLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_layer_add(a : ChemrxnoptimizeLayer, b : ChemrxnoptimizeLayer) -> ChemrxnoptimizeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_optimize_layer_copy(s : ChemrxnoptimizeLayer) -> ChemrxnoptimizeLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_layer_fill(s : ChemrxnoptimizeLayer, v : Double) -> ChemrxnoptimizeLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_layer_min(s : ChemrxnoptimizeLayer) -> Double { @_common.min(s.data) }

pub fn chem_rxn_optimize_layer_max(s : ChemrxnoptimizeLayer) -> Double { @_common.max(s.data) }

pub fn chem_rxn_optimize_layer_to_string(s : ChemrxnoptimizeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_buffer_make(size : Int) -> ChemrxnoptimizeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_optimize_buffer_len(s : ChemrxnoptimizeBuffer) -> Int { s.size }

pub fn chem_rxn_optimize_buffer_get(s : ChemrxnoptimizeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_optimize_buffer_set(s : ChemrxnoptimizeBuffer, i : Int, v : Double) -> ChemrxnoptimizeBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_buffer_sum(s : ChemrxnoptimizeBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_optimize_buffer_mean(s : ChemrxnoptimizeBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_optimize_buffer_scale(s : ChemrxnoptimizeBuffer, f : Double) -> ChemrxnoptimizeBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_buffer_add(a : ChemrxnoptimizeBuffer, b : ChemrxnoptimizeBuffer) -> ChemrxnoptimizeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_optimize_buffer_copy(s : ChemrxnoptimizeBuffer) -> ChemrxnoptimizeBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_buffer_fill(s : ChemrxnoptimizeBuffer, v : Double) -> ChemrxnoptimizeBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_buffer_min(s : ChemrxnoptimizeBuffer) -> Double { @_common.min(s.data) }

pub fn chem_rxn_optimize_buffer_max(s : ChemrxnoptimizeBuffer) -> Double { @_common.max(s.data) }

pub fn chem_rxn_optimize_buffer_to_string(s : ChemrxnoptimizeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_cursor_make(size : Int) -> ChemrxnoptimizeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_optimize_cursor_len(s : ChemrxnoptimizeCursor) -> Int { s.size }

pub fn chem_rxn_optimize_cursor_get(s : ChemrxnoptimizeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_optimize_cursor_set(s : ChemrxnoptimizeCursor, i : Int, v : Double) -> ChemrxnoptimizeCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_cursor_sum(s : ChemrxnoptimizeCursor) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_optimize_cursor_mean(s : ChemrxnoptimizeCursor) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_optimize_cursor_scale(s : ChemrxnoptimizeCursor, f : Double) -> ChemrxnoptimizeCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_cursor_add(a : ChemrxnoptimizeCursor, b : ChemrxnoptimizeCursor) -> ChemrxnoptimizeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_optimize_cursor_copy(s : ChemrxnoptimizeCursor) -> ChemrxnoptimizeCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_cursor_fill(s : ChemrxnoptimizeCursor, v : Double) -> ChemrxnoptimizeCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_cursor_min(s : ChemrxnoptimizeCursor) -> Double { @_common.min(s.data) }

pub fn chem_rxn_optimize_cursor_max(s : ChemrxnoptimizeCursor) -> Double { @_common.max(s.data) }

pub fn chem_rxn_optimize_cursor_to_string(s : ChemrxnoptimizeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_view_make(size : Int) -> ChemrxnoptimizeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_optimize_view_len(s : ChemrxnoptimizeView) -> Int { s.size }

pub fn chem_rxn_optimize_view_get(s : ChemrxnoptimizeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_optimize_view_set(s : ChemrxnoptimizeView, i : Int, v : Double) -> ChemrxnoptimizeView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_view_sum(s : ChemrxnoptimizeView) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_optimize_view_mean(s : ChemrxnoptimizeView) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_optimize_view_scale(s : ChemrxnoptimizeView, f : Double) -> ChemrxnoptimizeView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_view_add(a : ChemrxnoptimizeView, b : ChemrxnoptimizeView) -> ChemrxnoptimizeView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_optimize_view_copy(s : ChemrxnoptimizeView) -> ChemrxnoptimizeView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_view_fill(s : ChemrxnoptimizeView, v : Double) -> ChemrxnoptimizeView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_view_min(s : ChemrxnoptimizeView) -> Double { @_common.min(s.data) }

pub fn chem_rxn_optimize_view_max(s : ChemrxnoptimizeView) -> Double { @_common.max(s.data) }

pub fn chem_rxn_optimize_view_to_string(s : ChemrxnoptimizeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_range_make(size : Int) -> ChemrxnoptimizeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_optimize_range_len(s : ChemrxnoptimizeRange) -> Int { s.size }

pub fn chem_rxn_optimize_range_get(s : ChemrxnoptimizeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_optimize_range_set(s : ChemrxnoptimizeRange, i : Int, v : Double) -> ChemrxnoptimizeRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_range_sum(s : ChemrxnoptimizeRange) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_optimize_range_mean(s : ChemrxnoptimizeRange) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_optimize_range_scale(s : ChemrxnoptimizeRange, f : Double) -> ChemrxnoptimizeRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_range_add(a : ChemrxnoptimizeRange, b : ChemrxnoptimizeRange) -> ChemrxnoptimizeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_optimize_range_copy(s : ChemrxnoptimizeRange) -> ChemrxnoptimizeRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_range_fill(s : ChemrxnoptimizeRange, v : Double) -> ChemrxnoptimizeRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_range_min(s : ChemrxnoptimizeRange) -> Double { @_common.min(s.data) }

pub fn chem_rxn_optimize_range_max(s : ChemrxnoptimizeRange) -> Double { @_common.max(s.data) }

pub fn chem_rxn_optimize_range_to_string(s : ChemrxnoptimizeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_slice_make(size : Int) -> ChemrxnoptimizeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_optimize_slice_len(s : ChemrxnoptimizeSlice) -> Int { s.size }

pub fn chem_rxn_optimize_slice_get(s : ChemrxnoptimizeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_optimize_slice_set(s : ChemrxnoptimizeSlice, i : Int, v : Double) -> ChemrxnoptimizeSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_slice_sum(s : ChemrxnoptimizeSlice) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_optimize_slice_mean(s : ChemrxnoptimizeSlice) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_optimize_slice_scale(s : ChemrxnoptimizeSlice, f : Double) -> ChemrxnoptimizeSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_slice_add(a : ChemrxnoptimizeSlice, b : ChemrxnoptimizeSlice) -> ChemrxnoptimizeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_optimize_slice_copy(s : ChemrxnoptimizeSlice) -> ChemrxnoptimizeSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_slice_fill(s : ChemrxnoptimizeSlice, v : Double) -> ChemrxnoptimizeSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_optimize_slice_min(s : ChemrxnoptimizeSlice) -> Double { @_common.min(s.data) }

pub fn chem_rxn_optimize_slice_max(s : ChemrxnoptimizeSlice) -> Double { @_common.max(s.data) }

pub fn chem_rxn_optimize_slice_to_string(s : ChemrxnoptimizeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

