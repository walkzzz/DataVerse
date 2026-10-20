///===
/// extcore/chem_rxn_kinetics

pub(all) struct ChemrxnkineticsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_rxn_kinetics_make_point(x : Double, y : Double) -> ChemrxnkineticsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_rxn_kinetics_make_point3(x : Double, y : Double, z : Double) -> ChemrxnkineticsPoint {
  { x, y, z, label: 0 }
}

pub fn ChemrxnkineticsPoint::x(self : ChemrxnkineticsPoint) -> Double { self.x }

pub fn ChemrxnkineticsPoint::y(self : ChemrxnkineticsPoint) -> Double { self.y }

pub fn ChemrxnkineticsPoint::z(self : ChemrxnkineticsPoint) -> Double { self.z }

pub fn ChemrxnkineticsPoint::label(self : ChemrxnkineticsPoint) -> Int { self.label }

pub fn ChemrxnkineticsPoint::dist(self : ChemrxnkineticsPoint, other : ChemrxnkineticsPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemrxnkineticsPoint::add(self : ChemrxnkineticsPoint, other : ChemrxnkineticsPoint) -> ChemrxnkineticsPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemrxnkineticsPoint::sub(self : ChemrxnkineticsPoint, other : ChemrxnkineticsPoint) -> ChemrxnkineticsPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemrxnkineticsPoint::scale(self : ChemrxnkineticsPoint, s : Double) -> ChemrxnkineticsPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemrxnkineticsPoint::dot(self : ChemrxnkineticsPoint, other : ChemrxnkineticsPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemrxnkineticsPoint::cross(self : ChemrxnkineticsPoint, other : ChemrxnkineticsPoint) -> ChemrxnkineticsPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemrxnkineticsPoint::norm(self : ChemrxnkineticsPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemrxnkineticsPoint::normalize(self : ChemrxnkineticsPoint) -> ChemrxnkineticsPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemrxnkineticsPoint::negate(self : ChemrxnkineticsPoint) -> ChemrxnkineticsPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemrxnkineticsPoint::mid(self : ChemrxnkineticsPoint, other : ChemrxnkineticsPoint) -> ChemrxnkineticsPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemrxnkineticsPoint::lerp(self : ChemrxnkineticsPoint, other : ChemrxnkineticsPoint, t : Double) -> ChemrxnkineticsPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemrxnkineticsPoint::to_string(self : ChemrxnkineticsPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemrxnkineticsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_rxn_kinetics_make_series(vals : Array[Double], name : String) -> ChemrxnkineticsSeries {
  { vals, name, meta: 0 }
}

pub fn ChemrxnkineticsSeries::len(self : ChemrxnkineticsSeries) -> Int { self.vals.length() }

pub fn ChemrxnkineticsSeries::sum(self : ChemrxnkineticsSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemrxnkineticsSeries::mean(self : ChemrxnkineticsSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemrxnkineticsSeries::min(self : ChemrxnkineticsSeries) -> Double { @_common.min(self.vals) }

pub fn ChemrxnkineticsSeries::max(self : ChemrxnkineticsSeries) -> Double { @_common.max(self.vals) }

pub fn ChemrxnkineticsSeries::range(self : ChemrxnkineticsSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemrxnkineticsSeries::variance(self : ChemrxnkineticsSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemrxnkineticsSeries::std(self : ChemrxnkineticsSeries) -> Double { @_common.std(self.vals) }

pub fn ChemrxnkineticsSeries::median(self : ChemrxnkineticsSeries) -> Double { @_common.median(self.vals) }

pub fn ChemrxnkineticsSeries::scale(self : ChemrxnkineticsSeries, f : Double) -> ChemrxnkineticsSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemrxnkineticsSeries::add(self : ChemrxnkineticsSeries, other : ChemrxnkineticsSeries) -> ChemrxnkineticsSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemrxnkineticsSeries::sub(self : ChemrxnkineticsSeries, other : ChemrxnkineticsSeries) -> ChemrxnkineticsSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemrxnkineticsSeries::normalize(self : ChemrxnkineticsSeries) -> ChemrxnkineticsSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemrxnkineticsSeries::cumsum(self : ChemrxnkineticsSeries) -> ChemrxnkineticsSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemrxnkineticsSeries::to_string(self : ChemrxnkineticsSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemrxnkineticsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_rxn_kinetics_make_matrix(rows : Int, cols : Int, val : Double) -> ChemrxnkineticsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_rxn_kinetics_matrix_identity(n : Int) -> ChemrxnkineticsMatrix {
  let m = chem_rxn_kinetics_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemrxnkineticsMatrix::get(self : ChemrxnkineticsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemrxnkineticsMatrix::transpose(self : ChemrxnkineticsMatrix) -> ChemrxnkineticsMatrix {
  let result = chem_rxn_kinetics_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemrxnkineticsMatrix::add(self : ChemrxnkineticsMatrix, other : ChemrxnkineticsMatrix) -> ChemrxnkineticsMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_rxn_kinetics_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemrxnkineticsMatrix::scale(self : ChemrxnkineticsMatrix, s : Double) -> ChemrxnkineticsMatrix {
  let result = chem_rxn_kinetics_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemrxnkineticsMatrix::multiply(self : ChemrxnkineticsMatrix, other : ChemrxnkineticsMatrix) -> ChemrxnkineticsMatrix {
  if self.cols != other.rows { return chem_rxn_kinetics_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_rxn_kinetics_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ChemrxnkineticsMatrix::trace(self : ChemrxnkineticsMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemrxnkineticsMatrix::det(self : ChemrxnkineticsMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemrxnkineticsMatrix::norm(self : ChemrxnkineticsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemrxnkineticsMatrix::to_string(self : ChemrxnkineticsMatrix) -> String {
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

pub(all) struct ChemrxnkineticsVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_rxn_kinetics_make_vector(comps : Array[Double]) -> ChemrxnkineticsVector {
  { comps, dim: comps.length() }
}

pub fn chem_rxn_kinetics_vector_zero(dim : Int) -> ChemrxnkineticsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemrxnkineticsVector::add(self : ChemrxnkineticsVector, other : ChemrxnkineticsVector) -> ChemrxnkineticsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemrxnkineticsVector::sub(self : ChemrxnkineticsVector, other : ChemrxnkineticsVector) -> ChemrxnkineticsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemrxnkineticsVector::scale(self : ChemrxnkineticsVector, s : Double) -> ChemrxnkineticsVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemrxnkineticsVector::dot(self : ChemrxnkineticsVector, other : ChemrxnkineticsVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemrxnkineticsVector::norm(self : ChemrxnkineticsVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemrxnkineticsVector::normalize(self : ChemrxnkineticsVector) -> ChemrxnkineticsVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemrxnkineticsVector::dist(self : ChemrxnkineticsVector, other : ChemrxnkineticsVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemrxnkineticsVector::to_string(self : ChemrxnkineticsVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_rxn_kinetics_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_rxn_kinetics_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_rxn_kinetics_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_rxn_kinetics_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_rxn_kinetics_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_rxn_kinetics_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_rxn_kinetics_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_rxn_kinetics_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_rxn_kinetics_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_rxn_kinetics_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_rxn_kinetics_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_rxn_kinetics_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_rxn_kinetics_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_rxn_kinetics_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_rxn_kinetics_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_rxn_kinetics_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_rxn_kinetics_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_rxn_kinetics_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_rxn_kinetics_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_rxn_kinetics_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_rxn_kinetics_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_rxn_kinetics_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_rxn_kinetics_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_rxn_kinetics_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_rxn_kinetics_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_rxn_kinetics_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_rxn_kinetics_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_rxn_kinetics_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_rxn_kinetics_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemrxnkineticsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_frame_make(size : Int) -> ChemrxnkineticsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_kinetics_frame_len(s : ChemrxnkineticsFrame) -> Int { s.size }

pub fn chem_rxn_kinetics_frame_get(s : ChemrxnkineticsFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_kinetics_frame_set(s : ChemrxnkineticsFrame, i : Int, v : Double) -> ChemrxnkineticsFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_frame_sum(s : ChemrxnkineticsFrame) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_kinetics_frame_mean(s : ChemrxnkineticsFrame) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_kinetics_frame_scale(s : ChemrxnkineticsFrame, f : Double) -> ChemrxnkineticsFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_frame_add(a : ChemrxnkineticsFrame, b : ChemrxnkineticsFrame) -> ChemrxnkineticsFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_kinetics_frame_copy(s : ChemrxnkineticsFrame) -> ChemrxnkineticsFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_frame_fill(s : ChemrxnkineticsFrame, v : Double) -> ChemrxnkineticsFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_frame_min(s : ChemrxnkineticsFrame) -> Double { @_common.min(s.data) }

pub fn chem_rxn_kinetics_frame_max(s : ChemrxnkineticsFrame) -> Double { @_common.max(s.data) }

pub fn chem_rxn_kinetics_frame_to_string(s : ChemrxnkineticsFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_table_make(size : Int) -> ChemrxnkineticsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_kinetics_table_len(s : ChemrxnkineticsTable) -> Int { s.size }

pub fn chem_rxn_kinetics_table_get(s : ChemrxnkineticsTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_kinetics_table_set(s : ChemrxnkineticsTable, i : Int, v : Double) -> ChemrxnkineticsTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_table_sum(s : ChemrxnkineticsTable) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_kinetics_table_mean(s : ChemrxnkineticsTable) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_kinetics_table_scale(s : ChemrxnkineticsTable, f : Double) -> ChemrxnkineticsTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_table_add(a : ChemrxnkineticsTable, b : ChemrxnkineticsTable) -> ChemrxnkineticsTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_kinetics_table_copy(s : ChemrxnkineticsTable) -> ChemrxnkineticsTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_table_fill(s : ChemrxnkineticsTable, v : Double) -> ChemrxnkineticsTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_table_min(s : ChemrxnkineticsTable) -> Double { @_common.min(s.data) }

pub fn chem_rxn_kinetics_table_max(s : ChemrxnkineticsTable) -> Double { @_common.max(s.data) }

pub fn chem_rxn_kinetics_table_to_string(s : ChemrxnkineticsTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_graphn_make(size : Int) -> ChemrxnkineticsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_kinetics_graphn_len(s : ChemrxnkineticsGraphN) -> Int { s.size }

pub fn chem_rxn_kinetics_graphn_get(s : ChemrxnkineticsGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_kinetics_graphn_set(s : ChemrxnkineticsGraphN, i : Int, v : Double) -> ChemrxnkineticsGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_graphn_sum(s : ChemrxnkineticsGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_kinetics_graphn_mean(s : ChemrxnkineticsGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_kinetics_graphn_scale(s : ChemrxnkineticsGraphN, f : Double) -> ChemrxnkineticsGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_graphn_add(a : ChemrxnkineticsGraphN, b : ChemrxnkineticsGraphN) -> ChemrxnkineticsGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_kinetics_graphn_copy(s : ChemrxnkineticsGraphN) -> ChemrxnkineticsGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_graphn_fill(s : ChemrxnkineticsGraphN, v : Double) -> ChemrxnkineticsGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_graphn_min(s : ChemrxnkineticsGraphN) -> Double { @_common.min(s.data) }

pub fn chem_rxn_kinetics_graphn_max(s : ChemrxnkineticsGraphN) -> Double { @_common.max(s.data) }

pub fn chem_rxn_kinetics_graphn_to_string(s : ChemrxnkineticsGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_node_make(size : Int) -> ChemrxnkineticsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_kinetics_node_len(s : ChemrxnkineticsNode) -> Int { s.size }

pub fn chem_rxn_kinetics_node_get(s : ChemrxnkineticsNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_kinetics_node_set(s : ChemrxnkineticsNode, i : Int, v : Double) -> ChemrxnkineticsNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_node_sum(s : ChemrxnkineticsNode) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_kinetics_node_mean(s : ChemrxnkineticsNode) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_kinetics_node_scale(s : ChemrxnkineticsNode, f : Double) -> ChemrxnkineticsNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_node_add(a : ChemrxnkineticsNode, b : ChemrxnkineticsNode) -> ChemrxnkineticsNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_kinetics_node_copy(s : ChemrxnkineticsNode) -> ChemrxnkineticsNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_node_fill(s : ChemrxnkineticsNode, v : Double) -> ChemrxnkineticsNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_node_min(s : ChemrxnkineticsNode) -> Double { @_common.min(s.data) }

pub fn chem_rxn_kinetics_node_max(s : ChemrxnkineticsNode) -> Double { @_common.max(s.data) }

pub fn chem_rxn_kinetics_node_to_string(s : ChemrxnkineticsNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_edge_make(size : Int) -> ChemrxnkineticsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_kinetics_edge_len(s : ChemrxnkineticsEdge) -> Int { s.size }

pub fn chem_rxn_kinetics_edge_get(s : ChemrxnkineticsEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_kinetics_edge_set(s : ChemrxnkineticsEdge, i : Int, v : Double) -> ChemrxnkineticsEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_edge_sum(s : ChemrxnkineticsEdge) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_kinetics_edge_mean(s : ChemrxnkineticsEdge) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_kinetics_edge_scale(s : ChemrxnkineticsEdge, f : Double) -> ChemrxnkineticsEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_edge_add(a : ChemrxnkineticsEdge, b : ChemrxnkineticsEdge) -> ChemrxnkineticsEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_kinetics_edge_copy(s : ChemrxnkineticsEdge) -> ChemrxnkineticsEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_edge_fill(s : ChemrxnkineticsEdge, v : Double) -> ChemrxnkineticsEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_edge_min(s : ChemrxnkineticsEdge) -> Double { @_common.min(s.data) }

pub fn chem_rxn_kinetics_edge_max(s : ChemrxnkineticsEdge) -> Double { @_common.max(s.data) }

pub fn chem_rxn_kinetics_edge_to_string(s : ChemrxnkineticsEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_path_make(size : Int) -> ChemrxnkineticsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_kinetics_path_len(s : ChemrxnkineticsPath) -> Int { s.size }

pub fn chem_rxn_kinetics_path_get(s : ChemrxnkineticsPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_kinetics_path_set(s : ChemrxnkineticsPath, i : Int, v : Double) -> ChemrxnkineticsPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_path_sum(s : ChemrxnkineticsPath) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_kinetics_path_mean(s : ChemrxnkineticsPath) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_kinetics_path_scale(s : ChemrxnkineticsPath, f : Double) -> ChemrxnkineticsPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_path_add(a : ChemrxnkineticsPath, b : ChemrxnkineticsPath) -> ChemrxnkineticsPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_kinetics_path_copy(s : ChemrxnkineticsPath) -> ChemrxnkineticsPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_path_fill(s : ChemrxnkineticsPath, v : Double) -> ChemrxnkineticsPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_path_min(s : ChemrxnkineticsPath) -> Double { @_common.min(s.data) }

pub fn chem_rxn_kinetics_path_max(s : ChemrxnkineticsPath) -> Double { @_common.max(s.data) }

pub fn chem_rxn_kinetics_path_to_string(s : ChemrxnkineticsPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_cluster_make(size : Int) -> ChemrxnkineticsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_kinetics_cluster_len(s : ChemrxnkineticsCluster) -> Int { s.size }

pub fn chem_rxn_kinetics_cluster_get(s : ChemrxnkineticsCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_kinetics_cluster_set(s : ChemrxnkineticsCluster, i : Int, v : Double) -> ChemrxnkineticsCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_cluster_sum(s : ChemrxnkineticsCluster) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_kinetics_cluster_mean(s : ChemrxnkineticsCluster) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_kinetics_cluster_scale(s : ChemrxnkineticsCluster, f : Double) -> ChemrxnkineticsCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_cluster_add(a : ChemrxnkineticsCluster, b : ChemrxnkineticsCluster) -> ChemrxnkineticsCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_kinetics_cluster_copy(s : ChemrxnkineticsCluster) -> ChemrxnkineticsCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_cluster_fill(s : ChemrxnkineticsCluster, v : Double) -> ChemrxnkineticsCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_cluster_min(s : ChemrxnkineticsCluster) -> Double { @_common.min(s.data) }

pub fn chem_rxn_kinetics_cluster_max(s : ChemrxnkineticsCluster) -> Double { @_common.max(s.data) }

pub fn chem_rxn_kinetics_cluster_to_string(s : ChemrxnkineticsCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_model_make(size : Int) -> ChemrxnkineticsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_kinetics_model_len(s : ChemrxnkineticsModel) -> Int { s.size }

pub fn chem_rxn_kinetics_model_get(s : ChemrxnkineticsModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_kinetics_model_set(s : ChemrxnkineticsModel, i : Int, v : Double) -> ChemrxnkineticsModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_model_sum(s : ChemrxnkineticsModel) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_kinetics_model_mean(s : ChemrxnkineticsModel) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_kinetics_model_scale(s : ChemrxnkineticsModel, f : Double) -> ChemrxnkineticsModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_model_add(a : ChemrxnkineticsModel, b : ChemrxnkineticsModel) -> ChemrxnkineticsModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_kinetics_model_copy(s : ChemrxnkineticsModel) -> ChemrxnkineticsModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_model_fill(s : ChemrxnkineticsModel, v : Double) -> ChemrxnkineticsModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_model_min(s : ChemrxnkineticsModel) -> Double { @_common.min(s.data) }

pub fn chem_rxn_kinetics_model_max(s : ChemrxnkineticsModel) -> Double { @_common.max(s.data) }

pub fn chem_rxn_kinetics_model_to_string(s : ChemrxnkineticsModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_layer_make(size : Int) -> ChemrxnkineticsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_kinetics_layer_len(s : ChemrxnkineticsLayer) -> Int { s.size }

pub fn chem_rxn_kinetics_layer_get(s : ChemrxnkineticsLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_kinetics_layer_set(s : ChemrxnkineticsLayer, i : Int, v : Double) -> ChemrxnkineticsLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_layer_sum(s : ChemrxnkineticsLayer) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_kinetics_layer_mean(s : ChemrxnkineticsLayer) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_kinetics_layer_scale(s : ChemrxnkineticsLayer, f : Double) -> ChemrxnkineticsLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_layer_add(a : ChemrxnkineticsLayer, b : ChemrxnkineticsLayer) -> ChemrxnkineticsLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_kinetics_layer_copy(s : ChemrxnkineticsLayer) -> ChemrxnkineticsLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_layer_fill(s : ChemrxnkineticsLayer, v : Double) -> ChemrxnkineticsLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_layer_min(s : ChemrxnkineticsLayer) -> Double { @_common.min(s.data) }

pub fn chem_rxn_kinetics_layer_max(s : ChemrxnkineticsLayer) -> Double { @_common.max(s.data) }

pub fn chem_rxn_kinetics_layer_to_string(s : ChemrxnkineticsLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_buffer_make(size : Int) -> ChemrxnkineticsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_kinetics_buffer_len(s : ChemrxnkineticsBuffer) -> Int { s.size }

pub fn chem_rxn_kinetics_buffer_get(s : ChemrxnkineticsBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_kinetics_buffer_set(s : ChemrxnkineticsBuffer, i : Int, v : Double) -> ChemrxnkineticsBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_buffer_sum(s : ChemrxnkineticsBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_kinetics_buffer_mean(s : ChemrxnkineticsBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_kinetics_buffer_scale(s : ChemrxnkineticsBuffer, f : Double) -> ChemrxnkineticsBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_buffer_add(a : ChemrxnkineticsBuffer, b : ChemrxnkineticsBuffer) -> ChemrxnkineticsBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_kinetics_buffer_copy(s : ChemrxnkineticsBuffer) -> ChemrxnkineticsBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_buffer_fill(s : ChemrxnkineticsBuffer, v : Double) -> ChemrxnkineticsBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_buffer_min(s : ChemrxnkineticsBuffer) -> Double { @_common.min(s.data) }

pub fn chem_rxn_kinetics_buffer_max(s : ChemrxnkineticsBuffer) -> Double { @_common.max(s.data) }

pub fn chem_rxn_kinetics_buffer_to_string(s : ChemrxnkineticsBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_cursor_make(size : Int) -> ChemrxnkineticsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_kinetics_cursor_len(s : ChemrxnkineticsCursor) -> Int { s.size }

pub fn chem_rxn_kinetics_cursor_get(s : ChemrxnkineticsCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_kinetics_cursor_set(s : ChemrxnkineticsCursor, i : Int, v : Double) -> ChemrxnkineticsCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_cursor_sum(s : ChemrxnkineticsCursor) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_kinetics_cursor_mean(s : ChemrxnkineticsCursor) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_kinetics_cursor_scale(s : ChemrxnkineticsCursor, f : Double) -> ChemrxnkineticsCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_cursor_add(a : ChemrxnkineticsCursor, b : ChemrxnkineticsCursor) -> ChemrxnkineticsCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_kinetics_cursor_copy(s : ChemrxnkineticsCursor) -> ChemrxnkineticsCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_cursor_fill(s : ChemrxnkineticsCursor, v : Double) -> ChemrxnkineticsCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_cursor_min(s : ChemrxnkineticsCursor) -> Double { @_common.min(s.data) }

pub fn chem_rxn_kinetics_cursor_max(s : ChemrxnkineticsCursor) -> Double { @_common.max(s.data) }

pub fn chem_rxn_kinetics_cursor_to_string(s : ChemrxnkineticsCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_view_make(size : Int) -> ChemrxnkineticsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_kinetics_view_len(s : ChemrxnkineticsView) -> Int { s.size }

pub fn chem_rxn_kinetics_view_get(s : ChemrxnkineticsView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_kinetics_view_set(s : ChemrxnkineticsView, i : Int, v : Double) -> ChemrxnkineticsView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_view_sum(s : ChemrxnkineticsView) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_kinetics_view_mean(s : ChemrxnkineticsView) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_kinetics_view_scale(s : ChemrxnkineticsView, f : Double) -> ChemrxnkineticsView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_view_add(a : ChemrxnkineticsView, b : ChemrxnkineticsView) -> ChemrxnkineticsView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_kinetics_view_copy(s : ChemrxnkineticsView) -> ChemrxnkineticsView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_view_fill(s : ChemrxnkineticsView, v : Double) -> ChemrxnkineticsView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_view_min(s : ChemrxnkineticsView) -> Double { @_common.min(s.data) }

pub fn chem_rxn_kinetics_view_max(s : ChemrxnkineticsView) -> Double { @_common.max(s.data) }

pub fn chem_rxn_kinetics_view_to_string(s : ChemrxnkineticsView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_range_make(size : Int) -> ChemrxnkineticsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_kinetics_range_len(s : ChemrxnkineticsRange) -> Int { s.size }

pub fn chem_rxn_kinetics_range_get(s : ChemrxnkineticsRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_kinetics_range_set(s : ChemrxnkineticsRange, i : Int, v : Double) -> ChemrxnkineticsRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_range_sum(s : ChemrxnkineticsRange) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_kinetics_range_mean(s : ChemrxnkineticsRange) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_kinetics_range_scale(s : ChemrxnkineticsRange, f : Double) -> ChemrxnkineticsRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_range_add(a : ChemrxnkineticsRange, b : ChemrxnkineticsRange) -> ChemrxnkineticsRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_kinetics_range_copy(s : ChemrxnkineticsRange) -> ChemrxnkineticsRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_range_fill(s : ChemrxnkineticsRange, v : Double) -> ChemrxnkineticsRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_range_min(s : ChemrxnkineticsRange) -> Double { @_common.min(s.data) }

pub fn chem_rxn_kinetics_range_max(s : ChemrxnkineticsRange) -> Double { @_common.max(s.data) }

pub fn chem_rxn_kinetics_range_to_string(s : ChemrxnkineticsRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_slice_make(size : Int) -> ChemrxnkineticsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_kinetics_slice_len(s : ChemrxnkineticsSlice) -> Int { s.size }

pub fn chem_rxn_kinetics_slice_get(s : ChemrxnkineticsSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_kinetics_slice_set(s : ChemrxnkineticsSlice, i : Int, v : Double) -> ChemrxnkineticsSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_slice_sum(s : ChemrxnkineticsSlice) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_kinetics_slice_mean(s : ChemrxnkineticsSlice) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_kinetics_slice_scale(s : ChemrxnkineticsSlice, f : Double) -> ChemrxnkineticsSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_slice_add(a : ChemrxnkineticsSlice, b : ChemrxnkineticsSlice) -> ChemrxnkineticsSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_kinetics_slice_copy(s : ChemrxnkineticsSlice) -> ChemrxnkineticsSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_slice_fill(s : ChemrxnkineticsSlice, v : Double) -> ChemrxnkineticsSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_kinetics_slice_min(s : ChemrxnkineticsSlice) -> Double { @_common.min(s.data) }

pub fn chem_rxn_kinetics_slice_max(s : ChemrxnkineticsSlice) -> Double { @_common.max(s.data) }

pub fn chem_rxn_kinetics_slice_to_string(s : ChemrxnkineticsSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

