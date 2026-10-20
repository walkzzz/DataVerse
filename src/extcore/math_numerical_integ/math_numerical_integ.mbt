///===
/// extcore/math_numerical_integ

pub(all) struct MathnumericalintegPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_numerical_integ_make_point(x : Double, y : Double) -> MathnumericalintegPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_numerical_integ_make_point3(x : Double, y : Double, z : Double) -> MathnumericalintegPoint {
  { x, y, z, label: 0 }
}

pub fn MathnumericalintegPoint::x(self : MathnumericalintegPoint) -> Double { self.x }

pub fn MathnumericalintegPoint::y(self : MathnumericalintegPoint) -> Double { self.y }

pub fn MathnumericalintegPoint::z(self : MathnumericalintegPoint) -> Double { self.z }

pub fn MathnumericalintegPoint::label(self : MathnumericalintegPoint) -> Int { self.label }

pub fn MathnumericalintegPoint::dist(self : MathnumericalintegPoint, other : MathnumericalintegPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathnumericalintegPoint::add(self : MathnumericalintegPoint, other : MathnumericalintegPoint) -> MathnumericalintegPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathnumericalintegPoint::sub(self : MathnumericalintegPoint, other : MathnumericalintegPoint) -> MathnumericalintegPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathnumericalintegPoint::scale(self : MathnumericalintegPoint, s : Double) -> MathnumericalintegPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathnumericalintegPoint::dot(self : MathnumericalintegPoint, other : MathnumericalintegPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathnumericalintegPoint::cross(self : MathnumericalintegPoint, other : MathnumericalintegPoint) -> MathnumericalintegPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathnumericalintegPoint::norm(self : MathnumericalintegPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathnumericalintegPoint::normalize(self : MathnumericalintegPoint) -> MathnumericalintegPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathnumericalintegPoint::negate(self : MathnumericalintegPoint) -> MathnumericalintegPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathnumericalintegPoint::mid(self : MathnumericalintegPoint, other : MathnumericalintegPoint) -> MathnumericalintegPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathnumericalintegPoint::lerp(self : MathnumericalintegPoint, other : MathnumericalintegPoint, t : Double) -> MathnumericalintegPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathnumericalintegPoint::to_string(self : MathnumericalintegPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathnumericalintegSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_numerical_integ_make_series(vals : Array[Double], name : String) -> MathnumericalintegSeries {
  { vals, name, meta: 0 }
}

pub fn MathnumericalintegSeries::len(self : MathnumericalintegSeries) -> Int { self.vals.length() }

pub fn MathnumericalintegSeries::sum(self : MathnumericalintegSeries) -> Double { @_common.sum(self.vals) }

pub fn MathnumericalintegSeries::mean(self : MathnumericalintegSeries) -> Double { @_common.mean(self.vals) }

pub fn MathnumericalintegSeries::min(self : MathnumericalintegSeries) -> Double { @_common.min(self.vals) }

pub fn MathnumericalintegSeries::max(self : MathnumericalintegSeries) -> Double { @_common.max(self.vals) }

pub fn MathnumericalintegSeries::range(self : MathnumericalintegSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathnumericalintegSeries::variance(self : MathnumericalintegSeries) -> Double { @_common.variance(self.vals) }

pub fn MathnumericalintegSeries::std(self : MathnumericalintegSeries) -> Double { @_common.std(self.vals) }

pub fn MathnumericalintegSeries::median(self : MathnumericalintegSeries) -> Double { @_common.median(self.vals) }

pub fn MathnumericalintegSeries::scale(self : MathnumericalintegSeries, f : Double) -> MathnumericalintegSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathnumericalintegSeries::add(self : MathnumericalintegSeries, other : MathnumericalintegSeries) -> MathnumericalintegSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathnumericalintegSeries::sub(self : MathnumericalintegSeries, other : MathnumericalintegSeries) -> MathnumericalintegSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathnumericalintegSeries::normalize(self : MathnumericalintegSeries) -> MathnumericalintegSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathnumericalintegSeries::cumsum(self : MathnumericalintegSeries) -> MathnumericalintegSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathnumericalintegSeries::to_string(self : MathnumericalintegSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathnumericalintegMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_numerical_integ_make_matrix(rows : Int, cols : Int, val : Double) -> MathnumericalintegMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn math_numerical_integ_matrix_identity(n : Int) -> MathnumericalintegMatrix {
  let m = math_numerical_integ_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathnumericalintegMatrix::get(self : MathnumericalintegMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathnumericalintegMatrix::transpose(self : MathnumericalintegMatrix) -> MathnumericalintegMatrix {
  let result = math_numerical_integ_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathnumericalintegMatrix::add(self : MathnumericalintegMatrix, other : MathnumericalintegMatrix) -> MathnumericalintegMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_numerical_integ_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathnumericalintegMatrix::scale(self : MathnumericalintegMatrix, s : Double) -> MathnumericalintegMatrix {
  let result = math_numerical_integ_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathnumericalintegMatrix::multiply(self : MathnumericalintegMatrix, other : MathnumericalintegMatrix) -> MathnumericalintegMatrix {
  if self.cols != other.rows { return math_numerical_integ_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_numerical_integ_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MathnumericalintegMatrix::trace(self : MathnumericalintegMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathnumericalintegMatrix::det(self : MathnumericalintegMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathnumericalintegMatrix::norm(self : MathnumericalintegMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathnumericalintegMatrix::to_string(self : MathnumericalintegMatrix) -> String {
  let mut result = "Mat(" + self.rows.to_string() + "x" + self.cols.to_string() + ")\n"
  let rl = if self.rows < 5 { self.rows } else { 5 }
  let cl = if self.cols < 5 { self.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + @_common.dbl(self.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct MathnumericalintegVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_numerical_integ_make_vector(comps : Array[Double]) -> MathnumericalintegVector {
  { comps, dim: comps.length() }
}

pub fn math_numerical_integ_vector_zero(dim : Int) -> MathnumericalintegVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathnumericalintegVector::add(self : MathnumericalintegVector, other : MathnumericalintegVector) -> MathnumericalintegVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathnumericalintegVector::sub(self : MathnumericalintegVector, other : MathnumericalintegVector) -> MathnumericalintegVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathnumericalintegVector::scale(self : MathnumericalintegVector, s : Double) -> MathnumericalintegVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathnumericalintegVector::dot(self : MathnumericalintegVector, other : MathnumericalintegVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathnumericalintegVector::norm(self : MathnumericalintegVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathnumericalintegVector::normalize(self : MathnumericalintegVector) -> MathnumericalintegVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathnumericalintegVector::dist(self : MathnumericalintegVector, other : MathnumericalintegVector) -> Double {
  self.sub(other).norm()
}

pub fn MathnumericalintegVector::to_string(self : MathnumericalintegVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathnumericalintegFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_integ_frame_make(size : Int) -> MathnumericalintegFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathnumericalintegFrame::len(self : MathnumericalintegFrame) -> Int { self.size }

pub fn MathnumericalintegFrame::get(self : MathnumericalintegFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathnumericalintegFrame::set(self : MathnumericalintegFrame, i : Int, v : Double) -> MathnumericalintegFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathnumericalintegFrame::sum(self : MathnumericalintegFrame) -> Double { @_common.sum(self.data) }

pub fn MathnumericalintegFrame::mean(self : MathnumericalintegFrame) -> Double { @_common.mean(self.data) }

pub fn MathnumericalintegFrame::scale(self : MathnumericalintegFrame, f : Double) -> MathnumericalintegFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathnumericalintegFrame::add(self : MathnumericalintegFrame, other : MathnumericalintegFrame) -> MathnumericalintegFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathnumericalintegFrame::copy(self : MathnumericalintegFrame) -> MathnumericalintegFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathnumericalintegFrame::fill(self : MathnumericalintegFrame, v : Double) -> MathnumericalintegFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathnumericalintegFrame::min(self : MathnumericalintegFrame) -> Double { @_common.min(self.data) }

pub fn MathnumericalintegFrame::max(self : MathnumericalintegFrame) -> Double { @_common.max(self.data) }

pub fn MathnumericalintegFrame::to_string(self : MathnumericalintegFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathnumericalintegTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_integ_table_make(size : Int) -> MathnumericalintegTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathnumericalintegTable::len(self : MathnumericalintegTable) -> Int { self.size }

pub fn MathnumericalintegTable::get(self : MathnumericalintegTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathnumericalintegTable::set(self : MathnumericalintegTable, i : Int, v : Double) -> MathnumericalintegTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathnumericalintegTable::sum(self : MathnumericalintegTable) -> Double { @_common.sum(self.data) }

pub fn MathnumericalintegTable::mean(self : MathnumericalintegTable) -> Double { @_common.mean(self.data) }

pub fn MathnumericalintegTable::scale(self : MathnumericalintegTable, f : Double) -> MathnumericalintegTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathnumericalintegTable::add(self : MathnumericalintegTable, other : MathnumericalintegTable) -> MathnumericalintegTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathnumericalintegTable::copy(self : MathnumericalintegTable) -> MathnumericalintegTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathnumericalintegTable::fill(self : MathnumericalintegTable, v : Double) -> MathnumericalintegTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathnumericalintegTable::min(self : MathnumericalintegTable) -> Double { @_common.min(self.data) }

pub fn MathnumericalintegTable::max(self : MathnumericalintegTable) -> Double { @_common.max(self.data) }

pub fn MathnumericalintegTable::to_string(self : MathnumericalintegTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathnumericalintegGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_integ_graphn_make(size : Int) -> MathnumericalintegGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathnumericalintegGraphN::len(self : MathnumericalintegGraphN) -> Int { self.size }

pub fn MathnumericalintegGraphN::get(self : MathnumericalintegGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathnumericalintegGraphN::set(self : MathnumericalintegGraphN, i : Int, v : Double) -> MathnumericalintegGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathnumericalintegGraphN::sum(self : MathnumericalintegGraphN) -> Double { @_common.sum(self.data) }

pub fn MathnumericalintegGraphN::mean(self : MathnumericalintegGraphN) -> Double { @_common.mean(self.data) }

pub fn MathnumericalintegGraphN::scale(self : MathnumericalintegGraphN, f : Double) -> MathnumericalintegGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathnumericalintegGraphN::add(self : MathnumericalintegGraphN, other : MathnumericalintegGraphN) -> MathnumericalintegGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathnumericalintegGraphN::copy(self : MathnumericalintegGraphN) -> MathnumericalintegGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathnumericalintegGraphN::fill(self : MathnumericalintegGraphN, v : Double) -> MathnumericalintegGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathnumericalintegGraphN::min(self : MathnumericalintegGraphN) -> Double { @_common.min(self.data) }

pub fn MathnumericalintegGraphN::max(self : MathnumericalintegGraphN) -> Double { @_common.max(self.data) }

pub fn MathnumericalintegGraphN::to_string(self : MathnumericalintegGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathnumericalintegNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_integ_node_make(size : Int) -> MathnumericalintegNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathnumericalintegNode::len(self : MathnumericalintegNode) -> Int { self.size }

pub fn MathnumericalintegNode::get(self : MathnumericalintegNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathnumericalintegNode::set(self : MathnumericalintegNode, i : Int, v : Double) -> MathnumericalintegNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathnumericalintegNode::sum(self : MathnumericalintegNode) -> Double { @_common.sum(self.data) }

pub fn MathnumericalintegNode::mean(self : MathnumericalintegNode) -> Double { @_common.mean(self.data) }

pub fn MathnumericalintegNode::scale(self : MathnumericalintegNode, f : Double) -> MathnumericalintegNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathnumericalintegNode::add(self : MathnumericalintegNode, other : MathnumericalintegNode) -> MathnumericalintegNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathnumericalintegNode::copy(self : MathnumericalintegNode) -> MathnumericalintegNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathnumericalintegNode::fill(self : MathnumericalintegNode, v : Double) -> MathnumericalintegNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathnumericalintegNode::min(self : MathnumericalintegNode) -> Double { @_common.min(self.data) }

pub fn MathnumericalintegNode::max(self : MathnumericalintegNode) -> Double { @_common.max(self.data) }

pub fn MathnumericalintegNode::to_string(self : MathnumericalintegNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathnumericalintegEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_integ_edge_make(size : Int) -> MathnumericalintegEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathnumericalintegEdge::len(self : MathnumericalintegEdge) -> Int { self.size }

pub fn MathnumericalintegEdge::get(self : MathnumericalintegEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathnumericalintegEdge::set(self : MathnumericalintegEdge, i : Int, v : Double) -> MathnumericalintegEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathnumericalintegEdge::sum(self : MathnumericalintegEdge) -> Double { @_common.sum(self.data) }

pub fn MathnumericalintegEdge::mean(self : MathnumericalintegEdge) -> Double { @_common.mean(self.data) }

pub fn MathnumericalintegEdge::scale(self : MathnumericalintegEdge, f : Double) -> MathnumericalintegEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathnumericalintegEdge::add(self : MathnumericalintegEdge, other : MathnumericalintegEdge) -> MathnumericalintegEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathnumericalintegEdge::copy(self : MathnumericalintegEdge) -> MathnumericalintegEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathnumericalintegEdge::fill(self : MathnumericalintegEdge, v : Double) -> MathnumericalintegEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathnumericalintegEdge::min(self : MathnumericalintegEdge) -> Double { @_common.min(self.data) }

pub fn MathnumericalintegEdge::max(self : MathnumericalintegEdge) -> Double { @_common.max(self.data) }

pub fn MathnumericalintegEdge::to_string(self : MathnumericalintegEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathnumericalintegPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_integ_path_make(size : Int) -> MathnumericalintegPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathnumericalintegPath::len(self : MathnumericalintegPath) -> Int { self.size }

pub fn MathnumericalintegPath::get(self : MathnumericalintegPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathnumericalintegPath::set(self : MathnumericalintegPath, i : Int, v : Double) -> MathnumericalintegPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathnumericalintegPath::sum(self : MathnumericalintegPath) -> Double { @_common.sum(self.data) }

pub fn MathnumericalintegPath::mean(self : MathnumericalintegPath) -> Double { @_common.mean(self.data) }

pub fn MathnumericalintegPath::scale(self : MathnumericalintegPath, f : Double) -> MathnumericalintegPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathnumericalintegPath::add(self : MathnumericalintegPath, other : MathnumericalintegPath) -> MathnumericalintegPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathnumericalintegPath::copy(self : MathnumericalintegPath) -> MathnumericalintegPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathnumericalintegPath::fill(self : MathnumericalintegPath, v : Double) -> MathnumericalintegPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathnumericalintegPath::min(self : MathnumericalintegPath) -> Double { @_common.min(self.data) }

pub fn MathnumericalintegPath::max(self : MathnumericalintegPath) -> Double { @_common.max(self.data) }

pub fn MathnumericalintegPath::to_string(self : MathnumericalintegPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathnumericalintegCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_integ_cluster_make(size : Int) -> MathnumericalintegCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathnumericalintegCluster::len(self : MathnumericalintegCluster) -> Int { self.size }

pub fn MathnumericalintegCluster::get(self : MathnumericalintegCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathnumericalintegCluster::set(self : MathnumericalintegCluster, i : Int, v : Double) -> MathnumericalintegCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathnumericalintegCluster::sum(self : MathnumericalintegCluster) -> Double { @_common.sum(self.data) }

pub fn MathnumericalintegCluster::mean(self : MathnumericalintegCluster) -> Double { @_common.mean(self.data) }

pub fn MathnumericalintegCluster::scale(self : MathnumericalintegCluster, f : Double) -> MathnumericalintegCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathnumericalintegCluster::add(self : MathnumericalintegCluster, other : MathnumericalintegCluster) -> MathnumericalintegCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathnumericalintegCluster::copy(self : MathnumericalintegCluster) -> MathnumericalintegCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathnumericalintegCluster::fill(self : MathnumericalintegCluster, v : Double) -> MathnumericalintegCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathnumericalintegCluster::min(self : MathnumericalintegCluster) -> Double { @_common.min(self.data) }

pub fn MathnumericalintegCluster::max(self : MathnumericalintegCluster) -> Double { @_common.max(self.data) }

pub fn MathnumericalintegCluster::to_string(self : MathnumericalintegCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathnumericalintegModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_integ_model_make(size : Int) -> MathnumericalintegModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathnumericalintegModel::len(self : MathnumericalintegModel) -> Int { self.size }

pub fn MathnumericalintegModel::get(self : MathnumericalintegModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathnumericalintegModel::set(self : MathnumericalintegModel, i : Int, v : Double) -> MathnumericalintegModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathnumericalintegModel::sum(self : MathnumericalintegModel) -> Double { @_common.sum(self.data) }

pub fn MathnumericalintegModel::mean(self : MathnumericalintegModel) -> Double { @_common.mean(self.data) }

pub fn MathnumericalintegModel::scale(self : MathnumericalintegModel, f : Double) -> MathnumericalintegModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathnumericalintegModel::add(self : MathnumericalintegModel, other : MathnumericalintegModel) -> MathnumericalintegModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathnumericalintegModel::copy(self : MathnumericalintegModel) -> MathnumericalintegModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathnumericalintegModel::fill(self : MathnumericalintegModel, v : Double) -> MathnumericalintegModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathnumericalintegModel::min(self : MathnumericalintegModel) -> Double { @_common.min(self.data) }

pub fn MathnumericalintegModel::max(self : MathnumericalintegModel) -> Double { @_common.max(self.data) }

pub fn MathnumericalintegModel::to_string(self : MathnumericalintegModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathnumericalintegLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_integ_layer_make(size : Int) -> MathnumericalintegLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathnumericalintegLayer::len(self : MathnumericalintegLayer) -> Int { self.size }

pub fn MathnumericalintegLayer::get(self : MathnumericalintegLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathnumericalintegLayer::set(self : MathnumericalintegLayer, i : Int, v : Double) -> MathnumericalintegLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathnumericalintegLayer::sum(self : MathnumericalintegLayer) -> Double { @_common.sum(self.data) }

pub fn MathnumericalintegLayer::mean(self : MathnumericalintegLayer) -> Double { @_common.mean(self.data) }

pub fn MathnumericalintegLayer::scale(self : MathnumericalintegLayer, f : Double) -> MathnumericalintegLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathnumericalintegLayer::add(self : MathnumericalintegLayer, other : MathnumericalintegLayer) -> MathnumericalintegLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathnumericalintegLayer::copy(self : MathnumericalintegLayer) -> MathnumericalintegLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathnumericalintegLayer::fill(self : MathnumericalintegLayer, v : Double) -> MathnumericalintegLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathnumericalintegLayer::min(self : MathnumericalintegLayer) -> Double { @_common.min(self.data) }

pub fn MathnumericalintegLayer::max(self : MathnumericalintegLayer) -> Double { @_common.max(self.data) }

pub fn MathnumericalintegLayer::to_string(self : MathnumericalintegLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathnumericalintegBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_integ_buffer_make(size : Int) -> MathnumericalintegBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathnumericalintegBuffer::len(self : MathnumericalintegBuffer) -> Int { self.size }

pub fn MathnumericalintegBuffer::get(self : MathnumericalintegBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathnumericalintegBuffer::set(self : MathnumericalintegBuffer, i : Int, v : Double) -> MathnumericalintegBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathnumericalintegBuffer::sum(self : MathnumericalintegBuffer) -> Double { @_common.sum(self.data) }

pub fn MathnumericalintegBuffer::mean(self : MathnumericalintegBuffer) -> Double { @_common.mean(self.data) }

pub fn MathnumericalintegBuffer::scale(self : MathnumericalintegBuffer, f : Double) -> MathnumericalintegBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathnumericalintegBuffer::add(self : MathnumericalintegBuffer, other : MathnumericalintegBuffer) -> MathnumericalintegBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathnumericalintegBuffer::copy(self : MathnumericalintegBuffer) -> MathnumericalintegBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathnumericalintegBuffer::fill(self : MathnumericalintegBuffer, v : Double) -> MathnumericalintegBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathnumericalintegBuffer::min(self : MathnumericalintegBuffer) -> Double { @_common.min(self.data) }

pub fn MathnumericalintegBuffer::max(self : MathnumericalintegBuffer) -> Double { @_common.max(self.data) }

pub fn MathnumericalintegBuffer::to_string(self : MathnumericalintegBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathnumericalintegCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_integ_cursor_make(size : Int) -> MathnumericalintegCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathnumericalintegCursor::len(self : MathnumericalintegCursor) -> Int { self.size }

pub fn MathnumericalintegCursor::get(self : MathnumericalintegCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathnumericalintegCursor::set(self : MathnumericalintegCursor, i : Int, v : Double) -> MathnumericalintegCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathnumericalintegCursor::sum(self : MathnumericalintegCursor) -> Double { @_common.sum(self.data) }

pub fn MathnumericalintegCursor::mean(self : MathnumericalintegCursor) -> Double { @_common.mean(self.data) }

pub fn MathnumericalintegCursor::scale(self : MathnumericalintegCursor, f : Double) -> MathnumericalintegCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathnumericalintegCursor::add(self : MathnumericalintegCursor, other : MathnumericalintegCursor) -> MathnumericalintegCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathnumericalintegCursor::copy(self : MathnumericalintegCursor) -> MathnumericalintegCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathnumericalintegCursor::fill(self : MathnumericalintegCursor, v : Double) -> MathnumericalintegCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathnumericalintegCursor::min(self : MathnumericalintegCursor) -> Double { @_common.min(self.data) }

pub fn MathnumericalintegCursor::max(self : MathnumericalintegCursor) -> Double { @_common.max(self.data) }

pub fn MathnumericalintegCursor::to_string(self : MathnumericalintegCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathnumericalintegView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_integ_view_make(size : Int) -> MathnumericalintegView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathnumericalintegView::len(self : MathnumericalintegView) -> Int { self.size }

pub fn MathnumericalintegView::get(self : MathnumericalintegView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathnumericalintegView::set(self : MathnumericalintegView, i : Int, v : Double) -> MathnumericalintegView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathnumericalintegView::sum(self : MathnumericalintegView) -> Double { @_common.sum(self.data) }

pub fn MathnumericalintegView::mean(self : MathnumericalintegView) -> Double { @_common.mean(self.data) }

pub fn MathnumericalintegView::scale(self : MathnumericalintegView, f : Double) -> MathnumericalintegView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathnumericalintegView::add(self : MathnumericalintegView, other : MathnumericalintegView) -> MathnumericalintegView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathnumericalintegView::copy(self : MathnumericalintegView) -> MathnumericalintegView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathnumericalintegView::fill(self : MathnumericalintegView, v : Double) -> MathnumericalintegView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathnumericalintegView::min(self : MathnumericalintegView) -> Double { @_common.min(self.data) }

pub fn MathnumericalintegView::max(self : MathnumericalintegView) -> Double { @_common.max(self.data) }

pub fn MathnumericalintegView::to_string(self : MathnumericalintegView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathnumericalintegRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_integ_range_make(size : Int) -> MathnumericalintegRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathnumericalintegRange::len(self : MathnumericalintegRange) -> Int { self.size }

pub fn MathnumericalintegRange::get(self : MathnumericalintegRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathnumericalintegRange::set(self : MathnumericalintegRange, i : Int, v : Double) -> MathnumericalintegRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathnumericalintegRange::sum(self : MathnumericalintegRange) -> Double { @_common.sum(self.data) }

pub fn MathnumericalintegRange::mean(self : MathnumericalintegRange) -> Double { @_common.mean(self.data) }

pub fn MathnumericalintegRange::scale(self : MathnumericalintegRange, f : Double) -> MathnumericalintegRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathnumericalintegRange::add(self : MathnumericalintegRange, other : MathnumericalintegRange) -> MathnumericalintegRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathnumericalintegRange::copy(self : MathnumericalintegRange) -> MathnumericalintegRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathnumericalintegRange::fill(self : MathnumericalintegRange, v : Double) -> MathnumericalintegRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathnumericalintegRange::min(self : MathnumericalintegRange) -> Double { @_common.min(self.data) }

pub fn MathnumericalintegRange::max(self : MathnumericalintegRange) -> Double { @_common.max(self.data) }

pub fn MathnumericalintegRange::to_string(self : MathnumericalintegRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathnumericalintegSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_integ_slice_make(size : Int) -> MathnumericalintegSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathnumericalintegSlice::len(self : MathnumericalintegSlice) -> Int { self.size }

pub fn MathnumericalintegSlice::get(self : MathnumericalintegSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathnumericalintegSlice::set(self : MathnumericalintegSlice, i : Int, v : Double) -> MathnumericalintegSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathnumericalintegSlice::sum(self : MathnumericalintegSlice) -> Double { @_common.sum(self.data) }

pub fn MathnumericalintegSlice::mean(self : MathnumericalintegSlice) -> Double { @_common.mean(self.data) }

pub fn MathnumericalintegSlice::scale(self : MathnumericalintegSlice, f : Double) -> MathnumericalintegSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathnumericalintegSlice::add(self : MathnumericalintegSlice, other : MathnumericalintegSlice) -> MathnumericalintegSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathnumericalintegSlice::copy(self : MathnumericalintegSlice) -> MathnumericalintegSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathnumericalintegSlice::fill(self : MathnumericalintegSlice, v : Double) -> MathnumericalintegSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathnumericalintegSlice::min(self : MathnumericalintegSlice) -> Double { @_common.min(self.data) }

pub fn MathnumericalintegSlice::max(self : MathnumericalintegSlice) -> Double { @_common.max(self.data) }

pub fn MathnumericalintegSlice::to_string(self : MathnumericalintegSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

