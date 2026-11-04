///|
///===
/// extcore/chem_desc_hybrid
pub(all) struct ChemdeschybridPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn chem_desc_hybrid_make_point(
  x : Double,
  y : Double,
) -> ChemdeschybridPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn chem_desc_hybrid_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> ChemdeschybridPoint {
  { x, y, z, label: 0, }
}

///|
pub fn ChemdeschybridPoint::x(self : ChemdeschybridPoint) -> Double {
  self.x
}

///|
pub fn ChemdeschybridPoint::y(self : ChemdeschybridPoint) -> Double {
  self.y
}

///|
pub fn ChemdeschybridPoint::z(self : ChemdeschybridPoint) -> Double {
  self.z
}

///|
pub fn ChemdeschybridPoint::label(self : ChemdeschybridPoint) -> Int32 {
  self.label
}

///|
pub fn ChemdeschybridPoint::dist(
  self : ChemdeschybridPoint,
  other : ChemdeschybridPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn ChemdeschybridPoint::add(
  self : ChemdeschybridPoint,
  other : ChemdeschybridPoint,
) -> ChemdeschybridPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn ChemdeschybridPoint::sub(
  self : ChemdeschybridPoint,
  other : ChemdeschybridPoint,
) -> ChemdeschybridPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn ChemdeschybridPoint::scale(
  self : ChemdeschybridPoint,
  s : Double,
) -> ChemdeschybridPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn ChemdeschybridPoint::dot(
  self : ChemdeschybridPoint,
  other : ChemdeschybridPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn ChemdeschybridPoint::cross(
  self : ChemdeschybridPoint,
  other : ChemdeschybridPoint,
) -> ChemdeschybridPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn ChemdeschybridPoint::norm(self : ChemdeschybridPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn ChemdeschybridPoint::normalize(
  self : ChemdeschybridPoint,
) -> ChemdeschybridPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn ChemdeschybridPoint::negate(
  self : ChemdeschybridPoint,
) -> ChemdeschybridPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn ChemdeschybridPoint::mid(
  self : ChemdeschybridPoint,
  other : ChemdeschybridPoint,
) -> ChemdeschybridPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn ChemdeschybridPoint::lerp(
  self : ChemdeschybridPoint,
  other : ChemdeschybridPoint,
  t : Double,
) -> ChemdeschybridPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn ChemdeschybridPoint::to_string(self : ChemdeschybridPoint) -> String {
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
pub(all) struct ChemdeschybridSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn chem_desc_hybrid_make_series(
  vals : Array[Double],
  name : String,
) -> ChemdeschybridSeries {
  { vals, name, meta: 0, }
}

///|
pub fn ChemdeschybridSeries::len(self : ChemdeschybridSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn ChemdeschybridSeries::sum(self : ChemdeschybridSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn ChemdeschybridSeries::mean(self : ChemdeschybridSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn ChemdeschybridSeries::min(self : ChemdeschybridSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn ChemdeschybridSeries::max(self : ChemdeschybridSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn ChemdeschybridSeries::range(self : ChemdeschybridSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn ChemdeschybridSeries::variance(self : ChemdeschybridSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn ChemdeschybridSeries::std(self : ChemdeschybridSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn ChemdeschybridSeries::median(self : ChemdeschybridSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn ChemdeschybridSeries::scale(
  self : ChemdeschybridSeries,
  f : Double,
) -> ChemdeschybridSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn ChemdeschybridSeries::add(
  self : ChemdeschybridSeries,
  other : ChemdeschybridSeries,
) -> ChemdeschybridSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn ChemdeschybridSeries::sub(
  self : ChemdeschybridSeries,
  other : ChemdeschybridSeries,
) -> ChemdeschybridSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn ChemdeschybridSeries::normalize(
  self : ChemdeschybridSeries,
) -> ChemdeschybridSeries {
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
pub fn ChemdeschybridSeries::cumsum(
  self : ChemdeschybridSeries,
) -> ChemdeschybridSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn ChemdeschybridSeries::to_string(self : ChemdeschybridSeries) -> String {
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
pub(all) struct ChemdeschybridMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn chem_desc_hybrid_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> ChemdeschybridMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn chem_desc_hybrid_matrix_identity(n : Int32) -> ChemdeschybridMatrix {
  let m = chem_desc_hybrid_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn ChemdeschybridMatrix::get(
  self : ChemdeschybridMatrix,
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
pub fn ChemdeschybridMatrix::transpose(
  self : ChemdeschybridMatrix,
) -> ChemdeschybridMatrix {
  let result = chem_desc_hybrid_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn ChemdeschybridMatrix::add(
  self : ChemdeschybridMatrix,
  other : ChemdeschybridMatrix,
) -> ChemdeschybridMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = chem_desc_hybrid_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn ChemdeschybridMatrix::scale(
  self : ChemdeschybridMatrix,
  s : Double,
) -> ChemdeschybridMatrix {
  let result = chem_desc_hybrid_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn ChemdeschybridMatrix::multiply(
  self : ChemdeschybridMatrix,
  other : ChemdeschybridMatrix,
) -> ChemdeschybridMatrix {
  if self.cols != other.rows {
    return chem_desc_hybrid_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = chem_desc_hybrid_make_matrix(self.rows, other.cols, 0.0)
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
pub fn ChemdeschybridMatrix::trace(self : ChemdeschybridMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn ChemdeschybridMatrix::det(self : ChemdeschybridMatrix) -> Double {
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
pub fn ChemdeschybridMatrix::norm(self : ChemdeschybridMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn ChemdeschybridMatrix::to_string(self : ChemdeschybridMatrix) -> String {
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
pub(all) struct ChemdeschybridVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn chem_desc_hybrid_make_vector(
  comps : Array[Double],
) -> ChemdeschybridVector {
  { comps, dim: comps.length(), }
}

///|
pub fn chem_desc_hybrid_vector_zero(dim : Int32) -> ChemdeschybridVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn ChemdeschybridVector::add(
  self : ChemdeschybridVector,
  other : ChemdeschybridVector,
) -> ChemdeschybridVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn ChemdeschybridVector::sub(
  self : ChemdeschybridVector,
  other : ChemdeschybridVector,
) -> ChemdeschybridVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn ChemdeschybridVector::scale(
  self : ChemdeschybridVector,
  s : Double,
) -> ChemdeschybridVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn ChemdeschybridVector::dot(
  self : ChemdeschybridVector,
  other : ChemdeschybridVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn ChemdeschybridVector::norm(self : ChemdeschybridVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn ChemdeschybridVector::normalize(
  self : ChemdeschybridVector,
) -> ChemdeschybridVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn ChemdeschybridVector::dist(
  self : ChemdeschybridVector,
  other : ChemdeschybridVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn ChemdeschybridVector::to_string(self : ChemdeschybridVector) -> String {
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
pub(all) struct ChemdeschybridFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_desc_hybrid_frame_make(size : Int32) -> ChemdeschybridFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemdeschybridFrame::len(self : ChemdeschybridFrame) -> Int32 {
  self.size
}

///|
pub fn ChemdeschybridFrame::get(
  self : ChemdeschybridFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemdeschybridFrame::set(
  self : ChemdeschybridFrame,
  i : Int32,
  v : Double,
) -> ChemdeschybridFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridFrame::sum(self : ChemdeschybridFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemdeschybridFrame::mean(self : ChemdeschybridFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemdeschybridFrame::scale(
  self : ChemdeschybridFrame,
  f : Double,
) -> ChemdeschybridFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridFrame::add(
  self : ChemdeschybridFrame,
  other : ChemdeschybridFrame,
) -> ChemdeschybridFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemdeschybridFrame::copy(
  self : ChemdeschybridFrame,
) -> ChemdeschybridFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridFrame::fill(
  self : ChemdeschybridFrame,
  v : Double,
) -> ChemdeschybridFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridFrame::min(self : ChemdeschybridFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemdeschybridFrame::max(self : ChemdeschybridFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemdeschybridFrame::to_string(self : ChemdeschybridFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemdeschybridTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_desc_hybrid_table_make(size : Int32) -> ChemdeschybridTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemdeschybridTable::len(self : ChemdeschybridTable) -> Int32 {
  self.size
}

///|
pub fn ChemdeschybridTable::get(
  self : ChemdeschybridTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemdeschybridTable::set(
  self : ChemdeschybridTable,
  i : Int32,
  v : Double,
) -> ChemdeschybridTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridTable::sum(self : ChemdeschybridTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemdeschybridTable::mean(self : ChemdeschybridTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemdeschybridTable::scale(
  self : ChemdeschybridTable,
  f : Double,
) -> ChemdeschybridTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridTable::add(
  self : ChemdeschybridTable,
  other : ChemdeschybridTable,
) -> ChemdeschybridTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemdeschybridTable::copy(
  self : ChemdeschybridTable,
) -> ChemdeschybridTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridTable::fill(
  self : ChemdeschybridTable,
  v : Double,
) -> ChemdeschybridTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridTable::min(self : ChemdeschybridTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemdeschybridTable::max(self : ChemdeschybridTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemdeschybridTable::to_string(self : ChemdeschybridTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemdeschybridGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_desc_hybrid_graphn_make(size : Int32) -> ChemdeschybridGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemdeschybridGraphN::len(self : ChemdeschybridGraphN) -> Int32 {
  self.size
}

///|
pub fn ChemdeschybridGraphN::get(
  self : ChemdeschybridGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemdeschybridGraphN::set(
  self : ChemdeschybridGraphN,
  i : Int32,
  v : Double,
) -> ChemdeschybridGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridGraphN::sum(self : ChemdeschybridGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemdeschybridGraphN::mean(self : ChemdeschybridGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemdeschybridGraphN::scale(
  self : ChemdeschybridGraphN,
  f : Double,
) -> ChemdeschybridGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridGraphN::add(
  self : ChemdeschybridGraphN,
  other : ChemdeschybridGraphN,
) -> ChemdeschybridGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemdeschybridGraphN::copy(
  self : ChemdeschybridGraphN,
) -> ChemdeschybridGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridGraphN::fill(
  self : ChemdeschybridGraphN,
  v : Double,
) -> ChemdeschybridGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridGraphN::min(self : ChemdeschybridGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemdeschybridGraphN::max(self : ChemdeschybridGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemdeschybridGraphN::to_string(self : ChemdeschybridGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemdeschybridNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_desc_hybrid_node_make(size : Int32) -> ChemdeschybridNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemdeschybridNode::len(self : ChemdeschybridNode) -> Int32 {
  self.size
}

///|
pub fn ChemdeschybridNode::get(self : ChemdeschybridNode, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemdeschybridNode::set(
  self : ChemdeschybridNode,
  i : Int32,
  v : Double,
) -> ChemdeschybridNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridNode::sum(self : ChemdeschybridNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemdeschybridNode::mean(self : ChemdeschybridNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemdeschybridNode::scale(
  self : ChemdeschybridNode,
  f : Double,
) -> ChemdeschybridNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridNode::add(
  self : ChemdeschybridNode,
  other : ChemdeschybridNode,
) -> ChemdeschybridNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemdeschybridNode::copy(
  self : ChemdeschybridNode,
) -> ChemdeschybridNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridNode::fill(
  self : ChemdeschybridNode,
  v : Double,
) -> ChemdeschybridNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridNode::min(self : ChemdeschybridNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemdeschybridNode::max(self : ChemdeschybridNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemdeschybridNode::to_string(self : ChemdeschybridNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemdeschybridEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_desc_hybrid_edge_make(size : Int32) -> ChemdeschybridEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemdeschybridEdge::len(self : ChemdeschybridEdge) -> Int32 {
  self.size
}

///|
pub fn ChemdeschybridEdge::get(self : ChemdeschybridEdge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemdeschybridEdge::set(
  self : ChemdeschybridEdge,
  i : Int32,
  v : Double,
) -> ChemdeschybridEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridEdge::sum(self : ChemdeschybridEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemdeschybridEdge::mean(self : ChemdeschybridEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemdeschybridEdge::scale(
  self : ChemdeschybridEdge,
  f : Double,
) -> ChemdeschybridEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridEdge::add(
  self : ChemdeschybridEdge,
  other : ChemdeschybridEdge,
) -> ChemdeschybridEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemdeschybridEdge::copy(
  self : ChemdeschybridEdge,
) -> ChemdeschybridEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridEdge::fill(
  self : ChemdeschybridEdge,
  v : Double,
) -> ChemdeschybridEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridEdge::min(self : ChemdeschybridEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemdeschybridEdge::max(self : ChemdeschybridEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemdeschybridEdge::to_string(self : ChemdeschybridEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemdeschybridPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_desc_hybrid_path_make(size : Int32) -> ChemdeschybridPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemdeschybridPath::len(self : ChemdeschybridPath) -> Int32 {
  self.size
}

///|
pub fn ChemdeschybridPath::get(self : ChemdeschybridPath, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemdeschybridPath::set(
  self : ChemdeschybridPath,
  i : Int32,
  v : Double,
) -> ChemdeschybridPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridPath::sum(self : ChemdeschybridPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemdeschybridPath::mean(self : ChemdeschybridPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemdeschybridPath::scale(
  self : ChemdeschybridPath,
  f : Double,
) -> ChemdeschybridPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridPath::add(
  self : ChemdeschybridPath,
  other : ChemdeschybridPath,
) -> ChemdeschybridPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemdeschybridPath::copy(
  self : ChemdeschybridPath,
) -> ChemdeschybridPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridPath::fill(
  self : ChemdeschybridPath,
  v : Double,
) -> ChemdeschybridPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridPath::min(self : ChemdeschybridPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemdeschybridPath::max(self : ChemdeschybridPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemdeschybridPath::to_string(self : ChemdeschybridPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemdeschybridCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_desc_hybrid_cluster_make(size : Int32) -> ChemdeschybridCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemdeschybridCluster::len(self : ChemdeschybridCluster) -> Int32 {
  self.size
}

///|
pub fn ChemdeschybridCluster::get(
  self : ChemdeschybridCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemdeschybridCluster::set(
  self : ChemdeschybridCluster,
  i : Int32,
  v : Double,
) -> ChemdeschybridCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridCluster::sum(self : ChemdeschybridCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemdeschybridCluster::mean(self : ChemdeschybridCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemdeschybridCluster::scale(
  self : ChemdeschybridCluster,
  f : Double,
) -> ChemdeschybridCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridCluster::add(
  self : ChemdeschybridCluster,
  other : ChemdeschybridCluster,
) -> ChemdeschybridCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemdeschybridCluster::copy(
  self : ChemdeschybridCluster,
) -> ChemdeschybridCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridCluster::fill(
  self : ChemdeschybridCluster,
  v : Double,
) -> ChemdeschybridCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridCluster::min(self : ChemdeschybridCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemdeschybridCluster::max(self : ChemdeschybridCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemdeschybridCluster::to_string(self : ChemdeschybridCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemdeschybridModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_desc_hybrid_model_make(size : Int32) -> ChemdeschybridModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemdeschybridModel::len(self : ChemdeschybridModel) -> Int32 {
  self.size
}

///|
pub fn ChemdeschybridModel::get(
  self : ChemdeschybridModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemdeschybridModel::set(
  self : ChemdeschybridModel,
  i : Int32,
  v : Double,
) -> ChemdeschybridModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridModel::sum(self : ChemdeschybridModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemdeschybridModel::mean(self : ChemdeschybridModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemdeschybridModel::scale(
  self : ChemdeschybridModel,
  f : Double,
) -> ChemdeschybridModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridModel::add(
  self : ChemdeschybridModel,
  other : ChemdeschybridModel,
) -> ChemdeschybridModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemdeschybridModel::copy(
  self : ChemdeschybridModel,
) -> ChemdeschybridModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridModel::fill(
  self : ChemdeschybridModel,
  v : Double,
) -> ChemdeschybridModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridModel::min(self : ChemdeschybridModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemdeschybridModel::max(self : ChemdeschybridModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemdeschybridModel::to_string(self : ChemdeschybridModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemdeschybridLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_desc_hybrid_layer_make(size : Int32) -> ChemdeschybridLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemdeschybridLayer::len(self : ChemdeschybridLayer) -> Int32 {
  self.size
}

///|
pub fn ChemdeschybridLayer::get(
  self : ChemdeschybridLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemdeschybridLayer::set(
  self : ChemdeschybridLayer,
  i : Int32,
  v : Double,
) -> ChemdeschybridLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridLayer::sum(self : ChemdeschybridLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemdeschybridLayer::mean(self : ChemdeschybridLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemdeschybridLayer::scale(
  self : ChemdeschybridLayer,
  f : Double,
) -> ChemdeschybridLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridLayer::add(
  self : ChemdeschybridLayer,
  other : ChemdeschybridLayer,
) -> ChemdeschybridLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemdeschybridLayer::copy(
  self : ChemdeschybridLayer,
) -> ChemdeschybridLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridLayer::fill(
  self : ChemdeschybridLayer,
  v : Double,
) -> ChemdeschybridLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridLayer::min(self : ChemdeschybridLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemdeschybridLayer::max(self : ChemdeschybridLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemdeschybridLayer::to_string(self : ChemdeschybridLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemdeschybridBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_desc_hybrid_buffer_make(size : Int32) -> ChemdeschybridBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemdeschybridBuffer::len(self : ChemdeschybridBuffer) -> Int32 {
  self.size
}

///|
pub fn ChemdeschybridBuffer::get(
  self : ChemdeschybridBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemdeschybridBuffer::set(
  self : ChemdeschybridBuffer,
  i : Int32,
  v : Double,
) -> ChemdeschybridBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridBuffer::sum(self : ChemdeschybridBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemdeschybridBuffer::mean(self : ChemdeschybridBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemdeschybridBuffer::scale(
  self : ChemdeschybridBuffer,
  f : Double,
) -> ChemdeschybridBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridBuffer::add(
  self : ChemdeschybridBuffer,
  other : ChemdeschybridBuffer,
) -> ChemdeschybridBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemdeschybridBuffer::copy(
  self : ChemdeschybridBuffer,
) -> ChemdeschybridBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridBuffer::fill(
  self : ChemdeschybridBuffer,
  v : Double,
) -> ChemdeschybridBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridBuffer::min(self : ChemdeschybridBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemdeschybridBuffer::max(self : ChemdeschybridBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemdeschybridBuffer::to_string(self : ChemdeschybridBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemdeschybridCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_desc_hybrid_cursor_make(size : Int32) -> ChemdeschybridCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemdeschybridCursor::len(self : ChemdeschybridCursor) -> Int32 {
  self.size
}

///|
pub fn ChemdeschybridCursor::get(
  self : ChemdeschybridCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemdeschybridCursor::set(
  self : ChemdeschybridCursor,
  i : Int32,
  v : Double,
) -> ChemdeschybridCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridCursor::sum(self : ChemdeschybridCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemdeschybridCursor::mean(self : ChemdeschybridCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemdeschybridCursor::scale(
  self : ChemdeschybridCursor,
  f : Double,
) -> ChemdeschybridCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridCursor::add(
  self : ChemdeschybridCursor,
  other : ChemdeschybridCursor,
) -> ChemdeschybridCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemdeschybridCursor::copy(
  self : ChemdeschybridCursor,
) -> ChemdeschybridCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridCursor::fill(
  self : ChemdeschybridCursor,
  v : Double,
) -> ChemdeschybridCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridCursor::min(self : ChemdeschybridCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemdeschybridCursor::max(self : ChemdeschybridCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemdeschybridCursor::to_string(self : ChemdeschybridCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemdeschybridView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_desc_hybrid_view_make(size : Int32) -> ChemdeschybridView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemdeschybridView::len(self : ChemdeschybridView) -> Int32 {
  self.size
}

///|
pub fn ChemdeschybridView::get(self : ChemdeschybridView, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemdeschybridView::set(
  self : ChemdeschybridView,
  i : Int32,
  v : Double,
) -> ChemdeschybridView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridView::sum(self : ChemdeschybridView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemdeschybridView::mean(self : ChemdeschybridView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemdeschybridView::scale(
  self : ChemdeschybridView,
  f : Double,
) -> ChemdeschybridView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridView::add(
  self : ChemdeschybridView,
  other : ChemdeschybridView,
) -> ChemdeschybridView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemdeschybridView::copy(
  self : ChemdeschybridView,
) -> ChemdeschybridView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridView::fill(
  self : ChemdeschybridView,
  v : Double,
) -> ChemdeschybridView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridView::min(self : ChemdeschybridView) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemdeschybridView::max(self : ChemdeschybridView) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemdeschybridView::to_string(self : ChemdeschybridView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemdeschybridRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_desc_hybrid_range_make(size : Int32) -> ChemdeschybridRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemdeschybridRange::len(self : ChemdeschybridRange) -> Int32 {
  self.size
}

///|
pub fn ChemdeschybridRange::get(
  self : ChemdeschybridRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemdeschybridRange::set(
  self : ChemdeschybridRange,
  i : Int32,
  v : Double,
) -> ChemdeschybridRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridRange::sum(self : ChemdeschybridRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemdeschybridRange::mean(self : ChemdeschybridRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemdeschybridRange::scale(
  self : ChemdeschybridRange,
  f : Double,
) -> ChemdeschybridRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridRange::add(
  self : ChemdeschybridRange,
  other : ChemdeschybridRange,
) -> ChemdeschybridRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemdeschybridRange::copy(
  self : ChemdeschybridRange,
) -> ChemdeschybridRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridRange::fill(
  self : ChemdeschybridRange,
  v : Double,
) -> ChemdeschybridRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridRange::min(self : ChemdeschybridRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemdeschybridRange::max(self : ChemdeschybridRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemdeschybridRange::to_string(self : ChemdeschybridRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemdeschybridSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_desc_hybrid_slice_make(size : Int32) -> ChemdeschybridSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemdeschybridSlice::len(self : ChemdeschybridSlice) -> Int32 {
  self.size
}

///|
pub fn ChemdeschybridSlice::get(
  self : ChemdeschybridSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemdeschybridSlice::set(
  self : ChemdeschybridSlice,
  i : Int32,
  v : Double,
) -> ChemdeschybridSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridSlice::sum(self : ChemdeschybridSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemdeschybridSlice::mean(self : ChemdeschybridSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemdeschybridSlice::scale(
  self : ChemdeschybridSlice,
  f : Double,
) -> ChemdeschybridSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridSlice::add(
  self : ChemdeschybridSlice,
  other : ChemdeschybridSlice,
) -> ChemdeschybridSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemdeschybridSlice::copy(
  self : ChemdeschybridSlice,
) -> ChemdeschybridSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridSlice::fill(
  self : ChemdeschybridSlice,
  v : Double,
) -> ChemdeschybridSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemdeschybridSlice::min(self : ChemdeschybridSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemdeschybridSlice::max(self : ChemdeschybridSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemdeschybridSlice::to_string(self : ChemdeschybridSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
