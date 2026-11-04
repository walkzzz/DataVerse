///|
///===
/// extcore/chem_mol_props_mw
pub(all) struct ChemmolpropsmwPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn chem_mol_props_mw_make_point(
  x : Double,
  y : Double,
) -> ChemmolpropsmwPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn chem_mol_props_mw_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> ChemmolpropsmwPoint {
  { x, y, z, label: 0, }
}

///|
pub fn ChemmolpropsmwPoint::x(self : ChemmolpropsmwPoint) -> Double {
  self.x
}

///|
pub fn ChemmolpropsmwPoint::y(self : ChemmolpropsmwPoint) -> Double {
  self.y
}

///|
pub fn ChemmolpropsmwPoint::z(self : ChemmolpropsmwPoint) -> Double {
  self.z
}

///|
pub fn ChemmolpropsmwPoint::label(self : ChemmolpropsmwPoint) -> Int32 {
  self.label
}

///|
pub fn ChemmolpropsmwPoint::dist(
  self : ChemmolpropsmwPoint,
  other : ChemmolpropsmwPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn ChemmolpropsmwPoint::add(
  self : ChemmolpropsmwPoint,
  other : ChemmolpropsmwPoint,
) -> ChemmolpropsmwPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn ChemmolpropsmwPoint::sub(
  self : ChemmolpropsmwPoint,
  other : ChemmolpropsmwPoint,
) -> ChemmolpropsmwPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn ChemmolpropsmwPoint::scale(
  self : ChemmolpropsmwPoint,
  s : Double,
) -> ChemmolpropsmwPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn ChemmolpropsmwPoint::dot(
  self : ChemmolpropsmwPoint,
  other : ChemmolpropsmwPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn ChemmolpropsmwPoint::cross(
  self : ChemmolpropsmwPoint,
  other : ChemmolpropsmwPoint,
) -> ChemmolpropsmwPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn ChemmolpropsmwPoint::norm(self : ChemmolpropsmwPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn ChemmolpropsmwPoint::normalize(
  self : ChemmolpropsmwPoint,
) -> ChemmolpropsmwPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn ChemmolpropsmwPoint::negate(
  self : ChemmolpropsmwPoint,
) -> ChemmolpropsmwPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn ChemmolpropsmwPoint::mid(
  self : ChemmolpropsmwPoint,
  other : ChemmolpropsmwPoint,
) -> ChemmolpropsmwPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn ChemmolpropsmwPoint::lerp(
  self : ChemmolpropsmwPoint,
  other : ChemmolpropsmwPoint,
  t : Double,
) -> ChemmolpropsmwPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn ChemmolpropsmwPoint::to_string(self : ChemmolpropsmwPoint) -> String {
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
pub(all) struct ChemmolpropsmwSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn chem_mol_props_mw_make_series(
  vals : Array[Double],
  name : String,
) -> ChemmolpropsmwSeries {
  { vals, name, meta: 0, }
}

///|
pub fn ChemmolpropsmwSeries::len(self : ChemmolpropsmwSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn ChemmolpropsmwSeries::sum(self : ChemmolpropsmwSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn ChemmolpropsmwSeries::mean(self : ChemmolpropsmwSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn ChemmolpropsmwSeries::min(self : ChemmolpropsmwSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn ChemmolpropsmwSeries::max(self : ChemmolpropsmwSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn ChemmolpropsmwSeries::range(self : ChemmolpropsmwSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn ChemmolpropsmwSeries::variance(self : ChemmolpropsmwSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn ChemmolpropsmwSeries::std(self : ChemmolpropsmwSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn ChemmolpropsmwSeries::median(self : ChemmolpropsmwSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn ChemmolpropsmwSeries::scale(
  self : ChemmolpropsmwSeries,
  f : Double,
) -> ChemmolpropsmwSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn ChemmolpropsmwSeries::add(
  self : ChemmolpropsmwSeries,
  other : ChemmolpropsmwSeries,
) -> ChemmolpropsmwSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn ChemmolpropsmwSeries::sub(
  self : ChemmolpropsmwSeries,
  other : ChemmolpropsmwSeries,
) -> ChemmolpropsmwSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn ChemmolpropsmwSeries::normalize(
  self : ChemmolpropsmwSeries,
) -> ChemmolpropsmwSeries {
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
pub fn ChemmolpropsmwSeries::cumsum(
  self : ChemmolpropsmwSeries,
) -> ChemmolpropsmwSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn ChemmolpropsmwSeries::to_string(self : ChemmolpropsmwSeries) -> String {
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
pub(all) struct ChemmolpropsmwMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn chem_mol_props_mw_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> ChemmolpropsmwMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn chem_mol_props_mw_matrix_identity(n : Int32) -> ChemmolpropsmwMatrix {
  let m = chem_mol_props_mw_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn ChemmolpropsmwMatrix::get(
  self : ChemmolpropsmwMatrix,
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
pub fn ChemmolpropsmwMatrix::transpose(
  self : ChemmolpropsmwMatrix,
) -> ChemmolpropsmwMatrix {
  let result = chem_mol_props_mw_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn ChemmolpropsmwMatrix::add(
  self : ChemmolpropsmwMatrix,
  other : ChemmolpropsmwMatrix,
) -> ChemmolpropsmwMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = chem_mol_props_mw_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn ChemmolpropsmwMatrix::scale(
  self : ChemmolpropsmwMatrix,
  s : Double,
) -> ChemmolpropsmwMatrix {
  let result = chem_mol_props_mw_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn ChemmolpropsmwMatrix::multiply(
  self : ChemmolpropsmwMatrix,
  other : ChemmolpropsmwMatrix,
) -> ChemmolpropsmwMatrix {
  if self.cols != other.rows {
    return chem_mol_props_mw_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = chem_mol_props_mw_make_matrix(self.rows, other.cols, 0.0)
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
pub fn ChemmolpropsmwMatrix::trace(self : ChemmolpropsmwMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn ChemmolpropsmwMatrix::det(self : ChemmolpropsmwMatrix) -> Double {
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
pub fn ChemmolpropsmwMatrix::norm(self : ChemmolpropsmwMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn ChemmolpropsmwMatrix::to_string(self : ChemmolpropsmwMatrix) -> String {
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
pub(all) struct ChemmolpropsmwVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn chem_mol_props_mw_make_vector(
  comps : Array[Double],
) -> ChemmolpropsmwVector {
  { comps, dim: comps.length(), }
}

///|
pub fn chem_mol_props_mw_vector_zero(dim : Int32) -> ChemmolpropsmwVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn ChemmolpropsmwVector::add(
  self : ChemmolpropsmwVector,
  other : ChemmolpropsmwVector,
) -> ChemmolpropsmwVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn ChemmolpropsmwVector::sub(
  self : ChemmolpropsmwVector,
  other : ChemmolpropsmwVector,
) -> ChemmolpropsmwVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn ChemmolpropsmwVector::scale(
  self : ChemmolpropsmwVector,
  s : Double,
) -> ChemmolpropsmwVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn ChemmolpropsmwVector::dot(
  self : ChemmolpropsmwVector,
  other : ChemmolpropsmwVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn ChemmolpropsmwVector::norm(self : ChemmolpropsmwVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn ChemmolpropsmwVector::normalize(
  self : ChemmolpropsmwVector,
) -> ChemmolpropsmwVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn ChemmolpropsmwVector::dist(
  self : ChemmolpropsmwVector,
  other : ChemmolpropsmwVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn ChemmolpropsmwVector::to_string(self : ChemmolpropsmwVector) -> String {
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
pub(all) struct ChemmolpropsmwFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_props_mw_frame_make(size : Int32) -> ChemmolpropsmwFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolpropsmwFrame::len(self : ChemmolpropsmwFrame) -> Int32 {
  self.size
}

///|
pub fn ChemmolpropsmwFrame::get(
  self : ChemmolpropsmwFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolpropsmwFrame::set(
  self : ChemmolpropsmwFrame,
  i : Int32,
  v : Double,
) -> ChemmolpropsmwFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwFrame::sum(self : ChemmolpropsmwFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolpropsmwFrame::mean(self : ChemmolpropsmwFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolpropsmwFrame::scale(
  self : ChemmolpropsmwFrame,
  f : Double,
) -> ChemmolpropsmwFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwFrame::add(
  self : ChemmolpropsmwFrame,
  other : ChemmolpropsmwFrame,
) -> ChemmolpropsmwFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwFrame::copy(
  self : ChemmolpropsmwFrame,
) -> ChemmolpropsmwFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwFrame::fill(
  self : ChemmolpropsmwFrame,
  v : Double,
) -> ChemmolpropsmwFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwFrame::min(self : ChemmolpropsmwFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolpropsmwFrame::max(self : ChemmolpropsmwFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolpropsmwFrame::to_string(self : ChemmolpropsmwFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolpropsmwTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_props_mw_table_make(size : Int32) -> ChemmolpropsmwTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolpropsmwTable::len(self : ChemmolpropsmwTable) -> Int32 {
  self.size
}

///|
pub fn ChemmolpropsmwTable::get(
  self : ChemmolpropsmwTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolpropsmwTable::set(
  self : ChemmolpropsmwTable,
  i : Int32,
  v : Double,
) -> ChemmolpropsmwTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwTable::sum(self : ChemmolpropsmwTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolpropsmwTable::mean(self : ChemmolpropsmwTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolpropsmwTable::scale(
  self : ChemmolpropsmwTable,
  f : Double,
) -> ChemmolpropsmwTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwTable::add(
  self : ChemmolpropsmwTable,
  other : ChemmolpropsmwTable,
) -> ChemmolpropsmwTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwTable::copy(
  self : ChemmolpropsmwTable,
) -> ChemmolpropsmwTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwTable::fill(
  self : ChemmolpropsmwTable,
  v : Double,
) -> ChemmolpropsmwTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwTable::min(self : ChemmolpropsmwTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolpropsmwTable::max(self : ChemmolpropsmwTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolpropsmwTable::to_string(self : ChemmolpropsmwTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolpropsmwGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_props_mw_graphn_make(size : Int32) -> ChemmolpropsmwGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolpropsmwGraphN::len(self : ChemmolpropsmwGraphN) -> Int32 {
  self.size
}

///|
pub fn ChemmolpropsmwGraphN::get(
  self : ChemmolpropsmwGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolpropsmwGraphN::set(
  self : ChemmolpropsmwGraphN,
  i : Int32,
  v : Double,
) -> ChemmolpropsmwGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwGraphN::sum(self : ChemmolpropsmwGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolpropsmwGraphN::mean(self : ChemmolpropsmwGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolpropsmwGraphN::scale(
  self : ChemmolpropsmwGraphN,
  f : Double,
) -> ChemmolpropsmwGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwGraphN::add(
  self : ChemmolpropsmwGraphN,
  other : ChemmolpropsmwGraphN,
) -> ChemmolpropsmwGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwGraphN::copy(
  self : ChemmolpropsmwGraphN,
) -> ChemmolpropsmwGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwGraphN::fill(
  self : ChemmolpropsmwGraphN,
  v : Double,
) -> ChemmolpropsmwGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwGraphN::min(self : ChemmolpropsmwGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolpropsmwGraphN::max(self : ChemmolpropsmwGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolpropsmwGraphN::to_string(self : ChemmolpropsmwGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolpropsmwNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_props_mw_node_make(size : Int32) -> ChemmolpropsmwNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolpropsmwNode::len(self : ChemmolpropsmwNode) -> Int32 {
  self.size
}

///|
pub fn ChemmolpropsmwNode::get(self : ChemmolpropsmwNode, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolpropsmwNode::set(
  self : ChemmolpropsmwNode,
  i : Int32,
  v : Double,
) -> ChemmolpropsmwNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwNode::sum(self : ChemmolpropsmwNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolpropsmwNode::mean(self : ChemmolpropsmwNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolpropsmwNode::scale(
  self : ChemmolpropsmwNode,
  f : Double,
) -> ChemmolpropsmwNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwNode::add(
  self : ChemmolpropsmwNode,
  other : ChemmolpropsmwNode,
) -> ChemmolpropsmwNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwNode::copy(
  self : ChemmolpropsmwNode,
) -> ChemmolpropsmwNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwNode::fill(
  self : ChemmolpropsmwNode,
  v : Double,
) -> ChemmolpropsmwNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwNode::min(self : ChemmolpropsmwNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolpropsmwNode::max(self : ChemmolpropsmwNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolpropsmwNode::to_string(self : ChemmolpropsmwNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolpropsmwEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_props_mw_edge_make(size : Int32) -> ChemmolpropsmwEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolpropsmwEdge::len(self : ChemmolpropsmwEdge) -> Int32 {
  self.size
}

///|
pub fn ChemmolpropsmwEdge::get(self : ChemmolpropsmwEdge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolpropsmwEdge::set(
  self : ChemmolpropsmwEdge,
  i : Int32,
  v : Double,
) -> ChemmolpropsmwEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwEdge::sum(self : ChemmolpropsmwEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolpropsmwEdge::mean(self : ChemmolpropsmwEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolpropsmwEdge::scale(
  self : ChemmolpropsmwEdge,
  f : Double,
) -> ChemmolpropsmwEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwEdge::add(
  self : ChemmolpropsmwEdge,
  other : ChemmolpropsmwEdge,
) -> ChemmolpropsmwEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwEdge::copy(
  self : ChemmolpropsmwEdge,
) -> ChemmolpropsmwEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwEdge::fill(
  self : ChemmolpropsmwEdge,
  v : Double,
) -> ChemmolpropsmwEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwEdge::min(self : ChemmolpropsmwEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolpropsmwEdge::max(self : ChemmolpropsmwEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolpropsmwEdge::to_string(self : ChemmolpropsmwEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolpropsmwPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_props_mw_path_make(size : Int32) -> ChemmolpropsmwPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolpropsmwPath::len(self : ChemmolpropsmwPath) -> Int32 {
  self.size
}

///|
pub fn ChemmolpropsmwPath::get(self : ChemmolpropsmwPath, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolpropsmwPath::set(
  self : ChemmolpropsmwPath,
  i : Int32,
  v : Double,
) -> ChemmolpropsmwPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwPath::sum(self : ChemmolpropsmwPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolpropsmwPath::mean(self : ChemmolpropsmwPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolpropsmwPath::scale(
  self : ChemmolpropsmwPath,
  f : Double,
) -> ChemmolpropsmwPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwPath::add(
  self : ChemmolpropsmwPath,
  other : ChemmolpropsmwPath,
) -> ChemmolpropsmwPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwPath::copy(
  self : ChemmolpropsmwPath,
) -> ChemmolpropsmwPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwPath::fill(
  self : ChemmolpropsmwPath,
  v : Double,
) -> ChemmolpropsmwPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwPath::min(self : ChemmolpropsmwPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolpropsmwPath::max(self : ChemmolpropsmwPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolpropsmwPath::to_string(self : ChemmolpropsmwPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolpropsmwCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_props_mw_cluster_make(size : Int32) -> ChemmolpropsmwCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolpropsmwCluster::len(self : ChemmolpropsmwCluster) -> Int32 {
  self.size
}

///|
pub fn ChemmolpropsmwCluster::get(
  self : ChemmolpropsmwCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolpropsmwCluster::set(
  self : ChemmolpropsmwCluster,
  i : Int32,
  v : Double,
) -> ChemmolpropsmwCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwCluster::sum(self : ChemmolpropsmwCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolpropsmwCluster::mean(self : ChemmolpropsmwCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolpropsmwCluster::scale(
  self : ChemmolpropsmwCluster,
  f : Double,
) -> ChemmolpropsmwCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwCluster::add(
  self : ChemmolpropsmwCluster,
  other : ChemmolpropsmwCluster,
) -> ChemmolpropsmwCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwCluster::copy(
  self : ChemmolpropsmwCluster,
) -> ChemmolpropsmwCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwCluster::fill(
  self : ChemmolpropsmwCluster,
  v : Double,
) -> ChemmolpropsmwCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwCluster::min(self : ChemmolpropsmwCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolpropsmwCluster::max(self : ChemmolpropsmwCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolpropsmwCluster::to_string(self : ChemmolpropsmwCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolpropsmwModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_props_mw_model_make(size : Int32) -> ChemmolpropsmwModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolpropsmwModel::len(self : ChemmolpropsmwModel) -> Int32 {
  self.size
}

///|
pub fn ChemmolpropsmwModel::get(
  self : ChemmolpropsmwModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolpropsmwModel::set(
  self : ChemmolpropsmwModel,
  i : Int32,
  v : Double,
) -> ChemmolpropsmwModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwModel::sum(self : ChemmolpropsmwModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolpropsmwModel::mean(self : ChemmolpropsmwModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolpropsmwModel::scale(
  self : ChemmolpropsmwModel,
  f : Double,
) -> ChemmolpropsmwModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwModel::add(
  self : ChemmolpropsmwModel,
  other : ChemmolpropsmwModel,
) -> ChemmolpropsmwModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwModel::copy(
  self : ChemmolpropsmwModel,
) -> ChemmolpropsmwModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwModel::fill(
  self : ChemmolpropsmwModel,
  v : Double,
) -> ChemmolpropsmwModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwModel::min(self : ChemmolpropsmwModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolpropsmwModel::max(self : ChemmolpropsmwModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolpropsmwModel::to_string(self : ChemmolpropsmwModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolpropsmwLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_props_mw_layer_make(size : Int32) -> ChemmolpropsmwLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolpropsmwLayer::len(self : ChemmolpropsmwLayer) -> Int32 {
  self.size
}

///|
pub fn ChemmolpropsmwLayer::get(
  self : ChemmolpropsmwLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolpropsmwLayer::set(
  self : ChemmolpropsmwLayer,
  i : Int32,
  v : Double,
) -> ChemmolpropsmwLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwLayer::sum(self : ChemmolpropsmwLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolpropsmwLayer::mean(self : ChemmolpropsmwLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolpropsmwLayer::scale(
  self : ChemmolpropsmwLayer,
  f : Double,
) -> ChemmolpropsmwLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwLayer::add(
  self : ChemmolpropsmwLayer,
  other : ChemmolpropsmwLayer,
) -> ChemmolpropsmwLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwLayer::copy(
  self : ChemmolpropsmwLayer,
) -> ChemmolpropsmwLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwLayer::fill(
  self : ChemmolpropsmwLayer,
  v : Double,
) -> ChemmolpropsmwLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwLayer::min(self : ChemmolpropsmwLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolpropsmwLayer::max(self : ChemmolpropsmwLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolpropsmwLayer::to_string(self : ChemmolpropsmwLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolpropsmwBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_props_mw_buffer_make(size : Int32) -> ChemmolpropsmwBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolpropsmwBuffer::len(self : ChemmolpropsmwBuffer) -> Int32 {
  self.size
}

///|
pub fn ChemmolpropsmwBuffer::get(
  self : ChemmolpropsmwBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolpropsmwBuffer::set(
  self : ChemmolpropsmwBuffer,
  i : Int32,
  v : Double,
) -> ChemmolpropsmwBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwBuffer::sum(self : ChemmolpropsmwBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolpropsmwBuffer::mean(self : ChemmolpropsmwBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolpropsmwBuffer::scale(
  self : ChemmolpropsmwBuffer,
  f : Double,
) -> ChemmolpropsmwBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwBuffer::add(
  self : ChemmolpropsmwBuffer,
  other : ChemmolpropsmwBuffer,
) -> ChemmolpropsmwBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwBuffer::copy(
  self : ChemmolpropsmwBuffer,
) -> ChemmolpropsmwBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwBuffer::fill(
  self : ChemmolpropsmwBuffer,
  v : Double,
) -> ChemmolpropsmwBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwBuffer::min(self : ChemmolpropsmwBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolpropsmwBuffer::max(self : ChemmolpropsmwBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolpropsmwBuffer::to_string(self : ChemmolpropsmwBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolpropsmwCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_props_mw_cursor_make(size : Int32) -> ChemmolpropsmwCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolpropsmwCursor::len(self : ChemmolpropsmwCursor) -> Int32 {
  self.size
}

///|
pub fn ChemmolpropsmwCursor::get(
  self : ChemmolpropsmwCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolpropsmwCursor::set(
  self : ChemmolpropsmwCursor,
  i : Int32,
  v : Double,
) -> ChemmolpropsmwCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwCursor::sum(self : ChemmolpropsmwCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolpropsmwCursor::mean(self : ChemmolpropsmwCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolpropsmwCursor::scale(
  self : ChemmolpropsmwCursor,
  f : Double,
) -> ChemmolpropsmwCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwCursor::add(
  self : ChemmolpropsmwCursor,
  other : ChemmolpropsmwCursor,
) -> ChemmolpropsmwCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwCursor::copy(
  self : ChemmolpropsmwCursor,
) -> ChemmolpropsmwCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwCursor::fill(
  self : ChemmolpropsmwCursor,
  v : Double,
) -> ChemmolpropsmwCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwCursor::min(self : ChemmolpropsmwCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolpropsmwCursor::max(self : ChemmolpropsmwCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolpropsmwCursor::to_string(self : ChemmolpropsmwCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolpropsmwView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_props_mw_view_make(size : Int32) -> ChemmolpropsmwView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolpropsmwView::len(self : ChemmolpropsmwView) -> Int32 {
  self.size
}

///|
pub fn ChemmolpropsmwView::get(self : ChemmolpropsmwView, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolpropsmwView::set(
  self : ChemmolpropsmwView,
  i : Int32,
  v : Double,
) -> ChemmolpropsmwView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwView::sum(self : ChemmolpropsmwView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolpropsmwView::mean(self : ChemmolpropsmwView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolpropsmwView::scale(
  self : ChemmolpropsmwView,
  f : Double,
) -> ChemmolpropsmwView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwView::add(
  self : ChemmolpropsmwView,
  other : ChemmolpropsmwView,
) -> ChemmolpropsmwView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwView::copy(
  self : ChemmolpropsmwView,
) -> ChemmolpropsmwView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwView::fill(
  self : ChemmolpropsmwView,
  v : Double,
) -> ChemmolpropsmwView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwView::min(self : ChemmolpropsmwView) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolpropsmwView::max(self : ChemmolpropsmwView) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolpropsmwView::to_string(self : ChemmolpropsmwView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolpropsmwRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_props_mw_range_make(size : Int32) -> ChemmolpropsmwRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolpropsmwRange::len(self : ChemmolpropsmwRange) -> Int32 {
  self.size
}

///|
pub fn ChemmolpropsmwRange::get(
  self : ChemmolpropsmwRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolpropsmwRange::set(
  self : ChemmolpropsmwRange,
  i : Int32,
  v : Double,
) -> ChemmolpropsmwRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwRange::sum(self : ChemmolpropsmwRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolpropsmwRange::mean(self : ChemmolpropsmwRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolpropsmwRange::scale(
  self : ChemmolpropsmwRange,
  f : Double,
) -> ChemmolpropsmwRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwRange::add(
  self : ChemmolpropsmwRange,
  other : ChemmolpropsmwRange,
) -> ChemmolpropsmwRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwRange::copy(
  self : ChemmolpropsmwRange,
) -> ChemmolpropsmwRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwRange::fill(
  self : ChemmolpropsmwRange,
  v : Double,
) -> ChemmolpropsmwRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwRange::min(self : ChemmolpropsmwRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolpropsmwRange::max(self : ChemmolpropsmwRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolpropsmwRange::to_string(self : ChemmolpropsmwRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolpropsmwSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_props_mw_slice_make(size : Int32) -> ChemmolpropsmwSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolpropsmwSlice::len(self : ChemmolpropsmwSlice) -> Int32 {
  self.size
}

///|
pub fn ChemmolpropsmwSlice::get(
  self : ChemmolpropsmwSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolpropsmwSlice::set(
  self : ChemmolpropsmwSlice,
  i : Int32,
  v : Double,
) -> ChemmolpropsmwSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwSlice::sum(self : ChemmolpropsmwSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolpropsmwSlice::mean(self : ChemmolpropsmwSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolpropsmwSlice::scale(
  self : ChemmolpropsmwSlice,
  f : Double,
) -> ChemmolpropsmwSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwSlice::add(
  self : ChemmolpropsmwSlice,
  other : ChemmolpropsmwSlice,
) -> ChemmolpropsmwSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwSlice::copy(
  self : ChemmolpropsmwSlice,
) -> ChemmolpropsmwSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwSlice::fill(
  self : ChemmolpropsmwSlice,
  v : Double,
) -> ChemmolpropsmwSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropsmwSlice::min(self : ChemmolpropsmwSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolpropsmwSlice::max(self : ChemmolpropsmwSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolpropsmwSlice::to_string(self : ChemmolpropsmwSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
