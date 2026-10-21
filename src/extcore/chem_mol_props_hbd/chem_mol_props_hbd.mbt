///|
///===
/// extcore/chem_mol_props_hbd
pub(all) struct ChemmolpropshbdPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn chem_mol_props_hbd_make_point(
  x : Double,
  y : Double,
) -> ChemmolpropshbdPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn chem_mol_props_hbd_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> ChemmolpropshbdPoint {
  { x, y, z, label: 0, }
}

///|
pub fn ChemmolpropshbdPoint::x(self : ChemmolpropshbdPoint) -> Double {
  self.x
}

///|
pub fn ChemmolpropshbdPoint::y(self : ChemmolpropshbdPoint) -> Double {
  self.y
}

///|
pub fn ChemmolpropshbdPoint::z(self : ChemmolpropshbdPoint) -> Double {
  self.z
}

///|
pub fn ChemmolpropshbdPoint::label(self : ChemmolpropshbdPoint) -> Int32 {
  self.label
}

///|
pub fn ChemmolpropshbdPoint::dist(
  self : ChemmolpropshbdPoint,
  other : ChemmolpropshbdPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn ChemmolpropshbdPoint::add(
  self : ChemmolpropshbdPoint,
  other : ChemmolpropshbdPoint,
) -> ChemmolpropshbdPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn ChemmolpropshbdPoint::sub(
  self : ChemmolpropshbdPoint,
  other : ChemmolpropshbdPoint,
) -> ChemmolpropshbdPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn ChemmolpropshbdPoint::scale(
  self : ChemmolpropshbdPoint,
  s : Double,
) -> ChemmolpropshbdPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn ChemmolpropshbdPoint::dot(
  self : ChemmolpropshbdPoint,
  other : ChemmolpropshbdPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn ChemmolpropshbdPoint::cross(
  self : ChemmolpropshbdPoint,
  other : ChemmolpropshbdPoint,
) -> ChemmolpropshbdPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn ChemmolpropshbdPoint::norm(self : ChemmolpropshbdPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn ChemmolpropshbdPoint::normalize(
  self : ChemmolpropshbdPoint,
) -> ChemmolpropshbdPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn ChemmolpropshbdPoint::negate(
  self : ChemmolpropshbdPoint,
) -> ChemmolpropshbdPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn ChemmolpropshbdPoint::mid(
  self : ChemmolpropshbdPoint,
  other : ChemmolpropshbdPoint,
) -> ChemmolpropshbdPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn ChemmolpropshbdPoint::lerp(
  self : ChemmolpropshbdPoint,
  other : ChemmolpropshbdPoint,
  t : Double,
) -> ChemmolpropshbdPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn ChemmolpropshbdPoint::to_string(self : ChemmolpropshbdPoint) -> String {
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
pub(all) struct ChemmolpropshbdSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn chem_mol_props_hbd_make_series(
  vals : Array[Double],
  name : String,
) -> ChemmolpropshbdSeries {
  { vals, name, meta: 0, }
}

///|
pub fn ChemmolpropshbdSeries::len(self : ChemmolpropshbdSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn ChemmolpropshbdSeries::sum(self : ChemmolpropshbdSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn ChemmolpropshbdSeries::mean(self : ChemmolpropshbdSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn ChemmolpropshbdSeries::min(self : ChemmolpropshbdSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn ChemmolpropshbdSeries::max(self : ChemmolpropshbdSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn ChemmolpropshbdSeries::range(self : ChemmolpropshbdSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn ChemmolpropshbdSeries::variance(self : ChemmolpropshbdSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn ChemmolpropshbdSeries::std(self : ChemmolpropshbdSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn ChemmolpropshbdSeries::median(self : ChemmolpropshbdSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn ChemmolpropshbdSeries::scale(
  self : ChemmolpropshbdSeries,
  f : Double,
) -> ChemmolpropshbdSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn ChemmolpropshbdSeries::add(
  self : ChemmolpropshbdSeries,
  other : ChemmolpropshbdSeries,
) -> ChemmolpropshbdSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn ChemmolpropshbdSeries::sub(
  self : ChemmolpropshbdSeries,
  other : ChemmolpropshbdSeries,
) -> ChemmolpropshbdSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn ChemmolpropshbdSeries::normalize(
  self : ChemmolpropshbdSeries,
) -> ChemmolpropshbdSeries {
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
pub fn ChemmolpropshbdSeries::cumsum(
  self : ChemmolpropshbdSeries,
) -> ChemmolpropshbdSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn ChemmolpropshbdSeries::to_string(self : ChemmolpropshbdSeries) -> String {
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
pub(all) struct ChemmolpropshbdMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn chem_mol_props_hbd_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> ChemmolpropshbdMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn chem_mol_props_hbd_matrix_identity(n : Int32) -> ChemmolpropshbdMatrix {
  let m = chem_mol_props_hbd_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn ChemmolpropshbdMatrix::get(
  self : ChemmolpropshbdMatrix,
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
pub fn ChemmolpropshbdMatrix::transpose(
  self : ChemmolpropshbdMatrix,
) -> ChemmolpropshbdMatrix {
  let result = chem_mol_props_hbd_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn ChemmolpropshbdMatrix::add(
  self : ChemmolpropshbdMatrix,
  other : ChemmolpropshbdMatrix,
) -> ChemmolpropshbdMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = chem_mol_props_hbd_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn ChemmolpropshbdMatrix::scale(
  self : ChemmolpropshbdMatrix,
  s : Double,
) -> ChemmolpropshbdMatrix {
  let result = chem_mol_props_hbd_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn ChemmolpropshbdMatrix::multiply(
  self : ChemmolpropshbdMatrix,
  other : ChemmolpropshbdMatrix,
) -> ChemmolpropshbdMatrix {
  if self.cols != other.rows {
    return chem_mol_props_hbd_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = chem_mol_props_hbd_make_matrix(self.rows, other.cols, 0.0)
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
pub fn ChemmolpropshbdMatrix::trace(self : ChemmolpropshbdMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn ChemmolpropshbdMatrix::det(self : ChemmolpropshbdMatrix) -> Double {
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
pub fn ChemmolpropshbdMatrix::norm(self : ChemmolpropshbdMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn ChemmolpropshbdMatrix::to_string(self : ChemmolpropshbdMatrix) -> String {
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
pub(all) struct ChemmolpropshbdVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn chem_mol_props_hbd_make_vector(
  comps : Array[Double],
) -> ChemmolpropshbdVector {
  { comps, dim: comps.length(), }
}

///|
pub fn chem_mol_props_hbd_vector_zero(dim : Int32) -> ChemmolpropshbdVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn ChemmolpropshbdVector::add(
  self : ChemmolpropshbdVector,
  other : ChemmolpropshbdVector,
) -> ChemmolpropshbdVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn ChemmolpropshbdVector::sub(
  self : ChemmolpropshbdVector,
  other : ChemmolpropshbdVector,
) -> ChemmolpropshbdVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn ChemmolpropshbdVector::scale(
  self : ChemmolpropshbdVector,
  s : Double,
) -> ChemmolpropshbdVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn ChemmolpropshbdVector::dot(
  self : ChemmolpropshbdVector,
  other : ChemmolpropshbdVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn ChemmolpropshbdVector::norm(self : ChemmolpropshbdVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn ChemmolpropshbdVector::normalize(
  self : ChemmolpropshbdVector,
) -> ChemmolpropshbdVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn ChemmolpropshbdVector::dist(
  self : ChemmolpropshbdVector,
  other : ChemmolpropshbdVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn ChemmolpropshbdVector::to_string(self : ChemmolpropshbdVector) -> String {
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
pub(all) struct ChemmolpropshbdFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_props_hbd_frame_make(size : Int32) -> ChemmolpropshbdFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolpropshbdFrame::len(self : ChemmolpropshbdFrame) -> Int32 {
  self.size
}

///|
pub fn ChemmolpropshbdFrame::get(
  self : ChemmolpropshbdFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolpropshbdFrame::set(
  self : ChemmolpropshbdFrame,
  i : Int32,
  v : Double,
) -> ChemmolpropshbdFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdFrame::sum(self : ChemmolpropshbdFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolpropshbdFrame::mean(self : ChemmolpropshbdFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolpropshbdFrame::scale(
  self : ChemmolpropshbdFrame,
  f : Double,
) -> ChemmolpropshbdFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdFrame::add(
  self : ChemmolpropshbdFrame,
  other : ChemmolpropshbdFrame,
) -> ChemmolpropshbdFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdFrame::copy(
  self : ChemmolpropshbdFrame,
) -> ChemmolpropshbdFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdFrame::fill(
  self : ChemmolpropshbdFrame,
  v : Double,
) -> ChemmolpropshbdFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdFrame::min(self : ChemmolpropshbdFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolpropshbdFrame::max(self : ChemmolpropshbdFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolpropshbdFrame::to_string(self : ChemmolpropshbdFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolpropshbdTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_props_hbd_table_make(size : Int32) -> ChemmolpropshbdTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolpropshbdTable::len(self : ChemmolpropshbdTable) -> Int32 {
  self.size
}

///|
pub fn ChemmolpropshbdTable::get(
  self : ChemmolpropshbdTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolpropshbdTable::set(
  self : ChemmolpropshbdTable,
  i : Int32,
  v : Double,
) -> ChemmolpropshbdTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdTable::sum(self : ChemmolpropshbdTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolpropshbdTable::mean(self : ChemmolpropshbdTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolpropshbdTable::scale(
  self : ChemmolpropshbdTable,
  f : Double,
) -> ChemmolpropshbdTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdTable::add(
  self : ChemmolpropshbdTable,
  other : ChemmolpropshbdTable,
) -> ChemmolpropshbdTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdTable::copy(
  self : ChemmolpropshbdTable,
) -> ChemmolpropshbdTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdTable::fill(
  self : ChemmolpropshbdTable,
  v : Double,
) -> ChemmolpropshbdTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdTable::min(self : ChemmolpropshbdTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolpropshbdTable::max(self : ChemmolpropshbdTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolpropshbdTable::to_string(self : ChemmolpropshbdTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolpropshbdGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_props_hbd_graphn_make(size : Int32) -> ChemmolpropshbdGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolpropshbdGraphN::len(self : ChemmolpropshbdGraphN) -> Int32 {
  self.size
}

///|
pub fn ChemmolpropshbdGraphN::get(
  self : ChemmolpropshbdGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolpropshbdGraphN::set(
  self : ChemmolpropshbdGraphN,
  i : Int32,
  v : Double,
) -> ChemmolpropshbdGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdGraphN::sum(self : ChemmolpropshbdGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolpropshbdGraphN::mean(self : ChemmolpropshbdGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolpropshbdGraphN::scale(
  self : ChemmolpropshbdGraphN,
  f : Double,
) -> ChemmolpropshbdGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdGraphN::add(
  self : ChemmolpropshbdGraphN,
  other : ChemmolpropshbdGraphN,
) -> ChemmolpropshbdGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdGraphN::copy(
  self : ChemmolpropshbdGraphN,
) -> ChemmolpropshbdGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdGraphN::fill(
  self : ChemmolpropshbdGraphN,
  v : Double,
) -> ChemmolpropshbdGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdGraphN::min(self : ChemmolpropshbdGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolpropshbdGraphN::max(self : ChemmolpropshbdGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolpropshbdGraphN::to_string(self : ChemmolpropshbdGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolpropshbdNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_props_hbd_node_make(size : Int32) -> ChemmolpropshbdNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolpropshbdNode::len(self : ChemmolpropshbdNode) -> Int32 {
  self.size
}

///|
pub fn ChemmolpropshbdNode::get(
  self : ChemmolpropshbdNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolpropshbdNode::set(
  self : ChemmolpropshbdNode,
  i : Int32,
  v : Double,
) -> ChemmolpropshbdNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdNode::sum(self : ChemmolpropshbdNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolpropshbdNode::mean(self : ChemmolpropshbdNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolpropshbdNode::scale(
  self : ChemmolpropshbdNode,
  f : Double,
) -> ChemmolpropshbdNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdNode::add(
  self : ChemmolpropshbdNode,
  other : ChemmolpropshbdNode,
) -> ChemmolpropshbdNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdNode::copy(
  self : ChemmolpropshbdNode,
) -> ChemmolpropshbdNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdNode::fill(
  self : ChemmolpropshbdNode,
  v : Double,
) -> ChemmolpropshbdNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdNode::min(self : ChemmolpropshbdNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolpropshbdNode::max(self : ChemmolpropshbdNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolpropshbdNode::to_string(self : ChemmolpropshbdNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolpropshbdEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_props_hbd_edge_make(size : Int32) -> ChemmolpropshbdEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolpropshbdEdge::len(self : ChemmolpropshbdEdge) -> Int32 {
  self.size
}

///|
pub fn ChemmolpropshbdEdge::get(
  self : ChemmolpropshbdEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolpropshbdEdge::set(
  self : ChemmolpropshbdEdge,
  i : Int32,
  v : Double,
) -> ChemmolpropshbdEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdEdge::sum(self : ChemmolpropshbdEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolpropshbdEdge::mean(self : ChemmolpropshbdEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolpropshbdEdge::scale(
  self : ChemmolpropshbdEdge,
  f : Double,
) -> ChemmolpropshbdEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdEdge::add(
  self : ChemmolpropshbdEdge,
  other : ChemmolpropshbdEdge,
) -> ChemmolpropshbdEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdEdge::copy(
  self : ChemmolpropshbdEdge,
) -> ChemmolpropshbdEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdEdge::fill(
  self : ChemmolpropshbdEdge,
  v : Double,
) -> ChemmolpropshbdEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdEdge::min(self : ChemmolpropshbdEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolpropshbdEdge::max(self : ChemmolpropshbdEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolpropshbdEdge::to_string(self : ChemmolpropshbdEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolpropshbdPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_props_hbd_path_make(size : Int32) -> ChemmolpropshbdPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolpropshbdPath::len(self : ChemmolpropshbdPath) -> Int32 {
  self.size
}

///|
pub fn ChemmolpropshbdPath::get(
  self : ChemmolpropshbdPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolpropshbdPath::set(
  self : ChemmolpropshbdPath,
  i : Int32,
  v : Double,
) -> ChemmolpropshbdPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdPath::sum(self : ChemmolpropshbdPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolpropshbdPath::mean(self : ChemmolpropshbdPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolpropshbdPath::scale(
  self : ChemmolpropshbdPath,
  f : Double,
) -> ChemmolpropshbdPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdPath::add(
  self : ChemmolpropshbdPath,
  other : ChemmolpropshbdPath,
) -> ChemmolpropshbdPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdPath::copy(
  self : ChemmolpropshbdPath,
) -> ChemmolpropshbdPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdPath::fill(
  self : ChemmolpropshbdPath,
  v : Double,
) -> ChemmolpropshbdPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdPath::min(self : ChemmolpropshbdPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolpropshbdPath::max(self : ChemmolpropshbdPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolpropshbdPath::to_string(self : ChemmolpropshbdPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolpropshbdCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_props_hbd_cluster_make(size : Int32) -> ChemmolpropshbdCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolpropshbdCluster::len(self : ChemmolpropshbdCluster) -> Int32 {
  self.size
}

///|
pub fn ChemmolpropshbdCluster::get(
  self : ChemmolpropshbdCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolpropshbdCluster::set(
  self : ChemmolpropshbdCluster,
  i : Int32,
  v : Double,
) -> ChemmolpropshbdCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdCluster::sum(self : ChemmolpropshbdCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolpropshbdCluster::mean(self : ChemmolpropshbdCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolpropshbdCluster::scale(
  self : ChemmolpropshbdCluster,
  f : Double,
) -> ChemmolpropshbdCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdCluster::add(
  self : ChemmolpropshbdCluster,
  other : ChemmolpropshbdCluster,
) -> ChemmolpropshbdCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdCluster::copy(
  self : ChemmolpropshbdCluster,
) -> ChemmolpropshbdCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdCluster::fill(
  self : ChemmolpropshbdCluster,
  v : Double,
) -> ChemmolpropshbdCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdCluster::min(self : ChemmolpropshbdCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolpropshbdCluster::max(self : ChemmolpropshbdCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolpropshbdCluster::to_string(
  self : ChemmolpropshbdCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolpropshbdModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_props_hbd_model_make(size : Int32) -> ChemmolpropshbdModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolpropshbdModel::len(self : ChemmolpropshbdModel) -> Int32 {
  self.size
}

///|
pub fn ChemmolpropshbdModel::get(
  self : ChemmolpropshbdModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolpropshbdModel::set(
  self : ChemmolpropshbdModel,
  i : Int32,
  v : Double,
) -> ChemmolpropshbdModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdModel::sum(self : ChemmolpropshbdModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolpropshbdModel::mean(self : ChemmolpropshbdModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolpropshbdModel::scale(
  self : ChemmolpropshbdModel,
  f : Double,
) -> ChemmolpropshbdModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdModel::add(
  self : ChemmolpropshbdModel,
  other : ChemmolpropshbdModel,
) -> ChemmolpropshbdModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdModel::copy(
  self : ChemmolpropshbdModel,
) -> ChemmolpropshbdModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdModel::fill(
  self : ChemmolpropshbdModel,
  v : Double,
) -> ChemmolpropshbdModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdModel::min(self : ChemmolpropshbdModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolpropshbdModel::max(self : ChemmolpropshbdModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolpropshbdModel::to_string(self : ChemmolpropshbdModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolpropshbdLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_props_hbd_layer_make(size : Int32) -> ChemmolpropshbdLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolpropshbdLayer::len(self : ChemmolpropshbdLayer) -> Int32 {
  self.size
}

///|
pub fn ChemmolpropshbdLayer::get(
  self : ChemmolpropshbdLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolpropshbdLayer::set(
  self : ChemmolpropshbdLayer,
  i : Int32,
  v : Double,
) -> ChemmolpropshbdLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdLayer::sum(self : ChemmolpropshbdLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolpropshbdLayer::mean(self : ChemmolpropshbdLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolpropshbdLayer::scale(
  self : ChemmolpropshbdLayer,
  f : Double,
) -> ChemmolpropshbdLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdLayer::add(
  self : ChemmolpropshbdLayer,
  other : ChemmolpropshbdLayer,
) -> ChemmolpropshbdLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdLayer::copy(
  self : ChemmolpropshbdLayer,
) -> ChemmolpropshbdLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdLayer::fill(
  self : ChemmolpropshbdLayer,
  v : Double,
) -> ChemmolpropshbdLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdLayer::min(self : ChemmolpropshbdLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolpropshbdLayer::max(self : ChemmolpropshbdLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolpropshbdLayer::to_string(self : ChemmolpropshbdLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolpropshbdBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_props_hbd_buffer_make(size : Int32) -> ChemmolpropshbdBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolpropshbdBuffer::len(self : ChemmolpropshbdBuffer) -> Int32 {
  self.size
}

///|
pub fn ChemmolpropshbdBuffer::get(
  self : ChemmolpropshbdBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolpropshbdBuffer::set(
  self : ChemmolpropshbdBuffer,
  i : Int32,
  v : Double,
) -> ChemmolpropshbdBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdBuffer::sum(self : ChemmolpropshbdBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolpropshbdBuffer::mean(self : ChemmolpropshbdBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolpropshbdBuffer::scale(
  self : ChemmolpropshbdBuffer,
  f : Double,
) -> ChemmolpropshbdBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdBuffer::add(
  self : ChemmolpropshbdBuffer,
  other : ChemmolpropshbdBuffer,
) -> ChemmolpropshbdBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdBuffer::copy(
  self : ChemmolpropshbdBuffer,
) -> ChemmolpropshbdBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdBuffer::fill(
  self : ChemmolpropshbdBuffer,
  v : Double,
) -> ChemmolpropshbdBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdBuffer::min(self : ChemmolpropshbdBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolpropshbdBuffer::max(self : ChemmolpropshbdBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolpropshbdBuffer::to_string(self : ChemmolpropshbdBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolpropshbdCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_props_hbd_cursor_make(size : Int32) -> ChemmolpropshbdCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolpropshbdCursor::len(self : ChemmolpropshbdCursor) -> Int32 {
  self.size
}

///|
pub fn ChemmolpropshbdCursor::get(
  self : ChemmolpropshbdCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolpropshbdCursor::set(
  self : ChemmolpropshbdCursor,
  i : Int32,
  v : Double,
) -> ChemmolpropshbdCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdCursor::sum(self : ChemmolpropshbdCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolpropshbdCursor::mean(self : ChemmolpropshbdCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolpropshbdCursor::scale(
  self : ChemmolpropshbdCursor,
  f : Double,
) -> ChemmolpropshbdCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdCursor::add(
  self : ChemmolpropshbdCursor,
  other : ChemmolpropshbdCursor,
) -> ChemmolpropshbdCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdCursor::copy(
  self : ChemmolpropshbdCursor,
) -> ChemmolpropshbdCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdCursor::fill(
  self : ChemmolpropshbdCursor,
  v : Double,
) -> ChemmolpropshbdCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdCursor::min(self : ChemmolpropshbdCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolpropshbdCursor::max(self : ChemmolpropshbdCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolpropshbdCursor::to_string(self : ChemmolpropshbdCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolpropshbdView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_props_hbd_view_make(size : Int32) -> ChemmolpropshbdView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolpropshbdView::len(self : ChemmolpropshbdView) -> Int32 {
  self.size
}

///|
pub fn ChemmolpropshbdView::get(
  self : ChemmolpropshbdView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolpropshbdView::set(
  self : ChemmolpropshbdView,
  i : Int32,
  v : Double,
) -> ChemmolpropshbdView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdView::sum(self : ChemmolpropshbdView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolpropshbdView::mean(self : ChemmolpropshbdView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolpropshbdView::scale(
  self : ChemmolpropshbdView,
  f : Double,
) -> ChemmolpropshbdView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdView::add(
  self : ChemmolpropshbdView,
  other : ChemmolpropshbdView,
) -> ChemmolpropshbdView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdView::copy(
  self : ChemmolpropshbdView,
) -> ChemmolpropshbdView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdView::fill(
  self : ChemmolpropshbdView,
  v : Double,
) -> ChemmolpropshbdView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdView::min(self : ChemmolpropshbdView) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolpropshbdView::max(self : ChemmolpropshbdView) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolpropshbdView::to_string(self : ChemmolpropshbdView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolpropshbdRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_props_hbd_range_make(size : Int32) -> ChemmolpropshbdRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolpropshbdRange::len(self : ChemmolpropshbdRange) -> Int32 {
  self.size
}

///|
pub fn ChemmolpropshbdRange::get(
  self : ChemmolpropshbdRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolpropshbdRange::set(
  self : ChemmolpropshbdRange,
  i : Int32,
  v : Double,
) -> ChemmolpropshbdRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdRange::sum(self : ChemmolpropshbdRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolpropshbdRange::mean(self : ChemmolpropshbdRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolpropshbdRange::scale(
  self : ChemmolpropshbdRange,
  f : Double,
) -> ChemmolpropshbdRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdRange::add(
  self : ChemmolpropshbdRange,
  other : ChemmolpropshbdRange,
) -> ChemmolpropshbdRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdRange::copy(
  self : ChemmolpropshbdRange,
) -> ChemmolpropshbdRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdRange::fill(
  self : ChemmolpropshbdRange,
  v : Double,
) -> ChemmolpropshbdRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdRange::min(self : ChemmolpropshbdRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolpropshbdRange::max(self : ChemmolpropshbdRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolpropshbdRange::to_string(self : ChemmolpropshbdRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolpropshbdSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_props_hbd_slice_make(size : Int32) -> ChemmolpropshbdSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolpropshbdSlice::len(self : ChemmolpropshbdSlice) -> Int32 {
  self.size
}

///|
pub fn ChemmolpropshbdSlice::get(
  self : ChemmolpropshbdSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolpropshbdSlice::set(
  self : ChemmolpropshbdSlice,
  i : Int32,
  v : Double,
) -> ChemmolpropshbdSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdSlice::sum(self : ChemmolpropshbdSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolpropshbdSlice::mean(self : ChemmolpropshbdSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolpropshbdSlice::scale(
  self : ChemmolpropshbdSlice,
  f : Double,
) -> ChemmolpropshbdSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdSlice::add(
  self : ChemmolpropshbdSlice,
  other : ChemmolpropshbdSlice,
) -> ChemmolpropshbdSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdSlice::copy(
  self : ChemmolpropshbdSlice,
) -> ChemmolpropshbdSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdSlice::fill(
  self : ChemmolpropshbdSlice,
  v : Double,
) -> ChemmolpropshbdSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolpropshbdSlice::min(self : ChemmolpropshbdSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolpropshbdSlice::max(self : ChemmolpropshbdSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolpropshbdSlice::to_string(self : ChemmolpropshbdSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
