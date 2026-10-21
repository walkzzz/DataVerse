///|
///===
/// extcore/bio_phylo_parsimony
pub(all) struct BiophyloparsimonyPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn bio_phylo_parsimony_make_point(
  x : Double,
  y : Double,
) -> BiophyloparsimonyPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn bio_phylo_parsimony_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> BiophyloparsimonyPoint {
  { x, y, z, label: 0, }
}

///|
pub fn BiophyloparsimonyPoint::x(self : BiophyloparsimonyPoint) -> Double {
  self.x
}

///|
pub fn BiophyloparsimonyPoint::y(self : BiophyloparsimonyPoint) -> Double {
  self.y
}

///|
pub fn BiophyloparsimonyPoint::z(self : BiophyloparsimonyPoint) -> Double {
  self.z
}

///|
pub fn BiophyloparsimonyPoint::label(self : BiophyloparsimonyPoint) -> Int32 {
  self.label
}

///|
pub fn BiophyloparsimonyPoint::dist(
  self : BiophyloparsimonyPoint,
  other : BiophyloparsimonyPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn BiophyloparsimonyPoint::add(
  self : BiophyloparsimonyPoint,
  other : BiophyloparsimonyPoint,
) -> BiophyloparsimonyPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn BiophyloparsimonyPoint::sub(
  self : BiophyloparsimonyPoint,
  other : BiophyloparsimonyPoint,
) -> BiophyloparsimonyPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn BiophyloparsimonyPoint::scale(
  self : BiophyloparsimonyPoint,
  s : Double,
) -> BiophyloparsimonyPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn BiophyloparsimonyPoint::dot(
  self : BiophyloparsimonyPoint,
  other : BiophyloparsimonyPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn BiophyloparsimonyPoint::cross(
  self : BiophyloparsimonyPoint,
  other : BiophyloparsimonyPoint,
) -> BiophyloparsimonyPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn BiophyloparsimonyPoint::norm(self : BiophyloparsimonyPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn BiophyloparsimonyPoint::normalize(
  self : BiophyloparsimonyPoint,
) -> BiophyloparsimonyPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn BiophyloparsimonyPoint::negate(
  self : BiophyloparsimonyPoint,
) -> BiophyloparsimonyPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn BiophyloparsimonyPoint::mid(
  self : BiophyloparsimonyPoint,
  other : BiophyloparsimonyPoint,
) -> BiophyloparsimonyPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn BiophyloparsimonyPoint::lerp(
  self : BiophyloparsimonyPoint,
  other : BiophyloparsimonyPoint,
  t : Double,
) -> BiophyloparsimonyPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn BiophyloparsimonyPoint::to_string(
  self : BiophyloparsimonyPoint,
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
pub(all) struct BiophyloparsimonySeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn bio_phylo_parsimony_make_series(
  vals : Array[Double],
  name : String,
) -> BiophyloparsimonySeries {
  { vals, name, meta: 0, }
}

///|
pub fn BiophyloparsimonySeries::len(self : BiophyloparsimonySeries) -> Int32 {
  self.vals.length()
}

///|
pub fn BiophyloparsimonySeries::sum(self : BiophyloparsimonySeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn BiophyloparsimonySeries::mean(self : BiophyloparsimonySeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn BiophyloparsimonySeries::min(self : BiophyloparsimonySeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn BiophyloparsimonySeries::max(self : BiophyloparsimonySeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn BiophyloparsimonySeries::range(self : BiophyloparsimonySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn BiophyloparsimonySeries::variance(
  self : BiophyloparsimonySeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn BiophyloparsimonySeries::std(self : BiophyloparsimonySeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn BiophyloparsimonySeries::median(
  self : BiophyloparsimonySeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn BiophyloparsimonySeries::scale(
  self : BiophyloparsimonySeries,
  f : Double,
) -> BiophyloparsimonySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn BiophyloparsimonySeries::add(
  self : BiophyloparsimonySeries,
  other : BiophyloparsimonySeries,
) -> BiophyloparsimonySeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn BiophyloparsimonySeries::sub(
  self : BiophyloparsimonySeries,
  other : BiophyloparsimonySeries,
) -> BiophyloparsimonySeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn BiophyloparsimonySeries::normalize(
  self : BiophyloparsimonySeries,
) -> BiophyloparsimonySeries {
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
pub fn BiophyloparsimonySeries::cumsum(
  self : BiophyloparsimonySeries,
) -> BiophyloparsimonySeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn BiophyloparsimonySeries::to_string(
  self : BiophyloparsimonySeries,
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
pub(all) struct BiophyloparsimonyMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn bio_phylo_parsimony_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> BiophyloparsimonyMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn bio_phylo_parsimony_matrix_identity(
  n : Int32,
) -> BiophyloparsimonyMatrix {
  let m = bio_phylo_parsimony_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn BiophyloparsimonyMatrix::get(
  self : BiophyloparsimonyMatrix,
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
pub fn BiophyloparsimonyMatrix::transpose(
  self : BiophyloparsimonyMatrix,
) -> BiophyloparsimonyMatrix {
  let result = bio_phylo_parsimony_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn BiophyloparsimonyMatrix::add(
  self : BiophyloparsimonyMatrix,
  other : BiophyloparsimonyMatrix,
) -> BiophyloparsimonyMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = bio_phylo_parsimony_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn BiophyloparsimonyMatrix::scale(
  self : BiophyloparsimonyMatrix,
  s : Double,
) -> BiophyloparsimonyMatrix {
  let result = bio_phylo_parsimony_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn BiophyloparsimonyMatrix::multiply(
  self : BiophyloparsimonyMatrix,
  other : BiophyloparsimonyMatrix,
) -> BiophyloparsimonyMatrix {
  if self.cols != other.rows {
    return bio_phylo_parsimony_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = bio_phylo_parsimony_make_matrix(self.rows, other.cols, 0.0)
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
pub fn BiophyloparsimonyMatrix::trace(self : BiophyloparsimonyMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn BiophyloparsimonyMatrix::det(self : BiophyloparsimonyMatrix) -> Double {
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
pub fn BiophyloparsimonyMatrix::norm(self : BiophyloparsimonyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn BiophyloparsimonyMatrix::to_string(
  self : BiophyloparsimonyMatrix,
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
pub(all) struct BiophyloparsimonyVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn bio_phylo_parsimony_make_vector(
  comps : Array[Double],
) -> BiophyloparsimonyVector {
  { comps, dim: comps.length(), }
}

///|
pub fn bio_phylo_parsimony_vector_zero(dim : Int32) -> BiophyloparsimonyVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn BiophyloparsimonyVector::add(
  self : BiophyloparsimonyVector,
  other : BiophyloparsimonyVector,
) -> BiophyloparsimonyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn BiophyloparsimonyVector::sub(
  self : BiophyloparsimonyVector,
  other : BiophyloparsimonyVector,
) -> BiophyloparsimonyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn BiophyloparsimonyVector::scale(
  self : BiophyloparsimonyVector,
  s : Double,
) -> BiophyloparsimonyVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn BiophyloparsimonyVector::dot(
  self : BiophyloparsimonyVector,
  other : BiophyloparsimonyVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn BiophyloparsimonyVector::norm(self : BiophyloparsimonyVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn BiophyloparsimonyVector::normalize(
  self : BiophyloparsimonyVector,
) -> BiophyloparsimonyVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn BiophyloparsimonyVector::dist(
  self : BiophyloparsimonyVector,
  other : BiophyloparsimonyVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn BiophyloparsimonyVector::to_string(
  self : BiophyloparsimonyVector,
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
pub(all) struct BiophyloparsimonyFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_phylo_parsimony_frame_make(size : Int32) -> BiophyloparsimonyFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiophyloparsimonyFrame::len(self : BiophyloparsimonyFrame) -> Int32 {
  self.size
}

///|
pub fn BiophyloparsimonyFrame::get(
  self : BiophyloparsimonyFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiophyloparsimonyFrame::set(
  self : BiophyloparsimonyFrame,
  i : Int32,
  v : Double,
) -> BiophyloparsimonyFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyFrame::sum(self : BiophyloparsimonyFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiophyloparsimonyFrame::mean(self : BiophyloparsimonyFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiophyloparsimonyFrame::scale(
  self : BiophyloparsimonyFrame,
  f : Double,
) -> BiophyloparsimonyFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyFrame::add(
  self : BiophyloparsimonyFrame,
  other : BiophyloparsimonyFrame,
) -> BiophyloparsimonyFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyFrame::copy(
  self : BiophyloparsimonyFrame,
) -> BiophyloparsimonyFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyFrame::fill(
  self : BiophyloparsimonyFrame,
  v : Double,
) -> BiophyloparsimonyFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyFrame::min(self : BiophyloparsimonyFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiophyloparsimonyFrame::max(self : BiophyloparsimonyFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiophyloparsimonyFrame::to_string(
  self : BiophyloparsimonyFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiophyloparsimonyTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_phylo_parsimony_table_make(size : Int32) -> BiophyloparsimonyTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiophyloparsimonyTable::len(self : BiophyloparsimonyTable) -> Int32 {
  self.size
}

///|
pub fn BiophyloparsimonyTable::get(
  self : BiophyloparsimonyTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiophyloparsimonyTable::set(
  self : BiophyloparsimonyTable,
  i : Int32,
  v : Double,
) -> BiophyloparsimonyTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyTable::sum(self : BiophyloparsimonyTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiophyloparsimonyTable::mean(self : BiophyloparsimonyTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiophyloparsimonyTable::scale(
  self : BiophyloparsimonyTable,
  f : Double,
) -> BiophyloparsimonyTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyTable::add(
  self : BiophyloparsimonyTable,
  other : BiophyloparsimonyTable,
) -> BiophyloparsimonyTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyTable::copy(
  self : BiophyloparsimonyTable,
) -> BiophyloparsimonyTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyTable::fill(
  self : BiophyloparsimonyTable,
  v : Double,
) -> BiophyloparsimonyTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyTable::min(self : BiophyloparsimonyTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiophyloparsimonyTable::max(self : BiophyloparsimonyTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiophyloparsimonyTable::to_string(
  self : BiophyloparsimonyTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiophyloparsimonyGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_phylo_parsimony_graphn_make(size : Int32) -> BiophyloparsimonyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiophyloparsimonyGraphN::len(self : BiophyloparsimonyGraphN) -> Int32 {
  self.size
}

///|
pub fn BiophyloparsimonyGraphN::get(
  self : BiophyloparsimonyGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiophyloparsimonyGraphN::set(
  self : BiophyloparsimonyGraphN,
  i : Int32,
  v : Double,
) -> BiophyloparsimonyGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyGraphN::sum(self : BiophyloparsimonyGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiophyloparsimonyGraphN::mean(self : BiophyloparsimonyGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiophyloparsimonyGraphN::scale(
  self : BiophyloparsimonyGraphN,
  f : Double,
) -> BiophyloparsimonyGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyGraphN::add(
  self : BiophyloparsimonyGraphN,
  other : BiophyloparsimonyGraphN,
) -> BiophyloparsimonyGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyGraphN::copy(
  self : BiophyloparsimonyGraphN,
) -> BiophyloparsimonyGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyGraphN::fill(
  self : BiophyloparsimonyGraphN,
  v : Double,
) -> BiophyloparsimonyGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyGraphN::min(self : BiophyloparsimonyGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiophyloparsimonyGraphN::max(self : BiophyloparsimonyGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiophyloparsimonyGraphN::to_string(
  self : BiophyloparsimonyGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiophyloparsimonyNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_phylo_parsimony_node_make(size : Int32) -> BiophyloparsimonyNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiophyloparsimonyNode::len(self : BiophyloparsimonyNode) -> Int32 {
  self.size
}

///|
pub fn BiophyloparsimonyNode::get(
  self : BiophyloparsimonyNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiophyloparsimonyNode::set(
  self : BiophyloparsimonyNode,
  i : Int32,
  v : Double,
) -> BiophyloparsimonyNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyNode::sum(self : BiophyloparsimonyNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiophyloparsimonyNode::mean(self : BiophyloparsimonyNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiophyloparsimonyNode::scale(
  self : BiophyloparsimonyNode,
  f : Double,
) -> BiophyloparsimonyNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyNode::add(
  self : BiophyloparsimonyNode,
  other : BiophyloparsimonyNode,
) -> BiophyloparsimonyNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyNode::copy(
  self : BiophyloparsimonyNode,
) -> BiophyloparsimonyNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyNode::fill(
  self : BiophyloparsimonyNode,
  v : Double,
) -> BiophyloparsimonyNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyNode::min(self : BiophyloparsimonyNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiophyloparsimonyNode::max(self : BiophyloparsimonyNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiophyloparsimonyNode::to_string(self : BiophyloparsimonyNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiophyloparsimonyEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_phylo_parsimony_edge_make(size : Int32) -> BiophyloparsimonyEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiophyloparsimonyEdge::len(self : BiophyloparsimonyEdge) -> Int32 {
  self.size
}

///|
pub fn BiophyloparsimonyEdge::get(
  self : BiophyloparsimonyEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiophyloparsimonyEdge::set(
  self : BiophyloparsimonyEdge,
  i : Int32,
  v : Double,
) -> BiophyloparsimonyEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyEdge::sum(self : BiophyloparsimonyEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiophyloparsimonyEdge::mean(self : BiophyloparsimonyEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiophyloparsimonyEdge::scale(
  self : BiophyloparsimonyEdge,
  f : Double,
) -> BiophyloparsimonyEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyEdge::add(
  self : BiophyloparsimonyEdge,
  other : BiophyloparsimonyEdge,
) -> BiophyloparsimonyEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyEdge::copy(
  self : BiophyloparsimonyEdge,
) -> BiophyloparsimonyEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyEdge::fill(
  self : BiophyloparsimonyEdge,
  v : Double,
) -> BiophyloparsimonyEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyEdge::min(self : BiophyloparsimonyEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiophyloparsimonyEdge::max(self : BiophyloparsimonyEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiophyloparsimonyEdge::to_string(self : BiophyloparsimonyEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiophyloparsimonyPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_phylo_parsimony_path_make(size : Int32) -> BiophyloparsimonyPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiophyloparsimonyPath::len(self : BiophyloparsimonyPath) -> Int32 {
  self.size
}

///|
pub fn BiophyloparsimonyPath::get(
  self : BiophyloparsimonyPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiophyloparsimonyPath::set(
  self : BiophyloparsimonyPath,
  i : Int32,
  v : Double,
) -> BiophyloparsimonyPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyPath::sum(self : BiophyloparsimonyPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiophyloparsimonyPath::mean(self : BiophyloparsimonyPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiophyloparsimonyPath::scale(
  self : BiophyloparsimonyPath,
  f : Double,
) -> BiophyloparsimonyPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyPath::add(
  self : BiophyloparsimonyPath,
  other : BiophyloparsimonyPath,
) -> BiophyloparsimonyPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyPath::copy(
  self : BiophyloparsimonyPath,
) -> BiophyloparsimonyPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyPath::fill(
  self : BiophyloparsimonyPath,
  v : Double,
) -> BiophyloparsimonyPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyPath::min(self : BiophyloparsimonyPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiophyloparsimonyPath::max(self : BiophyloparsimonyPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiophyloparsimonyPath::to_string(self : BiophyloparsimonyPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiophyloparsimonyCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_phylo_parsimony_cluster_make(
  size : Int32,
) -> BiophyloparsimonyCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiophyloparsimonyCluster::len(self : BiophyloparsimonyCluster) -> Int32 {
  self.size
}

///|
pub fn BiophyloparsimonyCluster::get(
  self : BiophyloparsimonyCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiophyloparsimonyCluster::set(
  self : BiophyloparsimonyCluster,
  i : Int32,
  v : Double,
) -> BiophyloparsimonyCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyCluster::sum(self : BiophyloparsimonyCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiophyloparsimonyCluster::mean(
  self : BiophyloparsimonyCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiophyloparsimonyCluster::scale(
  self : BiophyloparsimonyCluster,
  f : Double,
) -> BiophyloparsimonyCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyCluster::add(
  self : BiophyloparsimonyCluster,
  other : BiophyloparsimonyCluster,
) -> BiophyloparsimonyCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyCluster::copy(
  self : BiophyloparsimonyCluster,
) -> BiophyloparsimonyCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyCluster::fill(
  self : BiophyloparsimonyCluster,
  v : Double,
) -> BiophyloparsimonyCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyCluster::min(self : BiophyloparsimonyCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiophyloparsimonyCluster::max(self : BiophyloparsimonyCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiophyloparsimonyCluster::to_string(
  self : BiophyloparsimonyCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiophyloparsimonyModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_phylo_parsimony_model_make(size : Int32) -> BiophyloparsimonyModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiophyloparsimonyModel::len(self : BiophyloparsimonyModel) -> Int32 {
  self.size
}

///|
pub fn BiophyloparsimonyModel::get(
  self : BiophyloparsimonyModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiophyloparsimonyModel::set(
  self : BiophyloparsimonyModel,
  i : Int32,
  v : Double,
) -> BiophyloparsimonyModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyModel::sum(self : BiophyloparsimonyModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiophyloparsimonyModel::mean(self : BiophyloparsimonyModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiophyloparsimonyModel::scale(
  self : BiophyloparsimonyModel,
  f : Double,
) -> BiophyloparsimonyModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyModel::add(
  self : BiophyloparsimonyModel,
  other : BiophyloparsimonyModel,
) -> BiophyloparsimonyModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyModel::copy(
  self : BiophyloparsimonyModel,
) -> BiophyloparsimonyModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyModel::fill(
  self : BiophyloparsimonyModel,
  v : Double,
) -> BiophyloparsimonyModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyModel::min(self : BiophyloparsimonyModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiophyloparsimonyModel::max(self : BiophyloparsimonyModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiophyloparsimonyModel::to_string(
  self : BiophyloparsimonyModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiophyloparsimonyLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_phylo_parsimony_layer_make(size : Int32) -> BiophyloparsimonyLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiophyloparsimonyLayer::len(self : BiophyloparsimonyLayer) -> Int32 {
  self.size
}

///|
pub fn BiophyloparsimonyLayer::get(
  self : BiophyloparsimonyLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiophyloparsimonyLayer::set(
  self : BiophyloparsimonyLayer,
  i : Int32,
  v : Double,
) -> BiophyloparsimonyLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyLayer::sum(self : BiophyloparsimonyLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiophyloparsimonyLayer::mean(self : BiophyloparsimonyLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiophyloparsimonyLayer::scale(
  self : BiophyloparsimonyLayer,
  f : Double,
) -> BiophyloparsimonyLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyLayer::add(
  self : BiophyloparsimonyLayer,
  other : BiophyloparsimonyLayer,
) -> BiophyloparsimonyLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyLayer::copy(
  self : BiophyloparsimonyLayer,
) -> BiophyloparsimonyLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyLayer::fill(
  self : BiophyloparsimonyLayer,
  v : Double,
) -> BiophyloparsimonyLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyLayer::min(self : BiophyloparsimonyLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiophyloparsimonyLayer::max(self : BiophyloparsimonyLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiophyloparsimonyLayer::to_string(
  self : BiophyloparsimonyLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiophyloparsimonyBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_phylo_parsimony_buffer_make(size : Int32) -> BiophyloparsimonyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiophyloparsimonyBuffer::len(self : BiophyloparsimonyBuffer) -> Int32 {
  self.size
}

///|
pub fn BiophyloparsimonyBuffer::get(
  self : BiophyloparsimonyBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiophyloparsimonyBuffer::set(
  self : BiophyloparsimonyBuffer,
  i : Int32,
  v : Double,
) -> BiophyloparsimonyBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyBuffer::sum(self : BiophyloparsimonyBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiophyloparsimonyBuffer::mean(self : BiophyloparsimonyBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiophyloparsimonyBuffer::scale(
  self : BiophyloparsimonyBuffer,
  f : Double,
) -> BiophyloparsimonyBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyBuffer::add(
  self : BiophyloparsimonyBuffer,
  other : BiophyloparsimonyBuffer,
) -> BiophyloparsimonyBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyBuffer::copy(
  self : BiophyloparsimonyBuffer,
) -> BiophyloparsimonyBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyBuffer::fill(
  self : BiophyloparsimonyBuffer,
  v : Double,
) -> BiophyloparsimonyBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyBuffer::min(self : BiophyloparsimonyBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiophyloparsimonyBuffer::max(self : BiophyloparsimonyBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiophyloparsimonyBuffer::to_string(
  self : BiophyloparsimonyBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiophyloparsimonyCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_phylo_parsimony_cursor_make(size : Int32) -> BiophyloparsimonyCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiophyloparsimonyCursor::len(self : BiophyloparsimonyCursor) -> Int32 {
  self.size
}

///|
pub fn BiophyloparsimonyCursor::get(
  self : BiophyloparsimonyCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiophyloparsimonyCursor::set(
  self : BiophyloparsimonyCursor,
  i : Int32,
  v : Double,
) -> BiophyloparsimonyCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyCursor::sum(self : BiophyloparsimonyCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiophyloparsimonyCursor::mean(self : BiophyloparsimonyCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiophyloparsimonyCursor::scale(
  self : BiophyloparsimonyCursor,
  f : Double,
) -> BiophyloparsimonyCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyCursor::add(
  self : BiophyloparsimonyCursor,
  other : BiophyloparsimonyCursor,
) -> BiophyloparsimonyCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyCursor::copy(
  self : BiophyloparsimonyCursor,
) -> BiophyloparsimonyCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyCursor::fill(
  self : BiophyloparsimonyCursor,
  v : Double,
) -> BiophyloparsimonyCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyCursor::min(self : BiophyloparsimonyCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiophyloparsimonyCursor::max(self : BiophyloparsimonyCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiophyloparsimonyCursor::to_string(
  self : BiophyloparsimonyCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiophyloparsimonyView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_phylo_parsimony_view_make(size : Int32) -> BiophyloparsimonyView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiophyloparsimonyView::len(self : BiophyloparsimonyView) -> Int32 {
  self.size
}

///|
pub fn BiophyloparsimonyView::get(
  self : BiophyloparsimonyView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiophyloparsimonyView::set(
  self : BiophyloparsimonyView,
  i : Int32,
  v : Double,
) -> BiophyloparsimonyView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyView::sum(self : BiophyloparsimonyView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiophyloparsimonyView::mean(self : BiophyloparsimonyView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiophyloparsimonyView::scale(
  self : BiophyloparsimonyView,
  f : Double,
) -> BiophyloparsimonyView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyView::add(
  self : BiophyloparsimonyView,
  other : BiophyloparsimonyView,
) -> BiophyloparsimonyView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyView::copy(
  self : BiophyloparsimonyView,
) -> BiophyloparsimonyView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyView::fill(
  self : BiophyloparsimonyView,
  v : Double,
) -> BiophyloparsimonyView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyView::min(self : BiophyloparsimonyView) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiophyloparsimonyView::max(self : BiophyloparsimonyView) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiophyloparsimonyView::to_string(self : BiophyloparsimonyView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiophyloparsimonyRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_phylo_parsimony_range_make(size : Int32) -> BiophyloparsimonyRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiophyloparsimonyRange::len(self : BiophyloparsimonyRange) -> Int32 {
  self.size
}

///|
pub fn BiophyloparsimonyRange::get(
  self : BiophyloparsimonyRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiophyloparsimonyRange::set(
  self : BiophyloparsimonyRange,
  i : Int32,
  v : Double,
) -> BiophyloparsimonyRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyRange::sum(self : BiophyloparsimonyRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiophyloparsimonyRange::mean(self : BiophyloparsimonyRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiophyloparsimonyRange::scale(
  self : BiophyloparsimonyRange,
  f : Double,
) -> BiophyloparsimonyRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyRange::add(
  self : BiophyloparsimonyRange,
  other : BiophyloparsimonyRange,
) -> BiophyloparsimonyRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyRange::copy(
  self : BiophyloparsimonyRange,
) -> BiophyloparsimonyRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyRange::fill(
  self : BiophyloparsimonyRange,
  v : Double,
) -> BiophyloparsimonyRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonyRange::min(self : BiophyloparsimonyRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiophyloparsimonyRange::max(self : BiophyloparsimonyRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiophyloparsimonyRange::to_string(
  self : BiophyloparsimonyRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiophyloparsimonySlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_phylo_parsimony_slice_make(size : Int32) -> BiophyloparsimonySlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiophyloparsimonySlice::len(self : BiophyloparsimonySlice) -> Int32 {
  self.size
}

///|
pub fn BiophyloparsimonySlice::get(
  self : BiophyloparsimonySlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiophyloparsimonySlice::set(
  self : BiophyloparsimonySlice,
  i : Int32,
  v : Double,
) -> BiophyloparsimonySlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonySlice::sum(self : BiophyloparsimonySlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiophyloparsimonySlice::mean(self : BiophyloparsimonySlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiophyloparsimonySlice::scale(
  self : BiophyloparsimonySlice,
  f : Double,
) -> BiophyloparsimonySlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonySlice::add(
  self : BiophyloparsimonySlice,
  other : BiophyloparsimonySlice,
) -> BiophyloparsimonySlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiophyloparsimonySlice::copy(
  self : BiophyloparsimonySlice,
) -> BiophyloparsimonySlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonySlice::fill(
  self : BiophyloparsimonySlice,
  v : Double,
) -> BiophyloparsimonySlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiophyloparsimonySlice::min(self : BiophyloparsimonySlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiophyloparsimonySlice::max(self : BiophyloparsimonySlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiophyloparsimonySlice::to_string(
  self : BiophyloparsimonySlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
