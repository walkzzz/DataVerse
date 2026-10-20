///===
/// extcore/chem_mol_repr_molfile

pub(all) struct ChemmolreprmolfilePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_mol_repr_molfile_make_point(x : Double, y : Double) -> ChemmolreprmolfilePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_mol_repr_molfile_make_point3(x : Double, y : Double, z : Double) -> ChemmolreprmolfilePoint {
  { x, y, z, label: 0 }
}

pub fn ChemmolreprmolfilePoint::x(self : ChemmolreprmolfilePoint) -> Double { self.x }

pub fn ChemmolreprmolfilePoint::y(self : ChemmolreprmolfilePoint) -> Double { self.y }

pub fn ChemmolreprmolfilePoint::z(self : ChemmolreprmolfilePoint) -> Double { self.z }

pub fn ChemmolreprmolfilePoint::label(self : ChemmolreprmolfilePoint) -> Int { self.label }

pub fn ChemmolreprmolfilePoint::dist(self : ChemmolreprmolfilePoint, other : ChemmolreprmolfilePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemmolreprmolfilePoint::add(self : ChemmolreprmolfilePoint, other : ChemmolreprmolfilePoint) -> ChemmolreprmolfilePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemmolreprmolfilePoint::sub(self : ChemmolreprmolfilePoint, other : ChemmolreprmolfilePoint) -> ChemmolreprmolfilePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemmolreprmolfilePoint::scale(self : ChemmolreprmolfilePoint, s : Double) -> ChemmolreprmolfilePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemmolreprmolfilePoint::dot(self : ChemmolreprmolfilePoint, other : ChemmolreprmolfilePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemmolreprmolfilePoint::cross(self : ChemmolreprmolfilePoint, other : ChemmolreprmolfilePoint) -> ChemmolreprmolfilePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemmolreprmolfilePoint::norm(self : ChemmolreprmolfilePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemmolreprmolfilePoint::normalize(self : ChemmolreprmolfilePoint) -> ChemmolreprmolfilePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolreprmolfilePoint::negate(self : ChemmolreprmolfilePoint) -> ChemmolreprmolfilePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemmolreprmolfilePoint::mid(self : ChemmolreprmolfilePoint, other : ChemmolreprmolfilePoint) -> ChemmolreprmolfilePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemmolreprmolfilePoint::lerp(self : ChemmolreprmolfilePoint, other : ChemmolreprmolfilePoint, t : Double) -> ChemmolreprmolfilePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemmolreprmolfilePoint::to_string(self : ChemmolreprmolfilePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemmolreprmolfileSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_mol_repr_molfile_make_series(vals : Array[Double], name : String) -> ChemmolreprmolfileSeries {
  { vals, name, meta: 0 }
}

pub fn ChemmolreprmolfileSeries::len(self : ChemmolreprmolfileSeries) -> Int { self.vals.length() }

pub fn ChemmolreprmolfileSeries::sum(self : ChemmolreprmolfileSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemmolreprmolfileSeries::mean(self : ChemmolreprmolfileSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemmolreprmolfileSeries::min(self : ChemmolreprmolfileSeries) -> Double { @_common.min(self.vals) }

pub fn ChemmolreprmolfileSeries::max(self : ChemmolreprmolfileSeries) -> Double { @_common.max(self.vals) }

pub fn ChemmolreprmolfileSeries::range(self : ChemmolreprmolfileSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemmolreprmolfileSeries::variance(self : ChemmolreprmolfileSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemmolreprmolfileSeries::std(self : ChemmolreprmolfileSeries) -> Double { @_common.std(self.vals) }

pub fn ChemmolreprmolfileSeries::median(self : ChemmolreprmolfileSeries) -> Double { @_common.median(self.vals) }

pub fn ChemmolreprmolfileSeries::scale(self : ChemmolreprmolfileSeries, f : Double) -> ChemmolreprmolfileSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemmolreprmolfileSeries::add(self : ChemmolreprmolfileSeries, other : ChemmolreprmolfileSeries) -> ChemmolreprmolfileSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemmolreprmolfileSeries::sub(self : ChemmolreprmolfileSeries, other : ChemmolreprmolfileSeries) -> ChemmolreprmolfileSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemmolreprmolfileSeries::normalize(self : ChemmolreprmolfileSeries) -> ChemmolreprmolfileSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemmolreprmolfileSeries::cumsum(self : ChemmolreprmolfileSeries) -> ChemmolreprmolfileSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemmolreprmolfileSeries::to_string(self : ChemmolreprmolfileSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolreprmolfileMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_mol_repr_molfile_make_matrix(rows : Int, cols : Int, val : Double) -> ChemmolreprmolfileMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_mol_repr_molfile_matrix_identity(n : Int) -> ChemmolreprmolfileMatrix {
  let m = chem_mol_repr_molfile_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemmolreprmolfileMatrix::get(self : ChemmolreprmolfileMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemmolreprmolfileMatrix::transpose(self : ChemmolreprmolfileMatrix) -> ChemmolreprmolfileMatrix {
  let result = chem_mol_repr_molfile_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemmolreprmolfileMatrix::add(self : ChemmolreprmolfileMatrix, other : ChemmolreprmolfileMatrix) -> ChemmolreprmolfileMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_mol_repr_molfile_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemmolreprmolfileMatrix::scale(self : ChemmolreprmolfileMatrix, s : Double) -> ChemmolreprmolfileMatrix {
  let result = chem_mol_repr_molfile_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemmolreprmolfileMatrix::multiply(self : ChemmolreprmolfileMatrix, other : ChemmolreprmolfileMatrix) -> ChemmolreprmolfileMatrix {
  if self.cols != other.rows { return chem_mol_repr_molfile_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_mol_repr_molfile_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ChemmolreprmolfileMatrix::trace(self : ChemmolreprmolfileMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemmolreprmolfileMatrix::det(self : ChemmolreprmolfileMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemmolreprmolfileMatrix::norm(self : ChemmolreprmolfileMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemmolreprmolfileMatrix::to_string(self : ChemmolreprmolfileMatrix) -> String {
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

pub(all) struct ChemmolreprmolfileVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_mol_repr_molfile_make_vector(comps : Array[Double]) -> ChemmolreprmolfileVector {
  { comps, dim: comps.length() }
}

pub fn chem_mol_repr_molfile_vector_zero(dim : Int) -> ChemmolreprmolfileVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemmolreprmolfileVector::add(self : ChemmolreprmolfileVector, other : ChemmolreprmolfileVector) -> ChemmolreprmolfileVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolreprmolfileVector::sub(self : ChemmolreprmolfileVector, other : ChemmolreprmolfileVector) -> ChemmolreprmolfileVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolreprmolfileVector::scale(self : ChemmolreprmolfileVector, s : Double) -> ChemmolreprmolfileVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemmolreprmolfileVector::dot(self : ChemmolreprmolfileVector, other : ChemmolreprmolfileVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemmolreprmolfileVector::norm(self : ChemmolreprmolfileVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemmolreprmolfileVector::normalize(self : ChemmolreprmolfileVector) -> ChemmolreprmolfileVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolreprmolfileVector::dist(self : ChemmolreprmolfileVector, other : ChemmolreprmolfileVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemmolreprmolfileVector::to_string(self : ChemmolreprmolfileVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_mol_repr_molfile_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_mol_repr_molfile_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_mol_repr_molfile_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_mol_repr_molfile_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_mol_repr_molfile_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_mol_repr_molfile_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_mol_repr_molfile_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_mol_repr_molfile_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_mol_repr_molfile_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_mol_repr_molfile_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_mol_repr_molfile_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_mol_repr_molfile_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_mol_repr_molfile_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_mol_repr_molfile_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_mol_repr_molfile_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_mol_repr_molfile_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_mol_repr_molfile_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_mol_repr_molfile_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_mol_repr_molfile_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_mol_repr_molfile_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_mol_repr_molfile_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_mol_repr_molfile_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_mol_repr_molfile_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_mol_repr_molfile_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_mol_repr_molfile_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_mol_repr_molfile_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_mol_repr_molfile_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_mol_repr_molfile_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_mol_repr_molfile_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemmolreprmolfileFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_molfile_frame_make(size : Int) -> ChemmolreprmolfileFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_molfile_frame_len(s : ChemmolreprmolfileFrame) -> Int { s.size }

pub fn chem_mol_repr_molfile_frame_get(s : ChemmolreprmolfileFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_molfile_frame_set(s : ChemmolreprmolfileFrame, i : Int, v : Double) -> ChemmolreprmolfileFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_frame_sum(s : ChemmolreprmolfileFrame) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_molfile_frame_mean(s : ChemmolreprmolfileFrame) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_molfile_frame_scale(s : ChemmolreprmolfileFrame, f : Double) -> ChemmolreprmolfileFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_frame_add(a : ChemmolreprmolfileFrame, b : ChemmolreprmolfileFrame) -> ChemmolreprmolfileFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_molfile_frame_copy(s : ChemmolreprmolfileFrame) -> ChemmolreprmolfileFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_frame_fill(s : ChemmolreprmolfileFrame, v : Double) -> ChemmolreprmolfileFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_frame_min(s : ChemmolreprmolfileFrame) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_molfile_frame_max(s : ChemmolreprmolfileFrame) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_molfile_frame_to_string(s : ChemmolreprmolfileFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprmolfileTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_molfile_table_make(size : Int) -> ChemmolreprmolfileTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_molfile_table_len(s : ChemmolreprmolfileTable) -> Int { s.size }

pub fn chem_mol_repr_molfile_table_get(s : ChemmolreprmolfileTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_molfile_table_set(s : ChemmolreprmolfileTable, i : Int, v : Double) -> ChemmolreprmolfileTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_table_sum(s : ChemmolreprmolfileTable) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_molfile_table_mean(s : ChemmolreprmolfileTable) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_molfile_table_scale(s : ChemmolreprmolfileTable, f : Double) -> ChemmolreprmolfileTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_table_add(a : ChemmolreprmolfileTable, b : ChemmolreprmolfileTable) -> ChemmolreprmolfileTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_molfile_table_copy(s : ChemmolreprmolfileTable) -> ChemmolreprmolfileTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_table_fill(s : ChemmolreprmolfileTable, v : Double) -> ChemmolreprmolfileTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_table_min(s : ChemmolreprmolfileTable) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_molfile_table_max(s : ChemmolreprmolfileTable) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_molfile_table_to_string(s : ChemmolreprmolfileTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprmolfileGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_molfile_graphn_make(size : Int) -> ChemmolreprmolfileGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_molfile_graphn_len(s : ChemmolreprmolfileGraphN) -> Int { s.size }

pub fn chem_mol_repr_molfile_graphn_get(s : ChemmolreprmolfileGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_molfile_graphn_set(s : ChemmolreprmolfileGraphN, i : Int, v : Double) -> ChemmolreprmolfileGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_graphn_sum(s : ChemmolreprmolfileGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_molfile_graphn_mean(s : ChemmolreprmolfileGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_molfile_graphn_scale(s : ChemmolreprmolfileGraphN, f : Double) -> ChemmolreprmolfileGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_graphn_add(a : ChemmolreprmolfileGraphN, b : ChemmolreprmolfileGraphN) -> ChemmolreprmolfileGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_molfile_graphn_copy(s : ChemmolreprmolfileGraphN) -> ChemmolreprmolfileGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_graphn_fill(s : ChemmolreprmolfileGraphN, v : Double) -> ChemmolreprmolfileGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_graphn_min(s : ChemmolreprmolfileGraphN) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_molfile_graphn_max(s : ChemmolreprmolfileGraphN) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_molfile_graphn_to_string(s : ChemmolreprmolfileGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprmolfileNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_molfile_node_make(size : Int) -> ChemmolreprmolfileNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_molfile_node_len(s : ChemmolreprmolfileNode) -> Int { s.size }

pub fn chem_mol_repr_molfile_node_get(s : ChemmolreprmolfileNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_molfile_node_set(s : ChemmolreprmolfileNode, i : Int, v : Double) -> ChemmolreprmolfileNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_node_sum(s : ChemmolreprmolfileNode) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_molfile_node_mean(s : ChemmolreprmolfileNode) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_molfile_node_scale(s : ChemmolreprmolfileNode, f : Double) -> ChemmolreprmolfileNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_node_add(a : ChemmolreprmolfileNode, b : ChemmolreprmolfileNode) -> ChemmolreprmolfileNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_molfile_node_copy(s : ChemmolreprmolfileNode) -> ChemmolreprmolfileNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_node_fill(s : ChemmolreprmolfileNode, v : Double) -> ChemmolreprmolfileNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_node_min(s : ChemmolreprmolfileNode) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_molfile_node_max(s : ChemmolreprmolfileNode) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_molfile_node_to_string(s : ChemmolreprmolfileNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprmolfileEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_molfile_edge_make(size : Int) -> ChemmolreprmolfileEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_molfile_edge_len(s : ChemmolreprmolfileEdge) -> Int { s.size }

pub fn chem_mol_repr_molfile_edge_get(s : ChemmolreprmolfileEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_molfile_edge_set(s : ChemmolreprmolfileEdge, i : Int, v : Double) -> ChemmolreprmolfileEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_edge_sum(s : ChemmolreprmolfileEdge) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_molfile_edge_mean(s : ChemmolreprmolfileEdge) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_molfile_edge_scale(s : ChemmolreprmolfileEdge, f : Double) -> ChemmolreprmolfileEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_edge_add(a : ChemmolreprmolfileEdge, b : ChemmolreprmolfileEdge) -> ChemmolreprmolfileEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_molfile_edge_copy(s : ChemmolreprmolfileEdge) -> ChemmolreprmolfileEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_edge_fill(s : ChemmolreprmolfileEdge, v : Double) -> ChemmolreprmolfileEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_edge_min(s : ChemmolreprmolfileEdge) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_molfile_edge_max(s : ChemmolreprmolfileEdge) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_molfile_edge_to_string(s : ChemmolreprmolfileEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprmolfilePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_molfile_path_make(size : Int) -> ChemmolreprmolfilePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_molfile_path_len(s : ChemmolreprmolfilePath) -> Int { s.size }

pub fn chem_mol_repr_molfile_path_get(s : ChemmolreprmolfilePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_molfile_path_set(s : ChemmolreprmolfilePath, i : Int, v : Double) -> ChemmolreprmolfilePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_path_sum(s : ChemmolreprmolfilePath) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_molfile_path_mean(s : ChemmolreprmolfilePath) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_molfile_path_scale(s : ChemmolreprmolfilePath, f : Double) -> ChemmolreprmolfilePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_path_add(a : ChemmolreprmolfilePath, b : ChemmolreprmolfilePath) -> ChemmolreprmolfilePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_molfile_path_copy(s : ChemmolreprmolfilePath) -> ChemmolreprmolfilePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_path_fill(s : ChemmolreprmolfilePath, v : Double) -> ChemmolreprmolfilePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_path_min(s : ChemmolreprmolfilePath) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_molfile_path_max(s : ChemmolreprmolfilePath) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_molfile_path_to_string(s : ChemmolreprmolfilePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprmolfileCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_molfile_cluster_make(size : Int) -> ChemmolreprmolfileCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_molfile_cluster_len(s : ChemmolreprmolfileCluster) -> Int { s.size }

pub fn chem_mol_repr_molfile_cluster_get(s : ChemmolreprmolfileCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_molfile_cluster_set(s : ChemmolreprmolfileCluster, i : Int, v : Double) -> ChemmolreprmolfileCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_cluster_sum(s : ChemmolreprmolfileCluster) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_molfile_cluster_mean(s : ChemmolreprmolfileCluster) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_molfile_cluster_scale(s : ChemmolreprmolfileCluster, f : Double) -> ChemmolreprmolfileCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_cluster_add(a : ChemmolreprmolfileCluster, b : ChemmolreprmolfileCluster) -> ChemmolreprmolfileCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_molfile_cluster_copy(s : ChemmolreprmolfileCluster) -> ChemmolreprmolfileCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_cluster_fill(s : ChemmolreprmolfileCluster, v : Double) -> ChemmolreprmolfileCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_cluster_min(s : ChemmolreprmolfileCluster) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_molfile_cluster_max(s : ChemmolreprmolfileCluster) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_molfile_cluster_to_string(s : ChemmolreprmolfileCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprmolfileModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_molfile_model_make(size : Int) -> ChemmolreprmolfileModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_molfile_model_len(s : ChemmolreprmolfileModel) -> Int { s.size }

pub fn chem_mol_repr_molfile_model_get(s : ChemmolreprmolfileModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_molfile_model_set(s : ChemmolreprmolfileModel, i : Int, v : Double) -> ChemmolreprmolfileModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_model_sum(s : ChemmolreprmolfileModel) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_molfile_model_mean(s : ChemmolreprmolfileModel) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_molfile_model_scale(s : ChemmolreprmolfileModel, f : Double) -> ChemmolreprmolfileModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_model_add(a : ChemmolreprmolfileModel, b : ChemmolreprmolfileModel) -> ChemmolreprmolfileModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_molfile_model_copy(s : ChemmolreprmolfileModel) -> ChemmolreprmolfileModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_model_fill(s : ChemmolreprmolfileModel, v : Double) -> ChemmolreprmolfileModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_model_min(s : ChemmolreprmolfileModel) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_molfile_model_max(s : ChemmolreprmolfileModel) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_molfile_model_to_string(s : ChemmolreprmolfileModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprmolfileLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_molfile_layer_make(size : Int) -> ChemmolreprmolfileLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_molfile_layer_len(s : ChemmolreprmolfileLayer) -> Int { s.size }

pub fn chem_mol_repr_molfile_layer_get(s : ChemmolreprmolfileLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_molfile_layer_set(s : ChemmolreprmolfileLayer, i : Int, v : Double) -> ChemmolreprmolfileLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_layer_sum(s : ChemmolreprmolfileLayer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_molfile_layer_mean(s : ChemmolreprmolfileLayer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_molfile_layer_scale(s : ChemmolreprmolfileLayer, f : Double) -> ChemmolreprmolfileLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_layer_add(a : ChemmolreprmolfileLayer, b : ChemmolreprmolfileLayer) -> ChemmolreprmolfileLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_molfile_layer_copy(s : ChemmolreprmolfileLayer) -> ChemmolreprmolfileLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_layer_fill(s : ChemmolreprmolfileLayer, v : Double) -> ChemmolreprmolfileLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_layer_min(s : ChemmolreprmolfileLayer) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_molfile_layer_max(s : ChemmolreprmolfileLayer) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_molfile_layer_to_string(s : ChemmolreprmolfileLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprmolfileBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_molfile_buffer_make(size : Int) -> ChemmolreprmolfileBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_molfile_buffer_len(s : ChemmolreprmolfileBuffer) -> Int { s.size }

pub fn chem_mol_repr_molfile_buffer_get(s : ChemmolreprmolfileBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_molfile_buffer_set(s : ChemmolreprmolfileBuffer, i : Int, v : Double) -> ChemmolreprmolfileBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_buffer_sum(s : ChemmolreprmolfileBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_molfile_buffer_mean(s : ChemmolreprmolfileBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_molfile_buffer_scale(s : ChemmolreprmolfileBuffer, f : Double) -> ChemmolreprmolfileBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_buffer_add(a : ChemmolreprmolfileBuffer, b : ChemmolreprmolfileBuffer) -> ChemmolreprmolfileBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_molfile_buffer_copy(s : ChemmolreprmolfileBuffer) -> ChemmolreprmolfileBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_buffer_fill(s : ChemmolreprmolfileBuffer, v : Double) -> ChemmolreprmolfileBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_buffer_min(s : ChemmolreprmolfileBuffer) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_molfile_buffer_max(s : ChemmolreprmolfileBuffer) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_molfile_buffer_to_string(s : ChemmolreprmolfileBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprmolfileCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_molfile_cursor_make(size : Int) -> ChemmolreprmolfileCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_molfile_cursor_len(s : ChemmolreprmolfileCursor) -> Int { s.size }

pub fn chem_mol_repr_molfile_cursor_get(s : ChemmolreprmolfileCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_molfile_cursor_set(s : ChemmolreprmolfileCursor, i : Int, v : Double) -> ChemmolreprmolfileCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_cursor_sum(s : ChemmolreprmolfileCursor) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_molfile_cursor_mean(s : ChemmolreprmolfileCursor) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_molfile_cursor_scale(s : ChemmolreprmolfileCursor, f : Double) -> ChemmolreprmolfileCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_cursor_add(a : ChemmolreprmolfileCursor, b : ChemmolreprmolfileCursor) -> ChemmolreprmolfileCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_molfile_cursor_copy(s : ChemmolreprmolfileCursor) -> ChemmolreprmolfileCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_cursor_fill(s : ChemmolreprmolfileCursor, v : Double) -> ChemmolreprmolfileCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_cursor_min(s : ChemmolreprmolfileCursor) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_molfile_cursor_max(s : ChemmolreprmolfileCursor) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_molfile_cursor_to_string(s : ChemmolreprmolfileCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprmolfileView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_molfile_view_make(size : Int) -> ChemmolreprmolfileView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_molfile_view_len(s : ChemmolreprmolfileView) -> Int { s.size }

pub fn chem_mol_repr_molfile_view_get(s : ChemmolreprmolfileView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_molfile_view_set(s : ChemmolreprmolfileView, i : Int, v : Double) -> ChemmolreprmolfileView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_view_sum(s : ChemmolreprmolfileView) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_molfile_view_mean(s : ChemmolreprmolfileView) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_molfile_view_scale(s : ChemmolreprmolfileView, f : Double) -> ChemmolreprmolfileView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_view_add(a : ChemmolreprmolfileView, b : ChemmolreprmolfileView) -> ChemmolreprmolfileView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_molfile_view_copy(s : ChemmolreprmolfileView) -> ChemmolreprmolfileView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_view_fill(s : ChemmolreprmolfileView, v : Double) -> ChemmolreprmolfileView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_view_min(s : ChemmolreprmolfileView) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_molfile_view_max(s : ChemmolreprmolfileView) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_molfile_view_to_string(s : ChemmolreprmolfileView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprmolfileRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_molfile_range_make(size : Int) -> ChemmolreprmolfileRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_molfile_range_len(s : ChemmolreprmolfileRange) -> Int { s.size }

pub fn chem_mol_repr_molfile_range_get(s : ChemmolreprmolfileRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_molfile_range_set(s : ChemmolreprmolfileRange, i : Int, v : Double) -> ChemmolreprmolfileRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_range_sum(s : ChemmolreprmolfileRange) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_molfile_range_mean(s : ChemmolreprmolfileRange) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_molfile_range_scale(s : ChemmolreprmolfileRange, f : Double) -> ChemmolreprmolfileRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_range_add(a : ChemmolreprmolfileRange, b : ChemmolreprmolfileRange) -> ChemmolreprmolfileRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_molfile_range_copy(s : ChemmolreprmolfileRange) -> ChemmolreprmolfileRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_range_fill(s : ChemmolreprmolfileRange, v : Double) -> ChemmolreprmolfileRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_range_min(s : ChemmolreprmolfileRange) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_molfile_range_max(s : ChemmolreprmolfileRange) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_molfile_range_to_string(s : ChemmolreprmolfileRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprmolfileSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_molfile_slice_make(size : Int) -> ChemmolreprmolfileSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_molfile_slice_len(s : ChemmolreprmolfileSlice) -> Int { s.size }

pub fn chem_mol_repr_molfile_slice_get(s : ChemmolreprmolfileSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_molfile_slice_set(s : ChemmolreprmolfileSlice, i : Int, v : Double) -> ChemmolreprmolfileSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_slice_sum(s : ChemmolreprmolfileSlice) -> Double { @_common.sum(s.data) }

pub fn chem_mol_repr_molfile_slice_mean(s : ChemmolreprmolfileSlice) -> Double { @_common.mean(s.data) }

pub fn chem_mol_repr_molfile_slice_scale(s : ChemmolreprmolfileSlice, f : Double) -> ChemmolreprmolfileSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_slice_add(a : ChemmolreprmolfileSlice, b : ChemmolreprmolfileSlice) -> ChemmolreprmolfileSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_mol_repr_molfile_slice_copy(s : ChemmolreprmolfileSlice) -> ChemmolreprmolfileSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_slice_fill(s : ChemmolreprmolfileSlice, v : Double) -> ChemmolreprmolfileSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_mol_repr_molfile_slice_min(s : ChemmolreprmolfileSlice) -> Double { @_common.min(s.data) }

pub fn chem_mol_repr_molfile_slice_max(s : ChemmolreprmolfileSlice) -> Double { @_common.max(s.data) }

pub fn chem_mol_repr_molfile_slice_to_string(s : ChemmolreprmolfileSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

