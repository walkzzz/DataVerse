///===
/// extcore/chem_mol_props_logp

pub(all) struct ChemmolpropslogpPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_mol_props_logp_make_point(x : Double, y : Double) -> ChemmolpropslogpPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_mol_props_logp_make_point3(x : Double, y : Double, z : Double) -> ChemmolpropslogpPoint {
  { x, y, z, label: 0 }
}

pub fn ChemmolpropslogpPoint::x(self : ChemmolpropslogpPoint) -> Double { self.x }

pub fn ChemmolpropslogpPoint::y(self : ChemmolpropslogpPoint) -> Double { self.y }

pub fn ChemmolpropslogpPoint::z(self : ChemmolpropslogpPoint) -> Double { self.z }

pub fn ChemmolpropslogpPoint::label(self : ChemmolpropslogpPoint) -> Int { self.label }

pub fn ChemmolpropslogpPoint::dist(self : ChemmolpropslogpPoint, other : ChemmolpropslogpPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemmolpropslogpPoint::add(self : ChemmolpropslogpPoint, other : ChemmolpropslogpPoint) -> ChemmolpropslogpPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemmolpropslogpPoint::sub(self : ChemmolpropslogpPoint, other : ChemmolpropslogpPoint) -> ChemmolpropslogpPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemmolpropslogpPoint::scale(self : ChemmolpropslogpPoint, s : Double) -> ChemmolpropslogpPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemmolpropslogpPoint::dot(self : ChemmolpropslogpPoint, other : ChemmolpropslogpPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemmolpropslogpPoint::cross(self : ChemmolpropslogpPoint, other : ChemmolpropslogpPoint) -> ChemmolpropslogpPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemmolpropslogpPoint::norm(self : ChemmolpropslogpPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemmolpropslogpPoint::normalize(self : ChemmolpropslogpPoint) -> ChemmolpropslogpPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolpropslogpPoint::negate(self : ChemmolpropslogpPoint) -> ChemmolpropslogpPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemmolpropslogpPoint::mid(self : ChemmolpropslogpPoint, other : ChemmolpropslogpPoint) -> ChemmolpropslogpPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemmolpropslogpPoint::lerp(self : ChemmolpropslogpPoint, other : ChemmolpropslogpPoint, t : Double) -> ChemmolpropslogpPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemmolpropslogpPoint::to_string(self : ChemmolpropslogpPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemmolpropslogpSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_mol_props_logp_make_series(vals : Array[Double], name : String) -> ChemmolpropslogpSeries {
  { vals, name, meta: 0 }
}

pub fn ChemmolpropslogpSeries::len(self : ChemmolpropslogpSeries) -> Int { self.vals.length() }

pub fn ChemmolpropslogpSeries::sum(self : ChemmolpropslogpSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemmolpropslogpSeries::mean(self : ChemmolpropslogpSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemmolpropslogpSeries::min(self : ChemmolpropslogpSeries) -> Double { @_common.min(self.vals) }

pub fn ChemmolpropslogpSeries::max(self : ChemmolpropslogpSeries) -> Double { @_common.max(self.vals) }

pub fn ChemmolpropslogpSeries::range(self : ChemmolpropslogpSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemmolpropslogpSeries::variance(self : ChemmolpropslogpSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemmolpropslogpSeries::std(self : ChemmolpropslogpSeries) -> Double { @_common.std(self.vals) }

pub fn ChemmolpropslogpSeries::median(self : ChemmolpropslogpSeries) -> Double { @_common.median(self.vals) }

pub fn ChemmolpropslogpSeries::scale(self : ChemmolpropslogpSeries, f : Double) -> ChemmolpropslogpSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemmolpropslogpSeries::add(self : ChemmolpropslogpSeries, other : ChemmolpropslogpSeries) -> ChemmolpropslogpSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemmolpropslogpSeries::sub(self : ChemmolpropslogpSeries, other : ChemmolpropslogpSeries) -> ChemmolpropslogpSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemmolpropslogpSeries::normalize(self : ChemmolpropslogpSeries) -> ChemmolpropslogpSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemmolpropslogpSeries::cumsum(self : ChemmolpropslogpSeries) -> ChemmolpropslogpSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemmolpropslogpSeries::to_string(self : ChemmolpropslogpSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolpropslogpMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_mol_props_logp_make_matrix(rows : Int, cols : Int, val : Double) -> ChemmolpropslogpMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_mol_props_logp_matrix_identity(n : Int) -> ChemmolpropslogpMatrix {
  let m = chem_mol_props_logp_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemmolpropslogpMatrix::get(self : ChemmolpropslogpMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemmolpropslogpMatrix::transpose(self : ChemmolpropslogpMatrix) -> ChemmolpropslogpMatrix {
  let result = chem_mol_props_logp_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemmolpropslogpMatrix::add(self : ChemmolpropslogpMatrix, other : ChemmolpropslogpMatrix) -> ChemmolpropslogpMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_mol_props_logp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemmolpropslogpMatrix::scale(self : ChemmolpropslogpMatrix, s : Double) -> ChemmolpropslogpMatrix {
  let result = chem_mol_props_logp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemmolpropslogpMatrix::multiply(self : ChemmolpropslogpMatrix, other : ChemmolpropslogpMatrix) -> ChemmolpropslogpMatrix {
  if self.cols != other.rows { return chem_mol_props_logp_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_mol_props_logp_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ChemmolpropslogpMatrix::trace(self : ChemmolpropslogpMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemmolpropslogpMatrix::det(self : ChemmolpropslogpMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemmolpropslogpMatrix::norm(self : ChemmolpropslogpMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemmolpropslogpMatrix::to_string(self : ChemmolpropslogpMatrix) -> String {
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

pub(all) struct ChemmolpropslogpVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_mol_props_logp_make_vector(comps : Array[Double]) -> ChemmolpropslogpVector {
  { comps, dim: comps.length() }
}

pub fn chem_mol_props_logp_vector_zero(dim : Int) -> ChemmolpropslogpVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemmolpropslogpVector::add(self : ChemmolpropslogpVector, other : ChemmolpropslogpVector) -> ChemmolpropslogpVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolpropslogpVector::sub(self : ChemmolpropslogpVector, other : ChemmolpropslogpVector) -> ChemmolpropslogpVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolpropslogpVector::scale(self : ChemmolpropslogpVector, s : Double) -> ChemmolpropslogpVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemmolpropslogpVector::dot(self : ChemmolpropslogpVector, other : ChemmolpropslogpVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemmolpropslogpVector::norm(self : ChemmolpropslogpVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemmolpropslogpVector::normalize(self : ChemmolpropslogpVector) -> ChemmolpropslogpVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolpropslogpVector::dist(self : ChemmolpropslogpVector, other : ChemmolpropslogpVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemmolpropslogpVector::to_string(self : ChemmolpropslogpVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_mol_props_logp_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_mol_props_logp_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_mol_props_logp_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_mol_props_logp_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_mol_props_logp_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_mol_props_logp_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_mol_props_logp_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_mol_props_logp_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_mol_props_logp_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_mol_props_logp_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_mol_props_logp_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_mol_props_logp_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_mol_props_logp_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_mol_props_logp_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_mol_props_logp_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_mol_props_logp_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_mol_props_logp_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_mol_props_logp_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_mol_props_logp_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_mol_props_logp_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_mol_props_logp_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_mol_props_logp_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_mol_props_logp_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_mol_props_logp_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_mol_props_logp_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_mol_props_logp_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_mol_props_logp_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_mol_props_logp_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_mol_props_logp_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemmolpropslogpFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_logp_frame_make(size : Int) -> ChemmolpropslogpFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_logp_frame_len(s : ChemmolpropslogpFrame) -> Int { s.size }

pub fn chem_mol_props_logp_frame_get(s : ChemmolpropslogpFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_logp_frame_set(s : ChemmolpropslogpFrame, i : Int, v : Double) -> ChemmolpropslogpFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_frame_sum(s : ChemmolpropslogpFrame) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_logp_frame_mean(s : ChemmolpropslogpFrame) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_logp_frame_scale(s : ChemmolpropslogpFrame, f : Double) -> ChemmolpropslogpFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_frame_add(a : ChemmolpropslogpFrame, b : ChemmolpropslogpFrame) -> ChemmolpropslogpFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_logp_frame_copy(s : ChemmolpropslogpFrame) -> ChemmolpropslogpFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_frame_fill(s : ChemmolpropslogpFrame, v : Double) -> ChemmolpropslogpFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_frame_min(s : ChemmolpropslogpFrame) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_logp_frame_max(s : ChemmolpropslogpFrame) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_logp_frame_to_string(s : ChemmolpropslogpFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropslogpTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_logp_table_make(size : Int) -> ChemmolpropslogpTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_logp_table_len(s : ChemmolpropslogpTable) -> Int { s.size }

pub fn chem_mol_props_logp_table_get(s : ChemmolpropslogpTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_logp_table_set(s : ChemmolpropslogpTable, i : Int, v : Double) -> ChemmolpropslogpTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_table_sum(s : ChemmolpropslogpTable) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_logp_table_mean(s : ChemmolpropslogpTable) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_logp_table_scale(s : ChemmolpropslogpTable, f : Double) -> ChemmolpropslogpTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_table_add(a : ChemmolpropslogpTable, b : ChemmolpropslogpTable) -> ChemmolpropslogpTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_logp_table_copy(s : ChemmolpropslogpTable) -> ChemmolpropslogpTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_table_fill(s : ChemmolpropslogpTable, v : Double) -> ChemmolpropslogpTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_table_min(s : ChemmolpropslogpTable) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_logp_table_max(s : ChemmolpropslogpTable) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_logp_table_to_string(s : ChemmolpropslogpTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropslogpGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_logp_graphn_make(size : Int) -> ChemmolpropslogpGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_logp_graphn_len(s : ChemmolpropslogpGraphN) -> Int { s.size }

pub fn chem_mol_props_logp_graphn_get(s : ChemmolpropslogpGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_logp_graphn_set(s : ChemmolpropslogpGraphN, i : Int, v : Double) -> ChemmolpropslogpGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_graphn_sum(s : ChemmolpropslogpGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_logp_graphn_mean(s : ChemmolpropslogpGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_logp_graphn_scale(s : ChemmolpropslogpGraphN, f : Double) -> ChemmolpropslogpGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_graphn_add(a : ChemmolpropslogpGraphN, b : ChemmolpropslogpGraphN) -> ChemmolpropslogpGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_logp_graphn_copy(s : ChemmolpropslogpGraphN) -> ChemmolpropslogpGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_graphn_fill(s : ChemmolpropslogpGraphN, v : Double) -> ChemmolpropslogpGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_graphn_min(s : ChemmolpropslogpGraphN) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_logp_graphn_max(s : ChemmolpropslogpGraphN) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_logp_graphn_to_string(s : ChemmolpropslogpGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropslogpNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_logp_node_make(size : Int) -> ChemmolpropslogpNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_logp_node_len(s : ChemmolpropslogpNode) -> Int { s.size }

pub fn chem_mol_props_logp_node_get(s : ChemmolpropslogpNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_logp_node_set(s : ChemmolpropslogpNode, i : Int, v : Double) -> ChemmolpropslogpNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_node_sum(s : ChemmolpropslogpNode) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_logp_node_mean(s : ChemmolpropslogpNode) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_logp_node_scale(s : ChemmolpropslogpNode, f : Double) -> ChemmolpropslogpNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_node_add(a : ChemmolpropslogpNode, b : ChemmolpropslogpNode) -> ChemmolpropslogpNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_logp_node_copy(s : ChemmolpropslogpNode) -> ChemmolpropslogpNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_node_fill(s : ChemmolpropslogpNode, v : Double) -> ChemmolpropslogpNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_node_min(s : ChemmolpropslogpNode) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_logp_node_max(s : ChemmolpropslogpNode) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_logp_node_to_string(s : ChemmolpropslogpNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropslogpEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_logp_edge_make(size : Int) -> ChemmolpropslogpEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_logp_edge_len(s : ChemmolpropslogpEdge) -> Int { s.size }

pub fn chem_mol_props_logp_edge_get(s : ChemmolpropslogpEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_logp_edge_set(s : ChemmolpropslogpEdge, i : Int, v : Double) -> ChemmolpropslogpEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_edge_sum(s : ChemmolpropslogpEdge) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_logp_edge_mean(s : ChemmolpropslogpEdge) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_logp_edge_scale(s : ChemmolpropslogpEdge, f : Double) -> ChemmolpropslogpEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_edge_add(a : ChemmolpropslogpEdge, b : ChemmolpropslogpEdge) -> ChemmolpropslogpEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_logp_edge_copy(s : ChemmolpropslogpEdge) -> ChemmolpropslogpEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_edge_fill(s : ChemmolpropslogpEdge, v : Double) -> ChemmolpropslogpEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_edge_min(s : ChemmolpropslogpEdge) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_logp_edge_max(s : ChemmolpropslogpEdge) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_logp_edge_to_string(s : ChemmolpropslogpEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropslogpPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_logp_path_make(size : Int) -> ChemmolpropslogpPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_logp_path_len(s : ChemmolpropslogpPath) -> Int { s.size }

pub fn chem_mol_props_logp_path_get(s : ChemmolpropslogpPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_logp_path_set(s : ChemmolpropslogpPath, i : Int, v : Double) -> ChemmolpropslogpPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_path_sum(s : ChemmolpropslogpPath) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_logp_path_mean(s : ChemmolpropslogpPath) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_logp_path_scale(s : ChemmolpropslogpPath, f : Double) -> ChemmolpropslogpPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_path_add(a : ChemmolpropslogpPath, b : ChemmolpropslogpPath) -> ChemmolpropslogpPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_logp_path_copy(s : ChemmolpropslogpPath) -> ChemmolpropslogpPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_path_fill(s : ChemmolpropslogpPath, v : Double) -> ChemmolpropslogpPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_path_min(s : ChemmolpropslogpPath) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_logp_path_max(s : ChemmolpropslogpPath) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_logp_path_to_string(s : ChemmolpropslogpPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropslogpCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_logp_cluster_make(size : Int) -> ChemmolpropslogpCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_logp_cluster_len(s : ChemmolpropslogpCluster) -> Int { s.size }

pub fn chem_mol_props_logp_cluster_get(s : ChemmolpropslogpCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_logp_cluster_set(s : ChemmolpropslogpCluster, i : Int, v : Double) -> ChemmolpropslogpCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_cluster_sum(s : ChemmolpropslogpCluster) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_logp_cluster_mean(s : ChemmolpropslogpCluster) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_logp_cluster_scale(s : ChemmolpropslogpCluster, f : Double) -> ChemmolpropslogpCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_cluster_add(a : ChemmolpropslogpCluster, b : ChemmolpropslogpCluster) -> ChemmolpropslogpCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_logp_cluster_copy(s : ChemmolpropslogpCluster) -> ChemmolpropslogpCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_cluster_fill(s : ChemmolpropslogpCluster, v : Double) -> ChemmolpropslogpCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_cluster_min(s : ChemmolpropslogpCluster) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_logp_cluster_max(s : ChemmolpropslogpCluster) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_logp_cluster_to_string(s : ChemmolpropslogpCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropslogpModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_logp_model_make(size : Int) -> ChemmolpropslogpModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_logp_model_len(s : ChemmolpropslogpModel) -> Int { s.size }

pub fn chem_mol_props_logp_model_get(s : ChemmolpropslogpModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_logp_model_set(s : ChemmolpropslogpModel, i : Int, v : Double) -> ChemmolpropslogpModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_model_sum(s : ChemmolpropslogpModel) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_logp_model_mean(s : ChemmolpropslogpModel) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_logp_model_scale(s : ChemmolpropslogpModel, f : Double) -> ChemmolpropslogpModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_model_add(a : ChemmolpropslogpModel, b : ChemmolpropslogpModel) -> ChemmolpropslogpModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_logp_model_copy(s : ChemmolpropslogpModel) -> ChemmolpropslogpModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_model_fill(s : ChemmolpropslogpModel, v : Double) -> ChemmolpropslogpModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_model_min(s : ChemmolpropslogpModel) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_logp_model_max(s : ChemmolpropslogpModel) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_logp_model_to_string(s : ChemmolpropslogpModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropslogpLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_logp_layer_make(size : Int) -> ChemmolpropslogpLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_logp_layer_len(s : ChemmolpropslogpLayer) -> Int { s.size }

pub fn chem_mol_props_logp_layer_get(s : ChemmolpropslogpLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_logp_layer_set(s : ChemmolpropslogpLayer, i : Int, v : Double) -> ChemmolpropslogpLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_layer_sum(s : ChemmolpropslogpLayer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_logp_layer_mean(s : ChemmolpropslogpLayer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_logp_layer_scale(s : ChemmolpropslogpLayer, f : Double) -> ChemmolpropslogpLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_layer_add(a : ChemmolpropslogpLayer, b : ChemmolpropslogpLayer) -> ChemmolpropslogpLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_logp_layer_copy(s : ChemmolpropslogpLayer) -> ChemmolpropslogpLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_layer_fill(s : ChemmolpropslogpLayer, v : Double) -> ChemmolpropslogpLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_layer_min(s : ChemmolpropslogpLayer) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_logp_layer_max(s : ChemmolpropslogpLayer) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_logp_layer_to_string(s : ChemmolpropslogpLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropslogpBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_logp_buffer_make(size : Int) -> ChemmolpropslogpBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_logp_buffer_len(s : ChemmolpropslogpBuffer) -> Int { s.size }

pub fn chem_mol_props_logp_buffer_get(s : ChemmolpropslogpBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_logp_buffer_set(s : ChemmolpropslogpBuffer, i : Int, v : Double) -> ChemmolpropslogpBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_buffer_sum(s : ChemmolpropslogpBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_logp_buffer_mean(s : ChemmolpropslogpBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_logp_buffer_scale(s : ChemmolpropslogpBuffer, f : Double) -> ChemmolpropslogpBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_buffer_add(a : ChemmolpropslogpBuffer, b : ChemmolpropslogpBuffer) -> ChemmolpropslogpBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_logp_buffer_copy(s : ChemmolpropslogpBuffer) -> ChemmolpropslogpBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_buffer_fill(s : ChemmolpropslogpBuffer, v : Double) -> ChemmolpropslogpBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_buffer_min(s : ChemmolpropslogpBuffer) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_logp_buffer_max(s : ChemmolpropslogpBuffer) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_logp_buffer_to_string(s : ChemmolpropslogpBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropslogpCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_logp_cursor_make(size : Int) -> ChemmolpropslogpCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_logp_cursor_len(s : ChemmolpropslogpCursor) -> Int { s.size }

pub fn chem_mol_props_logp_cursor_get(s : ChemmolpropslogpCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_logp_cursor_set(s : ChemmolpropslogpCursor, i : Int, v : Double) -> ChemmolpropslogpCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_cursor_sum(s : ChemmolpropslogpCursor) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_logp_cursor_mean(s : ChemmolpropslogpCursor) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_logp_cursor_scale(s : ChemmolpropslogpCursor, f : Double) -> ChemmolpropslogpCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_cursor_add(a : ChemmolpropslogpCursor, b : ChemmolpropslogpCursor) -> ChemmolpropslogpCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_logp_cursor_copy(s : ChemmolpropslogpCursor) -> ChemmolpropslogpCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_cursor_fill(s : ChemmolpropslogpCursor, v : Double) -> ChemmolpropslogpCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_cursor_min(s : ChemmolpropslogpCursor) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_logp_cursor_max(s : ChemmolpropslogpCursor) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_logp_cursor_to_string(s : ChemmolpropslogpCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropslogpView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_logp_view_make(size : Int) -> ChemmolpropslogpView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_logp_view_len(s : ChemmolpropslogpView) -> Int { s.size }

pub fn chem_mol_props_logp_view_get(s : ChemmolpropslogpView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_logp_view_set(s : ChemmolpropslogpView, i : Int, v : Double) -> ChemmolpropslogpView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_view_sum(s : ChemmolpropslogpView) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_logp_view_mean(s : ChemmolpropslogpView) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_logp_view_scale(s : ChemmolpropslogpView, f : Double) -> ChemmolpropslogpView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_view_add(a : ChemmolpropslogpView, b : ChemmolpropslogpView) -> ChemmolpropslogpView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_logp_view_copy(s : ChemmolpropslogpView) -> ChemmolpropslogpView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_view_fill(s : ChemmolpropslogpView, v : Double) -> ChemmolpropslogpView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_view_min(s : ChemmolpropslogpView) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_logp_view_max(s : ChemmolpropslogpView) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_logp_view_to_string(s : ChemmolpropslogpView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropslogpRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_logp_range_make(size : Int) -> ChemmolpropslogpRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_logp_range_len(s : ChemmolpropslogpRange) -> Int { s.size }

pub fn chem_mol_props_logp_range_get(s : ChemmolpropslogpRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_logp_range_set(s : ChemmolpropslogpRange, i : Int, v : Double) -> ChemmolpropslogpRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_range_sum(s : ChemmolpropslogpRange) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_logp_range_mean(s : ChemmolpropslogpRange) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_logp_range_scale(s : ChemmolpropslogpRange, f : Double) -> ChemmolpropslogpRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_range_add(a : ChemmolpropslogpRange, b : ChemmolpropslogpRange) -> ChemmolpropslogpRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_logp_range_copy(s : ChemmolpropslogpRange) -> ChemmolpropslogpRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_range_fill(s : ChemmolpropslogpRange, v : Double) -> ChemmolpropslogpRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_range_min(s : ChemmolpropslogpRange) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_logp_range_max(s : ChemmolpropslogpRange) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_logp_range_to_string(s : ChemmolpropslogpRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropslogpSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_logp_slice_make(size : Int) -> ChemmolpropslogpSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_logp_slice_len(s : ChemmolpropslogpSlice) -> Int { s.size }

pub fn chem_mol_props_logp_slice_get(s : ChemmolpropslogpSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_logp_slice_set(s : ChemmolpropslogpSlice, i : Int, v : Double) -> ChemmolpropslogpSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_slice_sum(s : ChemmolpropslogpSlice) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_logp_slice_mean(s : ChemmolpropslogpSlice) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_logp_slice_scale(s : ChemmolpropslogpSlice, f : Double) -> ChemmolpropslogpSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_slice_add(a : ChemmolpropslogpSlice, b : ChemmolpropslogpSlice) -> ChemmolpropslogpSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_logp_slice_copy(s : ChemmolpropslogpSlice) -> ChemmolpropslogpSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_slice_fill(s : ChemmolpropslogpSlice, v : Double) -> ChemmolpropslogpSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_logp_slice_min(s : ChemmolpropslogpSlice) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_logp_slice_max(s : ChemmolpropslogpSlice) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_logp_slice_to_string(s : ChemmolpropslogpSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

