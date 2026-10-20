///===
/// extcore/chem_rxn_selectivity

pub(all) struct ChemrxnselectivityPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_rxn_selectivity_make_point(x : Double, y : Double) -> ChemrxnselectivityPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_rxn_selectivity_make_point3(x : Double, y : Double, z : Double) -> ChemrxnselectivityPoint {
  { x, y, z, label: 0 }
}

pub fn ChemrxnselectivityPoint::x(self : ChemrxnselectivityPoint) -> Double { self.x }

pub fn ChemrxnselectivityPoint::y(self : ChemrxnselectivityPoint) -> Double { self.y }

pub fn ChemrxnselectivityPoint::z(self : ChemrxnselectivityPoint) -> Double { self.z }

pub fn ChemrxnselectivityPoint::label(self : ChemrxnselectivityPoint) -> Int { self.label }

pub fn ChemrxnselectivityPoint::dist(self : ChemrxnselectivityPoint, other : ChemrxnselectivityPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemrxnselectivityPoint::add(self : ChemrxnselectivityPoint, other : ChemrxnselectivityPoint) -> ChemrxnselectivityPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemrxnselectivityPoint::sub(self : ChemrxnselectivityPoint, other : ChemrxnselectivityPoint) -> ChemrxnselectivityPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemrxnselectivityPoint::scale(self : ChemrxnselectivityPoint, s : Double) -> ChemrxnselectivityPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemrxnselectivityPoint::dot(self : ChemrxnselectivityPoint, other : ChemrxnselectivityPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemrxnselectivityPoint::cross(self : ChemrxnselectivityPoint, other : ChemrxnselectivityPoint) -> ChemrxnselectivityPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemrxnselectivityPoint::norm(self : ChemrxnselectivityPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemrxnselectivityPoint::normalize(self : ChemrxnselectivityPoint) -> ChemrxnselectivityPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemrxnselectivityPoint::negate(self : ChemrxnselectivityPoint) -> ChemrxnselectivityPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemrxnselectivityPoint::mid(self : ChemrxnselectivityPoint, other : ChemrxnselectivityPoint) -> ChemrxnselectivityPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemrxnselectivityPoint::lerp(self : ChemrxnselectivityPoint, other : ChemrxnselectivityPoint, t : Double) -> ChemrxnselectivityPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemrxnselectivityPoint::to_string(self : ChemrxnselectivityPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemrxnselectivitySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_rxn_selectivity_make_series(vals : Array[Double], name : String) -> ChemrxnselectivitySeries {
  { vals, name, meta: 0 }
}

pub fn ChemrxnselectivitySeries::len(self : ChemrxnselectivitySeries) -> Int { self.vals.length() }

pub fn ChemrxnselectivitySeries::sum(self : ChemrxnselectivitySeries) -> Double { @_common.sum(self.vals) }

pub fn ChemrxnselectivitySeries::mean(self : ChemrxnselectivitySeries) -> Double { @_common.mean(self.vals) }

pub fn ChemrxnselectivitySeries::min(self : ChemrxnselectivitySeries) -> Double { @_common.min(self.vals) }

pub fn ChemrxnselectivitySeries::max(self : ChemrxnselectivitySeries) -> Double { @_common.max(self.vals) }

pub fn ChemrxnselectivitySeries::range(self : ChemrxnselectivitySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemrxnselectivitySeries::variance(self : ChemrxnselectivitySeries) -> Double { @_common.variance(self.vals) }

pub fn ChemrxnselectivitySeries::std(self : ChemrxnselectivitySeries) -> Double { @_common.std(self.vals) }

pub fn ChemrxnselectivitySeries::median(self : ChemrxnselectivitySeries) -> Double { @_common.median(self.vals) }

pub fn ChemrxnselectivitySeries::scale(self : ChemrxnselectivitySeries, f : Double) -> ChemrxnselectivitySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemrxnselectivitySeries::add(self : ChemrxnselectivitySeries, other : ChemrxnselectivitySeries) -> ChemrxnselectivitySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemrxnselectivitySeries::sub(self : ChemrxnselectivitySeries, other : ChemrxnselectivitySeries) -> ChemrxnselectivitySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemrxnselectivitySeries::normalize(self : ChemrxnselectivitySeries) -> ChemrxnselectivitySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemrxnselectivitySeries::cumsum(self : ChemrxnselectivitySeries) -> ChemrxnselectivitySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemrxnselectivitySeries::to_string(self : ChemrxnselectivitySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemrxnselectivityMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_rxn_selectivity_make_matrix(rows : Int, cols : Int, val : Double) -> ChemrxnselectivityMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_rxn_selectivity_matrix_identity(n : Int) -> ChemrxnselectivityMatrix {
  let m = chem_rxn_selectivity_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemrxnselectivityMatrix::get(self : ChemrxnselectivityMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemrxnselectivityMatrix::transpose(self : ChemrxnselectivityMatrix) -> ChemrxnselectivityMatrix {
  let result = chem_rxn_selectivity_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemrxnselectivityMatrix::add(self : ChemrxnselectivityMatrix, other : ChemrxnselectivityMatrix) -> ChemrxnselectivityMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_rxn_selectivity_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemrxnselectivityMatrix::scale(self : ChemrxnselectivityMatrix, s : Double) -> ChemrxnselectivityMatrix {
  let result = chem_rxn_selectivity_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemrxnselectivityMatrix::multiply(self : ChemrxnselectivityMatrix, other : ChemrxnselectivityMatrix) -> ChemrxnselectivityMatrix {
  if self.cols != other.rows { return chem_rxn_selectivity_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_rxn_selectivity_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ChemrxnselectivityMatrix::trace(self : ChemrxnselectivityMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemrxnselectivityMatrix::det(self : ChemrxnselectivityMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemrxnselectivityMatrix::norm(self : ChemrxnselectivityMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemrxnselectivityMatrix::to_string(self : ChemrxnselectivityMatrix) -> String {
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

pub(all) struct ChemrxnselectivityVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_rxn_selectivity_make_vector(comps : Array[Double]) -> ChemrxnselectivityVector {
  { comps, dim: comps.length() }
}

pub fn chem_rxn_selectivity_vector_zero(dim : Int) -> ChemrxnselectivityVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemrxnselectivityVector::add(self : ChemrxnselectivityVector, other : ChemrxnselectivityVector) -> ChemrxnselectivityVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemrxnselectivityVector::sub(self : ChemrxnselectivityVector, other : ChemrxnselectivityVector) -> ChemrxnselectivityVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemrxnselectivityVector::scale(self : ChemrxnselectivityVector, s : Double) -> ChemrxnselectivityVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemrxnselectivityVector::dot(self : ChemrxnselectivityVector, other : ChemrxnselectivityVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemrxnselectivityVector::norm(self : ChemrxnselectivityVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemrxnselectivityVector::normalize(self : ChemrxnselectivityVector) -> ChemrxnselectivityVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemrxnselectivityVector::dist(self : ChemrxnselectivityVector, other : ChemrxnselectivityVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemrxnselectivityVector::to_string(self : ChemrxnselectivityVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_rxn_selectivity_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_rxn_selectivity_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_rxn_selectivity_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_rxn_selectivity_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_rxn_selectivity_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_rxn_selectivity_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_rxn_selectivity_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_rxn_selectivity_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_rxn_selectivity_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_rxn_selectivity_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_rxn_selectivity_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_rxn_selectivity_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_rxn_selectivity_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_rxn_selectivity_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_rxn_selectivity_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_rxn_selectivity_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_rxn_selectivity_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_rxn_selectivity_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_rxn_selectivity_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_rxn_selectivity_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_rxn_selectivity_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_rxn_selectivity_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_rxn_selectivity_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_rxn_selectivity_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_rxn_selectivity_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_rxn_selectivity_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_rxn_selectivity_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_rxn_selectivity_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_rxn_selectivity_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemrxnselectivityFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_selectivity_frame_make(size : Int) -> ChemrxnselectivityFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_selectivity_frame_len(s : ChemrxnselectivityFrame) -> Int { s.size }

pub fn chem_rxn_selectivity_frame_get(s : ChemrxnselectivityFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_selectivity_frame_set(s : ChemrxnselectivityFrame, i : Int, v : Double) -> ChemrxnselectivityFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_frame_sum(s : ChemrxnselectivityFrame) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_selectivity_frame_mean(s : ChemrxnselectivityFrame) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_selectivity_frame_scale(s : ChemrxnselectivityFrame, f : Double) -> ChemrxnselectivityFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_frame_add(a : ChemrxnselectivityFrame, b : ChemrxnselectivityFrame) -> ChemrxnselectivityFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_selectivity_frame_copy(s : ChemrxnselectivityFrame) -> ChemrxnselectivityFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_frame_fill(s : ChemrxnselectivityFrame, v : Double) -> ChemrxnselectivityFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_frame_min(s : ChemrxnselectivityFrame) -> Double { @_common.min(s.data) }

pub fn chem_rxn_selectivity_frame_max(s : ChemrxnselectivityFrame) -> Double { @_common.max(s.data) }

pub fn chem_rxn_selectivity_frame_to_string(s : ChemrxnselectivityFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnselectivityTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_selectivity_table_make(size : Int) -> ChemrxnselectivityTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_selectivity_table_len(s : ChemrxnselectivityTable) -> Int { s.size }

pub fn chem_rxn_selectivity_table_get(s : ChemrxnselectivityTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_selectivity_table_set(s : ChemrxnselectivityTable, i : Int, v : Double) -> ChemrxnselectivityTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_table_sum(s : ChemrxnselectivityTable) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_selectivity_table_mean(s : ChemrxnselectivityTable) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_selectivity_table_scale(s : ChemrxnselectivityTable, f : Double) -> ChemrxnselectivityTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_table_add(a : ChemrxnselectivityTable, b : ChemrxnselectivityTable) -> ChemrxnselectivityTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_selectivity_table_copy(s : ChemrxnselectivityTable) -> ChemrxnselectivityTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_table_fill(s : ChemrxnselectivityTable, v : Double) -> ChemrxnselectivityTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_table_min(s : ChemrxnselectivityTable) -> Double { @_common.min(s.data) }

pub fn chem_rxn_selectivity_table_max(s : ChemrxnselectivityTable) -> Double { @_common.max(s.data) }

pub fn chem_rxn_selectivity_table_to_string(s : ChemrxnselectivityTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnselectivityGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_selectivity_graphn_make(size : Int) -> ChemrxnselectivityGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_selectivity_graphn_len(s : ChemrxnselectivityGraphN) -> Int { s.size }

pub fn chem_rxn_selectivity_graphn_get(s : ChemrxnselectivityGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_selectivity_graphn_set(s : ChemrxnselectivityGraphN, i : Int, v : Double) -> ChemrxnselectivityGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_graphn_sum(s : ChemrxnselectivityGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_selectivity_graphn_mean(s : ChemrxnselectivityGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_selectivity_graphn_scale(s : ChemrxnselectivityGraphN, f : Double) -> ChemrxnselectivityGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_graphn_add(a : ChemrxnselectivityGraphN, b : ChemrxnselectivityGraphN) -> ChemrxnselectivityGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_selectivity_graphn_copy(s : ChemrxnselectivityGraphN) -> ChemrxnselectivityGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_graphn_fill(s : ChemrxnselectivityGraphN, v : Double) -> ChemrxnselectivityGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_graphn_min(s : ChemrxnselectivityGraphN) -> Double { @_common.min(s.data) }

pub fn chem_rxn_selectivity_graphn_max(s : ChemrxnselectivityGraphN) -> Double { @_common.max(s.data) }

pub fn chem_rxn_selectivity_graphn_to_string(s : ChemrxnselectivityGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnselectivityNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_selectivity_node_make(size : Int) -> ChemrxnselectivityNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_selectivity_node_len(s : ChemrxnselectivityNode) -> Int { s.size }

pub fn chem_rxn_selectivity_node_get(s : ChemrxnselectivityNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_selectivity_node_set(s : ChemrxnselectivityNode, i : Int, v : Double) -> ChemrxnselectivityNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_node_sum(s : ChemrxnselectivityNode) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_selectivity_node_mean(s : ChemrxnselectivityNode) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_selectivity_node_scale(s : ChemrxnselectivityNode, f : Double) -> ChemrxnselectivityNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_node_add(a : ChemrxnselectivityNode, b : ChemrxnselectivityNode) -> ChemrxnselectivityNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_selectivity_node_copy(s : ChemrxnselectivityNode) -> ChemrxnselectivityNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_node_fill(s : ChemrxnselectivityNode, v : Double) -> ChemrxnselectivityNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_node_min(s : ChemrxnselectivityNode) -> Double { @_common.min(s.data) }

pub fn chem_rxn_selectivity_node_max(s : ChemrxnselectivityNode) -> Double { @_common.max(s.data) }

pub fn chem_rxn_selectivity_node_to_string(s : ChemrxnselectivityNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnselectivityEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_selectivity_edge_make(size : Int) -> ChemrxnselectivityEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_selectivity_edge_len(s : ChemrxnselectivityEdge) -> Int { s.size }

pub fn chem_rxn_selectivity_edge_get(s : ChemrxnselectivityEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_selectivity_edge_set(s : ChemrxnselectivityEdge, i : Int, v : Double) -> ChemrxnselectivityEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_edge_sum(s : ChemrxnselectivityEdge) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_selectivity_edge_mean(s : ChemrxnselectivityEdge) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_selectivity_edge_scale(s : ChemrxnselectivityEdge, f : Double) -> ChemrxnselectivityEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_edge_add(a : ChemrxnselectivityEdge, b : ChemrxnselectivityEdge) -> ChemrxnselectivityEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_selectivity_edge_copy(s : ChemrxnselectivityEdge) -> ChemrxnselectivityEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_edge_fill(s : ChemrxnselectivityEdge, v : Double) -> ChemrxnselectivityEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_edge_min(s : ChemrxnselectivityEdge) -> Double { @_common.min(s.data) }

pub fn chem_rxn_selectivity_edge_max(s : ChemrxnselectivityEdge) -> Double { @_common.max(s.data) }

pub fn chem_rxn_selectivity_edge_to_string(s : ChemrxnselectivityEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnselectivityPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_selectivity_path_make(size : Int) -> ChemrxnselectivityPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_selectivity_path_len(s : ChemrxnselectivityPath) -> Int { s.size }

pub fn chem_rxn_selectivity_path_get(s : ChemrxnselectivityPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_selectivity_path_set(s : ChemrxnselectivityPath, i : Int, v : Double) -> ChemrxnselectivityPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_path_sum(s : ChemrxnselectivityPath) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_selectivity_path_mean(s : ChemrxnselectivityPath) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_selectivity_path_scale(s : ChemrxnselectivityPath, f : Double) -> ChemrxnselectivityPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_path_add(a : ChemrxnselectivityPath, b : ChemrxnselectivityPath) -> ChemrxnselectivityPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_selectivity_path_copy(s : ChemrxnselectivityPath) -> ChemrxnselectivityPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_path_fill(s : ChemrxnselectivityPath, v : Double) -> ChemrxnselectivityPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_path_min(s : ChemrxnselectivityPath) -> Double { @_common.min(s.data) }

pub fn chem_rxn_selectivity_path_max(s : ChemrxnselectivityPath) -> Double { @_common.max(s.data) }

pub fn chem_rxn_selectivity_path_to_string(s : ChemrxnselectivityPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnselectivityCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_selectivity_cluster_make(size : Int) -> ChemrxnselectivityCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_selectivity_cluster_len(s : ChemrxnselectivityCluster) -> Int { s.size }

pub fn chem_rxn_selectivity_cluster_get(s : ChemrxnselectivityCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_selectivity_cluster_set(s : ChemrxnselectivityCluster, i : Int, v : Double) -> ChemrxnselectivityCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_cluster_sum(s : ChemrxnselectivityCluster) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_selectivity_cluster_mean(s : ChemrxnselectivityCluster) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_selectivity_cluster_scale(s : ChemrxnselectivityCluster, f : Double) -> ChemrxnselectivityCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_cluster_add(a : ChemrxnselectivityCluster, b : ChemrxnselectivityCluster) -> ChemrxnselectivityCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_selectivity_cluster_copy(s : ChemrxnselectivityCluster) -> ChemrxnselectivityCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_cluster_fill(s : ChemrxnselectivityCluster, v : Double) -> ChemrxnselectivityCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_cluster_min(s : ChemrxnselectivityCluster) -> Double { @_common.min(s.data) }

pub fn chem_rxn_selectivity_cluster_max(s : ChemrxnselectivityCluster) -> Double { @_common.max(s.data) }

pub fn chem_rxn_selectivity_cluster_to_string(s : ChemrxnselectivityCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnselectivityModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_selectivity_model_make(size : Int) -> ChemrxnselectivityModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_selectivity_model_len(s : ChemrxnselectivityModel) -> Int { s.size }

pub fn chem_rxn_selectivity_model_get(s : ChemrxnselectivityModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_selectivity_model_set(s : ChemrxnselectivityModel, i : Int, v : Double) -> ChemrxnselectivityModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_model_sum(s : ChemrxnselectivityModel) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_selectivity_model_mean(s : ChemrxnselectivityModel) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_selectivity_model_scale(s : ChemrxnselectivityModel, f : Double) -> ChemrxnselectivityModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_model_add(a : ChemrxnselectivityModel, b : ChemrxnselectivityModel) -> ChemrxnselectivityModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_selectivity_model_copy(s : ChemrxnselectivityModel) -> ChemrxnselectivityModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_model_fill(s : ChemrxnselectivityModel, v : Double) -> ChemrxnselectivityModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_model_min(s : ChemrxnselectivityModel) -> Double { @_common.min(s.data) }

pub fn chem_rxn_selectivity_model_max(s : ChemrxnselectivityModel) -> Double { @_common.max(s.data) }

pub fn chem_rxn_selectivity_model_to_string(s : ChemrxnselectivityModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnselectivityLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_selectivity_layer_make(size : Int) -> ChemrxnselectivityLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_selectivity_layer_len(s : ChemrxnselectivityLayer) -> Int { s.size }

pub fn chem_rxn_selectivity_layer_get(s : ChemrxnselectivityLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_selectivity_layer_set(s : ChemrxnselectivityLayer, i : Int, v : Double) -> ChemrxnselectivityLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_layer_sum(s : ChemrxnselectivityLayer) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_selectivity_layer_mean(s : ChemrxnselectivityLayer) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_selectivity_layer_scale(s : ChemrxnselectivityLayer, f : Double) -> ChemrxnselectivityLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_layer_add(a : ChemrxnselectivityLayer, b : ChemrxnselectivityLayer) -> ChemrxnselectivityLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_selectivity_layer_copy(s : ChemrxnselectivityLayer) -> ChemrxnselectivityLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_layer_fill(s : ChemrxnselectivityLayer, v : Double) -> ChemrxnselectivityLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_layer_min(s : ChemrxnselectivityLayer) -> Double { @_common.min(s.data) }

pub fn chem_rxn_selectivity_layer_max(s : ChemrxnselectivityLayer) -> Double { @_common.max(s.data) }

pub fn chem_rxn_selectivity_layer_to_string(s : ChemrxnselectivityLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnselectivityBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_selectivity_buffer_make(size : Int) -> ChemrxnselectivityBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_selectivity_buffer_len(s : ChemrxnselectivityBuffer) -> Int { s.size }

pub fn chem_rxn_selectivity_buffer_get(s : ChemrxnselectivityBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_selectivity_buffer_set(s : ChemrxnselectivityBuffer, i : Int, v : Double) -> ChemrxnselectivityBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_buffer_sum(s : ChemrxnselectivityBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_selectivity_buffer_mean(s : ChemrxnselectivityBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_selectivity_buffer_scale(s : ChemrxnselectivityBuffer, f : Double) -> ChemrxnselectivityBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_buffer_add(a : ChemrxnselectivityBuffer, b : ChemrxnselectivityBuffer) -> ChemrxnselectivityBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_selectivity_buffer_copy(s : ChemrxnselectivityBuffer) -> ChemrxnselectivityBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_buffer_fill(s : ChemrxnselectivityBuffer, v : Double) -> ChemrxnselectivityBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_buffer_min(s : ChemrxnselectivityBuffer) -> Double { @_common.min(s.data) }

pub fn chem_rxn_selectivity_buffer_max(s : ChemrxnselectivityBuffer) -> Double { @_common.max(s.data) }

pub fn chem_rxn_selectivity_buffer_to_string(s : ChemrxnselectivityBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnselectivityCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_selectivity_cursor_make(size : Int) -> ChemrxnselectivityCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_selectivity_cursor_len(s : ChemrxnselectivityCursor) -> Int { s.size }

pub fn chem_rxn_selectivity_cursor_get(s : ChemrxnselectivityCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_selectivity_cursor_set(s : ChemrxnselectivityCursor, i : Int, v : Double) -> ChemrxnselectivityCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_cursor_sum(s : ChemrxnselectivityCursor) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_selectivity_cursor_mean(s : ChemrxnselectivityCursor) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_selectivity_cursor_scale(s : ChemrxnselectivityCursor, f : Double) -> ChemrxnselectivityCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_cursor_add(a : ChemrxnselectivityCursor, b : ChemrxnselectivityCursor) -> ChemrxnselectivityCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_selectivity_cursor_copy(s : ChemrxnselectivityCursor) -> ChemrxnselectivityCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_cursor_fill(s : ChemrxnselectivityCursor, v : Double) -> ChemrxnselectivityCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_cursor_min(s : ChemrxnselectivityCursor) -> Double { @_common.min(s.data) }

pub fn chem_rxn_selectivity_cursor_max(s : ChemrxnselectivityCursor) -> Double { @_common.max(s.data) }

pub fn chem_rxn_selectivity_cursor_to_string(s : ChemrxnselectivityCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnselectivityView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_selectivity_view_make(size : Int) -> ChemrxnselectivityView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_selectivity_view_len(s : ChemrxnselectivityView) -> Int { s.size }

pub fn chem_rxn_selectivity_view_get(s : ChemrxnselectivityView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_selectivity_view_set(s : ChemrxnselectivityView, i : Int, v : Double) -> ChemrxnselectivityView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_view_sum(s : ChemrxnselectivityView) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_selectivity_view_mean(s : ChemrxnselectivityView) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_selectivity_view_scale(s : ChemrxnselectivityView, f : Double) -> ChemrxnselectivityView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_view_add(a : ChemrxnselectivityView, b : ChemrxnselectivityView) -> ChemrxnselectivityView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_selectivity_view_copy(s : ChemrxnselectivityView) -> ChemrxnselectivityView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_view_fill(s : ChemrxnselectivityView, v : Double) -> ChemrxnselectivityView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_view_min(s : ChemrxnselectivityView) -> Double { @_common.min(s.data) }

pub fn chem_rxn_selectivity_view_max(s : ChemrxnselectivityView) -> Double { @_common.max(s.data) }

pub fn chem_rxn_selectivity_view_to_string(s : ChemrxnselectivityView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnselectivityRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_selectivity_range_make(size : Int) -> ChemrxnselectivityRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_selectivity_range_len(s : ChemrxnselectivityRange) -> Int { s.size }

pub fn chem_rxn_selectivity_range_get(s : ChemrxnselectivityRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_selectivity_range_set(s : ChemrxnselectivityRange, i : Int, v : Double) -> ChemrxnselectivityRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_range_sum(s : ChemrxnselectivityRange) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_selectivity_range_mean(s : ChemrxnselectivityRange) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_selectivity_range_scale(s : ChemrxnselectivityRange, f : Double) -> ChemrxnselectivityRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_range_add(a : ChemrxnselectivityRange, b : ChemrxnselectivityRange) -> ChemrxnselectivityRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_selectivity_range_copy(s : ChemrxnselectivityRange) -> ChemrxnselectivityRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_range_fill(s : ChemrxnselectivityRange, v : Double) -> ChemrxnselectivityRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_range_min(s : ChemrxnselectivityRange) -> Double { @_common.min(s.data) }

pub fn chem_rxn_selectivity_range_max(s : ChemrxnselectivityRange) -> Double { @_common.max(s.data) }

pub fn chem_rxn_selectivity_range_to_string(s : ChemrxnselectivityRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnselectivitySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_selectivity_slice_make(size : Int) -> ChemrxnselectivitySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_selectivity_slice_len(s : ChemrxnselectivitySlice) -> Int { s.size }

pub fn chem_rxn_selectivity_slice_get(s : ChemrxnselectivitySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_selectivity_slice_set(s : ChemrxnselectivitySlice, i : Int, v : Double) -> ChemrxnselectivitySlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_slice_sum(s : ChemrxnselectivitySlice) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_selectivity_slice_mean(s : ChemrxnselectivitySlice) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_selectivity_slice_scale(s : ChemrxnselectivitySlice, f : Double) -> ChemrxnselectivitySlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_slice_add(a : ChemrxnselectivitySlice, b : ChemrxnselectivitySlice) -> ChemrxnselectivitySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_selectivity_slice_copy(s : ChemrxnselectivitySlice) -> ChemrxnselectivitySlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_slice_fill(s : ChemrxnselectivitySlice, v : Double) -> ChemrxnselectivitySlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_selectivity_slice_min(s : ChemrxnselectivitySlice) -> Double { @_common.min(s.data) }

pub fn chem_rxn_selectivity_slice_max(s : ChemrxnselectivitySlice) -> Double { @_common.max(s.data) }

pub fn chem_rxn_selectivity_slice_to_string(s : ChemrxnselectivitySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

