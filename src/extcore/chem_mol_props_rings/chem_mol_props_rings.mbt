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

pub fn ChemmolpropsringsFrame::len(self : ChemmolpropsringsFrame) -> Int { self.size }

pub fn ChemmolpropsringsFrame::get(self : ChemmolpropsringsFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsringsFrame::set(self : ChemmolpropsringsFrame, i : Int, v : Double) -> ChemmolpropsringsFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsFrame::sum(self : ChemmolpropsringsFrame) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsringsFrame::mean(self : ChemmolpropsringsFrame) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsringsFrame::scale(self : ChemmolpropsringsFrame, f : Double) -> ChemmolpropsringsFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsFrame::add(self : ChemmolpropsringsFrame, other : ChemmolpropsringsFrame) -> ChemmolpropsringsFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsringsFrame::copy(self : ChemmolpropsringsFrame) -> ChemmolpropsringsFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsFrame::fill(self : ChemmolpropsringsFrame, v : Double) -> ChemmolpropsringsFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsFrame::min(self : ChemmolpropsringsFrame) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsringsFrame::max(self : ChemmolpropsringsFrame) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsringsFrame::to_string(self : ChemmolpropsringsFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsringsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rings_table_make(size : Int) -> ChemmolpropsringsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsringsTable::len(self : ChemmolpropsringsTable) -> Int { self.size }

pub fn ChemmolpropsringsTable::get(self : ChemmolpropsringsTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsringsTable::set(self : ChemmolpropsringsTable, i : Int, v : Double) -> ChemmolpropsringsTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsTable::sum(self : ChemmolpropsringsTable) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsringsTable::mean(self : ChemmolpropsringsTable) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsringsTable::scale(self : ChemmolpropsringsTable, f : Double) -> ChemmolpropsringsTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsTable::add(self : ChemmolpropsringsTable, other : ChemmolpropsringsTable) -> ChemmolpropsringsTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsringsTable::copy(self : ChemmolpropsringsTable) -> ChemmolpropsringsTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsTable::fill(self : ChemmolpropsringsTable, v : Double) -> ChemmolpropsringsTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsTable::min(self : ChemmolpropsringsTable) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsringsTable::max(self : ChemmolpropsringsTable) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsringsTable::to_string(self : ChemmolpropsringsTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsringsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rings_graphn_make(size : Int) -> ChemmolpropsringsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsringsGraphN::len(self : ChemmolpropsringsGraphN) -> Int { self.size }

pub fn ChemmolpropsringsGraphN::get(self : ChemmolpropsringsGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsringsGraphN::set(self : ChemmolpropsringsGraphN, i : Int, v : Double) -> ChemmolpropsringsGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsGraphN::sum(self : ChemmolpropsringsGraphN) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsringsGraphN::mean(self : ChemmolpropsringsGraphN) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsringsGraphN::scale(self : ChemmolpropsringsGraphN, f : Double) -> ChemmolpropsringsGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsGraphN::add(self : ChemmolpropsringsGraphN, other : ChemmolpropsringsGraphN) -> ChemmolpropsringsGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsringsGraphN::copy(self : ChemmolpropsringsGraphN) -> ChemmolpropsringsGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsGraphN::fill(self : ChemmolpropsringsGraphN, v : Double) -> ChemmolpropsringsGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsGraphN::min(self : ChemmolpropsringsGraphN) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsringsGraphN::max(self : ChemmolpropsringsGraphN) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsringsGraphN::to_string(self : ChemmolpropsringsGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsringsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rings_node_make(size : Int) -> ChemmolpropsringsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsringsNode::len(self : ChemmolpropsringsNode) -> Int { self.size }

pub fn ChemmolpropsringsNode::get(self : ChemmolpropsringsNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsringsNode::set(self : ChemmolpropsringsNode, i : Int, v : Double) -> ChemmolpropsringsNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsNode::sum(self : ChemmolpropsringsNode) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsringsNode::mean(self : ChemmolpropsringsNode) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsringsNode::scale(self : ChemmolpropsringsNode, f : Double) -> ChemmolpropsringsNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsNode::add(self : ChemmolpropsringsNode, other : ChemmolpropsringsNode) -> ChemmolpropsringsNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsringsNode::copy(self : ChemmolpropsringsNode) -> ChemmolpropsringsNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsNode::fill(self : ChemmolpropsringsNode, v : Double) -> ChemmolpropsringsNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsNode::min(self : ChemmolpropsringsNode) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsringsNode::max(self : ChemmolpropsringsNode) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsringsNode::to_string(self : ChemmolpropsringsNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsringsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rings_edge_make(size : Int) -> ChemmolpropsringsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsringsEdge::len(self : ChemmolpropsringsEdge) -> Int { self.size }

pub fn ChemmolpropsringsEdge::get(self : ChemmolpropsringsEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsringsEdge::set(self : ChemmolpropsringsEdge, i : Int, v : Double) -> ChemmolpropsringsEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsEdge::sum(self : ChemmolpropsringsEdge) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsringsEdge::mean(self : ChemmolpropsringsEdge) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsringsEdge::scale(self : ChemmolpropsringsEdge, f : Double) -> ChemmolpropsringsEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsEdge::add(self : ChemmolpropsringsEdge, other : ChemmolpropsringsEdge) -> ChemmolpropsringsEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsringsEdge::copy(self : ChemmolpropsringsEdge) -> ChemmolpropsringsEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsEdge::fill(self : ChemmolpropsringsEdge, v : Double) -> ChemmolpropsringsEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsEdge::min(self : ChemmolpropsringsEdge) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsringsEdge::max(self : ChemmolpropsringsEdge) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsringsEdge::to_string(self : ChemmolpropsringsEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsringsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rings_path_make(size : Int) -> ChemmolpropsringsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsringsPath::len(self : ChemmolpropsringsPath) -> Int { self.size }

pub fn ChemmolpropsringsPath::get(self : ChemmolpropsringsPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsringsPath::set(self : ChemmolpropsringsPath, i : Int, v : Double) -> ChemmolpropsringsPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsPath::sum(self : ChemmolpropsringsPath) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsringsPath::mean(self : ChemmolpropsringsPath) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsringsPath::scale(self : ChemmolpropsringsPath, f : Double) -> ChemmolpropsringsPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsPath::add(self : ChemmolpropsringsPath, other : ChemmolpropsringsPath) -> ChemmolpropsringsPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsringsPath::copy(self : ChemmolpropsringsPath) -> ChemmolpropsringsPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsPath::fill(self : ChemmolpropsringsPath, v : Double) -> ChemmolpropsringsPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsPath::min(self : ChemmolpropsringsPath) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsringsPath::max(self : ChemmolpropsringsPath) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsringsPath::to_string(self : ChemmolpropsringsPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsringsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rings_cluster_make(size : Int) -> ChemmolpropsringsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsringsCluster::len(self : ChemmolpropsringsCluster) -> Int { self.size }

pub fn ChemmolpropsringsCluster::get(self : ChemmolpropsringsCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsringsCluster::set(self : ChemmolpropsringsCluster, i : Int, v : Double) -> ChemmolpropsringsCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsCluster::sum(self : ChemmolpropsringsCluster) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsringsCluster::mean(self : ChemmolpropsringsCluster) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsringsCluster::scale(self : ChemmolpropsringsCluster, f : Double) -> ChemmolpropsringsCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsCluster::add(self : ChemmolpropsringsCluster, other : ChemmolpropsringsCluster) -> ChemmolpropsringsCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsringsCluster::copy(self : ChemmolpropsringsCluster) -> ChemmolpropsringsCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsCluster::fill(self : ChemmolpropsringsCluster, v : Double) -> ChemmolpropsringsCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsCluster::min(self : ChemmolpropsringsCluster) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsringsCluster::max(self : ChemmolpropsringsCluster) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsringsCluster::to_string(self : ChemmolpropsringsCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsringsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rings_model_make(size : Int) -> ChemmolpropsringsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsringsModel::len(self : ChemmolpropsringsModel) -> Int { self.size }

pub fn ChemmolpropsringsModel::get(self : ChemmolpropsringsModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsringsModel::set(self : ChemmolpropsringsModel, i : Int, v : Double) -> ChemmolpropsringsModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsModel::sum(self : ChemmolpropsringsModel) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsringsModel::mean(self : ChemmolpropsringsModel) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsringsModel::scale(self : ChemmolpropsringsModel, f : Double) -> ChemmolpropsringsModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsModel::add(self : ChemmolpropsringsModel, other : ChemmolpropsringsModel) -> ChemmolpropsringsModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsringsModel::copy(self : ChemmolpropsringsModel) -> ChemmolpropsringsModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsModel::fill(self : ChemmolpropsringsModel, v : Double) -> ChemmolpropsringsModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsModel::min(self : ChemmolpropsringsModel) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsringsModel::max(self : ChemmolpropsringsModel) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsringsModel::to_string(self : ChemmolpropsringsModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsringsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rings_layer_make(size : Int) -> ChemmolpropsringsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsringsLayer::len(self : ChemmolpropsringsLayer) -> Int { self.size }

pub fn ChemmolpropsringsLayer::get(self : ChemmolpropsringsLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsringsLayer::set(self : ChemmolpropsringsLayer, i : Int, v : Double) -> ChemmolpropsringsLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsLayer::sum(self : ChemmolpropsringsLayer) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsringsLayer::mean(self : ChemmolpropsringsLayer) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsringsLayer::scale(self : ChemmolpropsringsLayer, f : Double) -> ChemmolpropsringsLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsLayer::add(self : ChemmolpropsringsLayer, other : ChemmolpropsringsLayer) -> ChemmolpropsringsLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsringsLayer::copy(self : ChemmolpropsringsLayer) -> ChemmolpropsringsLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsLayer::fill(self : ChemmolpropsringsLayer, v : Double) -> ChemmolpropsringsLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsLayer::min(self : ChemmolpropsringsLayer) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsringsLayer::max(self : ChemmolpropsringsLayer) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsringsLayer::to_string(self : ChemmolpropsringsLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsringsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rings_buffer_make(size : Int) -> ChemmolpropsringsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsringsBuffer::len(self : ChemmolpropsringsBuffer) -> Int { self.size }

pub fn ChemmolpropsringsBuffer::get(self : ChemmolpropsringsBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsringsBuffer::set(self : ChemmolpropsringsBuffer, i : Int, v : Double) -> ChemmolpropsringsBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsBuffer::sum(self : ChemmolpropsringsBuffer) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsringsBuffer::mean(self : ChemmolpropsringsBuffer) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsringsBuffer::scale(self : ChemmolpropsringsBuffer, f : Double) -> ChemmolpropsringsBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsBuffer::add(self : ChemmolpropsringsBuffer, other : ChemmolpropsringsBuffer) -> ChemmolpropsringsBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsringsBuffer::copy(self : ChemmolpropsringsBuffer) -> ChemmolpropsringsBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsBuffer::fill(self : ChemmolpropsringsBuffer, v : Double) -> ChemmolpropsringsBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsBuffer::min(self : ChemmolpropsringsBuffer) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsringsBuffer::max(self : ChemmolpropsringsBuffer) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsringsBuffer::to_string(self : ChemmolpropsringsBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsringsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rings_cursor_make(size : Int) -> ChemmolpropsringsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsringsCursor::len(self : ChemmolpropsringsCursor) -> Int { self.size }

pub fn ChemmolpropsringsCursor::get(self : ChemmolpropsringsCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsringsCursor::set(self : ChemmolpropsringsCursor, i : Int, v : Double) -> ChemmolpropsringsCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsCursor::sum(self : ChemmolpropsringsCursor) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsringsCursor::mean(self : ChemmolpropsringsCursor) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsringsCursor::scale(self : ChemmolpropsringsCursor, f : Double) -> ChemmolpropsringsCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsCursor::add(self : ChemmolpropsringsCursor, other : ChemmolpropsringsCursor) -> ChemmolpropsringsCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsringsCursor::copy(self : ChemmolpropsringsCursor) -> ChemmolpropsringsCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsCursor::fill(self : ChemmolpropsringsCursor, v : Double) -> ChemmolpropsringsCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsCursor::min(self : ChemmolpropsringsCursor) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsringsCursor::max(self : ChemmolpropsringsCursor) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsringsCursor::to_string(self : ChemmolpropsringsCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsringsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rings_view_make(size : Int) -> ChemmolpropsringsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsringsView::len(self : ChemmolpropsringsView) -> Int { self.size }

pub fn ChemmolpropsringsView::get(self : ChemmolpropsringsView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsringsView::set(self : ChemmolpropsringsView, i : Int, v : Double) -> ChemmolpropsringsView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsView::sum(self : ChemmolpropsringsView) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsringsView::mean(self : ChemmolpropsringsView) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsringsView::scale(self : ChemmolpropsringsView, f : Double) -> ChemmolpropsringsView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsView::add(self : ChemmolpropsringsView, other : ChemmolpropsringsView) -> ChemmolpropsringsView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsringsView::copy(self : ChemmolpropsringsView) -> ChemmolpropsringsView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsView::fill(self : ChemmolpropsringsView, v : Double) -> ChemmolpropsringsView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsView::min(self : ChemmolpropsringsView) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsringsView::max(self : ChemmolpropsringsView) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsringsView::to_string(self : ChemmolpropsringsView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsringsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rings_range_make(size : Int) -> ChemmolpropsringsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsringsRange::len(self : ChemmolpropsringsRange) -> Int { self.size }

pub fn ChemmolpropsringsRange::get(self : ChemmolpropsringsRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsringsRange::set(self : ChemmolpropsringsRange, i : Int, v : Double) -> ChemmolpropsringsRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsRange::sum(self : ChemmolpropsringsRange) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsringsRange::mean(self : ChemmolpropsringsRange) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsringsRange::scale(self : ChemmolpropsringsRange, f : Double) -> ChemmolpropsringsRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsRange::add(self : ChemmolpropsringsRange, other : ChemmolpropsringsRange) -> ChemmolpropsringsRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsringsRange::copy(self : ChemmolpropsringsRange) -> ChemmolpropsringsRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsRange::fill(self : ChemmolpropsringsRange, v : Double) -> ChemmolpropsringsRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsRange::min(self : ChemmolpropsringsRange) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsringsRange::max(self : ChemmolpropsringsRange) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsringsRange::to_string(self : ChemmolpropsringsRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsringsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rings_slice_make(size : Int) -> ChemmolpropsringsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemmolpropsringsSlice::len(self : ChemmolpropsringsSlice) -> Int { self.size }

pub fn ChemmolpropsringsSlice::get(self : ChemmolpropsringsSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemmolpropsringsSlice::set(self : ChemmolpropsringsSlice, i : Int, v : Double) -> ChemmolpropsringsSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsSlice::sum(self : ChemmolpropsringsSlice) -> Double { @_common.sum(self.data) }

pub fn ChemmolpropsringsSlice::mean(self : ChemmolpropsringsSlice) -> Double { @_common.mean(self.data) }

pub fn ChemmolpropsringsSlice::scale(self : ChemmolpropsringsSlice, f : Double) -> ChemmolpropsringsSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsSlice::add(self : ChemmolpropsringsSlice, other : ChemmolpropsringsSlice) -> ChemmolpropsringsSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemmolpropsringsSlice::copy(self : ChemmolpropsringsSlice) -> ChemmolpropsringsSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsSlice::fill(self : ChemmolpropsringsSlice, v : Double) -> ChemmolpropsringsSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemmolpropsringsSlice::min(self : ChemmolpropsringsSlice) -> Double { @_common.min(self.data) }

pub fn ChemmolpropsringsSlice::max(self : ChemmolpropsringsSlice) -> Double { @_common.max(self.data) }

pub fn ChemmolpropsringsSlice::to_string(self : ChemmolpropsringsSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

