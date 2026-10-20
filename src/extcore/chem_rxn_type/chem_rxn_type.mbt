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

pub fn chem_rxn_type_frame_len(s : ChemrxntypeFrame) -> Int { s.size }

pub fn chem_rxn_type_frame_get(s : ChemrxntypeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_type_frame_set(s : ChemrxntypeFrame, i : Int, v : Double) -> ChemrxntypeFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_frame_sum(s : ChemrxntypeFrame) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_type_frame_mean(s : ChemrxntypeFrame) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_type_frame_scale(s : ChemrxntypeFrame, f : Double) -> ChemrxntypeFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_frame_add(a : ChemrxntypeFrame, b : ChemrxntypeFrame) -> ChemrxntypeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_type_frame_copy(s : ChemrxntypeFrame) -> ChemrxntypeFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_frame_fill(s : ChemrxntypeFrame, v : Double) -> ChemrxntypeFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_frame_min(s : ChemrxntypeFrame) -> Double { @_common.min(s.data) }

pub fn chem_rxn_type_frame_max(s : ChemrxntypeFrame) -> Double { @_common.max(s.data) }

pub fn chem_rxn_type_frame_to_string(s : ChemrxntypeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxntypeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_type_table_make(size : Int) -> ChemrxntypeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_type_table_len(s : ChemrxntypeTable) -> Int { s.size }

pub fn chem_rxn_type_table_get(s : ChemrxntypeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_type_table_set(s : ChemrxntypeTable, i : Int, v : Double) -> ChemrxntypeTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_table_sum(s : ChemrxntypeTable) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_type_table_mean(s : ChemrxntypeTable) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_type_table_scale(s : ChemrxntypeTable, f : Double) -> ChemrxntypeTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_table_add(a : ChemrxntypeTable, b : ChemrxntypeTable) -> ChemrxntypeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_type_table_copy(s : ChemrxntypeTable) -> ChemrxntypeTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_table_fill(s : ChemrxntypeTable, v : Double) -> ChemrxntypeTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_table_min(s : ChemrxntypeTable) -> Double { @_common.min(s.data) }

pub fn chem_rxn_type_table_max(s : ChemrxntypeTable) -> Double { @_common.max(s.data) }

pub fn chem_rxn_type_table_to_string(s : ChemrxntypeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxntypeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_type_graphn_make(size : Int) -> ChemrxntypeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_type_graphn_len(s : ChemrxntypeGraphN) -> Int { s.size }

pub fn chem_rxn_type_graphn_get(s : ChemrxntypeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_type_graphn_set(s : ChemrxntypeGraphN, i : Int, v : Double) -> ChemrxntypeGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_graphn_sum(s : ChemrxntypeGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_type_graphn_mean(s : ChemrxntypeGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_type_graphn_scale(s : ChemrxntypeGraphN, f : Double) -> ChemrxntypeGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_graphn_add(a : ChemrxntypeGraphN, b : ChemrxntypeGraphN) -> ChemrxntypeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_type_graphn_copy(s : ChemrxntypeGraphN) -> ChemrxntypeGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_graphn_fill(s : ChemrxntypeGraphN, v : Double) -> ChemrxntypeGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_graphn_min(s : ChemrxntypeGraphN) -> Double { @_common.min(s.data) }

pub fn chem_rxn_type_graphn_max(s : ChemrxntypeGraphN) -> Double { @_common.max(s.data) }

pub fn chem_rxn_type_graphn_to_string(s : ChemrxntypeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxntypeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_type_node_make(size : Int) -> ChemrxntypeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_type_node_len(s : ChemrxntypeNode) -> Int { s.size }

pub fn chem_rxn_type_node_get(s : ChemrxntypeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_type_node_set(s : ChemrxntypeNode, i : Int, v : Double) -> ChemrxntypeNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_node_sum(s : ChemrxntypeNode) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_type_node_mean(s : ChemrxntypeNode) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_type_node_scale(s : ChemrxntypeNode, f : Double) -> ChemrxntypeNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_node_add(a : ChemrxntypeNode, b : ChemrxntypeNode) -> ChemrxntypeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_type_node_copy(s : ChemrxntypeNode) -> ChemrxntypeNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_node_fill(s : ChemrxntypeNode, v : Double) -> ChemrxntypeNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_node_min(s : ChemrxntypeNode) -> Double { @_common.min(s.data) }

pub fn chem_rxn_type_node_max(s : ChemrxntypeNode) -> Double { @_common.max(s.data) }

pub fn chem_rxn_type_node_to_string(s : ChemrxntypeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxntypeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_type_edge_make(size : Int) -> ChemrxntypeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_type_edge_len(s : ChemrxntypeEdge) -> Int { s.size }

pub fn chem_rxn_type_edge_get(s : ChemrxntypeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_type_edge_set(s : ChemrxntypeEdge, i : Int, v : Double) -> ChemrxntypeEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_edge_sum(s : ChemrxntypeEdge) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_type_edge_mean(s : ChemrxntypeEdge) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_type_edge_scale(s : ChemrxntypeEdge, f : Double) -> ChemrxntypeEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_edge_add(a : ChemrxntypeEdge, b : ChemrxntypeEdge) -> ChemrxntypeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_type_edge_copy(s : ChemrxntypeEdge) -> ChemrxntypeEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_edge_fill(s : ChemrxntypeEdge, v : Double) -> ChemrxntypeEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_edge_min(s : ChemrxntypeEdge) -> Double { @_common.min(s.data) }

pub fn chem_rxn_type_edge_max(s : ChemrxntypeEdge) -> Double { @_common.max(s.data) }

pub fn chem_rxn_type_edge_to_string(s : ChemrxntypeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxntypePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_type_path_make(size : Int) -> ChemrxntypePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_type_path_len(s : ChemrxntypePath) -> Int { s.size }

pub fn chem_rxn_type_path_get(s : ChemrxntypePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_type_path_set(s : ChemrxntypePath, i : Int, v : Double) -> ChemrxntypePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_path_sum(s : ChemrxntypePath) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_type_path_mean(s : ChemrxntypePath) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_type_path_scale(s : ChemrxntypePath, f : Double) -> ChemrxntypePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_path_add(a : ChemrxntypePath, b : ChemrxntypePath) -> ChemrxntypePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_type_path_copy(s : ChemrxntypePath) -> ChemrxntypePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_path_fill(s : ChemrxntypePath, v : Double) -> ChemrxntypePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_path_min(s : ChemrxntypePath) -> Double { @_common.min(s.data) }

pub fn chem_rxn_type_path_max(s : ChemrxntypePath) -> Double { @_common.max(s.data) }

pub fn chem_rxn_type_path_to_string(s : ChemrxntypePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxntypeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_type_cluster_make(size : Int) -> ChemrxntypeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_type_cluster_len(s : ChemrxntypeCluster) -> Int { s.size }

pub fn chem_rxn_type_cluster_get(s : ChemrxntypeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_type_cluster_set(s : ChemrxntypeCluster, i : Int, v : Double) -> ChemrxntypeCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_cluster_sum(s : ChemrxntypeCluster) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_type_cluster_mean(s : ChemrxntypeCluster) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_type_cluster_scale(s : ChemrxntypeCluster, f : Double) -> ChemrxntypeCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_cluster_add(a : ChemrxntypeCluster, b : ChemrxntypeCluster) -> ChemrxntypeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_type_cluster_copy(s : ChemrxntypeCluster) -> ChemrxntypeCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_cluster_fill(s : ChemrxntypeCluster, v : Double) -> ChemrxntypeCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_cluster_min(s : ChemrxntypeCluster) -> Double { @_common.min(s.data) }

pub fn chem_rxn_type_cluster_max(s : ChemrxntypeCluster) -> Double { @_common.max(s.data) }

pub fn chem_rxn_type_cluster_to_string(s : ChemrxntypeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxntypeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_type_model_make(size : Int) -> ChemrxntypeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_type_model_len(s : ChemrxntypeModel) -> Int { s.size }

pub fn chem_rxn_type_model_get(s : ChemrxntypeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_type_model_set(s : ChemrxntypeModel, i : Int, v : Double) -> ChemrxntypeModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_model_sum(s : ChemrxntypeModel) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_type_model_mean(s : ChemrxntypeModel) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_type_model_scale(s : ChemrxntypeModel, f : Double) -> ChemrxntypeModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_model_add(a : ChemrxntypeModel, b : ChemrxntypeModel) -> ChemrxntypeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_type_model_copy(s : ChemrxntypeModel) -> ChemrxntypeModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_model_fill(s : ChemrxntypeModel, v : Double) -> ChemrxntypeModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_model_min(s : ChemrxntypeModel) -> Double { @_common.min(s.data) }

pub fn chem_rxn_type_model_max(s : ChemrxntypeModel) -> Double { @_common.max(s.data) }

pub fn chem_rxn_type_model_to_string(s : ChemrxntypeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxntypeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_type_layer_make(size : Int) -> ChemrxntypeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_type_layer_len(s : ChemrxntypeLayer) -> Int { s.size }

pub fn chem_rxn_type_layer_get(s : ChemrxntypeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_type_layer_set(s : ChemrxntypeLayer, i : Int, v : Double) -> ChemrxntypeLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_layer_sum(s : ChemrxntypeLayer) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_type_layer_mean(s : ChemrxntypeLayer) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_type_layer_scale(s : ChemrxntypeLayer, f : Double) -> ChemrxntypeLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_layer_add(a : ChemrxntypeLayer, b : ChemrxntypeLayer) -> ChemrxntypeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_type_layer_copy(s : ChemrxntypeLayer) -> ChemrxntypeLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_layer_fill(s : ChemrxntypeLayer, v : Double) -> ChemrxntypeLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_layer_min(s : ChemrxntypeLayer) -> Double { @_common.min(s.data) }

pub fn chem_rxn_type_layer_max(s : ChemrxntypeLayer) -> Double { @_common.max(s.data) }

pub fn chem_rxn_type_layer_to_string(s : ChemrxntypeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxntypeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_type_buffer_make(size : Int) -> ChemrxntypeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_type_buffer_len(s : ChemrxntypeBuffer) -> Int { s.size }

pub fn chem_rxn_type_buffer_get(s : ChemrxntypeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_type_buffer_set(s : ChemrxntypeBuffer, i : Int, v : Double) -> ChemrxntypeBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_buffer_sum(s : ChemrxntypeBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_type_buffer_mean(s : ChemrxntypeBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_type_buffer_scale(s : ChemrxntypeBuffer, f : Double) -> ChemrxntypeBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_buffer_add(a : ChemrxntypeBuffer, b : ChemrxntypeBuffer) -> ChemrxntypeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_type_buffer_copy(s : ChemrxntypeBuffer) -> ChemrxntypeBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_buffer_fill(s : ChemrxntypeBuffer, v : Double) -> ChemrxntypeBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_buffer_min(s : ChemrxntypeBuffer) -> Double { @_common.min(s.data) }

pub fn chem_rxn_type_buffer_max(s : ChemrxntypeBuffer) -> Double { @_common.max(s.data) }

pub fn chem_rxn_type_buffer_to_string(s : ChemrxntypeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxntypeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_type_cursor_make(size : Int) -> ChemrxntypeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_type_cursor_len(s : ChemrxntypeCursor) -> Int { s.size }

pub fn chem_rxn_type_cursor_get(s : ChemrxntypeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_type_cursor_set(s : ChemrxntypeCursor, i : Int, v : Double) -> ChemrxntypeCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_cursor_sum(s : ChemrxntypeCursor) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_type_cursor_mean(s : ChemrxntypeCursor) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_type_cursor_scale(s : ChemrxntypeCursor, f : Double) -> ChemrxntypeCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_cursor_add(a : ChemrxntypeCursor, b : ChemrxntypeCursor) -> ChemrxntypeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_type_cursor_copy(s : ChemrxntypeCursor) -> ChemrxntypeCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_cursor_fill(s : ChemrxntypeCursor, v : Double) -> ChemrxntypeCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_cursor_min(s : ChemrxntypeCursor) -> Double { @_common.min(s.data) }

pub fn chem_rxn_type_cursor_max(s : ChemrxntypeCursor) -> Double { @_common.max(s.data) }

pub fn chem_rxn_type_cursor_to_string(s : ChemrxntypeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxntypeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_type_view_make(size : Int) -> ChemrxntypeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_type_view_len(s : ChemrxntypeView) -> Int { s.size }

pub fn chem_rxn_type_view_get(s : ChemrxntypeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_type_view_set(s : ChemrxntypeView, i : Int, v : Double) -> ChemrxntypeView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_view_sum(s : ChemrxntypeView) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_type_view_mean(s : ChemrxntypeView) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_type_view_scale(s : ChemrxntypeView, f : Double) -> ChemrxntypeView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_view_add(a : ChemrxntypeView, b : ChemrxntypeView) -> ChemrxntypeView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_type_view_copy(s : ChemrxntypeView) -> ChemrxntypeView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_view_fill(s : ChemrxntypeView, v : Double) -> ChemrxntypeView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_view_min(s : ChemrxntypeView) -> Double { @_common.min(s.data) }

pub fn chem_rxn_type_view_max(s : ChemrxntypeView) -> Double { @_common.max(s.data) }

pub fn chem_rxn_type_view_to_string(s : ChemrxntypeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxntypeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_type_range_make(size : Int) -> ChemrxntypeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_type_range_len(s : ChemrxntypeRange) -> Int { s.size }

pub fn chem_rxn_type_range_get(s : ChemrxntypeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_type_range_set(s : ChemrxntypeRange, i : Int, v : Double) -> ChemrxntypeRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_range_sum(s : ChemrxntypeRange) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_type_range_mean(s : ChemrxntypeRange) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_type_range_scale(s : ChemrxntypeRange, f : Double) -> ChemrxntypeRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_range_add(a : ChemrxntypeRange, b : ChemrxntypeRange) -> ChemrxntypeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_type_range_copy(s : ChemrxntypeRange) -> ChemrxntypeRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_range_fill(s : ChemrxntypeRange, v : Double) -> ChemrxntypeRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_range_min(s : ChemrxntypeRange) -> Double { @_common.min(s.data) }

pub fn chem_rxn_type_range_max(s : ChemrxntypeRange) -> Double { @_common.max(s.data) }

pub fn chem_rxn_type_range_to_string(s : ChemrxntypeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxntypeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_type_slice_make(size : Int) -> ChemrxntypeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_type_slice_len(s : ChemrxntypeSlice) -> Int { s.size }

pub fn chem_rxn_type_slice_get(s : ChemrxntypeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_type_slice_set(s : ChemrxntypeSlice, i : Int, v : Double) -> ChemrxntypeSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_slice_sum(s : ChemrxntypeSlice) -> Double { @_common.sum(s.data) }

pub fn chem_rxn_type_slice_mean(s : ChemrxntypeSlice) -> Double { @_common.mean(s.data) }

pub fn chem_rxn_type_slice_scale(s : ChemrxntypeSlice, f : Double) -> ChemrxntypeSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_slice_add(a : ChemrxntypeSlice, b : ChemrxntypeSlice) -> ChemrxntypeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_rxn_type_slice_copy(s : ChemrxntypeSlice) -> ChemrxntypeSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_slice_fill(s : ChemrxntypeSlice, v : Double) -> ChemrxntypeSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_rxn_type_slice_min(s : ChemrxntypeSlice) -> Double { @_common.min(s.data) }

pub fn chem_rxn_type_slice_max(s : ChemrxntypeSlice) -> Double { @_common.max(s.data) }

pub fn chem_rxn_type_slice_to_string(s : ChemrxntypeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

