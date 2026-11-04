///|
///===
/// extcore/bio_struct_domain
pub(all) struct BiostructdomainPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn bio_struct_domain_make_point(
  x : Double,
  y : Double,
) -> BiostructdomainPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn bio_struct_domain_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> BiostructdomainPoint {
  { x, y, z, label: 0, }
}

///|
pub fn BiostructdomainPoint::x(self : BiostructdomainPoint) -> Double {
  self.x
}

///|
pub fn BiostructdomainPoint::y(self : BiostructdomainPoint) -> Double {
  self.y
}

///|
pub fn BiostructdomainPoint::z(self : BiostructdomainPoint) -> Double {
  self.z
}

///|
pub fn BiostructdomainPoint::label(self : BiostructdomainPoint) -> Int32 {
  self.label
}

///|
pub fn BiostructdomainPoint::dist(
  self : BiostructdomainPoint,
  other : BiostructdomainPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn BiostructdomainPoint::add(
  self : BiostructdomainPoint,
  other : BiostructdomainPoint,
) -> BiostructdomainPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn BiostructdomainPoint::sub(
  self : BiostructdomainPoint,
  other : BiostructdomainPoint,
) -> BiostructdomainPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn BiostructdomainPoint::scale(
  self : BiostructdomainPoint,
  s : Double,
) -> BiostructdomainPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn BiostructdomainPoint::dot(
  self : BiostructdomainPoint,
  other : BiostructdomainPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn BiostructdomainPoint::cross(
  self : BiostructdomainPoint,
  other : BiostructdomainPoint,
) -> BiostructdomainPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn BiostructdomainPoint::norm(self : BiostructdomainPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn BiostructdomainPoint::normalize(
  self : BiostructdomainPoint,
) -> BiostructdomainPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn BiostructdomainPoint::negate(
  self : BiostructdomainPoint,
) -> BiostructdomainPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn BiostructdomainPoint::mid(
  self : BiostructdomainPoint,
  other : BiostructdomainPoint,
) -> BiostructdomainPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn BiostructdomainPoint::lerp(
  self : BiostructdomainPoint,
  other : BiostructdomainPoint,
  t : Double,
) -> BiostructdomainPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn BiostructdomainPoint::to_string(self : BiostructdomainPoint) -> String {
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
pub(all) struct BiostructdomainSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn bio_struct_domain_make_series(
  vals : Array[Double],
  name : String,
) -> BiostructdomainSeries {
  { vals, name, meta: 0, }
}

///|
pub fn BiostructdomainSeries::len(self : BiostructdomainSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn BiostructdomainSeries::sum(self : BiostructdomainSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn BiostructdomainSeries::mean(self : BiostructdomainSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn BiostructdomainSeries::min(self : BiostructdomainSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn BiostructdomainSeries::max(self : BiostructdomainSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn BiostructdomainSeries::range(self : BiostructdomainSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn BiostructdomainSeries::variance(self : BiostructdomainSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn BiostructdomainSeries::std(self : BiostructdomainSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn BiostructdomainSeries::median(self : BiostructdomainSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn BiostructdomainSeries::scale(
  self : BiostructdomainSeries,
  f : Double,
) -> BiostructdomainSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn BiostructdomainSeries::add(
  self : BiostructdomainSeries,
  other : BiostructdomainSeries,
) -> BiostructdomainSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn BiostructdomainSeries::sub(
  self : BiostructdomainSeries,
  other : BiostructdomainSeries,
) -> BiostructdomainSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn BiostructdomainSeries::normalize(
  self : BiostructdomainSeries,
) -> BiostructdomainSeries {
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
pub fn BiostructdomainSeries::cumsum(
  self : BiostructdomainSeries,
) -> BiostructdomainSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn BiostructdomainSeries::to_string(self : BiostructdomainSeries) -> String {
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
pub(all) struct BiostructdomainMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn bio_struct_domain_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> BiostructdomainMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn bio_struct_domain_matrix_identity(n : Int32) -> BiostructdomainMatrix {
  let m = bio_struct_domain_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn BiostructdomainMatrix::get(
  self : BiostructdomainMatrix,
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
pub fn BiostructdomainMatrix::transpose(
  self : BiostructdomainMatrix,
) -> BiostructdomainMatrix {
  let result = bio_struct_domain_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn BiostructdomainMatrix::add(
  self : BiostructdomainMatrix,
  other : BiostructdomainMatrix,
) -> BiostructdomainMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = bio_struct_domain_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn BiostructdomainMatrix::scale(
  self : BiostructdomainMatrix,
  s : Double,
) -> BiostructdomainMatrix {
  let result = bio_struct_domain_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn BiostructdomainMatrix::multiply(
  self : BiostructdomainMatrix,
  other : BiostructdomainMatrix,
) -> BiostructdomainMatrix {
  if self.cols != other.rows {
    return bio_struct_domain_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = bio_struct_domain_make_matrix(self.rows, other.cols, 0.0)
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
pub fn BiostructdomainMatrix::trace(self : BiostructdomainMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn BiostructdomainMatrix::det(self : BiostructdomainMatrix) -> Double {
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
pub fn BiostructdomainMatrix::norm(self : BiostructdomainMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn BiostructdomainMatrix::to_string(self : BiostructdomainMatrix) -> String {
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
pub(all) struct BiostructdomainVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn bio_struct_domain_make_vector(
  comps : Array[Double],
) -> BiostructdomainVector {
  { comps, dim: comps.length(), }
}

///|
pub fn bio_struct_domain_vector_zero(dim : Int32) -> BiostructdomainVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn BiostructdomainVector::add(
  self : BiostructdomainVector,
  other : BiostructdomainVector,
) -> BiostructdomainVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn BiostructdomainVector::sub(
  self : BiostructdomainVector,
  other : BiostructdomainVector,
) -> BiostructdomainVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn BiostructdomainVector::scale(
  self : BiostructdomainVector,
  s : Double,
) -> BiostructdomainVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn BiostructdomainVector::dot(
  self : BiostructdomainVector,
  other : BiostructdomainVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn BiostructdomainVector::norm(self : BiostructdomainVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn BiostructdomainVector::normalize(
  self : BiostructdomainVector,
) -> BiostructdomainVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn BiostructdomainVector::dist(
  self : BiostructdomainVector,
  other : BiostructdomainVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn BiostructdomainVector::to_string(self : BiostructdomainVector) -> String {
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
pub(all) struct BiostructdomainFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_struct_domain_frame_make(size : Int32) -> BiostructdomainFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiostructdomainFrame::len(self : BiostructdomainFrame) -> Int32 {
  self.size
}

///|
pub fn BiostructdomainFrame::get(
  self : BiostructdomainFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiostructdomainFrame::set(
  self : BiostructdomainFrame,
  i : Int32,
  v : Double,
) -> BiostructdomainFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainFrame::sum(self : BiostructdomainFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiostructdomainFrame::mean(self : BiostructdomainFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiostructdomainFrame::scale(
  self : BiostructdomainFrame,
  f : Double,
) -> BiostructdomainFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainFrame::add(
  self : BiostructdomainFrame,
  other : BiostructdomainFrame,
) -> BiostructdomainFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiostructdomainFrame::copy(
  self : BiostructdomainFrame,
) -> BiostructdomainFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainFrame::fill(
  self : BiostructdomainFrame,
  v : Double,
) -> BiostructdomainFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainFrame::min(self : BiostructdomainFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiostructdomainFrame::max(self : BiostructdomainFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiostructdomainFrame::to_string(self : BiostructdomainFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiostructdomainTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_struct_domain_table_make(size : Int32) -> BiostructdomainTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiostructdomainTable::len(self : BiostructdomainTable) -> Int32 {
  self.size
}

///|
pub fn BiostructdomainTable::get(
  self : BiostructdomainTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiostructdomainTable::set(
  self : BiostructdomainTable,
  i : Int32,
  v : Double,
) -> BiostructdomainTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainTable::sum(self : BiostructdomainTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiostructdomainTable::mean(self : BiostructdomainTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiostructdomainTable::scale(
  self : BiostructdomainTable,
  f : Double,
) -> BiostructdomainTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainTable::add(
  self : BiostructdomainTable,
  other : BiostructdomainTable,
) -> BiostructdomainTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiostructdomainTable::copy(
  self : BiostructdomainTable,
) -> BiostructdomainTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainTable::fill(
  self : BiostructdomainTable,
  v : Double,
) -> BiostructdomainTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainTable::min(self : BiostructdomainTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiostructdomainTable::max(self : BiostructdomainTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiostructdomainTable::to_string(self : BiostructdomainTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiostructdomainGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_struct_domain_graphn_make(size : Int32) -> BiostructdomainGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiostructdomainGraphN::len(self : BiostructdomainGraphN) -> Int32 {
  self.size
}

///|
pub fn BiostructdomainGraphN::get(
  self : BiostructdomainGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiostructdomainGraphN::set(
  self : BiostructdomainGraphN,
  i : Int32,
  v : Double,
) -> BiostructdomainGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainGraphN::sum(self : BiostructdomainGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiostructdomainGraphN::mean(self : BiostructdomainGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiostructdomainGraphN::scale(
  self : BiostructdomainGraphN,
  f : Double,
) -> BiostructdomainGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainGraphN::add(
  self : BiostructdomainGraphN,
  other : BiostructdomainGraphN,
) -> BiostructdomainGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiostructdomainGraphN::copy(
  self : BiostructdomainGraphN,
) -> BiostructdomainGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainGraphN::fill(
  self : BiostructdomainGraphN,
  v : Double,
) -> BiostructdomainGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainGraphN::min(self : BiostructdomainGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiostructdomainGraphN::max(self : BiostructdomainGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiostructdomainGraphN::to_string(self : BiostructdomainGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiostructdomainNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_struct_domain_node_make(size : Int32) -> BiostructdomainNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiostructdomainNode::len(self : BiostructdomainNode) -> Int32 {
  self.size
}

///|
pub fn BiostructdomainNode::get(
  self : BiostructdomainNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiostructdomainNode::set(
  self : BiostructdomainNode,
  i : Int32,
  v : Double,
) -> BiostructdomainNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainNode::sum(self : BiostructdomainNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiostructdomainNode::mean(self : BiostructdomainNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiostructdomainNode::scale(
  self : BiostructdomainNode,
  f : Double,
) -> BiostructdomainNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainNode::add(
  self : BiostructdomainNode,
  other : BiostructdomainNode,
) -> BiostructdomainNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiostructdomainNode::copy(
  self : BiostructdomainNode,
) -> BiostructdomainNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainNode::fill(
  self : BiostructdomainNode,
  v : Double,
) -> BiostructdomainNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainNode::min(self : BiostructdomainNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiostructdomainNode::max(self : BiostructdomainNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiostructdomainNode::to_string(self : BiostructdomainNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiostructdomainEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_struct_domain_edge_make(size : Int32) -> BiostructdomainEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiostructdomainEdge::len(self : BiostructdomainEdge) -> Int32 {
  self.size
}

///|
pub fn BiostructdomainEdge::get(
  self : BiostructdomainEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiostructdomainEdge::set(
  self : BiostructdomainEdge,
  i : Int32,
  v : Double,
) -> BiostructdomainEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainEdge::sum(self : BiostructdomainEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiostructdomainEdge::mean(self : BiostructdomainEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiostructdomainEdge::scale(
  self : BiostructdomainEdge,
  f : Double,
) -> BiostructdomainEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainEdge::add(
  self : BiostructdomainEdge,
  other : BiostructdomainEdge,
) -> BiostructdomainEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiostructdomainEdge::copy(
  self : BiostructdomainEdge,
) -> BiostructdomainEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainEdge::fill(
  self : BiostructdomainEdge,
  v : Double,
) -> BiostructdomainEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainEdge::min(self : BiostructdomainEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiostructdomainEdge::max(self : BiostructdomainEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiostructdomainEdge::to_string(self : BiostructdomainEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiostructdomainPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_struct_domain_path_make(size : Int32) -> BiostructdomainPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiostructdomainPath::len(self : BiostructdomainPath) -> Int32 {
  self.size
}

///|
pub fn BiostructdomainPath::get(
  self : BiostructdomainPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiostructdomainPath::set(
  self : BiostructdomainPath,
  i : Int32,
  v : Double,
) -> BiostructdomainPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainPath::sum(self : BiostructdomainPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiostructdomainPath::mean(self : BiostructdomainPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiostructdomainPath::scale(
  self : BiostructdomainPath,
  f : Double,
) -> BiostructdomainPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainPath::add(
  self : BiostructdomainPath,
  other : BiostructdomainPath,
) -> BiostructdomainPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiostructdomainPath::copy(
  self : BiostructdomainPath,
) -> BiostructdomainPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainPath::fill(
  self : BiostructdomainPath,
  v : Double,
) -> BiostructdomainPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainPath::min(self : BiostructdomainPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiostructdomainPath::max(self : BiostructdomainPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiostructdomainPath::to_string(self : BiostructdomainPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiostructdomainCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_struct_domain_cluster_make(size : Int32) -> BiostructdomainCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiostructdomainCluster::len(self : BiostructdomainCluster) -> Int32 {
  self.size
}

///|
pub fn BiostructdomainCluster::get(
  self : BiostructdomainCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiostructdomainCluster::set(
  self : BiostructdomainCluster,
  i : Int32,
  v : Double,
) -> BiostructdomainCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainCluster::sum(self : BiostructdomainCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiostructdomainCluster::mean(self : BiostructdomainCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiostructdomainCluster::scale(
  self : BiostructdomainCluster,
  f : Double,
) -> BiostructdomainCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainCluster::add(
  self : BiostructdomainCluster,
  other : BiostructdomainCluster,
) -> BiostructdomainCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiostructdomainCluster::copy(
  self : BiostructdomainCluster,
) -> BiostructdomainCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainCluster::fill(
  self : BiostructdomainCluster,
  v : Double,
) -> BiostructdomainCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainCluster::min(self : BiostructdomainCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiostructdomainCluster::max(self : BiostructdomainCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiostructdomainCluster::to_string(
  self : BiostructdomainCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiostructdomainModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_struct_domain_model_make(size : Int32) -> BiostructdomainModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiostructdomainModel::len(self : BiostructdomainModel) -> Int32 {
  self.size
}

///|
pub fn BiostructdomainModel::get(
  self : BiostructdomainModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiostructdomainModel::set(
  self : BiostructdomainModel,
  i : Int32,
  v : Double,
) -> BiostructdomainModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainModel::sum(self : BiostructdomainModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiostructdomainModel::mean(self : BiostructdomainModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiostructdomainModel::scale(
  self : BiostructdomainModel,
  f : Double,
) -> BiostructdomainModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainModel::add(
  self : BiostructdomainModel,
  other : BiostructdomainModel,
) -> BiostructdomainModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiostructdomainModel::copy(
  self : BiostructdomainModel,
) -> BiostructdomainModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainModel::fill(
  self : BiostructdomainModel,
  v : Double,
) -> BiostructdomainModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainModel::min(self : BiostructdomainModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiostructdomainModel::max(self : BiostructdomainModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiostructdomainModel::to_string(self : BiostructdomainModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiostructdomainLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_struct_domain_layer_make(size : Int32) -> BiostructdomainLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiostructdomainLayer::len(self : BiostructdomainLayer) -> Int32 {
  self.size
}

///|
pub fn BiostructdomainLayer::get(
  self : BiostructdomainLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiostructdomainLayer::set(
  self : BiostructdomainLayer,
  i : Int32,
  v : Double,
) -> BiostructdomainLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainLayer::sum(self : BiostructdomainLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiostructdomainLayer::mean(self : BiostructdomainLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiostructdomainLayer::scale(
  self : BiostructdomainLayer,
  f : Double,
) -> BiostructdomainLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainLayer::add(
  self : BiostructdomainLayer,
  other : BiostructdomainLayer,
) -> BiostructdomainLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiostructdomainLayer::copy(
  self : BiostructdomainLayer,
) -> BiostructdomainLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainLayer::fill(
  self : BiostructdomainLayer,
  v : Double,
) -> BiostructdomainLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainLayer::min(self : BiostructdomainLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiostructdomainLayer::max(self : BiostructdomainLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiostructdomainLayer::to_string(self : BiostructdomainLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiostructdomainBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_struct_domain_buffer_make(size : Int32) -> BiostructdomainBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiostructdomainBuffer::len(self : BiostructdomainBuffer) -> Int32 {
  self.size
}

///|
pub fn BiostructdomainBuffer::get(
  self : BiostructdomainBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiostructdomainBuffer::set(
  self : BiostructdomainBuffer,
  i : Int32,
  v : Double,
) -> BiostructdomainBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainBuffer::sum(self : BiostructdomainBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiostructdomainBuffer::mean(self : BiostructdomainBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiostructdomainBuffer::scale(
  self : BiostructdomainBuffer,
  f : Double,
) -> BiostructdomainBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainBuffer::add(
  self : BiostructdomainBuffer,
  other : BiostructdomainBuffer,
) -> BiostructdomainBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiostructdomainBuffer::copy(
  self : BiostructdomainBuffer,
) -> BiostructdomainBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainBuffer::fill(
  self : BiostructdomainBuffer,
  v : Double,
) -> BiostructdomainBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainBuffer::min(self : BiostructdomainBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiostructdomainBuffer::max(self : BiostructdomainBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiostructdomainBuffer::to_string(self : BiostructdomainBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiostructdomainCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_struct_domain_cursor_make(size : Int32) -> BiostructdomainCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiostructdomainCursor::len(self : BiostructdomainCursor) -> Int32 {
  self.size
}

///|
pub fn BiostructdomainCursor::get(
  self : BiostructdomainCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiostructdomainCursor::set(
  self : BiostructdomainCursor,
  i : Int32,
  v : Double,
) -> BiostructdomainCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainCursor::sum(self : BiostructdomainCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiostructdomainCursor::mean(self : BiostructdomainCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiostructdomainCursor::scale(
  self : BiostructdomainCursor,
  f : Double,
) -> BiostructdomainCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainCursor::add(
  self : BiostructdomainCursor,
  other : BiostructdomainCursor,
) -> BiostructdomainCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiostructdomainCursor::copy(
  self : BiostructdomainCursor,
) -> BiostructdomainCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainCursor::fill(
  self : BiostructdomainCursor,
  v : Double,
) -> BiostructdomainCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainCursor::min(self : BiostructdomainCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiostructdomainCursor::max(self : BiostructdomainCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiostructdomainCursor::to_string(self : BiostructdomainCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiostructdomainView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_struct_domain_view_make(size : Int32) -> BiostructdomainView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiostructdomainView::len(self : BiostructdomainView) -> Int32 {
  self.size
}

///|
pub fn BiostructdomainView::get(
  self : BiostructdomainView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiostructdomainView::set(
  self : BiostructdomainView,
  i : Int32,
  v : Double,
) -> BiostructdomainView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainView::sum(self : BiostructdomainView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiostructdomainView::mean(self : BiostructdomainView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiostructdomainView::scale(
  self : BiostructdomainView,
  f : Double,
) -> BiostructdomainView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainView::add(
  self : BiostructdomainView,
  other : BiostructdomainView,
) -> BiostructdomainView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiostructdomainView::copy(
  self : BiostructdomainView,
) -> BiostructdomainView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainView::fill(
  self : BiostructdomainView,
  v : Double,
) -> BiostructdomainView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainView::min(self : BiostructdomainView) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiostructdomainView::max(self : BiostructdomainView) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiostructdomainView::to_string(self : BiostructdomainView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiostructdomainRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_struct_domain_range_make(size : Int32) -> BiostructdomainRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiostructdomainRange::len(self : BiostructdomainRange) -> Int32 {
  self.size
}

///|
pub fn BiostructdomainRange::get(
  self : BiostructdomainRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiostructdomainRange::set(
  self : BiostructdomainRange,
  i : Int32,
  v : Double,
) -> BiostructdomainRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainRange::sum(self : BiostructdomainRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiostructdomainRange::mean(self : BiostructdomainRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiostructdomainRange::scale(
  self : BiostructdomainRange,
  f : Double,
) -> BiostructdomainRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainRange::add(
  self : BiostructdomainRange,
  other : BiostructdomainRange,
) -> BiostructdomainRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiostructdomainRange::copy(
  self : BiostructdomainRange,
) -> BiostructdomainRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainRange::fill(
  self : BiostructdomainRange,
  v : Double,
) -> BiostructdomainRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainRange::min(self : BiostructdomainRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiostructdomainRange::max(self : BiostructdomainRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiostructdomainRange::to_string(self : BiostructdomainRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiostructdomainSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_struct_domain_slice_make(size : Int32) -> BiostructdomainSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiostructdomainSlice::len(self : BiostructdomainSlice) -> Int32 {
  self.size
}

///|
pub fn BiostructdomainSlice::get(
  self : BiostructdomainSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiostructdomainSlice::set(
  self : BiostructdomainSlice,
  i : Int32,
  v : Double,
) -> BiostructdomainSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainSlice::sum(self : BiostructdomainSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiostructdomainSlice::mean(self : BiostructdomainSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiostructdomainSlice::scale(
  self : BiostructdomainSlice,
  f : Double,
) -> BiostructdomainSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainSlice::add(
  self : BiostructdomainSlice,
  other : BiostructdomainSlice,
) -> BiostructdomainSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiostructdomainSlice::copy(
  self : BiostructdomainSlice,
) -> BiostructdomainSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainSlice::fill(
  self : BiostructdomainSlice,
  v : Double,
) -> BiostructdomainSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructdomainSlice::min(self : BiostructdomainSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiostructdomainSlice::max(self : BiostructdomainSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiostructdomainSlice::to_string(self : BiostructdomainSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
