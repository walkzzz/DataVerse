///===
/// extcore/chem_mol_props_charge

pub(all) struct ChemmolpropschargePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_mol_props_charge_make_point(x : Double, y : Double) -> ChemmolpropschargePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_mol_props_charge_make_point3(x : Double, y : Double, z : Double) -> ChemmolpropschargePoint {
  { x, y, z, label: 0 }
}

pub fn ChemmolpropschargePoint::x(self : ChemmolpropschargePoint) -> Double { self.x }

pub fn ChemmolpropschargePoint::y(self : ChemmolpropschargePoint) -> Double { self.y }

pub fn ChemmolpropschargePoint::z(self : ChemmolpropschargePoint) -> Double { self.z }

pub fn ChemmolpropschargePoint::label(self : ChemmolpropschargePoint) -> Int { self.label }

pub fn ChemmolpropschargePoint::dist(self : ChemmolpropschargePoint, other : ChemmolpropschargePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemmolpropschargePoint::add(self : ChemmolpropschargePoint, other : ChemmolpropschargePoint) -> ChemmolpropschargePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemmolpropschargePoint::sub(self : ChemmolpropschargePoint, other : ChemmolpropschargePoint) -> ChemmolpropschargePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemmolpropschargePoint::scale(self : ChemmolpropschargePoint, s : Double) -> ChemmolpropschargePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemmolpropschargePoint::dot(self : ChemmolpropschargePoint, other : ChemmolpropschargePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemmolpropschargePoint::cross(self : ChemmolpropschargePoint, other : ChemmolpropschargePoint) -> ChemmolpropschargePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemmolpropschargePoint::norm(self : ChemmolpropschargePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemmolpropschargePoint::normalize(self : ChemmolpropschargePoint) -> ChemmolpropschargePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolpropschargePoint::negate(self : ChemmolpropschargePoint) -> ChemmolpropschargePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemmolpropschargePoint::mid(self : ChemmolpropschargePoint, other : ChemmolpropschargePoint) -> ChemmolpropschargePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemmolpropschargePoint::lerp(self : ChemmolpropschargePoint, other : ChemmolpropschargePoint, t : Double) -> ChemmolpropschargePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemmolpropschargePoint::to_string(self : ChemmolpropschargePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemmolpropschargeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_mol_props_charge_make_series(vals : Array[Double], name : String) -> ChemmolpropschargeSeries {
  { vals, name, meta: 0 }
}

pub fn ChemmolpropschargeSeries::len(self : ChemmolpropschargeSeries) -> Int { self.vals.length() }

pub fn ChemmolpropschargeSeries::sum(self : ChemmolpropschargeSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemmolpropschargeSeries::mean(self : ChemmolpropschargeSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemmolpropschargeSeries::min(self : ChemmolpropschargeSeries) -> Double { @_common.min(self.vals) }

pub fn ChemmolpropschargeSeries::max(self : ChemmolpropschargeSeries) -> Double { @_common.max(self.vals) }

pub fn ChemmolpropschargeSeries::range(self : ChemmolpropschargeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemmolpropschargeSeries::variance(self : ChemmolpropschargeSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemmolpropschargeSeries::std(self : ChemmolpropschargeSeries) -> Double { @_common.std(self.vals) }

pub fn ChemmolpropschargeSeries::median(self : ChemmolpropschargeSeries) -> Double { @_common.median(self.vals) }

pub fn ChemmolpropschargeSeries::scale(self : ChemmolpropschargeSeries, f : Double) -> ChemmolpropschargeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemmolpropschargeSeries::add(self : ChemmolpropschargeSeries, other : ChemmolpropschargeSeries) -> ChemmolpropschargeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemmolpropschargeSeries::sub(self : ChemmolpropschargeSeries, other : ChemmolpropschargeSeries) -> ChemmolpropschargeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemmolpropschargeSeries::normalize(self : ChemmolpropschargeSeries) -> ChemmolpropschargeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemmolpropschargeSeries::cumsum(self : ChemmolpropschargeSeries) -> ChemmolpropschargeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemmolpropschargeSeries::to_string(self : ChemmolpropschargeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolpropschargeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_mol_props_charge_make_matrix(rows : Int, cols : Int, val : Double) -> ChemmolpropschargeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_mol_props_charge_matrix_identity(n : Int) -> ChemmolpropschargeMatrix {
  let m = chem_mol_props_charge_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemmolpropschargeMatrix::get(self : ChemmolpropschargeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemmolpropschargeMatrix::transpose(self : ChemmolpropschargeMatrix) -> ChemmolpropschargeMatrix {
  let result = chem_mol_props_charge_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemmolpropschargeMatrix::add(self : ChemmolpropschargeMatrix, other : ChemmolpropschargeMatrix) -> ChemmolpropschargeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_mol_props_charge_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemmolpropschargeMatrix::scale(self : ChemmolpropschargeMatrix, s : Double) -> ChemmolpropschargeMatrix {
  let result = chem_mol_props_charge_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemmolpropschargeMatrix::multiply(self : ChemmolpropschargeMatrix, other : ChemmolpropschargeMatrix) -> ChemmolpropschargeMatrix {
  if self.cols != other.rows { return chem_mol_props_charge_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_mol_props_charge_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ChemmolpropschargeMatrix::trace(self : ChemmolpropschargeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemmolpropschargeMatrix::det(self : ChemmolpropschargeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemmolpropschargeMatrix::norm(self : ChemmolpropschargeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemmolpropschargeMatrix::to_string(self : ChemmolpropschargeMatrix) -> String {
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

pub(all) struct ChemmolpropschargeVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_mol_props_charge_make_vector(comps : Array[Double]) -> ChemmolpropschargeVector {
  { comps, dim: comps.length() }
}

pub fn chem_mol_props_charge_vector_zero(dim : Int) -> ChemmolpropschargeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemmolpropschargeVector::add(self : ChemmolpropschargeVector, other : ChemmolpropschargeVector) -> ChemmolpropschargeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolpropschargeVector::sub(self : ChemmolpropschargeVector, other : ChemmolpropschargeVector) -> ChemmolpropschargeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolpropschargeVector::scale(self : ChemmolpropschargeVector, s : Double) -> ChemmolpropschargeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemmolpropschargeVector::dot(self : ChemmolpropschargeVector, other : ChemmolpropschargeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemmolpropschargeVector::norm(self : ChemmolpropschargeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemmolpropschargeVector::normalize(self : ChemmolpropschargeVector) -> ChemmolpropschargeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolpropschargeVector::dist(self : ChemmolpropschargeVector, other : ChemmolpropschargeVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemmolpropschargeVector::to_string(self : ChemmolpropschargeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_mol_props_charge_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_mol_props_charge_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_mol_props_charge_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_mol_props_charge_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_mol_props_charge_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_mol_props_charge_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_mol_props_charge_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_mol_props_charge_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_mol_props_charge_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_mol_props_charge_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_mol_props_charge_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_mol_props_charge_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_mol_props_charge_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_mol_props_charge_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_mol_props_charge_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_mol_props_charge_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_mol_props_charge_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_mol_props_charge_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_mol_props_charge_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_mol_props_charge_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_mol_props_charge_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_mol_props_charge_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_mol_props_charge_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_mol_props_charge_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_mol_props_charge_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_mol_props_charge_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_mol_props_charge_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_mol_props_charge_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_mol_props_charge_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemmolpropschargeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_charge_frame_make(size : Int) -> ChemmolpropschargeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_charge_frame_len(s : ChemmolpropschargeFrame) -> Int { s.size }

pub fn chem_mol_props_charge_frame_get(s : ChemmolpropschargeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_charge_frame_set(s : ChemmolpropschargeFrame, i : Int, v : Double) -> ChemmolpropschargeFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_frame_sum(s : ChemmolpropschargeFrame) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_charge_frame_mean(s : ChemmolpropschargeFrame) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_charge_frame_scale(s : ChemmolpropschargeFrame, f : Double) -> ChemmolpropschargeFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_frame_add(a : ChemmolpropschargeFrame, b : ChemmolpropschargeFrame) -> ChemmolpropschargeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_charge_frame_copy(s : ChemmolpropschargeFrame) -> ChemmolpropschargeFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_frame_fill(s : ChemmolpropschargeFrame, v : Double) -> ChemmolpropschargeFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_frame_min(s : ChemmolpropschargeFrame) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_charge_frame_max(s : ChemmolpropschargeFrame) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_charge_frame_to_string(s : ChemmolpropschargeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropschargeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_charge_table_make(size : Int) -> ChemmolpropschargeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_charge_table_len(s : ChemmolpropschargeTable) -> Int { s.size }

pub fn chem_mol_props_charge_table_get(s : ChemmolpropschargeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_charge_table_set(s : ChemmolpropschargeTable, i : Int, v : Double) -> ChemmolpropschargeTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_table_sum(s : ChemmolpropschargeTable) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_charge_table_mean(s : ChemmolpropschargeTable) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_charge_table_scale(s : ChemmolpropschargeTable, f : Double) -> ChemmolpropschargeTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_table_add(a : ChemmolpropschargeTable, b : ChemmolpropschargeTable) -> ChemmolpropschargeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_charge_table_copy(s : ChemmolpropschargeTable) -> ChemmolpropschargeTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_table_fill(s : ChemmolpropschargeTable, v : Double) -> ChemmolpropschargeTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_table_min(s : ChemmolpropschargeTable) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_charge_table_max(s : ChemmolpropschargeTable) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_charge_table_to_string(s : ChemmolpropschargeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropschargeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_charge_graphn_make(size : Int) -> ChemmolpropschargeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_charge_graphn_len(s : ChemmolpropschargeGraphN) -> Int { s.size }

pub fn chem_mol_props_charge_graphn_get(s : ChemmolpropschargeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_charge_graphn_set(s : ChemmolpropschargeGraphN, i : Int, v : Double) -> ChemmolpropschargeGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_graphn_sum(s : ChemmolpropschargeGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_charge_graphn_mean(s : ChemmolpropschargeGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_charge_graphn_scale(s : ChemmolpropschargeGraphN, f : Double) -> ChemmolpropschargeGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_graphn_add(a : ChemmolpropschargeGraphN, b : ChemmolpropschargeGraphN) -> ChemmolpropschargeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_charge_graphn_copy(s : ChemmolpropschargeGraphN) -> ChemmolpropschargeGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_graphn_fill(s : ChemmolpropschargeGraphN, v : Double) -> ChemmolpropschargeGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_graphn_min(s : ChemmolpropschargeGraphN) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_charge_graphn_max(s : ChemmolpropschargeGraphN) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_charge_graphn_to_string(s : ChemmolpropschargeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropschargeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_charge_node_make(size : Int) -> ChemmolpropschargeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_charge_node_len(s : ChemmolpropschargeNode) -> Int { s.size }

pub fn chem_mol_props_charge_node_get(s : ChemmolpropschargeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_charge_node_set(s : ChemmolpropschargeNode, i : Int, v : Double) -> ChemmolpropschargeNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_node_sum(s : ChemmolpropschargeNode) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_charge_node_mean(s : ChemmolpropschargeNode) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_charge_node_scale(s : ChemmolpropschargeNode, f : Double) -> ChemmolpropschargeNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_node_add(a : ChemmolpropschargeNode, b : ChemmolpropschargeNode) -> ChemmolpropschargeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_charge_node_copy(s : ChemmolpropschargeNode) -> ChemmolpropschargeNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_node_fill(s : ChemmolpropschargeNode, v : Double) -> ChemmolpropschargeNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_node_min(s : ChemmolpropschargeNode) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_charge_node_max(s : ChemmolpropschargeNode) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_charge_node_to_string(s : ChemmolpropschargeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropschargeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_charge_edge_make(size : Int) -> ChemmolpropschargeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_charge_edge_len(s : ChemmolpropschargeEdge) -> Int { s.size }

pub fn chem_mol_props_charge_edge_get(s : ChemmolpropschargeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_charge_edge_set(s : ChemmolpropschargeEdge, i : Int, v : Double) -> ChemmolpropschargeEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_edge_sum(s : ChemmolpropschargeEdge) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_charge_edge_mean(s : ChemmolpropschargeEdge) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_charge_edge_scale(s : ChemmolpropschargeEdge, f : Double) -> ChemmolpropschargeEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_edge_add(a : ChemmolpropschargeEdge, b : ChemmolpropschargeEdge) -> ChemmolpropschargeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_charge_edge_copy(s : ChemmolpropschargeEdge) -> ChemmolpropschargeEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_edge_fill(s : ChemmolpropschargeEdge, v : Double) -> ChemmolpropschargeEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_edge_min(s : ChemmolpropschargeEdge) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_charge_edge_max(s : ChemmolpropschargeEdge) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_charge_edge_to_string(s : ChemmolpropschargeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropschargePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_charge_path_make(size : Int) -> ChemmolpropschargePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_charge_path_len(s : ChemmolpropschargePath) -> Int { s.size }

pub fn chem_mol_props_charge_path_get(s : ChemmolpropschargePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_charge_path_set(s : ChemmolpropschargePath, i : Int, v : Double) -> ChemmolpropschargePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_path_sum(s : ChemmolpropschargePath) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_charge_path_mean(s : ChemmolpropschargePath) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_charge_path_scale(s : ChemmolpropschargePath, f : Double) -> ChemmolpropschargePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_path_add(a : ChemmolpropschargePath, b : ChemmolpropschargePath) -> ChemmolpropschargePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_charge_path_copy(s : ChemmolpropschargePath) -> ChemmolpropschargePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_path_fill(s : ChemmolpropschargePath, v : Double) -> ChemmolpropschargePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_path_min(s : ChemmolpropschargePath) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_charge_path_max(s : ChemmolpropschargePath) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_charge_path_to_string(s : ChemmolpropschargePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropschargeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_charge_cluster_make(size : Int) -> ChemmolpropschargeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_charge_cluster_len(s : ChemmolpropschargeCluster) -> Int { s.size }

pub fn chem_mol_props_charge_cluster_get(s : ChemmolpropschargeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_charge_cluster_set(s : ChemmolpropschargeCluster, i : Int, v : Double) -> ChemmolpropschargeCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_cluster_sum(s : ChemmolpropschargeCluster) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_charge_cluster_mean(s : ChemmolpropschargeCluster) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_charge_cluster_scale(s : ChemmolpropschargeCluster, f : Double) -> ChemmolpropschargeCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_cluster_add(a : ChemmolpropschargeCluster, b : ChemmolpropschargeCluster) -> ChemmolpropschargeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_charge_cluster_copy(s : ChemmolpropschargeCluster) -> ChemmolpropschargeCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_cluster_fill(s : ChemmolpropschargeCluster, v : Double) -> ChemmolpropschargeCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_cluster_min(s : ChemmolpropschargeCluster) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_charge_cluster_max(s : ChemmolpropschargeCluster) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_charge_cluster_to_string(s : ChemmolpropschargeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropschargeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_charge_model_make(size : Int) -> ChemmolpropschargeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_charge_model_len(s : ChemmolpropschargeModel) -> Int { s.size }

pub fn chem_mol_props_charge_model_get(s : ChemmolpropschargeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_charge_model_set(s : ChemmolpropschargeModel, i : Int, v : Double) -> ChemmolpropschargeModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_model_sum(s : ChemmolpropschargeModel) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_charge_model_mean(s : ChemmolpropschargeModel) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_charge_model_scale(s : ChemmolpropschargeModel, f : Double) -> ChemmolpropschargeModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_model_add(a : ChemmolpropschargeModel, b : ChemmolpropschargeModel) -> ChemmolpropschargeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_charge_model_copy(s : ChemmolpropschargeModel) -> ChemmolpropschargeModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_model_fill(s : ChemmolpropschargeModel, v : Double) -> ChemmolpropschargeModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_model_min(s : ChemmolpropschargeModel) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_charge_model_max(s : ChemmolpropschargeModel) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_charge_model_to_string(s : ChemmolpropschargeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropschargeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_charge_layer_make(size : Int) -> ChemmolpropschargeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_charge_layer_len(s : ChemmolpropschargeLayer) -> Int { s.size }

pub fn chem_mol_props_charge_layer_get(s : ChemmolpropschargeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_charge_layer_set(s : ChemmolpropschargeLayer, i : Int, v : Double) -> ChemmolpropschargeLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_layer_sum(s : ChemmolpropschargeLayer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_charge_layer_mean(s : ChemmolpropschargeLayer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_charge_layer_scale(s : ChemmolpropschargeLayer, f : Double) -> ChemmolpropschargeLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_layer_add(a : ChemmolpropschargeLayer, b : ChemmolpropschargeLayer) -> ChemmolpropschargeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_charge_layer_copy(s : ChemmolpropschargeLayer) -> ChemmolpropschargeLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_layer_fill(s : ChemmolpropschargeLayer, v : Double) -> ChemmolpropschargeLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_layer_min(s : ChemmolpropschargeLayer) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_charge_layer_max(s : ChemmolpropschargeLayer) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_charge_layer_to_string(s : ChemmolpropschargeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropschargeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_charge_buffer_make(size : Int) -> ChemmolpropschargeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_charge_buffer_len(s : ChemmolpropschargeBuffer) -> Int { s.size }

pub fn chem_mol_props_charge_buffer_get(s : ChemmolpropschargeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_charge_buffer_set(s : ChemmolpropschargeBuffer, i : Int, v : Double) -> ChemmolpropschargeBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_buffer_sum(s : ChemmolpropschargeBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_charge_buffer_mean(s : ChemmolpropschargeBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_charge_buffer_scale(s : ChemmolpropschargeBuffer, f : Double) -> ChemmolpropschargeBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_buffer_add(a : ChemmolpropschargeBuffer, b : ChemmolpropschargeBuffer) -> ChemmolpropschargeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_charge_buffer_copy(s : ChemmolpropschargeBuffer) -> ChemmolpropschargeBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_buffer_fill(s : ChemmolpropschargeBuffer, v : Double) -> ChemmolpropschargeBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_buffer_min(s : ChemmolpropschargeBuffer) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_charge_buffer_max(s : ChemmolpropschargeBuffer) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_charge_buffer_to_string(s : ChemmolpropschargeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropschargeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_charge_cursor_make(size : Int) -> ChemmolpropschargeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_charge_cursor_len(s : ChemmolpropschargeCursor) -> Int { s.size }

pub fn chem_mol_props_charge_cursor_get(s : ChemmolpropschargeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_charge_cursor_set(s : ChemmolpropschargeCursor, i : Int, v : Double) -> ChemmolpropschargeCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_cursor_sum(s : ChemmolpropschargeCursor) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_charge_cursor_mean(s : ChemmolpropschargeCursor) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_charge_cursor_scale(s : ChemmolpropschargeCursor, f : Double) -> ChemmolpropschargeCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_cursor_add(a : ChemmolpropschargeCursor, b : ChemmolpropschargeCursor) -> ChemmolpropschargeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_charge_cursor_copy(s : ChemmolpropschargeCursor) -> ChemmolpropschargeCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_cursor_fill(s : ChemmolpropschargeCursor, v : Double) -> ChemmolpropschargeCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_cursor_min(s : ChemmolpropschargeCursor) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_charge_cursor_max(s : ChemmolpropschargeCursor) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_charge_cursor_to_string(s : ChemmolpropschargeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropschargeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_charge_view_make(size : Int) -> ChemmolpropschargeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_charge_view_len(s : ChemmolpropschargeView) -> Int { s.size }

pub fn chem_mol_props_charge_view_get(s : ChemmolpropschargeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_charge_view_set(s : ChemmolpropschargeView, i : Int, v : Double) -> ChemmolpropschargeView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_view_sum(s : ChemmolpropschargeView) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_charge_view_mean(s : ChemmolpropschargeView) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_charge_view_scale(s : ChemmolpropschargeView, f : Double) -> ChemmolpropschargeView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_view_add(a : ChemmolpropschargeView, b : ChemmolpropschargeView) -> ChemmolpropschargeView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_charge_view_copy(s : ChemmolpropschargeView) -> ChemmolpropschargeView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_view_fill(s : ChemmolpropschargeView, v : Double) -> ChemmolpropschargeView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_view_min(s : ChemmolpropschargeView) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_charge_view_max(s : ChemmolpropschargeView) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_charge_view_to_string(s : ChemmolpropschargeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropschargeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_charge_range_make(size : Int) -> ChemmolpropschargeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_charge_range_len(s : ChemmolpropschargeRange) -> Int { s.size }

pub fn chem_mol_props_charge_range_get(s : ChemmolpropschargeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_charge_range_set(s : ChemmolpropschargeRange, i : Int, v : Double) -> ChemmolpropschargeRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_range_sum(s : ChemmolpropschargeRange) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_charge_range_mean(s : ChemmolpropschargeRange) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_charge_range_scale(s : ChemmolpropschargeRange, f : Double) -> ChemmolpropschargeRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_range_add(a : ChemmolpropschargeRange, b : ChemmolpropschargeRange) -> ChemmolpropschargeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_charge_range_copy(s : ChemmolpropschargeRange) -> ChemmolpropschargeRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_range_fill(s : ChemmolpropschargeRange, v : Double) -> ChemmolpropschargeRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_range_min(s : ChemmolpropschargeRange) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_charge_range_max(s : ChemmolpropschargeRange) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_charge_range_to_string(s : ChemmolpropschargeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropschargeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_charge_slice_make(size : Int) -> ChemmolpropschargeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_charge_slice_len(s : ChemmolpropschargeSlice) -> Int { s.size }

pub fn chem_mol_props_charge_slice_get(s : ChemmolpropschargeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_charge_slice_set(s : ChemmolpropschargeSlice, i : Int, v : Double) -> ChemmolpropschargeSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_slice_sum(s : ChemmolpropschargeSlice) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_charge_slice_mean(s : ChemmolpropschargeSlice) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_charge_slice_scale(s : ChemmolpropschargeSlice, f : Double) -> ChemmolpropschargeSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_slice_add(a : ChemmolpropschargeSlice, b : ChemmolpropschargeSlice) -> ChemmolpropschargeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_charge_slice_copy(s : ChemmolpropschargeSlice) -> ChemmolpropschargeSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_slice_fill(s : ChemmolpropschargeSlice, v : Double) -> ChemmolpropschargeSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_charge_slice_min(s : ChemmolpropschargeSlice) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_charge_slice_max(s : ChemmolpropschargeSlice) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_charge_slice_to_string(s : ChemmolpropschargeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

