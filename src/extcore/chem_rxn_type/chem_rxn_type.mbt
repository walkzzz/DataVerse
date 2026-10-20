///===
/// extcore/chem_rxn_type

pub(all) struct ChemrxntypePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_rxn_type_make_point(x : Double, y : Double) -> ChemrxntypePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_rxn_type_make_point3(x : Double, y : Double, z : Double) -> ChemrxntypePoint {
  { x, y, z, label: 0 }
}

pub fn ChemrxntypePoint::x(self : ChemrxntypePoint) -> Double { self.x }

pub fn ChemrxntypePoint::y(self : ChemrxntypePoint) -> Double { self.y }

pub fn ChemrxntypePoint::z(self : ChemrxntypePoint) -> Double { self.z }

pub fn ChemrxntypePoint::label(self : ChemrxntypePoint) -> Int { self.label }

pub fn ChemrxntypePoint::dist(self : ChemrxntypePoint, other : ChemrxntypePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemrxntypePoint::add(self : ChemrxntypePoint, other : ChemrxntypePoint) -> ChemrxntypePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemrxntypePoint::sub(self : ChemrxntypePoint, other : ChemrxntypePoint) -> ChemrxntypePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemrxntypePoint::scale(self : ChemrxntypePoint, s : Double) -> ChemrxntypePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemrxntypePoint::dot(self : ChemrxntypePoint, other : ChemrxntypePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemrxntypePoint::cross(self : ChemrxntypePoint, other : ChemrxntypePoint) -> ChemrxntypePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemrxntypePoint::norm(self : ChemrxntypePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemrxntypePoint::normalize(self : ChemrxntypePoint) -> ChemrxntypePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemrxntypePoint::negate(self : ChemrxntypePoint) -> ChemrxntypePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemrxntypePoint::mid(self : ChemrxntypePoint, other : ChemrxntypePoint) -> ChemrxntypePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemrxntypePoint::lerp(self : ChemrxntypePoint, other : ChemrxntypePoint, t : Double) -> ChemrxntypePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemrxntypePoint::to_string(self : ChemrxntypePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemrxntypeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_rxn_type_make_series(vals : Array[Double], name : String) -> ChemrxntypeSeries {
  { vals, name, meta: 0 }
}

pub fn ChemrxntypeSeries::len(self : ChemrxntypeSeries) -> Int { self.vals.length() }

pub fn ChemrxntypeSeries::sum(self : ChemrxntypeSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemrxntypeSeries::mean(self : ChemrxntypeSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemrxntypeSeries::min(self : ChemrxntypeSeries) -> Double { @_common.min(self.vals) }

pub fn ChemrxntypeSeries::max(self : ChemrxntypeSeries) -> Double { @_common.max(self.vals) }

pub fn ChemrxntypeSeries::range(self : ChemrxntypeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemrxntypeSeries::variance(self : ChemrxntypeSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemrxntypeSeries::std(self : ChemrxntypeSeries) -> Double { @_common.std(self.vals) }

pub fn ChemrxntypeSeries::median(self : ChemrxntypeSeries) -> Double { @_common.median(self.vals) }

pub fn ChemrxntypeSeries::scale(self : ChemrxntypeSeries, f : Double) -> ChemrxntypeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemrxntypeSeries::add(self : ChemrxntypeSeries, other : ChemrxntypeSeries) -> ChemrxntypeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemrxntypeSeries::sub(self : ChemrxntypeSeries, other : ChemrxntypeSeries) -> ChemrxntypeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemrxntypeSeries::normalize(self : ChemrxntypeSeries) -> ChemrxntypeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemrxntypeSeries::cumsum(self : ChemrxntypeSeries) -> ChemrxntypeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemrxntypeSeries::to_string(self : ChemrxntypeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemrxntypeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_rxn_type_make_matrix(rows : Int, cols : Int, val : Double) -> ChemrxntypeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_rxn_type_matrix_identity(n : Int) -> ChemrxntypeMatrix {
  let m = chem_rxn_type_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemrxntypeMatrix::get(self : ChemrxntypeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemrxntypeMatrix::transpose(self : ChemrxntypeMatrix) -> ChemrxntypeMatrix {
  let result = chem_rxn_type_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemrxntypeMatrix::add(self : ChemrxntypeMatrix, other : ChemrxntypeMatrix) -> ChemrxntypeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_rxn_type_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemrxntypeMatrix::scale(self : ChemrxntypeMatrix, s : Double) -> ChemrxntypeMatrix {
  let result = chem_rxn_type_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemrxntypeMatrix::multiply(self : ChemrxntypeMatrix, other : ChemrxntypeMatrix) -> ChemrxntypeMatrix {
  if self.cols != other.rows { return chem_rxn_type_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_rxn_type_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ChemrxntypeMatrix::trace(self : ChemrxntypeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemrxntypeMatrix::det(self : ChemrxntypeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemrxntypeMatrix::norm(self : ChemrxntypeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemrxntypeMatrix::to_string(self : ChemrxntypeMatrix) -> String {
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

pub(all) struct ChemrxntypeVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_rxn_type_make_vector(comps : Array[Double]) -> ChemrxntypeVector {
  { comps, dim: comps.length() }
}

pub fn chem_rxn_type_vector_zero(dim : Int) -> ChemrxntypeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemrxntypeVector::add(self : ChemrxntypeVector, other : ChemrxntypeVector) -> ChemrxntypeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemrxntypeVector::sub(self : ChemrxntypeVector, other : ChemrxntypeVector) -> ChemrxntypeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemrxntypeVector::scale(self : ChemrxntypeVector, s : Double) -> ChemrxntypeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemrxntypeVector::dot(self : ChemrxntypeVector, other : ChemrxntypeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemrxntypeVector::norm(self : ChemrxntypeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemrxntypeVector::normalize(self : ChemrxntypeVector) -> ChemrxntypeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemrxntypeVector::dist(self : ChemrxntypeVector, other : ChemrxntypeVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemrxntypeVector::to_string(self : ChemrxntypeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_rxn_type_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_rxn_type_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_rxn_type_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_rxn_type_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_rxn_type_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_rxn_type_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_rxn_type_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_rxn_type_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_rxn_type_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_rxn_type_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_rxn_type_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_rxn_type_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_rxn_type_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_rxn_type_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_rxn_type_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_rxn_type_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_rxn_type_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_rxn_type_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_rxn_type_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_rxn_type_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_rxn_type_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_rxn_type_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_rxn_type_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_rxn_type_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_rxn_type_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_rxn_type_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_rxn_type_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_rxn_type_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_rxn_type_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemrxntypeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_type_frame_make(size : Int) -> ChemrxntypeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxntypeFrame::len(self : ChemrxntypeFrame) -> Int { self.size }

pub fn ChemrxntypeFrame::get(self : ChemrxntypeFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxntypeFrame::set(self : ChemrxntypeFrame, i : Int, v : Double) -> ChemrxntypeFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxntypeFrame::sum(self : ChemrxntypeFrame) -> Double { @_common.sum(self.data) }

pub fn ChemrxntypeFrame::mean(self : ChemrxntypeFrame) -> Double { @_common.mean(self.data) }

pub fn ChemrxntypeFrame::scale(self : ChemrxntypeFrame, f : Double) -> ChemrxntypeFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxntypeFrame::add(self : ChemrxntypeFrame, other : ChemrxntypeFrame) -> ChemrxntypeFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxntypeFrame::copy(self : ChemrxntypeFrame) -> ChemrxntypeFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxntypeFrame::fill(self : ChemrxntypeFrame, v : Double) -> ChemrxntypeFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxntypeFrame::min(self : ChemrxntypeFrame) -> Double { @_common.min(self.data) }

pub fn ChemrxntypeFrame::max(self : ChemrxntypeFrame) -> Double { @_common.max(self.data) }

pub fn ChemrxntypeFrame::to_string(self : ChemrxntypeFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxntypeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_type_table_make(size : Int) -> ChemrxntypeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxntypeTable::len(self : ChemrxntypeTable) -> Int { self.size }

pub fn ChemrxntypeTable::get(self : ChemrxntypeTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxntypeTable::set(self : ChemrxntypeTable, i : Int, v : Double) -> ChemrxntypeTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxntypeTable::sum(self : ChemrxntypeTable) -> Double { @_common.sum(self.data) }

pub fn ChemrxntypeTable::mean(self : ChemrxntypeTable) -> Double { @_common.mean(self.data) }

pub fn ChemrxntypeTable::scale(self : ChemrxntypeTable, f : Double) -> ChemrxntypeTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxntypeTable::add(self : ChemrxntypeTable, other : ChemrxntypeTable) -> ChemrxntypeTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxntypeTable::copy(self : ChemrxntypeTable) -> ChemrxntypeTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxntypeTable::fill(self : ChemrxntypeTable, v : Double) -> ChemrxntypeTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxntypeTable::min(self : ChemrxntypeTable) -> Double { @_common.min(self.data) }

pub fn ChemrxntypeTable::max(self : ChemrxntypeTable) -> Double { @_common.max(self.data) }

pub fn ChemrxntypeTable::to_string(self : ChemrxntypeTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxntypeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_type_graphn_make(size : Int) -> ChemrxntypeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxntypeGraphN::len(self : ChemrxntypeGraphN) -> Int { self.size }

pub fn ChemrxntypeGraphN::get(self : ChemrxntypeGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxntypeGraphN::set(self : ChemrxntypeGraphN, i : Int, v : Double) -> ChemrxntypeGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxntypeGraphN::sum(self : ChemrxntypeGraphN) -> Double { @_common.sum(self.data) }

pub fn ChemrxntypeGraphN::mean(self : ChemrxntypeGraphN) -> Double { @_common.mean(self.data) }

pub fn ChemrxntypeGraphN::scale(self : ChemrxntypeGraphN, f : Double) -> ChemrxntypeGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxntypeGraphN::add(self : ChemrxntypeGraphN, other : ChemrxntypeGraphN) -> ChemrxntypeGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxntypeGraphN::copy(self : ChemrxntypeGraphN) -> ChemrxntypeGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxntypeGraphN::fill(self : ChemrxntypeGraphN, v : Double) -> ChemrxntypeGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxntypeGraphN::min(self : ChemrxntypeGraphN) -> Double { @_common.min(self.data) }

pub fn ChemrxntypeGraphN::max(self : ChemrxntypeGraphN) -> Double { @_common.max(self.data) }

pub fn ChemrxntypeGraphN::to_string(self : ChemrxntypeGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxntypeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_type_node_make(size : Int) -> ChemrxntypeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxntypeNode::len(self : ChemrxntypeNode) -> Int { self.size }

pub fn ChemrxntypeNode::get(self : ChemrxntypeNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxntypeNode::set(self : ChemrxntypeNode, i : Int, v : Double) -> ChemrxntypeNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxntypeNode::sum(self : ChemrxntypeNode) -> Double { @_common.sum(self.data) }

pub fn ChemrxntypeNode::mean(self : ChemrxntypeNode) -> Double { @_common.mean(self.data) }

pub fn ChemrxntypeNode::scale(self : ChemrxntypeNode, f : Double) -> ChemrxntypeNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxntypeNode::add(self : ChemrxntypeNode, other : ChemrxntypeNode) -> ChemrxntypeNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxntypeNode::copy(self : ChemrxntypeNode) -> ChemrxntypeNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxntypeNode::fill(self : ChemrxntypeNode, v : Double) -> ChemrxntypeNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxntypeNode::min(self : ChemrxntypeNode) -> Double { @_common.min(self.data) }

pub fn ChemrxntypeNode::max(self : ChemrxntypeNode) -> Double { @_common.max(self.data) }

pub fn ChemrxntypeNode::to_string(self : ChemrxntypeNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxntypeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_type_edge_make(size : Int) -> ChemrxntypeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxntypeEdge::len(self : ChemrxntypeEdge) -> Int { self.size }

pub fn ChemrxntypeEdge::get(self : ChemrxntypeEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxntypeEdge::set(self : ChemrxntypeEdge, i : Int, v : Double) -> ChemrxntypeEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxntypeEdge::sum(self : ChemrxntypeEdge) -> Double { @_common.sum(self.data) }

pub fn ChemrxntypeEdge::mean(self : ChemrxntypeEdge) -> Double { @_common.mean(self.data) }

pub fn ChemrxntypeEdge::scale(self : ChemrxntypeEdge, f : Double) -> ChemrxntypeEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxntypeEdge::add(self : ChemrxntypeEdge, other : ChemrxntypeEdge) -> ChemrxntypeEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxntypeEdge::copy(self : ChemrxntypeEdge) -> ChemrxntypeEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxntypeEdge::fill(self : ChemrxntypeEdge, v : Double) -> ChemrxntypeEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxntypeEdge::min(self : ChemrxntypeEdge) -> Double { @_common.min(self.data) }

pub fn ChemrxntypeEdge::max(self : ChemrxntypeEdge) -> Double { @_common.max(self.data) }

pub fn ChemrxntypeEdge::to_string(self : ChemrxntypeEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxntypePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_type_path_make(size : Int) -> ChemrxntypePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxntypePath::len(self : ChemrxntypePath) -> Int { self.size }

pub fn ChemrxntypePath::get(self : ChemrxntypePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxntypePath::set(self : ChemrxntypePath, i : Int, v : Double) -> ChemrxntypePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxntypePath::sum(self : ChemrxntypePath) -> Double { @_common.sum(self.data) }

pub fn ChemrxntypePath::mean(self : ChemrxntypePath) -> Double { @_common.mean(self.data) }

pub fn ChemrxntypePath::scale(self : ChemrxntypePath, f : Double) -> ChemrxntypePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxntypePath::add(self : ChemrxntypePath, other : ChemrxntypePath) -> ChemrxntypePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxntypePath::copy(self : ChemrxntypePath) -> ChemrxntypePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxntypePath::fill(self : ChemrxntypePath, v : Double) -> ChemrxntypePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxntypePath::min(self : ChemrxntypePath) -> Double { @_common.min(self.data) }

pub fn ChemrxntypePath::max(self : ChemrxntypePath) -> Double { @_common.max(self.data) }

pub fn ChemrxntypePath::to_string(self : ChemrxntypePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxntypeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_type_cluster_make(size : Int) -> ChemrxntypeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxntypeCluster::len(self : ChemrxntypeCluster) -> Int { self.size }

pub fn ChemrxntypeCluster::get(self : ChemrxntypeCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxntypeCluster::set(self : ChemrxntypeCluster, i : Int, v : Double) -> ChemrxntypeCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxntypeCluster::sum(self : ChemrxntypeCluster) -> Double { @_common.sum(self.data) }

pub fn ChemrxntypeCluster::mean(self : ChemrxntypeCluster) -> Double { @_common.mean(self.data) }

pub fn ChemrxntypeCluster::scale(self : ChemrxntypeCluster, f : Double) -> ChemrxntypeCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxntypeCluster::add(self : ChemrxntypeCluster, other : ChemrxntypeCluster) -> ChemrxntypeCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxntypeCluster::copy(self : ChemrxntypeCluster) -> ChemrxntypeCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxntypeCluster::fill(self : ChemrxntypeCluster, v : Double) -> ChemrxntypeCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxntypeCluster::min(self : ChemrxntypeCluster) -> Double { @_common.min(self.data) }

pub fn ChemrxntypeCluster::max(self : ChemrxntypeCluster) -> Double { @_common.max(self.data) }

pub fn ChemrxntypeCluster::to_string(self : ChemrxntypeCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxntypeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_type_model_make(size : Int) -> ChemrxntypeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxntypeModel::len(self : ChemrxntypeModel) -> Int { self.size }

pub fn ChemrxntypeModel::get(self : ChemrxntypeModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxntypeModel::set(self : ChemrxntypeModel, i : Int, v : Double) -> ChemrxntypeModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxntypeModel::sum(self : ChemrxntypeModel) -> Double { @_common.sum(self.data) }

pub fn ChemrxntypeModel::mean(self : ChemrxntypeModel) -> Double { @_common.mean(self.data) }

pub fn ChemrxntypeModel::scale(self : ChemrxntypeModel, f : Double) -> ChemrxntypeModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxntypeModel::add(self : ChemrxntypeModel, other : ChemrxntypeModel) -> ChemrxntypeModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxntypeModel::copy(self : ChemrxntypeModel) -> ChemrxntypeModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxntypeModel::fill(self : ChemrxntypeModel, v : Double) -> ChemrxntypeModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxntypeModel::min(self : ChemrxntypeModel) -> Double { @_common.min(self.data) }

pub fn ChemrxntypeModel::max(self : ChemrxntypeModel) -> Double { @_common.max(self.data) }

pub fn ChemrxntypeModel::to_string(self : ChemrxntypeModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxntypeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_type_layer_make(size : Int) -> ChemrxntypeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxntypeLayer::len(self : ChemrxntypeLayer) -> Int { self.size }

pub fn ChemrxntypeLayer::get(self : ChemrxntypeLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxntypeLayer::set(self : ChemrxntypeLayer, i : Int, v : Double) -> ChemrxntypeLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxntypeLayer::sum(self : ChemrxntypeLayer) -> Double { @_common.sum(self.data) }

pub fn ChemrxntypeLayer::mean(self : ChemrxntypeLayer) -> Double { @_common.mean(self.data) }

pub fn ChemrxntypeLayer::scale(self : ChemrxntypeLayer, f : Double) -> ChemrxntypeLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxntypeLayer::add(self : ChemrxntypeLayer, other : ChemrxntypeLayer) -> ChemrxntypeLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxntypeLayer::copy(self : ChemrxntypeLayer) -> ChemrxntypeLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxntypeLayer::fill(self : ChemrxntypeLayer, v : Double) -> ChemrxntypeLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxntypeLayer::min(self : ChemrxntypeLayer) -> Double { @_common.min(self.data) }

pub fn ChemrxntypeLayer::max(self : ChemrxntypeLayer) -> Double { @_common.max(self.data) }

pub fn ChemrxntypeLayer::to_string(self : ChemrxntypeLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxntypeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_type_buffer_make(size : Int) -> ChemrxntypeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxntypeBuffer::len(self : ChemrxntypeBuffer) -> Int { self.size }

pub fn ChemrxntypeBuffer::get(self : ChemrxntypeBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxntypeBuffer::set(self : ChemrxntypeBuffer, i : Int, v : Double) -> ChemrxntypeBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxntypeBuffer::sum(self : ChemrxntypeBuffer) -> Double { @_common.sum(self.data) }

pub fn ChemrxntypeBuffer::mean(self : ChemrxntypeBuffer) -> Double { @_common.mean(self.data) }

pub fn ChemrxntypeBuffer::scale(self : ChemrxntypeBuffer, f : Double) -> ChemrxntypeBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxntypeBuffer::add(self : ChemrxntypeBuffer, other : ChemrxntypeBuffer) -> ChemrxntypeBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxntypeBuffer::copy(self : ChemrxntypeBuffer) -> ChemrxntypeBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxntypeBuffer::fill(self : ChemrxntypeBuffer, v : Double) -> ChemrxntypeBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxntypeBuffer::min(self : ChemrxntypeBuffer) -> Double { @_common.min(self.data) }

pub fn ChemrxntypeBuffer::max(self : ChemrxntypeBuffer) -> Double { @_common.max(self.data) }

pub fn ChemrxntypeBuffer::to_string(self : ChemrxntypeBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxntypeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_type_cursor_make(size : Int) -> ChemrxntypeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxntypeCursor::len(self : ChemrxntypeCursor) -> Int { self.size }

pub fn ChemrxntypeCursor::get(self : ChemrxntypeCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxntypeCursor::set(self : ChemrxntypeCursor, i : Int, v : Double) -> ChemrxntypeCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxntypeCursor::sum(self : ChemrxntypeCursor) -> Double { @_common.sum(self.data) }

pub fn ChemrxntypeCursor::mean(self : ChemrxntypeCursor) -> Double { @_common.mean(self.data) }

pub fn ChemrxntypeCursor::scale(self : ChemrxntypeCursor, f : Double) -> ChemrxntypeCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxntypeCursor::add(self : ChemrxntypeCursor, other : ChemrxntypeCursor) -> ChemrxntypeCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxntypeCursor::copy(self : ChemrxntypeCursor) -> ChemrxntypeCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxntypeCursor::fill(self : ChemrxntypeCursor, v : Double) -> ChemrxntypeCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxntypeCursor::min(self : ChemrxntypeCursor) -> Double { @_common.min(self.data) }

pub fn ChemrxntypeCursor::max(self : ChemrxntypeCursor) -> Double { @_common.max(self.data) }

pub fn ChemrxntypeCursor::to_string(self : ChemrxntypeCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxntypeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_type_view_make(size : Int) -> ChemrxntypeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxntypeView::len(self : ChemrxntypeView) -> Int { self.size }

pub fn ChemrxntypeView::get(self : ChemrxntypeView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxntypeView::set(self : ChemrxntypeView, i : Int, v : Double) -> ChemrxntypeView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxntypeView::sum(self : ChemrxntypeView) -> Double { @_common.sum(self.data) }

pub fn ChemrxntypeView::mean(self : ChemrxntypeView) -> Double { @_common.mean(self.data) }

pub fn ChemrxntypeView::scale(self : ChemrxntypeView, f : Double) -> ChemrxntypeView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxntypeView::add(self : ChemrxntypeView, other : ChemrxntypeView) -> ChemrxntypeView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxntypeView::copy(self : ChemrxntypeView) -> ChemrxntypeView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxntypeView::fill(self : ChemrxntypeView, v : Double) -> ChemrxntypeView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxntypeView::min(self : ChemrxntypeView) -> Double { @_common.min(self.data) }

pub fn ChemrxntypeView::max(self : ChemrxntypeView) -> Double { @_common.max(self.data) }

pub fn ChemrxntypeView::to_string(self : ChemrxntypeView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxntypeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_type_range_make(size : Int) -> ChemrxntypeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxntypeRange::len(self : ChemrxntypeRange) -> Int { self.size }

pub fn ChemrxntypeRange::get(self : ChemrxntypeRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxntypeRange::set(self : ChemrxntypeRange, i : Int, v : Double) -> ChemrxntypeRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxntypeRange::sum(self : ChemrxntypeRange) -> Double { @_common.sum(self.data) }

pub fn ChemrxntypeRange::mean(self : ChemrxntypeRange) -> Double { @_common.mean(self.data) }

pub fn ChemrxntypeRange::scale(self : ChemrxntypeRange, f : Double) -> ChemrxntypeRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxntypeRange::add(self : ChemrxntypeRange, other : ChemrxntypeRange) -> ChemrxntypeRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxntypeRange::copy(self : ChemrxntypeRange) -> ChemrxntypeRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxntypeRange::fill(self : ChemrxntypeRange, v : Double) -> ChemrxntypeRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxntypeRange::min(self : ChemrxntypeRange) -> Double { @_common.min(self.data) }

pub fn ChemrxntypeRange::max(self : ChemrxntypeRange) -> Double { @_common.max(self.data) }

pub fn ChemrxntypeRange::to_string(self : ChemrxntypeRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemrxntypeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_type_slice_make(size : Int) -> ChemrxntypeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemrxntypeSlice::len(self : ChemrxntypeSlice) -> Int { self.size }

pub fn ChemrxntypeSlice::get(self : ChemrxntypeSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemrxntypeSlice::set(self : ChemrxntypeSlice, i : Int, v : Double) -> ChemrxntypeSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemrxntypeSlice::sum(self : ChemrxntypeSlice) -> Double { @_common.sum(self.data) }

pub fn ChemrxntypeSlice::mean(self : ChemrxntypeSlice) -> Double { @_common.mean(self.data) }

pub fn ChemrxntypeSlice::scale(self : ChemrxntypeSlice, f : Double) -> ChemrxntypeSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemrxntypeSlice::add(self : ChemrxntypeSlice, other : ChemrxntypeSlice) -> ChemrxntypeSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemrxntypeSlice::copy(self : ChemrxntypeSlice) -> ChemrxntypeSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemrxntypeSlice::fill(self : ChemrxntypeSlice, v : Double) -> ChemrxntypeSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemrxntypeSlice::min(self : ChemrxntypeSlice) -> Double { @_common.min(self.data) }

pub fn ChemrxntypeSlice::max(self : ChemrxntypeSlice) -> Double { @_common.max(self.data) }

pub fn ChemrxntypeSlice::to_string(self : ChemrxntypeSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

