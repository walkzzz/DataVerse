///|
///===
/// extcore/bio_struct_motif
pub(all) struct BiostructmotifPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn bio_struct_motif_make_point(
  x : Double,
  y : Double,
) -> BiostructmotifPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn bio_struct_motif_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> BiostructmotifPoint {
  { x, y, z, label: 0, }
}

///|
pub fn BiostructmotifPoint::x(self : BiostructmotifPoint) -> Double {
  self.x
}

///|
pub fn BiostructmotifPoint::y(self : BiostructmotifPoint) -> Double {
  self.y
}

///|
pub fn BiostructmotifPoint::z(self : BiostructmotifPoint) -> Double {
  self.z
}

///|
pub fn BiostructmotifPoint::label(self : BiostructmotifPoint) -> Int32 {
  self.label
}

///|
pub fn BiostructmotifPoint::dist(
  self : BiostructmotifPoint,
  other : BiostructmotifPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn BiostructmotifPoint::add(
  self : BiostructmotifPoint,
  other : BiostructmotifPoint,
) -> BiostructmotifPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn BiostructmotifPoint::sub(
  self : BiostructmotifPoint,
  other : BiostructmotifPoint,
) -> BiostructmotifPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn BiostructmotifPoint::scale(
  self : BiostructmotifPoint,
  s : Double,
) -> BiostructmotifPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn BiostructmotifPoint::dot(
  self : BiostructmotifPoint,
  other : BiostructmotifPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn BiostructmotifPoint::cross(
  self : BiostructmotifPoint,
  other : BiostructmotifPoint,
) -> BiostructmotifPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn BiostructmotifPoint::norm(self : BiostructmotifPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn BiostructmotifPoint::normalize(
  self : BiostructmotifPoint,
) -> BiostructmotifPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn BiostructmotifPoint::negate(
  self : BiostructmotifPoint,
) -> BiostructmotifPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn BiostructmotifPoint::mid(
  self : BiostructmotifPoint,
  other : BiostructmotifPoint,
) -> BiostructmotifPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn BiostructmotifPoint::lerp(
  self : BiostructmotifPoint,
  other : BiostructmotifPoint,
  t : Double,
) -> BiostructmotifPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn BiostructmotifPoint::to_string(self : BiostructmotifPoint) -> String {
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
pub(all) struct BiostructmotifSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn bio_struct_motif_make_series(
  vals : Array[Double],
  name : String,
) -> BiostructmotifSeries {
  { vals, name, meta: 0, }
}

///|
pub fn BiostructmotifSeries::len(self : BiostructmotifSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn BiostructmotifSeries::sum(self : BiostructmotifSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn BiostructmotifSeries::mean(self : BiostructmotifSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn BiostructmotifSeries::min(self : BiostructmotifSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn BiostructmotifSeries::max(self : BiostructmotifSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn BiostructmotifSeries::range(self : BiostructmotifSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn BiostructmotifSeries::variance(self : BiostructmotifSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn BiostructmotifSeries::std(self : BiostructmotifSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn BiostructmotifSeries::median(self : BiostructmotifSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn BiostructmotifSeries::scale(
  self : BiostructmotifSeries,
  f : Double,
) -> BiostructmotifSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn BiostructmotifSeries::add(
  self : BiostructmotifSeries,
  other : BiostructmotifSeries,
) -> BiostructmotifSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn BiostructmotifSeries::sub(
  self : BiostructmotifSeries,
  other : BiostructmotifSeries,
) -> BiostructmotifSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn BiostructmotifSeries::normalize(
  self : BiostructmotifSeries,
) -> BiostructmotifSeries {
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
pub fn BiostructmotifSeries::cumsum(
  self : BiostructmotifSeries,
) -> BiostructmotifSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn BiostructmotifSeries::to_string(self : BiostructmotifSeries) -> String {
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
pub(all) struct BiostructmotifMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn bio_struct_motif_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> BiostructmotifMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn bio_struct_motif_matrix_identity(n : Int32) -> BiostructmotifMatrix {
  let m = bio_struct_motif_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn BiostructmotifMatrix::get(
  self : BiostructmotifMatrix,
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
pub fn BiostructmotifMatrix::transpose(
  self : BiostructmotifMatrix,
) -> BiostructmotifMatrix {
  let result = bio_struct_motif_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn BiostructmotifMatrix::add(
  self : BiostructmotifMatrix,
  other : BiostructmotifMatrix,
) -> BiostructmotifMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = bio_struct_motif_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn BiostructmotifMatrix::scale(
  self : BiostructmotifMatrix,
  s : Double,
) -> BiostructmotifMatrix {
  let result = bio_struct_motif_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn BiostructmotifMatrix::multiply(
  self : BiostructmotifMatrix,
  other : BiostructmotifMatrix,
) -> BiostructmotifMatrix {
  if self.cols != other.rows {
    return bio_struct_motif_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = bio_struct_motif_make_matrix(self.rows, other.cols, 0.0)
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
pub fn BiostructmotifMatrix::trace(self : BiostructmotifMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn BiostructmotifMatrix::det(self : BiostructmotifMatrix) -> Double {
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
pub fn BiostructmotifMatrix::norm(self : BiostructmotifMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn BiostructmotifMatrix::to_string(self : BiostructmotifMatrix) -> String {
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
pub(all) struct BiostructmotifVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn bio_struct_motif_make_vector(
  comps : Array[Double],
) -> BiostructmotifVector {
  { comps, dim: comps.length(), }
}

///|
pub fn bio_struct_motif_vector_zero(dim : Int32) -> BiostructmotifVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn BiostructmotifVector::add(
  self : BiostructmotifVector,
  other : BiostructmotifVector,
) -> BiostructmotifVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn BiostructmotifVector::sub(
  self : BiostructmotifVector,
  other : BiostructmotifVector,
) -> BiostructmotifVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn BiostructmotifVector::scale(
  self : BiostructmotifVector,
  s : Double,
) -> BiostructmotifVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn BiostructmotifVector::dot(
  self : BiostructmotifVector,
  other : BiostructmotifVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn BiostructmotifVector::norm(self : BiostructmotifVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn BiostructmotifVector::normalize(
  self : BiostructmotifVector,
) -> BiostructmotifVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn BiostructmotifVector::dist(
  self : BiostructmotifVector,
  other : BiostructmotifVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn BiostructmotifVector::to_string(self : BiostructmotifVector) -> String {
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
pub(all) struct BiostructmotifFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_struct_motif_frame_make(size : Int32) -> BiostructmotifFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiostructmotifFrame::len(self : BiostructmotifFrame) -> Int32 {
  self.size
}

///|
pub fn BiostructmotifFrame::get(
  self : BiostructmotifFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiostructmotifFrame::set(
  self : BiostructmotifFrame,
  i : Int32,
  v : Double,
) -> BiostructmotifFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifFrame::sum(self : BiostructmotifFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiostructmotifFrame::mean(self : BiostructmotifFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiostructmotifFrame::scale(
  self : BiostructmotifFrame,
  f : Double,
) -> BiostructmotifFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifFrame::add(
  self : BiostructmotifFrame,
  other : BiostructmotifFrame,
) -> BiostructmotifFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiostructmotifFrame::copy(
  self : BiostructmotifFrame,
) -> BiostructmotifFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifFrame::fill(
  self : BiostructmotifFrame,
  v : Double,
) -> BiostructmotifFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifFrame::min(self : BiostructmotifFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiostructmotifFrame::max(self : BiostructmotifFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiostructmotifFrame::to_string(self : BiostructmotifFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiostructmotifTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_struct_motif_table_make(size : Int32) -> BiostructmotifTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiostructmotifTable::len(self : BiostructmotifTable) -> Int32 {
  self.size
}

///|
pub fn BiostructmotifTable::get(
  self : BiostructmotifTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiostructmotifTable::set(
  self : BiostructmotifTable,
  i : Int32,
  v : Double,
) -> BiostructmotifTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifTable::sum(self : BiostructmotifTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiostructmotifTable::mean(self : BiostructmotifTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiostructmotifTable::scale(
  self : BiostructmotifTable,
  f : Double,
) -> BiostructmotifTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifTable::add(
  self : BiostructmotifTable,
  other : BiostructmotifTable,
) -> BiostructmotifTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiostructmotifTable::copy(
  self : BiostructmotifTable,
) -> BiostructmotifTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifTable::fill(
  self : BiostructmotifTable,
  v : Double,
) -> BiostructmotifTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifTable::min(self : BiostructmotifTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiostructmotifTable::max(self : BiostructmotifTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiostructmotifTable::to_string(self : BiostructmotifTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiostructmotifGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_struct_motif_graphn_make(size : Int32) -> BiostructmotifGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiostructmotifGraphN::len(self : BiostructmotifGraphN) -> Int32 {
  self.size
}

///|
pub fn BiostructmotifGraphN::get(
  self : BiostructmotifGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiostructmotifGraphN::set(
  self : BiostructmotifGraphN,
  i : Int32,
  v : Double,
) -> BiostructmotifGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifGraphN::sum(self : BiostructmotifGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiostructmotifGraphN::mean(self : BiostructmotifGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiostructmotifGraphN::scale(
  self : BiostructmotifGraphN,
  f : Double,
) -> BiostructmotifGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifGraphN::add(
  self : BiostructmotifGraphN,
  other : BiostructmotifGraphN,
) -> BiostructmotifGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiostructmotifGraphN::copy(
  self : BiostructmotifGraphN,
) -> BiostructmotifGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifGraphN::fill(
  self : BiostructmotifGraphN,
  v : Double,
) -> BiostructmotifGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifGraphN::min(self : BiostructmotifGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiostructmotifGraphN::max(self : BiostructmotifGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiostructmotifGraphN::to_string(self : BiostructmotifGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiostructmotifNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_struct_motif_node_make(size : Int32) -> BiostructmotifNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiostructmotifNode::len(self : BiostructmotifNode) -> Int32 {
  self.size
}

///|
pub fn BiostructmotifNode::get(self : BiostructmotifNode, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiostructmotifNode::set(
  self : BiostructmotifNode,
  i : Int32,
  v : Double,
) -> BiostructmotifNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifNode::sum(self : BiostructmotifNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiostructmotifNode::mean(self : BiostructmotifNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiostructmotifNode::scale(
  self : BiostructmotifNode,
  f : Double,
) -> BiostructmotifNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifNode::add(
  self : BiostructmotifNode,
  other : BiostructmotifNode,
) -> BiostructmotifNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiostructmotifNode::copy(
  self : BiostructmotifNode,
) -> BiostructmotifNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifNode::fill(
  self : BiostructmotifNode,
  v : Double,
) -> BiostructmotifNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifNode::min(self : BiostructmotifNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiostructmotifNode::max(self : BiostructmotifNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiostructmotifNode::to_string(self : BiostructmotifNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiostructmotifEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_struct_motif_edge_make(size : Int32) -> BiostructmotifEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiostructmotifEdge::len(self : BiostructmotifEdge) -> Int32 {
  self.size
}

///|
pub fn BiostructmotifEdge::get(self : BiostructmotifEdge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiostructmotifEdge::set(
  self : BiostructmotifEdge,
  i : Int32,
  v : Double,
) -> BiostructmotifEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifEdge::sum(self : BiostructmotifEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiostructmotifEdge::mean(self : BiostructmotifEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiostructmotifEdge::scale(
  self : BiostructmotifEdge,
  f : Double,
) -> BiostructmotifEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifEdge::add(
  self : BiostructmotifEdge,
  other : BiostructmotifEdge,
) -> BiostructmotifEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiostructmotifEdge::copy(
  self : BiostructmotifEdge,
) -> BiostructmotifEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifEdge::fill(
  self : BiostructmotifEdge,
  v : Double,
) -> BiostructmotifEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifEdge::min(self : BiostructmotifEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiostructmotifEdge::max(self : BiostructmotifEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiostructmotifEdge::to_string(self : BiostructmotifEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiostructmotifPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_struct_motif_path_make(size : Int32) -> BiostructmotifPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiostructmotifPath::len(self : BiostructmotifPath) -> Int32 {
  self.size
}

///|
pub fn BiostructmotifPath::get(self : BiostructmotifPath, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiostructmotifPath::set(
  self : BiostructmotifPath,
  i : Int32,
  v : Double,
) -> BiostructmotifPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifPath::sum(self : BiostructmotifPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiostructmotifPath::mean(self : BiostructmotifPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiostructmotifPath::scale(
  self : BiostructmotifPath,
  f : Double,
) -> BiostructmotifPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifPath::add(
  self : BiostructmotifPath,
  other : BiostructmotifPath,
) -> BiostructmotifPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiostructmotifPath::copy(
  self : BiostructmotifPath,
) -> BiostructmotifPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifPath::fill(
  self : BiostructmotifPath,
  v : Double,
) -> BiostructmotifPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifPath::min(self : BiostructmotifPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiostructmotifPath::max(self : BiostructmotifPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiostructmotifPath::to_string(self : BiostructmotifPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiostructmotifCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_struct_motif_cluster_make(size : Int32) -> BiostructmotifCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiostructmotifCluster::len(self : BiostructmotifCluster) -> Int32 {
  self.size
}

///|
pub fn BiostructmotifCluster::get(
  self : BiostructmotifCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiostructmotifCluster::set(
  self : BiostructmotifCluster,
  i : Int32,
  v : Double,
) -> BiostructmotifCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifCluster::sum(self : BiostructmotifCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiostructmotifCluster::mean(self : BiostructmotifCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiostructmotifCluster::scale(
  self : BiostructmotifCluster,
  f : Double,
) -> BiostructmotifCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifCluster::add(
  self : BiostructmotifCluster,
  other : BiostructmotifCluster,
) -> BiostructmotifCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiostructmotifCluster::copy(
  self : BiostructmotifCluster,
) -> BiostructmotifCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifCluster::fill(
  self : BiostructmotifCluster,
  v : Double,
) -> BiostructmotifCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifCluster::min(self : BiostructmotifCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiostructmotifCluster::max(self : BiostructmotifCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiostructmotifCluster::to_string(self : BiostructmotifCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiostructmotifModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_struct_motif_model_make(size : Int32) -> BiostructmotifModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiostructmotifModel::len(self : BiostructmotifModel) -> Int32 {
  self.size
}

///|
pub fn BiostructmotifModel::get(
  self : BiostructmotifModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiostructmotifModel::set(
  self : BiostructmotifModel,
  i : Int32,
  v : Double,
) -> BiostructmotifModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifModel::sum(self : BiostructmotifModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiostructmotifModel::mean(self : BiostructmotifModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiostructmotifModel::scale(
  self : BiostructmotifModel,
  f : Double,
) -> BiostructmotifModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifModel::add(
  self : BiostructmotifModel,
  other : BiostructmotifModel,
) -> BiostructmotifModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiostructmotifModel::copy(
  self : BiostructmotifModel,
) -> BiostructmotifModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifModel::fill(
  self : BiostructmotifModel,
  v : Double,
) -> BiostructmotifModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifModel::min(self : BiostructmotifModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiostructmotifModel::max(self : BiostructmotifModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiostructmotifModel::to_string(self : BiostructmotifModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiostructmotifLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_struct_motif_layer_make(size : Int32) -> BiostructmotifLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiostructmotifLayer::len(self : BiostructmotifLayer) -> Int32 {
  self.size
}

///|
pub fn BiostructmotifLayer::get(
  self : BiostructmotifLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiostructmotifLayer::set(
  self : BiostructmotifLayer,
  i : Int32,
  v : Double,
) -> BiostructmotifLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifLayer::sum(self : BiostructmotifLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiostructmotifLayer::mean(self : BiostructmotifLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiostructmotifLayer::scale(
  self : BiostructmotifLayer,
  f : Double,
) -> BiostructmotifLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifLayer::add(
  self : BiostructmotifLayer,
  other : BiostructmotifLayer,
) -> BiostructmotifLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiostructmotifLayer::copy(
  self : BiostructmotifLayer,
) -> BiostructmotifLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifLayer::fill(
  self : BiostructmotifLayer,
  v : Double,
) -> BiostructmotifLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifLayer::min(self : BiostructmotifLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiostructmotifLayer::max(self : BiostructmotifLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiostructmotifLayer::to_string(self : BiostructmotifLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiostructmotifBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_struct_motif_buffer_make(size : Int32) -> BiostructmotifBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiostructmotifBuffer::len(self : BiostructmotifBuffer) -> Int32 {
  self.size
}

///|
pub fn BiostructmotifBuffer::get(
  self : BiostructmotifBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiostructmotifBuffer::set(
  self : BiostructmotifBuffer,
  i : Int32,
  v : Double,
) -> BiostructmotifBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifBuffer::sum(self : BiostructmotifBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiostructmotifBuffer::mean(self : BiostructmotifBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiostructmotifBuffer::scale(
  self : BiostructmotifBuffer,
  f : Double,
) -> BiostructmotifBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifBuffer::add(
  self : BiostructmotifBuffer,
  other : BiostructmotifBuffer,
) -> BiostructmotifBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiostructmotifBuffer::copy(
  self : BiostructmotifBuffer,
) -> BiostructmotifBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifBuffer::fill(
  self : BiostructmotifBuffer,
  v : Double,
) -> BiostructmotifBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifBuffer::min(self : BiostructmotifBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiostructmotifBuffer::max(self : BiostructmotifBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiostructmotifBuffer::to_string(self : BiostructmotifBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiostructmotifCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_struct_motif_cursor_make(size : Int32) -> BiostructmotifCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiostructmotifCursor::len(self : BiostructmotifCursor) -> Int32 {
  self.size
}

///|
pub fn BiostructmotifCursor::get(
  self : BiostructmotifCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiostructmotifCursor::set(
  self : BiostructmotifCursor,
  i : Int32,
  v : Double,
) -> BiostructmotifCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifCursor::sum(self : BiostructmotifCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiostructmotifCursor::mean(self : BiostructmotifCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiostructmotifCursor::scale(
  self : BiostructmotifCursor,
  f : Double,
) -> BiostructmotifCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifCursor::add(
  self : BiostructmotifCursor,
  other : BiostructmotifCursor,
) -> BiostructmotifCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiostructmotifCursor::copy(
  self : BiostructmotifCursor,
) -> BiostructmotifCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifCursor::fill(
  self : BiostructmotifCursor,
  v : Double,
) -> BiostructmotifCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifCursor::min(self : BiostructmotifCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiostructmotifCursor::max(self : BiostructmotifCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiostructmotifCursor::to_string(self : BiostructmotifCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiostructmotifView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_struct_motif_view_make(size : Int32) -> BiostructmotifView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiostructmotifView::len(self : BiostructmotifView) -> Int32 {
  self.size
}

///|
pub fn BiostructmotifView::get(self : BiostructmotifView, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiostructmotifView::set(
  self : BiostructmotifView,
  i : Int32,
  v : Double,
) -> BiostructmotifView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifView::sum(self : BiostructmotifView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiostructmotifView::mean(self : BiostructmotifView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiostructmotifView::scale(
  self : BiostructmotifView,
  f : Double,
) -> BiostructmotifView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifView::add(
  self : BiostructmotifView,
  other : BiostructmotifView,
) -> BiostructmotifView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiostructmotifView::copy(
  self : BiostructmotifView,
) -> BiostructmotifView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifView::fill(
  self : BiostructmotifView,
  v : Double,
) -> BiostructmotifView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifView::min(self : BiostructmotifView) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiostructmotifView::max(self : BiostructmotifView) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiostructmotifView::to_string(self : BiostructmotifView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiostructmotifRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_struct_motif_range_make(size : Int32) -> BiostructmotifRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiostructmotifRange::len(self : BiostructmotifRange) -> Int32 {
  self.size
}

///|
pub fn BiostructmotifRange::get(
  self : BiostructmotifRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiostructmotifRange::set(
  self : BiostructmotifRange,
  i : Int32,
  v : Double,
) -> BiostructmotifRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifRange::sum(self : BiostructmotifRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiostructmotifRange::mean(self : BiostructmotifRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiostructmotifRange::scale(
  self : BiostructmotifRange,
  f : Double,
) -> BiostructmotifRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifRange::add(
  self : BiostructmotifRange,
  other : BiostructmotifRange,
) -> BiostructmotifRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiostructmotifRange::copy(
  self : BiostructmotifRange,
) -> BiostructmotifRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifRange::fill(
  self : BiostructmotifRange,
  v : Double,
) -> BiostructmotifRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifRange::min(self : BiostructmotifRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiostructmotifRange::max(self : BiostructmotifRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiostructmotifRange::to_string(self : BiostructmotifRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiostructmotifSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_struct_motif_slice_make(size : Int32) -> BiostructmotifSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiostructmotifSlice::len(self : BiostructmotifSlice) -> Int32 {
  self.size
}

///|
pub fn BiostructmotifSlice::get(
  self : BiostructmotifSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiostructmotifSlice::set(
  self : BiostructmotifSlice,
  i : Int32,
  v : Double,
) -> BiostructmotifSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifSlice::sum(self : BiostructmotifSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiostructmotifSlice::mean(self : BiostructmotifSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiostructmotifSlice::scale(
  self : BiostructmotifSlice,
  f : Double,
) -> BiostructmotifSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifSlice::add(
  self : BiostructmotifSlice,
  other : BiostructmotifSlice,
) -> BiostructmotifSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiostructmotifSlice::copy(
  self : BiostructmotifSlice,
) -> BiostructmotifSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifSlice::fill(
  self : BiostructmotifSlice,
  v : Double,
) -> BiostructmotifSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructmotifSlice::min(self : BiostructmotifSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiostructmotifSlice::max(self : BiostructmotifSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiostructmotifSlice::to_string(self : BiostructmotifSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
