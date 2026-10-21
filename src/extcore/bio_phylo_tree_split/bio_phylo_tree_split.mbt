///|
///===
/// extcore/bio_phylo_tree_split
pub(all) struct BiophylotreesplitPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn bio_phylo_tree_split_make_point(
  x : Double,
  y : Double,
) -> BiophylotreesplitPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn bio_phylo_tree_split_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> BiophylotreesplitPoint {
  { x, y, z, label: 0, }
}

///|
pub fn BiophylotreesplitPoint::x(self : BiophylotreesplitPoint) -> Double {
  self.x
}

///|
pub fn BiophylotreesplitPoint::y(self : BiophylotreesplitPoint) -> Double {
  self.y
}

///|
pub fn BiophylotreesplitPoint::z(self : BiophylotreesplitPoint) -> Double {
  self.z
}

///|
pub fn BiophylotreesplitPoint::label(self : BiophylotreesplitPoint) -> Int32 {
  self.label
}

///|
pub fn BiophylotreesplitPoint::dist(
  self : BiophylotreesplitPoint,
  other : BiophylotreesplitPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn BiophylotreesplitPoint::add(
  self : BiophylotreesplitPoint,
  other : BiophylotreesplitPoint,
) -> BiophylotreesplitPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn BiophylotreesplitPoint::sub(
  self : BiophylotreesplitPoint,
  other : BiophylotreesplitPoint,
) -> BiophylotreesplitPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn BiophylotreesplitPoint::scale(
  self : BiophylotreesplitPoint,
  s : Double,
) -> BiophylotreesplitPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn BiophylotreesplitPoint::dot(
  self : BiophylotreesplitPoint,
  other : BiophylotreesplitPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn BiophylotreesplitPoint::cross(
  self : BiophylotreesplitPoint,
  other : BiophylotreesplitPoint,
) -> BiophylotreesplitPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn BiophylotreesplitPoint::norm(self : BiophylotreesplitPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn BiophylotreesplitPoint::normalize(
  self : BiophylotreesplitPoint,
) -> BiophylotreesplitPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn BiophylotreesplitPoint::negate(
  self : BiophylotreesplitPoint,
) -> BiophylotreesplitPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn BiophylotreesplitPoint::mid(
  self : BiophylotreesplitPoint,
  other : BiophylotreesplitPoint,
) -> BiophylotreesplitPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn BiophylotreesplitPoint::lerp(
  self : BiophylotreesplitPoint,
  other : BiophylotreesplitPoint,
  t : Double,
) -> BiophylotreesplitPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn BiophylotreesplitPoint::to_string(
  self : BiophylotreesplitPoint,
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
pub(all) struct BiophylotreesplitSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn bio_phylo_tree_split_make_series(
  vals : Array[Double],
  name : String,
) -> BiophylotreesplitSeries {
  { vals, name, meta: 0, }
}

///|
pub fn BiophylotreesplitSeries::len(self : BiophylotreesplitSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn BiophylotreesplitSeries::sum(self : BiophylotreesplitSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn BiophylotreesplitSeries::mean(self : BiophylotreesplitSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn BiophylotreesplitSeries::min(self : BiophylotreesplitSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn BiophylotreesplitSeries::max(self : BiophylotreesplitSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn BiophylotreesplitSeries::range(self : BiophylotreesplitSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn BiophylotreesplitSeries::variance(
  self : BiophylotreesplitSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn BiophylotreesplitSeries::std(self : BiophylotreesplitSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn BiophylotreesplitSeries::median(
  self : BiophylotreesplitSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn BiophylotreesplitSeries::scale(
  self : BiophylotreesplitSeries,
  f : Double,
) -> BiophylotreesplitSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn BiophylotreesplitSeries::add(
  self : BiophylotreesplitSeries,
  other : BiophylotreesplitSeries,
) -> BiophylotreesplitSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn BiophylotreesplitSeries::sub(
  self : BiophylotreesplitSeries,
  other : BiophylotreesplitSeries,
) -> BiophylotreesplitSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn BiophylotreesplitSeries::normalize(
  self : BiophylotreesplitSeries,
) -> BiophylotreesplitSeries {
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
pub fn BiophylotreesplitSeries::cumsum(
  self : BiophylotreesplitSeries,
) -> BiophylotreesplitSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn BiophylotreesplitSeries::to_string(
  self : BiophylotreesplitSeries,
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
pub(all) struct BiophylotreesplitMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn bio_phylo_tree_split_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> BiophylotreesplitMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn bio_phylo_tree_split_matrix_identity(
  n : Int32,
) -> BiophylotreesplitMatrix {
  let m = bio_phylo_tree_split_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn BiophylotreesplitMatrix::get(
  self : BiophylotreesplitMatrix,
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
pub fn BiophylotreesplitMatrix::transpose(
  self : BiophylotreesplitMatrix,
) -> BiophylotreesplitMatrix {
  let result = bio_phylo_tree_split_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn BiophylotreesplitMatrix::add(
  self : BiophylotreesplitMatrix,
  other : BiophylotreesplitMatrix,
) -> BiophylotreesplitMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = bio_phylo_tree_split_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn BiophylotreesplitMatrix::scale(
  self : BiophylotreesplitMatrix,
  s : Double,
) -> BiophylotreesplitMatrix {
  let result = bio_phylo_tree_split_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn BiophylotreesplitMatrix::multiply(
  self : BiophylotreesplitMatrix,
  other : BiophylotreesplitMatrix,
) -> BiophylotreesplitMatrix {
  if self.cols != other.rows {
    return bio_phylo_tree_split_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = bio_phylo_tree_split_make_matrix(self.rows, other.cols, 0.0)
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
pub fn BiophylotreesplitMatrix::trace(self : BiophylotreesplitMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn BiophylotreesplitMatrix::det(self : BiophylotreesplitMatrix) -> Double {
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
pub fn BiophylotreesplitMatrix::norm(self : BiophylotreesplitMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn BiophylotreesplitMatrix::to_string(
  self : BiophylotreesplitMatrix,
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
pub(all) struct BiophylotreesplitVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn bio_phylo_tree_split_make_vector(
  comps : Array[Double],
) -> BiophylotreesplitVector {
  { comps, dim: comps.length(), }
}

///|
pub fn bio_phylo_tree_split_vector_zero(dim : Int32) -> BiophylotreesplitVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn BiophylotreesplitVector::add(
  self : BiophylotreesplitVector,
  other : BiophylotreesplitVector,
) -> BiophylotreesplitVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn BiophylotreesplitVector::sub(
  self : BiophylotreesplitVector,
  other : BiophylotreesplitVector,
) -> BiophylotreesplitVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn BiophylotreesplitVector::scale(
  self : BiophylotreesplitVector,
  s : Double,
) -> BiophylotreesplitVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn BiophylotreesplitVector::dot(
  self : BiophylotreesplitVector,
  other : BiophylotreesplitVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn BiophylotreesplitVector::norm(self : BiophylotreesplitVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn BiophylotreesplitVector::normalize(
  self : BiophylotreesplitVector,
) -> BiophylotreesplitVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn BiophylotreesplitVector::dist(
  self : BiophylotreesplitVector,
  other : BiophylotreesplitVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn BiophylotreesplitVector::to_string(
  self : BiophylotreesplitVector,
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
pub(all) struct BiophylotreesplitFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_phylo_tree_split_frame_make(size : Int32) -> BiophylotreesplitFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiophylotreesplitFrame::len(self : BiophylotreesplitFrame) -> Int32 {
  self.size
}

///|
pub fn BiophylotreesplitFrame::get(
  self : BiophylotreesplitFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiophylotreesplitFrame::set(
  self : BiophylotreesplitFrame,
  i : Int32,
  v : Double,
) -> BiophylotreesplitFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitFrame::sum(self : BiophylotreesplitFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiophylotreesplitFrame::mean(self : BiophylotreesplitFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiophylotreesplitFrame::scale(
  self : BiophylotreesplitFrame,
  f : Double,
) -> BiophylotreesplitFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitFrame::add(
  self : BiophylotreesplitFrame,
  other : BiophylotreesplitFrame,
) -> BiophylotreesplitFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiophylotreesplitFrame::copy(
  self : BiophylotreesplitFrame,
) -> BiophylotreesplitFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitFrame::fill(
  self : BiophylotreesplitFrame,
  v : Double,
) -> BiophylotreesplitFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitFrame::min(self : BiophylotreesplitFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiophylotreesplitFrame::max(self : BiophylotreesplitFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiophylotreesplitFrame::to_string(
  self : BiophylotreesplitFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiophylotreesplitTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_phylo_tree_split_table_make(size : Int32) -> BiophylotreesplitTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiophylotreesplitTable::len(self : BiophylotreesplitTable) -> Int32 {
  self.size
}

///|
pub fn BiophylotreesplitTable::get(
  self : BiophylotreesplitTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiophylotreesplitTable::set(
  self : BiophylotreesplitTable,
  i : Int32,
  v : Double,
) -> BiophylotreesplitTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitTable::sum(self : BiophylotreesplitTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiophylotreesplitTable::mean(self : BiophylotreesplitTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiophylotreesplitTable::scale(
  self : BiophylotreesplitTable,
  f : Double,
) -> BiophylotreesplitTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitTable::add(
  self : BiophylotreesplitTable,
  other : BiophylotreesplitTable,
) -> BiophylotreesplitTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiophylotreesplitTable::copy(
  self : BiophylotreesplitTable,
) -> BiophylotreesplitTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitTable::fill(
  self : BiophylotreesplitTable,
  v : Double,
) -> BiophylotreesplitTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitTable::min(self : BiophylotreesplitTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiophylotreesplitTable::max(self : BiophylotreesplitTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiophylotreesplitTable::to_string(
  self : BiophylotreesplitTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiophylotreesplitGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_phylo_tree_split_graphn_make(
  size : Int32,
) -> BiophylotreesplitGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiophylotreesplitGraphN::len(self : BiophylotreesplitGraphN) -> Int32 {
  self.size
}

///|
pub fn BiophylotreesplitGraphN::get(
  self : BiophylotreesplitGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiophylotreesplitGraphN::set(
  self : BiophylotreesplitGraphN,
  i : Int32,
  v : Double,
) -> BiophylotreesplitGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitGraphN::sum(self : BiophylotreesplitGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiophylotreesplitGraphN::mean(self : BiophylotreesplitGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiophylotreesplitGraphN::scale(
  self : BiophylotreesplitGraphN,
  f : Double,
) -> BiophylotreesplitGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitGraphN::add(
  self : BiophylotreesplitGraphN,
  other : BiophylotreesplitGraphN,
) -> BiophylotreesplitGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiophylotreesplitGraphN::copy(
  self : BiophylotreesplitGraphN,
) -> BiophylotreesplitGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitGraphN::fill(
  self : BiophylotreesplitGraphN,
  v : Double,
) -> BiophylotreesplitGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitGraphN::min(self : BiophylotreesplitGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiophylotreesplitGraphN::max(self : BiophylotreesplitGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiophylotreesplitGraphN::to_string(
  self : BiophylotreesplitGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiophylotreesplitNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_phylo_tree_split_node_make(size : Int32) -> BiophylotreesplitNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiophylotreesplitNode::len(self : BiophylotreesplitNode) -> Int32 {
  self.size
}

///|
pub fn BiophylotreesplitNode::get(
  self : BiophylotreesplitNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiophylotreesplitNode::set(
  self : BiophylotreesplitNode,
  i : Int32,
  v : Double,
) -> BiophylotreesplitNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitNode::sum(self : BiophylotreesplitNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiophylotreesplitNode::mean(self : BiophylotreesplitNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiophylotreesplitNode::scale(
  self : BiophylotreesplitNode,
  f : Double,
) -> BiophylotreesplitNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitNode::add(
  self : BiophylotreesplitNode,
  other : BiophylotreesplitNode,
) -> BiophylotreesplitNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiophylotreesplitNode::copy(
  self : BiophylotreesplitNode,
) -> BiophylotreesplitNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitNode::fill(
  self : BiophylotreesplitNode,
  v : Double,
) -> BiophylotreesplitNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitNode::min(self : BiophylotreesplitNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiophylotreesplitNode::max(self : BiophylotreesplitNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiophylotreesplitNode::to_string(self : BiophylotreesplitNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiophylotreesplitEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_phylo_tree_split_edge_make(size : Int32) -> BiophylotreesplitEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiophylotreesplitEdge::len(self : BiophylotreesplitEdge) -> Int32 {
  self.size
}

///|
pub fn BiophylotreesplitEdge::get(
  self : BiophylotreesplitEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiophylotreesplitEdge::set(
  self : BiophylotreesplitEdge,
  i : Int32,
  v : Double,
) -> BiophylotreesplitEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitEdge::sum(self : BiophylotreesplitEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiophylotreesplitEdge::mean(self : BiophylotreesplitEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiophylotreesplitEdge::scale(
  self : BiophylotreesplitEdge,
  f : Double,
) -> BiophylotreesplitEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitEdge::add(
  self : BiophylotreesplitEdge,
  other : BiophylotreesplitEdge,
) -> BiophylotreesplitEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiophylotreesplitEdge::copy(
  self : BiophylotreesplitEdge,
) -> BiophylotreesplitEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitEdge::fill(
  self : BiophylotreesplitEdge,
  v : Double,
) -> BiophylotreesplitEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitEdge::min(self : BiophylotreesplitEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiophylotreesplitEdge::max(self : BiophylotreesplitEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiophylotreesplitEdge::to_string(self : BiophylotreesplitEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiophylotreesplitPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_phylo_tree_split_path_make(size : Int32) -> BiophylotreesplitPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiophylotreesplitPath::len(self : BiophylotreesplitPath) -> Int32 {
  self.size
}

///|
pub fn BiophylotreesplitPath::get(
  self : BiophylotreesplitPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiophylotreesplitPath::set(
  self : BiophylotreesplitPath,
  i : Int32,
  v : Double,
) -> BiophylotreesplitPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitPath::sum(self : BiophylotreesplitPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiophylotreesplitPath::mean(self : BiophylotreesplitPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiophylotreesplitPath::scale(
  self : BiophylotreesplitPath,
  f : Double,
) -> BiophylotreesplitPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitPath::add(
  self : BiophylotreesplitPath,
  other : BiophylotreesplitPath,
) -> BiophylotreesplitPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiophylotreesplitPath::copy(
  self : BiophylotreesplitPath,
) -> BiophylotreesplitPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitPath::fill(
  self : BiophylotreesplitPath,
  v : Double,
) -> BiophylotreesplitPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitPath::min(self : BiophylotreesplitPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiophylotreesplitPath::max(self : BiophylotreesplitPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiophylotreesplitPath::to_string(self : BiophylotreesplitPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiophylotreesplitCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_phylo_tree_split_cluster_make(
  size : Int32,
) -> BiophylotreesplitCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiophylotreesplitCluster::len(self : BiophylotreesplitCluster) -> Int32 {
  self.size
}

///|
pub fn BiophylotreesplitCluster::get(
  self : BiophylotreesplitCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiophylotreesplitCluster::set(
  self : BiophylotreesplitCluster,
  i : Int32,
  v : Double,
) -> BiophylotreesplitCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitCluster::sum(self : BiophylotreesplitCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiophylotreesplitCluster::mean(
  self : BiophylotreesplitCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiophylotreesplitCluster::scale(
  self : BiophylotreesplitCluster,
  f : Double,
) -> BiophylotreesplitCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitCluster::add(
  self : BiophylotreesplitCluster,
  other : BiophylotreesplitCluster,
) -> BiophylotreesplitCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiophylotreesplitCluster::copy(
  self : BiophylotreesplitCluster,
) -> BiophylotreesplitCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitCluster::fill(
  self : BiophylotreesplitCluster,
  v : Double,
) -> BiophylotreesplitCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitCluster::min(self : BiophylotreesplitCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiophylotreesplitCluster::max(self : BiophylotreesplitCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiophylotreesplitCluster::to_string(
  self : BiophylotreesplitCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiophylotreesplitModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_phylo_tree_split_model_make(size : Int32) -> BiophylotreesplitModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiophylotreesplitModel::len(self : BiophylotreesplitModel) -> Int32 {
  self.size
}

///|
pub fn BiophylotreesplitModel::get(
  self : BiophylotreesplitModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiophylotreesplitModel::set(
  self : BiophylotreesplitModel,
  i : Int32,
  v : Double,
) -> BiophylotreesplitModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitModel::sum(self : BiophylotreesplitModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiophylotreesplitModel::mean(self : BiophylotreesplitModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiophylotreesplitModel::scale(
  self : BiophylotreesplitModel,
  f : Double,
) -> BiophylotreesplitModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitModel::add(
  self : BiophylotreesplitModel,
  other : BiophylotreesplitModel,
) -> BiophylotreesplitModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiophylotreesplitModel::copy(
  self : BiophylotreesplitModel,
) -> BiophylotreesplitModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitModel::fill(
  self : BiophylotreesplitModel,
  v : Double,
) -> BiophylotreesplitModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitModel::min(self : BiophylotreesplitModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiophylotreesplitModel::max(self : BiophylotreesplitModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiophylotreesplitModel::to_string(
  self : BiophylotreesplitModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiophylotreesplitLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_phylo_tree_split_layer_make(size : Int32) -> BiophylotreesplitLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiophylotreesplitLayer::len(self : BiophylotreesplitLayer) -> Int32 {
  self.size
}

///|
pub fn BiophylotreesplitLayer::get(
  self : BiophylotreesplitLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiophylotreesplitLayer::set(
  self : BiophylotreesplitLayer,
  i : Int32,
  v : Double,
) -> BiophylotreesplitLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitLayer::sum(self : BiophylotreesplitLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiophylotreesplitLayer::mean(self : BiophylotreesplitLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiophylotreesplitLayer::scale(
  self : BiophylotreesplitLayer,
  f : Double,
) -> BiophylotreesplitLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitLayer::add(
  self : BiophylotreesplitLayer,
  other : BiophylotreesplitLayer,
) -> BiophylotreesplitLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiophylotreesplitLayer::copy(
  self : BiophylotreesplitLayer,
) -> BiophylotreesplitLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitLayer::fill(
  self : BiophylotreesplitLayer,
  v : Double,
) -> BiophylotreesplitLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitLayer::min(self : BiophylotreesplitLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiophylotreesplitLayer::max(self : BiophylotreesplitLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiophylotreesplitLayer::to_string(
  self : BiophylotreesplitLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiophylotreesplitBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_phylo_tree_split_buffer_make(
  size : Int32,
) -> BiophylotreesplitBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiophylotreesplitBuffer::len(self : BiophylotreesplitBuffer) -> Int32 {
  self.size
}

///|
pub fn BiophylotreesplitBuffer::get(
  self : BiophylotreesplitBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiophylotreesplitBuffer::set(
  self : BiophylotreesplitBuffer,
  i : Int32,
  v : Double,
) -> BiophylotreesplitBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitBuffer::sum(self : BiophylotreesplitBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiophylotreesplitBuffer::mean(self : BiophylotreesplitBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiophylotreesplitBuffer::scale(
  self : BiophylotreesplitBuffer,
  f : Double,
) -> BiophylotreesplitBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitBuffer::add(
  self : BiophylotreesplitBuffer,
  other : BiophylotreesplitBuffer,
) -> BiophylotreesplitBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiophylotreesplitBuffer::copy(
  self : BiophylotreesplitBuffer,
) -> BiophylotreesplitBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitBuffer::fill(
  self : BiophylotreesplitBuffer,
  v : Double,
) -> BiophylotreesplitBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitBuffer::min(self : BiophylotreesplitBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiophylotreesplitBuffer::max(self : BiophylotreesplitBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiophylotreesplitBuffer::to_string(
  self : BiophylotreesplitBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiophylotreesplitCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_phylo_tree_split_cursor_make(
  size : Int32,
) -> BiophylotreesplitCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiophylotreesplitCursor::len(self : BiophylotreesplitCursor) -> Int32 {
  self.size
}

///|
pub fn BiophylotreesplitCursor::get(
  self : BiophylotreesplitCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiophylotreesplitCursor::set(
  self : BiophylotreesplitCursor,
  i : Int32,
  v : Double,
) -> BiophylotreesplitCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitCursor::sum(self : BiophylotreesplitCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiophylotreesplitCursor::mean(self : BiophylotreesplitCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiophylotreesplitCursor::scale(
  self : BiophylotreesplitCursor,
  f : Double,
) -> BiophylotreesplitCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitCursor::add(
  self : BiophylotreesplitCursor,
  other : BiophylotreesplitCursor,
) -> BiophylotreesplitCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiophylotreesplitCursor::copy(
  self : BiophylotreesplitCursor,
) -> BiophylotreesplitCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitCursor::fill(
  self : BiophylotreesplitCursor,
  v : Double,
) -> BiophylotreesplitCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitCursor::min(self : BiophylotreesplitCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiophylotreesplitCursor::max(self : BiophylotreesplitCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiophylotreesplitCursor::to_string(
  self : BiophylotreesplitCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiophylotreesplitView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_phylo_tree_split_view_make(size : Int32) -> BiophylotreesplitView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiophylotreesplitView::len(self : BiophylotreesplitView) -> Int32 {
  self.size
}

///|
pub fn BiophylotreesplitView::get(
  self : BiophylotreesplitView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiophylotreesplitView::set(
  self : BiophylotreesplitView,
  i : Int32,
  v : Double,
) -> BiophylotreesplitView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitView::sum(self : BiophylotreesplitView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiophylotreesplitView::mean(self : BiophylotreesplitView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiophylotreesplitView::scale(
  self : BiophylotreesplitView,
  f : Double,
) -> BiophylotreesplitView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitView::add(
  self : BiophylotreesplitView,
  other : BiophylotreesplitView,
) -> BiophylotreesplitView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiophylotreesplitView::copy(
  self : BiophylotreesplitView,
) -> BiophylotreesplitView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitView::fill(
  self : BiophylotreesplitView,
  v : Double,
) -> BiophylotreesplitView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitView::min(self : BiophylotreesplitView) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiophylotreesplitView::max(self : BiophylotreesplitView) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiophylotreesplitView::to_string(self : BiophylotreesplitView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiophylotreesplitRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_phylo_tree_split_range_make(size : Int32) -> BiophylotreesplitRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiophylotreesplitRange::len(self : BiophylotreesplitRange) -> Int32 {
  self.size
}

///|
pub fn BiophylotreesplitRange::get(
  self : BiophylotreesplitRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiophylotreesplitRange::set(
  self : BiophylotreesplitRange,
  i : Int32,
  v : Double,
) -> BiophylotreesplitRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitRange::sum(self : BiophylotreesplitRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiophylotreesplitRange::mean(self : BiophylotreesplitRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiophylotreesplitRange::scale(
  self : BiophylotreesplitRange,
  f : Double,
) -> BiophylotreesplitRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitRange::add(
  self : BiophylotreesplitRange,
  other : BiophylotreesplitRange,
) -> BiophylotreesplitRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiophylotreesplitRange::copy(
  self : BiophylotreesplitRange,
) -> BiophylotreesplitRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitRange::fill(
  self : BiophylotreesplitRange,
  v : Double,
) -> BiophylotreesplitRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitRange::min(self : BiophylotreesplitRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiophylotreesplitRange::max(self : BiophylotreesplitRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiophylotreesplitRange::to_string(
  self : BiophylotreesplitRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiophylotreesplitSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_phylo_tree_split_slice_make(size : Int32) -> BiophylotreesplitSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiophylotreesplitSlice::len(self : BiophylotreesplitSlice) -> Int32 {
  self.size
}

///|
pub fn BiophylotreesplitSlice::get(
  self : BiophylotreesplitSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiophylotreesplitSlice::set(
  self : BiophylotreesplitSlice,
  i : Int32,
  v : Double,
) -> BiophylotreesplitSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitSlice::sum(self : BiophylotreesplitSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiophylotreesplitSlice::mean(self : BiophylotreesplitSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiophylotreesplitSlice::scale(
  self : BiophylotreesplitSlice,
  f : Double,
) -> BiophylotreesplitSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitSlice::add(
  self : BiophylotreesplitSlice,
  other : BiophylotreesplitSlice,
) -> BiophylotreesplitSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiophylotreesplitSlice::copy(
  self : BiophylotreesplitSlice,
) -> BiophylotreesplitSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitSlice::fill(
  self : BiophylotreesplitSlice,
  v : Double,
) -> BiophylotreesplitSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiophylotreesplitSlice::min(self : BiophylotreesplitSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiophylotreesplitSlice::max(self : BiophylotreesplitSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiophylotreesplitSlice::to_string(
  self : BiophylotreesplitSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
