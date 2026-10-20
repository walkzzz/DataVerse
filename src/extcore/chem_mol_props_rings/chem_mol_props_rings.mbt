///===
/// extcore/chem_mol_props_rings

pub(all) struct ChemmolpropsringsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_mol_props_rings_make_point(x : Double, y : Double) -> ChemmolpropsringsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_mol_props_rings_make_point3(x : Double, y : Double, z : Double) -> ChemmolpropsringsPoint {
  { x, y, z, label: 0 }
}

pub fn ChemmolpropsringsPoint::x(self : ChemmolpropsringsPoint) -> Double { self.x }

pub fn ChemmolpropsringsPoint::y(self : ChemmolpropsringsPoint) -> Double { self.y }

pub fn ChemmolpropsringsPoint::z(self : ChemmolpropsringsPoint) -> Double { self.z }

pub fn ChemmolpropsringsPoint::label(self : ChemmolpropsringsPoint) -> Int { self.label }

pub fn ChemmolpropsringsPoint::dist(self : ChemmolpropsringsPoint, other : ChemmolpropsringsPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemmolpropsringsPoint::add(self : ChemmolpropsringsPoint, other : ChemmolpropsringsPoint) -> ChemmolpropsringsPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemmolpropsringsPoint::sub(self : ChemmolpropsringsPoint, other : ChemmolpropsringsPoint) -> ChemmolpropsringsPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemmolpropsringsPoint::scale(self : ChemmolpropsringsPoint, s : Double) -> ChemmolpropsringsPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemmolpropsringsPoint::dot(self : ChemmolpropsringsPoint, other : ChemmolpropsringsPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemmolpropsringsPoint::cross(self : ChemmolpropsringsPoint, other : ChemmolpropsringsPoint) -> ChemmolpropsringsPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemmolpropsringsPoint::norm(self : ChemmolpropsringsPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemmolpropsringsPoint::normalize(self : ChemmolpropsringsPoint) -> ChemmolpropsringsPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolpropsringsPoint::negate(self : ChemmolpropsringsPoint) -> ChemmolpropsringsPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemmolpropsringsPoint::mid(self : ChemmolpropsringsPoint, other : ChemmolpropsringsPoint) -> ChemmolpropsringsPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemmolpropsringsPoint::lerp(self : ChemmolpropsringsPoint, other : ChemmolpropsringsPoint, t : Double) -> ChemmolpropsringsPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemmolpropsringsPoint::to_string(self : ChemmolpropsringsPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemmolpropsringsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_mol_props_rings_make_series(vals : Array[Double], name : String) -> ChemmolpropsringsSeries {
  { vals, name, meta: 0 }
}

pub fn ChemmolpropsringsSeries::len(self : ChemmolpropsringsSeries) -> Int { self.vals.length() }

pub fn ChemmolpropsringsSeries::sum(self : ChemmolpropsringsSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemmolpropsringsSeries::mean(self : ChemmolpropsringsSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemmolpropsringsSeries::min(self : ChemmolpropsringsSeries) -> Double { @_common.min(self.vals) }

pub fn ChemmolpropsringsSeries::max(self : ChemmolpropsringsSeries) -> Double { @_common.max(self.vals) }

pub fn ChemmolpropsringsSeries::range(self : ChemmolpropsringsSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemmolpropsringsSeries::variance(self : ChemmolpropsringsSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemmolpropsringsSeries::std(self : ChemmolpropsringsSeries) -> Double { @_common.std(self.vals) }

pub fn ChemmolpropsringsSeries::median(self : ChemmolpropsringsSeries) -> Double { @_common.median(self.vals) }

pub fn ChemmolpropsringsSeries::scale(self : ChemmolpropsringsSeries, f : Double) -> ChemmolpropsringsSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemmolpropsringsSeries::add(self : ChemmolpropsringsSeries, other : ChemmolpropsringsSeries) -> ChemmolpropsringsSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemmolpropsringsSeries::sub(self : ChemmolpropsringsSeries, other : ChemmolpropsringsSeries) -> ChemmolpropsringsSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemmolpropsringsSeries::normalize(self : ChemmolpropsringsSeries) -> ChemmolpropsringsSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemmolpropsringsSeries::cumsum(self : ChemmolpropsringsSeries) -> ChemmolpropsringsSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemmolpropsringsSeries::to_string(self : ChemmolpropsringsSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolpropsringsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_mol_props_rings_make_matrix(rows : Int, cols : Int, val : Double) -> ChemmolpropsringsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_mol_props_rings_matrix_identity(n : Int) -> ChemmolpropsringsMatrix {
  let m = chem_mol_props_rings_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemmolpropsringsMatrix::get(self : ChemmolpropsringsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemmolpropsringsMatrix::transpose(self : ChemmolpropsringsMatrix) -> ChemmolpropsringsMatrix {
  let result = chem_mol_props_rings_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemmolpropsringsMatrix::add(self : ChemmolpropsringsMatrix, other : ChemmolpropsringsMatrix) -> ChemmolpropsringsMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_mol_props_rings_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemmolpropsringsMatrix::scale(self : ChemmolpropsringsMatrix, s : Double) -> ChemmolpropsringsMatrix {
  let result = chem_mol_props_rings_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemmolpropsringsMatrix::multiply(self : ChemmolpropsringsMatrix, other : ChemmolpropsringsMatrix) -> ChemmolpropsringsMatrix {
  if self.cols != other.rows { return chem_mol_props_rings_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_mol_props_rings_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ChemmolpropsringsMatrix::trace(self : ChemmolpropsringsMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemmolpropsringsMatrix::det(self : ChemmolpropsringsMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemmolpropsringsMatrix::norm(self : ChemmolpropsringsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemmolpropsringsMatrix::to_string(self : ChemmolpropsringsMatrix) -> String {
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

pub(all) struct ChemmolpropsringsVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_mol_props_rings_make_vector(comps : Array[Double]) -> ChemmolpropsringsVector {
  { comps, dim: comps.length() }
}

pub fn chem_mol_props_rings_vector_zero(dim : Int) -> ChemmolpropsringsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemmolpropsringsVector::add(self : ChemmolpropsringsVector, other : ChemmolpropsringsVector) -> ChemmolpropsringsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolpropsringsVector::sub(self : ChemmolpropsringsVector, other : ChemmolpropsringsVector) -> ChemmolpropsringsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolpropsringsVector::scale(self : ChemmolpropsringsVector, s : Double) -> ChemmolpropsringsVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemmolpropsringsVector::dot(self : ChemmolpropsringsVector, other : ChemmolpropsringsVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemmolpropsringsVector::norm(self : ChemmolpropsringsVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemmolpropsringsVector::normalize(self : ChemmolpropsringsVector) -> ChemmolpropsringsVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolpropsringsVector::dist(self : ChemmolpropsringsVector, other : ChemmolpropsringsVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemmolpropsringsVector::to_string(self : ChemmolpropsringsVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_mol_props_rings_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_mol_props_rings_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_mol_props_rings_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_mol_props_rings_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_mol_props_rings_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_mol_props_rings_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_mol_props_rings_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_mol_props_rings_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_mol_props_rings_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_mol_props_rings_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_mol_props_rings_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_mol_props_rings_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_mol_props_rings_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_mol_props_rings_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_mol_props_rings_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_mol_props_rings_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_mol_props_rings_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_mol_props_rings_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_mol_props_rings_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_mol_props_rings_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_mol_props_rings_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_mol_props_rings_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_mol_props_rings_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_mol_props_rings_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_mol_props_rings_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_mol_props_rings_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_mol_props_rings_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_mol_props_rings_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_mol_props_rings_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemmolpropsringsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rings_frame_make(size : Int) -> ChemmolpropsringsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rings_frame_len(s : ChemmolpropsringsFrame) -> Int { s.size }

pub fn chem_mol_props_rings_frame_get(s : ChemmolpropsringsFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rings_frame_set(s : ChemmolpropsringsFrame, i : Int, v : Double) -> ChemmolpropsringsFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_frame_sum(s : ChemmolpropsringsFrame) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_rings_frame_mean(s : ChemmolpropsringsFrame) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_rings_frame_scale(s : ChemmolpropsringsFrame, f : Double) -> ChemmolpropsringsFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_frame_add(a : ChemmolpropsringsFrame, b : ChemmolpropsringsFrame) -> ChemmolpropsringsFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_rings_frame_copy(s : ChemmolpropsringsFrame) -> ChemmolpropsringsFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_frame_fill(s : ChemmolpropsringsFrame, v : Double) -> ChemmolpropsringsFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_frame_min(s : ChemmolpropsringsFrame) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_rings_frame_max(s : ChemmolpropsringsFrame) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_rings_frame_to_string(s : ChemmolpropsringsFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsringsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rings_table_make(size : Int) -> ChemmolpropsringsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rings_table_len(s : ChemmolpropsringsTable) -> Int { s.size }

pub fn chem_mol_props_rings_table_get(s : ChemmolpropsringsTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rings_table_set(s : ChemmolpropsringsTable, i : Int, v : Double) -> ChemmolpropsringsTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_table_sum(s : ChemmolpropsringsTable) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_rings_table_mean(s : ChemmolpropsringsTable) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_rings_table_scale(s : ChemmolpropsringsTable, f : Double) -> ChemmolpropsringsTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_table_add(a : ChemmolpropsringsTable, b : ChemmolpropsringsTable) -> ChemmolpropsringsTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_rings_table_copy(s : ChemmolpropsringsTable) -> ChemmolpropsringsTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_table_fill(s : ChemmolpropsringsTable, v : Double) -> ChemmolpropsringsTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_table_min(s : ChemmolpropsringsTable) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_rings_table_max(s : ChemmolpropsringsTable) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_rings_table_to_string(s : ChemmolpropsringsTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsringsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rings_graphn_make(size : Int) -> ChemmolpropsringsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rings_graphn_len(s : ChemmolpropsringsGraphN) -> Int { s.size }

pub fn chem_mol_props_rings_graphn_get(s : ChemmolpropsringsGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rings_graphn_set(s : ChemmolpropsringsGraphN, i : Int, v : Double) -> ChemmolpropsringsGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_graphn_sum(s : ChemmolpropsringsGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_rings_graphn_mean(s : ChemmolpropsringsGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_rings_graphn_scale(s : ChemmolpropsringsGraphN, f : Double) -> ChemmolpropsringsGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_graphn_add(a : ChemmolpropsringsGraphN, b : ChemmolpropsringsGraphN) -> ChemmolpropsringsGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_rings_graphn_copy(s : ChemmolpropsringsGraphN) -> ChemmolpropsringsGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_graphn_fill(s : ChemmolpropsringsGraphN, v : Double) -> ChemmolpropsringsGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_graphn_min(s : ChemmolpropsringsGraphN) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_rings_graphn_max(s : ChemmolpropsringsGraphN) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_rings_graphn_to_string(s : ChemmolpropsringsGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsringsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rings_node_make(size : Int) -> ChemmolpropsringsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rings_node_len(s : ChemmolpropsringsNode) -> Int { s.size }

pub fn chem_mol_props_rings_node_get(s : ChemmolpropsringsNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rings_node_set(s : ChemmolpropsringsNode, i : Int, v : Double) -> ChemmolpropsringsNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_node_sum(s : ChemmolpropsringsNode) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_rings_node_mean(s : ChemmolpropsringsNode) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_rings_node_scale(s : ChemmolpropsringsNode, f : Double) -> ChemmolpropsringsNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_node_add(a : ChemmolpropsringsNode, b : ChemmolpropsringsNode) -> ChemmolpropsringsNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_rings_node_copy(s : ChemmolpropsringsNode) -> ChemmolpropsringsNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_node_fill(s : ChemmolpropsringsNode, v : Double) -> ChemmolpropsringsNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_node_min(s : ChemmolpropsringsNode) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_rings_node_max(s : ChemmolpropsringsNode) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_rings_node_to_string(s : ChemmolpropsringsNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsringsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rings_edge_make(size : Int) -> ChemmolpropsringsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rings_edge_len(s : ChemmolpropsringsEdge) -> Int { s.size }

pub fn chem_mol_props_rings_edge_get(s : ChemmolpropsringsEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rings_edge_set(s : ChemmolpropsringsEdge, i : Int, v : Double) -> ChemmolpropsringsEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_edge_sum(s : ChemmolpropsringsEdge) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_rings_edge_mean(s : ChemmolpropsringsEdge) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_rings_edge_scale(s : ChemmolpropsringsEdge, f : Double) -> ChemmolpropsringsEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_edge_add(a : ChemmolpropsringsEdge, b : ChemmolpropsringsEdge) -> ChemmolpropsringsEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_rings_edge_copy(s : ChemmolpropsringsEdge) -> ChemmolpropsringsEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_edge_fill(s : ChemmolpropsringsEdge, v : Double) -> ChemmolpropsringsEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_edge_min(s : ChemmolpropsringsEdge) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_rings_edge_max(s : ChemmolpropsringsEdge) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_rings_edge_to_string(s : ChemmolpropsringsEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsringsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rings_path_make(size : Int) -> ChemmolpropsringsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rings_path_len(s : ChemmolpropsringsPath) -> Int { s.size }

pub fn chem_mol_props_rings_path_get(s : ChemmolpropsringsPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rings_path_set(s : ChemmolpropsringsPath, i : Int, v : Double) -> ChemmolpropsringsPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_path_sum(s : ChemmolpropsringsPath) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_rings_path_mean(s : ChemmolpropsringsPath) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_rings_path_scale(s : ChemmolpropsringsPath, f : Double) -> ChemmolpropsringsPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_path_add(a : ChemmolpropsringsPath, b : ChemmolpropsringsPath) -> ChemmolpropsringsPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_rings_path_copy(s : ChemmolpropsringsPath) -> ChemmolpropsringsPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_path_fill(s : ChemmolpropsringsPath, v : Double) -> ChemmolpropsringsPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_path_min(s : ChemmolpropsringsPath) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_rings_path_max(s : ChemmolpropsringsPath) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_rings_path_to_string(s : ChemmolpropsringsPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsringsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rings_cluster_make(size : Int) -> ChemmolpropsringsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rings_cluster_len(s : ChemmolpropsringsCluster) -> Int { s.size }

pub fn chem_mol_props_rings_cluster_get(s : ChemmolpropsringsCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rings_cluster_set(s : ChemmolpropsringsCluster, i : Int, v : Double) -> ChemmolpropsringsCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_cluster_sum(s : ChemmolpropsringsCluster) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_rings_cluster_mean(s : ChemmolpropsringsCluster) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_rings_cluster_scale(s : ChemmolpropsringsCluster, f : Double) -> ChemmolpropsringsCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_cluster_add(a : ChemmolpropsringsCluster, b : ChemmolpropsringsCluster) -> ChemmolpropsringsCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_rings_cluster_copy(s : ChemmolpropsringsCluster) -> ChemmolpropsringsCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_cluster_fill(s : ChemmolpropsringsCluster, v : Double) -> ChemmolpropsringsCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_cluster_min(s : ChemmolpropsringsCluster) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_rings_cluster_max(s : ChemmolpropsringsCluster) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_rings_cluster_to_string(s : ChemmolpropsringsCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsringsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rings_model_make(size : Int) -> ChemmolpropsringsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rings_model_len(s : ChemmolpropsringsModel) -> Int { s.size }

pub fn chem_mol_props_rings_model_get(s : ChemmolpropsringsModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rings_model_set(s : ChemmolpropsringsModel, i : Int, v : Double) -> ChemmolpropsringsModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_model_sum(s : ChemmolpropsringsModel) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_rings_model_mean(s : ChemmolpropsringsModel) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_rings_model_scale(s : ChemmolpropsringsModel, f : Double) -> ChemmolpropsringsModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_model_add(a : ChemmolpropsringsModel, b : ChemmolpropsringsModel) -> ChemmolpropsringsModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_rings_model_copy(s : ChemmolpropsringsModel) -> ChemmolpropsringsModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_model_fill(s : ChemmolpropsringsModel, v : Double) -> ChemmolpropsringsModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_model_min(s : ChemmolpropsringsModel) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_rings_model_max(s : ChemmolpropsringsModel) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_rings_model_to_string(s : ChemmolpropsringsModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsringsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rings_layer_make(size : Int) -> ChemmolpropsringsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rings_layer_len(s : ChemmolpropsringsLayer) -> Int { s.size }

pub fn chem_mol_props_rings_layer_get(s : ChemmolpropsringsLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rings_layer_set(s : ChemmolpropsringsLayer, i : Int, v : Double) -> ChemmolpropsringsLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_layer_sum(s : ChemmolpropsringsLayer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_rings_layer_mean(s : ChemmolpropsringsLayer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_rings_layer_scale(s : ChemmolpropsringsLayer, f : Double) -> ChemmolpropsringsLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_layer_add(a : ChemmolpropsringsLayer, b : ChemmolpropsringsLayer) -> ChemmolpropsringsLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_rings_layer_copy(s : ChemmolpropsringsLayer) -> ChemmolpropsringsLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_layer_fill(s : ChemmolpropsringsLayer, v : Double) -> ChemmolpropsringsLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_layer_min(s : ChemmolpropsringsLayer) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_rings_layer_max(s : ChemmolpropsringsLayer) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_rings_layer_to_string(s : ChemmolpropsringsLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsringsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rings_buffer_make(size : Int) -> ChemmolpropsringsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rings_buffer_len(s : ChemmolpropsringsBuffer) -> Int { s.size }

pub fn chem_mol_props_rings_buffer_get(s : ChemmolpropsringsBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rings_buffer_set(s : ChemmolpropsringsBuffer, i : Int, v : Double) -> ChemmolpropsringsBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_buffer_sum(s : ChemmolpropsringsBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_rings_buffer_mean(s : ChemmolpropsringsBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_rings_buffer_scale(s : ChemmolpropsringsBuffer, f : Double) -> ChemmolpropsringsBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_buffer_add(a : ChemmolpropsringsBuffer, b : ChemmolpropsringsBuffer) -> ChemmolpropsringsBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_rings_buffer_copy(s : ChemmolpropsringsBuffer) -> ChemmolpropsringsBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_buffer_fill(s : ChemmolpropsringsBuffer, v : Double) -> ChemmolpropsringsBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_buffer_min(s : ChemmolpropsringsBuffer) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_rings_buffer_max(s : ChemmolpropsringsBuffer) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_rings_buffer_to_string(s : ChemmolpropsringsBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsringsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rings_cursor_make(size : Int) -> ChemmolpropsringsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rings_cursor_len(s : ChemmolpropsringsCursor) -> Int { s.size }

pub fn chem_mol_props_rings_cursor_get(s : ChemmolpropsringsCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rings_cursor_set(s : ChemmolpropsringsCursor, i : Int, v : Double) -> ChemmolpropsringsCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_cursor_sum(s : ChemmolpropsringsCursor) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_rings_cursor_mean(s : ChemmolpropsringsCursor) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_rings_cursor_scale(s : ChemmolpropsringsCursor, f : Double) -> ChemmolpropsringsCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_cursor_add(a : ChemmolpropsringsCursor, b : ChemmolpropsringsCursor) -> ChemmolpropsringsCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_rings_cursor_copy(s : ChemmolpropsringsCursor) -> ChemmolpropsringsCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_cursor_fill(s : ChemmolpropsringsCursor, v : Double) -> ChemmolpropsringsCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_cursor_min(s : ChemmolpropsringsCursor) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_rings_cursor_max(s : ChemmolpropsringsCursor) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_rings_cursor_to_string(s : ChemmolpropsringsCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsringsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rings_view_make(size : Int) -> ChemmolpropsringsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rings_view_len(s : ChemmolpropsringsView) -> Int { s.size }

pub fn chem_mol_props_rings_view_get(s : ChemmolpropsringsView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rings_view_set(s : ChemmolpropsringsView, i : Int, v : Double) -> ChemmolpropsringsView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_view_sum(s : ChemmolpropsringsView) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_rings_view_mean(s : ChemmolpropsringsView) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_rings_view_scale(s : ChemmolpropsringsView, f : Double) -> ChemmolpropsringsView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_view_add(a : ChemmolpropsringsView, b : ChemmolpropsringsView) -> ChemmolpropsringsView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_rings_view_copy(s : ChemmolpropsringsView) -> ChemmolpropsringsView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_view_fill(s : ChemmolpropsringsView, v : Double) -> ChemmolpropsringsView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_view_min(s : ChemmolpropsringsView) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_rings_view_max(s : ChemmolpropsringsView) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_rings_view_to_string(s : ChemmolpropsringsView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsringsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rings_range_make(size : Int) -> ChemmolpropsringsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rings_range_len(s : ChemmolpropsringsRange) -> Int { s.size }

pub fn chem_mol_props_rings_range_get(s : ChemmolpropsringsRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rings_range_set(s : ChemmolpropsringsRange, i : Int, v : Double) -> ChemmolpropsringsRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_range_sum(s : ChemmolpropsringsRange) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_rings_range_mean(s : ChemmolpropsringsRange) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_rings_range_scale(s : ChemmolpropsringsRange, f : Double) -> ChemmolpropsringsRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_range_add(a : ChemmolpropsringsRange, b : ChemmolpropsringsRange) -> ChemmolpropsringsRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_rings_range_copy(s : ChemmolpropsringsRange) -> ChemmolpropsringsRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_range_fill(s : ChemmolpropsringsRange, v : Double) -> ChemmolpropsringsRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_range_min(s : ChemmolpropsringsRange) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_rings_range_max(s : ChemmolpropsringsRange) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_rings_range_to_string(s : ChemmolpropsringsRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsringsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rings_slice_make(size : Int) -> ChemmolpropsringsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rings_slice_len(s : ChemmolpropsringsSlice) -> Int { s.size }

pub fn chem_mol_props_rings_slice_get(s : ChemmolpropsringsSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rings_slice_set(s : ChemmolpropsringsSlice, i : Int, v : Double) -> ChemmolpropsringsSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_slice_sum(s : ChemmolpropsringsSlice) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_rings_slice_mean(s : ChemmolpropsringsSlice) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_rings_slice_scale(s : ChemmolpropsringsSlice, f : Double) -> ChemmolpropsringsSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_slice_add(a : ChemmolpropsringsSlice, b : ChemmolpropsringsSlice) -> ChemmolpropsringsSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_rings_slice_copy(s : ChemmolpropsringsSlice) -> ChemmolpropsringsSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_slice_fill(s : ChemmolpropsringsSlice, v : Double) -> ChemmolpropsringsSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_rings_slice_min(s : ChemmolpropsringsSlice) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_rings_slice_max(s : ChemmolpropsringsSlice) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_rings_slice_to_string(s : ChemmolpropsringsSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

