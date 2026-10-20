///===
/// extcore/chem_rxn_retro

pub(all) struct ChemrxnretroPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_rxn_retro_make_point(x : Double, y : Double) -> ChemrxnretroPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_rxn_retro_make_point3(x : Double, y : Double, z : Double) -> ChemrxnretroPoint {
  { x, y, z, label: 0 }
}

pub fn ChemrxnretroPoint::x(self : ChemrxnretroPoint) -> Double { self.x }

pub fn ChemrxnretroPoint::y(self : ChemrxnretroPoint) -> Double { self.y }

pub fn ChemrxnretroPoint::z(self : ChemrxnretroPoint) -> Double { self.z }

pub fn ChemrxnretroPoint::label(self : ChemrxnretroPoint) -> Int { self.label }

pub fn ChemrxnretroPoint::dist(self : ChemrxnretroPoint, other : ChemrxnretroPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemrxnretroPoint::add(self : ChemrxnretroPoint, other : ChemrxnretroPoint) -> ChemrxnretroPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemrxnretroPoint::sub(self : ChemrxnretroPoint, other : ChemrxnretroPoint) -> ChemrxnretroPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemrxnretroPoint::scale(self : ChemrxnretroPoint, s : Double) -> ChemrxnretroPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemrxnretroPoint::dot(self : ChemrxnretroPoint, other : ChemrxnretroPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemrxnretroPoint::cross(self : ChemrxnretroPoint, other : ChemrxnretroPoint) -> ChemrxnretroPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemrxnretroPoint::norm(self : ChemrxnretroPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemrxnretroPoint::normalize(self : ChemrxnretroPoint) -> ChemrxnretroPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemrxnretroPoint::negate(self : ChemrxnretroPoint) -> ChemrxnretroPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemrxnretroPoint::mid(self : ChemrxnretroPoint, other : ChemrxnretroPoint) -> ChemrxnretroPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemrxnretroPoint::lerp(self : ChemrxnretroPoint, other : ChemrxnretroPoint, t : Double) -> ChemrxnretroPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemrxnretroPoint::to_string(self : ChemrxnretroPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemrxnretroSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_rxn_retro_make_series(vals : Array[Double], name : String) -> ChemrxnretroSeries {
  { vals, name, meta: 0 }
}

pub fn ChemrxnretroSeries::len(self : ChemrxnretroSeries) -> Int { self.vals.length() }

pub fn ChemrxnretroSeries::sum(self : ChemrxnretroSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemrxnretroSeries::mean(self : ChemrxnretroSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemrxnretroSeries::min(self : ChemrxnretroSeries) -> Double { @_common.min(self.vals) }

pub fn ChemrxnretroSeries::max(self : ChemrxnretroSeries) -> Double { @_common.max(self.vals) }

pub fn ChemrxnretroSeries::range(self : ChemrxnretroSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemrxnretroSeries::variance(self : ChemrxnretroSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemrxnretroSeries::std(self : ChemrxnretroSeries) -> Double { @_common.std(self.vals) }

pub fn ChemrxnretroSeries::median(self : ChemrxnretroSeries) -> Double { @_common.median(self.vals) }

pub fn ChemrxnretroSeries::scale(self : ChemrxnretroSeries, f : Double) -> ChemrxnretroSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemrxnretroSeries::add(self : ChemrxnretroSeries, other : ChemrxnretroSeries) -> ChemrxnretroSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemrxnretroSeries::sub(self : ChemrxnretroSeries, other : ChemrxnretroSeries) -> ChemrxnretroSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemrxnretroSeries::normalize(self : ChemrxnretroSeries) -> ChemrxnretroSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemrxnretroSeries::cumsum(self : ChemrxnretroSeries) -> ChemrxnretroSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemrxnretroSeries::to_string(self : ChemrxnretroSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemrxnretroMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_rxn_retro_make_matrix(rows : Int, cols : Int, val : Double) -> ChemrxnretroMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_rxn_retro_matrix_identity(n : Int) -> ChemrxnretroMatrix {
  let m = chem_rxn_retro_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemrxnretroMatrix::get(self : ChemrxnretroMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemrxnretroMatrix::transpose(self : ChemrxnretroMatrix) -> ChemrxnretroMatrix {
  let result = chem_rxn_retro_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemrxnretroMatrix::add(self : ChemrxnretroMatrix, other : ChemrxnretroMatrix) -> ChemrxnretroMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_rxn_retro_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemrxnretroMatrix::scale(self : ChemrxnretroMatrix, s : Double) -> ChemrxnretroMatrix {
  let result = chem_rxn_retro_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemrxnretroMatrix::multiply(self : ChemrxnretroMatrix, other : ChemrxnretroMatrix) -> ChemrxnretroMatrix {
  if self.cols != other.rows { return chem_rxn_retro_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_rxn_retro_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ChemrxnretroMatrix::trace(self : ChemrxnretroMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemrxnretroMatrix::det(self : ChemrxnretroMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemrxnretroMatrix::norm(self : ChemrxnretroMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemrxnretroMatrix::to_string(self : ChemrxnretroMatrix) -> String {
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

pub(all) struct ChemrxnretroVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_rxn_retro_make_vector(comps : Array[Double]) -> ChemrxnretroVector {
  { comps, dim: comps.length() }
}

pub fn chem_rxn_retro_vector_zero(dim : Int) -> ChemrxnretroVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemrxnretroVector::add(self : ChemrxnretroVector, other : ChemrxnretroVector) -> ChemrxnretroVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemrxnretroVector::sub(self : ChemrxnretroVector, other : ChemrxnretroVector) -> ChemrxnretroVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemrxnretroVector::scale(self : ChemrxnretroVector, s : Double) -> ChemrxnretroVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemrxnretroVector::dot(self : ChemrxnretroVector, other : ChemrxnretroVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemrxnretroVector::norm(self : ChemrxnretroVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemrxnretroVector::normalize(self : ChemrxnretroVector) -> ChemrxnretroVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemrxnretroVector::dist(self : ChemrxnretroVector, other : ChemrxnretroVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemrxnretroVector::to_string(self : ChemrxnretroVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_rxn_retro_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_rxn_retro_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_rxn_retro_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_rxn_retro_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_rxn_retro_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_rxn_retro_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_rxn_retro_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_rxn_retro_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_rxn_retro_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_rxn_retro_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_rxn_retro_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_rxn_retro_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_rxn_retro_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_rxn_retro_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_rxn_retro_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_rxn_retro_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_rxn_retro_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_rxn_retro_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_rxn_retro_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_rxn_retro_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_rxn_retro_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_rxn_retro_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_rxn_retro_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_rxn_retro_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_rxn_retro_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_rxn_retro_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_rxn_retro_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_rxn_retro_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_rxn_retro_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemrxnretroFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_retro_frame_make(size : Int) -> ChemrxnretroFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_retro_frame_len(s : ChemrxnretroFrame) -> Int { s.size }

pub fn chem_rxn_retro_frame_get(s : ChemrxnretroFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_retro_frame_set(s : ChemrxnretroFrame, i : Int, v : Double) -> ChemrxnretroFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_frame_sum(s : ChemrxnretroFrame) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_retro_frame_mean(s : ChemrxnretroFrame) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_retro_frame_scale(s : ChemrxnretroFrame, f : Double) -> ChemrxnretroFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_frame_add(a : ChemrxnretroFrame, b : ChemrxnretroFrame) -> ChemrxnretroFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_retro_frame_copy(s : ChemrxnretroFrame) -> ChemrxnretroFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_frame_fill(s : ChemrxnretroFrame, v : Double) -> ChemrxnretroFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_frame_min(s : ChemrxnretroFrame) -> Double { @_common.min(s.data) }

pub fn chem_rxn_retro_frame_max(s : ChemrxnretroFrame) -> Double { @_common.max(s.data) }

pub fn chem_rxn_retro_frame_to_string(s : ChemrxnretroFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnretroTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_retro_table_make(size : Int) -> ChemrxnretroTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_retro_table_len(s : ChemrxnretroTable) -> Int { s.size }

pub fn chem_rxn_retro_table_get(s : ChemrxnretroTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_retro_table_set(s : ChemrxnretroTable, i : Int, v : Double) -> ChemrxnretroTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_table_sum(s : ChemrxnretroTable) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_retro_table_mean(s : ChemrxnretroTable) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_retro_table_scale(s : ChemrxnretroTable, f : Double) -> ChemrxnretroTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_table_add(a : ChemrxnretroTable, b : ChemrxnretroTable) -> ChemrxnretroTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_retro_table_copy(s : ChemrxnretroTable) -> ChemrxnretroTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_table_fill(s : ChemrxnretroTable, v : Double) -> ChemrxnretroTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_table_min(s : ChemrxnretroTable) -> Double { @_common.min(s.data) }

pub fn chem_rxn_retro_table_max(s : ChemrxnretroTable) -> Double { @_common.max(s.data) }

pub fn chem_rxn_retro_table_to_string(s : ChemrxnretroTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnretroGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_retro_graphn_make(size : Int) -> ChemrxnretroGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_retro_graphn_len(s : ChemrxnretroGraphN) -> Int { s.size }

pub fn chem_rxn_retro_graphn_get(s : ChemrxnretroGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_retro_graphn_set(s : ChemrxnretroGraphN, i : Int, v : Double) -> ChemrxnretroGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_graphn_sum(s : ChemrxnretroGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_retro_graphn_mean(s : ChemrxnretroGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_retro_graphn_scale(s : ChemrxnretroGraphN, f : Double) -> ChemrxnretroGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_graphn_add(a : ChemrxnretroGraphN, b : ChemrxnretroGraphN) -> ChemrxnretroGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_retro_graphn_copy(s : ChemrxnretroGraphN) -> ChemrxnretroGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_graphn_fill(s : ChemrxnretroGraphN, v : Double) -> ChemrxnretroGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_graphn_min(s : ChemrxnretroGraphN) -> Double { @_common.min(s.data) }

pub fn chem_rxn_retro_graphn_max(s : ChemrxnretroGraphN) -> Double { @_common.max(s.data) }

pub fn chem_rxn_retro_graphn_to_string(s : ChemrxnretroGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnretroNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_retro_node_make(size : Int) -> ChemrxnretroNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_retro_node_len(s : ChemrxnretroNode) -> Int { s.size }

pub fn chem_rxn_retro_node_get(s : ChemrxnretroNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_retro_node_set(s : ChemrxnretroNode, i : Int, v : Double) -> ChemrxnretroNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_node_sum(s : ChemrxnretroNode) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_retro_node_mean(s : ChemrxnretroNode) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_retro_node_scale(s : ChemrxnretroNode, f : Double) -> ChemrxnretroNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_node_add(a : ChemrxnretroNode, b : ChemrxnretroNode) -> ChemrxnretroNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_retro_node_copy(s : ChemrxnretroNode) -> ChemrxnretroNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_node_fill(s : ChemrxnretroNode, v : Double) -> ChemrxnretroNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_node_min(s : ChemrxnretroNode) -> Double { @_common.min(s.data) }

pub fn chem_rxn_retro_node_max(s : ChemrxnretroNode) -> Double { @_common.max(s.data) }

pub fn chem_rxn_retro_node_to_string(s : ChemrxnretroNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnretroEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_retro_edge_make(size : Int) -> ChemrxnretroEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_retro_edge_len(s : ChemrxnretroEdge) -> Int { s.size }

pub fn chem_rxn_retro_edge_get(s : ChemrxnretroEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_retro_edge_set(s : ChemrxnretroEdge, i : Int, v : Double) -> ChemrxnretroEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_edge_sum(s : ChemrxnretroEdge) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_retro_edge_mean(s : ChemrxnretroEdge) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_retro_edge_scale(s : ChemrxnretroEdge, f : Double) -> ChemrxnretroEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_edge_add(a : ChemrxnretroEdge, b : ChemrxnretroEdge) -> ChemrxnretroEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_retro_edge_copy(s : ChemrxnretroEdge) -> ChemrxnretroEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_edge_fill(s : ChemrxnretroEdge, v : Double) -> ChemrxnretroEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_edge_min(s : ChemrxnretroEdge) -> Double { @_common.min(s.data) }

pub fn chem_rxn_retro_edge_max(s : ChemrxnretroEdge) -> Double { @_common.max(s.data) }

pub fn chem_rxn_retro_edge_to_string(s : ChemrxnretroEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnretroPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_retro_path_make(size : Int) -> ChemrxnretroPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_retro_path_len(s : ChemrxnretroPath) -> Int { s.size }

pub fn chem_rxn_retro_path_get(s : ChemrxnretroPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_retro_path_set(s : ChemrxnretroPath, i : Int, v : Double) -> ChemrxnretroPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_path_sum(s : ChemrxnretroPath) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_retro_path_mean(s : ChemrxnretroPath) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_retro_path_scale(s : ChemrxnretroPath, f : Double) -> ChemrxnretroPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_path_add(a : ChemrxnretroPath, b : ChemrxnretroPath) -> ChemrxnretroPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_retro_path_copy(s : ChemrxnretroPath) -> ChemrxnretroPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_path_fill(s : ChemrxnretroPath, v : Double) -> ChemrxnretroPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_path_min(s : ChemrxnretroPath) -> Double { @_common.min(s.data) }

pub fn chem_rxn_retro_path_max(s : ChemrxnretroPath) -> Double { @_common.max(s.data) }

pub fn chem_rxn_retro_path_to_string(s : ChemrxnretroPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnretroCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_retro_cluster_make(size : Int) -> ChemrxnretroCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_retro_cluster_len(s : ChemrxnretroCluster) -> Int { s.size }

pub fn chem_rxn_retro_cluster_get(s : ChemrxnretroCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_retro_cluster_set(s : ChemrxnretroCluster, i : Int, v : Double) -> ChemrxnretroCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_cluster_sum(s : ChemrxnretroCluster) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_retro_cluster_mean(s : ChemrxnretroCluster) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_retro_cluster_scale(s : ChemrxnretroCluster, f : Double) -> ChemrxnretroCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_cluster_add(a : ChemrxnretroCluster, b : ChemrxnretroCluster) -> ChemrxnretroCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_retro_cluster_copy(s : ChemrxnretroCluster) -> ChemrxnretroCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_cluster_fill(s : ChemrxnretroCluster, v : Double) -> ChemrxnretroCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_cluster_min(s : ChemrxnretroCluster) -> Double { @_common.min(s.data) }

pub fn chem_rxn_retro_cluster_max(s : ChemrxnretroCluster) -> Double { @_common.max(s.data) }

pub fn chem_rxn_retro_cluster_to_string(s : ChemrxnretroCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnretroModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_retro_model_make(size : Int) -> ChemrxnretroModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_retro_model_len(s : ChemrxnretroModel) -> Int { s.size }

pub fn chem_rxn_retro_model_get(s : ChemrxnretroModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_retro_model_set(s : ChemrxnretroModel, i : Int, v : Double) -> ChemrxnretroModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_model_sum(s : ChemrxnretroModel) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_retro_model_mean(s : ChemrxnretroModel) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_retro_model_scale(s : ChemrxnretroModel, f : Double) -> ChemrxnretroModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_model_add(a : ChemrxnretroModel, b : ChemrxnretroModel) -> ChemrxnretroModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_retro_model_copy(s : ChemrxnretroModel) -> ChemrxnretroModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_model_fill(s : ChemrxnretroModel, v : Double) -> ChemrxnretroModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_model_min(s : ChemrxnretroModel) -> Double { @_common.min(s.data) }

pub fn chem_rxn_retro_model_max(s : ChemrxnretroModel) -> Double { @_common.max(s.data) }

pub fn chem_rxn_retro_model_to_string(s : ChemrxnretroModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnretroLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_retro_layer_make(size : Int) -> ChemrxnretroLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_retro_layer_len(s : ChemrxnretroLayer) -> Int { s.size }

pub fn chem_rxn_retro_layer_get(s : ChemrxnretroLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_retro_layer_set(s : ChemrxnretroLayer, i : Int, v : Double) -> ChemrxnretroLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_layer_sum(s : ChemrxnretroLayer) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_retro_layer_mean(s : ChemrxnretroLayer) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_retro_layer_scale(s : ChemrxnretroLayer, f : Double) -> ChemrxnretroLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_layer_add(a : ChemrxnretroLayer, b : ChemrxnretroLayer) -> ChemrxnretroLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_retro_layer_copy(s : ChemrxnretroLayer) -> ChemrxnretroLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_layer_fill(s : ChemrxnretroLayer, v : Double) -> ChemrxnretroLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_layer_min(s : ChemrxnretroLayer) -> Double { @_common.min(s.data) }

pub fn chem_rxn_retro_layer_max(s : ChemrxnretroLayer) -> Double { @_common.max(s.data) }

pub fn chem_rxn_retro_layer_to_string(s : ChemrxnretroLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnretroBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_retro_buffer_make(size : Int) -> ChemrxnretroBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_retro_buffer_len(s : ChemrxnretroBuffer) -> Int { s.size }

pub fn chem_rxn_retro_buffer_get(s : ChemrxnretroBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_retro_buffer_set(s : ChemrxnretroBuffer, i : Int, v : Double) -> ChemrxnretroBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_buffer_sum(s : ChemrxnretroBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_retro_buffer_mean(s : ChemrxnretroBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_retro_buffer_scale(s : ChemrxnretroBuffer, f : Double) -> ChemrxnretroBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_buffer_add(a : ChemrxnretroBuffer, b : ChemrxnretroBuffer) -> ChemrxnretroBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_retro_buffer_copy(s : ChemrxnretroBuffer) -> ChemrxnretroBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_buffer_fill(s : ChemrxnretroBuffer, v : Double) -> ChemrxnretroBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_buffer_min(s : ChemrxnretroBuffer) -> Double { @_common.min(s.data) }

pub fn chem_rxn_retro_buffer_max(s : ChemrxnretroBuffer) -> Double { @_common.max(s.data) }

pub fn chem_rxn_retro_buffer_to_string(s : ChemrxnretroBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnretroCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_retro_cursor_make(size : Int) -> ChemrxnretroCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_retro_cursor_len(s : ChemrxnretroCursor) -> Int { s.size }

pub fn chem_rxn_retro_cursor_get(s : ChemrxnretroCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_retro_cursor_set(s : ChemrxnretroCursor, i : Int, v : Double) -> ChemrxnretroCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_cursor_sum(s : ChemrxnretroCursor) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_retro_cursor_mean(s : ChemrxnretroCursor) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_retro_cursor_scale(s : ChemrxnretroCursor, f : Double) -> ChemrxnretroCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_cursor_add(a : ChemrxnretroCursor, b : ChemrxnretroCursor) -> ChemrxnretroCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_retro_cursor_copy(s : ChemrxnretroCursor) -> ChemrxnretroCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_cursor_fill(s : ChemrxnretroCursor, v : Double) -> ChemrxnretroCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_cursor_min(s : ChemrxnretroCursor) -> Double { @_common.min(s.data) }

pub fn chem_rxn_retro_cursor_max(s : ChemrxnretroCursor) -> Double { @_common.max(s.data) }

pub fn chem_rxn_retro_cursor_to_string(s : ChemrxnretroCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnretroView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_retro_view_make(size : Int) -> ChemrxnretroView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_retro_view_len(s : ChemrxnretroView) -> Int { s.size }

pub fn chem_rxn_retro_view_get(s : ChemrxnretroView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_retro_view_set(s : ChemrxnretroView, i : Int, v : Double) -> ChemrxnretroView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_view_sum(s : ChemrxnretroView) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_retro_view_mean(s : ChemrxnretroView) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_retro_view_scale(s : ChemrxnretroView, f : Double) -> ChemrxnretroView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_view_add(a : ChemrxnretroView, b : ChemrxnretroView) -> ChemrxnretroView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_retro_view_copy(s : ChemrxnretroView) -> ChemrxnretroView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_view_fill(s : ChemrxnretroView, v : Double) -> ChemrxnretroView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_view_min(s : ChemrxnretroView) -> Double { @_common.min(s.data) }

pub fn chem_rxn_retro_view_max(s : ChemrxnretroView) -> Double { @_common.max(s.data) }

pub fn chem_rxn_retro_view_to_string(s : ChemrxnretroView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnretroRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_retro_range_make(size : Int) -> ChemrxnretroRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_retro_range_len(s : ChemrxnretroRange) -> Int { s.size }

pub fn chem_rxn_retro_range_get(s : ChemrxnretroRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_retro_range_set(s : ChemrxnretroRange, i : Int, v : Double) -> ChemrxnretroRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_range_sum(s : ChemrxnretroRange) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_retro_range_mean(s : ChemrxnretroRange) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_retro_range_scale(s : ChemrxnretroRange, f : Double) -> ChemrxnretroRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_range_add(a : ChemrxnretroRange, b : ChemrxnretroRange) -> ChemrxnretroRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_retro_range_copy(s : ChemrxnretroRange) -> ChemrxnretroRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_range_fill(s : ChemrxnretroRange, v : Double) -> ChemrxnretroRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_range_min(s : ChemrxnretroRange) -> Double { @_common.min(s.data) }

pub fn chem_rxn_retro_range_max(s : ChemrxnretroRange) -> Double { @_common.max(s.data) }

pub fn chem_rxn_retro_range_to_string(s : ChemrxnretroRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnretroSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_retro_slice_make(size : Int) -> ChemrxnretroSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_retro_slice_len(s : ChemrxnretroSlice) -> Int { s.size }

pub fn chem_rxn_retro_slice_get(s : ChemrxnretroSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_retro_slice_set(s : ChemrxnretroSlice, i : Int, v : Double) -> ChemrxnretroSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_slice_sum(s : ChemrxnretroSlice) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_retro_slice_mean(s : ChemrxnretroSlice) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_retro_slice_scale(s : ChemrxnretroSlice, f : Double) -> ChemrxnretroSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_slice_add(a : ChemrxnretroSlice, b : ChemrxnretroSlice) -> ChemrxnretroSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_retro_slice_copy(s : ChemrxnretroSlice) -> ChemrxnretroSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_slice_fill(s : ChemrxnretroSlice, v : Double) -> ChemrxnretroSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_retro_slice_min(s : ChemrxnretroSlice) -> Double { @_common.min(s.data) }

pub fn chem_rxn_retro_slice_max(s : ChemrxnretroSlice) -> Double { @_common.max(s.data) }

pub fn chem_rxn_retro_slice_to_string(s : ChemrxnretroSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

