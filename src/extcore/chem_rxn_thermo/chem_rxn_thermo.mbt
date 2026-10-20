///===
/// extcore/chem_rxn_thermo

pub(all) struct ChemrxnthermoPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_rxn_thermo_make_point(x : Double, y : Double) -> ChemrxnthermoPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_rxn_thermo_make_point3(x : Double, y : Double, z : Double) -> ChemrxnthermoPoint {
  { x, y, z, label: 0 }
}

pub fn ChemrxnthermoPoint::x(self : ChemrxnthermoPoint) -> Double { self.x }

pub fn ChemrxnthermoPoint::y(self : ChemrxnthermoPoint) -> Double { self.y }

pub fn ChemrxnthermoPoint::z(self : ChemrxnthermoPoint) -> Double { self.z }

pub fn ChemrxnthermoPoint::label(self : ChemrxnthermoPoint) -> Int { self.label }

pub fn ChemrxnthermoPoint::dist(self : ChemrxnthermoPoint, other : ChemrxnthermoPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemrxnthermoPoint::add(self : ChemrxnthermoPoint, other : ChemrxnthermoPoint) -> ChemrxnthermoPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemrxnthermoPoint::sub(self : ChemrxnthermoPoint, other : ChemrxnthermoPoint) -> ChemrxnthermoPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemrxnthermoPoint::scale(self : ChemrxnthermoPoint, s : Double) -> ChemrxnthermoPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemrxnthermoPoint::dot(self : ChemrxnthermoPoint, other : ChemrxnthermoPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemrxnthermoPoint::cross(self : ChemrxnthermoPoint, other : ChemrxnthermoPoint) -> ChemrxnthermoPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemrxnthermoPoint::norm(self : ChemrxnthermoPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemrxnthermoPoint::normalize(self : ChemrxnthermoPoint) -> ChemrxnthermoPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemrxnthermoPoint::negate(self : ChemrxnthermoPoint) -> ChemrxnthermoPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemrxnthermoPoint::mid(self : ChemrxnthermoPoint, other : ChemrxnthermoPoint) -> ChemrxnthermoPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemrxnthermoPoint::lerp(self : ChemrxnthermoPoint, other : ChemrxnthermoPoint, t : Double) -> ChemrxnthermoPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemrxnthermoPoint::to_string(self : ChemrxnthermoPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemrxnthermoSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_rxn_thermo_make_series(vals : Array[Double], name : String) -> ChemrxnthermoSeries {
  { vals, name, meta: 0 }
}

pub fn ChemrxnthermoSeries::len(self : ChemrxnthermoSeries) -> Int { self.vals.length() }

pub fn ChemrxnthermoSeries::sum(self : ChemrxnthermoSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemrxnthermoSeries::mean(self : ChemrxnthermoSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemrxnthermoSeries::min(self : ChemrxnthermoSeries) -> Double { @_common.min(self.vals) }

pub fn ChemrxnthermoSeries::max(self : ChemrxnthermoSeries) -> Double { @_common.max(self.vals) }

pub fn ChemrxnthermoSeries::range(self : ChemrxnthermoSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemrxnthermoSeries::variance(self : ChemrxnthermoSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemrxnthermoSeries::std(self : ChemrxnthermoSeries) -> Double { @_common.std(self.vals) }

pub fn ChemrxnthermoSeries::median(self : ChemrxnthermoSeries) -> Double { @_common.median(self.vals) }

pub fn ChemrxnthermoSeries::scale(self : ChemrxnthermoSeries, f : Double) -> ChemrxnthermoSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemrxnthermoSeries::add(self : ChemrxnthermoSeries, other : ChemrxnthermoSeries) -> ChemrxnthermoSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemrxnthermoSeries::sub(self : ChemrxnthermoSeries, other : ChemrxnthermoSeries) -> ChemrxnthermoSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemrxnthermoSeries::normalize(self : ChemrxnthermoSeries) -> ChemrxnthermoSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemrxnthermoSeries::cumsum(self : ChemrxnthermoSeries) -> ChemrxnthermoSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemrxnthermoSeries::to_string(self : ChemrxnthermoSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemrxnthermoMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_rxn_thermo_make_matrix(rows : Int, cols : Int, val : Double) -> ChemrxnthermoMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_rxn_thermo_matrix_identity(n : Int) -> ChemrxnthermoMatrix {
  let m = chem_rxn_thermo_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemrxnthermoMatrix::get(self : ChemrxnthermoMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemrxnthermoMatrix::transpose(self : ChemrxnthermoMatrix) -> ChemrxnthermoMatrix {
  let result = chem_rxn_thermo_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemrxnthermoMatrix::add(self : ChemrxnthermoMatrix, other : ChemrxnthermoMatrix) -> ChemrxnthermoMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_rxn_thermo_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemrxnthermoMatrix::scale(self : ChemrxnthermoMatrix, s : Double) -> ChemrxnthermoMatrix {
  let result = chem_rxn_thermo_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemrxnthermoMatrix::multiply(self : ChemrxnthermoMatrix, other : ChemrxnthermoMatrix) -> ChemrxnthermoMatrix {
  if self.cols != other.rows { return chem_rxn_thermo_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_rxn_thermo_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ChemrxnthermoMatrix::trace(self : ChemrxnthermoMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemrxnthermoMatrix::det(self : ChemrxnthermoMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemrxnthermoMatrix::norm(self : ChemrxnthermoMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemrxnthermoMatrix::to_string(self : ChemrxnthermoMatrix) -> String {
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

pub(all) struct ChemrxnthermoVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_rxn_thermo_make_vector(comps : Array[Double]) -> ChemrxnthermoVector {
  { comps, dim: comps.length() }
}

pub fn chem_rxn_thermo_vector_zero(dim : Int) -> ChemrxnthermoVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemrxnthermoVector::add(self : ChemrxnthermoVector, other : ChemrxnthermoVector) -> ChemrxnthermoVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemrxnthermoVector::sub(self : ChemrxnthermoVector, other : ChemrxnthermoVector) -> ChemrxnthermoVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemrxnthermoVector::scale(self : ChemrxnthermoVector, s : Double) -> ChemrxnthermoVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemrxnthermoVector::dot(self : ChemrxnthermoVector, other : ChemrxnthermoVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemrxnthermoVector::norm(self : ChemrxnthermoVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemrxnthermoVector::normalize(self : ChemrxnthermoVector) -> ChemrxnthermoVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemrxnthermoVector::dist(self : ChemrxnthermoVector, other : ChemrxnthermoVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemrxnthermoVector::to_string(self : ChemrxnthermoVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_rxn_thermo_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_rxn_thermo_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_rxn_thermo_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_rxn_thermo_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_rxn_thermo_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_rxn_thermo_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_rxn_thermo_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_rxn_thermo_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_rxn_thermo_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_rxn_thermo_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_rxn_thermo_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_rxn_thermo_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_rxn_thermo_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_rxn_thermo_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_rxn_thermo_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_rxn_thermo_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_rxn_thermo_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_rxn_thermo_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_rxn_thermo_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_rxn_thermo_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_rxn_thermo_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_rxn_thermo_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_rxn_thermo_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_rxn_thermo_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_rxn_thermo_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_rxn_thermo_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_rxn_thermo_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_rxn_thermo_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_rxn_thermo_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemrxnthermoFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_frame_make(size : Int) -> ChemrxnthermoFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_thermo_frame_len(s : ChemrxnthermoFrame) -> Int { s.size }

pub fn chem_rxn_thermo_frame_get(s : ChemrxnthermoFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_thermo_frame_set(s : ChemrxnthermoFrame, i : Int, v : Double) -> ChemrxnthermoFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_frame_sum(s : ChemrxnthermoFrame) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_thermo_frame_mean(s : ChemrxnthermoFrame) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_thermo_frame_scale(s : ChemrxnthermoFrame, f : Double) -> ChemrxnthermoFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_frame_add(a : ChemrxnthermoFrame, b : ChemrxnthermoFrame) -> ChemrxnthermoFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_thermo_frame_copy(s : ChemrxnthermoFrame) -> ChemrxnthermoFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_frame_fill(s : ChemrxnthermoFrame, v : Double) -> ChemrxnthermoFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_frame_min(s : ChemrxnthermoFrame) -> Double { @_common.min(s.data) }

pub fn chem_rxn_thermo_frame_max(s : ChemrxnthermoFrame) -> Double { @_common.max(s.data) }

pub fn chem_rxn_thermo_frame_to_string(s : ChemrxnthermoFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_table_make(size : Int) -> ChemrxnthermoTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_thermo_table_len(s : ChemrxnthermoTable) -> Int { s.size }

pub fn chem_rxn_thermo_table_get(s : ChemrxnthermoTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_thermo_table_set(s : ChemrxnthermoTable, i : Int, v : Double) -> ChemrxnthermoTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_table_sum(s : ChemrxnthermoTable) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_thermo_table_mean(s : ChemrxnthermoTable) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_thermo_table_scale(s : ChemrxnthermoTable, f : Double) -> ChemrxnthermoTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_table_add(a : ChemrxnthermoTable, b : ChemrxnthermoTable) -> ChemrxnthermoTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_thermo_table_copy(s : ChemrxnthermoTable) -> ChemrxnthermoTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_table_fill(s : ChemrxnthermoTable, v : Double) -> ChemrxnthermoTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_table_min(s : ChemrxnthermoTable) -> Double { @_common.min(s.data) }

pub fn chem_rxn_thermo_table_max(s : ChemrxnthermoTable) -> Double { @_common.max(s.data) }

pub fn chem_rxn_thermo_table_to_string(s : ChemrxnthermoTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_graphn_make(size : Int) -> ChemrxnthermoGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_thermo_graphn_len(s : ChemrxnthermoGraphN) -> Int { s.size }

pub fn chem_rxn_thermo_graphn_get(s : ChemrxnthermoGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_thermo_graphn_set(s : ChemrxnthermoGraphN, i : Int, v : Double) -> ChemrxnthermoGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_graphn_sum(s : ChemrxnthermoGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_thermo_graphn_mean(s : ChemrxnthermoGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_thermo_graphn_scale(s : ChemrxnthermoGraphN, f : Double) -> ChemrxnthermoGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_graphn_add(a : ChemrxnthermoGraphN, b : ChemrxnthermoGraphN) -> ChemrxnthermoGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_thermo_graphn_copy(s : ChemrxnthermoGraphN) -> ChemrxnthermoGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_graphn_fill(s : ChemrxnthermoGraphN, v : Double) -> ChemrxnthermoGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_graphn_min(s : ChemrxnthermoGraphN) -> Double { @_common.min(s.data) }

pub fn chem_rxn_thermo_graphn_max(s : ChemrxnthermoGraphN) -> Double { @_common.max(s.data) }

pub fn chem_rxn_thermo_graphn_to_string(s : ChemrxnthermoGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_node_make(size : Int) -> ChemrxnthermoNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_thermo_node_len(s : ChemrxnthermoNode) -> Int { s.size }

pub fn chem_rxn_thermo_node_get(s : ChemrxnthermoNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_thermo_node_set(s : ChemrxnthermoNode, i : Int, v : Double) -> ChemrxnthermoNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_node_sum(s : ChemrxnthermoNode) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_thermo_node_mean(s : ChemrxnthermoNode) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_thermo_node_scale(s : ChemrxnthermoNode, f : Double) -> ChemrxnthermoNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_node_add(a : ChemrxnthermoNode, b : ChemrxnthermoNode) -> ChemrxnthermoNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_thermo_node_copy(s : ChemrxnthermoNode) -> ChemrxnthermoNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_node_fill(s : ChemrxnthermoNode, v : Double) -> ChemrxnthermoNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_node_min(s : ChemrxnthermoNode) -> Double { @_common.min(s.data) }

pub fn chem_rxn_thermo_node_max(s : ChemrxnthermoNode) -> Double { @_common.max(s.data) }

pub fn chem_rxn_thermo_node_to_string(s : ChemrxnthermoNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_edge_make(size : Int) -> ChemrxnthermoEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_thermo_edge_len(s : ChemrxnthermoEdge) -> Int { s.size }

pub fn chem_rxn_thermo_edge_get(s : ChemrxnthermoEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_thermo_edge_set(s : ChemrxnthermoEdge, i : Int, v : Double) -> ChemrxnthermoEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_edge_sum(s : ChemrxnthermoEdge) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_thermo_edge_mean(s : ChemrxnthermoEdge) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_thermo_edge_scale(s : ChemrxnthermoEdge, f : Double) -> ChemrxnthermoEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_edge_add(a : ChemrxnthermoEdge, b : ChemrxnthermoEdge) -> ChemrxnthermoEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_thermo_edge_copy(s : ChemrxnthermoEdge) -> ChemrxnthermoEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_edge_fill(s : ChemrxnthermoEdge, v : Double) -> ChemrxnthermoEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_edge_min(s : ChemrxnthermoEdge) -> Double { @_common.min(s.data) }

pub fn chem_rxn_thermo_edge_max(s : ChemrxnthermoEdge) -> Double { @_common.max(s.data) }

pub fn chem_rxn_thermo_edge_to_string(s : ChemrxnthermoEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_path_make(size : Int) -> ChemrxnthermoPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_thermo_path_len(s : ChemrxnthermoPath) -> Int { s.size }

pub fn chem_rxn_thermo_path_get(s : ChemrxnthermoPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_thermo_path_set(s : ChemrxnthermoPath, i : Int, v : Double) -> ChemrxnthermoPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_path_sum(s : ChemrxnthermoPath) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_thermo_path_mean(s : ChemrxnthermoPath) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_thermo_path_scale(s : ChemrxnthermoPath, f : Double) -> ChemrxnthermoPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_path_add(a : ChemrxnthermoPath, b : ChemrxnthermoPath) -> ChemrxnthermoPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_thermo_path_copy(s : ChemrxnthermoPath) -> ChemrxnthermoPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_path_fill(s : ChemrxnthermoPath, v : Double) -> ChemrxnthermoPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_path_min(s : ChemrxnthermoPath) -> Double { @_common.min(s.data) }

pub fn chem_rxn_thermo_path_max(s : ChemrxnthermoPath) -> Double { @_common.max(s.data) }

pub fn chem_rxn_thermo_path_to_string(s : ChemrxnthermoPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_cluster_make(size : Int) -> ChemrxnthermoCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_thermo_cluster_len(s : ChemrxnthermoCluster) -> Int { s.size }

pub fn chem_rxn_thermo_cluster_get(s : ChemrxnthermoCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_thermo_cluster_set(s : ChemrxnthermoCluster, i : Int, v : Double) -> ChemrxnthermoCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_cluster_sum(s : ChemrxnthermoCluster) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_thermo_cluster_mean(s : ChemrxnthermoCluster) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_thermo_cluster_scale(s : ChemrxnthermoCluster, f : Double) -> ChemrxnthermoCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_cluster_add(a : ChemrxnthermoCluster, b : ChemrxnthermoCluster) -> ChemrxnthermoCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_thermo_cluster_copy(s : ChemrxnthermoCluster) -> ChemrxnthermoCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_cluster_fill(s : ChemrxnthermoCluster, v : Double) -> ChemrxnthermoCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_cluster_min(s : ChemrxnthermoCluster) -> Double { @_common.min(s.data) }

pub fn chem_rxn_thermo_cluster_max(s : ChemrxnthermoCluster) -> Double { @_common.max(s.data) }

pub fn chem_rxn_thermo_cluster_to_string(s : ChemrxnthermoCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_model_make(size : Int) -> ChemrxnthermoModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_thermo_model_len(s : ChemrxnthermoModel) -> Int { s.size }

pub fn chem_rxn_thermo_model_get(s : ChemrxnthermoModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_thermo_model_set(s : ChemrxnthermoModel, i : Int, v : Double) -> ChemrxnthermoModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_model_sum(s : ChemrxnthermoModel) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_thermo_model_mean(s : ChemrxnthermoModel) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_thermo_model_scale(s : ChemrxnthermoModel, f : Double) -> ChemrxnthermoModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_model_add(a : ChemrxnthermoModel, b : ChemrxnthermoModel) -> ChemrxnthermoModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_thermo_model_copy(s : ChemrxnthermoModel) -> ChemrxnthermoModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_model_fill(s : ChemrxnthermoModel, v : Double) -> ChemrxnthermoModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_model_min(s : ChemrxnthermoModel) -> Double { @_common.min(s.data) }

pub fn chem_rxn_thermo_model_max(s : ChemrxnthermoModel) -> Double { @_common.max(s.data) }

pub fn chem_rxn_thermo_model_to_string(s : ChemrxnthermoModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_layer_make(size : Int) -> ChemrxnthermoLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_thermo_layer_len(s : ChemrxnthermoLayer) -> Int { s.size }

pub fn chem_rxn_thermo_layer_get(s : ChemrxnthermoLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_thermo_layer_set(s : ChemrxnthermoLayer, i : Int, v : Double) -> ChemrxnthermoLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_layer_sum(s : ChemrxnthermoLayer) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_thermo_layer_mean(s : ChemrxnthermoLayer) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_thermo_layer_scale(s : ChemrxnthermoLayer, f : Double) -> ChemrxnthermoLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_layer_add(a : ChemrxnthermoLayer, b : ChemrxnthermoLayer) -> ChemrxnthermoLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_thermo_layer_copy(s : ChemrxnthermoLayer) -> ChemrxnthermoLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_layer_fill(s : ChemrxnthermoLayer, v : Double) -> ChemrxnthermoLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_layer_min(s : ChemrxnthermoLayer) -> Double { @_common.min(s.data) }

pub fn chem_rxn_thermo_layer_max(s : ChemrxnthermoLayer) -> Double { @_common.max(s.data) }

pub fn chem_rxn_thermo_layer_to_string(s : ChemrxnthermoLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_buffer_make(size : Int) -> ChemrxnthermoBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_thermo_buffer_len(s : ChemrxnthermoBuffer) -> Int { s.size }

pub fn chem_rxn_thermo_buffer_get(s : ChemrxnthermoBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_thermo_buffer_set(s : ChemrxnthermoBuffer, i : Int, v : Double) -> ChemrxnthermoBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_buffer_sum(s : ChemrxnthermoBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_thermo_buffer_mean(s : ChemrxnthermoBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_thermo_buffer_scale(s : ChemrxnthermoBuffer, f : Double) -> ChemrxnthermoBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_buffer_add(a : ChemrxnthermoBuffer, b : ChemrxnthermoBuffer) -> ChemrxnthermoBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_thermo_buffer_copy(s : ChemrxnthermoBuffer) -> ChemrxnthermoBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_buffer_fill(s : ChemrxnthermoBuffer, v : Double) -> ChemrxnthermoBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_buffer_min(s : ChemrxnthermoBuffer) -> Double { @_common.min(s.data) }

pub fn chem_rxn_thermo_buffer_max(s : ChemrxnthermoBuffer) -> Double { @_common.max(s.data) }

pub fn chem_rxn_thermo_buffer_to_string(s : ChemrxnthermoBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_cursor_make(size : Int) -> ChemrxnthermoCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_thermo_cursor_len(s : ChemrxnthermoCursor) -> Int { s.size }

pub fn chem_rxn_thermo_cursor_get(s : ChemrxnthermoCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_thermo_cursor_set(s : ChemrxnthermoCursor, i : Int, v : Double) -> ChemrxnthermoCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_cursor_sum(s : ChemrxnthermoCursor) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_thermo_cursor_mean(s : ChemrxnthermoCursor) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_thermo_cursor_scale(s : ChemrxnthermoCursor, f : Double) -> ChemrxnthermoCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_cursor_add(a : ChemrxnthermoCursor, b : ChemrxnthermoCursor) -> ChemrxnthermoCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_thermo_cursor_copy(s : ChemrxnthermoCursor) -> ChemrxnthermoCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_cursor_fill(s : ChemrxnthermoCursor, v : Double) -> ChemrxnthermoCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_cursor_min(s : ChemrxnthermoCursor) -> Double { @_common.min(s.data) }

pub fn chem_rxn_thermo_cursor_max(s : ChemrxnthermoCursor) -> Double { @_common.max(s.data) }

pub fn chem_rxn_thermo_cursor_to_string(s : ChemrxnthermoCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_view_make(size : Int) -> ChemrxnthermoView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_thermo_view_len(s : ChemrxnthermoView) -> Int { s.size }

pub fn chem_rxn_thermo_view_get(s : ChemrxnthermoView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_thermo_view_set(s : ChemrxnthermoView, i : Int, v : Double) -> ChemrxnthermoView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_view_sum(s : ChemrxnthermoView) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_thermo_view_mean(s : ChemrxnthermoView) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_thermo_view_scale(s : ChemrxnthermoView, f : Double) -> ChemrxnthermoView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_view_add(a : ChemrxnthermoView, b : ChemrxnthermoView) -> ChemrxnthermoView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_thermo_view_copy(s : ChemrxnthermoView) -> ChemrxnthermoView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_view_fill(s : ChemrxnthermoView, v : Double) -> ChemrxnthermoView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_view_min(s : ChemrxnthermoView) -> Double { @_common.min(s.data) }

pub fn chem_rxn_thermo_view_max(s : ChemrxnthermoView) -> Double { @_common.max(s.data) }

pub fn chem_rxn_thermo_view_to_string(s : ChemrxnthermoView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_range_make(size : Int) -> ChemrxnthermoRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_thermo_range_len(s : ChemrxnthermoRange) -> Int { s.size }

pub fn chem_rxn_thermo_range_get(s : ChemrxnthermoRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_thermo_range_set(s : ChemrxnthermoRange, i : Int, v : Double) -> ChemrxnthermoRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_range_sum(s : ChemrxnthermoRange) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_thermo_range_mean(s : ChemrxnthermoRange) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_thermo_range_scale(s : ChemrxnthermoRange, f : Double) -> ChemrxnthermoRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_range_add(a : ChemrxnthermoRange, b : ChemrxnthermoRange) -> ChemrxnthermoRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_thermo_range_copy(s : ChemrxnthermoRange) -> ChemrxnthermoRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_range_fill(s : ChemrxnthermoRange, v : Double) -> ChemrxnthermoRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_range_min(s : ChemrxnthermoRange) -> Double { @_common.min(s.data) }

pub fn chem_rxn_thermo_range_max(s : ChemrxnthermoRange) -> Double { @_common.max(s.data) }

pub fn chem_rxn_thermo_range_to_string(s : ChemrxnthermoRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_slice_make(size : Int) -> ChemrxnthermoSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_thermo_slice_len(s : ChemrxnthermoSlice) -> Int { s.size }

pub fn chem_rxn_thermo_slice_get(s : ChemrxnthermoSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_thermo_slice_set(s : ChemrxnthermoSlice, i : Int, v : Double) -> ChemrxnthermoSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_slice_sum(s : ChemrxnthermoSlice) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_thermo_slice_mean(s : ChemrxnthermoSlice) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_thermo_slice_scale(s : ChemrxnthermoSlice, f : Double) -> ChemrxnthermoSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_slice_add(a : ChemrxnthermoSlice, b : ChemrxnthermoSlice) -> ChemrxnthermoSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_thermo_slice_copy(s : ChemrxnthermoSlice) -> ChemrxnthermoSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_slice_fill(s : ChemrxnthermoSlice, v : Double) -> ChemrxnthermoSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_thermo_slice_min(s : ChemrxnthermoSlice) -> Double { @_common.min(s.data) }

pub fn chem_rxn_thermo_slice_max(s : ChemrxnthermoSlice) -> Double { @_common.max(s.data) }

pub fn chem_rxn_thermo_slice_to_string(s : ChemrxnthermoSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

