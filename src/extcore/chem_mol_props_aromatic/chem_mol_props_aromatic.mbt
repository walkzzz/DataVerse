///===
/// extcore/chem_mol_props_aromatic

pub(all) struct ChemmolpropsaromaticPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_mol_props_aromatic_make_point(x : Double, y : Double) -> ChemmolpropsaromaticPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_mol_props_aromatic_make_point3(x : Double, y : Double, z : Double) -> ChemmolpropsaromaticPoint {
  { x, y, z, label: 0 }
}

pub fn ChemmolpropsaromaticPoint::x(self : ChemmolpropsaromaticPoint) -> Double { self.x }

pub fn ChemmolpropsaromaticPoint::y(self : ChemmolpropsaromaticPoint) -> Double { self.y }

pub fn ChemmolpropsaromaticPoint::z(self : ChemmolpropsaromaticPoint) -> Double { self.z }

pub fn ChemmolpropsaromaticPoint::label(self : ChemmolpropsaromaticPoint) -> Int { self.label }

pub fn ChemmolpropsaromaticPoint::dist(self : ChemmolpropsaromaticPoint, other : ChemmolpropsaromaticPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemmolpropsaromaticPoint::add(self : ChemmolpropsaromaticPoint, other : ChemmolpropsaromaticPoint) -> ChemmolpropsaromaticPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemmolpropsaromaticPoint::sub(self : ChemmolpropsaromaticPoint, other : ChemmolpropsaromaticPoint) -> ChemmolpropsaromaticPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemmolpropsaromaticPoint::scale(self : ChemmolpropsaromaticPoint, s : Double) -> ChemmolpropsaromaticPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemmolpropsaromaticPoint::dot(self : ChemmolpropsaromaticPoint, other : ChemmolpropsaromaticPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemmolpropsaromaticPoint::cross(self : ChemmolpropsaromaticPoint, other : ChemmolpropsaromaticPoint) -> ChemmolpropsaromaticPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemmolpropsaromaticPoint::norm(self : ChemmolpropsaromaticPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemmolpropsaromaticPoint::normalize(self : ChemmolpropsaromaticPoint) -> ChemmolpropsaromaticPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolpropsaromaticPoint::negate(self : ChemmolpropsaromaticPoint) -> ChemmolpropsaromaticPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemmolpropsaromaticPoint::mid(self : ChemmolpropsaromaticPoint, other : ChemmolpropsaromaticPoint) -> ChemmolpropsaromaticPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemmolpropsaromaticPoint::lerp(self : ChemmolpropsaromaticPoint, other : ChemmolpropsaromaticPoint, t : Double) -> ChemmolpropsaromaticPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemmolpropsaromaticPoint::to_string(self : ChemmolpropsaromaticPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemmolpropsaromaticSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_mol_props_aromatic_make_series(vals : Array[Double], name : String) -> ChemmolpropsaromaticSeries {
  { vals, name, meta: 0 }
}

pub fn ChemmolpropsaromaticSeries::len(self : ChemmolpropsaromaticSeries) -> Int { self.vals.length() }

pub fn ChemmolpropsaromaticSeries::sum(self : ChemmolpropsaromaticSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemmolpropsaromaticSeries::mean(self : ChemmolpropsaromaticSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemmolpropsaromaticSeries::min(self : ChemmolpropsaromaticSeries) -> Double { @_common.min(self.vals) }

pub fn ChemmolpropsaromaticSeries::max(self : ChemmolpropsaromaticSeries) -> Double { @_common.max(self.vals) }

pub fn ChemmolpropsaromaticSeries::range(self : ChemmolpropsaromaticSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemmolpropsaromaticSeries::variance(self : ChemmolpropsaromaticSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemmolpropsaromaticSeries::std(self : ChemmolpropsaromaticSeries) -> Double { @_common.std(self.vals) }

pub fn ChemmolpropsaromaticSeries::median(self : ChemmolpropsaromaticSeries) -> Double { @_common.median(self.vals) }

pub fn ChemmolpropsaromaticSeries::scale(self : ChemmolpropsaromaticSeries, f : Double) -> ChemmolpropsaromaticSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemmolpropsaromaticSeries::add(self : ChemmolpropsaromaticSeries, other : ChemmolpropsaromaticSeries) -> ChemmolpropsaromaticSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemmolpropsaromaticSeries::sub(self : ChemmolpropsaromaticSeries, other : ChemmolpropsaromaticSeries) -> ChemmolpropsaromaticSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemmolpropsaromaticSeries::normalize(self : ChemmolpropsaromaticSeries) -> ChemmolpropsaromaticSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemmolpropsaromaticSeries::cumsum(self : ChemmolpropsaromaticSeries) -> ChemmolpropsaromaticSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemmolpropsaromaticSeries::to_string(self : ChemmolpropsaromaticSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolpropsaromaticMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_mol_props_aromatic_make_matrix(rows : Int, cols : Int, val : Double) -> ChemmolpropsaromaticMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_mol_props_aromatic_matrix_identity(n : Int) -> ChemmolpropsaromaticMatrix {
  let m = chem_mol_props_aromatic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemmolpropsaromaticMatrix::get(self : ChemmolpropsaromaticMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemmolpropsaromaticMatrix::transpose(self : ChemmolpropsaromaticMatrix) -> ChemmolpropsaromaticMatrix {
  let result = chem_mol_props_aromatic_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemmolpropsaromaticMatrix::add(self : ChemmolpropsaromaticMatrix, other : ChemmolpropsaromaticMatrix) -> ChemmolpropsaromaticMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_mol_props_aromatic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemmolpropsaromaticMatrix::scale(self : ChemmolpropsaromaticMatrix, s : Double) -> ChemmolpropsaromaticMatrix {
  let result = chem_mol_props_aromatic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemmolpropsaromaticMatrix::multiply(self : ChemmolpropsaromaticMatrix, other : ChemmolpropsaromaticMatrix) -> ChemmolpropsaromaticMatrix {
  if self.cols != other.rows { return chem_mol_props_aromatic_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_mol_props_aromatic_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ChemmolpropsaromaticMatrix::trace(self : ChemmolpropsaromaticMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemmolpropsaromaticMatrix::det(self : ChemmolpropsaromaticMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemmolpropsaromaticMatrix::norm(self : ChemmolpropsaromaticMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemmolpropsaromaticMatrix::to_string(self : ChemmolpropsaromaticMatrix) -> String {
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

pub(all) struct ChemmolpropsaromaticVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_mol_props_aromatic_make_vector(comps : Array[Double]) -> ChemmolpropsaromaticVector {
  { comps, dim: comps.length() }
}

pub fn chem_mol_props_aromatic_vector_zero(dim : Int) -> ChemmolpropsaromaticVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemmolpropsaromaticVector::add(self : ChemmolpropsaromaticVector, other : ChemmolpropsaromaticVector) -> ChemmolpropsaromaticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolpropsaromaticVector::sub(self : ChemmolpropsaromaticVector, other : ChemmolpropsaromaticVector) -> ChemmolpropsaromaticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolpropsaromaticVector::scale(self : ChemmolpropsaromaticVector, s : Double) -> ChemmolpropsaromaticVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemmolpropsaromaticVector::dot(self : ChemmolpropsaromaticVector, other : ChemmolpropsaromaticVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemmolpropsaromaticVector::norm(self : ChemmolpropsaromaticVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemmolpropsaromaticVector::normalize(self : ChemmolpropsaromaticVector) -> ChemmolpropsaromaticVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolpropsaromaticVector::dist(self : ChemmolpropsaromaticVector, other : ChemmolpropsaromaticVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemmolpropsaromaticVector::to_string(self : ChemmolpropsaromaticVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_mol_props_aromatic_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_mol_props_aromatic_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_mol_props_aromatic_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_mol_props_aromatic_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_mol_props_aromatic_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_mol_props_aromatic_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_mol_props_aromatic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_mol_props_aromatic_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_mol_props_aromatic_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_mol_props_aromatic_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_mol_props_aromatic_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_mol_props_aromatic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_mol_props_aromatic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_mol_props_aromatic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_mol_props_aromatic_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_mol_props_aromatic_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_mol_props_aromatic_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_mol_props_aromatic_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_mol_props_aromatic_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_mol_props_aromatic_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_mol_props_aromatic_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_mol_props_aromatic_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_mol_props_aromatic_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_mol_props_aromatic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_mol_props_aromatic_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_mol_props_aromatic_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_mol_props_aromatic_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_mol_props_aromatic_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_mol_props_aromatic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemmolpropsaromaticFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_aromatic_frame_make(size : Int) -> ChemmolpropsaromaticFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_aromatic_frame_len(s : ChemmolpropsaromaticFrame) -> Int { s.size }

pub fn chem_mol_props_aromatic_frame_get(s : ChemmolpropsaromaticFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_aromatic_frame_set(s : ChemmolpropsaromaticFrame, i : Int, v : Double) -> ChemmolpropsaromaticFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_frame_sum(s : ChemmolpropsaromaticFrame) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_aromatic_frame_mean(s : ChemmolpropsaromaticFrame) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_aromatic_frame_scale(s : ChemmolpropsaromaticFrame, f : Double) -> ChemmolpropsaromaticFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_frame_add(a : ChemmolpropsaromaticFrame, b : ChemmolpropsaromaticFrame) -> ChemmolpropsaromaticFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_aromatic_frame_copy(s : ChemmolpropsaromaticFrame) -> ChemmolpropsaromaticFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_frame_fill(s : ChemmolpropsaromaticFrame, v : Double) -> ChemmolpropsaromaticFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_frame_min(s : ChemmolpropsaromaticFrame) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_aromatic_frame_max(s : ChemmolpropsaromaticFrame) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_aromatic_frame_to_string(s : ChemmolpropsaromaticFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsaromaticTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_aromatic_table_make(size : Int) -> ChemmolpropsaromaticTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_aromatic_table_len(s : ChemmolpropsaromaticTable) -> Int { s.size }

pub fn chem_mol_props_aromatic_table_get(s : ChemmolpropsaromaticTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_aromatic_table_set(s : ChemmolpropsaromaticTable, i : Int, v : Double) -> ChemmolpropsaromaticTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_table_sum(s : ChemmolpropsaromaticTable) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_aromatic_table_mean(s : ChemmolpropsaromaticTable) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_aromatic_table_scale(s : ChemmolpropsaromaticTable, f : Double) -> ChemmolpropsaromaticTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_table_add(a : ChemmolpropsaromaticTable, b : ChemmolpropsaromaticTable) -> ChemmolpropsaromaticTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_aromatic_table_copy(s : ChemmolpropsaromaticTable) -> ChemmolpropsaromaticTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_table_fill(s : ChemmolpropsaromaticTable, v : Double) -> ChemmolpropsaromaticTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_table_min(s : ChemmolpropsaromaticTable) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_aromatic_table_max(s : ChemmolpropsaromaticTable) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_aromatic_table_to_string(s : ChemmolpropsaromaticTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsaromaticGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_aromatic_graphn_make(size : Int) -> ChemmolpropsaromaticGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_aromatic_graphn_len(s : ChemmolpropsaromaticGraphN) -> Int { s.size }

pub fn chem_mol_props_aromatic_graphn_get(s : ChemmolpropsaromaticGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_aromatic_graphn_set(s : ChemmolpropsaromaticGraphN, i : Int, v : Double) -> ChemmolpropsaromaticGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_graphn_sum(s : ChemmolpropsaromaticGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_aromatic_graphn_mean(s : ChemmolpropsaromaticGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_aromatic_graphn_scale(s : ChemmolpropsaromaticGraphN, f : Double) -> ChemmolpropsaromaticGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_graphn_add(a : ChemmolpropsaromaticGraphN, b : ChemmolpropsaromaticGraphN) -> ChemmolpropsaromaticGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_aromatic_graphn_copy(s : ChemmolpropsaromaticGraphN) -> ChemmolpropsaromaticGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_graphn_fill(s : ChemmolpropsaromaticGraphN, v : Double) -> ChemmolpropsaromaticGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_graphn_min(s : ChemmolpropsaromaticGraphN) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_aromatic_graphn_max(s : ChemmolpropsaromaticGraphN) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_aromatic_graphn_to_string(s : ChemmolpropsaromaticGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsaromaticNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_aromatic_node_make(size : Int) -> ChemmolpropsaromaticNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_aromatic_node_len(s : ChemmolpropsaromaticNode) -> Int { s.size }

pub fn chem_mol_props_aromatic_node_get(s : ChemmolpropsaromaticNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_aromatic_node_set(s : ChemmolpropsaromaticNode, i : Int, v : Double) -> ChemmolpropsaromaticNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_node_sum(s : ChemmolpropsaromaticNode) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_aromatic_node_mean(s : ChemmolpropsaromaticNode) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_aromatic_node_scale(s : ChemmolpropsaromaticNode, f : Double) -> ChemmolpropsaromaticNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_node_add(a : ChemmolpropsaromaticNode, b : ChemmolpropsaromaticNode) -> ChemmolpropsaromaticNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_aromatic_node_copy(s : ChemmolpropsaromaticNode) -> ChemmolpropsaromaticNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_node_fill(s : ChemmolpropsaromaticNode, v : Double) -> ChemmolpropsaromaticNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_node_min(s : ChemmolpropsaromaticNode) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_aromatic_node_max(s : ChemmolpropsaromaticNode) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_aromatic_node_to_string(s : ChemmolpropsaromaticNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsaromaticEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_aromatic_edge_make(size : Int) -> ChemmolpropsaromaticEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_aromatic_edge_len(s : ChemmolpropsaromaticEdge) -> Int { s.size }

pub fn chem_mol_props_aromatic_edge_get(s : ChemmolpropsaromaticEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_aromatic_edge_set(s : ChemmolpropsaromaticEdge, i : Int, v : Double) -> ChemmolpropsaromaticEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_edge_sum(s : ChemmolpropsaromaticEdge) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_aromatic_edge_mean(s : ChemmolpropsaromaticEdge) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_aromatic_edge_scale(s : ChemmolpropsaromaticEdge, f : Double) -> ChemmolpropsaromaticEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_edge_add(a : ChemmolpropsaromaticEdge, b : ChemmolpropsaromaticEdge) -> ChemmolpropsaromaticEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_aromatic_edge_copy(s : ChemmolpropsaromaticEdge) -> ChemmolpropsaromaticEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_edge_fill(s : ChemmolpropsaromaticEdge, v : Double) -> ChemmolpropsaromaticEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_edge_min(s : ChemmolpropsaromaticEdge) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_aromatic_edge_max(s : ChemmolpropsaromaticEdge) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_aromatic_edge_to_string(s : ChemmolpropsaromaticEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsaromaticPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_aromatic_path_make(size : Int) -> ChemmolpropsaromaticPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_aromatic_path_len(s : ChemmolpropsaromaticPath) -> Int { s.size }

pub fn chem_mol_props_aromatic_path_get(s : ChemmolpropsaromaticPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_aromatic_path_set(s : ChemmolpropsaromaticPath, i : Int, v : Double) -> ChemmolpropsaromaticPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_path_sum(s : ChemmolpropsaromaticPath) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_aromatic_path_mean(s : ChemmolpropsaromaticPath) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_aromatic_path_scale(s : ChemmolpropsaromaticPath, f : Double) -> ChemmolpropsaromaticPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_path_add(a : ChemmolpropsaromaticPath, b : ChemmolpropsaromaticPath) -> ChemmolpropsaromaticPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_aromatic_path_copy(s : ChemmolpropsaromaticPath) -> ChemmolpropsaromaticPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_path_fill(s : ChemmolpropsaromaticPath, v : Double) -> ChemmolpropsaromaticPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_path_min(s : ChemmolpropsaromaticPath) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_aromatic_path_max(s : ChemmolpropsaromaticPath) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_aromatic_path_to_string(s : ChemmolpropsaromaticPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsaromaticCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_aromatic_cluster_make(size : Int) -> ChemmolpropsaromaticCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_aromatic_cluster_len(s : ChemmolpropsaromaticCluster) -> Int { s.size }

pub fn chem_mol_props_aromatic_cluster_get(s : ChemmolpropsaromaticCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_aromatic_cluster_set(s : ChemmolpropsaromaticCluster, i : Int, v : Double) -> ChemmolpropsaromaticCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_cluster_sum(s : ChemmolpropsaromaticCluster) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_aromatic_cluster_mean(s : ChemmolpropsaromaticCluster) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_aromatic_cluster_scale(s : ChemmolpropsaromaticCluster, f : Double) -> ChemmolpropsaromaticCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_cluster_add(a : ChemmolpropsaromaticCluster, b : ChemmolpropsaromaticCluster) -> ChemmolpropsaromaticCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_aromatic_cluster_copy(s : ChemmolpropsaromaticCluster) -> ChemmolpropsaromaticCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_cluster_fill(s : ChemmolpropsaromaticCluster, v : Double) -> ChemmolpropsaromaticCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_cluster_min(s : ChemmolpropsaromaticCluster) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_aromatic_cluster_max(s : ChemmolpropsaromaticCluster) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_aromatic_cluster_to_string(s : ChemmolpropsaromaticCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsaromaticModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_aromatic_model_make(size : Int) -> ChemmolpropsaromaticModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_aromatic_model_len(s : ChemmolpropsaromaticModel) -> Int { s.size }

pub fn chem_mol_props_aromatic_model_get(s : ChemmolpropsaromaticModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_aromatic_model_set(s : ChemmolpropsaromaticModel, i : Int, v : Double) -> ChemmolpropsaromaticModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_model_sum(s : ChemmolpropsaromaticModel) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_aromatic_model_mean(s : ChemmolpropsaromaticModel) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_aromatic_model_scale(s : ChemmolpropsaromaticModel, f : Double) -> ChemmolpropsaromaticModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_model_add(a : ChemmolpropsaromaticModel, b : ChemmolpropsaromaticModel) -> ChemmolpropsaromaticModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_aromatic_model_copy(s : ChemmolpropsaromaticModel) -> ChemmolpropsaromaticModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_model_fill(s : ChemmolpropsaromaticModel, v : Double) -> ChemmolpropsaromaticModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_model_min(s : ChemmolpropsaromaticModel) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_aromatic_model_max(s : ChemmolpropsaromaticModel) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_aromatic_model_to_string(s : ChemmolpropsaromaticModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsaromaticLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_aromatic_layer_make(size : Int) -> ChemmolpropsaromaticLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_aromatic_layer_len(s : ChemmolpropsaromaticLayer) -> Int { s.size }

pub fn chem_mol_props_aromatic_layer_get(s : ChemmolpropsaromaticLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_aromatic_layer_set(s : ChemmolpropsaromaticLayer, i : Int, v : Double) -> ChemmolpropsaromaticLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_layer_sum(s : ChemmolpropsaromaticLayer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_aromatic_layer_mean(s : ChemmolpropsaromaticLayer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_aromatic_layer_scale(s : ChemmolpropsaromaticLayer, f : Double) -> ChemmolpropsaromaticLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_layer_add(a : ChemmolpropsaromaticLayer, b : ChemmolpropsaromaticLayer) -> ChemmolpropsaromaticLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_aromatic_layer_copy(s : ChemmolpropsaromaticLayer) -> ChemmolpropsaromaticLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_layer_fill(s : ChemmolpropsaromaticLayer, v : Double) -> ChemmolpropsaromaticLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_layer_min(s : ChemmolpropsaromaticLayer) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_aromatic_layer_max(s : ChemmolpropsaromaticLayer) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_aromatic_layer_to_string(s : ChemmolpropsaromaticLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsaromaticBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_aromatic_buffer_make(size : Int) -> ChemmolpropsaromaticBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_aromatic_buffer_len(s : ChemmolpropsaromaticBuffer) -> Int { s.size }

pub fn chem_mol_props_aromatic_buffer_get(s : ChemmolpropsaromaticBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_aromatic_buffer_set(s : ChemmolpropsaromaticBuffer, i : Int, v : Double) -> ChemmolpropsaromaticBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_buffer_sum(s : ChemmolpropsaromaticBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_aromatic_buffer_mean(s : ChemmolpropsaromaticBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_aromatic_buffer_scale(s : ChemmolpropsaromaticBuffer, f : Double) -> ChemmolpropsaromaticBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_buffer_add(a : ChemmolpropsaromaticBuffer, b : ChemmolpropsaromaticBuffer) -> ChemmolpropsaromaticBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_aromatic_buffer_copy(s : ChemmolpropsaromaticBuffer) -> ChemmolpropsaromaticBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_buffer_fill(s : ChemmolpropsaromaticBuffer, v : Double) -> ChemmolpropsaromaticBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_buffer_min(s : ChemmolpropsaromaticBuffer) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_aromatic_buffer_max(s : ChemmolpropsaromaticBuffer) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_aromatic_buffer_to_string(s : ChemmolpropsaromaticBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsaromaticCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_aromatic_cursor_make(size : Int) -> ChemmolpropsaromaticCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_aromatic_cursor_len(s : ChemmolpropsaromaticCursor) -> Int { s.size }

pub fn chem_mol_props_aromatic_cursor_get(s : ChemmolpropsaromaticCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_aromatic_cursor_set(s : ChemmolpropsaromaticCursor, i : Int, v : Double) -> ChemmolpropsaromaticCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_cursor_sum(s : ChemmolpropsaromaticCursor) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_aromatic_cursor_mean(s : ChemmolpropsaromaticCursor) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_aromatic_cursor_scale(s : ChemmolpropsaromaticCursor, f : Double) -> ChemmolpropsaromaticCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_cursor_add(a : ChemmolpropsaromaticCursor, b : ChemmolpropsaromaticCursor) -> ChemmolpropsaromaticCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_aromatic_cursor_copy(s : ChemmolpropsaromaticCursor) -> ChemmolpropsaromaticCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_cursor_fill(s : ChemmolpropsaromaticCursor, v : Double) -> ChemmolpropsaromaticCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_cursor_min(s : ChemmolpropsaromaticCursor) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_aromatic_cursor_max(s : ChemmolpropsaromaticCursor) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_aromatic_cursor_to_string(s : ChemmolpropsaromaticCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsaromaticView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_aromatic_view_make(size : Int) -> ChemmolpropsaromaticView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_aromatic_view_len(s : ChemmolpropsaromaticView) -> Int { s.size }

pub fn chem_mol_props_aromatic_view_get(s : ChemmolpropsaromaticView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_aromatic_view_set(s : ChemmolpropsaromaticView, i : Int, v : Double) -> ChemmolpropsaromaticView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_view_sum(s : ChemmolpropsaromaticView) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_aromatic_view_mean(s : ChemmolpropsaromaticView) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_aromatic_view_scale(s : ChemmolpropsaromaticView, f : Double) -> ChemmolpropsaromaticView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_view_add(a : ChemmolpropsaromaticView, b : ChemmolpropsaromaticView) -> ChemmolpropsaromaticView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_aromatic_view_copy(s : ChemmolpropsaromaticView) -> ChemmolpropsaromaticView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_view_fill(s : ChemmolpropsaromaticView, v : Double) -> ChemmolpropsaromaticView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_view_min(s : ChemmolpropsaromaticView) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_aromatic_view_max(s : ChemmolpropsaromaticView) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_aromatic_view_to_string(s : ChemmolpropsaromaticView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsaromaticRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_aromatic_range_make(size : Int) -> ChemmolpropsaromaticRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_aromatic_range_len(s : ChemmolpropsaromaticRange) -> Int { s.size }

pub fn chem_mol_props_aromatic_range_get(s : ChemmolpropsaromaticRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_aromatic_range_set(s : ChemmolpropsaromaticRange, i : Int, v : Double) -> ChemmolpropsaromaticRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_range_sum(s : ChemmolpropsaromaticRange) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_aromatic_range_mean(s : ChemmolpropsaromaticRange) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_aromatic_range_scale(s : ChemmolpropsaromaticRange, f : Double) -> ChemmolpropsaromaticRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_range_add(a : ChemmolpropsaromaticRange, b : ChemmolpropsaromaticRange) -> ChemmolpropsaromaticRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_aromatic_range_copy(s : ChemmolpropsaromaticRange) -> ChemmolpropsaromaticRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_range_fill(s : ChemmolpropsaromaticRange, v : Double) -> ChemmolpropsaromaticRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_range_min(s : ChemmolpropsaromaticRange) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_aromatic_range_max(s : ChemmolpropsaromaticRange) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_aromatic_range_to_string(s : ChemmolpropsaromaticRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsaromaticSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_aromatic_slice_make(size : Int) -> ChemmolpropsaromaticSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_aromatic_slice_len(s : ChemmolpropsaromaticSlice) -> Int { s.size }

pub fn chem_mol_props_aromatic_slice_get(s : ChemmolpropsaromaticSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_aromatic_slice_set(s : ChemmolpropsaromaticSlice, i : Int, v : Double) -> ChemmolpropsaromaticSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_slice_sum(s : ChemmolpropsaromaticSlice) -> Double { @_common.sum(s.data) }

pub fn chem_mol_props_aromatic_slice_mean(s : ChemmolpropsaromaticSlice) -> Double { @_common.mean(s.data) }

pub fn chem_mol_props_aromatic_slice_scale(s : ChemmolpropsaromaticSlice, f : Double) -> ChemmolpropsaromaticSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_slice_add(a : ChemmolpropsaromaticSlice, b : ChemmolpropsaromaticSlice) -> ChemmolpropsaromaticSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_props_aromatic_slice_copy(s : ChemmolpropsaromaticSlice) -> ChemmolpropsaromaticSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_slice_fill(s : ChemmolpropsaromaticSlice, v : Double) -> ChemmolpropsaromaticSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_props_aromatic_slice_min(s : ChemmolpropsaromaticSlice) -> Double { @_common.min(s.data) }

pub fn chem_mol_props_aromatic_slice_max(s : ChemmolpropsaromaticSlice) -> Double { @_common.max(s.data) }

pub fn chem_mol_props_aromatic_slice_to_string(s : ChemmolpropsaromaticSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

