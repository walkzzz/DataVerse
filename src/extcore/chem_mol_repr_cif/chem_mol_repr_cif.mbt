///===
/// extcore/chem_mol_repr_cif

pub(all) struct ChemmolreprcifPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_mol_repr_cif_make_point(x : Double, y : Double) -> ChemmolreprcifPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_mol_repr_cif_make_point3(x : Double, y : Double, z : Double) -> ChemmolreprcifPoint {
  { x, y, z, label: 0 }
}

pub fn ChemmolreprcifPoint::x(self : ChemmolreprcifPoint) -> Double { self.x }

pub fn ChemmolreprcifPoint::y(self : ChemmolreprcifPoint) -> Double { self.y }

pub fn ChemmolreprcifPoint::z(self : ChemmolreprcifPoint) -> Double { self.z }

pub fn ChemmolreprcifPoint::label(self : ChemmolreprcifPoint) -> Int { self.label }

pub fn ChemmolreprcifPoint::dist(self : ChemmolreprcifPoint, other : ChemmolreprcifPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemmolreprcifPoint::add(self : ChemmolreprcifPoint, other : ChemmolreprcifPoint) -> ChemmolreprcifPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemmolreprcifPoint::sub(self : ChemmolreprcifPoint, other : ChemmolreprcifPoint) -> ChemmolreprcifPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemmolreprcifPoint::scale(self : ChemmolreprcifPoint, s : Double) -> ChemmolreprcifPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemmolreprcifPoint::dot(self : ChemmolreprcifPoint, other : ChemmolreprcifPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemmolreprcifPoint::cross(self : ChemmolreprcifPoint, other : ChemmolreprcifPoint) -> ChemmolreprcifPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemmolreprcifPoint::norm(self : ChemmolreprcifPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemmolreprcifPoint::normalize(self : ChemmolreprcifPoint) -> ChemmolreprcifPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolreprcifPoint::negate(self : ChemmolreprcifPoint) -> ChemmolreprcifPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemmolreprcifPoint::mid(self : ChemmolreprcifPoint, other : ChemmolreprcifPoint) -> ChemmolreprcifPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemmolreprcifPoint::lerp(self : ChemmolreprcifPoint, other : ChemmolreprcifPoint, t : Double) -> ChemmolreprcifPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemmolreprcifPoint::to_string(self : ChemmolreprcifPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemmolreprcifSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_mol_repr_cif_make_series(vals : Array[Double], name : String) -> ChemmolreprcifSeries {
  { vals, name, meta: 0 }
}

pub fn ChemmolreprcifSeries::len(self : ChemmolreprcifSeries) -> Int { self.vals.length() }

pub fn ChemmolreprcifSeries::sum(self : ChemmolreprcifSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemmolreprcifSeries::mean(self : ChemmolreprcifSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemmolreprcifSeries::min(self : ChemmolreprcifSeries) -> Double { @_common.min(self.vals) }

pub fn ChemmolreprcifSeries::max(self : ChemmolreprcifSeries) -> Double { @_common.max(self.vals) }

pub fn ChemmolreprcifSeries::range(self : ChemmolreprcifSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemmolreprcifSeries::variance(self : ChemmolreprcifSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemmolreprcifSeries::std(self : ChemmolreprcifSeries) -> Double { @_common.std(self.vals) }

pub fn ChemmolreprcifSeries::median(self : ChemmolreprcifSeries) -> Double { @_common.median(self.vals) }

pub fn ChemmolreprcifSeries::scale(self : ChemmolreprcifSeries, f : Double) -> ChemmolreprcifSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemmolreprcifSeries::add(self : ChemmolreprcifSeries, other : ChemmolreprcifSeries) -> ChemmolreprcifSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemmolreprcifSeries::sub(self : ChemmolreprcifSeries, other : ChemmolreprcifSeries) -> ChemmolreprcifSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemmolreprcifSeries::normalize(self : ChemmolreprcifSeries) -> ChemmolreprcifSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemmolreprcifSeries::cumsum(self : ChemmolreprcifSeries) -> ChemmolreprcifSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemmolreprcifSeries::to_string(self : ChemmolreprcifSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolreprcifMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_mol_repr_cif_make_matrix(rows : Int, cols : Int, val : Double) -> ChemmolreprcifMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_mol_repr_cif_matrix_identity(n : Int) -> ChemmolreprcifMatrix {
  let m = chem_mol_repr_cif_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemmolreprcifMatrix::get(self : ChemmolreprcifMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemmolreprcifMatrix::transpose(self : ChemmolreprcifMatrix) -> ChemmolreprcifMatrix {
  let result = chem_mol_repr_cif_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemmolreprcifMatrix::add(self : ChemmolreprcifMatrix, other : ChemmolreprcifMatrix) -> ChemmolreprcifMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_mol_repr_cif_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemmolreprcifMatrix::scale(self : ChemmolreprcifMatrix, s : Double) -> ChemmolreprcifMatrix {
  let result = chem_mol_repr_cif_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemmolreprcifMatrix::multiply(self : ChemmolreprcifMatrix, other : ChemmolreprcifMatrix) -> ChemmolreprcifMatrix {
  if self.cols != other.rows { return chem_mol_repr_cif_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_mol_repr_cif_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ChemmolreprcifMatrix::trace(self : ChemmolreprcifMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemmolreprcifMatrix::det(self : ChemmolreprcifMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemmolreprcifMatrix::norm(self : ChemmolreprcifMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemmolreprcifMatrix::to_string(self : ChemmolreprcifMatrix) -> String {
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

pub(all) struct ChemmolreprcifVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_mol_repr_cif_make_vector(comps : Array[Double]) -> ChemmolreprcifVector {
  { comps, dim: comps.length() }
}

pub fn chem_mol_repr_cif_vector_zero(dim : Int) -> ChemmolreprcifVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemmolreprcifVector::add(self : ChemmolreprcifVector, other : ChemmolreprcifVector) -> ChemmolreprcifVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolreprcifVector::sub(self : ChemmolreprcifVector, other : ChemmolreprcifVector) -> ChemmolreprcifVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemmolreprcifVector::scale(self : ChemmolreprcifVector, s : Double) -> ChemmolreprcifVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemmolreprcifVector::dot(self : ChemmolreprcifVector, other : ChemmolreprcifVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemmolreprcifVector::norm(self : ChemmolreprcifVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemmolreprcifVector::normalize(self : ChemmolreprcifVector) -> ChemmolreprcifVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemmolreprcifVector::dist(self : ChemmolreprcifVector, other : ChemmolreprcifVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemmolreprcifVector::to_string(self : ChemmolreprcifVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_mol_repr_cif_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_mol_repr_cif_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_mol_repr_cif_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_mol_repr_cif_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_mol_repr_cif_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_mol_repr_cif_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_mol_repr_cif_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_mol_repr_cif_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_mol_repr_cif_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_mol_repr_cif_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_mol_repr_cif_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_mol_repr_cif_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_mol_repr_cif_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_mol_repr_cif_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_mol_repr_cif_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_mol_repr_cif_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_mol_repr_cif_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_mol_repr_cif_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_mol_repr_cif_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_mol_repr_cif_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_mol_repr_cif_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_mol_repr_cif_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_mol_repr_cif_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_mol_repr_cif_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_mol_repr_cif_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_mol_repr_cif_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_mol_repr_cif_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_mol_repr_cif_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_mol_repr_cif_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemmolreprcifFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_frame_make(size : Int) -> ChemmolreprcifFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprcifFrame::len(self : ChemmolreprcifFrame) -> Int { self.size }

pub fn ChemmolreprcifFrame::get(self : ChemmolreprcifFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprcifFrame::set(self : ChemmolreprcifFrame, i : Int, v : Double) -> ChemmolreprcifFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifFrame::sum(self : ChemmolreprcifFrame) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprcifFrame::mean(self : ChemmolreprcifFrame) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprcifFrame::scale(self : ChemmolreprcifFrame, f : Double) -> ChemmolreprcifFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifFrame::add(self : ChemmolreprcifFrame, other : ChemmolreprcifFrame) -> ChemmolreprcifFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprcifFrame::copy(self : ChemmolreprcifFrame) -> ChemmolreprcifFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifFrame::fill(self : ChemmolreprcifFrame, v : Double) -> ChemmolreprcifFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifFrame::min(self : ChemmolreprcifFrame) -> Double { @_common.min(self.data) }

pub fn ChemmolreprcifFrame::max(self : ChemmolreprcifFrame) -> Double { @_common.max(self.data) }

pub fn ChemmolreprcifFrame::to_string(self : ChemmolreprcifFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_table_make(size : Int) -> ChemmolreprcifTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprcifTable::len(self : ChemmolreprcifTable) -> Int { self.size }

pub fn ChemmolreprcifTable::get(self : ChemmolreprcifTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprcifTable::set(self : ChemmolreprcifTable, i : Int, v : Double) -> ChemmolreprcifTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifTable::sum(self : ChemmolreprcifTable) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprcifTable::mean(self : ChemmolreprcifTable) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprcifTable::scale(self : ChemmolreprcifTable, f : Double) -> ChemmolreprcifTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifTable::add(self : ChemmolreprcifTable, other : ChemmolreprcifTable) -> ChemmolreprcifTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprcifTable::copy(self : ChemmolreprcifTable) -> ChemmolreprcifTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifTable::fill(self : ChemmolreprcifTable, v : Double) -> ChemmolreprcifTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifTable::min(self : ChemmolreprcifTable) -> Double { @_common.min(self.data) }

pub fn ChemmolreprcifTable::max(self : ChemmolreprcifTable) -> Double { @_common.max(self.data) }

pub fn ChemmolreprcifTable::to_string(self : ChemmolreprcifTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_graphn_make(size : Int) -> ChemmolreprcifGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprcifGraphN::len(self : ChemmolreprcifGraphN) -> Int { self.size }

pub fn ChemmolreprcifGraphN::get(self : ChemmolreprcifGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprcifGraphN::set(self : ChemmolreprcifGraphN, i : Int, v : Double) -> ChemmolreprcifGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifGraphN::sum(self : ChemmolreprcifGraphN) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprcifGraphN::mean(self : ChemmolreprcifGraphN) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprcifGraphN::scale(self : ChemmolreprcifGraphN, f : Double) -> ChemmolreprcifGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifGraphN::add(self : ChemmolreprcifGraphN, other : ChemmolreprcifGraphN) -> ChemmolreprcifGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprcifGraphN::copy(self : ChemmolreprcifGraphN) -> ChemmolreprcifGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifGraphN::fill(self : ChemmolreprcifGraphN, v : Double) -> ChemmolreprcifGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifGraphN::min(self : ChemmolreprcifGraphN) -> Double { @_common.min(self.data) }

pub fn ChemmolreprcifGraphN::max(self : ChemmolreprcifGraphN) -> Double { @_common.max(self.data) }

pub fn ChemmolreprcifGraphN::to_string(self : ChemmolreprcifGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_node_make(size : Int) -> ChemmolreprcifNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprcifNode::len(self : ChemmolreprcifNode) -> Int { self.size }

pub fn ChemmolreprcifNode::get(self : ChemmolreprcifNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprcifNode::set(self : ChemmolreprcifNode, i : Int, v : Double) -> ChemmolreprcifNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifNode::sum(self : ChemmolreprcifNode) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprcifNode::mean(self : ChemmolreprcifNode) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprcifNode::scale(self : ChemmolreprcifNode, f : Double) -> ChemmolreprcifNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifNode::add(self : ChemmolreprcifNode, other : ChemmolreprcifNode) -> ChemmolreprcifNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprcifNode::copy(self : ChemmolreprcifNode) -> ChemmolreprcifNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifNode::fill(self : ChemmolreprcifNode, v : Double) -> ChemmolreprcifNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifNode::min(self : ChemmolreprcifNode) -> Double { @_common.min(self.data) }

pub fn ChemmolreprcifNode::max(self : ChemmolreprcifNode) -> Double { @_common.max(self.data) }

pub fn ChemmolreprcifNode::to_string(self : ChemmolreprcifNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_edge_make(size : Int) -> ChemmolreprcifEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprcifEdge::len(self : ChemmolreprcifEdge) -> Int { self.size }

pub fn ChemmolreprcifEdge::get(self : ChemmolreprcifEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprcifEdge::set(self : ChemmolreprcifEdge, i : Int, v : Double) -> ChemmolreprcifEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifEdge::sum(self : ChemmolreprcifEdge) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprcifEdge::mean(self : ChemmolreprcifEdge) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprcifEdge::scale(self : ChemmolreprcifEdge, f : Double) -> ChemmolreprcifEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifEdge::add(self : ChemmolreprcifEdge, other : ChemmolreprcifEdge) -> ChemmolreprcifEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprcifEdge::copy(self : ChemmolreprcifEdge) -> ChemmolreprcifEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifEdge::fill(self : ChemmolreprcifEdge, v : Double) -> ChemmolreprcifEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifEdge::min(self : ChemmolreprcifEdge) -> Double { @_common.min(self.data) }

pub fn ChemmolreprcifEdge::max(self : ChemmolreprcifEdge) -> Double { @_common.max(self.data) }

pub fn ChemmolreprcifEdge::to_string(self : ChemmolreprcifEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_path_make(size : Int) -> ChemmolreprcifPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprcifPath::len(self : ChemmolreprcifPath) -> Int { self.size }

pub fn ChemmolreprcifPath::get(self : ChemmolreprcifPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprcifPath::set(self : ChemmolreprcifPath, i : Int, v : Double) -> ChemmolreprcifPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifPath::sum(self : ChemmolreprcifPath) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprcifPath::mean(self : ChemmolreprcifPath) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprcifPath::scale(self : ChemmolreprcifPath, f : Double) -> ChemmolreprcifPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifPath::add(self : ChemmolreprcifPath, other : ChemmolreprcifPath) -> ChemmolreprcifPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprcifPath::copy(self : ChemmolreprcifPath) -> ChemmolreprcifPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifPath::fill(self : ChemmolreprcifPath, v : Double) -> ChemmolreprcifPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifPath::min(self : ChemmolreprcifPath) -> Double { @_common.min(self.data) }

pub fn ChemmolreprcifPath::max(self : ChemmolreprcifPath) -> Double { @_common.max(self.data) }

pub fn ChemmolreprcifPath::to_string(self : ChemmolreprcifPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_cluster_make(size : Int) -> ChemmolreprcifCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprcifCluster::len(self : ChemmolreprcifCluster) -> Int { self.size }

pub fn ChemmolreprcifCluster::get(self : ChemmolreprcifCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprcifCluster::set(self : ChemmolreprcifCluster, i : Int, v : Double) -> ChemmolreprcifCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifCluster::sum(self : ChemmolreprcifCluster) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprcifCluster::mean(self : ChemmolreprcifCluster) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprcifCluster::scale(self : ChemmolreprcifCluster, f : Double) -> ChemmolreprcifCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifCluster::add(self : ChemmolreprcifCluster, other : ChemmolreprcifCluster) -> ChemmolreprcifCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprcifCluster::copy(self : ChemmolreprcifCluster) -> ChemmolreprcifCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifCluster::fill(self : ChemmolreprcifCluster, v : Double) -> ChemmolreprcifCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifCluster::min(self : ChemmolreprcifCluster) -> Double { @_common.min(self.data) }

pub fn ChemmolreprcifCluster::max(self : ChemmolreprcifCluster) -> Double { @_common.max(self.data) }

pub fn ChemmolreprcifCluster::to_string(self : ChemmolreprcifCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_model_make(size : Int) -> ChemmolreprcifModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprcifModel::len(self : ChemmolreprcifModel) -> Int { self.size }

pub fn ChemmolreprcifModel::get(self : ChemmolreprcifModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprcifModel::set(self : ChemmolreprcifModel, i : Int, v : Double) -> ChemmolreprcifModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifModel::sum(self : ChemmolreprcifModel) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprcifModel::mean(self : ChemmolreprcifModel) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprcifModel::scale(self : ChemmolreprcifModel, f : Double) -> ChemmolreprcifModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifModel::add(self : ChemmolreprcifModel, other : ChemmolreprcifModel) -> ChemmolreprcifModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprcifModel::copy(self : ChemmolreprcifModel) -> ChemmolreprcifModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifModel::fill(self : ChemmolreprcifModel, v : Double) -> ChemmolreprcifModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifModel::min(self : ChemmolreprcifModel) -> Double { @_common.min(self.data) }

pub fn ChemmolreprcifModel::max(self : ChemmolreprcifModel) -> Double { @_common.max(self.data) }

pub fn ChemmolreprcifModel::to_string(self : ChemmolreprcifModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_layer_make(size : Int) -> ChemmolreprcifLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprcifLayer::len(self : ChemmolreprcifLayer) -> Int { self.size }

pub fn ChemmolreprcifLayer::get(self : ChemmolreprcifLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprcifLayer::set(self : ChemmolreprcifLayer, i : Int, v : Double) -> ChemmolreprcifLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifLayer::sum(self : ChemmolreprcifLayer) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprcifLayer::mean(self : ChemmolreprcifLayer) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprcifLayer::scale(self : ChemmolreprcifLayer, f : Double) -> ChemmolreprcifLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifLayer::add(self : ChemmolreprcifLayer, other : ChemmolreprcifLayer) -> ChemmolreprcifLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprcifLayer::copy(self : ChemmolreprcifLayer) -> ChemmolreprcifLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifLayer::fill(self : ChemmolreprcifLayer, v : Double) -> ChemmolreprcifLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifLayer::min(self : ChemmolreprcifLayer) -> Double { @_common.min(self.data) }

pub fn ChemmolreprcifLayer::max(self : ChemmolreprcifLayer) -> Double { @_common.max(self.data) }

pub fn ChemmolreprcifLayer::to_string(self : ChemmolreprcifLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_buffer_make(size : Int) -> ChemmolreprcifBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprcifBuffer::len(self : ChemmolreprcifBuffer) -> Int { self.size }

pub fn ChemmolreprcifBuffer::get(self : ChemmolreprcifBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprcifBuffer::set(self : ChemmolreprcifBuffer, i : Int, v : Double) -> ChemmolreprcifBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifBuffer::sum(self : ChemmolreprcifBuffer) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprcifBuffer::mean(self : ChemmolreprcifBuffer) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprcifBuffer::scale(self : ChemmolreprcifBuffer, f : Double) -> ChemmolreprcifBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifBuffer::add(self : ChemmolreprcifBuffer, other : ChemmolreprcifBuffer) -> ChemmolreprcifBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprcifBuffer::copy(self : ChemmolreprcifBuffer) -> ChemmolreprcifBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifBuffer::fill(self : ChemmolreprcifBuffer, v : Double) -> ChemmolreprcifBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifBuffer::min(self : ChemmolreprcifBuffer) -> Double { @_common.min(self.data) }

pub fn ChemmolreprcifBuffer::max(self : ChemmolreprcifBuffer) -> Double { @_common.max(self.data) }

pub fn ChemmolreprcifBuffer::to_string(self : ChemmolreprcifBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_cursor_make(size : Int) -> ChemmolreprcifCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprcifCursor::len(self : ChemmolreprcifCursor) -> Int { self.size }

pub fn ChemmolreprcifCursor::get(self : ChemmolreprcifCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprcifCursor::set(self : ChemmolreprcifCursor, i : Int, v : Double) -> ChemmolreprcifCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifCursor::sum(self : ChemmolreprcifCursor) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprcifCursor::mean(self : ChemmolreprcifCursor) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprcifCursor::scale(self : ChemmolreprcifCursor, f : Double) -> ChemmolreprcifCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifCursor::add(self : ChemmolreprcifCursor, other : ChemmolreprcifCursor) -> ChemmolreprcifCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprcifCursor::copy(self : ChemmolreprcifCursor) -> ChemmolreprcifCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifCursor::fill(self : ChemmolreprcifCursor, v : Double) -> ChemmolreprcifCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifCursor::min(self : ChemmolreprcifCursor) -> Double { @_common.min(self.data) }

pub fn ChemmolreprcifCursor::max(self : ChemmolreprcifCursor) -> Double { @_common.max(self.data) }

pub fn ChemmolreprcifCursor::to_string(self : ChemmolreprcifCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_view_make(size : Int) -> ChemmolreprcifView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprcifView::len(self : ChemmolreprcifView) -> Int { self.size }

pub fn ChemmolreprcifView::get(self : ChemmolreprcifView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprcifView::set(self : ChemmolreprcifView, i : Int, v : Double) -> ChemmolreprcifView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifView::sum(self : ChemmolreprcifView) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprcifView::mean(self : ChemmolreprcifView) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprcifView::scale(self : ChemmolreprcifView, f : Double) -> ChemmolreprcifView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifView::add(self : ChemmolreprcifView, other : ChemmolreprcifView) -> ChemmolreprcifView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprcifView::copy(self : ChemmolreprcifView) -> ChemmolreprcifView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifView::fill(self : ChemmolreprcifView, v : Double) -> ChemmolreprcifView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifView::min(self : ChemmolreprcifView) -> Double { @_common.min(self.data) }

pub fn ChemmolreprcifView::max(self : ChemmolreprcifView) -> Double { @_common.max(self.data) }

pub fn ChemmolreprcifView::to_string(self : ChemmolreprcifView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_range_make(size : Int) -> ChemmolreprcifRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprcifRange::len(self : ChemmolreprcifRange) -> Int { self.size }

pub fn ChemmolreprcifRange::get(self : ChemmolreprcifRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprcifRange::set(self : ChemmolreprcifRange, i : Int, v : Double) -> ChemmolreprcifRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifRange::sum(self : ChemmolreprcifRange) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprcifRange::mean(self : ChemmolreprcifRange) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprcifRange::scale(self : ChemmolreprcifRange, f : Double) -> ChemmolreprcifRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifRange::add(self : ChemmolreprcifRange, other : ChemmolreprcifRange) -> ChemmolreprcifRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprcifRange::copy(self : ChemmolreprcifRange) -> ChemmolreprcifRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifRange::fill(self : ChemmolreprcifRange, v : Double) -> ChemmolreprcifRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifRange::min(self : ChemmolreprcifRange) -> Double { @_common.min(self.data) }

pub fn ChemmolreprcifRange::max(self : ChemmolreprcifRange) -> Double { @_common.max(self.data) }

pub fn ChemmolreprcifRange::to_string(self : ChemmolreprcifRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_slice_make(size : Int) -> ChemmolreprcifSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolreprcifSlice::len(self : ChemmolreprcifSlice) -> Int { self.size }

pub fn ChemmolreprcifSlice::get(self : ChemmolreprcifSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolreprcifSlice::set(self : ChemmolreprcifSlice, i : Int, v : Double) -> ChemmolreprcifSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifSlice::sum(self : ChemmolreprcifSlice) -> Double { @_common.sum(self.data) }

pub fn ChemmolreprcifSlice::mean(self : ChemmolreprcifSlice) -> Double { @_common.mean(self.data) }

pub fn ChemmolreprcifSlice::scale(self : ChemmolreprcifSlice, f : Double) -> ChemmolreprcifSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifSlice::add(self : ChemmolreprcifSlice, other : ChemmolreprcifSlice) -> ChemmolreprcifSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolreprcifSlice::copy(self : ChemmolreprcifSlice) -> ChemmolreprcifSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifSlice::fill(self : ChemmolreprcifSlice, v : Double) -> ChemmolreprcifSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolreprcifSlice::min(self : ChemmolreprcifSlice) -> Double { @_common.min(self.data) }

pub fn ChemmolreprcifSlice::max(self : ChemmolreprcifSlice) -> Double { @_common.max(self.data) }

pub fn ChemmolreprcifSlice::to_string(self : ChemmolreprcifSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

