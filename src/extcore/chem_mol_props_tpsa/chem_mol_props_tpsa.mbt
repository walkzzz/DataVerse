///===
/// extcore/chem_mol_props_tpsa

pub(all) struct ChemmolpropstpsaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_mol_props_tpsa_make_point(x : Double, y : Double) -> ChemmolpropstpsaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_mol_props_tpsa_make_point3(x : Double, y : Double, z : Double) -> ChemmolpropstpsaPoint {
  { x, y, z, label: 0 }
}

pub fn ChemmolpropstpsaPoint::x(self : ChemmolpropstpsaPoint) -> Double { self.x }

pub fn ChemmolpropstpsaPoint::y(self : ChemmolpropstpsaPoint) -> Double { self.y }

pub fn ChemmolpropstpsaPoint::z(self : ChemmolpropstpsaPoint) -> Double { self.z }

pub fn ChemmolpropstpsaPoint::label(self : ChemmolpropstpsaPoint) -> Int { self.label }

pub fn ChemmolpropstpsaPoint::dist(self : ChemmolpropstpsaPoint, other : ChemmolpropstpsaPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemmolpropstpsaPoint::add(self : ChemmolpropstpsaPoint, other : ChemmolpropstpsaPoint) -> ChemmolpropstpsaPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemmolpropstpsaPoint::sub(self : ChemmolpropstpsaPoint, other : ChemmolpropstpsaPoint) -> ChemmolpropstpsaPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemmolpropstpsaPoint::scale(self : ChemmolpropstpsaPoint, s : Double) -> ChemmolpropstpsaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemmolpropstpsaPoint::dot(self : ChemmolpropstpsaPoint, other : ChemmolpropstpsaPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemmolpropstpsaPoint::cross(self : ChemmolpropstpsaPoint, other : ChemmolpropstpsaPoint) -> ChemmolpropstpsaPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemmolpropstpsaPoint::norm(self : ChemmolpropstpsaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemmolpropstpsaPoint::normalize(self : ChemmolpropstpsaPoint) -> ChemmolpropstpsaPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolpropstpsaPoint::negate(self : ChemmolpropstpsaPoint) -> ChemmolpropstpsaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemmolpropstpsaPoint::mid(self : ChemmolpropstpsaPoint, other : ChemmolpropstpsaPoint) -> ChemmolpropstpsaPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemmolpropstpsaPoint::lerp(self : ChemmolpropstpsaPoint, other : ChemmolpropstpsaPoint, t : Double) -> ChemmolpropstpsaPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemmolpropstpsaPoint::to_string(self : ChemmolpropstpsaPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_mol_props_tpsa_make_series(vals : Array[Double], name : String) -> ChemmolpropstpsaSeries {
  { vals, name, meta: 0 }
}

pub fn ChemmolpropstpsaSeries::len(self : ChemmolpropstpsaSeries) -> Int { self.vals.length() }

pub fn ChemmolpropstpsaSeries::sum(self : ChemmolpropstpsaSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemmolpropstpsaSeries::mean(self : ChemmolpropstpsaSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemmolpropstpsaSeries::min(self : ChemmolpropstpsaSeries) -> Double { @_common.min(self.vals) }

pub fn ChemmolpropstpsaSeries::max(self : ChemmolpropstpsaSeries) -> Double { @_common.max(self.vals) }

pub fn ChemmolpropstpsaSeries::range(self : ChemmolpropstpsaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemmolpropstpsaSeries::variance(self : ChemmolpropstpsaSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemmolpropstpsaSeries::std(self : ChemmolpropstpsaSeries) -> Double { @_common.std(self.vals) }

pub fn ChemmolpropstpsaSeries::median(self : ChemmolpropstpsaSeries) -> Double { @_common.median(self.vals) }

pub fn ChemmolpropstpsaSeries::scale(self : ChemmolpropstpsaSeries, f : Double) -> ChemmolpropstpsaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemmolpropstpsaSeries::add(self : ChemmolpropstpsaSeries, other : ChemmolpropstpsaSeries) -> ChemmolpropstpsaSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemmolpropstpsaSeries::sub(self : ChemmolpropstpsaSeries, other : ChemmolpropstpsaSeries) -> ChemmolpropstpsaSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemmolpropstpsaSeries::normalize(self : ChemmolpropstpsaSeries) -> ChemmolpropstpsaSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemmolpropstpsaSeries::cumsum(self : ChemmolpropstpsaSeries) -> ChemmolpropstpsaSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemmolpropstpsaSeries::to_string(self : ChemmolpropstpsaSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolpropstpsaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_mol_props_tpsa_make_matrix(rows : Int, cols : Int, val : Double) -> ChemmolpropstpsaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_mol_props_tpsa_matrix_identity(n : Int) -> ChemmolpropstpsaMatrix {
  let m = chem_mol_props_tpsa_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemmolpropstpsaMatrix::get(self : ChemmolpropstpsaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemmolpropstpsaMatrix::transpose(self : ChemmolpropstpsaMatrix) -> ChemmolpropstpsaMatrix {
  let result = chem_mol_props_tpsa_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemmolpropstpsaMatrix::add(self : ChemmolpropstpsaMatrix, other : ChemmolpropstpsaMatrix) -> ChemmolpropstpsaMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_mol_props_tpsa_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemmolpropstpsaMatrix::scale(self : ChemmolpropstpsaMatrix, s : Double) -> ChemmolpropstpsaMatrix {
  let result = chem_mol_props_tpsa_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemmolpropstpsaMatrix::multiply(self : ChemmolpropstpsaMatrix, other : ChemmolpropstpsaMatrix) -> ChemmolpropstpsaMatrix {
  if self.cols != other.rows { return chem_mol_props_tpsa_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_mol_props_tpsa_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ChemmolpropstpsaMatrix::trace(self : ChemmolpropstpsaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemmolpropstpsaMatrix::det(self : ChemmolpropstpsaMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemmolpropstpsaMatrix::norm(self : ChemmolpropstpsaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemmolpropstpsaMatrix::to_string(self : ChemmolpropstpsaMatrix) -> String {
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

pub(all) struct ChemmolpropstpsaVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_mol_props_tpsa_make_vector(comps : Array[Double]) -> ChemmolpropstpsaVector {
  { comps, dim: comps.length() }
}

pub fn chem_mol_props_tpsa_vector_zero(dim : Int) -> ChemmolpropstpsaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemmolpropstpsaVector::add(self : ChemmolpropstpsaVector, other : ChemmolpropstpsaVector) -> ChemmolpropstpsaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolpropstpsaVector::sub(self : ChemmolpropstpsaVector, other : ChemmolpropstpsaVector) -> ChemmolpropstpsaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolpropstpsaVector::scale(self : ChemmolpropstpsaVector, s : Double) -> ChemmolpropstpsaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemmolpropstpsaVector::dot(self : ChemmolpropstpsaVector, other : ChemmolpropstpsaVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemmolpropstpsaVector::norm(self : ChemmolpropstpsaVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemmolpropstpsaVector::normalize(self : ChemmolpropstpsaVector) -> ChemmolpropstpsaVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolpropstpsaVector::dist(self : ChemmolpropstpsaVector, other : ChemmolpropstpsaVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemmolpropstpsaVector::to_string(self : ChemmolpropstpsaVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_mol_props_tpsa_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_mol_props_tpsa_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_mol_props_tpsa_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_mol_props_tpsa_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_mol_props_tpsa_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_mol_props_tpsa_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_mol_props_tpsa_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_mol_props_tpsa_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_mol_props_tpsa_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_mol_props_tpsa_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_mol_props_tpsa_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_mol_props_tpsa_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_mol_props_tpsa_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_mol_props_tpsa_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_mol_props_tpsa_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_mol_props_tpsa_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_mol_props_tpsa_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_mol_props_tpsa_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_mol_props_tpsa_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_mol_props_tpsa_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_mol_props_tpsa_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_mol_props_tpsa_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_mol_props_tpsa_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_mol_props_tpsa_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_mol_props_tpsa_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_mol_props_tpsa_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_mol_props_tpsa_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_mol_props_tpsa_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_mol_props_tpsa_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemmolpropstpsaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_frame_make(size : Int) -> ChemmolpropstpsaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_tpsa_frame_len(s : ChemmolpropstpsaFrame) -> Int { s.size }

pub fn chem_mol_props_tpsa_frame_get(s : ChemmolpropstpsaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_tpsa_frame_set(s : ChemmolpropstpsaFrame, i : Int, v : Double) -> ChemmolpropstpsaFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_frame_sum(s : ChemmolpropstpsaFrame) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_tpsa_frame_mean(s : ChemmolpropstpsaFrame) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_tpsa_frame_scale(s : ChemmolpropstpsaFrame, f : Double) -> ChemmolpropstpsaFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_frame_add(a : ChemmolpropstpsaFrame, b : ChemmolpropstpsaFrame) -> ChemmolpropstpsaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_tpsa_frame_copy(s : ChemmolpropstpsaFrame) -> ChemmolpropstpsaFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_frame_fill(s : ChemmolpropstpsaFrame, v : Double) -> ChemmolpropstpsaFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_frame_min(s : ChemmolpropstpsaFrame) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_tpsa_frame_max(s : ChemmolpropstpsaFrame) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_tpsa_frame_to_string(s : ChemmolpropstpsaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_table_make(size : Int) -> ChemmolpropstpsaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_tpsa_table_len(s : ChemmolpropstpsaTable) -> Int { s.size }

pub fn chem_mol_props_tpsa_table_get(s : ChemmolpropstpsaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_tpsa_table_set(s : ChemmolpropstpsaTable, i : Int, v : Double) -> ChemmolpropstpsaTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_table_sum(s : ChemmolpropstpsaTable) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_tpsa_table_mean(s : ChemmolpropstpsaTable) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_tpsa_table_scale(s : ChemmolpropstpsaTable, f : Double) -> ChemmolpropstpsaTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_table_add(a : ChemmolpropstpsaTable, b : ChemmolpropstpsaTable) -> ChemmolpropstpsaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_tpsa_table_copy(s : ChemmolpropstpsaTable) -> ChemmolpropstpsaTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_table_fill(s : ChemmolpropstpsaTable, v : Double) -> ChemmolpropstpsaTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_table_min(s : ChemmolpropstpsaTable) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_tpsa_table_max(s : ChemmolpropstpsaTable) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_tpsa_table_to_string(s : ChemmolpropstpsaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_graphn_make(size : Int) -> ChemmolpropstpsaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_tpsa_graphn_len(s : ChemmolpropstpsaGraphN) -> Int { s.size }

pub fn chem_mol_props_tpsa_graphn_get(s : ChemmolpropstpsaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_tpsa_graphn_set(s : ChemmolpropstpsaGraphN, i : Int, v : Double) -> ChemmolpropstpsaGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_graphn_sum(s : ChemmolpropstpsaGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_tpsa_graphn_mean(s : ChemmolpropstpsaGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_tpsa_graphn_scale(s : ChemmolpropstpsaGraphN, f : Double) -> ChemmolpropstpsaGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_graphn_add(a : ChemmolpropstpsaGraphN, b : ChemmolpropstpsaGraphN) -> ChemmolpropstpsaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_tpsa_graphn_copy(s : ChemmolpropstpsaGraphN) -> ChemmolpropstpsaGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_graphn_fill(s : ChemmolpropstpsaGraphN, v : Double) -> ChemmolpropstpsaGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_graphn_min(s : ChemmolpropstpsaGraphN) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_tpsa_graphn_max(s : ChemmolpropstpsaGraphN) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_tpsa_graphn_to_string(s : ChemmolpropstpsaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_node_make(size : Int) -> ChemmolpropstpsaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_tpsa_node_len(s : ChemmolpropstpsaNode) -> Int { s.size }

pub fn chem_mol_props_tpsa_node_get(s : ChemmolpropstpsaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_tpsa_node_set(s : ChemmolpropstpsaNode, i : Int, v : Double) -> ChemmolpropstpsaNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_node_sum(s : ChemmolpropstpsaNode) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_tpsa_node_mean(s : ChemmolpropstpsaNode) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_tpsa_node_scale(s : ChemmolpropstpsaNode, f : Double) -> ChemmolpropstpsaNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_node_add(a : ChemmolpropstpsaNode, b : ChemmolpropstpsaNode) -> ChemmolpropstpsaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_tpsa_node_copy(s : ChemmolpropstpsaNode) -> ChemmolpropstpsaNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_node_fill(s : ChemmolpropstpsaNode, v : Double) -> ChemmolpropstpsaNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_node_min(s : ChemmolpropstpsaNode) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_tpsa_node_max(s : ChemmolpropstpsaNode) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_tpsa_node_to_string(s : ChemmolpropstpsaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_edge_make(size : Int) -> ChemmolpropstpsaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_tpsa_edge_len(s : ChemmolpropstpsaEdge) -> Int { s.size }

pub fn chem_mol_props_tpsa_edge_get(s : ChemmolpropstpsaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_tpsa_edge_set(s : ChemmolpropstpsaEdge, i : Int, v : Double) -> ChemmolpropstpsaEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_edge_sum(s : ChemmolpropstpsaEdge) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_tpsa_edge_mean(s : ChemmolpropstpsaEdge) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_tpsa_edge_scale(s : ChemmolpropstpsaEdge, f : Double) -> ChemmolpropstpsaEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_edge_add(a : ChemmolpropstpsaEdge, b : ChemmolpropstpsaEdge) -> ChemmolpropstpsaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_tpsa_edge_copy(s : ChemmolpropstpsaEdge) -> ChemmolpropstpsaEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_edge_fill(s : ChemmolpropstpsaEdge, v : Double) -> ChemmolpropstpsaEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_edge_min(s : ChemmolpropstpsaEdge) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_tpsa_edge_max(s : ChemmolpropstpsaEdge) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_tpsa_edge_to_string(s : ChemmolpropstpsaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_path_make(size : Int) -> ChemmolpropstpsaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_tpsa_path_len(s : ChemmolpropstpsaPath) -> Int { s.size }

pub fn chem_mol_props_tpsa_path_get(s : ChemmolpropstpsaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_tpsa_path_set(s : ChemmolpropstpsaPath, i : Int, v : Double) -> ChemmolpropstpsaPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_path_sum(s : ChemmolpropstpsaPath) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_tpsa_path_mean(s : ChemmolpropstpsaPath) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_tpsa_path_scale(s : ChemmolpropstpsaPath, f : Double) -> ChemmolpropstpsaPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_path_add(a : ChemmolpropstpsaPath, b : ChemmolpropstpsaPath) -> ChemmolpropstpsaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_tpsa_path_copy(s : ChemmolpropstpsaPath) -> ChemmolpropstpsaPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_path_fill(s : ChemmolpropstpsaPath, v : Double) -> ChemmolpropstpsaPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_path_min(s : ChemmolpropstpsaPath) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_tpsa_path_max(s : ChemmolpropstpsaPath) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_tpsa_path_to_string(s : ChemmolpropstpsaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_cluster_make(size : Int) -> ChemmolpropstpsaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_tpsa_cluster_len(s : ChemmolpropstpsaCluster) -> Int { s.size }

pub fn chem_mol_props_tpsa_cluster_get(s : ChemmolpropstpsaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_tpsa_cluster_set(s : ChemmolpropstpsaCluster, i : Int, v : Double) -> ChemmolpropstpsaCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_cluster_sum(s : ChemmolpropstpsaCluster) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_tpsa_cluster_mean(s : ChemmolpropstpsaCluster) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_tpsa_cluster_scale(s : ChemmolpropstpsaCluster, f : Double) -> ChemmolpropstpsaCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_cluster_add(a : ChemmolpropstpsaCluster, b : ChemmolpropstpsaCluster) -> ChemmolpropstpsaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_tpsa_cluster_copy(s : ChemmolpropstpsaCluster) -> ChemmolpropstpsaCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_cluster_fill(s : ChemmolpropstpsaCluster, v : Double) -> ChemmolpropstpsaCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_cluster_min(s : ChemmolpropstpsaCluster) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_tpsa_cluster_max(s : ChemmolpropstpsaCluster) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_tpsa_cluster_to_string(s : ChemmolpropstpsaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_model_make(size : Int) -> ChemmolpropstpsaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_tpsa_model_len(s : ChemmolpropstpsaModel) -> Int { s.size }

pub fn chem_mol_props_tpsa_model_get(s : ChemmolpropstpsaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_tpsa_model_set(s : ChemmolpropstpsaModel, i : Int, v : Double) -> ChemmolpropstpsaModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_model_sum(s : ChemmolpropstpsaModel) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_tpsa_model_mean(s : ChemmolpropstpsaModel) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_tpsa_model_scale(s : ChemmolpropstpsaModel, f : Double) -> ChemmolpropstpsaModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_model_add(a : ChemmolpropstpsaModel, b : ChemmolpropstpsaModel) -> ChemmolpropstpsaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_tpsa_model_copy(s : ChemmolpropstpsaModel) -> ChemmolpropstpsaModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_model_fill(s : ChemmolpropstpsaModel, v : Double) -> ChemmolpropstpsaModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_model_min(s : ChemmolpropstpsaModel) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_tpsa_model_max(s : ChemmolpropstpsaModel) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_tpsa_model_to_string(s : ChemmolpropstpsaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_layer_make(size : Int) -> ChemmolpropstpsaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_tpsa_layer_len(s : ChemmolpropstpsaLayer) -> Int { s.size }

pub fn chem_mol_props_tpsa_layer_get(s : ChemmolpropstpsaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_tpsa_layer_set(s : ChemmolpropstpsaLayer, i : Int, v : Double) -> ChemmolpropstpsaLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_layer_sum(s : ChemmolpropstpsaLayer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_tpsa_layer_mean(s : ChemmolpropstpsaLayer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_tpsa_layer_scale(s : ChemmolpropstpsaLayer, f : Double) -> ChemmolpropstpsaLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_layer_add(a : ChemmolpropstpsaLayer, b : ChemmolpropstpsaLayer) -> ChemmolpropstpsaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_tpsa_layer_copy(s : ChemmolpropstpsaLayer) -> ChemmolpropstpsaLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_layer_fill(s : ChemmolpropstpsaLayer, v : Double) -> ChemmolpropstpsaLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_layer_min(s : ChemmolpropstpsaLayer) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_tpsa_layer_max(s : ChemmolpropstpsaLayer) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_tpsa_layer_to_string(s : ChemmolpropstpsaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_buffer_make(size : Int) -> ChemmolpropstpsaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_tpsa_buffer_len(s : ChemmolpropstpsaBuffer) -> Int { s.size }

pub fn chem_mol_props_tpsa_buffer_get(s : ChemmolpropstpsaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_tpsa_buffer_set(s : ChemmolpropstpsaBuffer, i : Int, v : Double) -> ChemmolpropstpsaBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_buffer_sum(s : ChemmolpropstpsaBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_tpsa_buffer_mean(s : ChemmolpropstpsaBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_tpsa_buffer_scale(s : ChemmolpropstpsaBuffer, f : Double) -> ChemmolpropstpsaBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_buffer_add(a : ChemmolpropstpsaBuffer, b : ChemmolpropstpsaBuffer) -> ChemmolpropstpsaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_tpsa_buffer_copy(s : ChemmolpropstpsaBuffer) -> ChemmolpropstpsaBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_buffer_fill(s : ChemmolpropstpsaBuffer, v : Double) -> ChemmolpropstpsaBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_buffer_min(s : ChemmolpropstpsaBuffer) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_tpsa_buffer_max(s : ChemmolpropstpsaBuffer) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_tpsa_buffer_to_string(s : ChemmolpropstpsaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_cursor_make(size : Int) -> ChemmolpropstpsaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_tpsa_cursor_len(s : ChemmolpropstpsaCursor) -> Int { s.size }

pub fn chem_mol_props_tpsa_cursor_get(s : ChemmolpropstpsaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_tpsa_cursor_set(s : ChemmolpropstpsaCursor, i : Int, v : Double) -> ChemmolpropstpsaCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_cursor_sum(s : ChemmolpropstpsaCursor) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_tpsa_cursor_mean(s : ChemmolpropstpsaCursor) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_tpsa_cursor_scale(s : ChemmolpropstpsaCursor, f : Double) -> ChemmolpropstpsaCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_cursor_add(a : ChemmolpropstpsaCursor, b : ChemmolpropstpsaCursor) -> ChemmolpropstpsaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_tpsa_cursor_copy(s : ChemmolpropstpsaCursor) -> ChemmolpropstpsaCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_cursor_fill(s : ChemmolpropstpsaCursor, v : Double) -> ChemmolpropstpsaCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_cursor_min(s : ChemmolpropstpsaCursor) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_tpsa_cursor_max(s : ChemmolpropstpsaCursor) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_tpsa_cursor_to_string(s : ChemmolpropstpsaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_view_make(size : Int) -> ChemmolpropstpsaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_tpsa_view_len(s : ChemmolpropstpsaView) -> Int { s.size }

pub fn chem_mol_props_tpsa_view_get(s : ChemmolpropstpsaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_tpsa_view_set(s : ChemmolpropstpsaView, i : Int, v : Double) -> ChemmolpropstpsaView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_view_sum(s : ChemmolpropstpsaView) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_tpsa_view_mean(s : ChemmolpropstpsaView) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_tpsa_view_scale(s : ChemmolpropstpsaView, f : Double) -> ChemmolpropstpsaView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_view_add(a : ChemmolpropstpsaView, b : ChemmolpropstpsaView) -> ChemmolpropstpsaView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_tpsa_view_copy(s : ChemmolpropstpsaView) -> ChemmolpropstpsaView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_view_fill(s : ChemmolpropstpsaView, v : Double) -> ChemmolpropstpsaView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_view_min(s : ChemmolpropstpsaView) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_tpsa_view_max(s : ChemmolpropstpsaView) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_tpsa_view_to_string(s : ChemmolpropstpsaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_range_make(size : Int) -> ChemmolpropstpsaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_tpsa_range_len(s : ChemmolpropstpsaRange) -> Int { s.size }

pub fn chem_mol_props_tpsa_range_get(s : ChemmolpropstpsaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_tpsa_range_set(s : ChemmolpropstpsaRange, i : Int, v : Double) -> ChemmolpropstpsaRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_range_sum(s : ChemmolpropstpsaRange) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_tpsa_range_mean(s : ChemmolpropstpsaRange) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_tpsa_range_scale(s : ChemmolpropstpsaRange, f : Double) -> ChemmolpropstpsaRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_range_add(a : ChemmolpropstpsaRange, b : ChemmolpropstpsaRange) -> ChemmolpropstpsaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_tpsa_range_copy(s : ChemmolpropstpsaRange) -> ChemmolpropstpsaRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_range_fill(s : ChemmolpropstpsaRange, v : Double) -> ChemmolpropstpsaRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_range_min(s : ChemmolpropstpsaRange) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_tpsa_range_max(s : ChemmolpropstpsaRange) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_tpsa_range_to_string(s : ChemmolpropstpsaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_slice_make(size : Int) -> ChemmolpropstpsaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_tpsa_slice_len(s : ChemmolpropstpsaSlice) -> Int { s.size }

pub fn chem_mol_props_tpsa_slice_get(s : ChemmolpropstpsaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_tpsa_slice_set(s : ChemmolpropstpsaSlice, i : Int, v : Double) -> ChemmolpropstpsaSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_slice_sum(s : ChemmolpropstpsaSlice) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_tpsa_slice_mean(s : ChemmolpropstpsaSlice) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_tpsa_slice_scale(s : ChemmolpropstpsaSlice, f : Double) -> ChemmolpropstpsaSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_slice_add(a : ChemmolpropstpsaSlice, b : ChemmolpropstpsaSlice) -> ChemmolpropstpsaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_tpsa_slice_copy(s : ChemmolpropstpsaSlice) -> ChemmolpropstpsaSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_slice_fill(s : ChemmolpropstpsaSlice, v : Double) -> ChemmolpropstpsaSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_tpsa_slice_min(s : ChemmolpropstpsaSlice) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_tpsa_slice_max(s : ChemmolpropstpsaSlice) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_tpsa_slice_to_string(s : ChemmolpropstpsaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

