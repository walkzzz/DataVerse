///===
/// extcore/chem_mol_repr_xyz

pub(all) struct ChemmolreprxyzPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_mol_repr_xyz_make_point(x : Double, y : Double) -> ChemmolreprxyzPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_mol_repr_xyz_make_point3(x : Double, y : Double, z : Double) -> ChemmolreprxyzPoint {
  { x, y, z, label: 0 }
}

pub fn ChemmolreprxyzPoint::x(self : ChemmolreprxyzPoint) -> Double { self.x }

pub fn ChemmolreprxyzPoint::y(self : ChemmolreprxyzPoint) -> Double { self.y }

pub fn ChemmolreprxyzPoint::z(self : ChemmolreprxyzPoint) -> Double { self.z }

pub fn ChemmolreprxyzPoint::label(self : ChemmolreprxyzPoint) -> Int { self.label }

pub fn ChemmolreprxyzPoint::dist(self : ChemmolreprxyzPoint, other : ChemmolreprxyzPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemmolreprxyzPoint::add(self : ChemmolreprxyzPoint, other : ChemmolreprxyzPoint) -> ChemmolreprxyzPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemmolreprxyzPoint::sub(self : ChemmolreprxyzPoint, other : ChemmolreprxyzPoint) -> ChemmolreprxyzPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemmolreprxyzPoint::scale(self : ChemmolreprxyzPoint, s : Double) -> ChemmolreprxyzPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemmolreprxyzPoint::dot(self : ChemmolreprxyzPoint, other : ChemmolreprxyzPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemmolreprxyzPoint::cross(self : ChemmolreprxyzPoint, other : ChemmolreprxyzPoint) -> ChemmolreprxyzPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemmolreprxyzPoint::norm(self : ChemmolreprxyzPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemmolreprxyzPoint::normalize(self : ChemmolreprxyzPoint) -> ChemmolreprxyzPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolreprxyzPoint::negate(self : ChemmolreprxyzPoint) -> ChemmolreprxyzPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemmolreprxyzPoint::mid(self : ChemmolreprxyzPoint, other : ChemmolreprxyzPoint) -> ChemmolreprxyzPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemmolreprxyzPoint::lerp(self : ChemmolreprxyzPoint, other : ChemmolreprxyzPoint, t : Double) -> ChemmolreprxyzPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemmolreprxyzPoint::to_string(self : ChemmolreprxyzPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemmolreprxyzSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_mol_repr_xyz_make_series(vals : Array[Double], name : String) -> ChemmolreprxyzSeries {
  { vals, name, meta: 0 }
}

pub fn ChemmolreprxyzSeries::len(self : ChemmolreprxyzSeries) -> Int { self.vals.length() }

pub fn ChemmolreprxyzSeries::sum(self : ChemmolreprxyzSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemmolreprxyzSeries::mean(self : ChemmolreprxyzSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemmolreprxyzSeries::min(self : ChemmolreprxyzSeries) -> Double { @_common.min(self.vals) }

pub fn ChemmolreprxyzSeries::max(self : ChemmolreprxyzSeries) -> Double { @_common.max(self.vals) }

pub fn ChemmolreprxyzSeries::range(self : ChemmolreprxyzSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemmolreprxyzSeries::variance(self : ChemmolreprxyzSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemmolreprxyzSeries::std(self : ChemmolreprxyzSeries) -> Double { @_common.std(self.vals) }

pub fn ChemmolreprxyzSeries::median(self : ChemmolreprxyzSeries) -> Double { @_common.median(self.vals) }

pub fn ChemmolreprxyzSeries::scale(self : ChemmolreprxyzSeries, f : Double) -> ChemmolreprxyzSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemmolreprxyzSeries::add(self : ChemmolreprxyzSeries, other : ChemmolreprxyzSeries) -> ChemmolreprxyzSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemmolreprxyzSeries::sub(self : ChemmolreprxyzSeries, other : ChemmolreprxyzSeries) -> ChemmolreprxyzSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemmolreprxyzSeries::normalize(self : ChemmolreprxyzSeries) -> ChemmolreprxyzSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemmolreprxyzSeries::cumsum(self : ChemmolreprxyzSeries) -> ChemmolreprxyzSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemmolreprxyzSeries::to_string(self : ChemmolreprxyzSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolreprxyzMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_mol_repr_xyz_make_matrix(rows : Int, cols : Int, val : Double) -> ChemmolreprxyzMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_mol_repr_xyz_matrix_identity(n : Int) -> ChemmolreprxyzMatrix {
  let m = chem_mol_repr_xyz_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemmolreprxyzMatrix::get(self : ChemmolreprxyzMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemmolreprxyzMatrix::transpose(self : ChemmolreprxyzMatrix) -> ChemmolreprxyzMatrix {
  let result = chem_mol_repr_xyz_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemmolreprxyzMatrix::add(self : ChemmolreprxyzMatrix, other : ChemmolreprxyzMatrix) -> ChemmolreprxyzMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_mol_repr_xyz_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemmolreprxyzMatrix::scale(self : ChemmolreprxyzMatrix, s : Double) -> ChemmolreprxyzMatrix {
  let result = chem_mol_repr_xyz_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemmolreprxyzMatrix::multiply(self : ChemmolreprxyzMatrix, other : ChemmolreprxyzMatrix) -> ChemmolreprxyzMatrix {
  if self.cols != other.rows { return chem_mol_repr_xyz_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_mol_repr_xyz_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ChemmolreprxyzMatrix::trace(self : ChemmolreprxyzMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemmolreprxyzMatrix::det(self : ChemmolreprxyzMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemmolreprxyzMatrix::norm(self : ChemmolreprxyzMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemmolreprxyzMatrix::to_string(self : ChemmolreprxyzMatrix) -> String {
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

pub(all) struct ChemmolreprxyzVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_mol_repr_xyz_make_vector(comps : Array[Double]) -> ChemmolreprxyzVector {
  { comps, dim: comps.length() }
}

pub fn chem_mol_repr_xyz_vector_zero(dim : Int) -> ChemmolreprxyzVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemmolreprxyzVector::add(self : ChemmolreprxyzVector, other : ChemmolreprxyzVector) -> ChemmolreprxyzVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolreprxyzVector::sub(self : ChemmolreprxyzVector, other : ChemmolreprxyzVector) -> ChemmolreprxyzVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolreprxyzVector::scale(self : ChemmolreprxyzVector, s : Double) -> ChemmolreprxyzVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemmolreprxyzVector::dot(self : ChemmolreprxyzVector, other : ChemmolreprxyzVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemmolreprxyzVector::norm(self : ChemmolreprxyzVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemmolreprxyzVector::normalize(self : ChemmolreprxyzVector) -> ChemmolreprxyzVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolreprxyzVector::dist(self : ChemmolreprxyzVector, other : ChemmolreprxyzVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemmolreprxyzVector::to_string(self : ChemmolreprxyzVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_mol_repr_xyz_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_mol_repr_xyz_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_mol_repr_xyz_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_mol_repr_xyz_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_mol_repr_xyz_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_mol_repr_xyz_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_mol_repr_xyz_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_mol_repr_xyz_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_mol_repr_xyz_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_mol_repr_xyz_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_mol_repr_xyz_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_mol_repr_xyz_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_mol_repr_xyz_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_mol_repr_xyz_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_mol_repr_xyz_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_mol_repr_xyz_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_mol_repr_xyz_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_mol_repr_xyz_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_mol_repr_xyz_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_mol_repr_xyz_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_mol_repr_xyz_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_mol_repr_xyz_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_mol_repr_xyz_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_mol_repr_xyz_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_mol_repr_xyz_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_mol_repr_xyz_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_mol_repr_xyz_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_mol_repr_xyz_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_mol_repr_xyz_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemmolreprxyzFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_xyz_frame_make(size : Int) -> ChemmolreprxyzFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_xyz_frame_len(s : ChemmolreprxyzFrame) -> Int { s.size }

pub fn chem_mol_repr_xyz_frame_get(s : ChemmolreprxyzFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_xyz_frame_set(s : ChemmolreprxyzFrame, i : Int, v : Double) -> ChemmolreprxyzFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_frame_sum(s : ChemmolreprxyzFrame) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_xyz_frame_mean(s : ChemmolreprxyzFrame) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_xyz_frame_scale(s : ChemmolreprxyzFrame, f : Double) -> ChemmolreprxyzFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_frame_add(a : ChemmolreprxyzFrame, b : ChemmolreprxyzFrame) -> ChemmolreprxyzFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_xyz_frame_copy(s : ChemmolreprxyzFrame) -> ChemmolreprxyzFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_frame_fill(s : ChemmolreprxyzFrame, v : Double) -> ChemmolreprxyzFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_frame_min(s : ChemmolreprxyzFrame) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_xyz_frame_max(s : ChemmolreprxyzFrame) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_xyz_frame_to_string(s : ChemmolreprxyzFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprxyzTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_xyz_table_make(size : Int) -> ChemmolreprxyzTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_xyz_table_len(s : ChemmolreprxyzTable) -> Int { s.size }

pub fn chem_mol_repr_xyz_table_get(s : ChemmolreprxyzTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_xyz_table_set(s : ChemmolreprxyzTable, i : Int, v : Double) -> ChemmolreprxyzTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_table_sum(s : ChemmolreprxyzTable) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_xyz_table_mean(s : ChemmolreprxyzTable) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_xyz_table_scale(s : ChemmolreprxyzTable, f : Double) -> ChemmolreprxyzTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_table_add(a : ChemmolreprxyzTable, b : ChemmolreprxyzTable) -> ChemmolreprxyzTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_xyz_table_copy(s : ChemmolreprxyzTable) -> ChemmolreprxyzTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_table_fill(s : ChemmolreprxyzTable, v : Double) -> ChemmolreprxyzTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_table_min(s : ChemmolreprxyzTable) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_xyz_table_max(s : ChemmolreprxyzTable) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_xyz_table_to_string(s : ChemmolreprxyzTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprxyzGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_xyz_graphn_make(size : Int) -> ChemmolreprxyzGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_xyz_graphn_len(s : ChemmolreprxyzGraphN) -> Int { s.size }

pub fn chem_mol_repr_xyz_graphn_get(s : ChemmolreprxyzGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_xyz_graphn_set(s : ChemmolreprxyzGraphN, i : Int, v : Double) -> ChemmolreprxyzGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_graphn_sum(s : ChemmolreprxyzGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_xyz_graphn_mean(s : ChemmolreprxyzGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_xyz_graphn_scale(s : ChemmolreprxyzGraphN, f : Double) -> ChemmolreprxyzGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_graphn_add(a : ChemmolreprxyzGraphN, b : ChemmolreprxyzGraphN) -> ChemmolreprxyzGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_xyz_graphn_copy(s : ChemmolreprxyzGraphN) -> ChemmolreprxyzGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_graphn_fill(s : ChemmolreprxyzGraphN, v : Double) -> ChemmolreprxyzGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_graphn_min(s : ChemmolreprxyzGraphN) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_xyz_graphn_max(s : ChemmolreprxyzGraphN) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_xyz_graphn_to_string(s : ChemmolreprxyzGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprxyzNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_xyz_node_make(size : Int) -> ChemmolreprxyzNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_xyz_node_len(s : ChemmolreprxyzNode) -> Int { s.size }

pub fn chem_mol_repr_xyz_node_get(s : ChemmolreprxyzNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_xyz_node_set(s : ChemmolreprxyzNode, i : Int, v : Double) -> ChemmolreprxyzNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_node_sum(s : ChemmolreprxyzNode) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_xyz_node_mean(s : ChemmolreprxyzNode) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_xyz_node_scale(s : ChemmolreprxyzNode, f : Double) -> ChemmolreprxyzNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_node_add(a : ChemmolreprxyzNode, b : ChemmolreprxyzNode) -> ChemmolreprxyzNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_xyz_node_copy(s : ChemmolreprxyzNode) -> ChemmolreprxyzNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_node_fill(s : ChemmolreprxyzNode, v : Double) -> ChemmolreprxyzNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_node_min(s : ChemmolreprxyzNode) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_xyz_node_max(s : ChemmolreprxyzNode) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_xyz_node_to_string(s : ChemmolreprxyzNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprxyzEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_xyz_edge_make(size : Int) -> ChemmolreprxyzEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_xyz_edge_len(s : ChemmolreprxyzEdge) -> Int { s.size }

pub fn chem_mol_repr_xyz_edge_get(s : ChemmolreprxyzEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_xyz_edge_set(s : ChemmolreprxyzEdge, i : Int, v : Double) -> ChemmolreprxyzEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_edge_sum(s : ChemmolreprxyzEdge) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_xyz_edge_mean(s : ChemmolreprxyzEdge) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_xyz_edge_scale(s : ChemmolreprxyzEdge, f : Double) -> ChemmolreprxyzEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_edge_add(a : ChemmolreprxyzEdge, b : ChemmolreprxyzEdge) -> ChemmolreprxyzEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_xyz_edge_copy(s : ChemmolreprxyzEdge) -> ChemmolreprxyzEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_edge_fill(s : ChemmolreprxyzEdge, v : Double) -> ChemmolreprxyzEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_edge_min(s : ChemmolreprxyzEdge) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_xyz_edge_max(s : ChemmolreprxyzEdge) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_xyz_edge_to_string(s : ChemmolreprxyzEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprxyzPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_xyz_path_make(size : Int) -> ChemmolreprxyzPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_xyz_path_len(s : ChemmolreprxyzPath) -> Int { s.size }

pub fn chem_mol_repr_xyz_path_get(s : ChemmolreprxyzPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_xyz_path_set(s : ChemmolreprxyzPath, i : Int, v : Double) -> ChemmolreprxyzPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_path_sum(s : ChemmolreprxyzPath) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_xyz_path_mean(s : ChemmolreprxyzPath) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_xyz_path_scale(s : ChemmolreprxyzPath, f : Double) -> ChemmolreprxyzPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_path_add(a : ChemmolreprxyzPath, b : ChemmolreprxyzPath) -> ChemmolreprxyzPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_xyz_path_copy(s : ChemmolreprxyzPath) -> ChemmolreprxyzPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_path_fill(s : ChemmolreprxyzPath, v : Double) -> ChemmolreprxyzPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_path_min(s : ChemmolreprxyzPath) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_xyz_path_max(s : ChemmolreprxyzPath) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_xyz_path_to_string(s : ChemmolreprxyzPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprxyzCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_xyz_cluster_make(size : Int) -> ChemmolreprxyzCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_xyz_cluster_len(s : ChemmolreprxyzCluster) -> Int { s.size }

pub fn chem_mol_repr_xyz_cluster_get(s : ChemmolreprxyzCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_xyz_cluster_set(s : ChemmolreprxyzCluster, i : Int, v : Double) -> ChemmolreprxyzCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_cluster_sum(s : ChemmolreprxyzCluster) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_xyz_cluster_mean(s : ChemmolreprxyzCluster) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_xyz_cluster_scale(s : ChemmolreprxyzCluster, f : Double) -> ChemmolreprxyzCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_cluster_add(a : ChemmolreprxyzCluster, b : ChemmolreprxyzCluster) -> ChemmolreprxyzCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_xyz_cluster_copy(s : ChemmolreprxyzCluster) -> ChemmolreprxyzCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_cluster_fill(s : ChemmolreprxyzCluster, v : Double) -> ChemmolreprxyzCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_cluster_min(s : ChemmolreprxyzCluster) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_xyz_cluster_max(s : ChemmolreprxyzCluster) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_xyz_cluster_to_string(s : ChemmolreprxyzCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprxyzModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_xyz_model_make(size : Int) -> ChemmolreprxyzModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_xyz_model_len(s : ChemmolreprxyzModel) -> Int { s.size }

pub fn chem_mol_repr_xyz_model_get(s : ChemmolreprxyzModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_xyz_model_set(s : ChemmolreprxyzModel, i : Int, v : Double) -> ChemmolreprxyzModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_model_sum(s : ChemmolreprxyzModel) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_xyz_model_mean(s : ChemmolreprxyzModel) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_xyz_model_scale(s : ChemmolreprxyzModel, f : Double) -> ChemmolreprxyzModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_model_add(a : ChemmolreprxyzModel, b : ChemmolreprxyzModel) -> ChemmolreprxyzModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_xyz_model_copy(s : ChemmolreprxyzModel) -> ChemmolreprxyzModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_model_fill(s : ChemmolreprxyzModel, v : Double) -> ChemmolreprxyzModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_model_min(s : ChemmolreprxyzModel) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_xyz_model_max(s : ChemmolreprxyzModel) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_xyz_model_to_string(s : ChemmolreprxyzModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprxyzLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_xyz_layer_make(size : Int) -> ChemmolreprxyzLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_xyz_layer_len(s : ChemmolreprxyzLayer) -> Int { s.size }

pub fn chem_mol_repr_xyz_layer_get(s : ChemmolreprxyzLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_xyz_layer_set(s : ChemmolreprxyzLayer, i : Int, v : Double) -> ChemmolreprxyzLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_layer_sum(s : ChemmolreprxyzLayer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_xyz_layer_mean(s : ChemmolreprxyzLayer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_xyz_layer_scale(s : ChemmolreprxyzLayer, f : Double) -> ChemmolreprxyzLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_layer_add(a : ChemmolreprxyzLayer, b : ChemmolreprxyzLayer) -> ChemmolreprxyzLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_xyz_layer_copy(s : ChemmolreprxyzLayer) -> ChemmolreprxyzLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_layer_fill(s : ChemmolreprxyzLayer, v : Double) -> ChemmolreprxyzLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_layer_min(s : ChemmolreprxyzLayer) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_xyz_layer_max(s : ChemmolreprxyzLayer) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_xyz_layer_to_string(s : ChemmolreprxyzLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprxyzBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_xyz_buffer_make(size : Int) -> ChemmolreprxyzBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_xyz_buffer_len(s : ChemmolreprxyzBuffer) -> Int { s.size }

pub fn chem_mol_repr_xyz_buffer_get(s : ChemmolreprxyzBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_xyz_buffer_set(s : ChemmolreprxyzBuffer, i : Int, v : Double) -> ChemmolreprxyzBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_buffer_sum(s : ChemmolreprxyzBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_xyz_buffer_mean(s : ChemmolreprxyzBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_xyz_buffer_scale(s : ChemmolreprxyzBuffer, f : Double) -> ChemmolreprxyzBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_buffer_add(a : ChemmolreprxyzBuffer, b : ChemmolreprxyzBuffer) -> ChemmolreprxyzBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_xyz_buffer_copy(s : ChemmolreprxyzBuffer) -> ChemmolreprxyzBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_buffer_fill(s : ChemmolreprxyzBuffer, v : Double) -> ChemmolreprxyzBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_buffer_min(s : ChemmolreprxyzBuffer) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_xyz_buffer_max(s : ChemmolreprxyzBuffer) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_xyz_buffer_to_string(s : ChemmolreprxyzBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprxyzCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_xyz_cursor_make(size : Int) -> ChemmolreprxyzCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_xyz_cursor_len(s : ChemmolreprxyzCursor) -> Int { s.size }

pub fn chem_mol_repr_xyz_cursor_get(s : ChemmolreprxyzCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_xyz_cursor_set(s : ChemmolreprxyzCursor, i : Int, v : Double) -> ChemmolreprxyzCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_cursor_sum(s : ChemmolreprxyzCursor) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_xyz_cursor_mean(s : ChemmolreprxyzCursor) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_xyz_cursor_scale(s : ChemmolreprxyzCursor, f : Double) -> ChemmolreprxyzCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_cursor_add(a : ChemmolreprxyzCursor, b : ChemmolreprxyzCursor) -> ChemmolreprxyzCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_xyz_cursor_copy(s : ChemmolreprxyzCursor) -> ChemmolreprxyzCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_cursor_fill(s : ChemmolreprxyzCursor, v : Double) -> ChemmolreprxyzCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_cursor_min(s : ChemmolreprxyzCursor) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_xyz_cursor_max(s : ChemmolreprxyzCursor) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_xyz_cursor_to_string(s : ChemmolreprxyzCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprxyzView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_xyz_view_make(size : Int) -> ChemmolreprxyzView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_xyz_view_len(s : ChemmolreprxyzView) -> Int { s.size }

pub fn chem_mol_repr_xyz_view_get(s : ChemmolreprxyzView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_xyz_view_set(s : ChemmolreprxyzView, i : Int, v : Double) -> ChemmolreprxyzView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_view_sum(s : ChemmolreprxyzView) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_xyz_view_mean(s : ChemmolreprxyzView) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_xyz_view_scale(s : ChemmolreprxyzView, f : Double) -> ChemmolreprxyzView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_view_add(a : ChemmolreprxyzView, b : ChemmolreprxyzView) -> ChemmolreprxyzView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_xyz_view_copy(s : ChemmolreprxyzView) -> ChemmolreprxyzView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_view_fill(s : ChemmolreprxyzView, v : Double) -> ChemmolreprxyzView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_view_min(s : ChemmolreprxyzView) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_xyz_view_max(s : ChemmolreprxyzView) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_xyz_view_to_string(s : ChemmolreprxyzView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprxyzRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_xyz_range_make(size : Int) -> ChemmolreprxyzRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_xyz_range_len(s : ChemmolreprxyzRange) -> Int { s.size }

pub fn chem_mol_repr_xyz_range_get(s : ChemmolreprxyzRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_xyz_range_set(s : ChemmolreprxyzRange, i : Int, v : Double) -> ChemmolreprxyzRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_range_sum(s : ChemmolreprxyzRange) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_xyz_range_mean(s : ChemmolreprxyzRange) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_xyz_range_scale(s : ChemmolreprxyzRange, f : Double) -> ChemmolreprxyzRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_range_add(a : ChemmolreprxyzRange, b : ChemmolreprxyzRange) -> ChemmolreprxyzRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_xyz_range_copy(s : ChemmolreprxyzRange) -> ChemmolreprxyzRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_range_fill(s : ChemmolreprxyzRange, v : Double) -> ChemmolreprxyzRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_range_min(s : ChemmolreprxyzRange) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_xyz_range_max(s : ChemmolreprxyzRange) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_xyz_range_to_string(s : ChemmolreprxyzRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprxyzSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_xyz_slice_make(size : Int) -> ChemmolreprxyzSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_xyz_slice_len(s : ChemmolreprxyzSlice) -> Int { s.size }

pub fn chem_mol_repr_xyz_slice_get(s : ChemmolreprxyzSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_xyz_slice_set(s : ChemmolreprxyzSlice, i : Int, v : Double) -> ChemmolreprxyzSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_slice_sum(s : ChemmolreprxyzSlice) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_xyz_slice_mean(s : ChemmolreprxyzSlice) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_xyz_slice_scale(s : ChemmolreprxyzSlice, f : Double) -> ChemmolreprxyzSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_slice_add(a : ChemmolreprxyzSlice, b : ChemmolreprxyzSlice) -> ChemmolreprxyzSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_xyz_slice_copy(s : ChemmolreprxyzSlice) -> ChemmolreprxyzSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_slice_fill(s : ChemmolreprxyzSlice, v : Double) -> ChemmolreprxyzSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_xyz_slice_min(s : ChemmolreprxyzSlice) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_xyz_slice_max(s : ChemmolreprxyzSlice) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_xyz_slice_to_string(s : ChemmolreprxyzSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

