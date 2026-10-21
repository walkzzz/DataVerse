///|
///===
/// extcore/db_tx_2pc
pub(all) struct Dbtx2pcPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn db_tx_2pc_make_point(x : Double, y : Double) -> Dbtx2pcPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn db_tx_2pc_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> Dbtx2pcPoint {
  { x, y, z, label: 0, }
}

///|
pub fn Dbtx2pcPoint::x(self : Dbtx2pcPoint) -> Double {
  self.x
}

///|
pub fn Dbtx2pcPoint::y(self : Dbtx2pcPoint) -> Double {
  self.y
}

///|
pub fn Dbtx2pcPoint::z(self : Dbtx2pcPoint) -> Double {
  self.z
}

///|
pub fn Dbtx2pcPoint::label(self : Dbtx2pcPoint) -> Int32 {
  self.label
}

///|
pub fn Dbtx2pcPoint::dist(self : Dbtx2pcPoint, other : Dbtx2pcPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn Dbtx2pcPoint::add(
  self : Dbtx2pcPoint,
  other : Dbtx2pcPoint,
) -> Dbtx2pcPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn Dbtx2pcPoint::sub(
  self : Dbtx2pcPoint,
  other : Dbtx2pcPoint,
) -> Dbtx2pcPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn Dbtx2pcPoint::scale(self : Dbtx2pcPoint, s : Double) -> Dbtx2pcPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn Dbtx2pcPoint::dot(self : Dbtx2pcPoint, other : Dbtx2pcPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn Dbtx2pcPoint::cross(
  self : Dbtx2pcPoint,
  other : Dbtx2pcPoint,
) -> Dbtx2pcPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn Dbtx2pcPoint::norm(self : Dbtx2pcPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn Dbtx2pcPoint::normalize(self : Dbtx2pcPoint) -> Dbtx2pcPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn Dbtx2pcPoint::negate(self : Dbtx2pcPoint) -> Dbtx2pcPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn Dbtx2pcPoint::mid(
  self : Dbtx2pcPoint,
  other : Dbtx2pcPoint,
) -> Dbtx2pcPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn Dbtx2pcPoint::lerp(
  self : Dbtx2pcPoint,
  other : Dbtx2pcPoint,
  t : Double,
) -> Dbtx2pcPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn Dbtx2pcPoint::to_string(self : Dbtx2pcPoint) -> String {
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
pub(all) struct Dbtx2pcSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn db_tx_2pc_make_series(
  vals : Array[Double],
  name : String,
) -> Dbtx2pcSeries {
  { vals, name, meta: 0, }
}

///|
pub fn Dbtx2pcSeries::len(self : Dbtx2pcSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn Dbtx2pcSeries::sum(self : Dbtx2pcSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn Dbtx2pcSeries::mean(self : Dbtx2pcSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn Dbtx2pcSeries::min(self : Dbtx2pcSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn Dbtx2pcSeries::max(self : Dbtx2pcSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn Dbtx2pcSeries::range(self : Dbtx2pcSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn Dbtx2pcSeries::variance(self : Dbtx2pcSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn Dbtx2pcSeries::std(self : Dbtx2pcSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn Dbtx2pcSeries::median(self : Dbtx2pcSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn Dbtx2pcSeries::scale(self : Dbtx2pcSeries, f : Double) -> Dbtx2pcSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn Dbtx2pcSeries::add(
  self : Dbtx2pcSeries,
  other : Dbtx2pcSeries,
) -> Dbtx2pcSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn Dbtx2pcSeries::sub(
  self : Dbtx2pcSeries,
  other : Dbtx2pcSeries,
) -> Dbtx2pcSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn Dbtx2pcSeries::normalize(self : Dbtx2pcSeries) -> Dbtx2pcSeries {
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
pub fn Dbtx2pcSeries::cumsum(self : Dbtx2pcSeries) -> Dbtx2pcSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn Dbtx2pcSeries::to_string(self : Dbtx2pcSeries) -> String {
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
pub(all) struct Dbtx2pcMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn db_tx_2pc_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> Dbtx2pcMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn db_tx_2pc_matrix_identity(n : Int32) -> Dbtx2pcMatrix {
  let m = db_tx_2pc_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn Dbtx2pcMatrix::get(self : Dbtx2pcMatrix, i : Int32, j : Int32) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols {
    0.0
  } else {
    self.data[i][j]
  }
}

///|
pub fn Dbtx2pcMatrix::transpose(self : Dbtx2pcMatrix) -> Dbtx2pcMatrix {
  let result = db_tx_2pc_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn Dbtx2pcMatrix::add(
  self : Dbtx2pcMatrix,
  other : Dbtx2pcMatrix,
) -> Dbtx2pcMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = db_tx_2pc_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn Dbtx2pcMatrix::scale(self : Dbtx2pcMatrix, s : Double) -> Dbtx2pcMatrix {
  let result = db_tx_2pc_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn Dbtx2pcMatrix::multiply(
  self : Dbtx2pcMatrix,
  other : Dbtx2pcMatrix,
) -> Dbtx2pcMatrix {
  if self.cols != other.rows {
    return db_tx_2pc_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = db_tx_2pc_make_matrix(self.rows, other.cols, 0.0)
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
pub fn Dbtx2pcMatrix::trace(self : Dbtx2pcMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn Dbtx2pcMatrix::det(self : Dbtx2pcMatrix) -> Double {
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
pub fn Dbtx2pcMatrix::norm(self : Dbtx2pcMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn Dbtx2pcMatrix::to_string(self : Dbtx2pcMatrix) -> String {
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
pub(all) struct Dbtx2pcVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn db_tx_2pc_make_vector(comps : Array[Double]) -> Dbtx2pcVector {
  { comps, dim: comps.length(), }
}

///|
pub fn db_tx_2pc_vector_zero(dim : Int32) -> Dbtx2pcVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn Dbtx2pcVector::add(
  self : Dbtx2pcVector,
  other : Dbtx2pcVector,
) -> Dbtx2pcVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn Dbtx2pcVector::sub(
  self : Dbtx2pcVector,
  other : Dbtx2pcVector,
) -> Dbtx2pcVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn Dbtx2pcVector::scale(self : Dbtx2pcVector, s : Double) -> Dbtx2pcVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn Dbtx2pcVector::dot(
  self : Dbtx2pcVector,
  other : Dbtx2pcVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn Dbtx2pcVector::norm(self : Dbtx2pcVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn Dbtx2pcVector::normalize(self : Dbtx2pcVector) -> Dbtx2pcVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn Dbtx2pcVector::dist(
  self : Dbtx2pcVector,
  other : Dbtx2pcVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn Dbtx2pcVector::to_string(self : Dbtx2pcVector) -> String {
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
pub(all) struct Dbtx2pcFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_tx_2pc_frame_make(size : Int32) -> Dbtx2pcFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Dbtx2pcFrame::len(self : Dbtx2pcFrame) -> Int32 {
  self.size
}

///|
pub fn Dbtx2pcFrame::get(self : Dbtx2pcFrame, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Dbtx2pcFrame::set(
  self : Dbtx2pcFrame,
  i : Int32,
  v : Double,
) -> Dbtx2pcFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcFrame::sum(self : Dbtx2pcFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Dbtx2pcFrame::mean(self : Dbtx2pcFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Dbtx2pcFrame::scale(self : Dbtx2pcFrame, f : Double) -> Dbtx2pcFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcFrame::add(
  self : Dbtx2pcFrame,
  other : Dbtx2pcFrame,
) -> Dbtx2pcFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Dbtx2pcFrame::copy(self : Dbtx2pcFrame) -> Dbtx2pcFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcFrame::fill(self : Dbtx2pcFrame, v : Double) -> Dbtx2pcFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcFrame::min(self : Dbtx2pcFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn Dbtx2pcFrame::max(self : Dbtx2pcFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn Dbtx2pcFrame::to_string(self : Dbtx2pcFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Dbtx2pcTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_tx_2pc_table_make(size : Int32) -> Dbtx2pcTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Dbtx2pcTable::len(self : Dbtx2pcTable) -> Int32 {
  self.size
}

///|
pub fn Dbtx2pcTable::get(self : Dbtx2pcTable, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Dbtx2pcTable::set(
  self : Dbtx2pcTable,
  i : Int32,
  v : Double,
) -> Dbtx2pcTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcTable::sum(self : Dbtx2pcTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Dbtx2pcTable::mean(self : Dbtx2pcTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Dbtx2pcTable::scale(self : Dbtx2pcTable, f : Double) -> Dbtx2pcTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcTable::add(
  self : Dbtx2pcTable,
  other : Dbtx2pcTable,
) -> Dbtx2pcTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Dbtx2pcTable::copy(self : Dbtx2pcTable) -> Dbtx2pcTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcTable::fill(self : Dbtx2pcTable, v : Double) -> Dbtx2pcTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcTable::min(self : Dbtx2pcTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn Dbtx2pcTable::max(self : Dbtx2pcTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn Dbtx2pcTable::to_string(self : Dbtx2pcTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Dbtx2pcGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_tx_2pc_graphn_make(size : Int32) -> Dbtx2pcGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Dbtx2pcGraphN::len(self : Dbtx2pcGraphN) -> Int32 {
  self.size
}

///|
pub fn Dbtx2pcGraphN::get(self : Dbtx2pcGraphN, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Dbtx2pcGraphN::set(
  self : Dbtx2pcGraphN,
  i : Int32,
  v : Double,
) -> Dbtx2pcGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcGraphN::sum(self : Dbtx2pcGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Dbtx2pcGraphN::mean(self : Dbtx2pcGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Dbtx2pcGraphN::scale(self : Dbtx2pcGraphN, f : Double) -> Dbtx2pcGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcGraphN::add(
  self : Dbtx2pcGraphN,
  other : Dbtx2pcGraphN,
) -> Dbtx2pcGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Dbtx2pcGraphN::copy(self : Dbtx2pcGraphN) -> Dbtx2pcGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcGraphN::fill(self : Dbtx2pcGraphN, v : Double) -> Dbtx2pcGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcGraphN::min(self : Dbtx2pcGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn Dbtx2pcGraphN::max(self : Dbtx2pcGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn Dbtx2pcGraphN::to_string(self : Dbtx2pcGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Dbtx2pcNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_tx_2pc_node_make(size : Int32) -> Dbtx2pcNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Dbtx2pcNode::len(self : Dbtx2pcNode) -> Int32 {
  self.size
}

///|
pub fn Dbtx2pcNode::get(self : Dbtx2pcNode, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Dbtx2pcNode::set(
  self : Dbtx2pcNode,
  i : Int32,
  v : Double,
) -> Dbtx2pcNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcNode::sum(self : Dbtx2pcNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Dbtx2pcNode::mean(self : Dbtx2pcNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Dbtx2pcNode::scale(self : Dbtx2pcNode, f : Double) -> Dbtx2pcNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcNode::add(self : Dbtx2pcNode, other : Dbtx2pcNode) -> Dbtx2pcNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Dbtx2pcNode::copy(self : Dbtx2pcNode) -> Dbtx2pcNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcNode::fill(self : Dbtx2pcNode, v : Double) -> Dbtx2pcNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcNode::min(self : Dbtx2pcNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn Dbtx2pcNode::max(self : Dbtx2pcNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn Dbtx2pcNode::to_string(self : Dbtx2pcNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Dbtx2pcEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_tx_2pc_edge_make(size : Int32) -> Dbtx2pcEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Dbtx2pcEdge::len(self : Dbtx2pcEdge) -> Int32 {
  self.size
}

///|
pub fn Dbtx2pcEdge::get(self : Dbtx2pcEdge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Dbtx2pcEdge::set(
  self : Dbtx2pcEdge,
  i : Int32,
  v : Double,
) -> Dbtx2pcEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcEdge::sum(self : Dbtx2pcEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Dbtx2pcEdge::mean(self : Dbtx2pcEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Dbtx2pcEdge::scale(self : Dbtx2pcEdge, f : Double) -> Dbtx2pcEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcEdge::add(self : Dbtx2pcEdge, other : Dbtx2pcEdge) -> Dbtx2pcEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Dbtx2pcEdge::copy(self : Dbtx2pcEdge) -> Dbtx2pcEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcEdge::fill(self : Dbtx2pcEdge, v : Double) -> Dbtx2pcEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcEdge::min(self : Dbtx2pcEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn Dbtx2pcEdge::max(self : Dbtx2pcEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn Dbtx2pcEdge::to_string(self : Dbtx2pcEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Dbtx2pcPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_tx_2pc_path_make(size : Int32) -> Dbtx2pcPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Dbtx2pcPath::len(self : Dbtx2pcPath) -> Int32 {
  self.size
}

///|
pub fn Dbtx2pcPath::get(self : Dbtx2pcPath, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Dbtx2pcPath::set(
  self : Dbtx2pcPath,
  i : Int32,
  v : Double,
) -> Dbtx2pcPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcPath::sum(self : Dbtx2pcPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Dbtx2pcPath::mean(self : Dbtx2pcPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Dbtx2pcPath::scale(self : Dbtx2pcPath, f : Double) -> Dbtx2pcPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcPath::add(self : Dbtx2pcPath, other : Dbtx2pcPath) -> Dbtx2pcPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Dbtx2pcPath::copy(self : Dbtx2pcPath) -> Dbtx2pcPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcPath::fill(self : Dbtx2pcPath, v : Double) -> Dbtx2pcPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcPath::min(self : Dbtx2pcPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn Dbtx2pcPath::max(self : Dbtx2pcPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn Dbtx2pcPath::to_string(self : Dbtx2pcPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Dbtx2pcCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_tx_2pc_cluster_make(size : Int32) -> Dbtx2pcCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Dbtx2pcCluster::len(self : Dbtx2pcCluster) -> Int32 {
  self.size
}

///|
pub fn Dbtx2pcCluster::get(self : Dbtx2pcCluster, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Dbtx2pcCluster::set(
  self : Dbtx2pcCluster,
  i : Int32,
  v : Double,
) -> Dbtx2pcCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcCluster::sum(self : Dbtx2pcCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Dbtx2pcCluster::mean(self : Dbtx2pcCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Dbtx2pcCluster::scale(
  self : Dbtx2pcCluster,
  f : Double,
) -> Dbtx2pcCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcCluster::add(
  self : Dbtx2pcCluster,
  other : Dbtx2pcCluster,
) -> Dbtx2pcCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Dbtx2pcCluster::copy(self : Dbtx2pcCluster) -> Dbtx2pcCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcCluster::fill(
  self : Dbtx2pcCluster,
  v : Double,
) -> Dbtx2pcCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcCluster::min(self : Dbtx2pcCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn Dbtx2pcCluster::max(self : Dbtx2pcCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn Dbtx2pcCluster::to_string(self : Dbtx2pcCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Dbtx2pcModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_tx_2pc_model_make(size : Int32) -> Dbtx2pcModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Dbtx2pcModel::len(self : Dbtx2pcModel) -> Int32 {
  self.size
}

///|
pub fn Dbtx2pcModel::get(self : Dbtx2pcModel, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Dbtx2pcModel::set(
  self : Dbtx2pcModel,
  i : Int32,
  v : Double,
) -> Dbtx2pcModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcModel::sum(self : Dbtx2pcModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Dbtx2pcModel::mean(self : Dbtx2pcModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Dbtx2pcModel::scale(self : Dbtx2pcModel, f : Double) -> Dbtx2pcModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcModel::add(
  self : Dbtx2pcModel,
  other : Dbtx2pcModel,
) -> Dbtx2pcModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Dbtx2pcModel::copy(self : Dbtx2pcModel) -> Dbtx2pcModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcModel::fill(self : Dbtx2pcModel, v : Double) -> Dbtx2pcModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcModel::min(self : Dbtx2pcModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn Dbtx2pcModel::max(self : Dbtx2pcModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn Dbtx2pcModel::to_string(self : Dbtx2pcModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Dbtx2pcLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_tx_2pc_layer_make(size : Int32) -> Dbtx2pcLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Dbtx2pcLayer::len(self : Dbtx2pcLayer) -> Int32 {
  self.size
}

///|
pub fn Dbtx2pcLayer::get(self : Dbtx2pcLayer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Dbtx2pcLayer::set(
  self : Dbtx2pcLayer,
  i : Int32,
  v : Double,
) -> Dbtx2pcLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcLayer::sum(self : Dbtx2pcLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Dbtx2pcLayer::mean(self : Dbtx2pcLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Dbtx2pcLayer::scale(self : Dbtx2pcLayer, f : Double) -> Dbtx2pcLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcLayer::add(
  self : Dbtx2pcLayer,
  other : Dbtx2pcLayer,
) -> Dbtx2pcLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Dbtx2pcLayer::copy(self : Dbtx2pcLayer) -> Dbtx2pcLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcLayer::fill(self : Dbtx2pcLayer, v : Double) -> Dbtx2pcLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcLayer::min(self : Dbtx2pcLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn Dbtx2pcLayer::max(self : Dbtx2pcLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn Dbtx2pcLayer::to_string(self : Dbtx2pcLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Dbtx2pcBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_tx_2pc_buffer_make(size : Int32) -> Dbtx2pcBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Dbtx2pcBuffer::len(self : Dbtx2pcBuffer) -> Int32 {
  self.size
}

///|
pub fn Dbtx2pcBuffer::get(self : Dbtx2pcBuffer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Dbtx2pcBuffer::set(
  self : Dbtx2pcBuffer,
  i : Int32,
  v : Double,
) -> Dbtx2pcBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcBuffer::sum(self : Dbtx2pcBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Dbtx2pcBuffer::mean(self : Dbtx2pcBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Dbtx2pcBuffer::scale(self : Dbtx2pcBuffer, f : Double) -> Dbtx2pcBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcBuffer::add(
  self : Dbtx2pcBuffer,
  other : Dbtx2pcBuffer,
) -> Dbtx2pcBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Dbtx2pcBuffer::copy(self : Dbtx2pcBuffer) -> Dbtx2pcBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcBuffer::fill(self : Dbtx2pcBuffer, v : Double) -> Dbtx2pcBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcBuffer::min(self : Dbtx2pcBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn Dbtx2pcBuffer::max(self : Dbtx2pcBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn Dbtx2pcBuffer::to_string(self : Dbtx2pcBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Dbtx2pcCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_tx_2pc_cursor_make(size : Int32) -> Dbtx2pcCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Dbtx2pcCursor::len(self : Dbtx2pcCursor) -> Int32 {
  self.size
}

///|
pub fn Dbtx2pcCursor::get(self : Dbtx2pcCursor, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Dbtx2pcCursor::set(
  self : Dbtx2pcCursor,
  i : Int32,
  v : Double,
) -> Dbtx2pcCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcCursor::sum(self : Dbtx2pcCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Dbtx2pcCursor::mean(self : Dbtx2pcCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Dbtx2pcCursor::scale(self : Dbtx2pcCursor, f : Double) -> Dbtx2pcCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcCursor::add(
  self : Dbtx2pcCursor,
  other : Dbtx2pcCursor,
) -> Dbtx2pcCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Dbtx2pcCursor::copy(self : Dbtx2pcCursor) -> Dbtx2pcCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcCursor::fill(self : Dbtx2pcCursor, v : Double) -> Dbtx2pcCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcCursor::min(self : Dbtx2pcCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn Dbtx2pcCursor::max(self : Dbtx2pcCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn Dbtx2pcCursor::to_string(self : Dbtx2pcCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Dbtx2pcView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_tx_2pc_view_make(size : Int32) -> Dbtx2pcView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Dbtx2pcView::len(self : Dbtx2pcView) -> Int32 {
  self.size
}

///|
pub fn Dbtx2pcView::get(self : Dbtx2pcView, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Dbtx2pcView::set(
  self : Dbtx2pcView,
  i : Int32,
  v : Double,
) -> Dbtx2pcView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcView::sum(self : Dbtx2pcView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Dbtx2pcView::mean(self : Dbtx2pcView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Dbtx2pcView::scale(self : Dbtx2pcView, f : Double) -> Dbtx2pcView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcView::add(self : Dbtx2pcView, other : Dbtx2pcView) -> Dbtx2pcView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Dbtx2pcView::copy(self : Dbtx2pcView) -> Dbtx2pcView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcView::fill(self : Dbtx2pcView, v : Double) -> Dbtx2pcView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcView::min(self : Dbtx2pcView) -> Double {
  @_common.min(self.data)
}

///|
pub fn Dbtx2pcView::max(self : Dbtx2pcView) -> Double {
  @_common.max(self.data)
}

///|
pub fn Dbtx2pcView::to_string(self : Dbtx2pcView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Dbtx2pcRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_tx_2pc_range_make(size : Int32) -> Dbtx2pcRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Dbtx2pcRange::len(self : Dbtx2pcRange) -> Int32 {
  self.size
}

///|
pub fn Dbtx2pcRange::get(self : Dbtx2pcRange, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Dbtx2pcRange::set(
  self : Dbtx2pcRange,
  i : Int32,
  v : Double,
) -> Dbtx2pcRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcRange::sum(self : Dbtx2pcRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Dbtx2pcRange::mean(self : Dbtx2pcRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Dbtx2pcRange::scale(self : Dbtx2pcRange, f : Double) -> Dbtx2pcRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcRange::add(
  self : Dbtx2pcRange,
  other : Dbtx2pcRange,
) -> Dbtx2pcRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Dbtx2pcRange::copy(self : Dbtx2pcRange) -> Dbtx2pcRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcRange::fill(self : Dbtx2pcRange, v : Double) -> Dbtx2pcRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcRange::min(self : Dbtx2pcRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn Dbtx2pcRange::max(self : Dbtx2pcRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn Dbtx2pcRange::to_string(self : Dbtx2pcRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct Dbtx2pcSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_tx_2pc_slice_make(size : Int32) -> Dbtx2pcSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn Dbtx2pcSlice::len(self : Dbtx2pcSlice) -> Int32 {
  self.size
}

///|
pub fn Dbtx2pcSlice::get(self : Dbtx2pcSlice, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn Dbtx2pcSlice::set(
  self : Dbtx2pcSlice,
  i : Int32,
  v : Double,
) -> Dbtx2pcSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcSlice::sum(self : Dbtx2pcSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn Dbtx2pcSlice::mean(self : Dbtx2pcSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn Dbtx2pcSlice::scale(self : Dbtx2pcSlice, f : Double) -> Dbtx2pcSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcSlice::add(
  self : Dbtx2pcSlice,
  other : Dbtx2pcSlice,
) -> Dbtx2pcSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn Dbtx2pcSlice::copy(self : Dbtx2pcSlice) -> Dbtx2pcSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcSlice::fill(self : Dbtx2pcSlice, v : Double) -> Dbtx2pcSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn Dbtx2pcSlice::min(self : Dbtx2pcSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn Dbtx2pcSlice::max(self : Dbtx2pcSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn Dbtx2pcSlice::to_string(self : Dbtx2pcSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
