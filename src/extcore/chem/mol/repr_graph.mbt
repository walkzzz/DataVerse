///|
///===
/// extcore/chem_mol_repr_graph
pub(all) struct ChemmolreprgraphPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn chem_mol_repr_graph_make_point(
  x : Double,
  y : Double,
) -> ChemmolreprgraphPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn chem_mol_repr_graph_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> ChemmolreprgraphPoint {
  { x, y, z, label: 0, }
}

///|
pub fn ChemmolreprgraphPoint::x(self : ChemmolreprgraphPoint) -> Double {
  self.x
}

///|
pub fn ChemmolreprgraphPoint::y(self : ChemmolreprgraphPoint) -> Double {
  self.y
}

///|
pub fn ChemmolreprgraphPoint::z(self : ChemmolreprgraphPoint) -> Double {
  self.z
}

///|
pub fn ChemmolreprgraphPoint::label(self : ChemmolreprgraphPoint) -> Int32 {
  self.label
}

///|
pub fn ChemmolreprgraphPoint::dist(
  self : ChemmolreprgraphPoint,
  other : ChemmolreprgraphPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn ChemmolreprgraphPoint::add(
  self : ChemmolreprgraphPoint,
  other : ChemmolreprgraphPoint,
) -> ChemmolreprgraphPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn ChemmolreprgraphPoint::sub(
  self : ChemmolreprgraphPoint,
  other : ChemmolreprgraphPoint,
) -> ChemmolreprgraphPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn ChemmolreprgraphPoint::scale(
  self : ChemmolreprgraphPoint,
  s : Double,
) -> ChemmolreprgraphPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn ChemmolreprgraphPoint::dot(
  self : ChemmolreprgraphPoint,
  other : ChemmolreprgraphPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn ChemmolreprgraphPoint::cross(
  self : ChemmolreprgraphPoint,
  other : ChemmolreprgraphPoint,
) -> ChemmolreprgraphPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn ChemmolreprgraphPoint::norm(self : ChemmolreprgraphPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn ChemmolreprgraphPoint::normalize(
  self : ChemmolreprgraphPoint,
) -> ChemmolreprgraphPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn ChemmolreprgraphPoint::negate(
  self : ChemmolreprgraphPoint,
) -> ChemmolreprgraphPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn ChemmolreprgraphPoint::mid(
  self : ChemmolreprgraphPoint,
  other : ChemmolreprgraphPoint,
) -> ChemmolreprgraphPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn ChemmolreprgraphPoint::lerp(
  self : ChemmolreprgraphPoint,
  other : ChemmolreprgraphPoint,
  t : Double,
) -> ChemmolreprgraphPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn ChemmolreprgraphPoint::to_string(self : ChemmolreprgraphPoint) -> String {
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
pub(all) struct ChemmolreprgraphSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn chem_mol_repr_graph_make_series(
  vals : Array[Double],
  name : String,
) -> ChemmolreprgraphSeries {
  { vals, name, meta: 0, }
}

///|
pub fn ChemmolreprgraphSeries::len(self : ChemmolreprgraphSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn ChemmolreprgraphSeries::sum(self : ChemmolreprgraphSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn ChemmolreprgraphSeries::mean(self : ChemmolreprgraphSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn ChemmolreprgraphSeries::min(self : ChemmolreprgraphSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn ChemmolreprgraphSeries::max(self : ChemmolreprgraphSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn ChemmolreprgraphSeries::range(self : ChemmolreprgraphSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn ChemmolreprgraphSeries::variance(
  self : ChemmolreprgraphSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn ChemmolreprgraphSeries::std(self : ChemmolreprgraphSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn ChemmolreprgraphSeries::median(self : ChemmolreprgraphSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn ChemmolreprgraphSeries::scale(
  self : ChemmolreprgraphSeries,
  f : Double,
) -> ChemmolreprgraphSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn ChemmolreprgraphSeries::add(
  self : ChemmolreprgraphSeries,
  other : ChemmolreprgraphSeries,
) -> ChemmolreprgraphSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn ChemmolreprgraphSeries::sub(
  self : ChemmolreprgraphSeries,
  other : ChemmolreprgraphSeries,
) -> ChemmolreprgraphSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn ChemmolreprgraphSeries::normalize(
  self : ChemmolreprgraphSeries,
) -> ChemmolreprgraphSeries {
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
pub fn ChemmolreprgraphSeries::cumsum(
  self : ChemmolreprgraphSeries,
) -> ChemmolreprgraphSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn ChemmolreprgraphSeries::to_string(
  self : ChemmolreprgraphSeries,
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
pub(all) struct ChemmolreprgraphMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn chem_mol_repr_graph_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> ChemmolreprgraphMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn chem_mol_repr_graph_matrix_identity(n : Int32) -> ChemmolreprgraphMatrix {
  let m = chem_mol_repr_graph_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn ChemmolreprgraphMatrix::get(
  self : ChemmolreprgraphMatrix,
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
pub fn ChemmolreprgraphMatrix::transpose(
  self : ChemmolreprgraphMatrix,
) -> ChemmolreprgraphMatrix {
  let result = chem_mol_repr_graph_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn ChemmolreprgraphMatrix::add(
  self : ChemmolreprgraphMatrix,
  other : ChemmolreprgraphMatrix,
) -> ChemmolreprgraphMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = chem_mol_repr_graph_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn ChemmolreprgraphMatrix::scale(
  self : ChemmolreprgraphMatrix,
  s : Double,
) -> ChemmolreprgraphMatrix {
  let result = chem_mol_repr_graph_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn ChemmolreprgraphMatrix::multiply(
  self : ChemmolreprgraphMatrix,
  other : ChemmolreprgraphMatrix,
) -> ChemmolreprgraphMatrix {
  if self.cols != other.rows {
    return chem_mol_repr_graph_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = chem_mol_repr_graph_make_matrix(self.rows, other.cols, 0.0)
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
pub fn ChemmolreprgraphMatrix::trace(self : ChemmolreprgraphMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn ChemmolreprgraphMatrix::det(self : ChemmolreprgraphMatrix) -> Double {
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
pub fn ChemmolreprgraphMatrix::norm(self : ChemmolreprgraphMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn ChemmolreprgraphMatrix::to_string(
  self : ChemmolreprgraphMatrix,
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
pub(all) struct ChemmolreprgraphVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn chem_mol_repr_graph_make_vector(
  comps : Array[Double],
) -> ChemmolreprgraphVector {
  { comps, dim: comps.length(), }
}

///|
pub fn chem_mol_repr_graph_vector_zero(dim : Int32) -> ChemmolreprgraphVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn ChemmolreprgraphVector::add(
  self : ChemmolreprgraphVector,
  other : ChemmolreprgraphVector,
) -> ChemmolreprgraphVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn ChemmolreprgraphVector::sub(
  self : ChemmolreprgraphVector,
  other : ChemmolreprgraphVector,
) -> ChemmolreprgraphVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn ChemmolreprgraphVector::scale(
  self : ChemmolreprgraphVector,
  s : Double,
) -> ChemmolreprgraphVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn ChemmolreprgraphVector::dot(
  self : ChemmolreprgraphVector,
  other : ChemmolreprgraphVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn ChemmolreprgraphVector::norm(self : ChemmolreprgraphVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn ChemmolreprgraphVector::normalize(
  self : ChemmolreprgraphVector,
) -> ChemmolreprgraphVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn ChemmolreprgraphVector::dist(
  self : ChemmolreprgraphVector,
  other : ChemmolreprgraphVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn ChemmolreprgraphVector::to_string(
  self : ChemmolreprgraphVector,
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
pub(all) struct ChemmolreprgraphFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_graph_frame_make(size : Int32) -> ChemmolreprgraphFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolreprgraphFrame::len(self : ChemmolreprgraphFrame) -> Int32 {
  self.size
}

///|
pub fn ChemmolreprgraphFrame::get(
  self : ChemmolreprgraphFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolreprgraphFrame::set(
  self : ChemmolreprgraphFrame,
  i : Int32,
  v : Double,
) -> ChemmolreprgraphFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphFrame::sum(self : ChemmolreprgraphFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolreprgraphFrame::mean(self : ChemmolreprgraphFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolreprgraphFrame::scale(
  self : ChemmolreprgraphFrame,
  f : Double,
) -> ChemmolreprgraphFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphFrame::add(
  self : ChemmolreprgraphFrame,
  other : ChemmolreprgraphFrame,
) -> ChemmolreprgraphFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphFrame::copy(
  self : ChemmolreprgraphFrame,
) -> ChemmolreprgraphFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphFrame::fill(
  self : ChemmolreprgraphFrame,
  v : Double,
) -> ChemmolreprgraphFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphFrame::min(self : ChemmolreprgraphFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolreprgraphFrame::max(self : ChemmolreprgraphFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolreprgraphFrame::to_string(self : ChemmolreprgraphFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolreprgraphTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_graph_table_make(size : Int32) -> ChemmolreprgraphTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolreprgraphTable::len(self : ChemmolreprgraphTable) -> Int32 {
  self.size
}

///|
pub fn ChemmolreprgraphTable::get(
  self : ChemmolreprgraphTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolreprgraphTable::set(
  self : ChemmolreprgraphTable,
  i : Int32,
  v : Double,
) -> ChemmolreprgraphTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphTable::sum(self : ChemmolreprgraphTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolreprgraphTable::mean(self : ChemmolreprgraphTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolreprgraphTable::scale(
  self : ChemmolreprgraphTable,
  f : Double,
) -> ChemmolreprgraphTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphTable::add(
  self : ChemmolreprgraphTable,
  other : ChemmolreprgraphTable,
) -> ChemmolreprgraphTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphTable::copy(
  self : ChemmolreprgraphTable,
) -> ChemmolreprgraphTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphTable::fill(
  self : ChemmolreprgraphTable,
  v : Double,
) -> ChemmolreprgraphTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphTable::min(self : ChemmolreprgraphTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolreprgraphTable::max(self : ChemmolreprgraphTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolreprgraphTable::to_string(self : ChemmolreprgraphTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolreprgraphGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_graph_graphn_make(size : Int32) -> ChemmolreprgraphGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolreprgraphGraphN::len(self : ChemmolreprgraphGraphN) -> Int32 {
  self.size
}

///|
pub fn ChemmolreprgraphGraphN::get(
  self : ChemmolreprgraphGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolreprgraphGraphN::set(
  self : ChemmolreprgraphGraphN,
  i : Int32,
  v : Double,
) -> ChemmolreprgraphGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphGraphN::sum(self : ChemmolreprgraphGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolreprgraphGraphN::mean(self : ChemmolreprgraphGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolreprgraphGraphN::scale(
  self : ChemmolreprgraphGraphN,
  f : Double,
) -> ChemmolreprgraphGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphGraphN::add(
  self : ChemmolreprgraphGraphN,
  other : ChemmolreprgraphGraphN,
) -> ChemmolreprgraphGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphGraphN::copy(
  self : ChemmolreprgraphGraphN,
) -> ChemmolreprgraphGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphGraphN::fill(
  self : ChemmolreprgraphGraphN,
  v : Double,
) -> ChemmolreprgraphGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphGraphN::min(self : ChemmolreprgraphGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolreprgraphGraphN::max(self : ChemmolreprgraphGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolreprgraphGraphN::to_string(
  self : ChemmolreprgraphGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolreprgraphNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_graph_node_make(size : Int32) -> ChemmolreprgraphNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolreprgraphNode::len(self : ChemmolreprgraphNode) -> Int32 {
  self.size
}

///|
pub fn ChemmolreprgraphNode::get(
  self : ChemmolreprgraphNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolreprgraphNode::set(
  self : ChemmolreprgraphNode,
  i : Int32,
  v : Double,
) -> ChemmolreprgraphNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphNode::sum(self : ChemmolreprgraphNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolreprgraphNode::mean(self : ChemmolreprgraphNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolreprgraphNode::scale(
  self : ChemmolreprgraphNode,
  f : Double,
) -> ChemmolreprgraphNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphNode::add(
  self : ChemmolreprgraphNode,
  other : ChemmolreprgraphNode,
) -> ChemmolreprgraphNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphNode::copy(
  self : ChemmolreprgraphNode,
) -> ChemmolreprgraphNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphNode::fill(
  self : ChemmolreprgraphNode,
  v : Double,
) -> ChemmolreprgraphNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphNode::min(self : ChemmolreprgraphNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolreprgraphNode::max(self : ChemmolreprgraphNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolreprgraphNode::to_string(self : ChemmolreprgraphNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolreprgraphEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_graph_edge_make(size : Int32) -> ChemmolreprgraphEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolreprgraphEdge::len(self : ChemmolreprgraphEdge) -> Int32 {
  self.size
}

///|
pub fn ChemmolreprgraphEdge::get(
  self : ChemmolreprgraphEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolreprgraphEdge::set(
  self : ChemmolreprgraphEdge,
  i : Int32,
  v : Double,
) -> ChemmolreprgraphEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphEdge::sum(self : ChemmolreprgraphEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolreprgraphEdge::mean(self : ChemmolreprgraphEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolreprgraphEdge::scale(
  self : ChemmolreprgraphEdge,
  f : Double,
) -> ChemmolreprgraphEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphEdge::add(
  self : ChemmolreprgraphEdge,
  other : ChemmolreprgraphEdge,
) -> ChemmolreprgraphEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphEdge::copy(
  self : ChemmolreprgraphEdge,
) -> ChemmolreprgraphEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphEdge::fill(
  self : ChemmolreprgraphEdge,
  v : Double,
) -> ChemmolreprgraphEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphEdge::min(self : ChemmolreprgraphEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolreprgraphEdge::max(self : ChemmolreprgraphEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolreprgraphEdge::to_string(self : ChemmolreprgraphEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolreprgraphPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_graph_path_make(size : Int32) -> ChemmolreprgraphPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolreprgraphPath::len(self : ChemmolreprgraphPath) -> Int32 {
  self.size
}

///|
pub fn ChemmolreprgraphPath::get(
  self : ChemmolreprgraphPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolreprgraphPath::set(
  self : ChemmolreprgraphPath,
  i : Int32,
  v : Double,
) -> ChemmolreprgraphPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphPath::sum(self : ChemmolreprgraphPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolreprgraphPath::mean(self : ChemmolreprgraphPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolreprgraphPath::scale(
  self : ChemmolreprgraphPath,
  f : Double,
) -> ChemmolreprgraphPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphPath::add(
  self : ChemmolreprgraphPath,
  other : ChemmolreprgraphPath,
) -> ChemmolreprgraphPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphPath::copy(
  self : ChemmolreprgraphPath,
) -> ChemmolreprgraphPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphPath::fill(
  self : ChemmolreprgraphPath,
  v : Double,
) -> ChemmolreprgraphPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphPath::min(self : ChemmolreprgraphPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolreprgraphPath::max(self : ChemmolreprgraphPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolreprgraphPath::to_string(self : ChemmolreprgraphPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolreprgraphCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_graph_cluster_make(
  size : Int32,
) -> ChemmolreprgraphCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolreprgraphCluster::len(self : ChemmolreprgraphCluster) -> Int32 {
  self.size
}

///|
pub fn ChemmolreprgraphCluster::get(
  self : ChemmolreprgraphCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolreprgraphCluster::set(
  self : ChemmolreprgraphCluster,
  i : Int32,
  v : Double,
) -> ChemmolreprgraphCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphCluster::sum(self : ChemmolreprgraphCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolreprgraphCluster::mean(self : ChemmolreprgraphCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolreprgraphCluster::scale(
  self : ChemmolreprgraphCluster,
  f : Double,
) -> ChemmolreprgraphCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphCluster::add(
  self : ChemmolreprgraphCluster,
  other : ChemmolreprgraphCluster,
) -> ChemmolreprgraphCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphCluster::copy(
  self : ChemmolreprgraphCluster,
) -> ChemmolreprgraphCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphCluster::fill(
  self : ChemmolreprgraphCluster,
  v : Double,
) -> ChemmolreprgraphCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphCluster::min(self : ChemmolreprgraphCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolreprgraphCluster::max(self : ChemmolreprgraphCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolreprgraphCluster::to_string(
  self : ChemmolreprgraphCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolreprgraphModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_graph_model_make(size : Int32) -> ChemmolreprgraphModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolreprgraphModel::len(self : ChemmolreprgraphModel) -> Int32 {
  self.size
}

///|
pub fn ChemmolreprgraphModel::get(
  self : ChemmolreprgraphModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolreprgraphModel::set(
  self : ChemmolreprgraphModel,
  i : Int32,
  v : Double,
) -> ChemmolreprgraphModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphModel::sum(self : ChemmolreprgraphModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolreprgraphModel::mean(self : ChemmolreprgraphModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolreprgraphModel::scale(
  self : ChemmolreprgraphModel,
  f : Double,
) -> ChemmolreprgraphModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphModel::add(
  self : ChemmolreprgraphModel,
  other : ChemmolreprgraphModel,
) -> ChemmolreprgraphModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphModel::copy(
  self : ChemmolreprgraphModel,
) -> ChemmolreprgraphModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphModel::fill(
  self : ChemmolreprgraphModel,
  v : Double,
) -> ChemmolreprgraphModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphModel::min(self : ChemmolreprgraphModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolreprgraphModel::max(self : ChemmolreprgraphModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolreprgraphModel::to_string(self : ChemmolreprgraphModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolreprgraphLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_graph_layer_make(size : Int32) -> ChemmolreprgraphLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolreprgraphLayer::len(self : ChemmolreprgraphLayer) -> Int32 {
  self.size
}

///|
pub fn ChemmolreprgraphLayer::get(
  self : ChemmolreprgraphLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolreprgraphLayer::set(
  self : ChemmolreprgraphLayer,
  i : Int32,
  v : Double,
) -> ChemmolreprgraphLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphLayer::sum(self : ChemmolreprgraphLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolreprgraphLayer::mean(self : ChemmolreprgraphLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolreprgraphLayer::scale(
  self : ChemmolreprgraphLayer,
  f : Double,
) -> ChemmolreprgraphLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphLayer::add(
  self : ChemmolreprgraphLayer,
  other : ChemmolreprgraphLayer,
) -> ChemmolreprgraphLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphLayer::copy(
  self : ChemmolreprgraphLayer,
) -> ChemmolreprgraphLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphLayer::fill(
  self : ChemmolreprgraphLayer,
  v : Double,
) -> ChemmolreprgraphLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphLayer::min(self : ChemmolreprgraphLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolreprgraphLayer::max(self : ChemmolreprgraphLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolreprgraphLayer::to_string(self : ChemmolreprgraphLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolreprgraphBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_graph_buffer_make(size : Int32) -> ChemmolreprgraphBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolreprgraphBuffer::len(self : ChemmolreprgraphBuffer) -> Int32 {
  self.size
}

///|
pub fn ChemmolreprgraphBuffer::get(
  self : ChemmolreprgraphBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolreprgraphBuffer::set(
  self : ChemmolreprgraphBuffer,
  i : Int32,
  v : Double,
) -> ChemmolreprgraphBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphBuffer::sum(self : ChemmolreprgraphBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolreprgraphBuffer::mean(self : ChemmolreprgraphBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolreprgraphBuffer::scale(
  self : ChemmolreprgraphBuffer,
  f : Double,
) -> ChemmolreprgraphBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphBuffer::add(
  self : ChemmolreprgraphBuffer,
  other : ChemmolreprgraphBuffer,
) -> ChemmolreprgraphBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphBuffer::copy(
  self : ChemmolreprgraphBuffer,
) -> ChemmolreprgraphBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphBuffer::fill(
  self : ChemmolreprgraphBuffer,
  v : Double,
) -> ChemmolreprgraphBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphBuffer::min(self : ChemmolreprgraphBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolreprgraphBuffer::max(self : ChemmolreprgraphBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolreprgraphBuffer::to_string(
  self : ChemmolreprgraphBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolreprgraphCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_graph_cursor_make(size : Int32) -> ChemmolreprgraphCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolreprgraphCursor::len(self : ChemmolreprgraphCursor) -> Int32 {
  self.size
}

///|
pub fn ChemmolreprgraphCursor::get(
  self : ChemmolreprgraphCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolreprgraphCursor::set(
  self : ChemmolreprgraphCursor,
  i : Int32,
  v : Double,
) -> ChemmolreprgraphCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphCursor::sum(self : ChemmolreprgraphCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolreprgraphCursor::mean(self : ChemmolreprgraphCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolreprgraphCursor::scale(
  self : ChemmolreprgraphCursor,
  f : Double,
) -> ChemmolreprgraphCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphCursor::add(
  self : ChemmolreprgraphCursor,
  other : ChemmolreprgraphCursor,
) -> ChemmolreprgraphCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphCursor::copy(
  self : ChemmolreprgraphCursor,
) -> ChemmolreprgraphCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphCursor::fill(
  self : ChemmolreprgraphCursor,
  v : Double,
) -> ChemmolreprgraphCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphCursor::min(self : ChemmolreprgraphCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolreprgraphCursor::max(self : ChemmolreprgraphCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolreprgraphCursor::to_string(
  self : ChemmolreprgraphCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolreprgraphView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_graph_view_make(size : Int32) -> ChemmolreprgraphView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolreprgraphView::len(self : ChemmolreprgraphView) -> Int32 {
  self.size
}

///|
pub fn ChemmolreprgraphView::get(
  self : ChemmolreprgraphView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolreprgraphView::set(
  self : ChemmolreprgraphView,
  i : Int32,
  v : Double,
) -> ChemmolreprgraphView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphView::sum(self : ChemmolreprgraphView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolreprgraphView::mean(self : ChemmolreprgraphView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolreprgraphView::scale(
  self : ChemmolreprgraphView,
  f : Double,
) -> ChemmolreprgraphView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphView::add(
  self : ChemmolreprgraphView,
  other : ChemmolreprgraphView,
) -> ChemmolreprgraphView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphView::copy(
  self : ChemmolreprgraphView,
) -> ChemmolreprgraphView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphView::fill(
  self : ChemmolreprgraphView,
  v : Double,
) -> ChemmolreprgraphView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphView::min(self : ChemmolreprgraphView) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolreprgraphView::max(self : ChemmolreprgraphView) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolreprgraphView::to_string(self : ChemmolreprgraphView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolreprgraphRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_graph_range_make(size : Int32) -> ChemmolreprgraphRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolreprgraphRange::len(self : ChemmolreprgraphRange) -> Int32 {
  self.size
}

///|
pub fn ChemmolreprgraphRange::get(
  self : ChemmolreprgraphRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolreprgraphRange::set(
  self : ChemmolreprgraphRange,
  i : Int32,
  v : Double,
) -> ChemmolreprgraphRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphRange::sum(self : ChemmolreprgraphRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolreprgraphRange::mean(self : ChemmolreprgraphRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolreprgraphRange::scale(
  self : ChemmolreprgraphRange,
  f : Double,
) -> ChemmolreprgraphRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphRange::add(
  self : ChemmolreprgraphRange,
  other : ChemmolreprgraphRange,
) -> ChemmolreprgraphRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphRange::copy(
  self : ChemmolreprgraphRange,
) -> ChemmolreprgraphRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphRange::fill(
  self : ChemmolreprgraphRange,
  v : Double,
) -> ChemmolreprgraphRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphRange::min(self : ChemmolreprgraphRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolreprgraphRange::max(self : ChemmolreprgraphRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolreprgraphRange::to_string(self : ChemmolreprgraphRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemmolreprgraphSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_mol_repr_graph_slice_make(size : Int32) -> ChemmolreprgraphSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemmolreprgraphSlice::len(self : ChemmolreprgraphSlice) -> Int32 {
  self.size
}

///|
pub fn ChemmolreprgraphSlice::get(
  self : ChemmolreprgraphSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemmolreprgraphSlice::set(
  self : ChemmolreprgraphSlice,
  i : Int32,
  v : Double,
) -> ChemmolreprgraphSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphSlice::sum(self : ChemmolreprgraphSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemmolreprgraphSlice::mean(self : ChemmolreprgraphSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemmolreprgraphSlice::scale(
  self : ChemmolreprgraphSlice,
  f : Double,
) -> ChemmolreprgraphSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphSlice::add(
  self : ChemmolreprgraphSlice,
  other : ChemmolreprgraphSlice,
) -> ChemmolreprgraphSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphSlice::copy(
  self : ChemmolreprgraphSlice,
) -> ChemmolreprgraphSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphSlice::fill(
  self : ChemmolreprgraphSlice,
  v : Double,
) -> ChemmolreprgraphSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemmolreprgraphSlice::min(self : ChemmolreprgraphSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemmolreprgraphSlice::max(self : ChemmolreprgraphSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemmolreprgraphSlice::to_string(self : ChemmolreprgraphSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
