///|
///===
/// extcore/math_tensor_calc
pub(all) struct MathtensorcalcPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn math_tensor_calc_make_point(
  x : Double,
  y : Double,
) -> MathtensorcalcPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn math_tensor_calc_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> MathtensorcalcPoint {
  { x, y, z, label: 0, }
}

///|
pub fn MathtensorcalcPoint::x(self : MathtensorcalcPoint) -> Double {
  self.x
}

///|
pub fn MathtensorcalcPoint::y(self : MathtensorcalcPoint) -> Double {
  self.y
}

///|
pub fn MathtensorcalcPoint::z(self : MathtensorcalcPoint) -> Double {
  self.z
}

///|
pub fn MathtensorcalcPoint::label(self : MathtensorcalcPoint) -> Int32 {
  self.label
}

///|
pub fn MathtensorcalcPoint::dist(
  self : MathtensorcalcPoint,
  other : MathtensorcalcPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn MathtensorcalcPoint::add(
  self : MathtensorcalcPoint,
  other : MathtensorcalcPoint,
) -> MathtensorcalcPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn MathtensorcalcPoint::sub(
  self : MathtensorcalcPoint,
  other : MathtensorcalcPoint,
) -> MathtensorcalcPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn MathtensorcalcPoint::scale(
  self : MathtensorcalcPoint,
  s : Double,
) -> MathtensorcalcPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn MathtensorcalcPoint::dot(
  self : MathtensorcalcPoint,
  other : MathtensorcalcPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn MathtensorcalcPoint::cross(
  self : MathtensorcalcPoint,
  other : MathtensorcalcPoint,
) -> MathtensorcalcPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn MathtensorcalcPoint::norm(self : MathtensorcalcPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn MathtensorcalcPoint::normalize(
  self : MathtensorcalcPoint,
) -> MathtensorcalcPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn MathtensorcalcPoint::negate(
  self : MathtensorcalcPoint,
) -> MathtensorcalcPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn MathtensorcalcPoint::mid(
  self : MathtensorcalcPoint,
  other : MathtensorcalcPoint,
) -> MathtensorcalcPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn MathtensorcalcPoint::lerp(
  self : MathtensorcalcPoint,
  other : MathtensorcalcPoint,
  t : Double,
) -> MathtensorcalcPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn MathtensorcalcPoint::to_string(self : MathtensorcalcPoint) -> String {
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
pub(all) struct MathtensorcalcSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn math_tensor_calc_make_series(
  vals : Array[Double],
  name : String,
) -> MathtensorcalcSeries {
  { vals, name, meta: 0, }
}

///|
pub fn MathtensorcalcSeries::len(self : MathtensorcalcSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn MathtensorcalcSeries::sum(self : MathtensorcalcSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn MathtensorcalcSeries::mean(self : MathtensorcalcSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn MathtensorcalcSeries::min(self : MathtensorcalcSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn MathtensorcalcSeries::max(self : MathtensorcalcSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn MathtensorcalcSeries::range(self : MathtensorcalcSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn MathtensorcalcSeries::variance(self : MathtensorcalcSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn MathtensorcalcSeries::std(self : MathtensorcalcSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn MathtensorcalcSeries::median(self : MathtensorcalcSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn MathtensorcalcSeries::scale(
  self : MathtensorcalcSeries,
  f : Double,
) -> MathtensorcalcSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn MathtensorcalcSeries::add(
  self : MathtensorcalcSeries,
  other : MathtensorcalcSeries,
) -> MathtensorcalcSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn MathtensorcalcSeries::sub(
  self : MathtensorcalcSeries,
  other : MathtensorcalcSeries,
) -> MathtensorcalcSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn MathtensorcalcSeries::normalize(
  self : MathtensorcalcSeries,
) -> MathtensorcalcSeries {
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
pub fn MathtensorcalcSeries::cumsum(
  self : MathtensorcalcSeries,
) -> MathtensorcalcSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn MathtensorcalcSeries::to_string(self : MathtensorcalcSeries) -> String {
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
pub(all) struct MathtensorcalcMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn math_tensor_calc_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> MathtensorcalcMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn math_tensor_calc_matrix_identity(n : Int32) -> MathtensorcalcMatrix {
  let m = math_tensor_calc_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn MathtensorcalcMatrix::get(
  self : MathtensorcalcMatrix,
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
pub fn MathtensorcalcMatrix::transpose(
  self : MathtensorcalcMatrix,
) -> MathtensorcalcMatrix {
  let result = math_tensor_calc_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn MathtensorcalcMatrix::add(
  self : MathtensorcalcMatrix,
  other : MathtensorcalcMatrix,
) -> MathtensorcalcMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = math_tensor_calc_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn MathtensorcalcMatrix::scale(
  self : MathtensorcalcMatrix,
  s : Double,
) -> MathtensorcalcMatrix {
  let result = math_tensor_calc_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn MathtensorcalcMatrix::multiply(
  self : MathtensorcalcMatrix,
  other : MathtensorcalcMatrix,
) -> MathtensorcalcMatrix {
  if self.cols != other.rows {
    return math_tensor_calc_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = math_tensor_calc_make_matrix(self.rows, other.cols, 0.0)
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
pub fn MathtensorcalcMatrix::trace(self : MathtensorcalcMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn MathtensorcalcMatrix::det(self : MathtensorcalcMatrix) -> Double {
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
pub fn MathtensorcalcMatrix::norm(self : MathtensorcalcMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn MathtensorcalcMatrix::to_string(self : MathtensorcalcMatrix) -> String {
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
pub(all) struct MathtensorcalcVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn math_tensor_calc_make_vector(
  comps : Array[Double],
) -> MathtensorcalcVector {
  { comps, dim: comps.length(), }
}

///|
pub fn math_tensor_calc_vector_zero(dim : Int32) -> MathtensorcalcVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn MathtensorcalcVector::add(
  self : MathtensorcalcVector,
  other : MathtensorcalcVector,
) -> MathtensorcalcVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn MathtensorcalcVector::sub(
  self : MathtensorcalcVector,
  other : MathtensorcalcVector,
) -> MathtensorcalcVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn MathtensorcalcVector::scale(
  self : MathtensorcalcVector,
  s : Double,
) -> MathtensorcalcVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn MathtensorcalcVector::dot(
  self : MathtensorcalcVector,
  other : MathtensorcalcVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn MathtensorcalcVector::norm(self : MathtensorcalcVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn MathtensorcalcVector::normalize(
  self : MathtensorcalcVector,
) -> MathtensorcalcVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn MathtensorcalcVector::dist(
  self : MathtensorcalcVector,
  other : MathtensorcalcVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn MathtensorcalcVector::to_string(self : MathtensorcalcVector) -> String {
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
pub(all) struct MathtensorcalcFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_tensor_calc_frame_make(size : Int32) -> MathtensorcalcFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathtensorcalcFrame::len(self : MathtensorcalcFrame) -> Int32 {
  self.size
}

///|
pub fn MathtensorcalcFrame::get(
  self : MathtensorcalcFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathtensorcalcFrame::set(
  self : MathtensorcalcFrame,
  i : Int32,
  v : Double,
) -> MathtensorcalcFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcFrame::sum(self : MathtensorcalcFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathtensorcalcFrame::mean(self : MathtensorcalcFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathtensorcalcFrame::scale(
  self : MathtensorcalcFrame,
  f : Double,
) -> MathtensorcalcFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcFrame::add(
  self : MathtensorcalcFrame,
  other : MathtensorcalcFrame,
) -> MathtensorcalcFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathtensorcalcFrame::copy(
  self : MathtensorcalcFrame,
) -> MathtensorcalcFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcFrame::fill(
  self : MathtensorcalcFrame,
  v : Double,
) -> MathtensorcalcFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcFrame::min(self : MathtensorcalcFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathtensorcalcFrame::max(self : MathtensorcalcFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathtensorcalcFrame::to_string(self : MathtensorcalcFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathtensorcalcTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_tensor_calc_table_make(size : Int32) -> MathtensorcalcTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathtensorcalcTable::len(self : MathtensorcalcTable) -> Int32 {
  self.size
}

///|
pub fn MathtensorcalcTable::get(
  self : MathtensorcalcTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathtensorcalcTable::set(
  self : MathtensorcalcTable,
  i : Int32,
  v : Double,
) -> MathtensorcalcTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcTable::sum(self : MathtensorcalcTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathtensorcalcTable::mean(self : MathtensorcalcTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathtensorcalcTable::scale(
  self : MathtensorcalcTable,
  f : Double,
) -> MathtensorcalcTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcTable::add(
  self : MathtensorcalcTable,
  other : MathtensorcalcTable,
) -> MathtensorcalcTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathtensorcalcTable::copy(
  self : MathtensorcalcTable,
) -> MathtensorcalcTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcTable::fill(
  self : MathtensorcalcTable,
  v : Double,
) -> MathtensorcalcTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcTable::min(self : MathtensorcalcTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathtensorcalcTable::max(self : MathtensorcalcTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathtensorcalcTable::to_string(self : MathtensorcalcTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathtensorcalcGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_tensor_calc_graphn_make(size : Int32) -> MathtensorcalcGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathtensorcalcGraphN::len(self : MathtensorcalcGraphN) -> Int32 {
  self.size
}

///|
pub fn MathtensorcalcGraphN::get(
  self : MathtensorcalcGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathtensorcalcGraphN::set(
  self : MathtensorcalcGraphN,
  i : Int32,
  v : Double,
) -> MathtensorcalcGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcGraphN::sum(self : MathtensorcalcGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathtensorcalcGraphN::mean(self : MathtensorcalcGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathtensorcalcGraphN::scale(
  self : MathtensorcalcGraphN,
  f : Double,
) -> MathtensorcalcGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcGraphN::add(
  self : MathtensorcalcGraphN,
  other : MathtensorcalcGraphN,
) -> MathtensorcalcGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathtensorcalcGraphN::copy(
  self : MathtensorcalcGraphN,
) -> MathtensorcalcGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcGraphN::fill(
  self : MathtensorcalcGraphN,
  v : Double,
) -> MathtensorcalcGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcGraphN::min(self : MathtensorcalcGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathtensorcalcGraphN::max(self : MathtensorcalcGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathtensorcalcGraphN::to_string(self : MathtensorcalcGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathtensorcalcNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_tensor_calc_node_make(size : Int32) -> MathtensorcalcNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathtensorcalcNode::len(self : MathtensorcalcNode) -> Int32 {
  self.size
}

///|
pub fn MathtensorcalcNode::get(self : MathtensorcalcNode, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathtensorcalcNode::set(
  self : MathtensorcalcNode,
  i : Int32,
  v : Double,
) -> MathtensorcalcNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcNode::sum(self : MathtensorcalcNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathtensorcalcNode::mean(self : MathtensorcalcNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathtensorcalcNode::scale(
  self : MathtensorcalcNode,
  f : Double,
) -> MathtensorcalcNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcNode::add(
  self : MathtensorcalcNode,
  other : MathtensorcalcNode,
) -> MathtensorcalcNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathtensorcalcNode::copy(
  self : MathtensorcalcNode,
) -> MathtensorcalcNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcNode::fill(
  self : MathtensorcalcNode,
  v : Double,
) -> MathtensorcalcNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcNode::min(self : MathtensorcalcNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathtensorcalcNode::max(self : MathtensorcalcNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathtensorcalcNode::to_string(self : MathtensorcalcNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathtensorcalcEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_tensor_calc_edge_make(size : Int32) -> MathtensorcalcEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathtensorcalcEdge::len(self : MathtensorcalcEdge) -> Int32 {
  self.size
}

///|
pub fn MathtensorcalcEdge::get(self : MathtensorcalcEdge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathtensorcalcEdge::set(
  self : MathtensorcalcEdge,
  i : Int32,
  v : Double,
) -> MathtensorcalcEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcEdge::sum(self : MathtensorcalcEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathtensorcalcEdge::mean(self : MathtensorcalcEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathtensorcalcEdge::scale(
  self : MathtensorcalcEdge,
  f : Double,
) -> MathtensorcalcEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcEdge::add(
  self : MathtensorcalcEdge,
  other : MathtensorcalcEdge,
) -> MathtensorcalcEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathtensorcalcEdge::copy(
  self : MathtensorcalcEdge,
) -> MathtensorcalcEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcEdge::fill(
  self : MathtensorcalcEdge,
  v : Double,
) -> MathtensorcalcEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcEdge::min(self : MathtensorcalcEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathtensorcalcEdge::max(self : MathtensorcalcEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathtensorcalcEdge::to_string(self : MathtensorcalcEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathtensorcalcPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_tensor_calc_path_make(size : Int32) -> MathtensorcalcPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathtensorcalcPath::len(self : MathtensorcalcPath) -> Int32 {
  self.size
}

///|
pub fn MathtensorcalcPath::get(self : MathtensorcalcPath, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathtensorcalcPath::set(
  self : MathtensorcalcPath,
  i : Int32,
  v : Double,
) -> MathtensorcalcPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcPath::sum(self : MathtensorcalcPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathtensorcalcPath::mean(self : MathtensorcalcPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathtensorcalcPath::scale(
  self : MathtensorcalcPath,
  f : Double,
) -> MathtensorcalcPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcPath::add(
  self : MathtensorcalcPath,
  other : MathtensorcalcPath,
) -> MathtensorcalcPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathtensorcalcPath::copy(
  self : MathtensorcalcPath,
) -> MathtensorcalcPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcPath::fill(
  self : MathtensorcalcPath,
  v : Double,
) -> MathtensorcalcPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcPath::min(self : MathtensorcalcPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathtensorcalcPath::max(self : MathtensorcalcPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathtensorcalcPath::to_string(self : MathtensorcalcPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathtensorcalcCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_tensor_calc_cluster_make(size : Int32) -> MathtensorcalcCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathtensorcalcCluster::len(self : MathtensorcalcCluster) -> Int32 {
  self.size
}

///|
pub fn MathtensorcalcCluster::get(
  self : MathtensorcalcCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathtensorcalcCluster::set(
  self : MathtensorcalcCluster,
  i : Int32,
  v : Double,
) -> MathtensorcalcCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcCluster::sum(self : MathtensorcalcCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathtensorcalcCluster::mean(self : MathtensorcalcCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathtensorcalcCluster::scale(
  self : MathtensorcalcCluster,
  f : Double,
) -> MathtensorcalcCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcCluster::add(
  self : MathtensorcalcCluster,
  other : MathtensorcalcCluster,
) -> MathtensorcalcCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathtensorcalcCluster::copy(
  self : MathtensorcalcCluster,
) -> MathtensorcalcCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcCluster::fill(
  self : MathtensorcalcCluster,
  v : Double,
) -> MathtensorcalcCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcCluster::min(self : MathtensorcalcCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathtensorcalcCluster::max(self : MathtensorcalcCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathtensorcalcCluster::to_string(self : MathtensorcalcCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathtensorcalcModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_tensor_calc_model_make(size : Int32) -> MathtensorcalcModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathtensorcalcModel::len(self : MathtensorcalcModel) -> Int32 {
  self.size
}

///|
pub fn MathtensorcalcModel::get(
  self : MathtensorcalcModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathtensorcalcModel::set(
  self : MathtensorcalcModel,
  i : Int32,
  v : Double,
) -> MathtensorcalcModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcModel::sum(self : MathtensorcalcModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathtensorcalcModel::mean(self : MathtensorcalcModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathtensorcalcModel::scale(
  self : MathtensorcalcModel,
  f : Double,
) -> MathtensorcalcModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcModel::add(
  self : MathtensorcalcModel,
  other : MathtensorcalcModel,
) -> MathtensorcalcModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathtensorcalcModel::copy(
  self : MathtensorcalcModel,
) -> MathtensorcalcModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcModel::fill(
  self : MathtensorcalcModel,
  v : Double,
) -> MathtensorcalcModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcModel::min(self : MathtensorcalcModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathtensorcalcModel::max(self : MathtensorcalcModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathtensorcalcModel::to_string(self : MathtensorcalcModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathtensorcalcLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_tensor_calc_layer_make(size : Int32) -> MathtensorcalcLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathtensorcalcLayer::len(self : MathtensorcalcLayer) -> Int32 {
  self.size
}

///|
pub fn MathtensorcalcLayer::get(
  self : MathtensorcalcLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathtensorcalcLayer::set(
  self : MathtensorcalcLayer,
  i : Int32,
  v : Double,
) -> MathtensorcalcLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcLayer::sum(self : MathtensorcalcLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathtensorcalcLayer::mean(self : MathtensorcalcLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathtensorcalcLayer::scale(
  self : MathtensorcalcLayer,
  f : Double,
) -> MathtensorcalcLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcLayer::add(
  self : MathtensorcalcLayer,
  other : MathtensorcalcLayer,
) -> MathtensorcalcLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathtensorcalcLayer::copy(
  self : MathtensorcalcLayer,
) -> MathtensorcalcLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcLayer::fill(
  self : MathtensorcalcLayer,
  v : Double,
) -> MathtensorcalcLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcLayer::min(self : MathtensorcalcLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathtensorcalcLayer::max(self : MathtensorcalcLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathtensorcalcLayer::to_string(self : MathtensorcalcLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathtensorcalcBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_tensor_calc_buffer_make(size : Int32) -> MathtensorcalcBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathtensorcalcBuffer::len(self : MathtensorcalcBuffer) -> Int32 {
  self.size
}

///|
pub fn MathtensorcalcBuffer::get(
  self : MathtensorcalcBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathtensorcalcBuffer::set(
  self : MathtensorcalcBuffer,
  i : Int32,
  v : Double,
) -> MathtensorcalcBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcBuffer::sum(self : MathtensorcalcBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathtensorcalcBuffer::mean(self : MathtensorcalcBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathtensorcalcBuffer::scale(
  self : MathtensorcalcBuffer,
  f : Double,
) -> MathtensorcalcBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcBuffer::add(
  self : MathtensorcalcBuffer,
  other : MathtensorcalcBuffer,
) -> MathtensorcalcBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathtensorcalcBuffer::copy(
  self : MathtensorcalcBuffer,
) -> MathtensorcalcBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcBuffer::fill(
  self : MathtensorcalcBuffer,
  v : Double,
) -> MathtensorcalcBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcBuffer::min(self : MathtensorcalcBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathtensorcalcBuffer::max(self : MathtensorcalcBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathtensorcalcBuffer::to_string(self : MathtensorcalcBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathtensorcalcCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_tensor_calc_cursor_make(size : Int32) -> MathtensorcalcCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathtensorcalcCursor::len(self : MathtensorcalcCursor) -> Int32 {
  self.size
}

///|
pub fn MathtensorcalcCursor::get(
  self : MathtensorcalcCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathtensorcalcCursor::set(
  self : MathtensorcalcCursor,
  i : Int32,
  v : Double,
) -> MathtensorcalcCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcCursor::sum(self : MathtensorcalcCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathtensorcalcCursor::mean(self : MathtensorcalcCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathtensorcalcCursor::scale(
  self : MathtensorcalcCursor,
  f : Double,
) -> MathtensorcalcCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcCursor::add(
  self : MathtensorcalcCursor,
  other : MathtensorcalcCursor,
) -> MathtensorcalcCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathtensorcalcCursor::copy(
  self : MathtensorcalcCursor,
) -> MathtensorcalcCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcCursor::fill(
  self : MathtensorcalcCursor,
  v : Double,
) -> MathtensorcalcCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcCursor::min(self : MathtensorcalcCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathtensorcalcCursor::max(self : MathtensorcalcCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathtensorcalcCursor::to_string(self : MathtensorcalcCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathtensorcalcView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_tensor_calc_view_make(size : Int32) -> MathtensorcalcView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathtensorcalcView::len(self : MathtensorcalcView) -> Int32 {
  self.size
}

///|
pub fn MathtensorcalcView::get(self : MathtensorcalcView, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathtensorcalcView::set(
  self : MathtensorcalcView,
  i : Int32,
  v : Double,
) -> MathtensorcalcView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcView::sum(self : MathtensorcalcView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathtensorcalcView::mean(self : MathtensorcalcView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathtensorcalcView::scale(
  self : MathtensorcalcView,
  f : Double,
) -> MathtensorcalcView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcView::add(
  self : MathtensorcalcView,
  other : MathtensorcalcView,
) -> MathtensorcalcView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathtensorcalcView::copy(
  self : MathtensorcalcView,
) -> MathtensorcalcView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcView::fill(
  self : MathtensorcalcView,
  v : Double,
) -> MathtensorcalcView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcView::min(self : MathtensorcalcView) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathtensorcalcView::max(self : MathtensorcalcView) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathtensorcalcView::to_string(self : MathtensorcalcView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathtensorcalcRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_tensor_calc_range_make(size : Int32) -> MathtensorcalcRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathtensorcalcRange::len(self : MathtensorcalcRange) -> Int32 {
  self.size
}

///|
pub fn MathtensorcalcRange::get(
  self : MathtensorcalcRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathtensorcalcRange::set(
  self : MathtensorcalcRange,
  i : Int32,
  v : Double,
) -> MathtensorcalcRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcRange::sum(self : MathtensorcalcRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathtensorcalcRange::mean(self : MathtensorcalcRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathtensorcalcRange::scale(
  self : MathtensorcalcRange,
  f : Double,
) -> MathtensorcalcRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcRange::add(
  self : MathtensorcalcRange,
  other : MathtensorcalcRange,
) -> MathtensorcalcRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathtensorcalcRange::copy(
  self : MathtensorcalcRange,
) -> MathtensorcalcRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcRange::fill(
  self : MathtensorcalcRange,
  v : Double,
) -> MathtensorcalcRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcRange::min(self : MathtensorcalcRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathtensorcalcRange::max(self : MathtensorcalcRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathtensorcalcRange::to_string(self : MathtensorcalcRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathtensorcalcSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_tensor_calc_slice_make(size : Int32) -> MathtensorcalcSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathtensorcalcSlice::len(self : MathtensorcalcSlice) -> Int32 {
  self.size
}

///|
pub fn MathtensorcalcSlice::get(
  self : MathtensorcalcSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathtensorcalcSlice::set(
  self : MathtensorcalcSlice,
  i : Int32,
  v : Double,
) -> MathtensorcalcSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcSlice::sum(self : MathtensorcalcSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathtensorcalcSlice::mean(self : MathtensorcalcSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathtensorcalcSlice::scale(
  self : MathtensorcalcSlice,
  f : Double,
) -> MathtensorcalcSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcSlice::add(
  self : MathtensorcalcSlice,
  other : MathtensorcalcSlice,
) -> MathtensorcalcSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathtensorcalcSlice::copy(
  self : MathtensorcalcSlice,
) -> MathtensorcalcSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcSlice::fill(
  self : MathtensorcalcSlice,
  v : Double,
) -> MathtensorcalcSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathtensorcalcSlice::min(self : MathtensorcalcSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathtensorcalcSlice::max(self : MathtensorcalcSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathtensorcalcSlice::to_string(self : MathtensorcalcSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
