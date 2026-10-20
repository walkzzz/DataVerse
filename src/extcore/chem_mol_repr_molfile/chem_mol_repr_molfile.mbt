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

pub fn ChemmolreprmolfileFrame::len(self : ChemmolreprmolfileFrame) -> Int { self.size }

pub fn ChemmolreprmolfileFrame::get(self : ChemmolreprmolfileFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprmolfileFrame::set(self : ChemmolreprmolfileFrame, i : Int, v : Double) -> ChemmolreprmolfileFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileFrame::sum(self : ChemmolreprmolfileFrame) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprmolfileFrame::mean(self : ChemmolreprmolfileFrame) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprmolfileFrame::scale(self : ChemmolreprmolfileFrame, f : Double) -> ChemmolreprmolfileFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileFrame::add(self : ChemmolreprmolfileFrame, other : ChemmolreprmolfileFrame) -> ChemmolreprmolfileFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprmolfileFrame::copy(self : ChemmolreprmolfileFrame) -> ChemmolreprmolfileFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileFrame::fill(self : ChemmolreprmolfileFrame, v : Double) -> ChemmolreprmolfileFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileFrame::min(self : ChemmolreprmolfileFrame) -> Double { @_common.min(self.data) }

pub fn ChemmolreprmolfileFrame::max(self : ChemmolreprmolfileFrame) -> Double { @_common.max(self.data) }

pub fn ChemmolreprmolfileFrame::to_string(self : ChemmolreprmolfileFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprmolfileTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_molfile_table_make(size : Int) -> ChemmolreprmolfileTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprmolfileTable::len(self : ChemmolreprmolfileTable) -> Int { self.size }

pub fn ChemmolreprmolfileTable::get(self : ChemmolreprmolfileTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprmolfileTable::set(self : ChemmolreprmolfileTable, i : Int, v : Double) -> ChemmolreprmolfileTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileTable::sum(self : ChemmolreprmolfileTable) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprmolfileTable::mean(self : ChemmolreprmolfileTable) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprmolfileTable::scale(self : ChemmolreprmolfileTable, f : Double) -> ChemmolreprmolfileTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileTable::add(self : ChemmolreprmolfileTable, other : ChemmolreprmolfileTable) -> ChemmolreprmolfileTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprmolfileTable::copy(self : ChemmolreprmolfileTable) -> ChemmolreprmolfileTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileTable::fill(self : ChemmolreprmolfileTable, v : Double) -> ChemmolreprmolfileTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileTable::min(self : ChemmolreprmolfileTable) -> Double { @_common.min(self.data) }

pub fn ChemmolreprmolfileTable::max(self : ChemmolreprmolfileTable) -> Double { @_common.max(self.data) }

pub fn ChemmolreprmolfileTable::to_string(self : ChemmolreprmolfileTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprmolfileGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_molfile_graphn_make(size : Int) -> ChemmolreprmolfileGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprmolfileGraphN::len(self : ChemmolreprmolfileGraphN) -> Int { self.size }

pub fn ChemmolreprmolfileGraphN::get(self : ChemmolreprmolfileGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprmolfileGraphN::set(self : ChemmolreprmolfileGraphN, i : Int, v : Double) -> ChemmolreprmolfileGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileGraphN::sum(self : ChemmolreprmolfileGraphN) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprmolfileGraphN::mean(self : ChemmolreprmolfileGraphN) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprmolfileGraphN::scale(self : ChemmolreprmolfileGraphN, f : Double) -> ChemmolreprmolfileGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileGraphN::add(self : ChemmolreprmolfileGraphN, other : ChemmolreprmolfileGraphN) -> ChemmolreprmolfileGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprmolfileGraphN::copy(self : ChemmolreprmolfileGraphN) -> ChemmolreprmolfileGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileGraphN::fill(self : ChemmolreprmolfileGraphN, v : Double) -> ChemmolreprmolfileGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileGraphN::min(self : ChemmolreprmolfileGraphN) -> Double { @_common.min(self.data) }

pub fn ChemmolreprmolfileGraphN::max(self : ChemmolreprmolfileGraphN) -> Double { @_common.max(self.data) }

pub fn ChemmolreprmolfileGraphN::to_string(self : ChemmolreprmolfileGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprmolfileNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_molfile_node_make(size : Int) -> ChemmolreprmolfileNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprmolfileNode::len(self : ChemmolreprmolfileNode) -> Int { self.size }

pub fn ChemmolreprmolfileNode::get(self : ChemmolreprmolfileNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprmolfileNode::set(self : ChemmolreprmolfileNode, i : Int, v : Double) -> ChemmolreprmolfileNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileNode::sum(self : ChemmolreprmolfileNode) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprmolfileNode::mean(self : ChemmolreprmolfileNode) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprmolfileNode::scale(self : ChemmolreprmolfileNode, f : Double) -> ChemmolreprmolfileNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileNode::add(self : ChemmolreprmolfileNode, other : ChemmolreprmolfileNode) -> ChemmolreprmolfileNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprmolfileNode::copy(self : ChemmolreprmolfileNode) -> ChemmolreprmolfileNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileNode::fill(self : ChemmolreprmolfileNode, v : Double) -> ChemmolreprmolfileNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileNode::min(self : ChemmolreprmolfileNode) -> Double { @_common.min(self.data) }

pub fn ChemmolreprmolfileNode::max(self : ChemmolreprmolfileNode) -> Double { @_common.max(self.data) }

pub fn ChemmolreprmolfileNode::to_string(self : ChemmolreprmolfileNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprmolfileEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_molfile_edge_make(size : Int) -> ChemmolreprmolfileEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprmolfileEdge::len(self : ChemmolreprmolfileEdge) -> Int { self.size }

pub fn ChemmolreprmolfileEdge::get(self : ChemmolreprmolfileEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprmolfileEdge::set(self : ChemmolreprmolfileEdge, i : Int, v : Double) -> ChemmolreprmolfileEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileEdge::sum(self : ChemmolreprmolfileEdge) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprmolfileEdge::mean(self : ChemmolreprmolfileEdge) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprmolfileEdge::scale(self : ChemmolreprmolfileEdge, f : Double) -> ChemmolreprmolfileEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileEdge::add(self : ChemmolreprmolfileEdge, other : ChemmolreprmolfileEdge) -> ChemmolreprmolfileEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprmolfileEdge::copy(self : ChemmolreprmolfileEdge) -> ChemmolreprmolfileEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileEdge::fill(self : ChemmolreprmolfileEdge, v : Double) -> ChemmolreprmolfileEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileEdge::min(self : ChemmolreprmolfileEdge) -> Double { @_common.min(self.data) }

pub fn ChemmolreprmolfileEdge::max(self : ChemmolreprmolfileEdge) -> Double { @_common.max(self.data) }

pub fn ChemmolreprmolfileEdge::to_string(self : ChemmolreprmolfileEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprmolfilePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_molfile_path_make(size : Int) -> ChemmolreprmolfilePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprmolfilePath::len(self : ChemmolreprmolfilePath) -> Int { self.size }

pub fn ChemmolreprmolfilePath::get(self : ChemmolreprmolfilePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprmolfilePath::set(self : ChemmolreprmolfilePath, i : Int, v : Double) -> ChemmolreprmolfilePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfilePath::sum(self : ChemmolreprmolfilePath) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprmolfilePath::mean(self : ChemmolreprmolfilePath) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprmolfilePath::scale(self : ChemmolreprmolfilePath, f : Double) -> ChemmolreprmolfilePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfilePath::add(self : ChemmolreprmolfilePath, other : ChemmolreprmolfilePath) -> ChemmolreprmolfilePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprmolfilePath::copy(self : ChemmolreprmolfilePath) -> ChemmolreprmolfilePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfilePath::fill(self : ChemmolreprmolfilePath, v : Double) -> ChemmolreprmolfilePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfilePath::min(self : ChemmolreprmolfilePath) -> Double { @_common.min(self.data) }

pub fn ChemmolreprmolfilePath::max(self : ChemmolreprmolfilePath) -> Double { @_common.max(self.data) }

pub fn ChemmolreprmolfilePath::to_string(self : ChemmolreprmolfilePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprmolfileCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_molfile_cluster_make(size : Int) -> ChemmolreprmolfileCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprmolfileCluster::len(self : ChemmolreprmolfileCluster) -> Int { self.size }

pub fn ChemmolreprmolfileCluster::get(self : ChemmolreprmolfileCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprmolfileCluster::set(self : ChemmolreprmolfileCluster, i : Int, v : Double) -> ChemmolreprmolfileCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileCluster::sum(self : ChemmolreprmolfileCluster) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprmolfileCluster::mean(self : ChemmolreprmolfileCluster) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprmolfileCluster::scale(self : ChemmolreprmolfileCluster, f : Double) -> ChemmolreprmolfileCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileCluster::add(self : ChemmolreprmolfileCluster, other : ChemmolreprmolfileCluster) -> ChemmolreprmolfileCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprmolfileCluster::copy(self : ChemmolreprmolfileCluster) -> ChemmolreprmolfileCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileCluster::fill(self : ChemmolreprmolfileCluster, v : Double) -> ChemmolreprmolfileCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileCluster::min(self : ChemmolreprmolfileCluster) -> Double { @_common.min(self.data) }

pub fn ChemmolreprmolfileCluster::max(self : ChemmolreprmolfileCluster) -> Double { @_common.max(self.data) }

pub fn ChemmolreprmolfileCluster::to_string(self : ChemmolreprmolfileCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprmolfileModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_molfile_model_make(size : Int) -> ChemmolreprmolfileModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprmolfileModel::len(self : ChemmolreprmolfileModel) -> Int { self.size }

pub fn ChemmolreprmolfileModel::get(self : ChemmolreprmolfileModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprmolfileModel::set(self : ChemmolreprmolfileModel, i : Int, v : Double) -> ChemmolreprmolfileModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileModel::sum(self : ChemmolreprmolfileModel) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprmolfileModel::mean(self : ChemmolreprmolfileModel) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprmolfileModel::scale(self : ChemmolreprmolfileModel, f : Double) -> ChemmolreprmolfileModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileModel::add(self : ChemmolreprmolfileModel, other : ChemmolreprmolfileModel) -> ChemmolreprmolfileModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprmolfileModel::copy(self : ChemmolreprmolfileModel) -> ChemmolreprmolfileModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileModel::fill(self : ChemmolreprmolfileModel, v : Double) -> ChemmolreprmolfileModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileModel::min(self : ChemmolreprmolfileModel) -> Double { @_common.min(self.data) }

pub fn ChemmolreprmolfileModel::max(self : ChemmolreprmolfileModel) -> Double { @_common.max(self.data) }

pub fn ChemmolreprmolfileModel::to_string(self : ChemmolreprmolfileModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprmolfileLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_molfile_layer_make(size : Int) -> ChemmolreprmolfileLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprmolfileLayer::len(self : ChemmolreprmolfileLayer) -> Int { self.size }

pub fn ChemmolreprmolfileLayer::get(self : ChemmolreprmolfileLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprmolfileLayer::set(self : ChemmolreprmolfileLayer, i : Int, v : Double) -> ChemmolreprmolfileLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileLayer::sum(self : ChemmolreprmolfileLayer) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprmolfileLayer::mean(self : ChemmolreprmolfileLayer) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprmolfileLayer::scale(self : ChemmolreprmolfileLayer, f : Double) -> ChemmolreprmolfileLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileLayer::add(self : ChemmolreprmolfileLayer, other : ChemmolreprmolfileLayer) -> ChemmolreprmolfileLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprmolfileLayer::copy(self : ChemmolreprmolfileLayer) -> ChemmolreprmolfileLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileLayer::fill(self : ChemmolreprmolfileLayer, v : Double) -> ChemmolreprmolfileLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileLayer::min(self : ChemmolreprmolfileLayer) -> Double { @_common.min(self.data) }

pub fn ChemmolreprmolfileLayer::max(self : ChemmolreprmolfileLayer) -> Double { @_common.max(self.data) }

pub fn ChemmolreprmolfileLayer::to_string(self : ChemmolreprmolfileLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprmolfileBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_molfile_buffer_make(size : Int) -> ChemmolreprmolfileBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprmolfileBuffer::len(self : ChemmolreprmolfileBuffer) -> Int { self.size }

pub fn ChemmolreprmolfileBuffer::get(self : ChemmolreprmolfileBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprmolfileBuffer::set(self : ChemmolreprmolfileBuffer, i : Int, v : Double) -> ChemmolreprmolfileBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileBuffer::sum(self : ChemmolreprmolfileBuffer) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprmolfileBuffer::mean(self : ChemmolreprmolfileBuffer) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprmolfileBuffer::scale(self : ChemmolreprmolfileBuffer, f : Double) -> ChemmolreprmolfileBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileBuffer::add(self : ChemmolreprmolfileBuffer, other : ChemmolreprmolfileBuffer) -> ChemmolreprmolfileBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprmolfileBuffer::copy(self : ChemmolreprmolfileBuffer) -> ChemmolreprmolfileBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileBuffer::fill(self : ChemmolreprmolfileBuffer, v : Double) -> ChemmolreprmolfileBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileBuffer::min(self : ChemmolreprmolfileBuffer) -> Double { @_common.min(self.data) }

pub fn ChemmolreprmolfileBuffer::max(self : ChemmolreprmolfileBuffer) -> Double { @_common.max(self.data) }

pub fn ChemmolreprmolfileBuffer::to_string(self : ChemmolreprmolfileBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprmolfileCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_molfile_cursor_make(size : Int) -> ChemmolreprmolfileCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprmolfileCursor::len(self : ChemmolreprmolfileCursor) -> Int { self.size }

pub fn ChemmolreprmolfileCursor::get(self : ChemmolreprmolfileCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprmolfileCursor::set(self : ChemmolreprmolfileCursor, i : Int, v : Double) -> ChemmolreprmolfileCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileCursor::sum(self : ChemmolreprmolfileCursor) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprmolfileCursor::mean(self : ChemmolreprmolfileCursor) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprmolfileCursor::scale(self : ChemmolreprmolfileCursor, f : Double) -> ChemmolreprmolfileCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileCursor::add(self : ChemmolreprmolfileCursor, other : ChemmolreprmolfileCursor) -> ChemmolreprmolfileCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprmolfileCursor::copy(self : ChemmolreprmolfileCursor) -> ChemmolreprmolfileCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileCursor::fill(self : ChemmolreprmolfileCursor, v : Double) -> ChemmolreprmolfileCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileCursor::min(self : ChemmolreprmolfileCursor) -> Double { @_common.min(self.data) }

pub fn ChemmolreprmolfileCursor::max(self : ChemmolreprmolfileCursor) -> Double { @_common.max(self.data) }

pub fn ChemmolreprmolfileCursor::to_string(self : ChemmolreprmolfileCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprmolfileView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_molfile_view_make(size : Int) -> ChemmolreprmolfileView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprmolfileView::len(self : ChemmolreprmolfileView) -> Int { self.size }

pub fn ChemmolreprmolfileView::get(self : ChemmolreprmolfileView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprmolfileView::set(self : ChemmolreprmolfileView, i : Int, v : Double) -> ChemmolreprmolfileView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileView::sum(self : ChemmolreprmolfileView) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprmolfileView::mean(self : ChemmolreprmolfileView) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprmolfileView::scale(self : ChemmolreprmolfileView, f : Double) -> ChemmolreprmolfileView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileView::add(self : ChemmolreprmolfileView, other : ChemmolreprmolfileView) -> ChemmolreprmolfileView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprmolfileView::copy(self : ChemmolreprmolfileView) -> ChemmolreprmolfileView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileView::fill(self : ChemmolreprmolfileView, v : Double) -> ChemmolreprmolfileView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileView::min(self : ChemmolreprmolfileView) -> Double { @_common.min(self.data) }

pub fn ChemmolreprmolfileView::max(self : ChemmolreprmolfileView) -> Double { @_common.max(self.data) }

pub fn ChemmolreprmolfileView::to_string(self : ChemmolreprmolfileView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprmolfileRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_molfile_range_make(size : Int) -> ChemmolreprmolfileRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprmolfileRange::len(self : ChemmolreprmolfileRange) -> Int { self.size }

pub fn ChemmolreprmolfileRange::get(self : ChemmolreprmolfileRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprmolfileRange::set(self : ChemmolreprmolfileRange, i : Int, v : Double) -> ChemmolreprmolfileRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileRange::sum(self : ChemmolreprmolfileRange) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprmolfileRange::mean(self : ChemmolreprmolfileRange) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprmolfileRange::scale(self : ChemmolreprmolfileRange, f : Double) -> ChemmolreprmolfileRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileRange::add(self : ChemmolreprmolfileRange, other : ChemmolreprmolfileRange) -> ChemmolreprmolfileRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprmolfileRange::copy(self : ChemmolreprmolfileRange) -> ChemmolreprmolfileRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileRange::fill(self : ChemmolreprmolfileRange, v : Double) -> ChemmolreprmolfileRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileRange::min(self : ChemmolreprmolfileRange) -> Double { @_common.min(self.data) }

pub fn ChemmolreprmolfileRange::max(self : ChemmolreprmolfileRange) -> Double { @_common.max(self.data) }

pub fn ChemmolreprmolfileRange::to_string(self : ChemmolreprmolfileRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprmolfileSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_molfile_slice_make(size : Int) -> ChemmolreprmolfileSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprmolfileSlice::len(self : ChemmolreprmolfileSlice) -> Int { self.size }

pub fn ChemmolreprmolfileSlice::get(self : ChemmolreprmolfileSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprmolfileSlice::set(self : ChemmolreprmolfileSlice, i : Int, v : Double) -> ChemmolreprmolfileSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileSlice::sum(self : ChemmolreprmolfileSlice) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprmolfileSlice::mean(self : ChemmolreprmolfileSlice) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprmolfileSlice::scale(self : ChemmolreprmolfileSlice, f : Double) -> ChemmolreprmolfileSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileSlice::add(self : ChemmolreprmolfileSlice, other : ChemmolreprmolfileSlice) -> ChemmolreprmolfileSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprmolfileSlice::copy(self : ChemmolreprmolfileSlice) -> ChemmolreprmolfileSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileSlice::fill(self : ChemmolreprmolfileSlice, v : Double) -> ChemmolreprmolfileSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprmolfileSlice::min(self : ChemmolreprmolfileSlice) -> Double { @_common.min(self.data) }

pub fn ChemmolreprmolfileSlice::max(self : ChemmolreprmolfileSlice) -> Double { @_common.max(self.data) }

pub fn ChemmolreprmolfileSlice::to_string(self : ChemmolreprmolfileSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

