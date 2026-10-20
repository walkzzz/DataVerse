///===
/// extcore/geo_buffer_triangle

pub(all) struct GeobuffertrianglePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_buffer_triangle_make_point(x : Double, y : Double) -> GeobuffertrianglePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_buffer_triangle_make_point3(x : Double, y : Double, z : Double) -> GeobuffertrianglePoint {
  { x, y, z, label: 0 }
}

pub fn GeobuffertrianglePoint::x(self : GeobuffertrianglePoint) -> Double { self.x }

pub fn GeobuffertrianglePoint::y(self : GeobuffertrianglePoint) -> Double { self.y }

pub fn GeobuffertrianglePoint::z(self : GeobuffertrianglePoint) -> Double { self.z }

pub fn GeobuffertrianglePoint::label(self : GeobuffertrianglePoint) -> Int { self.label }

pub fn GeobuffertrianglePoint::dist(self : GeobuffertrianglePoint, other : GeobuffertrianglePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeobuffertrianglePoint::add(self : GeobuffertrianglePoint, other : GeobuffertrianglePoint) -> GeobuffertrianglePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeobuffertrianglePoint::sub(self : GeobuffertrianglePoint, other : GeobuffertrianglePoint) -> GeobuffertrianglePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeobuffertrianglePoint::scale(self : GeobuffertrianglePoint, s : Double) -> GeobuffertrianglePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeobuffertrianglePoint::dot(self : GeobuffertrianglePoint, other : GeobuffertrianglePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeobuffertrianglePoint::cross(self : GeobuffertrianglePoint, other : GeobuffertrianglePoint) -> GeobuffertrianglePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeobuffertrianglePoint::norm(self : GeobuffertrianglePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeobuffertrianglePoint::normalize(self : GeobuffertrianglePoint) -> GeobuffertrianglePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeobuffertrianglePoint::negate(self : GeobuffertrianglePoint) -> GeobuffertrianglePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeobuffertrianglePoint::mid(self : GeobuffertrianglePoint, other : GeobuffertrianglePoint) -> GeobuffertrianglePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeobuffertrianglePoint::lerp(self : GeobuffertrianglePoint, other : GeobuffertrianglePoint, t : Double) -> GeobuffertrianglePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeobuffertrianglePoint::to_string(self : GeobuffertrianglePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeobuffertriangleSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_buffer_triangle_make_series(vals : Array[Double], name : String) -> GeobuffertriangleSeries {
  { vals, name, meta: 0 }
}

pub fn GeobuffertriangleSeries::len(self : GeobuffertriangleSeries) -> Int { self.vals.length() }

pub fn GeobuffertriangleSeries::sum(self : GeobuffertriangleSeries) -> Double { @_common.sum(self.vals) }

pub fn GeobuffertriangleSeries::mean(self : GeobuffertriangleSeries) -> Double { @_common.mean(self.vals) }

pub fn GeobuffertriangleSeries::min(self : GeobuffertriangleSeries) -> Double { @_common.min(self.vals) }

pub fn GeobuffertriangleSeries::max(self : GeobuffertriangleSeries) -> Double { @_common.max(self.vals) }

pub fn GeobuffertriangleSeries::range(self : GeobuffertriangleSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeobuffertriangleSeries::variance(self : GeobuffertriangleSeries) -> Double { @_common.variance(self.vals) }

pub fn GeobuffertriangleSeries::std(self : GeobuffertriangleSeries) -> Double { @_common.std(self.vals) }

pub fn GeobuffertriangleSeries::median(self : GeobuffertriangleSeries) -> Double { @_common.median(self.vals) }

pub fn GeobuffertriangleSeries::scale(self : GeobuffertriangleSeries, f : Double) -> GeobuffertriangleSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeobuffertriangleSeries::add(self : GeobuffertriangleSeries, other : GeobuffertriangleSeries) -> GeobuffertriangleSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeobuffertriangleSeries::sub(self : GeobuffertriangleSeries, other : GeobuffertriangleSeries) -> GeobuffertriangleSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeobuffertriangleSeries::normalize(self : GeobuffertriangleSeries) -> GeobuffertriangleSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeobuffertriangleSeries::cumsum(self : GeobuffertriangleSeries) -> GeobuffertriangleSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeobuffertriangleSeries::to_string(self : GeobuffertriangleSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeobuffertriangleMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_buffer_triangle_make_matrix(rows : Int, cols : Int, val : Double) -> GeobuffertriangleMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn geo_buffer_triangle_matrix_identity(n : Int) -> GeobuffertriangleMatrix {
  let m = geo_buffer_triangle_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeobuffertriangleMatrix::get(self : GeobuffertriangleMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeobuffertriangleMatrix::transpose(self : GeobuffertriangleMatrix) -> GeobuffertriangleMatrix {
  let result = geo_buffer_triangle_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeobuffertriangleMatrix::add(self : GeobuffertriangleMatrix, other : GeobuffertriangleMatrix) -> GeobuffertriangleMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_buffer_triangle_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeobuffertriangleMatrix::scale(self : GeobuffertriangleMatrix, s : Double) -> GeobuffertriangleMatrix {
  let result = geo_buffer_triangle_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeobuffertriangleMatrix::multiply(self : GeobuffertriangleMatrix, other : GeobuffertriangleMatrix) -> GeobuffertriangleMatrix {
  if self.cols != other.rows { return geo_buffer_triangle_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_buffer_triangle_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn GeobuffertriangleMatrix::trace(self : GeobuffertriangleMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeobuffertriangleMatrix::det(self : GeobuffertriangleMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeobuffertriangleMatrix::norm(self : GeobuffertriangleMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeobuffertriangleMatrix::to_string(self : GeobuffertriangleMatrix) -> String {
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

pub(all) struct GeobuffertriangleVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_buffer_triangle_make_vector(comps : Array[Double]) -> GeobuffertriangleVector {
  { comps, dim: comps.length() }
}

pub fn geo_buffer_triangle_vector_zero(dim : Int) -> GeobuffertriangleVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeobuffertriangleVector::add(self : GeobuffertriangleVector, other : GeobuffertriangleVector) -> GeobuffertriangleVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeobuffertriangleVector::sub(self : GeobuffertriangleVector, other : GeobuffertriangleVector) -> GeobuffertriangleVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeobuffertriangleVector::scale(self : GeobuffertriangleVector, s : Double) -> GeobuffertriangleVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeobuffertriangleVector::dot(self : GeobuffertriangleVector, other : GeobuffertriangleVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeobuffertriangleVector::norm(self : GeobuffertriangleVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeobuffertriangleVector::normalize(self : GeobuffertriangleVector) -> GeobuffertriangleVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeobuffertriangleVector::dist(self : GeobuffertriangleVector, other : GeobuffertriangleVector) -> Double {
  self.sub(other).norm()
}

pub fn GeobuffertriangleVector::to_string(self : GeobuffertriangleVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeobuffertriangleFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_triangle_frame_make(size : Int) -> GeobuffertriangleFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffertriangleFrame::len(self : GeobuffertriangleFrame) -> Int { self.size }

pub fn GeobuffertriangleFrame::get(self : GeobuffertriangleFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffertriangleFrame::set(self : GeobuffertriangleFrame, i : Int, v : Double) -> GeobuffertriangleFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleFrame::sum(self : GeobuffertriangleFrame) -> Double { @_common.sum(self.data) }

pub fn GeobuffertriangleFrame::mean(self : GeobuffertriangleFrame) -> Double { @_common.mean(self.data) }

pub fn GeobuffertriangleFrame::scale(self : GeobuffertriangleFrame, f : Double) -> GeobuffertriangleFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleFrame::add(self : GeobuffertriangleFrame, other : GeobuffertriangleFrame) -> GeobuffertriangleFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffertriangleFrame::copy(self : GeobuffertriangleFrame) -> GeobuffertriangleFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleFrame::fill(self : GeobuffertriangleFrame, v : Double) -> GeobuffertriangleFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleFrame::min(self : GeobuffertriangleFrame) -> Double { @_common.min(self.data) }

pub fn GeobuffertriangleFrame::max(self : GeobuffertriangleFrame) -> Double { @_common.max(self.data) }

pub fn GeobuffertriangleFrame::to_string(self : GeobuffertriangleFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffertriangleTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_triangle_table_make(size : Int) -> GeobuffertriangleTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffertriangleTable::len(self : GeobuffertriangleTable) -> Int { self.size }

pub fn GeobuffertriangleTable::get(self : GeobuffertriangleTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffertriangleTable::set(self : GeobuffertriangleTable, i : Int, v : Double) -> GeobuffertriangleTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleTable::sum(self : GeobuffertriangleTable) -> Double { @_common.sum(self.data) }

pub fn GeobuffertriangleTable::mean(self : GeobuffertriangleTable) -> Double { @_common.mean(self.data) }

pub fn GeobuffertriangleTable::scale(self : GeobuffertriangleTable, f : Double) -> GeobuffertriangleTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleTable::add(self : GeobuffertriangleTable, other : GeobuffertriangleTable) -> GeobuffertriangleTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffertriangleTable::copy(self : GeobuffertriangleTable) -> GeobuffertriangleTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleTable::fill(self : GeobuffertriangleTable, v : Double) -> GeobuffertriangleTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleTable::min(self : GeobuffertriangleTable) -> Double { @_common.min(self.data) }

pub fn GeobuffertriangleTable::max(self : GeobuffertriangleTable) -> Double { @_common.max(self.data) }

pub fn GeobuffertriangleTable::to_string(self : GeobuffertriangleTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffertriangleGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_triangle_graphn_make(size : Int) -> GeobuffertriangleGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffertriangleGraphN::len(self : GeobuffertriangleGraphN) -> Int { self.size }

pub fn GeobuffertriangleGraphN::get(self : GeobuffertriangleGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffertriangleGraphN::set(self : GeobuffertriangleGraphN, i : Int, v : Double) -> GeobuffertriangleGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleGraphN::sum(self : GeobuffertriangleGraphN) -> Double { @_common.sum(self.data) }

pub fn GeobuffertriangleGraphN::mean(self : GeobuffertriangleGraphN) -> Double { @_common.mean(self.data) }

pub fn GeobuffertriangleGraphN::scale(self : GeobuffertriangleGraphN, f : Double) -> GeobuffertriangleGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleGraphN::add(self : GeobuffertriangleGraphN, other : GeobuffertriangleGraphN) -> GeobuffertriangleGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffertriangleGraphN::copy(self : GeobuffertriangleGraphN) -> GeobuffertriangleGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleGraphN::fill(self : GeobuffertriangleGraphN, v : Double) -> GeobuffertriangleGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleGraphN::min(self : GeobuffertriangleGraphN) -> Double { @_common.min(self.data) }

pub fn GeobuffertriangleGraphN::max(self : GeobuffertriangleGraphN) -> Double { @_common.max(self.data) }

pub fn GeobuffertriangleGraphN::to_string(self : GeobuffertriangleGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffertriangleNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_triangle_node_make(size : Int) -> GeobuffertriangleNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffertriangleNode::len(self : GeobuffertriangleNode) -> Int { self.size }

pub fn GeobuffertriangleNode::get(self : GeobuffertriangleNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffertriangleNode::set(self : GeobuffertriangleNode, i : Int, v : Double) -> GeobuffertriangleNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleNode::sum(self : GeobuffertriangleNode) -> Double { @_common.sum(self.data) }

pub fn GeobuffertriangleNode::mean(self : GeobuffertriangleNode) -> Double { @_common.mean(self.data) }

pub fn GeobuffertriangleNode::scale(self : GeobuffertriangleNode, f : Double) -> GeobuffertriangleNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleNode::add(self : GeobuffertriangleNode, other : GeobuffertriangleNode) -> GeobuffertriangleNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffertriangleNode::copy(self : GeobuffertriangleNode) -> GeobuffertriangleNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleNode::fill(self : GeobuffertriangleNode, v : Double) -> GeobuffertriangleNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleNode::min(self : GeobuffertriangleNode) -> Double { @_common.min(self.data) }

pub fn GeobuffertriangleNode::max(self : GeobuffertriangleNode) -> Double { @_common.max(self.data) }

pub fn GeobuffertriangleNode::to_string(self : GeobuffertriangleNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffertriangleEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_triangle_edge_make(size : Int) -> GeobuffertriangleEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffertriangleEdge::len(self : GeobuffertriangleEdge) -> Int { self.size }

pub fn GeobuffertriangleEdge::get(self : GeobuffertriangleEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffertriangleEdge::set(self : GeobuffertriangleEdge, i : Int, v : Double) -> GeobuffertriangleEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleEdge::sum(self : GeobuffertriangleEdge) -> Double { @_common.sum(self.data) }

pub fn GeobuffertriangleEdge::mean(self : GeobuffertriangleEdge) -> Double { @_common.mean(self.data) }

pub fn GeobuffertriangleEdge::scale(self : GeobuffertriangleEdge, f : Double) -> GeobuffertriangleEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleEdge::add(self : GeobuffertriangleEdge, other : GeobuffertriangleEdge) -> GeobuffertriangleEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffertriangleEdge::copy(self : GeobuffertriangleEdge) -> GeobuffertriangleEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleEdge::fill(self : GeobuffertriangleEdge, v : Double) -> GeobuffertriangleEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleEdge::min(self : GeobuffertriangleEdge) -> Double { @_common.min(self.data) }

pub fn GeobuffertriangleEdge::max(self : GeobuffertriangleEdge) -> Double { @_common.max(self.data) }

pub fn GeobuffertriangleEdge::to_string(self : GeobuffertriangleEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffertrianglePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_triangle_path_make(size : Int) -> GeobuffertrianglePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffertrianglePath::len(self : GeobuffertrianglePath) -> Int { self.size }

pub fn GeobuffertrianglePath::get(self : GeobuffertrianglePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffertrianglePath::set(self : GeobuffertrianglePath, i : Int, v : Double) -> GeobuffertrianglePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffertrianglePath::sum(self : GeobuffertrianglePath) -> Double { @_common.sum(self.data) }

pub fn GeobuffertrianglePath::mean(self : GeobuffertrianglePath) -> Double { @_common.mean(self.data) }

pub fn GeobuffertrianglePath::scale(self : GeobuffertrianglePath, f : Double) -> GeobuffertrianglePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffertrianglePath::add(self : GeobuffertrianglePath, other : GeobuffertrianglePath) -> GeobuffertrianglePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffertrianglePath::copy(self : GeobuffertrianglePath) -> GeobuffertrianglePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffertrianglePath::fill(self : GeobuffertrianglePath, v : Double) -> GeobuffertrianglePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffertrianglePath::min(self : GeobuffertrianglePath) -> Double { @_common.min(self.data) }

pub fn GeobuffertrianglePath::max(self : GeobuffertrianglePath) -> Double { @_common.max(self.data) }

pub fn GeobuffertrianglePath::to_string(self : GeobuffertrianglePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffertriangleCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_triangle_cluster_make(size : Int) -> GeobuffertriangleCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffertriangleCluster::len(self : GeobuffertriangleCluster) -> Int { self.size }

pub fn GeobuffertriangleCluster::get(self : GeobuffertriangleCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffertriangleCluster::set(self : GeobuffertriangleCluster, i : Int, v : Double) -> GeobuffertriangleCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleCluster::sum(self : GeobuffertriangleCluster) -> Double { @_common.sum(self.data) }

pub fn GeobuffertriangleCluster::mean(self : GeobuffertriangleCluster) -> Double { @_common.mean(self.data) }

pub fn GeobuffertriangleCluster::scale(self : GeobuffertriangleCluster, f : Double) -> GeobuffertriangleCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleCluster::add(self : GeobuffertriangleCluster, other : GeobuffertriangleCluster) -> GeobuffertriangleCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffertriangleCluster::copy(self : GeobuffertriangleCluster) -> GeobuffertriangleCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleCluster::fill(self : GeobuffertriangleCluster, v : Double) -> GeobuffertriangleCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleCluster::min(self : GeobuffertriangleCluster) -> Double { @_common.min(self.data) }

pub fn GeobuffertriangleCluster::max(self : GeobuffertriangleCluster) -> Double { @_common.max(self.data) }

pub fn GeobuffertriangleCluster::to_string(self : GeobuffertriangleCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffertriangleModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_triangle_model_make(size : Int) -> GeobuffertriangleModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffertriangleModel::len(self : GeobuffertriangleModel) -> Int { self.size }

pub fn GeobuffertriangleModel::get(self : GeobuffertriangleModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffertriangleModel::set(self : GeobuffertriangleModel, i : Int, v : Double) -> GeobuffertriangleModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleModel::sum(self : GeobuffertriangleModel) -> Double { @_common.sum(self.data) }

pub fn GeobuffertriangleModel::mean(self : GeobuffertriangleModel) -> Double { @_common.mean(self.data) }

pub fn GeobuffertriangleModel::scale(self : GeobuffertriangleModel, f : Double) -> GeobuffertriangleModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleModel::add(self : GeobuffertriangleModel, other : GeobuffertriangleModel) -> GeobuffertriangleModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffertriangleModel::copy(self : GeobuffertriangleModel) -> GeobuffertriangleModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleModel::fill(self : GeobuffertriangleModel, v : Double) -> GeobuffertriangleModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleModel::min(self : GeobuffertriangleModel) -> Double { @_common.min(self.data) }

pub fn GeobuffertriangleModel::max(self : GeobuffertriangleModel) -> Double { @_common.max(self.data) }

pub fn GeobuffertriangleModel::to_string(self : GeobuffertriangleModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffertriangleLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_triangle_layer_make(size : Int) -> GeobuffertriangleLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffertriangleLayer::len(self : GeobuffertriangleLayer) -> Int { self.size }

pub fn GeobuffertriangleLayer::get(self : GeobuffertriangleLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffertriangleLayer::set(self : GeobuffertriangleLayer, i : Int, v : Double) -> GeobuffertriangleLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleLayer::sum(self : GeobuffertriangleLayer) -> Double { @_common.sum(self.data) }

pub fn GeobuffertriangleLayer::mean(self : GeobuffertriangleLayer) -> Double { @_common.mean(self.data) }

pub fn GeobuffertriangleLayer::scale(self : GeobuffertriangleLayer, f : Double) -> GeobuffertriangleLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleLayer::add(self : GeobuffertriangleLayer, other : GeobuffertriangleLayer) -> GeobuffertriangleLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffertriangleLayer::copy(self : GeobuffertriangleLayer) -> GeobuffertriangleLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleLayer::fill(self : GeobuffertriangleLayer, v : Double) -> GeobuffertriangleLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleLayer::min(self : GeobuffertriangleLayer) -> Double { @_common.min(self.data) }

pub fn GeobuffertriangleLayer::max(self : GeobuffertriangleLayer) -> Double { @_common.max(self.data) }

pub fn GeobuffertriangleLayer::to_string(self : GeobuffertriangleLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffertriangleBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_triangle_buffer_make(size : Int) -> GeobuffertriangleBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffertriangleBuffer::len(self : GeobuffertriangleBuffer) -> Int { self.size }

pub fn GeobuffertriangleBuffer::get(self : GeobuffertriangleBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffertriangleBuffer::set(self : GeobuffertriangleBuffer, i : Int, v : Double) -> GeobuffertriangleBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleBuffer::sum(self : GeobuffertriangleBuffer) -> Double { @_common.sum(self.data) }

pub fn GeobuffertriangleBuffer::mean(self : GeobuffertriangleBuffer) -> Double { @_common.mean(self.data) }

pub fn GeobuffertriangleBuffer::scale(self : GeobuffertriangleBuffer, f : Double) -> GeobuffertriangleBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleBuffer::add(self : GeobuffertriangleBuffer, other : GeobuffertriangleBuffer) -> GeobuffertriangleBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffertriangleBuffer::copy(self : GeobuffertriangleBuffer) -> GeobuffertriangleBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleBuffer::fill(self : GeobuffertriangleBuffer, v : Double) -> GeobuffertriangleBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleBuffer::min(self : GeobuffertriangleBuffer) -> Double { @_common.min(self.data) }

pub fn GeobuffertriangleBuffer::max(self : GeobuffertriangleBuffer) -> Double { @_common.max(self.data) }

pub fn GeobuffertriangleBuffer::to_string(self : GeobuffertriangleBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffertriangleCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_triangle_cursor_make(size : Int) -> GeobuffertriangleCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffertriangleCursor::len(self : GeobuffertriangleCursor) -> Int { self.size }

pub fn GeobuffertriangleCursor::get(self : GeobuffertriangleCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffertriangleCursor::set(self : GeobuffertriangleCursor, i : Int, v : Double) -> GeobuffertriangleCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleCursor::sum(self : GeobuffertriangleCursor) -> Double { @_common.sum(self.data) }

pub fn GeobuffertriangleCursor::mean(self : GeobuffertriangleCursor) -> Double { @_common.mean(self.data) }

pub fn GeobuffertriangleCursor::scale(self : GeobuffertriangleCursor, f : Double) -> GeobuffertriangleCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleCursor::add(self : GeobuffertriangleCursor, other : GeobuffertriangleCursor) -> GeobuffertriangleCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffertriangleCursor::copy(self : GeobuffertriangleCursor) -> GeobuffertriangleCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleCursor::fill(self : GeobuffertriangleCursor, v : Double) -> GeobuffertriangleCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleCursor::min(self : GeobuffertriangleCursor) -> Double { @_common.min(self.data) }

pub fn GeobuffertriangleCursor::max(self : GeobuffertriangleCursor) -> Double { @_common.max(self.data) }

pub fn GeobuffertriangleCursor::to_string(self : GeobuffertriangleCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffertriangleView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_triangle_view_make(size : Int) -> GeobuffertriangleView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffertriangleView::len(self : GeobuffertriangleView) -> Int { self.size }

pub fn GeobuffertriangleView::get(self : GeobuffertriangleView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffertriangleView::set(self : GeobuffertriangleView, i : Int, v : Double) -> GeobuffertriangleView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleView::sum(self : GeobuffertriangleView) -> Double { @_common.sum(self.data) }

pub fn GeobuffertriangleView::mean(self : GeobuffertriangleView) -> Double { @_common.mean(self.data) }

pub fn GeobuffertriangleView::scale(self : GeobuffertriangleView, f : Double) -> GeobuffertriangleView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleView::add(self : GeobuffertriangleView, other : GeobuffertriangleView) -> GeobuffertriangleView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffertriangleView::copy(self : GeobuffertriangleView) -> GeobuffertriangleView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleView::fill(self : GeobuffertriangleView, v : Double) -> GeobuffertriangleView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleView::min(self : GeobuffertriangleView) -> Double { @_common.min(self.data) }

pub fn GeobuffertriangleView::max(self : GeobuffertriangleView) -> Double { @_common.max(self.data) }

pub fn GeobuffertriangleView::to_string(self : GeobuffertriangleView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffertriangleRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_triangle_range_make(size : Int) -> GeobuffertriangleRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffertriangleRange::len(self : GeobuffertriangleRange) -> Int { self.size }

pub fn GeobuffertriangleRange::get(self : GeobuffertriangleRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffertriangleRange::set(self : GeobuffertriangleRange, i : Int, v : Double) -> GeobuffertriangleRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleRange::sum(self : GeobuffertriangleRange) -> Double { @_common.sum(self.data) }

pub fn GeobuffertriangleRange::mean(self : GeobuffertriangleRange) -> Double { @_common.mean(self.data) }

pub fn GeobuffertriangleRange::scale(self : GeobuffertriangleRange, f : Double) -> GeobuffertriangleRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleRange::add(self : GeobuffertriangleRange, other : GeobuffertriangleRange) -> GeobuffertriangleRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffertriangleRange::copy(self : GeobuffertriangleRange) -> GeobuffertriangleRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleRange::fill(self : GeobuffertriangleRange, v : Double) -> GeobuffertriangleRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleRange::min(self : GeobuffertriangleRange) -> Double { @_common.min(self.data) }

pub fn GeobuffertriangleRange::max(self : GeobuffertriangleRange) -> Double { @_common.max(self.data) }

pub fn GeobuffertriangleRange::to_string(self : GeobuffertriangleRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeobuffertriangleSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_triangle_slice_make(size : Int) -> GeobuffertriangleSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeobuffertriangleSlice::len(self : GeobuffertriangleSlice) -> Int { self.size }

pub fn GeobuffertriangleSlice::get(self : GeobuffertriangleSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeobuffertriangleSlice::set(self : GeobuffertriangleSlice, i : Int, v : Double) -> GeobuffertriangleSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleSlice::sum(self : GeobuffertriangleSlice) -> Double { @_common.sum(self.data) }

pub fn GeobuffertriangleSlice::mean(self : GeobuffertriangleSlice) -> Double { @_common.mean(self.data) }

pub fn GeobuffertriangleSlice::scale(self : GeobuffertriangleSlice, f : Double) -> GeobuffertriangleSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleSlice::add(self : GeobuffertriangleSlice, other : GeobuffertriangleSlice) -> GeobuffertriangleSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeobuffertriangleSlice::copy(self : GeobuffertriangleSlice) -> GeobuffertriangleSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleSlice::fill(self : GeobuffertriangleSlice, v : Double) -> GeobuffertriangleSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeobuffertriangleSlice::min(self : GeobuffertriangleSlice) -> Double { @_common.min(self.data) }

pub fn GeobuffertriangleSlice::max(self : GeobuffertriangleSlice) -> Double { @_common.max(self.data) }

pub fn GeobuffertriangleSlice::to_string(self : GeobuffertriangleSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

