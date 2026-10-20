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

pub fn ChemmolpropschargeFrame::len(self : ChemmolpropschargeFrame) -> Int { self.size }

pub fn ChemmolpropschargeFrame::get(self : ChemmolpropschargeFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropschargeFrame::set(self : ChemmolpropschargeFrame, i : Int, v : Double) -> ChemmolpropschargeFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeFrame::sum(self : ChemmolpropschargeFrame) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropschargeFrame::mean(self : ChemmolpropschargeFrame) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropschargeFrame::scale(self : ChemmolpropschargeFrame, f : Double) -> ChemmolpropschargeFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeFrame::add(self : ChemmolpropschargeFrame, other : ChemmolpropschargeFrame) -> ChemmolpropschargeFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropschargeFrame::copy(self : ChemmolpropschargeFrame) -> ChemmolpropschargeFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeFrame::fill(self : ChemmolpropschargeFrame, v : Double) -> ChemmolpropschargeFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeFrame::min(self : ChemmolpropschargeFrame) -> Double { @_common.min(self.data) }

pub fn ChemmolpropschargeFrame::max(self : ChemmolpropschargeFrame) -> Double { @_common.max(self.data) }

pub fn ChemmolpropschargeFrame::to_string(self : ChemmolpropschargeFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropschargeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_charge_table_make(size : Int) -> ChemmolpropschargeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropschargeTable::len(self : ChemmolpropschargeTable) -> Int { self.size }

pub fn ChemmolpropschargeTable::get(self : ChemmolpropschargeTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropschargeTable::set(self : ChemmolpropschargeTable, i : Int, v : Double) -> ChemmolpropschargeTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeTable::sum(self : ChemmolpropschargeTable) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropschargeTable::mean(self : ChemmolpropschargeTable) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropschargeTable::scale(self : ChemmolpropschargeTable, f : Double) -> ChemmolpropschargeTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeTable::add(self : ChemmolpropschargeTable, other : ChemmolpropschargeTable) -> ChemmolpropschargeTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropschargeTable::copy(self : ChemmolpropschargeTable) -> ChemmolpropschargeTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeTable::fill(self : ChemmolpropschargeTable, v : Double) -> ChemmolpropschargeTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeTable::min(self : ChemmolpropschargeTable) -> Double { @_common.min(self.data) }

pub fn ChemmolpropschargeTable::max(self : ChemmolpropschargeTable) -> Double { @_common.max(self.data) }

pub fn ChemmolpropschargeTable::to_string(self : ChemmolpropschargeTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropschargeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_charge_graphn_make(size : Int) -> ChemmolpropschargeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropschargeGraphN::len(self : ChemmolpropschargeGraphN) -> Int { self.size }

pub fn ChemmolpropschargeGraphN::get(self : ChemmolpropschargeGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropschargeGraphN::set(self : ChemmolpropschargeGraphN, i : Int, v : Double) -> ChemmolpropschargeGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeGraphN::sum(self : ChemmolpropschargeGraphN) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropschargeGraphN::mean(self : ChemmolpropschargeGraphN) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropschargeGraphN::scale(self : ChemmolpropschargeGraphN, f : Double) -> ChemmolpropschargeGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeGraphN::add(self : ChemmolpropschargeGraphN, other : ChemmolpropschargeGraphN) -> ChemmolpropschargeGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropschargeGraphN::copy(self : ChemmolpropschargeGraphN) -> ChemmolpropschargeGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeGraphN::fill(self : ChemmolpropschargeGraphN, v : Double) -> ChemmolpropschargeGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeGraphN::min(self : ChemmolpropschargeGraphN) -> Double { @_common.min(self.data) }

pub fn ChemmolpropschargeGraphN::max(self : ChemmolpropschargeGraphN) -> Double { @_common.max(self.data) }

pub fn ChemmolpropschargeGraphN::to_string(self : ChemmolpropschargeGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropschargeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_charge_node_make(size : Int) -> ChemmolpropschargeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropschargeNode::len(self : ChemmolpropschargeNode) -> Int { self.size }

pub fn ChemmolpropschargeNode::get(self : ChemmolpropschargeNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropschargeNode::set(self : ChemmolpropschargeNode, i : Int, v : Double) -> ChemmolpropschargeNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeNode::sum(self : ChemmolpropschargeNode) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropschargeNode::mean(self : ChemmolpropschargeNode) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropschargeNode::scale(self : ChemmolpropschargeNode, f : Double) -> ChemmolpropschargeNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeNode::add(self : ChemmolpropschargeNode, other : ChemmolpropschargeNode) -> ChemmolpropschargeNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropschargeNode::copy(self : ChemmolpropschargeNode) -> ChemmolpropschargeNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeNode::fill(self : ChemmolpropschargeNode, v : Double) -> ChemmolpropschargeNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeNode::min(self : ChemmolpropschargeNode) -> Double { @_common.min(self.data) }

pub fn ChemmolpropschargeNode::max(self : ChemmolpropschargeNode) -> Double { @_common.max(self.data) }

pub fn ChemmolpropschargeNode::to_string(self : ChemmolpropschargeNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropschargeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_charge_edge_make(size : Int) -> ChemmolpropschargeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropschargeEdge::len(self : ChemmolpropschargeEdge) -> Int { self.size }

pub fn ChemmolpropschargeEdge::get(self : ChemmolpropschargeEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropschargeEdge::set(self : ChemmolpropschargeEdge, i : Int, v : Double) -> ChemmolpropschargeEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeEdge::sum(self : ChemmolpropschargeEdge) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropschargeEdge::mean(self : ChemmolpropschargeEdge) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropschargeEdge::scale(self : ChemmolpropschargeEdge, f : Double) -> ChemmolpropschargeEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeEdge::add(self : ChemmolpropschargeEdge, other : ChemmolpropschargeEdge) -> ChemmolpropschargeEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropschargeEdge::copy(self : ChemmolpropschargeEdge) -> ChemmolpropschargeEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeEdge::fill(self : ChemmolpropschargeEdge, v : Double) -> ChemmolpropschargeEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeEdge::min(self : ChemmolpropschargeEdge) -> Double { @_common.min(self.data) }

pub fn ChemmolpropschargeEdge::max(self : ChemmolpropschargeEdge) -> Double { @_common.max(self.data) }

pub fn ChemmolpropschargeEdge::to_string(self : ChemmolpropschargeEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropschargePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_charge_path_make(size : Int) -> ChemmolpropschargePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropschargePath::len(self : ChemmolpropschargePath) -> Int { self.size }

pub fn ChemmolpropschargePath::get(self : ChemmolpropschargePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropschargePath::set(self : ChemmolpropschargePath, i : Int, v : Double) -> ChemmolpropschargePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargePath::sum(self : ChemmolpropschargePath) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropschargePath::mean(self : ChemmolpropschargePath) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropschargePath::scale(self : ChemmolpropschargePath, f : Double) -> ChemmolpropschargePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargePath::add(self : ChemmolpropschargePath, other : ChemmolpropschargePath) -> ChemmolpropschargePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropschargePath::copy(self : ChemmolpropschargePath) -> ChemmolpropschargePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargePath::fill(self : ChemmolpropschargePath, v : Double) -> ChemmolpropschargePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargePath::min(self : ChemmolpropschargePath) -> Double { @_common.min(self.data) }

pub fn ChemmolpropschargePath::max(self : ChemmolpropschargePath) -> Double { @_common.max(self.data) }

pub fn ChemmolpropschargePath::to_string(self : ChemmolpropschargePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropschargeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_charge_cluster_make(size : Int) -> ChemmolpropschargeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropschargeCluster::len(self : ChemmolpropschargeCluster) -> Int { self.size }

pub fn ChemmolpropschargeCluster::get(self : ChemmolpropschargeCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropschargeCluster::set(self : ChemmolpropschargeCluster, i : Int, v : Double) -> ChemmolpropschargeCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeCluster::sum(self : ChemmolpropschargeCluster) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropschargeCluster::mean(self : ChemmolpropschargeCluster) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropschargeCluster::scale(self : ChemmolpropschargeCluster, f : Double) -> ChemmolpropschargeCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeCluster::add(self : ChemmolpropschargeCluster, other : ChemmolpropschargeCluster) -> ChemmolpropschargeCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropschargeCluster::copy(self : ChemmolpropschargeCluster) -> ChemmolpropschargeCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeCluster::fill(self : ChemmolpropschargeCluster, v : Double) -> ChemmolpropschargeCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeCluster::min(self : ChemmolpropschargeCluster) -> Double { @_common.min(self.data) }

pub fn ChemmolpropschargeCluster::max(self : ChemmolpropschargeCluster) -> Double { @_common.max(self.data) }

pub fn ChemmolpropschargeCluster::to_string(self : ChemmolpropschargeCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropschargeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_charge_model_make(size : Int) -> ChemmolpropschargeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropschargeModel::len(self : ChemmolpropschargeModel) -> Int { self.size }

pub fn ChemmolpropschargeModel::get(self : ChemmolpropschargeModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropschargeModel::set(self : ChemmolpropschargeModel, i : Int, v : Double) -> ChemmolpropschargeModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeModel::sum(self : ChemmolpropschargeModel) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropschargeModel::mean(self : ChemmolpropschargeModel) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropschargeModel::scale(self : ChemmolpropschargeModel, f : Double) -> ChemmolpropschargeModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeModel::add(self : ChemmolpropschargeModel, other : ChemmolpropschargeModel) -> ChemmolpropschargeModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropschargeModel::copy(self : ChemmolpropschargeModel) -> ChemmolpropschargeModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeModel::fill(self : ChemmolpropschargeModel, v : Double) -> ChemmolpropschargeModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeModel::min(self : ChemmolpropschargeModel) -> Double { @_common.min(self.data) }

pub fn ChemmolpropschargeModel::max(self : ChemmolpropschargeModel) -> Double { @_common.max(self.data) }

pub fn ChemmolpropschargeModel::to_string(self : ChemmolpropschargeModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropschargeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_charge_layer_make(size : Int) -> ChemmolpropschargeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropschargeLayer::len(self : ChemmolpropschargeLayer) -> Int { self.size }

pub fn ChemmolpropschargeLayer::get(self : ChemmolpropschargeLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropschargeLayer::set(self : ChemmolpropschargeLayer, i : Int, v : Double) -> ChemmolpropschargeLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeLayer::sum(self : ChemmolpropschargeLayer) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropschargeLayer::mean(self : ChemmolpropschargeLayer) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropschargeLayer::scale(self : ChemmolpropschargeLayer, f : Double) -> ChemmolpropschargeLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeLayer::add(self : ChemmolpropschargeLayer, other : ChemmolpropschargeLayer) -> ChemmolpropschargeLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropschargeLayer::copy(self : ChemmolpropschargeLayer) -> ChemmolpropschargeLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeLayer::fill(self : ChemmolpropschargeLayer, v : Double) -> ChemmolpropschargeLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeLayer::min(self : ChemmolpropschargeLayer) -> Double { @_common.min(self.data) }

pub fn ChemmolpropschargeLayer::max(self : ChemmolpropschargeLayer) -> Double { @_common.max(self.data) }

pub fn ChemmolpropschargeLayer::to_string(self : ChemmolpropschargeLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropschargeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_charge_buffer_make(size : Int) -> ChemmolpropschargeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropschargeBuffer::len(self : ChemmolpropschargeBuffer) -> Int { self.size }

pub fn ChemmolpropschargeBuffer::get(self : ChemmolpropschargeBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropschargeBuffer::set(self : ChemmolpropschargeBuffer, i : Int, v : Double) -> ChemmolpropschargeBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeBuffer::sum(self : ChemmolpropschargeBuffer) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropschargeBuffer::mean(self : ChemmolpropschargeBuffer) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropschargeBuffer::scale(self : ChemmolpropschargeBuffer, f : Double) -> ChemmolpropschargeBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeBuffer::add(self : ChemmolpropschargeBuffer, other : ChemmolpropschargeBuffer) -> ChemmolpropschargeBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropschargeBuffer::copy(self : ChemmolpropschargeBuffer) -> ChemmolpropschargeBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeBuffer::fill(self : ChemmolpropschargeBuffer, v : Double) -> ChemmolpropschargeBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeBuffer::min(self : ChemmolpropschargeBuffer) -> Double { @_common.min(self.data) }

pub fn ChemmolpropschargeBuffer::max(self : ChemmolpropschargeBuffer) -> Double { @_common.max(self.data) }

pub fn ChemmolpropschargeBuffer::to_string(self : ChemmolpropschargeBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropschargeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_charge_cursor_make(size : Int) -> ChemmolpropschargeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropschargeCursor::len(self : ChemmolpropschargeCursor) -> Int { self.size }

pub fn ChemmolpropschargeCursor::get(self : ChemmolpropschargeCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropschargeCursor::set(self : ChemmolpropschargeCursor, i : Int, v : Double) -> ChemmolpropschargeCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeCursor::sum(self : ChemmolpropschargeCursor) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropschargeCursor::mean(self : ChemmolpropschargeCursor) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropschargeCursor::scale(self : ChemmolpropschargeCursor, f : Double) -> ChemmolpropschargeCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeCursor::add(self : ChemmolpropschargeCursor, other : ChemmolpropschargeCursor) -> ChemmolpropschargeCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropschargeCursor::copy(self : ChemmolpropschargeCursor) -> ChemmolpropschargeCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeCursor::fill(self : ChemmolpropschargeCursor, v : Double) -> ChemmolpropschargeCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeCursor::min(self : ChemmolpropschargeCursor) -> Double { @_common.min(self.data) }

pub fn ChemmolpropschargeCursor::max(self : ChemmolpropschargeCursor) -> Double { @_common.max(self.data) }

pub fn ChemmolpropschargeCursor::to_string(self : ChemmolpropschargeCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropschargeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_charge_view_make(size : Int) -> ChemmolpropschargeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropschargeView::len(self : ChemmolpropschargeView) -> Int { self.size }

pub fn ChemmolpropschargeView::get(self : ChemmolpropschargeView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropschargeView::set(self : ChemmolpropschargeView, i : Int, v : Double) -> ChemmolpropschargeView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeView::sum(self : ChemmolpropschargeView) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropschargeView::mean(self : ChemmolpropschargeView) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropschargeView::scale(self : ChemmolpropschargeView, f : Double) -> ChemmolpropschargeView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeView::add(self : ChemmolpropschargeView, other : ChemmolpropschargeView) -> ChemmolpropschargeView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropschargeView::copy(self : ChemmolpropschargeView) -> ChemmolpropschargeView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeView::fill(self : ChemmolpropschargeView, v : Double) -> ChemmolpropschargeView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeView::min(self : ChemmolpropschargeView) -> Double { @_common.min(self.data) }

pub fn ChemmolpropschargeView::max(self : ChemmolpropschargeView) -> Double { @_common.max(self.data) }

pub fn ChemmolpropschargeView::to_string(self : ChemmolpropschargeView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropschargeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_charge_range_make(size : Int) -> ChemmolpropschargeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropschargeRange::len(self : ChemmolpropschargeRange) -> Int { self.size }

pub fn ChemmolpropschargeRange::get(self : ChemmolpropschargeRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropschargeRange::set(self : ChemmolpropschargeRange, i : Int, v : Double) -> ChemmolpropschargeRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeRange::sum(self : ChemmolpropschargeRange) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropschargeRange::mean(self : ChemmolpropschargeRange) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropschargeRange::scale(self : ChemmolpropschargeRange, f : Double) -> ChemmolpropschargeRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeRange::add(self : ChemmolpropschargeRange, other : ChemmolpropschargeRange) -> ChemmolpropschargeRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropschargeRange::copy(self : ChemmolpropschargeRange) -> ChemmolpropschargeRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeRange::fill(self : ChemmolpropschargeRange, v : Double) -> ChemmolpropschargeRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeRange::min(self : ChemmolpropschargeRange) -> Double { @_common.min(self.data) }

pub fn ChemmolpropschargeRange::max(self : ChemmolpropschargeRange) -> Double { @_common.max(self.data) }

pub fn ChemmolpropschargeRange::to_string(self : ChemmolpropschargeRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropschargeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_charge_slice_make(size : Int) -> ChemmolpropschargeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropschargeSlice::len(self : ChemmolpropschargeSlice) -> Int { self.size }

pub fn ChemmolpropschargeSlice::get(self : ChemmolpropschargeSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropschargeSlice::set(self : ChemmolpropschargeSlice, i : Int, v : Double) -> ChemmolpropschargeSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeSlice::sum(self : ChemmolpropschargeSlice) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropschargeSlice::mean(self : ChemmolpropschargeSlice) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropschargeSlice::scale(self : ChemmolpropschargeSlice, f : Double) -> ChemmolpropschargeSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeSlice::add(self : ChemmolpropschargeSlice, other : ChemmolpropschargeSlice) -> ChemmolpropschargeSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropschargeSlice::copy(self : ChemmolpropschargeSlice) -> ChemmolpropschargeSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeSlice::fill(self : ChemmolpropschargeSlice, v : Double) -> ChemmolpropschargeSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropschargeSlice::min(self : ChemmolpropschargeSlice) -> Double { @_common.min(self.data) }

pub fn ChemmolpropschargeSlice::max(self : ChemmolpropschargeSlice) -> Double { @_common.max(self.data) }

pub fn ChemmolpropschargeSlice::to_string(self : ChemmolpropschargeSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

