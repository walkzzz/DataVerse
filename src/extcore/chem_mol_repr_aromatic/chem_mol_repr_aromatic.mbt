///|
///===
/// extcore/chem_mol_repr_aromatic
pub(all) struct ChemmolrepraromaticPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn chem_mol_repr_aromatic_make_point(
  x : Double,
  y : Double,
) -> ChemmolrepraromaticPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn chem_mol_repr_aromatic_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> ChemmolrepraromaticPoint {
  { x, y, z, label: 0, }
}

///|
pub fn ChemmolrepraromaticPoint::x(self : ChemmolrepraromaticPoint) -> Double {
  self.x
}

///|
pub fn ChemmolrepraromaticPoint::y(self : ChemmolrepraromaticPoint) -> Double {
  self.y
}

///|
pub fn ChemmolrepraromaticPoint::z(self : ChemmolrepraromaticPoint) -> Double {
  self.z
}

///|
pub fn ChemmolrepraromaticPoint::label(
  self : ChemmolrepraromaticPoint,
) -> Int32 {
  self.label
}

///|
pub fn ChemmolrepraromaticPoint::dist(
  self : ChemmolrepraromaticPoint,
  other : ChemmolrepraromaticPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn ChemmolrepraromaticPoint::add(
  self : ChemmolrepraromaticPoint,
  other : ChemmolrepraromaticPoint,
) -> ChemmolrepraromaticPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn ChemmolrepraromaticPoint::sub(
  self : ChemmolrepraromaticPoint,
  other : ChemmolrepraromaticPoint,
) -> ChemmolrepraromaticPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn ChemmolrepraromaticPoint::scale(
  self : ChemmolrepraromaticPoint,
  s : Double,
) -> ChemmolrepraromaticPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn ChemmolrepraromaticPoint::dot(
  self : ChemmolrepraromaticPoint,
  other : ChemmolrepraromaticPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn ChemmolrepraromaticPoint::cross(
  self : ChemmolrepraromaticPoint,
  other : ChemmolrepraromaticPoint,
) -> ChemmolrepraromaticPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn ChemmolrepraromaticPoint::norm(
  self : ChemmolrepraromaticPoint,
) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn ChemmolrepraromaticPoint::normalize(
  self : ChemmolrepraromaticPoint,
) -> ChemmolrepraromaticPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn ChemmolrepraromaticPoint::negate(
  self : ChemmolrepraromaticPoint,
) -> ChemmolrepraromaticPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn ChemmolrepraromaticPoint::mid(
  self : ChemmolrepraromaticPoint,
  other : ChemmolrepraromaticPoint,
) -> ChemmolrepraromaticPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn ChemmolrepraromaticPoint::lerp(
  self : ChemmolrepraromaticPoint,
  other : ChemmolrepraromaticPoint,
  t : Double,
) -> ChemmolrepraromaticPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn ChemmolrepraromaticPoint::to_string(
  self : ChemmolrepraromaticPoint,
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
pub(all) struct ChemmolrepraromaticSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn chem_mol_repr_aromatic_make_series(
  vals : Array[Double],
  name : String,
) -> ChemmolrepraromaticSeries {
  { vals, name, meta: 0, }
}

///|
pub fn ChemmolrepraromaticSeries::len(
  self : ChemmolrepraromaticSeries,
) -> Int32 {
  self.vals.length()
}

///|
pub fn ChemmolrepraromaticSeries::sum(
  self : ChemmolrepraromaticSeries,
) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn ChemmolrepraromaticSeries::mean(
  self : ChemmolrepraromaticSeries,
) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn ChemmolrepraromaticSeries::min(
  self : ChemmolrepraromaticSeries,
) -> Double {
  @_common.min(self.vals)
}

///|
pub fn ChemmolrepraromaticSeries::max(
  self : ChemmolrepraromaticSeries,
) -> Double {
  @_common.max(self.vals)
}

///|
pub fn ChemmolrepraromaticSeries::range(
  self : ChemmolrepraromaticSeries,
) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn ChemmolrepraromaticSeries::variance(
  self : ChemmolrepraromaticSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn ChemmolrepraromaticSeries::std(
  self : ChemmolrepraromaticSeries,
) -> Double {
  @_common.std(self.vals)
}

///|
pub fn ChemmolrepraromaticSeries::median(
  self : ChemmolrepraromaticSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn ChemmolrepraromaticSeries::scale(
  self : ChemmolrepraromaticSeries,
  f : Double,
) -> ChemmolrepraromaticSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn ChemmolrepraromaticSeries::add(
  self : ChemmolrepraromaticSeries,
  other : ChemmolrepraromaticSeries,
) -> ChemmolrepraromaticSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn ChemmolrepraromaticSeries::sub(
  self : ChemmolrepraromaticSeries,
  other : ChemmolrepraromaticSeries,
) -> ChemmolrepraromaticSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn ChemmolrepraromaticSeries::normalize(
  self : ChemmolrepraromaticSeries,
) -> ChemmolrepraromaticSeries {
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
pub fn ChemmolrepraromaticSeries::cumsum(
  self : ChemmolrepraromaticSeries,
) -> ChemmolrepraromaticSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn ChemmolrepraromaticSeries::to_string(
  self : ChemmolrepraromaticSeries,
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
pub(all) struct ChemmolrepraromaticMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn chem_mol_repr_aromatic_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> ChemmolrepraromaticMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn chem_mol_repr_aromatic_matrix_identity(
  n : Int32,
) -> ChemmolrepraromaticMatrix {
  let m = chem_mol_repr_aromatic_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn ChemmolrepraromaticMatrix::get(
  self : ChemmolrepraromaticMatrix,
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
pub fn ChemmolrepraromaticMatrix::transpose(
  self : ChemmolrepraromaticMatrix,
) -> ChemmolrepraromaticMatrix {
  let result = chem_mol_repr_aromatic_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn ChemmolrepraromaticMatrix::add(
  self : ChemmolrepraromaticMatrix,
  other : ChemmolrepraromaticMatrix,
) -> ChemmolrepraromaticMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = chem_mol_repr_aromatic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn ChemmolrepraromaticMatrix::scale(
  self : ChemmolrepraromaticMatrix,
  s : Double,
) -> ChemmolrepraromaticMatrix {
  let result = chem_mol_repr_aromatic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn ChemmolrepraromaticMatrix::multiply(
  self : ChemmolrepraromaticMatrix,
  other : ChemmolrepraromaticMatrix,
) -> ChemmolrepraromaticMatrix {
  if self.cols != other.rows {
    return chem_mol_repr_aromatic_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = chem_mol_repr_aromatic_make_matrix(self.rows, other.cols, 0.0)
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
pub fn ChemmolrepraromaticMatrix::trace(
  self : ChemmolrepraromaticMatrix,
) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn ChemmolrepraromaticMatrix::det(
  self : ChemmolrepraromaticMatrix,
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
pub fn ChemmolrepraromaticMatrix::norm(
  self : ChemmolrepraromaticMatrix,
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
pub fn ChemmolrepraromaticMatrix::to_string(
  self : ChemmolrepraromaticMatrix,
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
pub(all) struct ChemmolrepraromaticVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn chem_mol_repr_aromatic_make_vector(
  comps : Array[Double],
) -> ChemmolrepraromaticVector {
  { comps, dim: comps.length(), }
}

///|
pub fn chem_mol_repr_aromatic_vector_zero(
  dim : Int32,
) -> ChemmolrepraromaticVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn ChemmolrepraromaticVector::add(
  self : ChemmolrepraromaticVector,
  other : ChemmolrepraromaticVector,
) -> ChemmolrepraromaticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn ChemmolrepraromaticVector::sub(
  self : ChemmolrepraromaticVector,
  other : ChemmolrepraromaticVector,
) -> ChemmolrepraromaticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn ChemmolrepraromaticVector::scale(
  self : ChemmolrepraromaticVector,
  s : Double,
) -> ChemmolrepraromaticVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn ChemmolrepraromaticVector::dot(
  self : ChemmolrepraromaticVector,
  other : ChemmolrepraromaticVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn ChemmolrepraromaticVector::norm(
  self : ChemmolrepraromaticVector,
) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn ChemmolrepraromaticVector::normalize(
  self : ChemmolrepraromaticVector,
) -> ChemmolrepraromaticVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn ChemmolrepraromaticVector::dist(
  self : ChemmolrepraromaticVector,
  other : ChemmolrepraromaticVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn ChemmolrepraromaticVector::to_string(
  self : ChemmolrepraromaticVector,
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
pub(all) struct ChemmolrepraromaticFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_aromatic_frame_make(
  size : Int32,
) -> ChemmolrepraromaticFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolrepraromaticFrame::len(self : ChemmolrepraromaticFrame) -> Int32 {
  self.size
}

///|
pub fn ChemmolrepraromaticFrame::get(
  self : ChemmolrepraromaticFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolrepraromaticFrame::set(
  self : ChemmolrepraromaticFrame,
  i : Int32,
  v : Double,
) -> ChemmolrepraromaticFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticFrame::sum(self : ChemmolrepraromaticFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolrepraromaticFrame::mean(
  self : ChemmolrepraromaticFrame,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolrepraromaticFrame::scale(
  self : ChemmolrepraromaticFrame,
  f : Double,
) -> ChemmolrepraromaticFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticFrame::add(
  self : ChemmolrepraromaticFrame,
  other : ChemmolrepraromaticFrame,
) -> ChemmolrepraromaticFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticFrame::copy(
  self : ChemmolrepraromaticFrame,
) -> ChemmolrepraromaticFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticFrame::fill(
  self : ChemmolrepraromaticFrame,
  v : Double,
) -> ChemmolrepraromaticFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticFrame::min(self : ChemmolrepraromaticFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolrepraromaticFrame::max(self : ChemmolrepraromaticFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolrepraromaticFrame::to_string(
  self : ChemmolrepraromaticFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolrepraromaticTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_aromatic_table_make(
  size : Int32,
) -> ChemmolrepraromaticTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolrepraromaticTable::len(self : ChemmolrepraromaticTable) -> Int32 {
  self.size
}

///|
pub fn ChemmolrepraromaticTable::get(
  self : ChemmolrepraromaticTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolrepraromaticTable::set(
  self : ChemmolrepraromaticTable,
  i : Int32,
  v : Double,
) -> ChemmolrepraromaticTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticTable::sum(self : ChemmolrepraromaticTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolrepraromaticTable::mean(
  self : ChemmolrepraromaticTable,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolrepraromaticTable::scale(
  self : ChemmolrepraromaticTable,
  f : Double,
) -> ChemmolrepraromaticTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticTable::add(
  self : ChemmolrepraromaticTable,
  other : ChemmolrepraromaticTable,
) -> ChemmolrepraromaticTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticTable::copy(
  self : ChemmolrepraromaticTable,
) -> ChemmolrepraromaticTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticTable::fill(
  self : ChemmolrepraromaticTable,
  v : Double,
) -> ChemmolrepraromaticTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticTable::min(self : ChemmolrepraromaticTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolrepraromaticTable::max(self : ChemmolrepraromaticTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolrepraromaticTable::to_string(
  self : ChemmolrepraromaticTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolrepraromaticGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_aromatic_graphn_make(
  size : Int32,
) -> ChemmolrepraromaticGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolrepraromaticGraphN::len(
  self : ChemmolrepraromaticGraphN,
) -> Int32 {
  self.size
}

///|
pub fn ChemmolrepraromaticGraphN::get(
  self : ChemmolrepraromaticGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolrepraromaticGraphN::set(
  self : ChemmolrepraromaticGraphN,
  i : Int32,
  v : Double,
) -> ChemmolrepraromaticGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticGraphN::sum(
  self : ChemmolrepraromaticGraphN,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolrepraromaticGraphN::mean(
  self : ChemmolrepraromaticGraphN,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolrepraromaticGraphN::scale(
  self : ChemmolrepraromaticGraphN,
  f : Double,
) -> ChemmolrepraromaticGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticGraphN::add(
  self : ChemmolrepraromaticGraphN,
  other : ChemmolrepraromaticGraphN,
) -> ChemmolrepraromaticGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticGraphN::copy(
  self : ChemmolrepraromaticGraphN,
) -> ChemmolrepraromaticGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticGraphN::fill(
  self : ChemmolrepraromaticGraphN,
  v : Double,
) -> ChemmolrepraromaticGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticGraphN::min(
  self : ChemmolrepraromaticGraphN,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolrepraromaticGraphN::max(
  self : ChemmolrepraromaticGraphN,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolrepraromaticGraphN::to_string(
  self : ChemmolrepraromaticGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolrepraromaticNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_aromatic_node_make(
  size : Int32,
) -> ChemmolrepraromaticNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolrepraromaticNode::len(self : ChemmolrepraromaticNode) -> Int32 {
  self.size
}

///|
pub fn ChemmolrepraromaticNode::get(
  self : ChemmolrepraromaticNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolrepraromaticNode::set(
  self : ChemmolrepraromaticNode,
  i : Int32,
  v : Double,
) -> ChemmolrepraromaticNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticNode::sum(self : ChemmolrepraromaticNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolrepraromaticNode::mean(self : ChemmolrepraromaticNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolrepraromaticNode::scale(
  self : ChemmolrepraromaticNode,
  f : Double,
) -> ChemmolrepraromaticNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticNode::add(
  self : ChemmolrepraromaticNode,
  other : ChemmolrepraromaticNode,
) -> ChemmolrepraromaticNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticNode::copy(
  self : ChemmolrepraromaticNode,
) -> ChemmolrepraromaticNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticNode::fill(
  self : ChemmolrepraromaticNode,
  v : Double,
) -> ChemmolrepraromaticNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticNode::min(self : ChemmolrepraromaticNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolrepraromaticNode::max(self : ChemmolrepraromaticNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolrepraromaticNode::to_string(
  self : ChemmolrepraromaticNode,
) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolrepraromaticEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_aromatic_edge_make(
  size : Int32,
) -> ChemmolrepraromaticEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolrepraromaticEdge::len(self : ChemmolrepraromaticEdge) -> Int32 {
  self.size
}

///|
pub fn ChemmolrepraromaticEdge::get(
  self : ChemmolrepraromaticEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolrepraromaticEdge::set(
  self : ChemmolrepraromaticEdge,
  i : Int32,
  v : Double,
) -> ChemmolrepraromaticEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticEdge::sum(self : ChemmolrepraromaticEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolrepraromaticEdge::mean(self : ChemmolrepraromaticEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolrepraromaticEdge::scale(
  self : ChemmolrepraromaticEdge,
  f : Double,
) -> ChemmolrepraromaticEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticEdge::add(
  self : ChemmolrepraromaticEdge,
  other : ChemmolrepraromaticEdge,
) -> ChemmolrepraromaticEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticEdge::copy(
  self : ChemmolrepraromaticEdge,
) -> ChemmolrepraromaticEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticEdge::fill(
  self : ChemmolrepraromaticEdge,
  v : Double,
) -> ChemmolrepraromaticEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticEdge::min(self : ChemmolrepraromaticEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolrepraromaticEdge::max(self : ChemmolrepraromaticEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolrepraromaticEdge::to_string(
  self : ChemmolrepraromaticEdge,
) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolrepraromaticPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_aromatic_path_make(
  size : Int32,
) -> ChemmolrepraromaticPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolrepraromaticPath::len(self : ChemmolrepraromaticPath) -> Int32 {
  self.size
}

///|
pub fn ChemmolrepraromaticPath::get(
  self : ChemmolrepraromaticPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolrepraromaticPath::set(
  self : ChemmolrepraromaticPath,
  i : Int32,
  v : Double,
) -> ChemmolrepraromaticPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticPath::sum(self : ChemmolrepraromaticPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolrepraromaticPath::mean(self : ChemmolrepraromaticPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolrepraromaticPath::scale(
  self : ChemmolrepraromaticPath,
  f : Double,
) -> ChemmolrepraromaticPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticPath::add(
  self : ChemmolrepraromaticPath,
  other : ChemmolrepraromaticPath,
) -> ChemmolrepraromaticPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticPath::copy(
  self : ChemmolrepraromaticPath,
) -> ChemmolrepraromaticPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticPath::fill(
  self : ChemmolrepraromaticPath,
  v : Double,
) -> ChemmolrepraromaticPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticPath::min(self : ChemmolrepraromaticPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolrepraromaticPath::max(self : ChemmolrepraromaticPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolrepraromaticPath::to_string(
  self : ChemmolrepraromaticPath,
) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolrepraromaticCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_aromatic_cluster_make(
  size : Int32,
) -> ChemmolrepraromaticCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolrepraromaticCluster::len(
  self : ChemmolrepraromaticCluster,
) -> Int32 {
  self.size
}

///|
pub fn ChemmolrepraromaticCluster::get(
  self : ChemmolrepraromaticCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolrepraromaticCluster::set(
  self : ChemmolrepraromaticCluster,
  i : Int32,
  v : Double,
) -> ChemmolrepraromaticCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticCluster::sum(
  self : ChemmolrepraromaticCluster,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolrepraromaticCluster::mean(
  self : ChemmolrepraromaticCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolrepraromaticCluster::scale(
  self : ChemmolrepraromaticCluster,
  f : Double,
) -> ChemmolrepraromaticCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticCluster::add(
  self : ChemmolrepraromaticCluster,
  other : ChemmolrepraromaticCluster,
) -> ChemmolrepraromaticCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticCluster::copy(
  self : ChemmolrepraromaticCluster,
) -> ChemmolrepraromaticCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticCluster::fill(
  self : ChemmolrepraromaticCluster,
  v : Double,
) -> ChemmolrepraromaticCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticCluster::min(
  self : ChemmolrepraromaticCluster,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolrepraromaticCluster::max(
  self : ChemmolrepraromaticCluster,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolrepraromaticCluster::to_string(
  self : ChemmolrepraromaticCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolrepraromaticModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_aromatic_model_make(
  size : Int32,
) -> ChemmolrepraromaticModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolrepraromaticModel::len(self : ChemmolrepraromaticModel) -> Int32 {
  self.size
}

///|
pub fn ChemmolrepraromaticModel::get(
  self : ChemmolrepraromaticModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolrepraromaticModel::set(
  self : ChemmolrepraromaticModel,
  i : Int32,
  v : Double,
) -> ChemmolrepraromaticModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticModel::sum(self : ChemmolrepraromaticModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolrepraromaticModel::mean(
  self : ChemmolrepraromaticModel,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolrepraromaticModel::scale(
  self : ChemmolrepraromaticModel,
  f : Double,
) -> ChemmolrepraromaticModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticModel::add(
  self : ChemmolrepraromaticModel,
  other : ChemmolrepraromaticModel,
) -> ChemmolrepraromaticModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticModel::copy(
  self : ChemmolrepraromaticModel,
) -> ChemmolrepraromaticModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticModel::fill(
  self : ChemmolrepraromaticModel,
  v : Double,
) -> ChemmolrepraromaticModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticModel::min(self : ChemmolrepraromaticModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolrepraromaticModel::max(self : ChemmolrepraromaticModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolrepraromaticModel::to_string(
  self : ChemmolrepraromaticModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolrepraromaticLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_aromatic_layer_make(
  size : Int32,
) -> ChemmolrepraromaticLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolrepraromaticLayer::len(self : ChemmolrepraromaticLayer) -> Int32 {
  self.size
}

///|
pub fn ChemmolrepraromaticLayer::get(
  self : ChemmolrepraromaticLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolrepraromaticLayer::set(
  self : ChemmolrepraromaticLayer,
  i : Int32,
  v : Double,
) -> ChemmolrepraromaticLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticLayer::sum(self : ChemmolrepraromaticLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolrepraromaticLayer::mean(
  self : ChemmolrepraromaticLayer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolrepraromaticLayer::scale(
  self : ChemmolrepraromaticLayer,
  f : Double,
) -> ChemmolrepraromaticLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticLayer::add(
  self : ChemmolrepraromaticLayer,
  other : ChemmolrepraromaticLayer,
) -> ChemmolrepraromaticLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticLayer::copy(
  self : ChemmolrepraromaticLayer,
) -> ChemmolrepraromaticLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticLayer::fill(
  self : ChemmolrepraromaticLayer,
  v : Double,
) -> ChemmolrepraromaticLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticLayer::min(self : ChemmolrepraromaticLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolrepraromaticLayer::max(self : ChemmolrepraromaticLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolrepraromaticLayer::to_string(
  self : ChemmolrepraromaticLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolrepraromaticBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_aromatic_buffer_make(
  size : Int32,
) -> ChemmolrepraromaticBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolrepraromaticBuffer::len(
  self : ChemmolrepraromaticBuffer,
) -> Int32 {
  self.size
}

///|
pub fn ChemmolrepraromaticBuffer::get(
  self : ChemmolrepraromaticBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolrepraromaticBuffer::set(
  self : ChemmolrepraromaticBuffer,
  i : Int32,
  v : Double,
) -> ChemmolrepraromaticBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticBuffer::sum(
  self : ChemmolrepraromaticBuffer,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolrepraromaticBuffer::mean(
  self : ChemmolrepraromaticBuffer,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolrepraromaticBuffer::scale(
  self : ChemmolrepraromaticBuffer,
  f : Double,
) -> ChemmolrepraromaticBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticBuffer::add(
  self : ChemmolrepraromaticBuffer,
  other : ChemmolrepraromaticBuffer,
) -> ChemmolrepraromaticBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticBuffer::copy(
  self : ChemmolrepraromaticBuffer,
) -> ChemmolrepraromaticBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticBuffer::fill(
  self : ChemmolrepraromaticBuffer,
  v : Double,
) -> ChemmolrepraromaticBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticBuffer::min(
  self : ChemmolrepraromaticBuffer,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolrepraromaticBuffer::max(
  self : ChemmolrepraromaticBuffer,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolrepraromaticBuffer::to_string(
  self : ChemmolrepraromaticBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolrepraromaticCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_aromatic_cursor_make(
  size : Int32,
) -> ChemmolrepraromaticCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolrepraromaticCursor::len(
  self : ChemmolrepraromaticCursor,
) -> Int32 {
  self.size
}

///|
pub fn ChemmolrepraromaticCursor::get(
  self : ChemmolrepraromaticCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolrepraromaticCursor::set(
  self : ChemmolrepraromaticCursor,
  i : Int32,
  v : Double,
) -> ChemmolrepraromaticCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticCursor::sum(
  self : ChemmolrepraromaticCursor,
) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolrepraromaticCursor::mean(
  self : ChemmolrepraromaticCursor,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolrepraromaticCursor::scale(
  self : ChemmolrepraromaticCursor,
  f : Double,
) -> ChemmolrepraromaticCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticCursor::add(
  self : ChemmolrepraromaticCursor,
  other : ChemmolrepraromaticCursor,
) -> ChemmolrepraromaticCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticCursor::copy(
  self : ChemmolrepraromaticCursor,
) -> ChemmolrepraromaticCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticCursor::fill(
  self : ChemmolrepraromaticCursor,
  v : Double,
) -> ChemmolrepraromaticCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticCursor::min(
  self : ChemmolrepraromaticCursor,
) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolrepraromaticCursor::max(
  self : ChemmolrepraromaticCursor,
) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolrepraromaticCursor::to_string(
  self : ChemmolrepraromaticCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolrepraromaticView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_aromatic_view_make(
  size : Int32,
) -> ChemmolrepraromaticView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolrepraromaticView::len(self : ChemmolrepraromaticView) -> Int32 {
  self.size
}

///|
pub fn ChemmolrepraromaticView::get(
  self : ChemmolrepraromaticView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolrepraromaticView::set(
  self : ChemmolrepraromaticView,
  i : Int32,
  v : Double,
) -> ChemmolrepraromaticView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticView::sum(self : ChemmolrepraromaticView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolrepraromaticView::mean(self : ChemmolrepraromaticView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolrepraromaticView::scale(
  self : ChemmolrepraromaticView,
  f : Double,
) -> ChemmolrepraromaticView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticView::add(
  self : ChemmolrepraromaticView,
  other : ChemmolrepraromaticView,
) -> ChemmolrepraromaticView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticView::copy(
  self : ChemmolrepraromaticView,
) -> ChemmolrepraromaticView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticView::fill(
  self : ChemmolrepraromaticView,
  v : Double,
) -> ChemmolrepraromaticView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticView::min(self : ChemmolrepraromaticView) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolrepraromaticView::max(self : ChemmolrepraromaticView) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolrepraromaticView::to_string(
  self : ChemmolrepraromaticView,
) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolrepraromaticRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_aromatic_range_make(
  size : Int32,
) -> ChemmolrepraromaticRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolrepraromaticRange::len(self : ChemmolrepraromaticRange) -> Int32 {
  self.size
}

///|
pub fn ChemmolrepraromaticRange::get(
  self : ChemmolrepraromaticRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolrepraromaticRange::set(
  self : ChemmolrepraromaticRange,
  i : Int32,
  v : Double,
) -> ChemmolrepraromaticRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticRange::sum(self : ChemmolrepraromaticRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolrepraromaticRange::mean(
  self : ChemmolrepraromaticRange,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolrepraromaticRange::scale(
  self : ChemmolrepraromaticRange,
  f : Double,
) -> ChemmolrepraromaticRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticRange::add(
  self : ChemmolrepraromaticRange,
  other : ChemmolrepraromaticRange,
) -> ChemmolrepraromaticRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticRange::copy(
  self : ChemmolrepraromaticRange,
) -> ChemmolrepraromaticRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticRange::fill(
  self : ChemmolrepraromaticRange,
  v : Double,
) -> ChemmolrepraromaticRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticRange::min(self : ChemmolrepraromaticRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolrepraromaticRange::max(self : ChemmolrepraromaticRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolrepraromaticRange::to_string(
  self : ChemmolrepraromaticRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolrepraromaticSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_aromatic_slice_make(
  size : Int32,
) -> ChemmolrepraromaticSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolrepraromaticSlice::len(self : ChemmolrepraromaticSlice) -> Int32 {
  self.size
}

///|
pub fn ChemmolrepraromaticSlice::get(
  self : ChemmolrepraromaticSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolrepraromaticSlice::set(
  self : ChemmolrepraromaticSlice,
  i : Int32,
  v : Double,
) -> ChemmolrepraromaticSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticSlice::sum(self : ChemmolrepraromaticSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolrepraromaticSlice::mean(
  self : ChemmolrepraromaticSlice,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolrepraromaticSlice::scale(
  self : ChemmolrepraromaticSlice,
  f : Double,
) -> ChemmolrepraromaticSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticSlice::add(
  self : ChemmolrepraromaticSlice,
  other : ChemmolrepraromaticSlice,
) -> ChemmolrepraromaticSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticSlice::copy(
  self : ChemmolrepraromaticSlice,
) -> ChemmolrepraromaticSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticSlice::fill(
  self : ChemmolrepraromaticSlice,
  v : Double,
) -> ChemmolrepraromaticSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolrepraromaticSlice::min(self : ChemmolrepraromaticSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolrepraromaticSlice::max(self : ChemmolrepraromaticSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolrepraromaticSlice::to_string(
  self : ChemmolrepraromaticSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
