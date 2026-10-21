///|
///===
/// extcore/chem_rxn_catalyst
pub(all) struct ChemrxncatalystPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn chem_rxn_catalyst_make_point(
  x : Double,
  y : Double,
) -> ChemrxncatalystPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn chem_rxn_catalyst_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> ChemrxncatalystPoint {
  { x, y, z, label: 0, }
}

///|
pub fn ChemrxncatalystPoint::x(self : ChemrxncatalystPoint) -> Double {
  self.x
}

///|
pub fn ChemrxncatalystPoint::y(self : ChemrxncatalystPoint) -> Double {
  self.y
}

///|
pub fn ChemrxncatalystPoint::z(self : ChemrxncatalystPoint) -> Double {
  self.z
}

///|
pub fn ChemrxncatalystPoint::label(self : ChemrxncatalystPoint) -> Int32 {
  self.label
}

///|
pub fn ChemrxncatalystPoint::dist(
  self : ChemrxncatalystPoint,
  other : ChemrxncatalystPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn ChemrxncatalystPoint::add(
  self : ChemrxncatalystPoint,
  other : ChemrxncatalystPoint,
) -> ChemrxncatalystPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn ChemrxncatalystPoint::sub(
  self : ChemrxncatalystPoint,
  other : ChemrxncatalystPoint,
) -> ChemrxncatalystPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn ChemrxncatalystPoint::scale(
  self : ChemrxncatalystPoint,
  s : Double,
) -> ChemrxncatalystPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn ChemrxncatalystPoint::dot(
  self : ChemrxncatalystPoint,
  other : ChemrxncatalystPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn ChemrxncatalystPoint::cross(
  self : ChemrxncatalystPoint,
  other : ChemrxncatalystPoint,
) -> ChemrxncatalystPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn ChemrxncatalystPoint::norm(self : ChemrxncatalystPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn ChemrxncatalystPoint::normalize(
  self : ChemrxncatalystPoint,
) -> ChemrxncatalystPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn ChemrxncatalystPoint::negate(
  self : ChemrxncatalystPoint,
) -> ChemrxncatalystPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn ChemrxncatalystPoint::mid(
  self : ChemrxncatalystPoint,
  other : ChemrxncatalystPoint,
) -> ChemrxncatalystPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn ChemrxncatalystPoint::lerp(
  self : ChemrxncatalystPoint,
  other : ChemrxncatalystPoint,
  t : Double,
) -> ChemrxncatalystPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn ChemrxncatalystPoint::to_string(self : ChemrxncatalystPoint) -> String {
  "(" +
  @_common.dbl(self.x) +
  ", " +
  @_common.dbl(self.y) +
  ", " +
  @_common.dbl(self.z) +
  ")[" +
  self.label.to_string() +
  "]"
}

///|
pub(all) struct ChemrxncatalystSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn chem_rxn_catalyst_make_series(
  vals : Array[Double],
  name : String,
) -> ChemrxncatalystSeries {
  { vals, name, meta: 0, }
}

///|
pub fn ChemrxncatalystSeries::len(self : ChemrxncatalystSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn ChemrxncatalystSeries::sum(self : ChemrxncatalystSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn ChemrxncatalystSeries::mean(self : ChemrxncatalystSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn ChemrxncatalystSeries::min(self : ChemrxncatalystSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn ChemrxncatalystSeries::max(self : ChemrxncatalystSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn ChemrxncatalystSeries::range(self : ChemrxncatalystSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn ChemrxncatalystSeries::variance(self : ChemrxncatalystSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn ChemrxncatalystSeries::std(self : ChemrxncatalystSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn ChemrxncatalystSeries::median(self : ChemrxncatalystSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn ChemrxncatalystSeries::scale(
  self : ChemrxncatalystSeries,
  f : Double,
) -> ChemrxncatalystSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn ChemrxncatalystSeries::add(
  self : ChemrxncatalystSeries,
  other : ChemrxncatalystSeries,
) -> ChemrxncatalystSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn ChemrxncatalystSeries::sub(
  self : ChemrxncatalystSeries,
  other : ChemrxncatalystSeries,
) -> ChemrxncatalystSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn ChemrxncatalystSeries::normalize(
  self : ChemrxncatalystSeries,
) -> ChemrxncatalystSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 {
    self
  } else {
    let result = []
    for i in 0..<self.vals.length() {
      result.push((self.vals[i] - mn) / r)
    }
    { vals: result, name: self.name, meta: self.meta, }
  }
}

///|
pub fn ChemrxncatalystSeries::cumsum(
  self : ChemrxncatalystSeries,
) -> ChemrxncatalystSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn ChemrxncatalystSeries::to_string(self : ChemrxncatalystSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + @_common.dbl(self.vals[i])
  }
  if n > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub(all) struct ChemrxncatalystMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn chem_rxn_catalyst_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> ChemrxncatalystMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn chem_rxn_catalyst_matrix_identity(n : Int32) -> ChemrxncatalystMatrix {
  let m = chem_rxn_catalyst_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn ChemrxncatalystMatrix::get(
  self : ChemrxncatalystMatrix,
  i : Int32,
  j : Int32,
) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols {
    0.0
  } else {
    self.data[i][j]
  }
}

///|
pub fn ChemrxncatalystMatrix::transpose(
  self : ChemrxncatalystMatrix,
) -> ChemrxncatalystMatrix {
  let result = chem_rxn_catalyst_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn ChemrxncatalystMatrix::add(
  self : ChemrxncatalystMatrix,
  other : ChemrxncatalystMatrix,
) -> ChemrxncatalystMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = chem_rxn_catalyst_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn ChemrxncatalystMatrix::scale(
  self : ChemrxncatalystMatrix,
  s : Double,
) -> ChemrxncatalystMatrix {
  let result = chem_rxn_catalyst_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn ChemrxncatalystMatrix::multiply(
  self : ChemrxncatalystMatrix,
  other : ChemrxncatalystMatrix,
) -> ChemrxncatalystMatrix {
  if self.cols != other.rows {
    return chem_rxn_catalyst_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = chem_rxn_catalyst_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols {
        result.data[i][j] = result.data[i][j] + v * other.data[k][j]
      }
    }
  }
  result
}

///|
pub fn ChemrxncatalystMatrix::trace(self : ChemrxncatalystMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn ChemrxncatalystMatrix::det(self : ChemrxncatalystMatrix) -> Double {
  if self.rows != self.cols {
    0.0
  } else if self.rows == 1 {
    self.data[0][0]
  } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] *
      (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] *
      (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] *
      (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else {
    0.0
  }
}

///|
pub fn ChemrxncatalystMatrix::norm(self : ChemrxncatalystMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn ChemrxncatalystMatrix::to_string(self : ChemrxncatalystMatrix) -> String {
  let mut result = "Mat(" +
    self.rows.to_string() +
    "x" +
    self.cols.to_string() +
    ")\n"
  let rl = if self.rows < 5 { self.rows } else { 5 }
  let cl = if self.cols < 5 { self.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl {
      if j > 0 {
        result = result + ", "
      }
      result = result + @_common.dbl(self.data[i][j])
    }
    result = result + "]\n"
  }
  result
}

///|
pub(all) struct ChemrxncatalystVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn chem_rxn_catalyst_make_vector(
  comps : Array[Double],
) -> ChemrxncatalystVector {
  { comps, dim: comps.length(), }
}

///|
pub fn chem_rxn_catalyst_vector_zero(dim : Int32) -> ChemrxncatalystVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn ChemrxncatalystVector::add(
  self : ChemrxncatalystVector,
  other : ChemrxncatalystVector,
) -> ChemrxncatalystVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn ChemrxncatalystVector::sub(
  self : ChemrxncatalystVector,
  other : ChemrxncatalystVector,
) -> ChemrxncatalystVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn ChemrxncatalystVector::scale(
  self : ChemrxncatalystVector,
  s : Double,
) -> ChemrxncatalystVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn ChemrxncatalystVector::dot(
  self : ChemrxncatalystVector,
  other : ChemrxncatalystVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn ChemrxncatalystVector::norm(self : ChemrxncatalystVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn ChemrxncatalystVector::normalize(
  self : ChemrxncatalystVector,
) -> ChemrxncatalystVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn ChemrxncatalystVector::dist(
  self : ChemrxncatalystVector,
  other : ChemrxncatalystVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn ChemrxncatalystVector::to_string(self : ChemrxncatalystVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + @_common.dbl(self.comps[i])
  }
  if self.dim > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub(all) struct ChemrxncatalystFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_rxn_catalyst_frame_make(size : Int32) -> ChemrxncatalystFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemrxncatalystFrame::len(self : ChemrxncatalystFrame) -> Int32 {
  self.size
}

///|
pub fn ChemrxncatalystFrame::get(
  self : ChemrxncatalystFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemrxncatalystFrame::set(
  self : ChemrxncatalystFrame,
  i : Int32,
  v : Double,
) -> ChemrxncatalystFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystFrame::sum(self : ChemrxncatalystFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemrxncatalystFrame::mean(self : ChemrxncatalystFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemrxncatalystFrame::scale(
  self : ChemrxncatalystFrame,
  f : Double,
) -> ChemrxncatalystFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystFrame::add(
  self : ChemrxncatalystFrame,
  other : ChemrxncatalystFrame,
) -> ChemrxncatalystFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemrxncatalystFrame::copy(
  self : ChemrxncatalystFrame,
) -> ChemrxncatalystFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystFrame::fill(
  self : ChemrxncatalystFrame,
  v : Double,
) -> ChemrxncatalystFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystFrame::min(self : ChemrxncatalystFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemrxncatalystFrame::max(self : ChemrxncatalystFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemrxncatalystFrame::to_string(self : ChemrxncatalystFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemrxncatalystTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_rxn_catalyst_table_make(size : Int32) -> ChemrxncatalystTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemrxncatalystTable::len(self : ChemrxncatalystTable) -> Int32 {
  self.size
}

///|
pub fn ChemrxncatalystTable::get(
  self : ChemrxncatalystTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemrxncatalystTable::set(
  self : ChemrxncatalystTable,
  i : Int32,
  v : Double,
) -> ChemrxncatalystTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystTable::sum(self : ChemrxncatalystTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemrxncatalystTable::mean(self : ChemrxncatalystTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemrxncatalystTable::scale(
  self : ChemrxncatalystTable,
  f : Double,
) -> ChemrxncatalystTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystTable::add(
  self : ChemrxncatalystTable,
  other : ChemrxncatalystTable,
) -> ChemrxncatalystTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemrxncatalystTable::copy(
  self : ChemrxncatalystTable,
) -> ChemrxncatalystTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystTable::fill(
  self : ChemrxncatalystTable,
  v : Double,
) -> ChemrxncatalystTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystTable::min(self : ChemrxncatalystTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemrxncatalystTable::max(self : ChemrxncatalystTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemrxncatalystTable::to_string(self : ChemrxncatalystTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemrxncatalystGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_rxn_catalyst_graphn_make(size : Int32) -> ChemrxncatalystGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemrxncatalystGraphN::len(self : ChemrxncatalystGraphN) -> Int32 {
  self.size
}

///|
pub fn ChemrxncatalystGraphN::get(
  self : ChemrxncatalystGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemrxncatalystGraphN::set(
  self : ChemrxncatalystGraphN,
  i : Int32,
  v : Double,
) -> ChemrxncatalystGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystGraphN::sum(self : ChemrxncatalystGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemrxncatalystGraphN::mean(self : ChemrxncatalystGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemrxncatalystGraphN::scale(
  self : ChemrxncatalystGraphN,
  f : Double,
) -> ChemrxncatalystGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystGraphN::add(
  self : ChemrxncatalystGraphN,
  other : ChemrxncatalystGraphN,
) -> ChemrxncatalystGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemrxncatalystGraphN::copy(
  self : ChemrxncatalystGraphN,
) -> ChemrxncatalystGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystGraphN::fill(
  self : ChemrxncatalystGraphN,
  v : Double,
) -> ChemrxncatalystGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystGraphN::min(self : ChemrxncatalystGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemrxncatalystGraphN::max(self : ChemrxncatalystGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemrxncatalystGraphN::to_string(self : ChemrxncatalystGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemrxncatalystNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_rxn_catalyst_node_make(size : Int32) -> ChemrxncatalystNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemrxncatalystNode::len(self : ChemrxncatalystNode) -> Int32 {
  self.size
}

///|
pub fn ChemrxncatalystNode::get(
  self : ChemrxncatalystNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemrxncatalystNode::set(
  self : ChemrxncatalystNode,
  i : Int32,
  v : Double,
) -> ChemrxncatalystNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystNode::sum(self : ChemrxncatalystNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemrxncatalystNode::mean(self : ChemrxncatalystNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemrxncatalystNode::scale(
  self : ChemrxncatalystNode,
  f : Double,
) -> ChemrxncatalystNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystNode::add(
  self : ChemrxncatalystNode,
  other : ChemrxncatalystNode,
) -> ChemrxncatalystNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemrxncatalystNode::copy(
  self : ChemrxncatalystNode,
) -> ChemrxncatalystNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystNode::fill(
  self : ChemrxncatalystNode,
  v : Double,
) -> ChemrxncatalystNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystNode::min(self : ChemrxncatalystNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemrxncatalystNode::max(self : ChemrxncatalystNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemrxncatalystNode::to_string(self : ChemrxncatalystNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemrxncatalystEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_rxn_catalyst_edge_make(size : Int32) -> ChemrxncatalystEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemrxncatalystEdge::len(self : ChemrxncatalystEdge) -> Int32 {
  self.size
}

///|
pub fn ChemrxncatalystEdge::get(
  self : ChemrxncatalystEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemrxncatalystEdge::set(
  self : ChemrxncatalystEdge,
  i : Int32,
  v : Double,
) -> ChemrxncatalystEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystEdge::sum(self : ChemrxncatalystEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemrxncatalystEdge::mean(self : ChemrxncatalystEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemrxncatalystEdge::scale(
  self : ChemrxncatalystEdge,
  f : Double,
) -> ChemrxncatalystEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystEdge::add(
  self : ChemrxncatalystEdge,
  other : ChemrxncatalystEdge,
) -> ChemrxncatalystEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemrxncatalystEdge::copy(
  self : ChemrxncatalystEdge,
) -> ChemrxncatalystEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystEdge::fill(
  self : ChemrxncatalystEdge,
  v : Double,
) -> ChemrxncatalystEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystEdge::min(self : ChemrxncatalystEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemrxncatalystEdge::max(self : ChemrxncatalystEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemrxncatalystEdge::to_string(self : ChemrxncatalystEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemrxncatalystPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_rxn_catalyst_path_make(size : Int32) -> ChemrxncatalystPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemrxncatalystPath::len(self : ChemrxncatalystPath) -> Int32 {
  self.size
}

///|
pub fn ChemrxncatalystPath::get(
  self : ChemrxncatalystPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemrxncatalystPath::set(
  self : ChemrxncatalystPath,
  i : Int32,
  v : Double,
) -> ChemrxncatalystPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystPath::sum(self : ChemrxncatalystPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemrxncatalystPath::mean(self : ChemrxncatalystPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemrxncatalystPath::scale(
  self : ChemrxncatalystPath,
  f : Double,
) -> ChemrxncatalystPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystPath::add(
  self : ChemrxncatalystPath,
  other : ChemrxncatalystPath,
) -> ChemrxncatalystPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemrxncatalystPath::copy(
  self : ChemrxncatalystPath,
) -> ChemrxncatalystPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystPath::fill(
  self : ChemrxncatalystPath,
  v : Double,
) -> ChemrxncatalystPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystPath::min(self : ChemrxncatalystPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemrxncatalystPath::max(self : ChemrxncatalystPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemrxncatalystPath::to_string(self : ChemrxncatalystPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemrxncatalystCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_rxn_catalyst_cluster_make(size : Int32) -> ChemrxncatalystCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemrxncatalystCluster::len(self : ChemrxncatalystCluster) -> Int32 {
  self.size
}

///|
pub fn ChemrxncatalystCluster::get(
  self : ChemrxncatalystCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemrxncatalystCluster::set(
  self : ChemrxncatalystCluster,
  i : Int32,
  v : Double,
) -> ChemrxncatalystCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystCluster::sum(self : ChemrxncatalystCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemrxncatalystCluster::mean(self : ChemrxncatalystCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemrxncatalystCluster::scale(
  self : ChemrxncatalystCluster,
  f : Double,
) -> ChemrxncatalystCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystCluster::add(
  self : ChemrxncatalystCluster,
  other : ChemrxncatalystCluster,
) -> ChemrxncatalystCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemrxncatalystCluster::copy(
  self : ChemrxncatalystCluster,
) -> ChemrxncatalystCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystCluster::fill(
  self : ChemrxncatalystCluster,
  v : Double,
) -> ChemrxncatalystCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystCluster::min(self : ChemrxncatalystCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemrxncatalystCluster::max(self : ChemrxncatalystCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemrxncatalystCluster::to_string(
  self : ChemrxncatalystCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemrxncatalystModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_rxn_catalyst_model_make(size : Int32) -> ChemrxncatalystModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemrxncatalystModel::len(self : ChemrxncatalystModel) -> Int32 {
  self.size
}

///|
pub fn ChemrxncatalystModel::get(
  self : ChemrxncatalystModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemrxncatalystModel::set(
  self : ChemrxncatalystModel,
  i : Int32,
  v : Double,
) -> ChemrxncatalystModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystModel::sum(self : ChemrxncatalystModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemrxncatalystModel::mean(self : ChemrxncatalystModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemrxncatalystModel::scale(
  self : ChemrxncatalystModel,
  f : Double,
) -> ChemrxncatalystModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystModel::add(
  self : ChemrxncatalystModel,
  other : ChemrxncatalystModel,
) -> ChemrxncatalystModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemrxncatalystModel::copy(
  self : ChemrxncatalystModel,
) -> ChemrxncatalystModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystModel::fill(
  self : ChemrxncatalystModel,
  v : Double,
) -> ChemrxncatalystModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystModel::min(self : ChemrxncatalystModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemrxncatalystModel::max(self : ChemrxncatalystModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemrxncatalystModel::to_string(self : ChemrxncatalystModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemrxncatalystLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_rxn_catalyst_layer_make(size : Int32) -> ChemrxncatalystLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemrxncatalystLayer::len(self : ChemrxncatalystLayer) -> Int32 {
  self.size
}

///|
pub fn ChemrxncatalystLayer::get(
  self : ChemrxncatalystLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemrxncatalystLayer::set(
  self : ChemrxncatalystLayer,
  i : Int32,
  v : Double,
) -> ChemrxncatalystLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystLayer::sum(self : ChemrxncatalystLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemrxncatalystLayer::mean(self : ChemrxncatalystLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemrxncatalystLayer::scale(
  self : ChemrxncatalystLayer,
  f : Double,
) -> ChemrxncatalystLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystLayer::add(
  self : ChemrxncatalystLayer,
  other : ChemrxncatalystLayer,
) -> ChemrxncatalystLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemrxncatalystLayer::copy(
  self : ChemrxncatalystLayer,
) -> ChemrxncatalystLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystLayer::fill(
  self : ChemrxncatalystLayer,
  v : Double,
) -> ChemrxncatalystLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystLayer::min(self : ChemrxncatalystLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemrxncatalystLayer::max(self : ChemrxncatalystLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemrxncatalystLayer::to_string(self : ChemrxncatalystLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemrxncatalystBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_rxn_catalyst_buffer_make(size : Int32) -> ChemrxncatalystBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemrxncatalystBuffer::len(self : ChemrxncatalystBuffer) -> Int32 {
  self.size
}

///|
pub fn ChemrxncatalystBuffer::get(
  self : ChemrxncatalystBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemrxncatalystBuffer::set(
  self : ChemrxncatalystBuffer,
  i : Int32,
  v : Double,
) -> ChemrxncatalystBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystBuffer::sum(self : ChemrxncatalystBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemrxncatalystBuffer::mean(self : ChemrxncatalystBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemrxncatalystBuffer::scale(
  self : ChemrxncatalystBuffer,
  f : Double,
) -> ChemrxncatalystBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystBuffer::add(
  self : ChemrxncatalystBuffer,
  other : ChemrxncatalystBuffer,
) -> ChemrxncatalystBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemrxncatalystBuffer::copy(
  self : ChemrxncatalystBuffer,
) -> ChemrxncatalystBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystBuffer::fill(
  self : ChemrxncatalystBuffer,
  v : Double,
) -> ChemrxncatalystBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystBuffer::min(self : ChemrxncatalystBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemrxncatalystBuffer::max(self : ChemrxncatalystBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemrxncatalystBuffer::to_string(self : ChemrxncatalystBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemrxncatalystCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_rxn_catalyst_cursor_make(size : Int32) -> ChemrxncatalystCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemrxncatalystCursor::len(self : ChemrxncatalystCursor) -> Int32 {
  self.size
}

///|
pub fn ChemrxncatalystCursor::get(
  self : ChemrxncatalystCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemrxncatalystCursor::set(
  self : ChemrxncatalystCursor,
  i : Int32,
  v : Double,
) -> ChemrxncatalystCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystCursor::sum(self : ChemrxncatalystCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemrxncatalystCursor::mean(self : ChemrxncatalystCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemrxncatalystCursor::scale(
  self : ChemrxncatalystCursor,
  f : Double,
) -> ChemrxncatalystCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystCursor::add(
  self : ChemrxncatalystCursor,
  other : ChemrxncatalystCursor,
) -> ChemrxncatalystCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemrxncatalystCursor::copy(
  self : ChemrxncatalystCursor,
) -> ChemrxncatalystCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystCursor::fill(
  self : ChemrxncatalystCursor,
  v : Double,
) -> ChemrxncatalystCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystCursor::min(self : ChemrxncatalystCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemrxncatalystCursor::max(self : ChemrxncatalystCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemrxncatalystCursor::to_string(self : ChemrxncatalystCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemrxncatalystView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_rxn_catalyst_view_make(size : Int32) -> ChemrxncatalystView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemrxncatalystView::len(self : ChemrxncatalystView) -> Int32 {
  self.size
}

///|
pub fn ChemrxncatalystView::get(
  self : ChemrxncatalystView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemrxncatalystView::set(
  self : ChemrxncatalystView,
  i : Int32,
  v : Double,
) -> ChemrxncatalystView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystView::sum(self : ChemrxncatalystView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemrxncatalystView::mean(self : ChemrxncatalystView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemrxncatalystView::scale(
  self : ChemrxncatalystView,
  f : Double,
) -> ChemrxncatalystView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystView::add(
  self : ChemrxncatalystView,
  other : ChemrxncatalystView,
) -> ChemrxncatalystView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemrxncatalystView::copy(
  self : ChemrxncatalystView,
) -> ChemrxncatalystView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystView::fill(
  self : ChemrxncatalystView,
  v : Double,
) -> ChemrxncatalystView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystView::min(self : ChemrxncatalystView) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemrxncatalystView::max(self : ChemrxncatalystView) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemrxncatalystView::to_string(self : ChemrxncatalystView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemrxncatalystRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_rxn_catalyst_range_make(size : Int32) -> ChemrxncatalystRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemrxncatalystRange::len(self : ChemrxncatalystRange) -> Int32 {
  self.size
}

///|
pub fn ChemrxncatalystRange::get(
  self : ChemrxncatalystRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemrxncatalystRange::set(
  self : ChemrxncatalystRange,
  i : Int32,
  v : Double,
) -> ChemrxncatalystRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystRange::sum(self : ChemrxncatalystRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemrxncatalystRange::mean(self : ChemrxncatalystRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemrxncatalystRange::scale(
  self : ChemrxncatalystRange,
  f : Double,
) -> ChemrxncatalystRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystRange::add(
  self : ChemrxncatalystRange,
  other : ChemrxncatalystRange,
) -> ChemrxncatalystRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemrxncatalystRange::copy(
  self : ChemrxncatalystRange,
) -> ChemrxncatalystRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystRange::fill(
  self : ChemrxncatalystRange,
  v : Double,
) -> ChemrxncatalystRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystRange::min(self : ChemrxncatalystRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemrxncatalystRange::max(self : ChemrxncatalystRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemrxncatalystRange::to_string(self : ChemrxncatalystRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemrxncatalystSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_rxn_catalyst_slice_make(size : Int32) -> ChemrxncatalystSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemrxncatalystSlice::len(self : ChemrxncatalystSlice) -> Int32 {
  self.size
}

///|
pub fn ChemrxncatalystSlice::get(
  self : ChemrxncatalystSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemrxncatalystSlice::set(
  self : ChemrxncatalystSlice,
  i : Int32,
  v : Double,
) -> ChemrxncatalystSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystSlice::sum(self : ChemrxncatalystSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemrxncatalystSlice::mean(self : ChemrxncatalystSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemrxncatalystSlice::scale(
  self : ChemrxncatalystSlice,
  f : Double,
) -> ChemrxncatalystSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystSlice::add(
  self : ChemrxncatalystSlice,
  other : ChemrxncatalystSlice,
) -> ChemrxncatalystSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemrxncatalystSlice::copy(
  self : ChemrxncatalystSlice,
) -> ChemrxncatalystSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystSlice::fill(
  self : ChemrxncatalystSlice,
  v : Double,
) -> ChemrxncatalystSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxncatalystSlice::min(self : ChemrxncatalystSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemrxncatalystSlice::max(self : ChemrxncatalystSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemrxncatalystSlice::to_string(self : ChemrxncatalystSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
