///|
///===
/// extcore/opt_meta_pso
pub(all) struct OptmetapsoPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn opt_meta_pso_make_point(x : Double, y : Double) -> OptmetapsoPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn opt_meta_pso_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> OptmetapsoPoint {
  { x, y, z, label: 0, }
}

///|
pub fn OptmetapsoPoint::x(self : OptmetapsoPoint) -> Double {
  self.x
}

///|
pub fn OptmetapsoPoint::y(self : OptmetapsoPoint) -> Double {
  self.y
}

///|
pub fn OptmetapsoPoint::z(self : OptmetapsoPoint) -> Double {
  self.z
}

///|
pub fn OptmetapsoPoint::label(self : OptmetapsoPoint) -> Int32 {
  self.label
}

///|
pub fn OptmetapsoPoint::dist(
  self : OptmetapsoPoint,
  other : OptmetapsoPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn OptmetapsoPoint::add(
  self : OptmetapsoPoint,
  other : OptmetapsoPoint,
) -> OptmetapsoPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn OptmetapsoPoint::sub(
  self : OptmetapsoPoint,
  other : OptmetapsoPoint,
) -> OptmetapsoPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn OptmetapsoPoint::scale(
  self : OptmetapsoPoint,
  s : Double,
) -> OptmetapsoPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn OptmetapsoPoint::dot(
  self : OptmetapsoPoint,
  other : OptmetapsoPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn OptmetapsoPoint::cross(
  self : OptmetapsoPoint,
  other : OptmetapsoPoint,
) -> OptmetapsoPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn OptmetapsoPoint::norm(self : OptmetapsoPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn OptmetapsoPoint::normalize(self : OptmetapsoPoint) -> OptmetapsoPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn OptmetapsoPoint::negate(self : OptmetapsoPoint) -> OptmetapsoPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn OptmetapsoPoint::mid(
  self : OptmetapsoPoint,
  other : OptmetapsoPoint,
) -> OptmetapsoPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn OptmetapsoPoint::lerp(
  self : OptmetapsoPoint,
  other : OptmetapsoPoint,
  t : Double,
) -> OptmetapsoPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn OptmetapsoPoint::to_string(self : OptmetapsoPoint) -> String {
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
pub(all) struct OptmetapsoSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn opt_meta_pso_make_series(
  vals : Array[Double],
  name : String,
) -> OptmetapsoSeries {
  { vals, name, meta: 0, }
}

///|
pub fn OptmetapsoSeries::len(self : OptmetapsoSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn OptmetapsoSeries::sum(self : OptmetapsoSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn OptmetapsoSeries::mean(self : OptmetapsoSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn OptmetapsoSeries::min(self : OptmetapsoSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn OptmetapsoSeries::max(self : OptmetapsoSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn OptmetapsoSeries::range(self : OptmetapsoSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn OptmetapsoSeries::variance(self : OptmetapsoSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn OptmetapsoSeries::std(self : OptmetapsoSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn OptmetapsoSeries::median(self : OptmetapsoSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn OptmetapsoSeries::scale(
  self : OptmetapsoSeries,
  f : Double,
) -> OptmetapsoSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn OptmetapsoSeries::add(
  self : OptmetapsoSeries,
  other : OptmetapsoSeries,
) -> OptmetapsoSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn OptmetapsoSeries::sub(
  self : OptmetapsoSeries,
  other : OptmetapsoSeries,
) -> OptmetapsoSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn OptmetapsoSeries::normalize(self : OptmetapsoSeries) -> OptmetapsoSeries {
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
pub fn OptmetapsoSeries::cumsum(self : OptmetapsoSeries) -> OptmetapsoSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn OptmetapsoSeries::to_string(self : OptmetapsoSeries) -> String {
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
pub(all) struct OptmetapsoMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn opt_meta_pso_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> OptmetapsoMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn opt_meta_pso_matrix_identity(n : Int32) -> OptmetapsoMatrix {
  let m = opt_meta_pso_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn OptmetapsoMatrix::get(
  self : OptmetapsoMatrix,
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
pub fn OptmetapsoMatrix::transpose(self : OptmetapsoMatrix) -> OptmetapsoMatrix {
  let result = opt_meta_pso_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn OptmetapsoMatrix::add(
  self : OptmetapsoMatrix,
  other : OptmetapsoMatrix,
) -> OptmetapsoMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = opt_meta_pso_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn OptmetapsoMatrix::scale(
  self : OptmetapsoMatrix,
  s : Double,
) -> OptmetapsoMatrix {
  let result = opt_meta_pso_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn OptmetapsoMatrix::multiply(
  self : OptmetapsoMatrix,
  other : OptmetapsoMatrix,
) -> OptmetapsoMatrix {
  if self.cols != other.rows {
    return opt_meta_pso_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = opt_meta_pso_make_matrix(self.rows, other.cols, 0.0)
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
pub fn OptmetapsoMatrix::trace(self : OptmetapsoMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn OptmetapsoMatrix::det(self : OptmetapsoMatrix) -> Double {
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
pub fn OptmetapsoMatrix::norm(self : OptmetapsoMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn OptmetapsoMatrix::to_string(self : OptmetapsoMatrix) -> String {
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
pub(all) struct OptmetapsoVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn opt_meta_pso_make_vector(comps : Array[Double]) -> OptmetapsoVector {
  { comps, dim: comps.length(), }
}

///|
pub fn opt_meta_pso_vector_zero(dim : Int32) -> OptmetapsoVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn OptmetapsoVector::add(
  self : OptmetapsoVector,
  other : OptmetapsoVector,
) -> OptmetapsoVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn OptmetapsoVector::sub(
  self : OptmetapsoVector,
  other : OptmetapsoVector,
) -> OptmetapsoVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn OptmetapsoVector::scale(
  self : OptmetapsoVector,
  s : Double,
) -> OptmetapsoVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn OptmetapsoVector::dot(
  self : OptmetapsoVector,
  other : OptmetapsoVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn OptmetapsoVector::norm(self : OptmetapsoVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn OptmetapsoVector::normalize(self : OptmetapsoVector) -> OptmetapsoVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn OptmetapsoVector::dist(
  self : OptmetapsoVector,
  other : OptmetapsoVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn OptmetapsoVector::to_string(self : OptmetapsoVector) -> String {
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
pub(all) struct OptmetapsoFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_meta_pso_frame_make(size : Int32) -> OptmetapsoFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptmetapsoFrame::len(self : OptmetapsoFrame) -> Int32 {
  self.size
}

///|
pub fn OptmetapsoFrame::get(self : OptmetapsoFrame, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptmetapsoFrame::set(
  self : OptmetapsoFrame,
  i : Int32,
  v : Double,
) -> OptmetapsoFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoFrame::sum(self : OptmetapsoFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptmetapsoFrame::mean(self : OptmetapsoFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptmetapsoFrame::scale(
  self : OptmetapsoFrame,
  f : Double,
) -> OptmetapsoFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoFrame::add(
  self : OptmetapsoFrame,
  other : OptmetapsoFrame,
) -> OptmetapsoFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptmetapsoFrame::copy(self : OptmetapsoFrame) -> OptmetapsoFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoFrame::fill(
  self : OptmetapsoFrame,
  v : Double,
) -> OptmetapsoFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoFrame::min(self : OptmetapsoFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptmetapsoFrame::max(self : OptmetapsoFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptmetapsoFrame::to_string(self : OptmetapsoFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptmetapsoTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_meta_pso_table_make(size : Int32) -> OptmetapsoTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptmetapsoTable::len(self : OptmetapsoTable) -> Int32 {
  self.size
}

///|
pub fn OptmetapsoTable::get(self : OptmetapsoTable, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptmetapsoTable::set(
  self : OptmetapsoTable,
  i : Int32,
  v : Double,
) -> OptmetapsoTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoTable::sum(self : OptmetapsoTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptmetapsoTable::mean(self : OptmetapsoTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptmetapsoTable::scale(
  self : OptmetapsoTable,
  f : Double,
) -> OptmetapsoTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoTable::add(
  self : OptmetapsoTable,
  other : OptmetapsoTable,
) -> OptmetapsoTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptmetapsoTable::copy(self : OptmetapsoTable) -> OptmetapsoTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoTable::fill(
  self : OptmetapsoTable,
  v : Double,
) -> OptmetapsoTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoTable::min(self : OptmetapsoTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptmetapsoTable::max(self : OptmetapsoTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptmetapsoTable::to_string(self : OptmetapsoTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptmetapsoGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_meta_pso_graphn_make(size : Int32) -> OptmetapsoGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptmetapsoGraphN::len(self : OptmetapsoGraphN) -> Int32 {
  self.size
}

///|
pub fn OptmetapsoGraphN::get(self : OptmetapsoGraphN, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptmetapsoGraphN::set(
  self : OptmetapsoGraphN,
  i : Int32,
  v : Double,
) -> OptmetapsoGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoGraphN::sum(self : OptmetapsoGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptmetapsoGraphN::mean(self : OptmetapsoGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptmetapsoGraphN::scale(
  self : OptmetapsoGraphN,
  f : Double,
) -> OptmetapsoGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoGraphN::add(
  self : OptmetapsoGraphN,
  other : OptmetapsoGraphN,
) -> OptmetapsoGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptmetapsoGraphN::copy(self : OptmetapsoGraphN) -> OptmetapsoGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoGraphN::fill(
  self : OptmetapsoGraphN,
  v : Double,
) -> OptmetapsoGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoGraphN::min(self : OptmetapsoGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptmetapsoGraphN::max(self : OptmetapsoGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptmetapsoGraphN::to_string(self : OptmetapsoGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptmetapsoNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_meta_pso_node_make(size : Int32) -> OptmetapsoNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptmetapsoNode::len(self : OptmetapsoNode) -> Int32 {
  self.size
}

///|
pub fn OptmetapsoNode::get(self : OptmetapsoNode, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptmetapsoNode::set(
  self : OptmetapsoNode,
  i : Int32,
  v : Double,
) -> OptmetapsoNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoNode::sum(self : OptmetapsoNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptmetapsoNode::mean(self : OptmetapsoNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptmetapsoNode::scale(
  self : OptmetapsoNode,
  f : Double,
) -> OptmetapsoNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoNode::add(
  self : OptmetapsoNode,
  other : OptmetapsoNode,
) -> OptmetapsoNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptmetapsoNode::copy(self : OptmetapsoNode) -> OptmetapsoNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoNode::fill(
  self : OptmetapsoNode,
  v : Double,
) -> OptmetapsoNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoNode::min(self : OptmetapsoNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptmetapsoNode::max(self : OptmetapsoNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptmetapsoNode::to_string(self : OptmetapsoNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptmetapsoEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_meta_pso_edge_make(size : Int32) -> OptmetapsoEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptmetapsoEdge::len(self : OptmetapsoEdge) -> Int32 {
  self.size
}

///|
pub fn OptmetapsoEdge::get(self : OptmetapsoEdge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptmetapsoEdge::set(
  self : OptmetapsoEdge,
  i : Int32,
  v : Double,
) -> OptmetapsoEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoEdge::sum(self : OptmetapsoEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptmetapsoEdge::mean(self : OptmetapsoEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptmetapsoEdge::scale(
  self : OptmetapsoEdge,
  f : Double,
) -> OptmetapsoEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoEdge::add(
  self : OptmetapsoEdge,
  other : OptmetapsoEdge,
) -> OptmetapsoEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptmetapsoEdge::copy(self : OptmetapsoEdge) -> OptmetapsoEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoEdge::fill(
  self : OptmetapsoEdge,
  v : Double,
) -> OptmetapsoEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoEdge::min(self : OptmetapsoEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptmetapsoEdge::max(self : OptmetapsoEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptmetapsoEdge::to_string(self : OptmetapsoEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptmetapsoPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_meta_pso_path_make(size : Int32) -> OptmetapsoPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptmetapsoPath::len(self : OptmetapsoPath) -> Int32 {
  self.size
}

///|
pub fn OptmetapsoPath::get(self : OptmetapsoPath, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptmetapsoPath::set(
  self : OptmetapsoPath,
  i : Int32,
  v : Double,
) -> OptmetapsoPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoPath::sum(self : OptmetapsoPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptmetapsoPath::mean(self : OptmetapsoPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptmetapsoPath::scale(
  self : OptmetapsoPath,
  f : Double,
) -> OptmetapsoPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoPath::add(
  self : OptmetapsoPath,
  other : OptmetapsoPath,
) -> OptmetapsoPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptmetapsoPath::copy(self : OptmetapsoPath) -> OptmetapsoPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoPath::fill(
  self : OptmetapsoPath,
  v : Double,
) -> OptmetapsoPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoPath::min(self : OptmetapsoPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptmetapsoPath::max(self : OptmetapsoPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptmetapsoPath::to_string(self : OptmetapsoPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptmetapsoCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_meta_pso_cluster_make(size : Int32) -> OptmetapsoCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptmetapsoCluster::len(self : OptmetapsoCluster) -> Int32 {
  self.size
}

///|
pub fn OptmetapsoCluster::get(self : OptmetapsoCluster, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptmetapsoCluster::set(
  self : OptmetapsoCluster,
  i : Int32,
  v : Double,
) -> OptmetapsoCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoCluster::sum(self : OptmetapsoCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptmetapsoCluster::mean(self : OptmetapsoCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptmetapsoCluster::scale(
  self : OptmetapsoCluster,
  f : Double,
) -> OptmetapsoCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoCluster::add(
  self : OptmetapsoCluster,
  other : OptmetapsoCluster,
) -> OptmetapsoCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptmetapsoCluster::copy(self : OptmetapsoCluster) -> OptmetapsoCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoCluster::fill(
  self : OptmetapsoCluster,
  v : Double,
) -> OptmetapsoCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoCluster::min(self : OptmetapsoCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptmetapsoCluster::max(self : OptmetapsoCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptmetapsoCluster::to_string(self : OptmetapsoCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptmetapsoModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_meta_pso_model_make(size : Int32) -> OptmetapsoModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptmetapsoModel::len(self : OptmetapsoModel) -> Int32 {
  self.size
}

///|
pub fn OptmetapsoModel::get(self : OptmetapsoModel, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptmetapsoModel::set(
  self : OptmetapsoModel,
  i : Int32,
  v : Double,
) -> OptmetapsoModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoModel::sum(self : OptmetapsoModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptmetapsoModel::mean(self : OptmetapsoModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptmetapsoModel::scale(
  self : OptmetapsoModel,
  f : Double,
) -> OptmetapsoModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoModel::add(
  self : OptmetapsoModel,
  other : OptmetapsoModel,
) -> OptmetapsoModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptmetapsoModel::copy(self : OptmetapsoModel) -> OptmetapsoModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoModel::fill(
  self : OptmetapsoModel,
  v : Double,
) -> OptmetapsoModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoModel::min(self : OptmetapsoModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptmetapsoModel::max(self : OptmetapsoModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptmetapsoModel::to_string(self : OptmetapsoModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptmetapsoLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_meta_pso_layer_make(size : Int32) -> OptmetapsoLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptmetapsoLayer::len(self : OptmetapsoLayer) -> Int32 {
  self.size
}

///|
pub fn OptmetapsoLayer::get(self : OptmetapsoLayer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptmetapsoLayer::set(
  self : OptmetapsoLayer,
  i : Int32,
  v : Double,
) -> OptmetapsoLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoLayer::sum(self : OptmetapsoLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptmetapsoLayer::mean(self : OptmetapsoLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptmetapsoLayer::scale(
  self : OptmetapsoLayer,
  f : Double,
) -> OptmetapsoLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoLayer::add(
  self : OptmetapsoLayer,
  other : OptmetapsoLayer,
) -> OptmetapsoLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptmetapsoLayer::copy(self : OptmetapsoLayer) -> OptmetapsoLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoLayer::fill(
  self : OptmetapsoLayer,
  v : Double,
) -> OptmetapsoLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoLayer::min(self : OptmetapsoLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptmetapsoLayer::max(self : OptmetapsoLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptmetapsoLayer::to_string(self : OptmetapsoLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptmetapsoBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_meta_pso_buffer_make(size : Int32) -> OptmetapsoBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptmetapsoBuffer::len(self : OptmetapsoBuffer) -> Int32 {
  self.size
}

///|
pub fn OptmetapsoBuffer::get(self : OptmetapsoBuffer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptmetapsoBuffer::set(
  self : OptmetapsoBuffer,
  i : Int32,
  v : Double,
) -> OptmetapsoBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoBuffer::sum(self : OptmetapsoBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptmetapsoBuffer::mean(self : OptmetapsoBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptmetapsoBuffer::scale(
  self : OptmetapsoBuffer,
  f : Double,
) -> OptmetapsoBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoBuffer::add(
  self : OptmetapsoBuffer,
  other : OptmetapsoBuffer,
) -> OptmetapsoBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptmetapsoBuffer::copy(self : OptmetapsoBuffer) -> OptmetapsoBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoBuffer::fill(
  self : OptmetapsoBuffer,
  v : Double,
) -> OptmetapsoBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoBuffer::min(self : OptmetapsoBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptmetapsoBuffer::max(self : OptmetapsoBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptmetapsoBuffer::to_string(self : OptmetapsoBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptmetapsoCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_meta_pso_cursor_make(size : Int32) -> OptmetapsoCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptmetapsoCursor::len(self : OptmetapsoCursor) -> Int32 {
  self.size
}

///|
pub fn OptmetapsoCursor::get(self : OptmetapsoCursor, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptmetapsoCursor::set(
  self : OptmetapsoCursor,
  i : Int32,
  v : Double,
) -> OptmetapsoCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoCursor::sum(self : OptmetapsoCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptmetapsoCursor::mean(self : OptmetapsoCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptmetapsoCursor::scale(
  self : OptmetapsoCursor,
  f : Double,
) -> OptmetapsoCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoCursor::add(
  self : OptmetapsoCursor,
  other : OptmetapsoCursor,
) -> OptmetapsoCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptmetapsoCursor::copy(self : OptmetapsoCursor) -> OptmetapsoCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoCursor::fill(
  self : OptmetapsoCursor,
  v : Double,
) -> OptmetapsoCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoCursor::min(self : OptmetapsoCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptmetapsoCursor::max(self : OptmetapsoCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptmetapsoCursor::to_string(self : OptmetapsoCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptmetapsoView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_meta_pso_view_make(size : Int32) -> OptmetapsoView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptmetapsoView::len(self : OptmetapsoView) -> Int32 {
  self.size
}

///|
pub fn OptmetapsoView::get(self : OptmetapsoView, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptmetapsoView::set(
  self : OptmetapsoView,
  i : Int32,
  v : Double,
) -> OptmetapsoView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoView::sum(self : OptmetapsoView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptmetapsoView::mean(self : OptmetapsoView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptmetapsoView::scale(
  self : OptmetapsoView,
  f : Double,
) -> OptmetapsoView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoView::add(
  self : OptmetapsoView,
  other : OptmetapsoView,
) -> OptmetapsoView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptmetapsoView::copy(self : OptmetapsoView) -> OptmetapsoView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoView::fill(
  self : OptmetapsoView,
  v : Double,
) -> OptmetapsoView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoView::min(self : OptmetapsoView) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptmetapsoView::max(self : OptmetapsoView) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptmetapsoView::to_string(self : OptmetapsoView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptmetapsoRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_meta_pso_range_make(size : Int32) -> OptmetapsoRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptmetapsoRange::len(self : OptmetapsoRange) -> Int32 {
  self.size
}

///|
pub fn OptmetapsoRange::get(self : OptmetapsoRange, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptmetapsoRange::set(
  self : OptmetapsoRange,
  i : Int32,
  v : Double,
) -> OptmetapsoRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoRange::sum(self : OptmetapsoRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptmetapsoRange::mean(self : OptmetapsoRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptmetapsoRange::scale(
  self : OptmetapsoRange,
  f : Double,
) -> OptmetapsoRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoRange::add(
  self : OptmetapsoRange,
  other : OptmetapsoRange,
) -> OptmetapsoRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptmetapsoRange::copy(self : OptmetapsoRange) -> OptmetapsoRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoRange::fill(
  self : OptmetapsoRange,
  v : Double,
) -> OptmetapsoRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoRange::min(self : OptmetapsoRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptmetapsoRange::max(self : OptmetapsoRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptmetapsoRange::to_string(self : OptmetapsoRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct OptmetapsoSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn opt_meta_pso_slice_make(size : Int32) -> OptmetapsoSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn OptmetapsoSlice::len(self : OptmetapsoSlice) -> Int32 {
  self.size
}

///|
pub fn OptmetapsoSlice::get(self : OptmetapsoSlice, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn OptmetapsoSlice::set(
  self : OptmetapsoSlice,
  i : Int32,
  v : Double,
) -> OptmetapsoSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoSlice::sum(self : OptmetapsoSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn OptmetapsoSlice::mean(self : OptmetapsoSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn OptmetapsoSlice::scale(
  self : OptmetapsoSlice,
  f : Double,
) -> OptmetapsoSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoSlice::add(
  self : OptmetapsoSlice,
  other : OptmetapsoSlice,
) -> OptmetapsoSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn OptmetapsoSlice::copy(self : OptmetapsoSlice) -> OptmetapsoSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoSlice::fill(
  self : OptmetapsoSlice,
  v : Double,
) -> OptmetapsoSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn OptmetapsoSlice::min(self : OptmetapsoSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn OptmetapsoSlice::max(self : OptmetapsoSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn OptmetapsoSlice::to_string(self : OptmetapsoSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
