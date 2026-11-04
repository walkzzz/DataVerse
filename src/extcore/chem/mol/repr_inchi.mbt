///|
///===
/// extcore/chem_mol_repr_inchi
pub(all) struct ChemmolreprinchiPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn chem_mol_repr_inchi_make_point(
  x : Double,
  y : Double,
) -> ChemmolreprinchiPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn chem_mol_repr_inchi_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> ChemmolreprinchiPoint {
  { x, y, z, label: 0, }
}

///|
pub fn ChemmolreprinchiPoint::x(self : ChemmolreprinchiPoint) -> Double {
  self.x
}

///|
pub fn ChemmolreprinchiPoint::y(self : ChemmolreprinchiPoint) -> Double {
  self.y
}

///|
pub fn ChemmolreprinchiPoint::z(self : ChemmolreprinchiPoint) -> Double {
  self.z
}

///|
pub fn ChemmolreprinchiPoint::label(self : ChemmolreprinchiPoint) -> Int32 {
  self.label
}

///|
pub fn ChemmolreprinchiPoint::dist(
  self : ChemmolreprinchiPoint,
  other : ChemmolreprinchiPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn ChemmolreprinchiPoint::add(
  self : ChemmolreprinchiPoint,
  other : ChemmolreprinchiPoint,
) -> ChemmolreprinchiPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn ChemmolreprinchiPoint::sub(
  self : ChemmolreprinchiPoint,
  other : ChemmolreprinchiPoint,
) -> ChemmolreprinchiPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn ChemmolreprinchiPoint::scale(
  self : ChemmolreprinchiPoint,
  s : Double,
) -> ChemmolreprinchiPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn ChemmolreprinchiPoint::dot(
  self : ChemmolreprinchiPoint,
  other : ChemmolreprinchiPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn ChemmolreprinchiPoint::cross(
  self : ChemmolreprinchiPoint,
  other : ChemmolreprinchiPoint,
) -> ChemmolreprinchiPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn ChemmolreprinchiPoint::norm(self : ChemmolreprinchiPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn ChemmolreprinchiPoint::normalize(
  self : ChemmolreprinchiPoint,
) -> ChemmolreprinchiPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn ChemmolreprinchiPoint::negate(
  self : ChemmolreprinchiPoint,
) -> ChemmolreprinchiPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn ChemmolreprinchiPoint::mid(
  self : ChemmolreprinchiPoint,
  other : ChemmolreprinchiPoint,
) -> ChemmolreprinchiPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn ChemmolreprinchiPoint::lerp(
  self : ChemmolreprinchiPoint,
  other : ChemmolreprinchiPoint,
  t : Double,
) -> ChemmolreprinchiPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn ChemmolreprinchiPoint::to_string(self : ChemmolreprinchiPoint) -> String {
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
pub(all) struct ChemmolreprinchiSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn chem_mol_repr_inchi_make_series(
  vals : Array[Double],
  name : String,
) -> ChemmolreprinchiSeries {
  { vals, name, meta: 0, }
}

///|
pub fn ChemmolreprinchiSeries::len(self : ChemmolreprinchiSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn ChemmolreprinchiSeries::sum(self : ChemmolreprinchiSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn ChemmolreprinchiSeries::mean(self : ChemmolreprinchiSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn ChemmolreprinchiSeries::min(self : ChemmolreprinchiSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn ChemmolreprinchiSeries::max(self : ChemmolreprinchiSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn ChemmolreprinchiSeries::range(self : ChemmolreprinchiSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn ChemmolreprinchiSeries::variance(
  self : ChemmolreprinchiSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn ChemmolreprinchiSeries::std(self : ChemmolreprinchiSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn ChemmolreprinchiSeries::median(self : ChemmolreprinchiSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn ChemmolreprinchiSeries::scale(
  self : ChemmolreprinchiSeries,
  f : Double,
) -> ChemmolreprinchiSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn ChemmolreprinchiSeries::add(
  self : ChemmolreprinchiSeries,
  other : ChemmolreprinchiSeries,
) -> ChemmolreprinchiSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn ChemmolreprinchiSeries::sub(
  self : ChemmolreprinchiSeries,
  other : ChemmolreprinchiSeries,
) -> ChemmolreprinchiSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn ChemmolreprinchiSeries::normalize(
  self : ChemmolreprinchiSeries,
) -> ChemmolreprinchiSeries {
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
pub fn ChemmolreprinchiSeries::cumsum(
  self : ChemmolreprinchiSeries,
) -> ChemmolreprinchiSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn ChemmolreprinchiSeries::to_string(
  self : ChemmolreprinchiSeries,
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
pub(all) struct ChemmolreprinchiMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn chem_mol_repr_inchi_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> ChemmolreprinchiMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn chem_mol_repr_inchi_matrix_identity(n : Int32) -> ChemmolreprinchiMatrix {
  let m = chem_mol_repr_inchi_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn ChemmolreprinchiMatrix::get(
  self : ChemmolreprinchiMatrix,
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
pub fn ChemmolreprinchiMatrix::transpose(
  self : ChemmolreprinchiMatrix,
) -> ChemmolreprinchiMatrix {
  let result = chem_mol_repr_inchi_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn ChemmolreprinchiMatrix::add(
  self : ChemmolreprinchiMatrix,
  other : ChemmolreprinchiMatrix,
) -> ChemmolreprinchiMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = chem_mol_repr_inchi_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn ChemmolreprinchiMatrix::scale(
  self : ChemmolreprinchiMatrix,
  s : Double,
) -> ChemmolreprinchiMatrix {
  let result = chem_mol_repr_inchi_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn ChemmolreprinchiMatrix::multiply(
  self : ChemmolreprinchiMatrix,
  other : ChemmolreprinchiMatrix,
) -> ChemmolreprinchiMatrix {
  if self.cols != other.rows {
    return chem_mol_repr_inchi_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = chem_mol_repr_inchi_make_matrix(self.rows, other.cols, 0.0)
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
pub fn ChemmolreprinchiMatrix::trace(self : ChemmolreprinchiMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn ChemmolreprinchiMatrix::det(self : ChemmolreprinchiMatrix) -> Double {
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
pub fn ChemmolreprinchiMatrix::norm(self : ChemmolreprinchiMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn ChemmolreprinchiMatrix::to_string(
  self : ChemmolreprinchiMatrix,
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
pub(all) struct ChemmolreprinchiVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn chem_mol_repr_inchi_make_vector(
  comps : Array[Double],
) -> ChemmolreprinchiVector {
  { comps, dim: comps.length(), }
}

///|
pub fn chem_mol_repr_inchi_vector_zero(dim : Int32) -> ChemmolreprinchiVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn ChemmolreprinchiVector::add(
  self : ChemmolreprinchiVector,
  other : ChemmolreprinchiVector,
) -> ChemmolreprinchiVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn ChemmolreprinchiVector::sub(
  self : ChemmolreprinchiVector,
  other : ChemmolreprinchiVector,
) -> ChemmolreprinchiVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn ChemmolreprinchiVector::scale(
  self : ChemmolreprinchiVector,
  s : Double,
) -> ChemmolreprinchiVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn ChemmolreprinchiVector::dot(
  self : ChemmolreprinchiVector,
  other : ChemmolreprinchiVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn ChemmolreprinchiVector::norm(self : ChemmolreprinchiVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn ChemmolreprinchiVector::normalize(
  self : ChemmolreprinchiVector,
) -> ChemmolreprinchiVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn ChemmolreprinchiVector::dist(
  self : ChemmolreprinchiVector,
  other : ChemmolreprinchiVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn ChemmolreprinchiVector::to_string(
  self : ChemmolreprinchiVector,
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
pub(all) struct ChemmolreprinchiFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_inchi_frame_make(size : Int32) -> ChemmolreprinchiFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolreprinchiFrame::len(self : ChemmolreprinchiFrame) -> Int32 {
  self.size
}

///|
pub fn ChemmolreprinchiFrame::get(
  self : ChemmolreprinchiFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolreprinchiFrame::set(
  self : ChemmolreprinchiFrame,
  i : Int32,
  v : Double,
) -> ChemmolreprinchiFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiFrame::sum(self : ChemmolreprinchiFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolreprinchiFrame::mean(self : ChemmolreprinchiFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolreprinchiFrame::scale(
  self : ChemmolreprinchiFrame,
  f : Double,
) -> ChemmolreprinchiFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiFrame::add(
  self : ChemmolreprinchiFrame,
  other : ChemmolreprinchiFrame,
) -> ChemmolreprinchiFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiFrame::copy(
  self : ChemmolreprinchiFrame,
) -> ChemmolreprinchiFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiFrame::fill(
  self : ChemmolreprinchiFrame,
  v : Double,
) -> ChemmolreprinchiFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiFrame::min(self : ChemmolreprinchiFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolreprinchiFrame::max(self : ChemmolreprinchiFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolreprinchiFrame::to_string(self : ChemmolreprinchiFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolreprinchiTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_inchi_table_make(size : Int32) -> ChemmolreprinchiTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolreprinchiTable::len(self : ChemmolreprinchiTable) -> Int32 {
  self.size
}

///|
pub fn ChemmolreprinchiTable::get(
  self : ChemmolreprinchiTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolreprinchiTable::set(
  self : ChemmolreprinchiTable,
  i : Int32,
  v : Double,
) -> ChemmolreprinchiTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiTable::sum(self : ChemmolreprinchiTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolreprinchiTable::mean(self : ChemmolreprinchiTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolreprinchiTable::scale(
  self : ChemmolreprinchiTable,
  f : Double,
) -> ChemmolreprinchiTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiTable::add(
  self : ChemmolreprinchiTable,
  other : ChemmolreprinchiTable,
) -> ChemmolreprinchiTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiTable::copy(
  self : ChemmolreprinchiTable,
) -> ChemmolreprinchiTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiTable::fill(
  self : ChemmolreprinchiTable,
  v : Double,
) -> ChemmolreprinchiTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiTable::min(self : ChemmolreprinchiTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolreprinchiTable::max(self : ChemmolreprinchiTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolreprinchiTable::to_string(self : ChemmolreprinchiTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolreprinchiGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_inchi_graphn_make(size : Int32) -> ChemmolreprinchiGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolreprinchiGraphN::len(self : ChemmolreprinchiGraphN) -> Int32 {
  self.size
}

///|
pub fn ChemmolreprinchiGraphN::get(
  self : ChemmolreprinchiGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolreprinchiGraphN::set(
  self : ChemmolreprinchiGraphN,
  i : Int32,
  v : Double,
) -> ChemmolreprinchiGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiGraphN::sum(self : ChemmolreprinchiGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolreprinchiGraphN::mean(self : ChemmolreprinchiGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolreprinchiGraphN::scale(
  self : ChemmolreprinchiGraphN,
  f : Double,
) -> ChemmolreprinchiGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiGraphN::add(
  self : ChemmolreprinchiGraphN,
  other : ChemmolreprinchiGraphN,
) -> ChemmolreprinchiGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiGraphN::copy(
  self : ChemmolreprinchiGraphN,
) -> ChemmolreprinchiGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiGraphN::fill(
  self : ChemmolreprinchiGraphN,
  v : Double,
) -> ChemmolreprinchiGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiGraphN::min(self : ChemmolreprinchiGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolreprinchiGraphN::max(self : ChemmolreprinchiGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolreprinchiGraphN::to_string(
  self : ChemmolreprinchiGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolreprinchiNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_inchi_node_make(size : Int32) -> ChemmolreprinchiNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolreprinchiNode::len(self : ChemmolreprinchiNode) -> Int32 {
  self.size
}

///|
pub fn ChemmolreprinchiNode::get(
  self : ChemmolreprinchiNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolreprinchiNode::set(
  self : ChemmolreprinchiNode,
  i : Int32,
  v : Double,
) -> ChemmolreprinchiNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiNode::sum(self : ChemmolreprinchiNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolreprinchiNode::mean(self : ChemmolreprinchiNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolreprinchiNode::scale(
  self : ChemmolreprinchiNode,
  f : Double,
) -> ChemmolreprinchiNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiNode::add(
  self : ChemmolreprinchiNode,
  other : ChemmolreprinchiNode,
) -> ChemmolreprinchiNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiNode::copy(
  self : ChemmolreprinchiNode,
) -> ChemmolreprinchiNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiNode::fill(
  self : ChemmolreprinchiNode,
  v : Double,
) -> ChemmolreprinchiNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiNode::min(self : ChemmolreprinchiNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolreprinchiNode::max(self : ChemmolreprinchiNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolreprinchiNode::to_string(self : ChemmolreprinchiNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolreprinchiEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_inchi_edge_make(size : Int32) -> ChemmolreprinchiEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolreprinchiEdge::len(self : ChemmolreprinchiEdge) -> Int32 {
  self.size
}

///|
pub fn ChemmolreprinchiEdge::get(
  self : ChemmolreprinchiEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolreprinchiEdge::set(
  self : ChemmolreprinchiEdge,
  i : Int32,
  v : Double,
) -> ChemmolreprinchiEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiEdge::sum(self : ChemmolreprinchiEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolreprinchiEdge::mean(self : ChemmolreprinchiEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolreprinchiEdge::scale(
  self : ChemmolreprinchiEdge,
  f : Double,
) -> ChemmolreprinchiEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiEdge::add(
  self : ChemmolreprinchiEdge,
  other : ChemmolreprinchiEdge,
) -> ChemmolreprinchiEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiEdge::copy(
  self : ChemmolreprinchiEdge,
) -> ChemmolreprinchiEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiEdge::fill(
  self : ChemmolreprinchiEdge,
  v : Double,
) -> ChemmolreprinchiEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiEdge::min(self : ChemmolreprinchiEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolreprinchiEdge::max(self : ChemmolreprinchiEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolreprinchiEdge::to_string(self : ChemmolreprinchiEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolreprinchiPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_inchi_path_make(size : Int32) -> ChemmolreprinchiPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolreprinchiPath::len(self : ChemmolreprinchiPath) -> Int32 {
  self.size
}

///|
pub fn ChemmolreprinchiPath::get(
  self : ChemmolreprinchiPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolreprinchiPath::set(
  self : ChemmolreprinchiPath,
  i : Int32,
  v : Double,
) -> ChemmolreprinchiPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiPath::sum(self : ChemmolreprinchiPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolreprinchiPath::mean(self : ChemmolreprinchiPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolreprinchiPath::scale(
  self : ChemmolreprinchiPath,
  f : Double,
) -> ChemmolreprinchiPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiPath::add(
  self : ChemmolreprinchiPath,
  other : ChemmolreprinchiPath,
) -> ChemmolreprinchiPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiPath::copy(
  self : ChemmolreprinchiPath,
) -> ChemmolreprinchiPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiPath::fill(
  self : ChemmolreprinchiPath,
  v : Double,
) -> ChemmolreprinchiPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiPath::min(self : ChemmolreprinchiPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolreprinchiPath::max(self : ChemmolreprinchiPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolreprinchiPath::to_string(self : ChemmolreprinchiPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolreprinchiCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_inchi_cluster_make(
  size : Int32,
) -> ChemmolreprinchiCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolreprinchiCluster::len(self : ChemmolreprinchiCluster) -> Int32 {
  self.size
}

///|
pub fn ChemmolreprinchiCluster::get(
  self : ChemmolreprinchiCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolreprinchiCluster::set(
  self : ChemmolreprinchiCluster,
  i : Int32,
  v : Double,
) -> ChemmolreprinchiCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiCluster::sum(self : ChemmolreprinchiCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolreprinchiCluster::mean(self : ChemmolreprinchiCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolreprinchiCluster::scale(
  self : ChemmolreprinchiCluster,
  f : Double,
) -> ChemmolreprinchiCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiCluster::add(
  self : ChemmolreprinchiCluster,
  other : ChemmolreprinchiCluster,
) -> ChemmolreprinchiCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiCluster::copy(
  self : ChemmolreprinchiCluster,
) -> ChemmolreprinchiCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiCluster::fill(
  self : ChemmolreprinchiCluster,
  v : Double,
) -> ChemmolreprinchiCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiCluster::min(self : ChemmolreprinchiCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolreprinchiCluster::max(self : ChemmolreprinchiCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolreprinchiCluster::to_string(
  self : ChemmolreprinchiCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolreprinchiModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_inchi_model_make(size : Int32) -> ChemmolreprinchiModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolreprinchiModel::len(self : ChemmolreprinchiModel) -> Int32 {
  self.size
}

///|
pub fn ChemmolreprinchiModel::get(
  self : ChemmolreprinchiModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolreprinchiModel::set(
  self : ChemmolreprinchiModel,
  i : Int32,
  v : Double,
) -> ChemmolreprinchiModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiModel::sum(self : ChemmolreprinchiModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolreprinchiModel::mean(self : ChemmolreprinchiModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolreprinchiModel::scale(
  self : ChemmolreprinchiModel,
  f : Double,
) -> ChemmolreprinchiModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiModel::add(
  self : ChemmolreprinchiModel,
  other : ChemmolreprinchiModel,
) -> ChemmolreprinchiModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiModel::copy(
  self : ChemmolreprinchiModel,
) -> ChemmolreprinchiModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiModel::fill(
  self : ChemmolreprinchiModel,
  v : Double,
) -> ChemmolreprinchiModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiModel::min(self : ChemmolreprinchiModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolreprinchiModel::max(self : ChemmolreprinchiModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolreprinchiModel::to_string(self : ChemmolreprinchiModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolreprinchiLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_inchi_layer_make(size : Int32) -> ChemmolreprinchiLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolreprinchiLayer::len(self : ChemmolreprinchiLayer) -> Int32 {
  self.size
}

///|
pub fn ChemmolreprinchiLayer::get(
  self : ChemmolreprinchiLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolreprinchiLayer::set(
  self : ChemmolreprinchiLayer,
  i : Int32,
  v : Double,
) -> ChemmolreprinchiLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiLayer::sum(self : ChemmolreprinchiLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolreprinchiLayer::mean(self : ChemmolreprinchiLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolreprinchiLayer::scale(
  self : ChemmolreprinchiLayer,
  f : Double,
) -> ChemmolreprinchiLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiLayer::add(
  self : ChemmolreprinchiLayer,
  other : ChemmolreprinchiLayer,
) -> ChemmolreprinchiLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiLayer::copy(
  self : ChemmolreprinchiLayer,
) -> ChemmolreprinchiLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiLayer::fill(
  self : ChemmolreprinchiLayer,
  v : Double,
) -> ChemmolreprinchiLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiLayer::min(self : ChemmolreprinchiLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolreprinchiLayer::max(self : ChemmolreprinchiLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolreprinchiLayer::to_string(self : ChemmolreprinchiLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolreprinchiBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_inchi_buffer_make(size : Int32) -> ChemmolreprinchiBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolreprinchiBuffer::len(self : ChemmolreprinchiBuffer) -> Int32 {
  self.size
}

///|
pub fn ChemmolreprinchiBuffer::get(
  self : ChemmolreprinchiBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolreprinchiBuffer::set(
  self : ChemmolreprinchiBuffer,
  i : Int32,
  v : Double,
) -> ChemmolreprinchiBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiBuffer::sum(self : ChemmolreprinchiBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolreprinchiBuffer::mean(self : ChemmolreprinchiBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolreprinchiBuffer::scale(
  self : ChemmolreprinchiBuffer,
  f : Double,
) -> ChemmolreprinchiBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiBuffer::add(
  self : ChemmolreprinchiBuffer,
  other : ChemmolreprinchiBuffer,
) -> ChemmolreprinchiBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiBuffer::copy(
  self : ChemmolreprinchiBuffer,
) -> ChemmolreprinchiBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiBuffer::fill(
  self : ChemmolreprinchiBuffer,
  v : Double,
) -> ChemmolreprinchiBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiBuffer::min(self : ChemmolreprinchiBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolreprinchiBuffer::max(self : ChemmolreprinchiBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolreprinchiBuffer::to_string(
  self : ChemmolreprinchiBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolreprinchiCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_inchi_cursor_make(size : Int32) -> ChemmolreprinchiCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolreprinchiCursor::len(self : ChemmolreprinchiCursor) -> Int32 {
  self.size
}

///|
pub fn ChemmolreprinchiCursor::get(
  self : ChemmolreprinchiCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolreprinchiCursor::set(
  self : ChemmolreprinchiCursor,
  i : Int32,
  v : Double,
) -> ChemmolreprinchiCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiCursor::sum(self : ChemmolreprinchiCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolreprinchiCursor::mean(self : ChemmolreprinchiCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolreprinchiCursor::scale(
  self : ChemmolreprinchiCursor,
  f : Double,
) -> ChemmolreprinchiCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiCursor::add(
  self : ChemmolreprinchiCursor,
  other : ChemmolreprinchiCursor,
) -> ChemmolreprinchiCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiCursor::copy(
  self : ChemmolreprinchiCursor,
) -> ChemmolreprinchiCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiCursor::fill(
  self : ChemmolreprinchiCursor,
  v : Double,
) -> ChemmolreprinchiCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiCursor::min(self : ChemmolreprinchiCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolreprinchiCursor::max(self : ChemmolreprinchiCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolreprinchiCursor::to_string(
  self : ChemmolreprinchiCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolreprinchiView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_inchi_view_make(size : Int32) -> ChemmolreprinchiView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolreprinchiView::len(self : ChemmolreprinchiView) -> Int32 {
  self.size
}

///|
pub fn ChemmolreprinchiView::get(
  self : ChemmolreprinchiView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolreprinchiView::set(
  self : ChemmolreprinchiView,
  i : Int32,
  v : Double,
) -> ChemmolreprinchiView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiView::sum(self : ChemmolreprinchiView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolreprinchiView::mean(self : ChemmolreprinchiView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolreprinchiView::scale(
  self : ChemmolreprinchiView,
  f : Double,
) -> ChemmolreprinchiView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiView::add(
  self : ChemmolreprinchiView,
  other : ChemmolreprinchiView,
) -> ChemmolreprinchiView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiView::copy(
  self : ChemmolreprinchiView,
) -> ChemmolreprinchiView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiView::fill(
  self : ChemmolreprinchiView,
  v : Double,
) -> ChemmolreprinchiView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiView::min(self : ChemmolreprinchiView) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolreprinchiView::max(self : ChemmolreprinchiView) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolreprinchiView::to_string(self : ChemmolreprinchiView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolreprinchiRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_inchi_range_make(size : Int32) -> ChemmolreprinchiRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolreprinchiRange::len(self : ChemmolreprinchiRange) -> Int32 {
  self.size
}

///|
pub fn ChemmolreprinchiRange::get(
  self : ChemmolreprinchiRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolreprinchiRange::set(
  self : ChemmolreprinchiRange,
  i : Int32,
  v : Double,
) -> ChemmolreprinchiRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiRange::sum(self : ChemmolreprinchiRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolreprinchiRange::mean(self : ChemmolreprinchiRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolreprinchiRange::scale(
  self : ChemmolreprinchiRange,
  f : Double,
) -> ChemmolreprinchiRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiRange::add(
  self : ChemmolreprinchiRange,
  other : ChemmolreprinchiRange,
) -> ChemmolreprinchiRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiRange::copy(
  self : ChemmolreprinchiRange,
) -> ChemmolreprinchiRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiRange::fill(
  self : ChemmolreprinchiRange,
  v : Double,
) -> ChemmolreprinchiRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiRange::min(self : ChemmolreprinchiRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolreprinchiRange::max(self : ChemmolreprinchiRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolreprinchiRange::to_string(self : ChemmolreprinchiRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolreprinchiSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_inchi_slice_make(size : Int32) -> ChemmolreprinchiSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolreprinchiSlice::len(self : ChemmolreprinchiSlice) -> Int32 {
  self.size
}

///|
pub fn ChemmolreprinchiSlice::get(
  self : ChemmolreprinchiSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolreprinchiSlice::set(
  self : ChemmolreprinchiSlice,
  i : Int32,
  v : Double,
) -> ChemmolreprinchiSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiSlice::sum(self : ChemmolreprinchiSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolreprinchiSlice::mean(self : ChemmolreprinchiSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolreprinchiSlice::scale(
  self : ChemmolreprinchiSlice,
  f : Double,
) -> ChemmolreprinchiSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiSlice::add(
  self : ChemmolreprinchiSlice,
  other : ChemmolreprinchiSlice,
) -> ChemmolreprinchiSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiSlice::copy(
  self : ChemmolreprinchiSlice,
) -> ChemmolreprinchiSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiSlice::fill(
  self : ChemmolreprinchiSlice,
  v : Double,
) -> ChemmolreprinchiSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprinchiSlice::min(self : ChemmolreprinchiSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolreprinchiSlice::max(self : ChemmolreprinchiSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolreprinchiSlice::to_string(self : ChemmolreprinchiSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
