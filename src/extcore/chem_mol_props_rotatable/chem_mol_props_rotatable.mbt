///===
/// extcore/chem_mol_props_rotatable

pub(all) struct ChemmolpropsrotatablePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_mol_props_rotatable_make_point(x : Double, y : Double) -> ChemmolpropsrotatablePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_mol_props_rotatable_make_point3(x : Double, y : Double, z : Double) -> ChemmolpropsrotatablePoint {
  { x, y, z, label: 0 }
}

pub fn ChemmolpropsrotatablePoint::x(self : ChemmolpropsrotatablePoint) -> Double { self.x }

pub fn ChemmolpropsrotatablePoint::y(self : ChemmolpropsrotatablePoint) -> Double { self.y }

pub fn ChemmolpropsrotatablePoint::z(self : ChemmolpropsrotatablePoint) -> Double { self.z }

pub fn ChemmolpropsrotatablePoint::label(self : ChemmolpropsrotatablePoint) -> Int { self.label }

pub fn ChemmolpropsrotatablePoint::dist(self : ChemmolpropsrotatablePoint, other : ChemmolpropsrotatablePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemmolpropsrotatablePoint::add(self : ChemmolpropsrotatablePoint, other : ChemmolpropsrotatablePoint) -> ChemmolpropsrotatablePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemmolpropsrotatablePoint::sub(self : ChemmolpropsrotatablePoint, other : ChemmolpropsrotatablePoint) -> ChemmolpropsrotatablePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemmolpropsrotatablePoint::scale(self : ChemmolpropsrotatablePoint, s : Double) -> ChemmolpropsrotatablePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemmolpropsrotatablePoint::dot(self : ChemmolpropsrotatablePoint, other : ChemmolpropsrotatablePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemmolpropsrotatablePoint::cross(self : ChemmolpropsrotatablePoint, other : ChemmolpropsrotatablePoint) -> ChemmolpropsrotatablePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemmolpropsrotatablePoint::norm(self : ChemmolpropsrotatablePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemmolpropsrotatablePoint::normalize(self : ChemmolpropsrotatablePoint) -> ChemmolpropsrotatablePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolpropsrotatablePoint::negate(self : ChemmolpropsrotatablePoint) -> ChemmolpropsrotatablePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemmolpropsrotatablePoint::mid(self : ChemmolpropsrotatablePoint, other : ChemmolpropsrotatablePoint) -> ChemmolpropsrotatablePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemmolpropsrotatablePoint::lerp(self : ChemmolpropsrotatablePoint, other : ChemmolpropsrotatablePoint, t : Double) -> ChemmolpropsrotatablePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemmolpropsrotatablePoint::to_string(self : ChemmolpropsrotatablePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemmolpropsrotatableSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_mol_props_rotatable_make_series(vals : Array[Double], name : String) -> ChemmolpropsrotatableSeries {
  { vals, name, meta: 0 }
}

pub fn ChemmolpropsrotatableSeries::len(self : ChemmolpropsrotatableSeries) -> Int { self.vals.length() }

pub fn ChemmolpropsrotatableSeries::sum(self : ChemmolpropsrotatableSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemmolpropsrotatableSeries::mean(self : ChemmolpropsrotatableSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemmolpropsrotatableSeries::min(self : ChemmolpropsrotatableSeries) -> Double { @_common.min(self.vals) }

pub fn ChemmolpropsrotatableSeries::max(self : ChemmolpropsrotatableSeries) -> Double { @_common.max(self.vals) }

pub fn ChemmolpropsrotatableSeries::range(self : ChemmolpropsrotatableSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemmolpropsrotatableSeries::variance(self : ChemmolpropsrotatableSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemmolpropsrotatableSeries::std(self : ChemmolpropsrotatableSeries) -> Double { @_common.std(self.vals) }

pub fn ChemmolpropsrotatableSeries::median(self : ChemmolpropsrotatableSeries) -> Double { @_common.median(self.vals) }

pub fn ChemmolpropsrotatableSeries::scale(self : ChemmolpropsrotatableSeries, f : Double) -> ChemmolpropsrotatableSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemmolpropsrotatableSeries::add(self : ChemmolpropsrotatableSeries, other : ChemmolpropsrotatableSeries) -> ChemmolpropsrotatableSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemmolpropsrotatableSeries::sub(self : ChemmolpropsrotatableSeries, other : ChemmolpropsrotatableSeries) -> ChemmolpropsrotatableSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemmolpropsrotatableSeries::normalize(self : ChemmolpropsrotatableSeries) -> ChemmolpropsrotatableSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemmolpropsrotatableSeries::cumsum(self : ChemmolpropsrotatableSeries) -> ChemmolpropsrotatableSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemmolpropsrotatableSeries::to_string(self : ChemmolpropsrotatableSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolpropsrotatableMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_mol_props_rotatable_make_matrix(rows : Int, cols : Int, val : Double) -> ChemmolpropsrotatableMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_mol_props_rotatable_matrix_identity(n : Int) -> ChemmolpropsrotatableMatrix {
  let m = chem_mol_props_rotatable_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemmolpropsrotatableMatrix::get(self : ChemmolpropsrotatableMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemmolpropsrotatableMatrix::transpose(self : ChemmolpropsrotatableMatrix) -> ChemmolpropsrotatableMatrix {
  let result = chem_mol_props_rotatable_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemmolpropsrotatableMatrix::add(self : ChemmolpropsrotatableMatrix, other : ChemmolpropsrotatableMatrix) -> ChemmolpropsrotatableMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_mol_props_rotatable_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemmolpropsrotatableMatrix::scale(self : ChemmolpropsrotatableMatrix, s : Double) -> ChemmolpropsrotatableMatrix {
  let result = chem_mol_props_rotatable_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemmolpropsrotatableMatrix::multiply(self : ChemmolpropsrotatableMatrix, other : ChemmolpropsrotatableMatrix) -> ChemmolpropsrotatableMatrix {
  if self.cols != other.rows { return chem_mol_props_rotatable_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_mol_props_rotatable_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ChemmolpropsrotatableMatrix::trace(self : ChemmolpropsrotatableMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemmolpropsrotatableMatrix::det(self : ChemmolpropsrotatableMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemmolpropsrotatableMatrix::norm(self : ChemmolpropsrotatableMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemmolpropsrotatableMatrix::to_string(self : ChemmolpropsrotatableMatrix) -> String {
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

pub(all) struct ChemmolpropsrotatableVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_mol_props_rotatable_make_vector(comps : Array[Double]) -> ChemmolpropsrotatableVector {
  { comps, dim: comps.length() }
}

pub fn chem_mol_props_rotatable_vector_zero(dim : Int) -> ChemmolpropsrotatableVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemmolpropsrotatableVector::add(self : ChemmolpropsrotatableVector, other : ChemmolpropsrotatableVector) -> ChemmolpropsrotatableVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolpropsrotatableVector::sub(self : ChemmolpropsrotatableVector, other : ChemmolpropsrotatableVector) -> ChemmolpropsrotatableVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolpropsrotatableVector::scale(self : ChemmolpropsrotatableVector, s : Double) -> ChemmolpropsrotatableVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemmolpropsrotatableVector::dot(self : ChemmolpropsrotatableVector, other : ChemmolpropsrotatableVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemmolpropsrotatableVector::norm(self : ChemmolpropsrotatableVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemmolpropsrotatableVector::normalize(self : ChemmolpropsrotatableVector) -> ChemmolpropsrotatableVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolpropsrotatableVector::dist(self : ChemmolpropsrotatableVector, other : ChemmolpropsrotatableVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemmolpropsrotatableVector::to_string(self : ChemmolpropsrotatableVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_mol_props_rotatable_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_mol_props_rotatable_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_mol_props_rotatable_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_mol_props_rotatable_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_mol_props_rotatable_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_mol_props_rotatable_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_mol_props_rotatable_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_mol_props_rotatable_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_mol_props_rotatable_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_mol_props_rotatable_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_mol_props_rotatable_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_mol_props_rotatable_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_mol_props_rotatable_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_mol_props_rotatable_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_mol_props_rotatable_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_mol_props_rotatable_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_mol_props_rotatable_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_mol_props_rotatable_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_mol_props_rotatable_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_mol_props_rotatable_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_mol_props_rotatable_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_mol_props_rotatable_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_mol_props_rotatable_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_mol_props_rotatable_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_mol_props_rotatable_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_mol_props_rotatable_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_mol_props_rotatable_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_mol_props_rotatable_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_mol_props_rotatable_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemmolpropsrotatableFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rotatable_frame_make(size : Int) -> ChemmolpropsrotatableFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rotatable_frame_len(s : ChemmolpropsrotatableFrame) -> Int { s.size }

pub fn chem_mol_props_rotatable_frame_get(s : ChemmolpropsrotatableFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rotatable_frame_set(s : ChemmolpropsrotatableFrame, i : Int, v : Double) -> ChemmolpropsrotatableFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_frame_sum(s : ChemmolpropsrotatableFrame) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_rotatable_frame_mean(s : ChemmolpropsrotatableFrame) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_rotatable_frame_scale(s : ChemmolpropsrotatableFrame, f : Double) -> ChemmolpropsrotatableFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_frame_add(a : ChemmolpropsrotatableFrame, b : ChemmolpropsrotatableFrame) -> ChemmolpropsrotatableFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_rotatable_frame_copy(s : ChemmolpropsrotatableFrame) -> ChemmolpropsrotatableFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_frame_fill(s : ChemmolpropsrotatableFrame, v : Double) -> ChemmolpropsrotatableFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_frame_min(s : ChemmolpropsrotatableFrame) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_rotatable_frame_max(s : ChemmolpropsrotatableFrame) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_rotatable_frame_to_string(s : ChemmolpropsrotatableFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsrotatableTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rotatable_table_make(size : Int) -> ChemmolpropsrotatableTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rotatable_table_len(s : ChemmolpropsrotatableTable) -> Int { s.size }

pub fn chem_mol_props_rotatable_table_get(s : ChemmolpropsrotatableTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rotatable_table_set(s : ChemmolpropsrotatableTable, i : Int, v : Double) -> ChemmolpropsrotatableTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_table_sum(s : ChemmolpropsrotatableTable) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_rotatable_table_mean(s : ChemmolpropsrotatableTable) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_rotatable_table_scale(s : ChemmolpropsrotatableTable, f : Double) -> ChemmolpropsrotatableTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_table_add(a : ChemmolpropsrotatableTable, b : ChemmolpropsrotatableTable) -> ChemmolpropsrotatableTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_rotatable_table_copy(s : ChemmolpropsrotatableTable) -> ChemmolpropsrotatableTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_table_fill(s : ChemmolpropsrotatableTable, v : Double) -> ChemmolpropsrotatableTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_table_min(s : ChemmolpropsrotatableTable) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_rotatable_table_max(s : ChemmolpropsrotatableTable) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_rotatable_table_to_string(s : ChemmolpropsrotatableTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsrotatableGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rotatable_graphn_make(size : Int) -> ChemmolpropsrotatableGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rotatable_graphn_len(s : ChemmolpropsrotatableGraphN) -> Int { s.size }

pub fn chem_mol_props_rotatable_graphn_get(s : ChemmolpropsrotatableGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rotatable_graphn_set(s : ChemmolpropsrotatableGraphN, i : Int, v : Double) -> ChemmolpropsrotatableGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_graphn_sum(s : ChemmolpropsrotatableGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_rotatable_graphn_mean(s : ChemmolpropsrotatableGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_rotatable_graphn_scale(s : ChemmolpropsrotatableGraphN, f : Double) -> ChemmolpropsrotatableGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_graphn_add(a : ChemmolpropsrotatableGraphN, b : ChemmolpropsrotatableGraphN) -> ChemmolpropsrotatableGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_rotatable_graphn_copy(s : ChemmolpropsrotatableGraphN) -> ChemmolpropsrotatableGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_graphn_fill(s : ChemmolpropsrotatableGraphN, v : Double) -> ChemmolpropsrotatableGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_graphn_min(s : ChemmolpropsrotatableGraphN) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_rotatable_graphn_max(s : ChemmolpropsrotatableGraphN) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_rotatable_graphn_to_string(s : ChemmolpropsrotatableGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsrotatableNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rotatable_node_make(size : Int) -> ChemmolpropsrotatableNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rotatable_node_len(s : ChemmolpropsrotatableNode) -> Int { s.size }

pub fn chem_mol_props_rotatable_node_get(s : ChemmolpropsrotatableNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rotatable_node_set(s : ChemmolpropsrotatableNode, i : Int, v : Double) -> ChemmolpropsrotatableNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_node_sum(s : ChemmolpropsrotatableNode) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_rotatable_node_mean(s : ChemmolpropsrotatableNode) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_rotatable_node_scale(s : ChemmolpropsrotatableNode, f : Double) -> ChemmolpropsrotatableNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_node_add(a : ChemmolpropsrotatableNode, b : ChemmolpropsrotatableNode) -> ChemmolpropsrotatableNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_rotatable_node_copy(s : ChemmolpropsrotatableNode) -> ChemmolpropsrotatableNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_node_fill(s : ChemmolpropsrotatableNode, v : Double) -> ChemmolpropsrotatableNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_node_min(s : ChemmolpropsrotatableNode) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_rotatable_node_max(s : ChemmolpropsrotatableNode) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_rotatable_node_to_string(s : ChemmolpropsrotatableNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsrotatableEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rotatable_edge_make(size : Int) -> ChemmolpropsrotatableEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rotatable_edge_len(s : ChemmolpropsrotatableEdge) -> Int { s.size }

pub fn chem_mol_props_rotatable_edge_get(s : ChemmolpropsrotatableEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rotatable_edge_set(s : ChemmolpropsrotatableEdge, i : Int, v : Double) -> ChemmolpropsrotatableEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_edge_sum(s : ChemmolpropsrotatableEdge) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_rotatable_edge_mean(s : ChemmolpropsrotatableEdge) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_rotatable_edge_scale(s : ChemmolpropsrotatableEdge, f : Double) -> ChemmolpropsrotatableEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_edge_add(a : ChemmolpropsrotatableEdge, b : ChemmolpropsrotatableEdge) -> ChemmolpropsrotatableEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_rotatable_edge_copy(s : ChemmolpropsrotatableEdge) -> ChemmolpropsrotatableEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_edge_fill(s : ChemmolpropsrotatableEdge, v : Double) -> ChemmolpropsrotatableEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_edge_min(s : ChemmolpropsrotatableEdge) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_rotatable_edge_max(s : ChemmolpropsrotatableEdge) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_rotatable_edge_to_string(s : ChemmolpropsrotatableEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsrotatablePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rotatable_path_make(size : Int) -> ChemmolpropsrotatablePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rotatable_path_len(s : ChemmolpropsrotatablePath) -> Int { s.size }

pub fn chem_mol_props_rotatable_path_get(s : ChemmolpropsrotatablePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rotatable_path_set(s : ChemmolpropsrotatablePath, i : Int, v : Double) -> ChemmolpropsrotatablePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_path_sum(s : ChemmolpropsrotatablePath) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_rotatable_path_mean(s : ChemmolpropsrotatablePath) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_rotatable_path_scale(s : ChemmolpropsrotatablePath, f : Double) -> ChemmolpropsrotatablePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_path_add(a : ChemmolpropsrotatablePath, b : ChemmolpropsrotatablePath) -> ChemmolpropsrotatablePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_rotatable_path_copy(s : ChemmolpropsrotatablePath) -> ChemmolpropsrotatablePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_path_fill(s : ChemmolpropsrotatablePath, v : Double) -> ChemmolpropsrotatablePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_path_min(s : ChemmolpropsrotatablePath) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_rotatable_path_max(s : ChemmolpropsrotatablePath) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_rotatable_path_to_string(s : ChemmolpropsrotatablePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsrotatableCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rotatable_cluster_make(size : Int) -> ChemmolpropsrotatableCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rotatable_cluster_len(s : ChemmolpropsrotatableCluster) -> Int { s.size }

pub fn chem_mol_props_rotatable_cluster_get(s : ChemmolpropsrotatableCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rotatable_cluster_set(s : ChemmolpropsrotatableCluster, i : Int, v : Double) -> ChemmolpropsrotatableCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_cluster_sum(s : ChemmolpropsrotatableCluster) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_rotatable_cluster_mean(s : ChemmolpropsrotatableCluster) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_rotatable_cluster_scale(s : ChemmolpropsrotatableCluster, f : Double) -> ChemmolpropsrotatableCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_cluster_add(a : ChemmolpropsrotatableCluster, b : ChemmolpropsrotatableCluster) -> ChemmolpropsrotatableCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_rotatable_cluster_copy(s : ChemmolpropsrotatableCluster) -> ChemmolpropsrotatableCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_cluster_fill(s : ChemmolpropsrotatableCluster, v : Double) -> ChemmolpropsrotatableCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_cluster_min(s : ChemmolpropsrotatableCluster) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_rotatable_cluster_max(s : ChemmolpropsrotatableCluster) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_rotatable_cluster_to_string(s : ChemmolpropsrotatableCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsrotatableModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rotatable_model_make(size : Int) -> ChemmolpropsrotatableModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rotatable_model_len(s : ChemmolpropsrotatableModel) -> Int { s.size }

pub fn chem_mol_props_rotatable_model_get(s : ChemmolpropsrotatableModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rotatable_model_set(s : ChemmolpropsrotatableModel, i : Int, v : Double) -> ChemmolpropsrotatableModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_model_sum(s : ChemmolpropsrotatableModel) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_rotatable_model_mean(s : ChemmolpropsrotatableModel) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_rotatable_model_scale(s : ChemmolpropsrotatableModel, f : Double) -> ChemmolpropsrotatableModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_model_add(a : ChemmolpropsrotatableModel, b : ChemmolpropsrotatableModel) -> ChemmolpropsrotatableModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_rotatable_model_copy(s : ChemmolpropsrotatableModel) -> ChemmolpropsrotatableModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_model_fill(s : ChemmolpropsrotatableModel, v : Double) -> ChemmolpropsrotatableModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_model_min(s : ChemmolpropsrotatableModel) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_rotatable_model_max(s : ChemmolpropsrotatableModel) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_rotatable_model_to_string(s : ChemmolpropsrotatableModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsrotatableLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rotatable_layer_make(size : Int) -> ChemmolpropsrotatableLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rotatable_layer_len(s : ChemmolpropsrotatableLayer) -> Int { s.size }

pub fn chem_mol_props_rotatable_layer_get(s : ChemmolpropsrotatableLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rotatable_layer_set(s : ChemmolpropsrotatableLayer, i : Int, v : Double) -> ChemmolpropsrotatableLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_layer_sum(s : ChemmolpropsrotatableLayer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_rotatable_layer_mean(s : ChemmolpropsrotatableLayer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_rotatable_layer_scale(s : ChemmolpropsrotatableLayer, f : Double) -> ChemmolpropsrotatableLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_layer_add(a : ChemmolpropsrotatableLayer, b : ChemmolpropsrotatableLayer) -> ChemmolpropsrotatableLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_rotatable_layer_copy(s : ChemmolpropsrotatableLayer) -> ChemmolpropsrotatableLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_layer_fill(s : ChemmolpropsrotatableLayer, v : Double) -> ChemmolpropsrotatableLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_layer_min(s : ChemmolpropsrotatableLayer) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_rotatable_layer_max(s : ChemmolpropsrotatableLayer) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_rotatable_layer_to_string(s : ChemmolpropsrotatableLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsrotatableBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rotatable_buffer_make(size : Int) -> ChemmolpropsrotatableBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rotatable_buffer_len(s : ChemmolpropsrotatableBuffer) -> Int { s.size }

pub fn chem_mol_props_rotatable_buffer_get(s : ChemmolpropsrotatableBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rotatable_buffer_set(s : ChemmolpropsrotatableBuffer, i : Int, v : Double) -> ChemmolpropsrotatableBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_buffer_sum(s : ChemmolpropsrotatableBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_rotatable_buffer_mean(s : ChemmolpropsrotatableBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_rotatable_buffer_scale(s : ChemmolpropsrotatableBuffer, f : Double) -> ChemmolpropsrotatableBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_buffer_add(a : ChemmolpropsrotatableBuffer, b : ChemmolpropsrotatableBuffer) -> ChemmolpropsrotatableBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_rotatable_buffer_copy(s : ChemmolpropsrotatableBuffer) -> ChemmolpropsrotatableBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_buffer_fill(s : ChemmolpropsrotatableBuffer, v : Double) -> ChemmolpropsrotatableBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_buffer_min(s : ChemmolpropsrotatableBuffer) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_rotatable_buffer_max(s : ChemmolpropsrotatableBuffer) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_rotatable_buffer_to_string(s : ChemmolpropsrotatableBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsrotatableCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rotatable_cursor_make(size : Int) -> ChemmolpropsrotatableCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rotatable_cursor_len(s : ChemmolpropsrotatableCursor) -> Int { s.size }

pub fn chem_mol_props_rotatable_cursor_get(s : ChemmolpropsrotatableCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rotatable_cursor_set(s : ChemmolpropsrotatableCursor, i : Int, v : Double) -> ChemmolpropsrotatableCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_cursor_sum(s : ChemmolpropsrotatableCursor) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_rotatable_cursor_mean(s : ChemmolpropsrotatableCursor) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_rotatable_cursor_scale(s : ChemmolpropsrotatableCursor, f : Double) -> ChemmolpropsrotatableCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_cursor_add(a : ChemmolpropsrotatableCursor, b : ChemmolpropsrotatableCursor) -> ChemmolpropsrotatableCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_rotatable_cursor_copy(s : ChemmolpropsrotatableCursor) -> ChemmolpropsrotatableCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_cursor_fill(s : ChemmolpropsrotatableCursor, v : Double) -> ChemmolpropsrotatableCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_cursor_min(s : ChemmolpropsrotatableCursor) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_rotatable_cursor_max(s : ChemmolpropsrotatableCursor) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_rotatable_cursor_to_string(s : ChemmolpropsrotatableCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsrotatableView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rotatable_view_make(size : Int) -> ChemmolpropsrotatableView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rotatable_view_len(s : ChemmolpropsrotatableView) -> Int { s.size }

pub fn chem_mol_props_rotatable_view_get(s : ChemmolpropsrotatableView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rotatable_view_set(s : ChemmolpropsrotatableView, i : Int, v : Double) -> ChemmolpropsrotatableView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_view_sum(s : ChemmolpropsrotatableView) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_rotatable_view_mean(s : ChemmolpropsrotatableView) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_rotatable_view_scale(s : ChemmolpropsrotatableView, f : Double) -> ChemmolpropsrotatableView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_view_add(a : ChemmolpropsrotatableView, b : ChemmolpropsrotatableView) -> ChemmolpropsrotatableView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_rotatable_view_copy(s : ChemmolpropsrotatableView) -> ChemmolpropsrotatableView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_view_fill(s : ChemmolpropsrotatableView, v : Double) -> ChemmolpropsrotatableView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_view_min(s : ChemmolpropsrotatableView) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_rotatable_view_max(s : ChemmolpropsrotatableView) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_rotatable_view_to_string(s : ChemmolpropsrotatableView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsrotatableRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rotatable_range_make(size : Int) -> ChemmolpropsrotatableRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rotatable_range_len(s : ChemmolpropsrotatableRange) -> Int { s.size }

pub fn chem_mol_props_rotatable_range_get(s : ChemmolpropsrotatableRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rotatable_range_set(s : ChemmolpropsrotatableRange, i : Int, v : Double) -> ChemmolpropsrotatableRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_range_sum(s : ChemmolpropsrotatableRange) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_rotatable_range_mean(s : ChemmolpropsrotatableRange) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_rotatable_range_scale(s : ChemmolpropsrotatableRange, f : Double) -> ChemmolpropsrotatableRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_range_add(a : ChemmolpropsrotatableRange, b : ChemmolpropsrotatableRange) -> ChemmolpropsrotatableRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_rotatable_range_copy(s : ChemmolpropsrotatableRange) -> ChemmolpropsrotatableRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_range_fill(s : ChemmolpropsrotatableRange, v : Double) -> ChemmolpropsrotatableRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_range_min(s : ChemmolpropsrotatableRange) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_rotatable_range_max(s : ChemmolpropsrotatableRange) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_rotatable_range_to_string(s : ChemmolpropsrotatableRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsrotatableSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rotatable_slice_make(size : Int) -> ChemmolpropsrotatableSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rotatable_slice_len(s : ChemmolpropsrotatableSlice) -> Int { s.size }

pub fn chem_mol_props_rotatable_slice_get(s : ChemmolpropsrotatableSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rotatable_slice_set(s : ChemmolpropsrotatableSlice, i : Int, v : Double) -> ChemmolpropsrotatableSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_slice_sum(s : ChemmolpropsrotatableSlice) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_rotatable_slice_mean(s : ChemmolpropsrotatableSlice) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_rotatable_slice_scale(s : ChemmolpropsrotatableSlice, f : Double) -> ChemmolpropsrotatableSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_slice_add(a : ChemmolpropsrotatableSlice, b : ChemmolpropsrotatableSlice) -> ChemmolpropsrotatableSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_rotatable_slice_copy(s : ChemmolpropsrotatableSlice) -> ChemmolpropsrotatableSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_slice_fill(s : ChemmolpropsrotatableSlice, v : Double) -> ChemmolpropsrotatableSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rotatable_slice_min(s : ChemmolpropsrotatableSlice) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_rotatable_slice_max(s : ChemmolpropsrotatableSlice) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_rotatable_slice_to_string(s : ChemmolpropsrotatableSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

