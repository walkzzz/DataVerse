///===
/// extcore/chem_mol_repr_pdb

pub(all) struct ChemmolreprpdbPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_mol_repr_pdb_make_point(x : Double, y : Double) -> ChemmolreprpdbPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_mol_repr_pdb_make_point3(x : Double, y : Double, z : Double) -> ChemmolreprpdbPoint {
  { x, y, z, label: 0 }
}

pub fn ChemmolreprpdbPoint::x(self : ChemmolreprpdbPoint) -> Double { self.x }

pub fn ChemmolreprpdbPoint::y(self : ChemmolreprpdbPoint) -> Double { self.y }

pub fn ChemmolreprpdbPoint::z(self : ChemmolreprpdbPoint) -> Double { self.z }

pub fn ChemmolreprpdbPoint::label(self : ChemmolreprpdbPoint) -> Int { self.label }

pub fn ChemmolreprpdbPoint::dist(self : ChemmolreprpdbPoint, other : ChemmolreprpdbPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemmolreprpdbPoint::add(self : ChemmolreprpdbPoint, other : ChemmolreprpdbPoint) -> ChemmolreprpdbPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemmolreprpdbPoint::sub(self : ChemmolreprpdbPoint, other : ChemmolreprpdbPoint) -> ChemmolreprpdbPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemmolreprpdbPoint::scale(self : ChemmolreprpdbPoint, s : Double) -> ChemmolreprpdbPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemmolreprpdbPoint::dot(self : ChemmolreprpdbPoint, other : ChemmolreprpdbPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemmolreprpdbPoint::cross(self : ChemmolreprpdbPoint, other : ChemmolreprpdbPoint) -> ChemmolreprpdbPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemmolreprpdbPoint::norm(self : ChemmolreprpdbPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemmolreprpdbPoint::normalize(self : ChemmolreprpdbPoint) -> ChemmolreprpdbPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolreprpdbPoint::negate(self : ChemmolreprpdbPoint) -> ChemmolreprpdbPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemmolreprpdbPoint::mid(self : ChemmolreprpdbPoint, other : ChemmolreprpdbPoint) -> ChemmolreprpdbPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemmolreprpdbPoint::lerp(self : ChemmolreprpdbPoint, other : ChemmolreprpdbPoint, t : Double) -> ChemmolreprpdbPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemmolreprpdbPoint::to_string(self : ChemmolreprpdbPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemmolreprpdbSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_mol_repr_pdb_make_series(vals : Array[Double], name : String) -> ChemmolreprpdbSeries {
  { vals, name, meta: 0 }
}

pub fn ChemmolreprpdbSeries::len(self : ChemmolreprpdbSeries) -> Int { self.vals.length() }

pub fn ChemmolreprpdbSeries::sum(self : ChemmolreprpdbSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemmolreprpdbSeries::mean(self : ChemmolreprpdbSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemmolreprpdbSeries::min(self : ChemmolreprpdbSeries) -> Double { @_common.min(self.vals) }

pub fn ChemmolreprpdbSeries::max(self : ChemmolreprpdbSeries) -> Double { @_common.max(self.vals) }

pub fn ChemmolreprpdbSeries::range(self : ChemmolreprpdbSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemmolreprpdbSeries::variance(self : ChemmolreprpdbSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemmolreprpdbSeries::std(self : ChemmolreprpdbSeries) -> Double { @_common.std(self.vals) }

pub fn ChemmolreprpdbSeries::median(self : ChemmolreprpdbSeries) -> Double { @_common.median(self.vals) }

pub fn ChemmolreprpdbSeries::scale(self : ChemmolreprpdbSeries, f : Double) -> ChemmolreprpdbSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemmolreprpdbSeries::add(self : ChemmolreprpdbSeries, other : ChemmolreprpdbSeries) -> ChemmolreprpdbSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemmolreprpdbSeries::sub(self : ChemmolreprpdbSeries, other : ChemmolreprpdbSeries) -> ChemmolreprpdbSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemmolreprpdbSeries::normalize(self : ChemmolreprpdbSeries) -> ChemmolreprpdbSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemmolreprpdbSeries::cumsum(self : ChemmolreprpdbSeries) -> ChemmolreprpdbSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemmolreprpdbSeries::to_string(self : ChemmolreprpdbSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolreprpdbMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_mol_repr_pdb_make_matrix(rows : Int, cols : Int, val : Double) -> ChemmolreprpdbMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_mol_repr_pdb_matrix_identity(n : Int) -> ChemmolreprpdbMatrix {
  let m = chem_mol_repr_pdb_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemmolreprpdbMatrix::get(self : ChemmolreprpdbMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemmolreprpdbMatrix::transpose(self : ChemmolreprpdbMatrix) -> ChemmolreprpdbMatrix {
  let result = chem_mol_repr_pdb_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemmolreprpdbMatrix::add(self : ChemmolreprpdbMatrix, other : ChemmolreprpdbMatrix) -> ChemmolreprpdbMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_mol_repr_pdb_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemmolreprpdbMatrix::scale(self : ChemmolreprpdbMatrix, s : Double) -> ChemmolreprpdbMatrix {
  let result = chem_mol_repr_pdb_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemmolreprpdbMatrix::multiply(self : ChemmolreprpdbMatrix, other : ChemmolreprpdbMatrix) -> ChemmolreprpdbMatrix {
  if self.cols != other.rows { return chem_mol_repr_pdb_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_mol_repr_pdb_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ChemmolreprpdbMatrix::trace(self : ChemmolreprpdbMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemmolreprpdbMatrix::det(self : ChemmolreprpdbMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemmolreprpdbMatrix::norm(self : ChemmolreprpdbMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemmolreprpdbMatrix::to_string(self : ChemmolreprpdbMatrix) -> String {
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

pub(all) struct ChemmolreprpdbVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_mol_repr_pdb_make_vector(comps : Array[Double]) -> ChemmolreprpdbVector {
  { comps, dim: comps.length() }
}

pub fn chem_mol_repr_pdb_vector_zero(dim : Int) -> ChemmolreprpdbVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemmolreprpdbVector::add(self : ChemmolreprpdbVector, other : ChemmolreprpdbVector) -> ChemmolreprpdbVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolreprpdbVector::sub(self : ChemmolreprpdbVector, other : ChemmolreprpdbVector) -> ChemmolreprpdbVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolreprpdbVector::scale(self : ChemmolreprpdbVector, s : Double) -> ChemmolreprpdbVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemmolreprpdbVector::dot(self : ChemmolreprpdbVector, other : ChemmolreprpdbVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemmolreprpdbVector::norm(self : ChemmolreprpdbVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemmolreprpdbVector::normalize(self : ChemmolreprpdbVector) -> ChemmolreprpdbVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolreprpdbVector::dist(self : ChemmolreprpdbVector, other : ChemmolreprpdbVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemmolreprpdbVector::to_string(self : ChemmolreprpdbVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_mol_repr_pdb_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_mol_repr_pdb_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_mol_repr_pdb_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_mol_repr_pdb_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_mol_repr_pdb_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_mol_repr_pdb_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_mol_repr_pdb_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_mol_repr_pdb_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_mol_repr_pdb_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_mol_repr_pdb_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_mol_repr_pdb_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_mol_repr_pdb_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_mol_repr_pdb_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_mol_repr_pdb_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_mol_repr_pdb_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_mol_repr_pdb_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_mol_repr_pdb_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_mol_repr_pdb_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_mol_repr_pdb_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_mol_repr_pdb_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_mol_repr_pdb_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_mol_repr_pdb_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_mol_repr_pdb_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_mol_repr_pdb_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_mol_repr_pdb_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_mol_repr_pdb_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_mol_repr_pdb_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_mol_repr_pdb_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_mol_repr_pdb_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemmolreprpdbFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_pdb_frame_make(size : Int) -> ChemmolreprpdbFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprpdbFrame::len(self : ChemmolreprpdbFrame) -> Int { self.size }

pub fn ChemmolreprpdbFrame::get(self : ChemmolreprpdbFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprpdbFrame::set(self : ChemmolreprpdbFrame, i : Int, v : Double) -> ChemmolreprpdbFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbFrame::sum(self : ChemmolreprpdbFrame) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprpdbFrame::mean(self : ChemmolreprpdbFrame) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprpdbFrame::scale(self : ChemmolreprpdbFrame, f : Double) -> ChemmolreprpdbFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbFrame::add(self : ChemmolreprpdbFrame, other : ChemmolreprpdbFrame) -> ChemmolreprpdbFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprpdbFrame::copy(self : ChemmolreprpdbFrame) -> ChemmolreprpdbFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbFrame::fill(self : ChemmolreprpdbFrame, v : Double) -> ChemmolreprpdbFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbFrame::min(self : ChemmolreprpdbFrame) -> Double { @_common.min(self.data) }

pub fn ChemmolreprpdbFrame::max(self : ChemmolreprpdbFrame) -> Double { @_common.max(self.data) }

pub fn ChemmolreprpdbFrame::to_string(self : ChemmolreprpdbFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprpdbTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_pdb_table_make(size : Int) -> ChemmolreprpdbTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprpdbTable::len(self : ChemmolreprpdbTable) -> Int { self.size }

pub fn ChemmolreprpdbTable::get(self : ChemmolreprpdbTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprpdbTable::set(self : ChemmolreprpdbTable, i : Int, v : Double) -> ChemmolreprpdbTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbTable::sum(self : ChemmolreprpdbTable) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprpdbTable::mean(self : ChemmolreprpdbTable) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprpdbTable::scale(self : ChemmolreprpdbTable, f : Double) -> ChemmolreprpdbTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbTable::add(self : ChemmolreprpdbTable, other : ChemmolreprpdbTable) -> ChemmolreprpdbTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprpdbTable::copy(self : ChemmolreprpdbTable) -> ChemmolreprpdbTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbTable::fill(self : ChemmolreprpdbTable, v : Double) -> ChemmolreprpdbTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbTable::min(self : ChemmolreprpdbTable) -> Double { @_common.min(self.data) }

pub fn ChemmolreprpdbTable::max(self : ChemmolreprpdbTable) -> Double { @_common.max(self.data) }

pub fn ChemmolreprpdbTable::to_string(self : ChemmolreprpdbTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprpdbGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_pdb_graphn_make(size : Int) -> ChemmolreprpdbGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprpdbGraphN::len(self : ChemmolreprpdbGraphN) -> Int { self.size }

pub fn ChemmolreprpdbGraphN::get(self : ChemmolreprpdbGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprpdbGraphN::set(self : ChemmolreprpdbGraphN, i : Int, v : Double) -> ChemmolreprpdbGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbGraphN::sum(self : ChemmolreprpdbGraphN) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprpdbGraphN::mean(self : ChemmolreprpdbGraphN) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprpdbGraphN::scale(self : ChemmolreprpdbGraphN, f : Double) -> ChemmolreprpdbGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbGraphN::add(self : ChemmolreprpdbGraphN, other : ChemmolreprpdbGraphN) -> ChemmolreprpdbGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprpdbGraphN::copy(self : ChemmolreprpdbGraphN) -> ChemmolreprpdbGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbGraphN::fill(self : ChemmolreprpdbGraphN, v : Double) -> ChemmolreprpdbGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbGraphN::min(self : ChemmolreprpdbGraphN) -> Double { @_common.min(self.data) }

pub fn ChemmolreprpdbGraphN::max(self : ChemmolreprpdbGraphN) -> Double { @_common.max(self.data) }

pub fn ChemmolreprpdbGraphN::to_string(self : ChemmolreprpdbGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprpdbNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_pdb_node_make(size : Int) -> ChemmolreprpdbNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprpdbNode::len(self : ChemmolreprpdbNode) -> Int { self.size }

pub fn ChemmolreprpdbNode::get(self : ChemmolreprpdbNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprpdbNode::set(self : ChemmolreprpdbNode, i : Int, v : Double) -> ChemmolreprpdbNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbNode::sum(self : ChemmolreprpdbNode) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprpdbNode::mean(self : ChemmolreprpdbNode) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprpdbNode::scale(self : ChemmolreprpdbNode, f : Double) -> ChemmolreprpdbNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbNode::add(self : ChemmolreprpdbNode, other : ChemmolreprpdbNode) -> ChemmolreprpdbNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprpdbNode::copy(self : ChemmolreprpdbNode) -> ChemmolreprpdbNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbNode::fill(self : ChemmolreprpdbNode, v : Double) -> ChemmolreprpdbNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbNode::min(self : ChemmolreprpdbNode) -> Double { @_common.min(self.data) }

pub fn ChemmolreprpdbNode::max(self : ChemmolreprpdbNode) -> Double { @_common.max(self.data) }

pub fn ChemmolreprpdbNode::to_string(self : ChemmolreprpdbNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprpdbEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_pdb_edge_make(size : Int) -> ChemmolreprpdbEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprpdbEdge::len(self : ChemmolreprpdbEdge) -> Int { self.size }

pub fn ChemmolreprpdbEdge::get(self : ChemmolreprpdbEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprpdbEdge::set(self : ChemmolreprpdbEdge, i : Int, v : Double) -> ChemmolreprpdbEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbEdge::sum(self : ChemmolreprpdbEdge) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprpdbEdge::mean(self : ChemmolreprpdbEdge) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprpdbEdge::scale(self : ChemmolreprpdbEdge, f : Double) -> ChemmolreprpdbEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbEdge::add(self : ChemmolreprpdbEdge, other : ChemmolreprpdbEdge) -> ChemmolreprpdbEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprpdbEdge::copy(self : ChemmolreprpdbEdge) -> ChemmolreprpdbEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbEdge::fill(self : ChemmolreprpdbEdge, v : Double) -> ChemmolreprpdbEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbEdge::min(self : ChemmolreprpdbEdge) -> Double { @_common.min(self.data) }

pub fn ChemmolreprpdbEdge::max(self : ChemmolreprpdbEdge) -> Double { @_common.max(self.data) }

pub fn ChemmolreprpdbEdge::to_string(self : ChemmolreprpdbEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprpdbPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_pdb_path_make(size : Int) -> ChemmolreprpdbPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprpdbPath::len(self : ChemmolreprpdbPath) -> Int { self.size }

pub fn ChemmolreprpdbPath::get(self : ChemmolreprpdbPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprpdbPath::set(self : ChemmolreprpdbPath, i : Int, v : Double) -> ChemmolreprpdbPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbPath::sum(self : ChemmolreprpdbPath) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprpdbPath::mean(self : ChemmolreprpdbPath) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprpdbPath::scale(self : ChemmolreprpdbPath, f : Double) -> ChemmolreprpdbPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbPath::add(self : ChemmolreprpdbPath, other : ChemmolreprpdbPath) -> ChemmolreprpdbPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprpdbPath::copy(self : ChemmolreprpdbPath) -> ChemmolreprpdbPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbPath::fill(self : ChemmolreprpdbPath, v : Double) -> ChemmolreprpdbPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbPath::min(self : ChemmolreprpdbPath) -> Double { @_common.min(self.data) }

pub fn ChemmolreprpdbPath::max(self : ChemmolreprpdbPath) -> Double { @_common.max(self.data) }

pub fn ChemmolreprpdbPath::to_string(self : ChemmolreprpdbPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprpdbCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_pdb_cluster_make(size : Int) -> ChemmolreprpdbCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprpdbCluster::len(self : ChemmolreprpdbCluster) -> Int { self.size }

pub fn ChemmolreprpdbCluster::get(self : ChemmolreprpdbCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprpdbCluster::set(self : ChemmolreprpdbCluster, i : Int, v : Double) -> ChemmolreprpdbCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbCluster::sum(self : ChemmolreprpdbCluster) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprpdbCluster::mean(self : ChemmolreprpdbCluster) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprpdbCluster::scale(self : ChemmolreprpdbCluster, f : Double) -> ChemmolreprpdbCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbCluster::add(self : ChemmolreprpdbCluster, other : ChemmolreprpdbCluster) -> ChemmolreprpdbCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprpdbCluster::copy(self : ChemmolreprpdbCluster) -> ChemmolreprpdbCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbCluster::fill(self : ChemmolreprpdbCluster, v : Double) -> ChemmolreprpdbCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbCluster::min(self : ChemmolreprpdbCluster) -> Double { @_common.min(self.data) }

pub fn ChemmolreprpdbCluster::max(self : ChemmolreprpdbCluster) -> Double { @_common.max(self.data) }

pub fn ChemmolreprpdbCluster::to_string(self : ChemmolreprpdbCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprpdbModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_pdb_model_make(size : Int) -> ChemmolreprpdbModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprpdbModel::len(self : ChemmolreprpdbModel) -> Int { self.size }

pub fn ChemmolreprpdbModel::get(self : ChemmolreprpdbModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprpdbModel::set(self : ChemmolreprpdbModel, i : Int, v : Double) -> ChemmolreprpdbModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbModel::sum(self : ChemmolreprpdbModel) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprpdbModel::mean(self : ChemmolreprpdbModel) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprpdbModel::scale(self : ChemmolreprpdbModel, f : Double) -> ChemmolreprpdbModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbModel::add(self : ChemmolreprpdbModel, other : ChemmolreprpdbModel) -> ChemmolreprpdbModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprpdbModel::copy(self : ChemmolreprpdbModel) -> ChemmolreprpdbModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbModel::fill(self : ChemmolreprpdbModel, v : Double) -> ChemmolreprpdbModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbModel::min(self : ChemmolreprpdbModel) -> Double { @_common.min(self.data) }

pub fn ChemmolreprpdbModel::max(self : ChemmolreprpdbModel) -> Double { @_common.max(self.data) }

pub fn ChemmolreprpdbModel::to_string(self : ChemmolreprpdbModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprpdbLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_pdb_layer_make(size : Int) -> ChemmolreprpdbLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprpdbLayer::len(self : ChemmolreprpdbLayer) -> Int { self.size }

pub fn ChemmolreprpdbLayer::get(self : ChemmolreprpdbLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprpdbLayer::set(self : ChemmolreprpdbLayer, i : Int, v : Double) -> ChemmolreprpdbLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbLayer::sum(self : ChemmolreprpdbLayer) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprpdbLayer::mean(self : ChemmolreprpdbLayer) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprpdbLayer::scale(self : ChemmolreprpdbLayer, f : Double) -> ChemmolreprpdbLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbLayer::add(self : ChemmolreprpdbLayer, other : ChemmolreprpdbLayer) -> ChemmolreprpdbLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprpdbLayer::copy(self : ChemmolreprpdbLayer) -> ChemmolreprpdbLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbLayer::fill(self : ChemmolreprpdbLayer, v : Double) -> ChemmolreprpdbLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbLayer::min(self : ChemmolreprpdbLayer) -> Double { @_common.min(self.data) }

pub fn ChemmolreprpdbLayer::max(self : ChemmolreprpdbLayer) -> Double { @_common.max(self.data) }

pub fn ChemmolreprpdbLayer::to_string(self : ChemmolreprpdbLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprpdbBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_pdb_buffer_make(size : Int) -> ChemmolreprpdbBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprpdbBuffer::len(self : ChemmolreprpdbBuffer) -> Int { self.size }

pub fn ChemmolreprpdbBuffer::get(self : ChemmolreprpdbBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprpdbBuffer::set(self : ChemmolreprpdbBuffer, i : Int, v : Double) -> ChemmolreprpdbBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbBuffer::sum(self : ChemmolreprpdbBuffer) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprpdbBuffer::mean(self : ChemmolreprpdbBuffer) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprpdbBuffer::scale(self : ChemmolreprpdbBuffer, f : Double) -> ChemmolreprpdbBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbBuffer::add(self : ChemmolreprpdbBuffer, other : ChemmolreprpdbBuffer) -> ChemmolreprpdbBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprpdbBuffer::copy(self : ChemmolreprpdbBuffer) -> ChemmolreprpdbBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbBuffer::fill(self : ChemmolreprpdbBuffer, v : Double) -> ChemmolreprpdbBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbBuffer::min(self : ChemmolreprpdbBuffer) -> Double { @_common.min(self.data) }

pub fn ChemmolreprpdbBuffer::max(self : ChemmolreprpdbBuffer) -> Double { @_common.max(self.data) }

pub fn ChemmolreprpdbBuffer::to_string(self : ChemmolreprpdbBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprpdbCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_pdb_cursor_make(size : Int) -> ChemmolreprpdbCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprpdbCursor::len(self : ChemmolreprpdbCursor) -> Int { self.size }

pub fn ChemmolreprpdbCursor::get(self : ChemmolreprpdbCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprpdbCursor::set(self : ChemmolreprpdbCursor, i : Int, v : Double) -> ChemmolreprpdbCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbCursor::sum(self : ChemmolreprpdbCursor) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprpdbCursor::mean(self : ChemmolreprpdbCursor) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprpdbCursor::scale(self : ChemmolreprpdbCursor, f : Double) -> ChemmolreprpdbCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbCursor::add(self : ChemmolreprpdbCursor, other : ChemmolreprpdbCursor) -> ChemmolreprpdbCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprpdbCursor::copy(self : ChemmolreprpdbCursor) -> ChemmolreprpdbCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbCursor::fill(self : ChemmolreprpdbCursor, v : Double) -> ChemmolreprpdbCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbCursor::min(self : ChemmolreprpdbCursor) -> Double { @_common.min(self.data) }

pub fn ChemmolreprpdbCursor::max(self : ChemmolreprpdbCursor) -> Double { @_common.max(self.data) }

pub fn ChemmolreprpdbCursor::to_string(self : ChemmolreprpdbCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprpdbView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_pdb_view_make(size : Int) -> ChemmolreprpdbView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprpdbView::len(self : ChemmolreprpdbView) -> Int { self.size }

pub fn ChemmolreprpdbView::get(self : ChemmolreprpdbView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprpdbView::set(self : ChemmolreprpdbView, i : Int, v : Double) -> ChemmolreprpdbView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbView::sum(self : ChemmolreprpdbView) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprpdbView::mean(self : ChemmolreprpdbView) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprpdbView::scale(self : ChemmolreprpdbView, f : Double) -> ChemmolreprpdbView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbView::add(self : ChemmolreprpdbView, other : ChemmolreprpdbView) -> ChemmolreprpdbView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprpdbView::copy(self : ChemmolreprpdbView) -> ChemmolreprpdbView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbView::fill(self : ChemmolreprpdbView, v : Double) -> ChemmolreprpdbView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbView::min(self : ChemmolreprpdbView) -> Double { @_common.min(self.data) }

pub fn ChemmolreprpdbView::max(self : ChemmolreprpdbView) -> Double { @_common.max(self.data) }

pub fn ChemmolreprpdbView::to_string(self : ChemmolreprpdbView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprpdbRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_pdb_range_make(size : Int) -> ChemmolreprpdbRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprpdbRange::len(self : ChemmolreprpdbRange) -> Int { self.size }

pub fn ChemmolreprpdbRange::get(self : ChemmolreprpdbRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprpdbRange::set(self : ChemmolreprpdbRange, i : Int, v : Double) -> ChemmolreprpdbRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbRange::sum(self : ChemmolreprpdbRange) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprpdbRange::mean(self : ChemmolreprpdbRange) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprpdbRange::scale(self : ChemmolreprpdbRange, f : Double) -> ChemmolreprpdbRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbRange::add(self : ChemmolreprpdbRange, other : ChemmolreprpdbRange) -> ChemmolreprpdbRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprpdbRange::copy(self : ChemmolreprpdbRange) -> ChemmolreprpdbRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbRange::fill(self : ChemmolreprpdbRange, v : Double) -> ChemmolreprpdbRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbRange::min(self : ChemmolreprpdbRange) -> Double { @_common.min(self.data) }

pub fn ChemmolreprpdbRange::max(self : ChemmolreprpdbRange) -> Double { @_common.max(self.data) }

pub fn ChemmolreprpdbRange::to_string(self : ChemmolreprpdbRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprpdbSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_pdb_slice_make(size : Int) -> ChemmolreprpdbSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprpdbSlice::len(self : ChemmolreprpdbSlice) -> Int { self.size }

pub fn ChemmolreprpdbSlice::get(self : ChemmolreprpdbSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprpdbSlice::set(self : ChemmolreprpdbSlice, i : Int, v : Double) -> ChemmolreprpdbSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbSlice::sum(self : ChemmolreprpdbSlice) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprpdbSlice::mean(self : ChemmolreprpdbSlice) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprpdbSlice::scale(self : ChemmolreprpdbSlice, f : Double) -> ChemmolreprpdbSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbSlice::add(self : ChemmolreprpdbSlice, other : ChemmolreprpdbSlice) -> ChemmolreprpdbSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprpdbSlice::copy(self : ChemmolreprpdbSlice) -> ChemmolreprpdbSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbSlice::fill(self : ChemmolreprpdbSlice, v : Double) -> ChemmolreprpdbSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprpdbSlice::min(self : ChemmolreprpdbSlice) -> Double { @_common.min(self.data) }

pub fn ChemmolreprpdbSlice::max(self : ChemmolreprpdbSlice) -> Double { @_common.max(self.data) }

pub fn ChemmolreprpdbSlice::to_string(self : ChemmolreprpdbSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

