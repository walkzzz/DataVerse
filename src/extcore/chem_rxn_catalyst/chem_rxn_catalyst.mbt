///===
/// extcore/chem_rxn_catalyst

pub(all) struct ChemrxncatalystPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_rxn_catalyst_make_point(x : Double, y : Double) -> ChemrxncatalystPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_rxn_catalyst_make_point3(x : Double, y : Double, z : Double) -> ChemrxncatalystPoint {
  { x, y, z, label: 0 }
}

pub fn ChemrxncatalystPoint::x(self : ChemrxncatalystPoint) -> Double { self.x }

pub fn ChemrxncatalystPoint::y(self : ChemrxncatalystPoint) -> Double { self.y }

pub fn ChemrxncatalystPoint::z(self : ChemrxncatalystPoint) -> Double { self.z }

pub fn ChemrxncatalystPoint::label(self : ChemrxncatalystPoint) -> Int { self.label }

pub fn ChemrxncatalystPoint::dist(self : ChemrxncatalystPoint, other : ChemrxncatalystPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemrxncatalystPoint::add(self : ChemrxncatalystPoint, other : ChemrxncatalystPoint) -> ChemrxncatalystPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemrxncatalystPoint::sub(self : ChemrxncatalystPoint, other : ChemrxncatalystPoint) -> ChemrxncatalystPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemrxncatalystPoint::scale(self : ChemrxncatalystPoint, s : Double) -> ChemrxncatalystPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemrxncatalystPoint::dot(self : ChemrxncatalystPoint, other : ChemrxncatalystPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemrxncatalystPoint::cross(self : ChemrxncatalystPoint, other : ChemrxncatalystPoint) -> ChemrxncatalystPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemrxncatalystPoint::norm(self : ChemrxncatalystPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemrxncatalystPoint::normalize(self : ChemrxncatalystPoint) -> ChemrxncatalystPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemrxncatalystPoint::negate(self : ChemrxncatalystPoint) -> ChemrxncatalystPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemrxncatalystPoint::mid(self : ChemrxncatalystPoint, other : ChemrxncatalystPoint) -> ChemrxncatalystPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemrxncatalystPoint::lerp(self : ChemrxncatalystPoint, other : ChemrxncatalystPoint, t : Double) -> ChemrxncatalystPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemrxncatalystPoint::to_string(self : ChemrxncatalystPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemrxncatalystSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_rxn_catalyst_make_series(vals : Array[Double], name : String) -> ChemrxncatalystSeries {
  { vals, name, meta: 0 }
}

pub fn ChemrxncatalystSeries::len(self : ChemrxncatalystSeries) -> Int { self.vals.length() }

pub fn ChemrxncatalystSeries::sum(self : ChemrxncatalystSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemrxncatalystSeries::mean(self : ChemrxncatalystSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemrxncatalystSeries::min(self : ChemrxncatalystSeries) -> Double { @_common.min(self.vals) }

pub fn ChemrxncatalystSeries::max(self : ChemrxncatalystSeries) -> Double { @_common.max(self.vals) }

pub fn ChemrxncatalystSeries::range(self : ChemrxncatalystSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemrxncatalystSeries::variance(self : ChemrxncatalystSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemrxncatalystSeries::std(self : ChemrxncatalystSeries) -> Double { @_common.std(self.vals) }

pub fn ChemrxncatalystSeries::median(self : ChemrxncatalystSeries) -> Double { @_common.median(self.vals) }

pub fn ChemrxncatalystSeries::scale(self : ChemrxncatalystSeries, f : Double) -> ChemrxncatalystSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemrxncatalystSeries::add(self : ChemrxncatalystSeries, other : ChemrxncatalystSeries) -> ChemrxncatalystSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemrxncatalystSeries::sub(self : ChemrxncatalystSeries, other : ChemrxncatalystSeries) -> ChemrxncatalystSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemrxncatalystSeries::normalize(self : ChemrxncatalystSeries) -> ChemrxncatalystSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemrxncatalystSeries::cumsum(self : ChemrxncatalystSeries) -> ChemrxncatalystSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemrxncatalystSeries::to_string(self : ChemrxncatalystSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemrxncatalystMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_rxn_catalyst_make_matrix(rows : Int, cols : Int, val : Double) -> ChemrxncatalystMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_rxn_catalyst_matrix_identity(n : Int) -> ChemrxncatalystMatrix {
  let m = chem_rxn_catalyst_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemrxncatalystMatrix::get(self : ChemrxncatalystMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemrxncatalystMatrix::transpose(self : ChemrxncatalystMatrix) -> ChemrxncatalystMatrix {
  let result = chem_rxn_catalyst_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemrxncatalystMatrix::add(self : ChemrxncatalystMatrix, other : ChemrxncatalystMatrix) -> ChemrxncatalystMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_rxn_catalyst_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemrxncatalystMatrix::scale(self : ChemrxncatalystMatrix, s : Double) -> ChemrxncatalystMatrix {
  let result = chem_rxn_catalyst_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemrxncatalystMatrix::multiply(self : ChemrxncatalystMatrix, other : ChemrxncatalystMatrix) -> ChemrxncatalystMatrix {
  if self.cols != other.rows { return chem_rxn_catalyst_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_rxn_catalyst_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ChemrxncatalystMatrix::trace(self : ChemrxncatalystMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemrxncatalystMatrix::det(self : ChemrxncatalystMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemrxncatalystMatrix::norm(self : ChemrxncatalystMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemrxncatalystMatrix::to_string(self : ChemrxncatalystMatrix) -> String {
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

pub(all) struct ChemrxncatalystVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_rxn_catalyst_make_vector(comps : Array[Double]) -> ChemrxncatalystVector {
  { comps, dim: comps.length() }
}

pub fn chem_rxn_catalyst_vector_zero(dim : Int) -> ChemrxncatalystVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemrxncatalystVector::add(self : ChemrxncatalystVector, other : ChemrxncatalystVector) -> ChemrxncatalystVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemrxncatalystVector::sub(self : ChemrxncatalystVector, other : ChemrxncatalystVector) -> ChemrxncatalystVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemrxncatalystVector::scale(self : ChemrxncatalystVector, s : Double) -> ChemrxncatalystVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemrxncatalystVector::dot(self : ChemrxncatalystVector, other : ChemrxncatalystVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemrxncatalystVector::norm(self : ChemrxncatalystVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemrxncatalystVector::normalize(self : ChemrxncatalystVector) -> ChemrxncatalystVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemrxncatalystVector::dist(self : ChemrxncatalystVector, other : ChemrxncatalystVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemrxncatalystVector::to_string(self : ChemrxncatalystVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_rxn_catalyst_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_rxn_catalyst_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_rxn_catalyst_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_rxn_catalyst_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_rxn_catalyst_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_rxn_catalyst_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_rxn_catalyst_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_rxn_catalyst_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_rxn_catalyst_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_rxn_catalyst_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_rxn_catalyst_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_rxn_catalyst_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_rxn_catalyst_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_rxn_catalyst_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_rxn_catalyst_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_rxn_catalyst_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_rxn_catalyst_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_rxn_catalyst_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_rxn_catalyst_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_rxn_catalyst_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_rxn_catalyst_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_rxn_catalyst_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_rxn_catalyst_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_rxn_catalyst_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_rxn_catalyst_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_rxn_catalyst_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_rxn_catalyst_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_rxn_catalyst_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_rxn_catalyst_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemrxncatalystFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_catalyst_frame_make(size : Int) -> ChemrxncatalystFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_catalyst_frame_len(s : ChemrxncatalystFrame) -> Int { s.size }

pub fn chem_rxn_catalyst_frame_get(s : ChemrxncatalystFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_catalyst_frame_set(s : ChemrxncatalystFrame, i : Int, v : Double) -> ChemrxncatalystFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_frame_sum(s : ChemrxncatalystFrame) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_catalyst_frame_mean(s : ChemrxncatalystFrame) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_catalyst_frame_scale(s : ChemrxncatalystFrame, f : Double) -> ChemrxncatalystFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_frame_add(a : ChemrxncatalystFrame, b : ChemrxncatalystFrame) -> ChemrxncatalystFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_catalyst_frame_copy(s : ChemrxncatalystFrame) -> ChemrxncatalystFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_frame_fill(s : ChemrxncatalystFrame, v : Double) -> ChemrxncatalystFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_frame_min(s : ChemrxncatalystFrame) -> Double { @_common.min(s.data) }

pub fn chem_rxn_catalyst_frame_max(s : ChemrxncatalystFrame) -> Double { @_common.max(s.data) }

pub fn chem_rxn_catalyst_frame_to_string(s : ChemrxncatalystFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxncatalystTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_catalyst_table_make(size : Int) -> ChemrxncatalystTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_catalyst_table_len(s : ChemrxncatalystTable) -> Int { s.size }

pub fn chem_rxn_catalyst_table_get(s : ChemrxncatalystTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_catalyst_table_set(s : ChemrxncatalystTable, i : Int, v : Double) -> ChemrxncatalystTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_table_sum(s : ChemrxncatalystTable) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_catalyst_table_mean(s : ChemrxncatalystTable) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_catalyst_table_scale(s : ChemrxncatalystTable, f : Double) -> ChemrxncatalystTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_table_add(a : ChemrxncatalystTable, b : ChemrxncatalystTable) -> ChemrxncatalystTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_catalyst_table_copy(s : ChemrxncatalystTable) -> ChemrxncatalystTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_table_fill(s : ChemrxncatalystTable, v : Double) -> ChemrxncatalystTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_table_min(s : ChemrxncatalystTable) -> Double { @_common.min(s.data) }

pub fn chem_rxn_catalyst_table_max(s : ChemrxncatalystTable) -> Double { @_common.max(s.data) }

pub fn chem_rxn_catalyst_table_to_string(s : ChemrxncatalystTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxncatalystGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_catalyst_graphn_make(size : Int) -> ChemrxncatalystGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_catalyst_graphn_len(s : ChemrxncatalystGraphN) -> Int { s.size }

pub fn chem_rxn_catalyst_graphn_get(s : ChemrxncatalystGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_catalyst_graphn_set(s : ChemrxncatalystGraphN, i : Int, v : Double) -> ChemrxncatalystGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_graphn_sum(s : ChemrxncatalystGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_catalyst_graphn_mean(s : ChemrxncatalystGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_catalyst_graphn_scale(s : ChemrxncatalystGraphN, f : Double) -> ChemrxncatalystGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_graphn_add(a : ChemrxncatalystGraphN, b : ChemrxncatalystGraphN) -> ChemrxncatalystGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_catalyst_graphn_copy(s : ChemrxncatalystGraphN) -> ChemrxncatalystGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_graphn_fill(s : ChemrxncatalystGraphN, v : Double) -> ChemrxncatalystGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_graphn_min(s : ChemrxncatalystGraphN) -> Double { @_common.min(s.data) }

pub fn chem_rxn_catalyst_graphn_max(s : ChemrxncatalystGraphN) -> Double { @_common.max(s.data) }

pub fn chem_rxn_catalyst_graphn_to_string(s : ChemrxncatalystGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxncatalystNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_catalyst_node_make(size : Int) -> ChemrxncatalystNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_catalyst_node_len(s : ChemrxncatalystNode) -> Int { s.size }

pub fn chem_rxn_catalyst_node_get(s : ChemrxncatalystNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_catalyst_node_set(s : ChemrxncatalystNode, i : Int, v : Double) -> ChemrxncatalystNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_node_sum(s : ChemrxncatalystNode) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_catalyst_node_mean(s : ChemrxncatalystNode) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_catalyst_node_scale(s : ChemrxncatalystNode, f : Double) -> ChemrxncatalystNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_node_add(a : ChemrxncatalystNode, b : ChemrxncatalystNode) -> ChemrxncatalystNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_catalyst_node_copy(s : ChemrxncatalystNode) -> ChemrxncatalystNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_node_fill(s : ChemrxncatalystNode, v : Double) -> ChemrxncatalystNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_node_min(s : ChemrxncatalystNode) -> Double { @_common.min(s.data) }

pub fn chem_rxn_catalyst_node_max(s : ChemrxncatalystNode) -> Double { @_common.max(s.data) }

pub fn chem_rxn_catalyst_node_to_string(s : ChemrxncatalystNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxncatalystEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_catalyst_edge_make(size : Int) -> ChemrxncatalystEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_catalyst_edge_len(s : ChemrxncatalystEdge) -> Int { s.size }

pub fn chem_rxn_catalyst_edge_get(s : ChemrxncatalystEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_catalyst_edge_set(s : ChemrxncatalystEdge, i : Int, v : Double) -> ChemrxncatalystEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_edge_sum(s : ChemrxncatalystEdge) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_catalyst_edge_mean(s : ChemrxncatalystEdge) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_catalyst_edge_scale(s : ChemrxncatalystEdge, f : Double) -> ChemrxncatalystEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_edge_add(a : ChemrxncatalystEdge, b : ChemrxncatalystEdge) -> ChemrxncatalystEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_catalyst_edge_copy(s : ChemrxncatalystEdge) -> ChemrxncatalystEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_edge_fill(s : ChemrxncatalystEdge, v : Double) -> ChemrxncatalystEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_edge_min(s : ChemrxncatalystEdge) -> Double { @_common.min(s.data) }

pub fn chem_rxn_catalyst_edge_max(s : ChemrxncatalystEdge) -> Double { @_common.max(s.data) }

pub fn chem_rxn_catalyst_edge_to_string(s : ChemrxncatalystEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxncatalystPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_catalyst_path_make(size : Int) -> ChemrxncatalystPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_catalyst_path_len(s : ChemrxncatalystPath) -> Int { s.size }

pub fn chem_rxn_catalyst_path_get(s : ChemrxncatalystPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_catalyst_path_set(s : ChemrxncatalystPath, i : Int, v : Double) -> ChemrxncatalystPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_path_sum(s : ChemrxncatalystPath) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_catalyst_path_mean(s : ChemrxncatalystPath) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_catalyst_path_scale(s : ChemrxncatalystPath, f : Double) -> ChemrxncatalystPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_path_add(a : ChemrxncatalystPath, b : ChemrxncatalystPath) -> ChemrxncatalystPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_catalyst_path_copy(s : ChemrxncatalystPath) -> ChemrxncatalystPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_path_fill(s : ChemrxncatalystPath, v : Double) -> ChemrxncatalystPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_path_min(s : ChemrxncatalystPath) -> Double { @_common.min(s.data) }

pub fn chem_rxn_catalyst_path_max(s : ChemrxncatalystPath) -> Double { @_common.max(s.data) }

pub fn chem_rxn_catalyst_path_to_string(s : ChemrxncatalystPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxncatalystCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_catalyst_cluster_make(size : Int) -> ChemrxncatalystCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_catalyst_cluster_len(s : ChemrxncatalystCluster) -> Int { s.size }

pub fn chem_rxn_catalyst_cluster_get(s : ChemrxncatalystCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_catalyst_cluster_set(s : ChemrxncatalystCluster, i : Int, v : Double) -> ChemrxncatalystCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_cluster_sum(s : ChemrxncatalystCluster) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_catalyst_cluster_mean(s : ChemrxncatalystCluster) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_catalyst_cluster_scale(s : ChemrxncatalystCluster, f : Double) -> ChemrxncatalystCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_cluster_add(a : ChemrxncatalystCluster, b : ChemrxncatalystCluster) -> ChemrxncatalystCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_catalyst_cluster_copy(s : ChemrxncatalystCluster) -> ChemrxncatalystCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_cluster_fill(s : ChemrxncatalystCluster, v : Double) -> ChemrxncatalystCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_cluster_min(s : ChemrxncatalystCluster) -> Double { @_common.min(s.data) }

pub fn chem_rxn_catalyst_cluster_max(s : ChemrxncatalystCluster) -> Double { @_common.max(s.data) }

pub fn chem_rxn_catalyst_cluster_to_string(s : ChemrxncatalystCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxncatalystModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_catalyst_model_make(size : Int) -> ChemrxncatalystModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_catalyst_model_len(s : ChemrxncatalystModel) -> Int { s.size }

pub fn chem_rxn_catalyst_model_get(s : ChemrxncatalystModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_catalyst_model_set(s : ChemrxncatalystModel, i : Int, v : Double) -> ChemrxncatalystModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_model_sum(s : ChemrxncatalystModel) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_catalyst_model_mean(s : ChemrxncatalystModel) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_catalyst_model_scale(s : ChemrxncatalystModel, f : Double) -> ChemrxncatalystModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_model_add(a : ChemrxncatalystModel, b : ChemrxncatalystModel) -> ChemrxncatalystModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_catalyst_model_copy(s : ChemrxncatalystModel) -> ChemrxncatalystModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_model_fill(s : ChemrxncatalystModel, v : Double) -> ChemrxncatalystModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_model_min(s : ChemrxncatalystModel) -> Double { @_common.min(s.data) }

pub fn chem_rxn_catalyst_model_max(s : ChemrxncatalystModel) -> Double { @_common.max(s.data) }

pub fn chem_rxn_catalyst_model_to_string(s : ChemrxncatalystModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxncatalystLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_catalyst_layer_make(size : Int) -> ChemrxncatalystLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_catalyst_layer_len(s : ChemrxncatalystLayer) -> Int { s.size }

pub fn chem_rxn_catalyst_layer_get(s : ChemrxncatalystLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_catalyst_layer_set(s : ChemrxncatalystLayer, i : Int, v : Double) -> ChemrxncatalystLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_layer_sum(s : ChemrxncatalystLayer) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_catalyst_layer_mean(s : ChemrxncatalystLayer) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_catalyst_layer_scale(s : ChemrxncatalystLayer, f : Double) -> ChemrxncatalystLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_layer_add(a : ChemrxncatalystLayer, b : ChemrxncatalystLayer) -> ChemrxncatalystLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_catalyst_layer_copy(s : ChemrxncatalystLayer) -> ChemrxncatalystLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_layer_fill(s : ChemrxncatalystLayer, v : Double) -> ChemrxncatalystLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_layer_min(s : ChemrxncatalystLayer) -> Double { @_common.min(s.data) }

pub fn chem_rxn_catalyst_layer_max(s : ChemrxncatalystLayer) -> Double { @_common.max(s.data) }

pub fn chem_rxn_catalyst_layer_to_string(s : ChemrxncatalystLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxncatalystBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_catalyst_buffer_make(size : Int) -> ChemrxncatalystBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_catalyst_buffer_len(s : ChemrxncatalystBuffer) -> Int { s.size }

pub fn chem_rxn_catalyst_buffer_get(s : ChemrxncatalystBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_catalyst_buffer_set(s : ChemrxncatalystBuffer, i : Int, v : Double) -> ChemrxncatalystBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_buffer_sum(s : ChemrxncatalystBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_catalyst_buffer_mean(s : ChemrxncatalystBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_catalyst_buffer_scale(s : ChemrxncatalystBuffer, f : Double) -> ChemrxncatalystBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_buffer_add(a : ChemrxncatalystBuffer, b : ChemrxncatalystBuffer) -> ChemrxncatalystBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_catalyst_buffer_copy(s : ChemrxncatalystBuffer) -> ChemrxncatalystBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_buffer_fill(s : ChemrxncatalystBuffer, v : Double) -> ChemrxncatalystBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_buffer_min(s : ChemrxncatalystBuffer) -> Double { @_common.min(s.data) }

pub fn chem_rxn_catalyst_buffer_max(s : ChemrxncatalystBuffer) -> Double { @_common.max(s.data) }

pub fn chem_rxn_catalyst_buffer_to_string(s : ChemrxncatalystBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxncatalystCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_catalyst_cursor_make(size : Int) -> ChemrxncatalystCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_catalyst_cursor_len(s : ChemrxncatalystCursor) -> Int { s.size }

pub fn chem_rxn_catalyst_cursor_get(s : ChemrxncatalystCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_catalyst_cursor_set(s : ChemrxncatalystCursor, i : Int, v : Double) -> ChemrxncatalystCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_cursor_sum(s : ChemrxncatalystCursor) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_catalyst_cursor_mean(s : ChemrxncatalystCursor) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_catalyst_cursor_scale(s : ChemrxncatalystCursor, f : Double) -> ChemrxncatalystCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_cursor_add(a : ChemrxncatalystCursor, b : ChemrxncatalystCursor) -> ChemrxncatalystCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_catalyst_cursor_copy(s : ChemrxncatalystCursor) -> ChemrxncatalystCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_cursor_fill(s : ChemrxncatalystCursor, v : Double) -> ChemrxncatalystCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_cursor_min(s : ChemrxncatalystCursor) -> Double { @_common.min(s.data) }

pub fn chem_rxn_catalyst_cursor_max(s : ChemrxncatalystCursor) -> Double { @_common.max(s.data) }

pub fn chem_rxn_catalyst_cursor_to_string(s : ChemrxncatalystCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxncatalystView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_catalyst_view_make(size : Int) -> ChemrxncatalystView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_catalyst_view_len(s : ChemrxncatalystView) -> Int { s.size }

pub fn chem_rxn_catalyst_view_get(s : ChemrxncatalystView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_catalyst_view_set(s : ChemrxncatalystView, i : Int, v : Double) -> ChemrxncatalystView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_view_sum(s : ChemrxncatalystView) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_catalyst_view_mean(s : ChemrxncatalystView) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_catalyst_view_scale(s : ChemrxncatalystView, f : Double) -> ChemrxncatalystView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_view_add(a : ChemrxncatalystView, b : ChemrxncatalystView) -> ChemrxncatalystView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_catalyst_view_copy(s : ChemrxncatalystView) -> ChemrxncatalystView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_view_fill(s : ChemrxncatalystView, v : Double) -> ChemrxncatalystView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_view_min(s : ChemrxncatalystView) -> Double { @_common.min(s.data) }

pub fn chem_rxn_catalyst_view_max(s : ChemrxncatalystView) -> Double { @_common.max(s.data) }

pub fn chem_rxn_catalyst_view_to_string(s : ChemrxncatalystView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxncatalystRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_catalyst_range_make(size : Int) -> ChemrxncatalystRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_catalyst_range_len(s : ChemrxncatalystRange) -> Int { s.size }

pub fn chem_rxn_catalyst_range_get(s : ChemrxncatalystRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_catalyst_range_set(s : ChemrxncatalystRange, i : Int, v : Double) -> ChemrxncatalystRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_range_sum(s : ChemrxncatalystRange) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_catalyst_range_mean(s : ChemrxncatalystRange) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_catalyst_range_scale(s : ChemrxncatalystRange, f : Double) -> ChemrxncatalystRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_range_add(a : ChemrxncatalystRange, b : ChemrxncatalystRange) -> ChemrxncatalystRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_catalyst_range_copy(s : ChemrxncatalystRange) -> ChemrxncatalystRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_range_fill(s : ChemrxncatalystRange, v : Double) -> ChemrxncatalystRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_range_min(s : ChemrxncatalystRange) -> Double { @_common.min(s.data) }

pub fn chem_rxn_catalyst_range_max(s : ChemrxncatalystRange) -> Double { @_common.max(s.data) }

pub fn chem_rxn_catalyst_range_to_string(s : ChemrxncatalystRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxncatalystSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_catalyst_slice_make(size : Int) -> ChemrxncatalystSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_catalyst_slice_len(s : ChemrxncatalystSlice) -> Int { s.size }

pub fn chem_rxn_catalyst_slice_get(s : ChemrxncatalystSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_catalyst_slice_set(s : ChemrxncatalystSlice, i : Int, v : Double) -> ChemrxncatalystSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_slice_sum(s : ChemrxncatalystSlice) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_catalyst_slice_mean(s : ChemrxncatalystSlice) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_catalyst_slice_scale(s : ChemrxncatalystSlice, f : Double) -> ChemrxncatalystSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_slice_add(a : ChemrxncatalystSlice, b : ChemrxncatalystSlice) -> ChemrxncatalystSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_catalyst_slice_copy(s : ChemrxncatalystSlice) -> ChemrxncatalystSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_slice_fill(s : ChemrxncatalystSlice, v : Double) -> ChemrxncatalystSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_catalyst_slice_min(s : ChemrxncatalystSlice) -> Double { @_common.min(s.data) }

pub fn chem_rxn_catalyst_slice_max(s : ChemrxncatalystSlice) -> Double { @_common.max(s.data) }

pub fn chem_rxn_catalyst_slice_to_string(s : ChemrxncatalystSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

