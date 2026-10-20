///===
/// extcore/chem_mol_props_mw

pub(all) struct ChemmolpropsmwPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_mol_props_mw_make_point(x : Double, y : Double) -> ChemmolpropsmwPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_mol_props_mw_make_point3(x : Double, y : Double, z : Double) -> ChemmolpropsmwPoint {
  { x, y, z, label: 0 }
}

pub fn ChemmolpropsmwPoint::x(self : ChemmolpropsmwPoint) -> Double { self.x }

pub fn ChemmolpropsmwPoint::y(self : ChemmolpropsmwPoint) -> Double { self.y }

pub fn ChemmolpropsmwPoint::z(self : ChemmolpropsmwPoint) -> Double { self.z }

pub fn ChemmolpropsmwPoint::label(self : ChemmolpropsmwPoint) -> Int { self.label }

pub fn ChemmolpropsmwPoint::dist(self : ChemmolpropsmwPoint, other : ChemmolpropsmwPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemmolpropsmwPoint::add(self : ChemmolpropsmwPoint, other : ChemmolpropsmwPoint) -> ChemmolpropsmwPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemmolpropsmwPoint::sub(self : ChemmolpropsmwPoint, other : ChemmolpropsmwPoint) -> ChemmolpropsmwPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemmolpropsmwPoint::scale(self : ChemmolpropsmwPoint, s : Double) -> ChemmolpropsmwPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemmolpropsmwPoint::dot(self : ChemmolpropsmwPoint, other : ChemmolpropsmwPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemmolpropsmwPoint::cross(self : ChemmolpropsmwPoint, other : ChemmolpropsmwPoint) -> ChemmolpropsmwPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemmolpropsmwPoint::norm(self : ChemmolpropsmwPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemmolpropsmwPoint::normalize(self : ChemmolpropsmwPoint) -> ChemmolpropsmwPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolpropsmwPoint::negate(self : ChemmolpropsmwPoint) -> ChemmolpropsmwPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemmolpropsmwPoint::mid(self : ChemmolpropsmwPoint, other : ChemmolpropsmwPoint) -> ChemmolpropsmwPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemmolpropsmwPoint::lerp(self : ChemmolpropsmwPoint, other : ChemmolpropsmwPoint, t : Double) -> ChemmolpropsmwPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemmolpropsmwPoint::to_string(self : ChemmolpropsmwPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemmolpropsmwSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_mol_props_mw_make_series(vals : Array[Double], name : String) -> ChemmolpropsmwSeries {
  { vals, name, meta: 0 }
}

pub fn ChemmolpropsmwSeries::len(self : ChemmolpropsmwSeries) -> Int { self.vals.length() }

pub fn ChemmolpropsmwSeries::sum(self : ChemmolpropsmwSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemmolpropsmwSeries::mean(self : ChemmolpropsmwSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemmolpropsmwSeries::min(self : ChemmolpropsmwSeries) -> Double { @_common.min(self.vals) }

pub fn ChemmolpropsmwSeries::max(self : ChemmolpropsmwSeries) -> Double { @_common.max(self.vals) }

pub fn ChemmolpropsmwSeries::range(self : ChemmolpropsmwSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemmolpropsmwSeries::variance(self : ChemmolpropsmwSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemmolpropsmwSeries::std(self : ChemmolpropsmwSeries) -> Double { @_common.std(self.vals) }

pub fn ChemmolpropsmwSeries::median(self : ChemmolpropsmwSeries) -> Double { @_common.median(self.vals) }

pub fn ChemmolpropsmwSeries::scale(self : ChemmolpropsmwSeries, f : Double) -> ChemmolpropsmwSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemmolpropsmwSeries::add(self : ChemmolpropsmwSeries, other : ChemmolpropsmwSeries) -> ChemmolpropsmwSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemmolpropsmwSeries::sub(self : ChemmolpropsmwSeries, other : ChemmolpropsmwSeries) -> ChemmolpropsmwSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemmolpropsmwSeries::normalize(self : ChemmolpropsmwSeries) -> ChemmolpropsmwSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemmolpropsmwSeries::cumsum(self : ChemmolpropsmwSeries) -> ChemmolpropsmwSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemmolpropsmwSeries::to_string(self : ChemmolpropsmwSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolpropsmwMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_mol_props_mw_make_matrix(rows : Int, cols : Int, val : Double) -> ChemmolpropsmwMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_mol_props_mw_matrix_identity(n : Int) -> ChemmolpropsmwMatrix {
  let m = chem_mol_props_mw_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemmolpropsmwMatrix::get(self : ChemmolpropsmwMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemmolpropsmwMatrix::transpose(self : ChemmolpropsmwMatrix) -> ChemmolpropsmwMatrix {
  let result = chem_mol_props_mw_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemmolpropsmwMatrix::add(self : ChemmolpropsmwMatrix, other : ChemmolpropsmwMatrix) -> ChemmolpropsmwMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_mol_props_mw_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemmolpropsmwMatrix::scale(self : ChemmolpropsmwMatrix, s : Double) -> ChemmolpropsmwMatrix {
  let result = chem_mol_props_mw_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemmolpropsmwMatrix::multiply(self : ChemmolpropsmwMatrix, other : ChemmolpropsmwMatrix) -> ChemmolpropsmwMatrix {
  if self.cols != other.rows { return chem_mol_props_mw_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_mol_props_mw_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ChemmolpropsmwMatrix::trace(self : ChemmolpropsmwMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemmolpropsmwMatrix::det(self : ChemmolpropsmwMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemmolpropsmwMatrix::norm(self : ChemmolpropsmwMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemmolpropsmwMatrix::to_string(self : ChemmolpropsmwMatrix) -> String {
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

pub(all) struct ChemmolpropsmwVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_mol_props_mw_make_vector(comps : Array[Double]) -> ChemmolpropsmwVector {
  { comps, dim: comps.length() }
}

pub fn chem_mol_props_mw_vector_zero(dim : Int) -> ChemmolpropsmwVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemmolpropsmwVector::add(self : ChemmolpropsmwVector, other : ChemmolpropsmwVector) -> ChemmolpropsmwVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolpropsmwVector::sub(self : ChemmolpropsmwVector, other : ChemmolpropsmwVector) -> ChemmolpropsmwVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolpropsmwVector::scale(self : ChemmolpropsmwVector, s : Double) -> ChemmolpropsmwVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemmolpropsmwVector::dot(self : ChemmolpropsmwVector, other : ChemmolpropsmwVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemmolpropsmwVector::norm(self : ChemmolpropsmwVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemmolpropsmwVector::normalize(self : ChemmolpropsmwVector) -> ChemmolpropsmwVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolpropsmwVector::dist(self : ChemmolpropsmwVector, other : ChemmolpropsmwVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemmolpropsmwVector::to_string(self : ChemmolpropsmwVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_mol_props_mw_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_mol_props_mw_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_mol_props_mw_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_mol_props_mw_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_mol_props_mw_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_mol_props_mw_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_mol_props_mw_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_mol_props_mw_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_mol_props_mw_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_mol_props_mw_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_mol_props_mw_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_mol_props_mw_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_mol_props_mw_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_mol_props_mw_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_mol_props_mw_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_mol_props_mw_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_mol_props_mw_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_mol_props_mw_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_mol_props_mw_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_mol_props_mw_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_mol_props_mw_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_mol_props_mw_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_mol_props_mw_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_mol_props_mw_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_mol_props_mw_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_mol_props_mw_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_mol_props_mw_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_mol_props_mw_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_mol_props_mw_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemmolpropsmwFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_mw_frame_make(size : Int) -> ChemmolpropsmwFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_mw_frame_len(s : ChemmolpropsmwFrame) -> Int { s.size }

pub fn chem_mol_props_mw_frame_get(s : ChemmolpropsmwFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_mw_frame_set(s : ChemmolpropsmwFrame, i : Int, v : Double) -> ChemmolpropsmwFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_frame_sum(s : ChemmolpropsmwFrame) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_mw_frame_mean(s : ChemmolpropsmwFrame) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_mw_frame_scale(s : ChemmolpropsmwFrame, f : Double) -> ChemmolpropsmwFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_frame_add(a : ChemmolpropsmwFrame, b : ChemmolpropsmwFrame) -> ChemmolpropsmwFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_mw_frame_copy(s : ChemmolpropsmwFrame) -> ChemmolpropsmwFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_frame_fill(s : ChemmolpropsmwFrame, v : Double) -> ChemmolpropsmwFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_frame_min(s : ChemmolpropsmwFrame) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_mw_frame_max(s : ChemmolpropsmwFrame) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_mw_frame_to_string(s : ChemmolpropsmwFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsmwTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_mw_table_make(size : Int) -> ChemmolpropsmwTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_mw_table_len(s : ChemmolpropsmwTable) -> Int { s.size }

pub fn chem_mol_props_mw_table_get(s : ChemmolpropsmwTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_mw_table_set(s : ChemmolpropsmwTable, i : Int, v : Double) -> ChemmolpropsmwTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_table_sum(s : ChemmolpropsmwTable) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_mw_table_mean(s : ChemmolpropsmwTable) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_mw_table_scale(s : ChemmolpropsmwTable, f : Double) -> ChemmolpropsmwTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_table_add(a : ChemmolpropsmwTable, b : ChemmolpropsmwTable) -> ChemmolpropsmwTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_mw_table_copy(s : ChemmolpropsmwTable) -> ChemmolpropsmwTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_table_fill(s : ChemmolpropsmwTable, v : Double) -> ChemmolpropsmwTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_table_min(s : ChemmolpropsmwTable) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_mw_table_max(s : ChemmolpropsmwTable) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_mw_table_to_string(s : ChemmolpropsmwTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsmwGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_mw_graphn_make(size : Int) -> ChemmolpropsmwGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_mw_graphn_len(s : ChemmolpropsmwGraphN) -> Int { s.size }

pub fn chem_mol_props_mw_graphn_get(s : ChemmolpropsmwGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_mw_graphn_set(s : ChemmolpropsmwGraphN, i : Int, v : Double) -> ChemmolpropsmwGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_graphn_sum(s : ChemmolpropsmwGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_mw_graphn_mean(s : ChemmolpropsmwGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_mw_graphn_scale(s : ChemmolpropsmwGraphN, f : Double) -> ChemmolpropsmwGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_graphn_add(a : ChemmolpropsmwGraphN, b : ChemmolpropsmwGraphN) -> ChemmolpropsmwGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_mw_graphn_copy(s : ChemmolpropsmwGraphN) -> ChemmolpropsmwGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_graphn_fill(s : ChemmolpropsmwGraphN, v : Double) -> ChemmolpropsmwGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_graphn_min(s : ChemmolpropsmwGraphN) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_mw_graphn_max(s : ChemmolpropsmwGraphN) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_mw_graphn_to_string(s : ChemmolpropsmwGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsmwNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_mw_node_make(size : Int) -> ChemmolpropsmwNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_mw_node_len(s : ChemmolpropsmwNode) -> Int { s.size }

pub fn chem_mol_props_mw_node_get(s : ChemmolpropsmwNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_mw_node_set(s : ChemmolpropsmwNode, i : Int, v : Double) -> ChemmolpropsmwNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_node_sum(s : ChemmolpropsmwNode) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_mw_node_mean(s : ChemmolpropsmwNode) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_mw_node_scale(s : ChemmolpropsmwNode, f : Double) -> ChemmolpropsmwNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_node_add(a : ChemmolpropsmwNode, b : ChemmolpropsmwNode) -> ChemmolpropsmwNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_mw_node_copy(s : ChemmolpropsmwNode) -> ChemmolpropsmwNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_node_fill(s : ChemmolpropsmwNode, v : Double) -> ChemmolpropsmwNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_node_min(s : ChemmolpropsmwNode) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_mw_node_max(s : ChemmolpropsmwNode) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_mw_node_to_string(s : ChemmolpropsmwNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsmwEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_mw_edge_make(size : Int) -> ChemmolpropsmwEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_mw_edge_len(s : ChemmolpropsmwEdge) -> Int { s.size }

pub fn chem_mol_props_mw_edge_get(s : ChemmolpropsmwEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_mw_edge_set(s : ChemmolpropsmwEdge, i : Int, v : Double) -> ChemmolpropsmwEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_edge_sum(s : ChemmolpropsmwEdge) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_mw_edge_mean(s : ChemmolpropsmwEdge) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_mw_edge_scale(s : ChemmolpropsmwEdge, f : Double) -> ChemmolpropsmwEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_edge_add(a : ChemmolpropsmwEdge, b : ChemmolpropsmwEdge) -> ChemmolpropsmwEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_mw_edge_copy(s : ChemmolpropsmwEdge) -> ChemmolpropsmwEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_edge_fill(s : ChemmolpropsmwEdge, v : Double) -> ChemmolpropsmwEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_edge_min(s : ChemmolpropsmwEdge) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_mw_edge_max(s : ChemmolpropsmwEdge) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_mw_edge_to_string(s : ChemmolpropsmwEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsmwPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_mw_path_make(size : Int) -> ChemmolpropsmwPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_mw_path_len(s : ChemmolpropsmwPath) -> Int { s.size }

pub fn chem_mol_props_mw_path_get(s : ChemmolpropsmwPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_mw_path_set(s : ChemmolpropsmwPath, i : Int, v : Double) -> ChemmolpropsmwPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_path_sum(s : ChemmolpropsmwPath) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_mw_path_mean(s : ChemmolpropsmwPath) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_mw_path_scale(s : ChemmolpropsmwPath, f : Double) -> ChemmolpropsmwPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_path_add(a : ChemmolpropsmwPath, b : ChemmolpropsmwPath) -> ChemmolpropsmwPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_mw_path_copy(s : ChemmolpropsmwPath) -> ChemmolpropsmwPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_path_fill(s : ChemmolpropsmwPath, v : Double) -> ChemmolpropsmwPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_path_min(s : ChemmolpropsmwPath) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_mw_path_max(s : ChemmolpropsmwPath) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_mw_path_to_string(s : ChemmolpropsmwPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsmwCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_mw_cluster_make(size : Int) -> ChemmolpropsmwCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_mw_cluster_len(s : ChemmolpropsmwCluster) -> Int { s.size }

pub fn chem_mol_props_mw_cluster_get(s : ChemmolpropsmwCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_mw_cluster_set(s : ChemmolpropsmwCluster, i : Int, v : Double) -> ChemmolpropsmwCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_cluster_sum(s : ChemmolpropsmwCluster) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_mw_cluster_mean(s : ChemmolpropsmwCluster) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_mw_cluster_scale(s : ChemmolpropsmwCluster, f : Double) -> ChemmolpropsmwCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_cluster_add(a : ChemmolpropsmwCluster, b : ChemmolpropsmwCluster) -> ChemmolpropsmwCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_mw_cluster_copy(s : ChemmolpropsmwCluster) -> ChemmolpropsmwCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_cluster_fill(s : ChemmolpropsmwCluster, v : Double) -> ChemmolpropsmwCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_cluster_min(s : ChemmolpropsmwCluster) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_mw_cluster_max(s : ChemmolpropsmwCluster) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_mw_cluster_to_string(s : ChemmolpropsmwCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsmwModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_mw_model_make(size : Int) -> ChemmolpropsmwModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_mw_model_len(s : ChemmolpropsmwModel) -> Int { s.size }

pub fn chem_mol_props_mw_model_get(s : ChemmolpropsmwModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_mw_model_set(s : ChemmolpropsmwModel, i : Int, v : Double) -> ChemmolpropsmwModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_model_sum(s : ChemmolpropsmwModel) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_mw_model_mean(s : ChemmolpropsmwModel) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_mw_model_scale(s : ChemmolpropsmwModel, f : Double) -> ChemmolpropsmwModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_model_add(a : ChemmolpropsmwModel, b : ChemmolpropsmwModel) -> ChemmolpropsmwModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_mw_model_copy(s : ChemmolpropsmwModel) -> ChemmolpropsmwModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_model_fill(s : ChemmolpropsmwModel, v : Double) -> ChemmolpropsmwModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_model_min(s : ChemmolpropsmwModel) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_mw_model_max(s : ChemmolpropsmwModel) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_mw_model_to_string(s : ChemmolpropsmwModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsmwLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_mw_layer_make(size : Int) -> ChemmolpropsmwLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_mw_layer_len(s : ChemmolpropsmwLayer) -> Int { s.size }

pub fn chem_mol_props_mw_layer_get(s : ChemmolpropsmwLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_mw_layer_set(s : ChemmolpropsmwLayer, i : Int, v : Double) -> ChemmolpropsmwLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_layer_sum(s : ChemmolpropsmwLayer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_mw_layer_mean(s : ChemmolpropsmwLayer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_mw_layer_scale(s : ChemmolpropsmwLayer, f : Double) -> ChemmolpropsmwLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_layer_add(a : ChemmolpropsmwLayer, b : ChemmolpropsmwLayer) -> ChemmolpropsmwLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_mw_layer_copy(s : ChemmolpropsmwLayer) -> ChemmolpropsmwLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_layer_fill(s : ChemmolpropsmwLayer, v : Double) -> ChemmolpropsmwLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_layer_min(s : ChemmolpropsmwLayer) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_mw_layer_max(s : ChemmolpropsmwLayer) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_mw_layer_to_string(s : ChemmolpropsmwLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsmwBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_mw_buffer_make(size : Int) -> ChemmolpropsmwBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_mw_buffer_len(s : ChemmolpropsmwBuffer) -> Int { s.size }

pub fn chem_mol_props_mw_buffer_get(s : ChemmolpropsmwBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_mw_buffer_set(s : ChemmolpropsmwBuffer, i : Int, v : Double) -> ChemmolpropsmwBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_buffer_sum(s : ChemmolpropsmwBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_mw_buffer_mean(s : ChemmolpropsmwBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_mw_buffer_scale(s : ChemmolpropsmwBuffer, f : Double) -> ChemmolpropsmwBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_buffer_add(a : ChemmolpropsmwBuffer, b : ChemmolpropsmwBuffer) -> ChemmolpropsmwBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_mw_buffer_copy(s : ChemmolpropsmwBuffer) -> ChemmolpropsmwBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_buffer_fill(s : ChemmolpropsmwBuffer, v : Double) -> ChemmolpropsmwBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_buffer_min(s : ChemmolpropsmwBuffer) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_mw_buffer_max(s : ChemmolpropsmwBuffer) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_mw_buffer_to_string(s : ChemmolpropsmwBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsmwCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_mw_cursor_make(size : Int) -> ChemmolpropsmwCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_mw_cursor_len(s : ChemmolpropsmwCursor) -> Int { s.size }

pub fn chem_mol_props_mw_cursor_get(s : ChemmolpropsmwCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_mw_cursor_set(s : ChemmolpropsmwCursor, i : Int, v : Double) -> ChemmolpropsmwCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_cursor_sum(s : ChemmolpropsmwCursor) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_mw_cursor_mean(s : ChemmolpropsmwCursor) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_mw_cursor_scale(s : ChemmolpropsmwCursor, f : Double) -> ChemmolpropsmwCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_cursor_add(a : ChemmolpropsmwCursor, b : ChemmolpropsmwCursor) -> ChemmolpropsmwCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_mw_cursor_copy(s : ChemmolpropsmwCursor) -> ChemmolpropsmwCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_cursor_fill(s : ChemmolpropsmwCursor, v : Double) -> ChemmolpropsmwCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_cursor_min(s : ChemmolpropsmwCursor) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_mw_cursor_max(s : ChemmolpropsmwCursor) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_mw_cursor_to_string(s : ChemmolpropsmwCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsmwView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_mw_view_make(size : Int) -> ChemmolpropsmwView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_mw_view_len(s : ChemmolpropsmwView) -> Int { s.size }

pub fn chem_mol_props_mw_view_get(s : ChemmolpropsmwView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_mw_view_set(s : ChemmolpropsmwView, i : Int, v : Double) -> ChemmolpropsmwView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_view_sum(s : ChemmolpropsmwView) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_mw_view_mean(s : ChemmolpropsmwView) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_mw_view_scale(s : ChemmolpropsmwView, f : Double) -> ChemmolpropsmwView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_view_add(a : ChemmolpropsmwView, b : ChemmolpropsmwView) -> ChemmolpropsmwView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_mw_view_copy(s : ChemmolpropsmwView) -> ChemmolpropsmwView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_view_fill(s : ChemmolpropsmwView, v : Double) -> ChemmolpropsmwView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_view_min(s : ChemmolpropsmwView) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_mw_view_max(s : ChemmolpropsmwView) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_mw_view_to_string(s : ChemmolpropsmwView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsmwRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_mw_range_make(size : Int) -> ChemmolpropsmwRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_mw_range_len(s : ChemmolpropsmwRange) -> Int { s.size }

pub fn chem_mol_props_mw_range_get(s : ChemmolpropsmwRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_mw_range_set(s : ChemmolpropsmwRange, i : Int, v : Double) -> ChemmolpropsmwRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_range_sum(s : ChemmolpropsmwRange) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_mw_range_mean(s : ChemmolpropsmwRange) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_mw_range_scale(s : ChemmolpropsmwRange, f : Double) -> ChemmolpropsmwRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_range_add(a : ChemmolpropsmwRange, b : ChemmolpropsmwRange) -> ChemmolpropsmwRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_mw_range_copy(s : ChemmolpropsmwRange) -> ChemmolpropsmwRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_range_fill(s : ChemmolpropsmwRange, v : Double) -> ChemmolpropsmwRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_range_min(s : ChemmolpropsmwRange) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_mw_range_max(s : ChemmolpropsmwRange) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_mw_range_to_string(s : ChemmolpropsmwRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsmwSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_mw_slice_make(size : Int) -> ChemmolpropsmwSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_mw_slice_len(s : ChemmolpropsmwSlice) -> Int { s.size }

pub fn chem_mol_props_mw_slice_get(s : ChemmolpropsmwSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_mw_slice_set(s : ChemmolpropsmwSlice, i : Int, v : Double) -> ChemmolpropsmwSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_slice_sum(s : ChemmolpropsmwSlice) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_mw_slice_mean(s : ChemmolpropsmwSlice) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_mw_slice_scale(s : ChemmolpropsmwSlice, f : Double) -> ChemmolpropsmwSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_slice_add(a : ChemmolpropsmwSlice, b : ChemmolpropsmwSlice) -> ChemmolpropsmwSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_mw_slice_copy(s : ChemmolpropsmwSlice) -> ChemmolpropsmwSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_slice_fill(s : ChemmolpropsmwSlice, v : Double) -> ChemmolpropsmwSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_mw_slice_min(s : ChemmolpropsmwSlice) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_mw_slice_max(s : ChemmolpropsmwSlice) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_mw_slice_to_string(s : ChemmolpropsmwSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

