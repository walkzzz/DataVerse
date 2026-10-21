///|
///===
/// extcore/chem_mol_repr_canonical
pub(all) struct ChemmolreprcanonicalPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn chem_mol_repr_canonical_make_point(
  x : Double,
  y : Double,
) -> ChemmolreprcanonicalPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn chem_mol_repr_canonical_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> ChemmolreprcanonicalPoint {
  { x, y, z, label: 0, }
}

///|
pub fn ChemmolreprcanonicalPoint::x(self : ChemmolreprcanonicalPoint) -> Double {
  self.x
}

///|
pub fn ChemmolreprcanonicalPoint::y(self : ChemmolreprcanonicalPoint) -> Double {
  self.y
}

///|
pub fn ChemmolreprcanonicalPoint::z(self : ChemmolreprcanonicalPoint) -> Double {
  self.z
}

///|
pub fn ChemmolreprcanonicalPoint::label(
  self : ChemmolreprcanonicalPoint,
) -> Int32 {
  self.label
}

///|
pub fn ChemmolreprcanonicalPoint::dist(
  self : ChemmolreprcanonicalPoint,
  other : ChemmolreprcanonicalPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn ChemmolreprcanonicalPoint::add(
  self : ChemmolreprcanonicalPoint,
  other : ChemmolreprcanonicalPoint,
) -> ChemmolreprcanonicalPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn ChemmolreprcanonicalPoint::sub(
  self : ChemmolreprcanonicalPoint,
  other : ChemmolreprcanonicalPoint,
) -> ChemmolreprcanonicalPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn ChemmolreprcanonicalPoint::scale(
  self : ChemmolreprcanonicalPoint,
  s : Double,
) -> ChemmolreprcanonicalPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn ChemmolreprcanonicalPoint::dot(
  self : ChemmolreprcanonicalPoint,
  other : ChemmolreprcanonicalPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn ChemmolreprcanonicalPoint::cross(
  self : ChemmolreprcanonicalPoint,
  other : ChemmolreprcanonicalPoint,
) -> ChemmolreprcanonicalPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn ChemmolreprcanonicalPoint::norm(
  self : ChemmolreprcanonicalPoint,
) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn ChemmolreprcanonicalPoint::normalize(
  self : ChemmolreprcanonicalPoint,
) -> ChemmolreprcanonicalPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn ChemmolreprcanonicalPoint::negate(
  self : ChemmolreprcanonicalPoint,
) -> ChemmolreprcanonicalPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn ChemmolreprcanonicalPoint::mid(
  self : ChemmolreprcanonicalPoint,
  other : ChemmolreprcanonicalPoint,
) -> ChemmolreprcanonicalPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn ChemmolreprcanonicalPoint::lerp(
  self : ChemmolreprcanonicalPoint,
  other : ChemmolreprcanonicalPoint,
  t : Double,
) -> ChemmolreprcanonicalPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn ChemmolreprcanonicalPoint::to_string(
  self : ChemmolreprcanonicalPoint,
) -> String {
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
pub(all) struct ChemmolreprcanonicalSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn chem_mol_repr_canonical_make_series(
  vals : Array[Double],
  name : String,
) -> ChemmolreprcanonicalSeries {
  { vals, name, meta: 0, }
}

///|
pub fn ChemmolreprcanonicalSeries::len(
  self : ChemmolreprcanonicalSeries,
) -> Int32 {
  self.vals.length()
}

///|
pub fn ChemmolreprcanonicalSeries::sum(
  self : ChemmolreprcanonicalSeries,
) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn ChemmolreprcanonicalSeries::mean(
  self : ChemmolreprcanonicalSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn ChemmolreprcanonicalSeries::min(
  self : ChemmolreprcanonicalSeries,
) -> Double {
  @_common.min(self.vals)
}

///|
pub fn ChemmolreprcanonicalSeries::max(
  self : ChemmolreprcanonicalSeries,
) -> Double {
  @_common.max(self.vals)
}

///|
pub fn ChemmolreprcanonicalSeries::range(
  self : ChemmolreprcanonicalSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn ChemmolreprcanonicalSeries::variance(
  self : ChemmolreprcanonicalSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn ChemmolreprcanonicalSeries::std(
  self : ChemmolreprcanonicalSeries,
) -> Double {
  @_common.std(self.vals)
}

///|
pub fn ChemmolreprcanonicalSeries::median(
  self : ChemmolreprcanonicalSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn ChemmolreprcanonicalSeries::scale(
  self : ChemmolreprcanonicalSeries,
  f : Double,
) -> ChemmolreprcanonicalSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn ChemmolreprcanonicalSeries::add(
  self : ChemmolreprcanonicalSeries,
  other : ChemmolreprcanonicalSeries,
) -> ChemmolreprcanonicalSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn ChemmolreprcanonicalSeries::sub(
  self : ChemmolreprcanonicalSeries,
  other : ChemmolreprcanonicalSeries,
) -> ChemmolreprcanonicalSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn ChemmolreprcanonicalSeries::normalize(
  self : ChemmolreprcanonicalSeries,
) -> ChemmolreprcanonicalSeries {
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
pub fn ChemmolreprcanonicalSeries::cumsum(
  self : ChemmolreprcanonicalSeries,
) -> ChemmolreprcanonicalSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn ChemmolreprcanonicalSeries::to_string(
  self : ChemmolreprcanonicalSeries,
) -> String {
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
pub(all) struct ChemmolreprcanonicalMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn chem_mol_repr_canonical_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> ChemmolreprcanonicalMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn chem_mol_repr_canonical_matrix_identity(
  n : Int32,
) -> ChemmolreprcanonicalMatrix {
  let m = chem_mol_repr_canonical_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn ChemmolreprcanonicalMatrix::get(
  self : ChemmolreprcanonicalMatrix,
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
pub fn ChemmolreprcanonicalMatrix::transpose(
  self : ChemmolreprcanonicalMatrix,
) -> ChemmolreprcanonicalMatrix {
  let result = chem_mol_repr_canonical_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn ChemmolreprcanonicalMatrix::add(
  self : ChemmolreprcanonicalMatrix,
  other : ChemmolreprcanonicalMatrix,
) -> ChemmolreprcanonicalMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = chem_mol_repr_canonical_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn ChemmolreprcanonicalMatrix::scale(
  self : ChemmolreprcanonicalMatrix,
  s : Double,
) -> ChemmolreprcanonicalMatrix {
  let result = chem_mol_repr_canonical_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn ChemmolreprcanonicalMatrix::multiply(
  self : ChemmolreprcanonicalMatrix,
  other : ChemmolreprcanonicalMatrix,
) -> ChemmolreprcanonicalMatrix {
  if self.cols != other.rows {
    return chem_mol_repr_canonical_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = chem_mol_repr_canonical_make_matrix(self.rows, other.cols, 0.0)
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
pub fn ChemmolreprcanonicalMatrix::trace(
  self : ChemmolreprcanonicalMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn ChemmolreprcanonicalMatrix::det(
  self : ChemmolreprcanonicalMatrix,
) -> Double {
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
pub fn ChemmolreprcanonicalMatrix::norm(
  self : ChemmolreprcanonicalMatrix,
) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn ChemmolreprcanonicalMatrix::to_string(
  self : ChemmolreprcanonicalMatrix,
) -> String {
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
pub(all) struct ChemmolreprcanonicalVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn chem_mol_repr_canonical_make_vector(
  comps : Array[Double],
) -> ChemmolreprcanonicalVector {
  { comps, dim: comps.length(), }
}

///|
pub fn chem_mol_repr_canonical_vector_zero(
  dim : Int32,
) -> ChemmolreprcanonicalVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn ChemmolreprcanonicalVector::add(
  self : ChemmolreprcanonicalVector,
  other : ChemmolreprcanonicalVector,
) -> ChemmolreprcanonicalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn ChemmolreprcanonicalVector::sub(
  self : ChemmolreprcanonicalVector,
  other : ChemmolreprcanonicalVector,
) -> ChemmolreprcanonicalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn ChemmolreprcanonicalVector::scale(
  self : ChemmolreprcanonicalVector,
  s : Double,
) -> ChemmolreprcanonicalVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn ChemmolreprcanonicalVector::dot(
  self : ChemmolreprcanonicalVector,
  other : ChemmolreprcanonicalVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn ChemmolreprcanonicalVector::norm(
  self : ChemmolreprcanonicalVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn ChemmolreprcanonicalVector::normalize(
  self : ChemmolreprcanonicalVector,
) -> ChemmolreprcanonicalVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn ChemmolreprcanonicalVector::dist(
  self : ChemmolreprcanonicalVector,
  other : ChemmolreprcanonicalVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn ChemmolreprcanonicalVector::to_string(
  self : ChemmolreprcanonicalVector,
) -> String {
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
pub(all) struct ChemmolreprcanonicalFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_canonical_frame_make(
  size : Int32,
) -> ChemmolreprcanonicalFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolreprcanonicalFrame::len(
  self : ChemmolreprcanonicalFrame,
) -> Int32 {
  self.size
}

///|
pub fn ChemmolreprcanonicalFrame::get(
  self : ChemmolreprcanonicalFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolreprcanonicalFrame::set(
  self : ChemmolreprcanonicalFrame,
  i : Int32,
  v : Double,
) -> ChemmolreprcanonicalFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalFrame::sum(
  self : ChemmolreprcanonicalFrame,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolreprcanonicalFrame::mean(
  self : ChemmolreprcanonicalFrame,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolreprcanonicalFrame::scale(
  self : ChemmolreprcanonicalFrame,
  f : Double,
) -> ChemmolreprcanonicalFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalFrame::add(
  self : ChemmolreprcanonicalFrame,
  other : ChemmolreprcanonicalFrame,
) -> ChemmolreprcanonicalFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalFrame::copy(
  self : ChemmolreprcanonicalFrame,
) -> ChemmolreprcanonicalFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalFrame::fill(
  self : ChemmolreprcanonicalFrame,
  v : Double,
) -> ChemmolreprcanonicalFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalFrame::min(
  self : ChemmolreprcanonicalFrame,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolreprcanonicalFrame::max(
  self : ChemmolreprcanonicalFrame,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolreprcanonicalFrame::to_string(
  self : ChemmolreprcanonicalFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolreprcanonicalTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_canonical_table_make(
  size : Int32,
) -> ChemmolreprcanonicalTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolreprcanonicalTable::len(
  self : ChemmolreprcanonicalTable,
) -> Int32 {
  self.size
}

///|
pub fn ChemmolreprcanonicalTable::get(
  self : ChemmolreprcanonicalTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolreprcanonicalTable::set(
  self : ChemmolreprcanonicalTable,
  i : Int32,
  v : Double,
) -> ChemmolreprcanonicalTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalTable::sum(
  self : ChemmolreprcanonicalTable,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolreprcanonicalTable::mean(
  self : ChemmolreprcanonicalTable,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolreprcanonicalTable::scale(
  self : ChemmolreprcanonicalTable,
  f : Double,
) -> ChemmolreprcanonicalTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalTable::add(
  self : ChemmolreprcanonicalTable,
  other : ChemmolreprcanonicalTable,
) -> ChemmolreprcanonicalTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalTable::copy(
  self : ChemmolreprcanonicalTable,
) -> ChemmolreprcanonicalTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalTable::fill(
  self : ChemmolreprcanonicalTable,
  v : Double,
) -> ChemmolreprcanonicalTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalTable::min(
  self : ChemmolreprcanonicalTable,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolreprcanonicalTable::max(
  self : ChemmolreprcanonicalTable,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolreprcanonicalTable::to_string(
  self : ChemmolreprcanonicalTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolreprcanonicalGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_canonical_graphn_make(
  size : Int32,
) -> ChemmolreprcanonicalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolreprcanonicalGraphN::len(
  self : ChemmolreprcanonicalGraphN,
) -> Int32 {
  self.size
}

///|
pub fn ChemmolreprcanonicalGraphN::get(
  self : ChemmolreprcanonicalGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolreprcanonicalGraphN::set(
  self : ChemmolreprcanonicalGraphN,
  i : Int32,
  v : Double,
) -> ChemmolreprcanonicalGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalGraphN::sum(
  self : ChemmolreprcanonicalGraphN,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolreprcanonicalGraphN::mean(
  self : ChemmolreprcanonicalGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolreprcanonicalGraphN::scale(
  self : ChemmolreprcanonicalGraphN,
  f : Double,
) -> ChemmolreprcanonicalGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalGraphN::add(
  self : ChemmolreprcanonicalGraphN,
  other : ChemmolreprcanonicalGraphN,
) -> ChemmolreprcanonicalGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalGraphN::copy(
  self : ChemmolreprcanonicalGraphN,
) -> ChemmolreprcanonicalGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalGraphN::fill(
  self : ChemmolreprcanonicalGraphN,
  v : Double,
) -> ChemmolreprcanonicalGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalGraphN::min(
  self : ChemmolreprcanonicalGraphN,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolreprcanonicalGraphN::max(
  self : ChemmolreprcanonicalGraphN,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolreprcanonicalGraphN::to_string(
  self : ChemmolreprcanonicalGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolreprcanonicalNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_canonical_node_make(
  size : Int32,
) -> ChemmolreprcanonicalNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolreprcanonicalNode::len(self : ChemmolreprcanonicalNode) -> Int32 {
  self.size
}

///|
pub fn ChemmolreprcanonicalNode::get(
  self : ChemmolreprcanonicalNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolreprcanonicalNode::set(
  self : ChemmolreprcanonicalNode,
  i : Int32,
  v : Double,
) -> ChemmolreprcanonicalNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalNode::sum(self : ChemmolreprcanonicalNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolreprcanonicalNode::mean(
  self : ChemmolreprcanonicalNode,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolreprcanonicalNode::scale(
  self : ChemmolreprcanonicalNode,
  f : Double,
) -> ChemmolreprcanonicalNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalNode::add(
  self : ChemmolreprcanonicalNode,
  other : ChemmolreprcanonicalNode,
) -> ChemmolreprcanonicalNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalNode::copy(
  self : ChemmolreprcanonicalNode,
) -> ChemmolreprcanonicalNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalNode::fill(
  self : ChemmolreprcanonicalNode,
  v : Double,
) -> ChemmolreprcanonicalNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalNode::min(self : ChemmolreprcanonicalNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolreprcanonicalNode::max(self : ChemmolreprcanonicalNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolreprcanonicalNode::to_string(
  self : ChemmolreprcanonicalNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolreprcanonicalEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_canonical_edge_make(
  size : Int32,
) -> ChemmolreprcanonicalEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolreprcanonicalEdge::len(self : ChemmolreprcanonicalEdge) -> Int32 {
  self.size
}

///|
pub fn ChemmolreprcanonicalEdge::get(
  self : ChemmolreprcanonicalEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolreprcanonicalEdge::set(
  self : ChemmolreprcanonicalEdge,
  i : Int32,
  v : Double,
) -> ChemmolreprcanonicalEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalEdge::sum(self : ChemmolreprcanonicalEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolreprcanonicalEdge::mean(
  self : ChemmolreprcanonicalEdge,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolreprcanonicalEdge::scale(
  self : ChemmolreprcanonicalEdge,
  f : Double,
) -> ChemmolreprcanonicalEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalEdge::add(
  self : ChemmolreprcanonicalEdge,
  other : ChemmolreprcanonicalEdge,
) -> ChemmolreprcanonicalEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalEdge::copy(
  self : ChemmolreprcanonicalEdge,
) -> ChemmolreprcanonicalEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalEdge::fill(
  self : ChemmolreprcanonicalEdge,
  v : Double,
) -> ChemmolreprcanonicalEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalEdge::min(self : ChemmolreprcanonicalEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolreprcanonicalEdge::max(self : ChemmolreprcanonicalEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolreprcanonicalEdge::to_string(
  self : ChemmolreprcanonicalEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolreprcanonicalPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_canonical_path_make(
  size : Int32,
) -> ChemmolreprcanonicalPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolreprcanonicalPath::len(self : ChemmolreprcanonicalPath) -> Int32 {
  self.size
}

///|
pub fn ChemmolreprcanonicalPath::get(
  self : ChemmolreprcanonicalPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolreprcanonicalPath::set(
  self : ChemmolreprcanonicalPath,
  i : Int32,
  v : Double,
) -> ChemmolreprcanonicalPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalPath::sum(self : ChemmolreprcanonicalPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolreprcanonicalPath::mean(
  self : ChemmolreprcanonicalPath,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolreprcanonicalPath::scale(
  self : ChemmolreprcanonicalPath,
  f : Double,
) -> ChemmolreprcanonicalPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalPath::add(
  self : ChemmolreprcanonicalPath,
  other : ChemmolreprcanonicalPath,
) -> ChemmolreprcanonicalPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalPath::copy(
  self : ChemmolreprcanonicalPath,
) -> ChemmolreprcanonicalPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalPath::fill(
  self : ChemmolreprcanonicalPath,
  v : Double,
) -> ChemmolreprcanonicalPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalPath::min(self : ChemmolreprcanonicalPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolreprcanonicalPath::max(self : ChemmolreprcanonicalPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolreprcanonicalPath::to_string(
  self : ChemmolreprcanonicalPath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolreprcanonicalCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_canonical_cluster_make(
  size : Int32,
) -> ChemmolreprcanonicalCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolreprcanonicalCluster::len(
  self : ChemmolreprcanonicalCluster,
) -> Int32 {
  self.size
}

///|
pub fn ChemmolreprcanonicalCluster::get(
  self : ChemmolreprcanonicalCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolreprcanonicalCluster::set(
  self : ChemmolreprcanonicalCluster,
  i : Int32,
  v : Double,
) -> ChemmolreprcanonicalCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalCluster::sum(
  self : ChemmolreprcanonicalCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolreprcanonicalCluster::mean(
  self : ChemmolreprcanonicalCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolreprcanonicalCluster::scale(
  self : ChemmolreprcanonicalCluster,
  f : Double,
) -> ChemmolreprcanonicalCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalCluster::add(
  self : ChemmolreprcanonicalCluster,
  other : ChemmolreprcanonicalCluster,
) -> ChemmolreprcanonicalCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalCluster::copy(
  self : ChemmolreprcanonicalCluster,
) -> ChemmolreprcanonicalCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalCluster::fill(
  self : ChemmolreprcanonicalCluster,
  v : Double,
) -> ChemmolreprcanonicalCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalCluster::min(
  self : ChemmolreprcanonicalCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolreprcanonicalCluster::max(
  self : ChemmolreprcanonicalCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolreprcanonicalCluster::to_string(
  self : ChemmolreprcanonicalCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolreprcanonicalModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_canonical_model_make(
  size : Int32,
) -> ChemmolreprcanonicalModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolreprcanonicalModel::len(
  self : ChemmolreprcanonicalModel,
) -> Int32 {
  self.size
}

///|
pub fn ChemmolreprcanonicalModel::get(
  self : ChemmolreprcanonicalModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolreprcanonicalModel::set(
  self : ChemmolreprcanonicalModel,
  i : Int32,
  v : Double,
) -> ChemmolreprcanonicalModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalModel::sum(
  self : ChemmolreprcanonicalModel,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolreprcanonicalModel::mean(
  self : ChemmolreprcanonicalModel,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolreprcanonicalModel::scale(
  self : ChemmolreprcanonicalModel,
  f : Double,
) -> ChemmolreprcanonicalModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalModel::add(
  self : ChemmolreprcanonicalModel,
  other : ChemmolreprcanonicalModel,
) -> ChemmolreprcanonicalModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalModel::copy(
  self : ChemmolreprcanonicalModel,
) -> ChemmolreprcanonicalModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalModel::fill(
  self : ChemmolreprcanonicalModel,
  v : Double,
) -> ChemmolreprcanonicalModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalModel::min(
  self : ChemmolreprcanonicalModel,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolreprcanonicalModel::max(
  self : ChemmolreprcanonicalModel,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolreprcanonicalModel::to_string(
  self : ChemmolreprcanonicalModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolreprcanonicalLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_canonical_layer_make(
  size : Int32,
) -> ChemmolreprcanonicalLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolreprcanonicalLayer::len(
  self : ChemmolreprcanonicalLayer,
) -> Int32 {
  self.size
}

///|
pub fn ChemmolreprcanonicalLayer::get(
  self : ChemmolreprcanonicalLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolreprcanonicalLayer::set(
  self : ChemmolreprcanonicalLayer,
  i : Int32,
  v : Double,
) -> ChemmolreprcanonicalLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalLayer::sum(
  self : ChemmolreprcanonicalLayer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolreprcanonicalLayer::mean(
  self : ChemmolreprcanonicalLayer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolreprcanonicalLayer::scale(
  self : ChemmolreprcanonicalLayer,
  f : Double,
) -> ChemmolreprcanonicalLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalLayer::add(
  self : ChemmolreprcanonicalLayer,
  other : ChemmolreprcanonicalLayer,
) -> ChemmolreprcanonicalLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalLayer::copy(
  self : ChemmolreprcanonicalLayer,
) -> ChemmolreprcanonicalLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalLayer::fill(
  self : ChemmolreprcanonicalLayer,
  v : Double,
) -> ChemmolreprcanonicalLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalLayer::min(
  self : ChemmolreprcanonicalLayer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolreprcanonicalLayer::max(
  self : ChemmolreprcanonicalLayer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolreprcanonicalLayer::to_string(
  self : ChemmolreprcanonicalLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolreprcanonicalBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_canonical_buffer_make(
  size : Int32,
) -> ChemmolreprcanonicalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolreprcanonicalBuffer::len(
  self : ChemmolreprcanonicalBuffer,
) -> Int32 {
  self.size
}

///|
pub fn ChemmolreprcanonicalBuffer::get(
  self : ChemmolreprcanonicalBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolreprcanonicalBuffer::set(
  self : ChemmolreprcanonicalBuffer,
  i : Int32,
  v : Double,
) -> ChemmolreprcanonicalBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalBuffer::sum(
  self : ChemmolreprcanonicalBuffer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolreprcanonicalBuffer::mean(
  self : ChemmolreprcanonicalBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolreprcanonicalBuffer::scale(
  self : ChemmolreprcanonicalBuffer,
  f : Double,
) -> ChemmolreprcanonicalBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalBuffer::add(
  self : ChemmolreprcanonicalBuffer,
  other : ChemmolreprcanonicalBuffer,
) -> ChemmolreprcanonicalBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalBuffer::copy(
  self : ChemmolreprcanonicalBuffer,
) -> ChemmolreprcanonicalBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalBuffer::fill(
  self : ChemmolreprcanonicalBuffer,
  v : Double,
) -> ChemmolreprcanonicalBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalBuffer::min(
  self : ChemmolreprcanonicalBuffer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolreprcanonicalBuffer::max(
  self : ChemmolreprcanonicalBuffer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolreprcanonicalBuffer::to_string(
  self : ChemmolreprcanonicalBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolreprcanonicalCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_canonical_cursor_make(
  size : Int32,
) -> ChemmolreprcanonicalCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolreprcanonicalCursor::len(
  self : ChemmolreprcanonicalCursor,
) -> Int32 {
  self.size
}

///|
pub fn ChemmolreprcanonicalCursor::get(
  self : ChemmolreprcanonicalCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolreprcanonicalCursor::set(
  self : ChemmolreprcanonicalCursor,
  i : Int32,
  v : Double,
) -> ChemmolreprcanonicalCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalCursor::sum(
  self : ChemmolreprcanonicalCursor,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolreprcanonicalCursor::mean(
  self : ChemmolreprcanonicalCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolreprcanonicalCursor::scale(
  self : ChemmolreprcanonicalCursor,
  f : Double,
) -> ChemmolreprcanonicalCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalCursor::add(
  self : ChemmolreprcanonicalCursor,
  other : ChemmolreprcanonicalCursor,
) -> ChemmolreprcanonicalCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalCursor::copy(
  self : ChemmolreprcanonicalCursor,
) -> ChemmolreprcanonicalCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalCursor::fill(
  self : ChemmolreprcanonicalCursor,
  v : Double,
) -> ChemmolreprcanonicalCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalCursor::min(
  self : ChemmolreprcanonicalCursor,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolreprcanonicalCursor::max(
  self : ChemmolreprcanonicalCursor,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolreprcanonicalCursor::to_string(
  self : ChemmolreprcanonicalCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolreprcanonicalView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_canonical_view_make(
  size : Int32,
) -> ChemmolreprcanonicalView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolreprcanonicalView::len(self : ChemmolreprcanonicalView) -> Int32 {
  self.size
}

///|
pub fn ChemmolreprcanonicalView::get(
  self : ChemmolreprcanonicalView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolreprcanonicalView::set(
  self : ChemmolreprcanonicalView,
  i : Int32,
  v : Double,
) -> ChemmolreprcanonicalView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalView::sum(self : ChemmolreprcanonicalView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolreprcanonicalView::mean(
  self : ChemmolreprcanonicalView,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolreprcanonicalView::scale(
  self : ChemmolreprcanonicalView,
  f : Double,
) -> ChemmolreprcanonicalView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalView::add(
  self : ChemmolreprcanonicalView,
  other : ChemmolreprcanonicalView,
) -> ChemmolreprcanonicalView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalView::copy(
  self : ChemmolreprcanonicalView,
) -> ChemmolreprcanonicalView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalView::fill(
  self : ChemmolreprcanonicalView,
  v : Double,
) -> ChemmolreprcanonicalView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalView::min(self : ChemmolreprcanonicalView) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolreprcanonicalView::max(self : ChemmolreprcanonicalView) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolreprcanonicalView::to_string(
  self : ChemmolreprcanonicalView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolreprcanonicalRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_canonical_range_make(
  size : Int32,
) -> ChemmolreprcanonicalRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolreprcanonicalRange::len(
  self : ChemmolreprcanonicalRange,
) -> Int32 {
  self.size
}

///|
pub fn ChemmolreprcanonicalRange::get(
  self : ChemmolreprcanonicalRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolreprcanonicalRange::set(
  self : ChemmolreprcanonicalRange,
  i : Int32,
  v : Double,
) -> ChemmolreprcanonicalRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalRange::sum(
  self : ChemmolreprcanonicalRange,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolreprcanonicalRange::mean(
  self : ChemmolreprcanonicalRange,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolreprcanonicalRange::scale(
  self : ChemmolreprcanonicalRange,
  f : Double,
) -> ChemmolreprcanonicalRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalRange::add(
  self : ChemmolreprcanonicalRange,
  other : ChemmolreprcanonicalRange,
) -> ChemmolreprcanonicalRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalRange::copy(
  self : ChemmolreprcanonicalRange,
) -> ChemmolreprcanonicalRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalRange::fill(
  self : ChemmolreprcanonicalRange,
  v : Double,
) -> ChemmolreprcanonicalRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalRange::min(
  self : ChemmolreprcanonicalRange,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolreprcanonicalRange::max(
  self : ChemmolreprcanonicalRange,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolreprcanonicalRange::to_string(
  self : ChemmolreprcanonicalRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolreprcanonicalSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_canonical_slice_make(
  size : Int32,
) -> ChemmolreprcanonicalSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolreprcanonicalSlice::len(
  self : ChemmolreprcanonicalSlice,
) -> Int32 {
  self.size
}

///|
pub fn ChemmolreprcanonicalSlice::get(
  self : ChemmolreprcanonicalSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolreprcanonicalSlice::set(
  self : ChemmolreprcanonicalSlice,
  i : Int32,
  v : Double,
) -> ChemmolreprcanonicalSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalSlice::sum(
  self : ChemmolreprcanonicalSlice,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolreprcanonicalSlice::mean(
  self : ChemmolreprcanonicalSlice,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolreprcanonicalSlice::scale(
  self : ChemmolreprcanonicalSlice,
  f : Double,
) -> ChemmolreprcanonicalSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalSlice::add(
  self : ChemmolreprcanonicalSlice,
  other : ChemmolreprcanonicalSlice,
) -> ChemmolreprcanonicalSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalSlice::copy(
  self : ChemmolreprcanonicalSlice,
) -> ChemmolreprcanonicalSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalSlice::fill(
  self : ChemmolreprcanonicalSlice,
  v : Double,
) -> ChemmolreprcanonicalSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprcanonicalSlice::min(
  self : ChemmolreprcanonicalSlice,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolreprcanonicalSlice::max(
  self : ChemmolreprcanonicalSlice,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolreprcanonicalSlice::to_string(
  self : ChemmolreprcanonicalSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
