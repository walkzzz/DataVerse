///===
/// extcore/math_galerkin

pub(all) struct MathgalerkinPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_galerkin_make_point(x : Double, y : Double) -> MathgalerkinPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_galerkin_make_point3(x : Double, y : Double, z : Double) -> MathgalerkinPoint {
  { x, y, z, label: 0 }
}

pub fn MathgalerkinPoint::x(self : MathgalerkinPoint) -> Double { self.x }

pub fn MathgalerkinPoint::y(self : MathgalerkinPoint) -> Double { self.y }

pub fn MathgalerkinPoint::z(self : MathgalerkinPoint) -> Double { self.z }

pub fn MathgalerkinPoint::label(self : MathgalerkinPoint) -> Int { self.label }

pub fn MathgalerkinPoint::dist(self : MathgalerkinPoint, other : MathgalerkinPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathgalerkinPoint::add(self : MathgalerkinPoint, other : MathgalerkinPoint) -> MathgalerkinPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathgalerkinPoint::sub(self : MathgalerkinPoint, other : MathgalerkinPoint) -> MathgalerkinPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathgalerkinPoint::scale(self : MathgalerkinPoint, s : Double) -> MathgalerkinPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathgalerkinPoint::dot(self : MathgalerkinPoint, other : MathgalerkinPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathgalerkinPoint::cross(self : MathgalerkinPoint, other : MathgalerkinPoint) -> MathgalerkinPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathgalerkinPoint::norm(self : MathgalerkinPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathgalerkinPoint::normalize(self : MathgalerkinPoint) -> MathgalerkinPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathgalerkinPoint::negate(self : MathgalerkinPoint) -> MathgalerkinPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathgalerkinPoint::mid(self : MathgalerkinPoint, other : MathgalerkinPoint) -> MathgalerkinPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathgalerkinPoint::lerp(self : MathgalerkinPoint, other : MathgalerkinPoint, t : Double) -> MathgalerkinPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathgalerkinPoint::to_string(self : MathgalerkinPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathgalerkinSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_galerkin_make_series(vals : Array[Double], name : String) -> MathgalerkinSeries {
  { vals, name, meta: 0 }
}

pub fn MathgalerkinSeries::len(self : MathgalerkinSeries) -> Int { self.vals.length() }

pub fn MathgalerkinSeries::sum(self : MathgalerkinSeries) -> Double { @_common.sum(self.vals) }

pub fn MathgalerkinSeries::mean(self : MathgalerkinSeries) -> Double { @_common.mean(self.vals) }

pub fn MathgalerkinSeries::min(self : MathgalerkinSeries) -> Double { @_common.min(self.vals) }

pub fn MathgalerkinSeries::max(self : MathgalerkinSeries) -> Double { @_common.max(self.vals) }

pub fn MathgalerkinSeries::range(self : MathgalerkinSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathgalerkinSeries::variance(self : MathgalerkinSeries) -> Double { @_common.variance(self.vals) }

pub fn MathgalerkinSeries::std(self : MathgalerkinSeries) -> Double { @_common.std(self.vals) }

pub fn MathgalerkinSeries::median(self : MathgalerkinSeries) -> Double { @_common.median(self.vals) }

pub fn MathgalerkinSeries::scale(self : MathgalerkinSeries, f : Double) -> MathgalerkinSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathgalerkinSeries::add(self : MathgalerkinSeries, other : MathgalerkinSeries) -> MathgalerkinSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathgalerkinSeries::sub(self : MathgalerkinSeries, other : MathgalerkinSeries) -> MathgalerkinSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathgalerkinSeries::normalize(self : MathgalerkinSeries) -> MathgalerkinSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathgalerkinSeries::cumsum(self : MathgalerkinSeries) -> MathgalerkinSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathgalerkinSeries::to_string(self : MathgalerkinSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathgalerkinMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_galerkin_make_matrix(rows : Int, cols : Int, val : Double) -> MathgalerkinMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_galerkin_matrix_identity(n : Int) -> MathgalerkinMatrix {
  let m = math_galerkin_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathgalerkinMatrix::get(self : MathgalerkinMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathgalerkinMatrix::transpose(self : MathgalerkinMatrix) -> MathgalerkinMatrix {
  let result = math_galerkin_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathgalerkinMatrix::add(self : MathgalerkinMatrix, other : MathgalerkinMatrix) -> MathgalerkinMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_galerkin_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathgalerkinMatrix::scale(self : MathgalerkinMatrix, s : Double) -> MathgalerkinMatrix {
  let result = math_galerkin_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathgalerkinMatrix::multiply(self : MathgalerkinMatrix, other : MathgalerkinMatrix) -> MathgalerkinMatrix {
  if self.cols != other.rows { return math_galerkin_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_galerkin_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathgalerkinMatrix::trace(self : MathgalerkinMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathgalerkinMatrix::det(self : MathgalerkinMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathgalerkinMatrix::norm(self : MathgalerkinMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathgalerkinMatrix::to_string(self : MathgalerkinMatrix) -> String {
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

pub(all) struct MathgalerkinVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_galerkin_make_vector(comps : Array[Double]) -> MathgalerkinVector {
  { comps, dim: comps.length() }
}

pub fn math_galerkin_vector_zero(dim : Int) -> MathgalerkinVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathgalerkinVector::add(self : MathgalerkinVector, other : MathgalerkinVector) -> MathgalerkinVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathgalerkinVector::sub(self : MathgalerkinVector, other : MathgalerkinVector) -> MathgalerkinVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathgalerkinVector::scale(self : MathgalerkinVector, s : Double) -> MathgalerkinVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathgalerkinVector::dot(self : MathgalerkinVector, other : MathgalerkinVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathgalerkinVector::norm(self : MathgalerkinVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathgalerkinVector::normalize(self : MathgalerkinVector) -> MathgalerkinVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathgalerkinVector::dist(self : MathgalerkinVector, other : MathgalerkinVector) -> Double {
  self.sub(other).norm()
}

pub fn MathgalerkinVector::to_string(self : MathgalerkinVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathgalerkinFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_galerkin_frame_make(size : Int) -> MathgalerkinFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathgalerkinFrame::len(self : MathgalerkinFrame) -> Int { self.size }

pub fn MathgalerkinFrame::get(self : MathgalerkinFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathgalerkinFrame::set(self : MathgalerkinFrame, i : Int, v : Double) -> MathgalerkinFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathgalerkinFrame::sum(self : MathgalerkinFrame) -> Double { @_common.sum(self.data) }

pub fn MathgalerkinFrame::mean(self : MathgalerkinFrame) -> Double { @_common.mean(self.data) }

pub fn MathgalerkinFrame::scale(self : MathgalerkinFrame, f : Double) -> MathgalerkinFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathgalerkinFrame::add(self : MathgalerkinFrame, other : MathgalerkinFrame) -> MathgalerkinFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathgalerkinFrame::copy(self : MathgalerkinFrame) -> MathgalerkinFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathgalerkinFrame::fill(self : MathgalerkinFrame, v : Double) -> MathgalerkinFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathgalerkinFrame::min(self : MathgalerkinFrame) -> Double { @_common.min(self.data) }

pub fn MathgalerkinFrame::max(self : MathgalerkinFrame) -> Double { @_common.max(self.data) }

pub fn MathgalerkinFrame::to_string(self : MathgalerkinFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathgalerkinTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_galerkin_table_make(size : Int) -> MathgalerkinTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathgalerkinTable::len(self : MathgalerkinTable) -> Int { self.size }

pub fn MathgalerkinTable::get(self : MathgalerkinTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathgalerkinTable::set(self : MathgalerkinTable, i : Int, v : Double) -> MathgalerkinTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathgalerkinTable::sum(self : MathgalerkinTable) -> Double { @_common.sum(self.data) }

pub fn MathgalerkinTable::mean(self : MathgalerkinTable) -> Double { @_common.mean(self.data) }

pub fn MathgalerkinTable::scale(self : MathgalerkinTable, f : Double) -> MathgalerkinTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathgalerkinTable::add(self : MathgalerkinTable, other : MathgalerkinTable) -> MathgalerkinTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathgalerkinTable::copy(self : MathgalerkinTable) -> MathgalerkinTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathgalerkinTable::fill(self : MathgalerkinTable, v : Double) -> MathgalerkinTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathgalerkinTable::min(self : MathgalerkinTable) -> Double { @_common.min(self.data) }

pub fn MathgalerkinTable::max(self : MathgalerkinTable) -> Double { @_common.max(self.data) }

pub fn MathgalerkinTable::to_string(self : MathgalerkinTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathgalerkinGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_galerkin_graphn_make(size : Int) -> MathgalerkinGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathgalerkinGraphN::len(self : MathgalerkinGraphN) -> Int { self.size }

pub fn MathgalerkinGraphN::get(self : MathgalerkinGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathgalerkinGraphN::set(self : MathgalerkinGraphN, i : Int, v : Double) -> MathgalerkinGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathgalerkinGraphN::sum(self : MathgalerkinGraphN) -> Double { @_common.sum(self.data) }

pub fn MathgalerkinGraphN::mean(self : MathgalerkinGraphN) -> Double { @_common.mean(self.data) }

pub fn MathgalerkinGraphN::scale(self : MathgalerkinGraphN, f : Double) -> MathgalerkinGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathgalerkinGraphN::add(self : MathgalerkinGraphN, other : MathgalerkinGraphN) -> MathgalerkinGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathgalerkinGraphN::copy(self : MathgalerkinGraphN) -> MathgalerkinGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathgalerkinGraphN::fill(self : MathgalerkinGraphN, v : Double) -> MathgalerkinGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathgalerkinGraphN::min(self : MathgalerkinGraphN) -> Double { @_common.min(self.data) }

pub fn MathgalerkinGraphN::max(self : MathgalerkinGraphN) -> Double { @_common.max(self.data) }

pub fn MathgalerkinGraphN::to_string(self : MathgalerkinGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathgalerkinNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_galerkin_node_make(size : Int) -> MathgalerkinNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathgalerkinNode::len(self : MathgalerkinNode) -> Int { self.size }

pub fn MathgalerkinNode::get(self : MathgalerkinNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathgalerkinNode::set(self : MathgalerkinNode, i : Int, v : Double) -> MathgalerkinNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathgalerkinNode::sum(self : MathgalerkinNode) -> Double { @_common.sum(self.data) }

pub fn MathgalerkinNode::mean(self : MathgalerkinNode) -> Double { @_common.mean(self.data) }

pub fn MathgalerkinNode::scale(self : MathgalerkinNode, f : Double) -> MathgalerkinNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathgalerkinNode::add(self : MathgalerkinNode, other : MathgalerkinNode) -> MathgalerkinNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathgalerkinNode::copy(self : MathgalerkinNode) -> MathgalerkinNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathgalerkinNode::fill(self : MathgalerkinNode, v : Double) -> MathgalerkinNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathgalerkinNode::min(self : MathgalerkinNode) -> Double { @_common.min(self.data) }

pub fn MathgalerkinNode::max(self : MathgalerkinNode) -> Double { @_common.max(self.data) }

pub fn MathgalerkinNode::to_string(self : MathgalerkinNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathgalerkinEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_galerkin_edge_make(size : Int) -> MathgalerkinEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathgalerkinEdge::len(self : MathgalerkinEdge) -> Int { self.size }

pub fn MathgalerkinEdge::get(self : MathgalerkinEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathgalerkinEdge::set(self : MathgalerkinEdge, i : Int, v : Double) -> MathgalerkinEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathgalerkinEdge::sum(self : MathgalerkinEdge) -> Double { @_common.sum(self.data) }

pub fn MathgalerkinEdge::mean(self : MathgalerkinEdge) -> Double { @_common.mean(self.data) }

pub fn MathgalerkinEdge::scale(self : MathgalerkinEdge, f : Double) -> MathgalerkinEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathgalerkinEdge::add(self : MathgalerkinEdge, other : MathgalerkinEdge) -> MathgalerkinEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathgalerkinEdge::copy(self : MathgalerkinEdge) -> MathgalerkinEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathgalerkinEdge::fill(self : MathgalerkinEdge, v : Double) -> MathgalerkinEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathgalerkinEdge::min(self : MathgalerkinEdge) -> Double { @_common.min(self.data) }

pub fn MathgalerkinEdge::max(self : MathgalerkinEdge) -> Double { @_common.max(self.data) }

pub fn MathgalerkinEdge::to_string(self : MathgalerkinEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathgalerkinPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_galerkin_path_make(size : Int) -> MathgalerkinPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathgalerkinPath::len(self : MathgalerkinPath) -> Int { self.size }

pub fn MathgalerkinPath::get(self : MathgalerkinPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathgalerkinPath::set(self : MathgalerkinPath, i : Int, v : Double) -> MathgalerkinPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathgalerkinPath::sum(self : MathgalerkinPath) -> Double { @_common.sum(self.data) }

pub fn MathgalerkinPath::mean(self : MathgalerkinPath) -> Double { @_common.mean(self.data) }

pub fn MathgalerkinPath::scale(self : MathgalerkinPath, f : Double) -> MathgalerkinPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathgalerkinPath::add(self : MathgalerkinPath, other : MathgalerkinPath) -> MathgalerkinPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathgalerkinPath::copy(self : MathgalerkinPath) -> MathgalerkinPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathgalerkinPath::fill(self : MathgalerkinPath, v : Double) -> MathgalerkinPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathgalerkinPath::min(self : MathgalerkinPath) -> Double { @_common.min(self.data) }

pub fn MathgalerkinPath::max(self : MathgalerkinPath) -> Double { @_common.max(self.data) }

pub fn MathgalerkinPath::to_string(self : MathgalerkinPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathgalerkinCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_galerkin_cluster_make(size : Int) -> MathgalerkinCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathgalerkinCluster::len(self : MathgalerkinCluster) -> Int { self.size }

pub fn MathgalerkinCluster::get(self : MathgalerkinCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathgalerkinCluster::set(self : MathgalerkinCluster, i : Int, v : Double) -> MathgalerkinCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathgalerkinCluster::sum(self : MathgalerkinCluster) -> Double { @_common.sum(self.data) }

pub fn MathgalerkinCluster::mean(self : MathgalerkinCluster) -> Double { @_common.mean(self.data) }

pub fn MathgalerkinCluster::scale(self : MathgalerkinCluster, f : Double) -> MathgalerkinCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathgalerkinCluster::add(self : MathgalerkinCluster, other : MathgalerkinCluster) -> MathgalerkinCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathgalerkinCluster::copy(self : MathgalerkinCluster) -> MathgalerkinCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathgalerkinCluster::fill(self : MathgalerkinCluster, v : Double) -> MathgalerkinCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathgalerkinCluster::min(self : MathgalerkinCluster) -> Double { @_common.min(self.data) }

pub fn MathgalerkinCluster::max(self : MathgalerkinCluster) -> Double { @_common.max(self.data) }

pub fn MathgalerkinCluster::to_string(self : MathgalerkinCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathgalerkinModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_galerkin_model_make(size : Int) -> MathgalerkinModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathgalerkinModel::len(self : MathgalerkinModel) -> Int { self.size }

pub fn MathgalerkinModel::get(self : MathgalerkinModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathgalerkinModel::set(self : MathgalerkinModel, i : Int, v : Double) -> MathgalerkinModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathgalerkinModel::sum(self : MathgalerkinModel) -> Double { @_common.sum(self.data) }

pub fn MathgalerkinModel::mean(self : MathgalerkinModel) -> Double { @_common.mean(self.data) }

pub fn MathgalerkinModel::scale(self : MathgalerkinModel, f : Double) -> MathgalerkinModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathgalerkinModel::add(self : MathgalerkinModel, other : MathgalerkinModel) -> MathgalerkinModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathgalerkinModel::copy(self : MathgalerkinModel) -> MathgalerkinModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathgalerkinModel::fill(self : MathgalerkinModel, v : Double) -> MathgalerkinModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathgalerkinModel::min(self : MathgalerkinModel) -> Double { @_common.min(self.data) }

pub fn MathgalerkinModel::max(self : MathgalerkinModel) -> Double { @_common.max(self.data) }

pub fn MathgalerkinModel::to_string(self : MathgalerkinModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathgalerkinLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_galerkin_layer_make(size : Int) -> MathgalerkinLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathgalerkinLayer::len(self : MathgalerkinLayer) -> Int { self.size }

pub fn MathgalerkinLayer::get(self : MathgalerkinLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathgalerkinLayer::set(self : MathgalerkinLayer, i : Int, v : Double) -> MathgalerkinLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathgalerkinLayer::sum(self : MathgalerkinLayer) -> Double { @_common.sum(self.data) }

pub fn MathgalerkinLayer::mean(self : MathgalerkinLayer) -> Double { @_common.mean(self.data) }

pub fn MathgalerkinLayer::scale(self : MathgalerkinLayer, f : Double) -> MathgalerkinLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathgalerkinLayer::add(self : MathgalerkinLayer, other : MathgalerkinLayer) -> MathgalerkinLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathgalerkinLayer::copy(self : MathgalerkinLayer) -> MathgalerkinLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathgalerkinLayer::fill(self : MathgalerkinLayer, v : Double) -> MathgalerkinLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathgalerkinLayer::min(self : MathgalerkinLayer) -> Double { @_common.min(self.data) }

pub fn MathgalerkinLayer::max(self : MathgalerkinLayer) -> Double { @_common.max(self.data) }

pub fn MathgalerkinLayer::to_string(self : MathgalerkinLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathgalerkinBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_galerkin_buffer_make(size : Int) -> MathgalerkinBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathgalerkinBuffer::len(self : MathgalerkinBuffer) -> Int { self.size }

pub fn MathgalerkinBuffer::get(self : MathgalerkinBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathgalerkinBuffer::set(self : MathgalerkinBuffer, i : Int, v : Double) -> MathgalerkinBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathgalerkinBuffer::sum(self : MathgalerkinBuffer) -> Double { @_common.sum(self.data) }

pub fn MathgalerkinBuffer::mean(self : MathgalerkinBuffer) -> Double { @_common.mean(self.data) }

pub fn MathgalerkinBuffer::scale(self : MathgalerkinBuffer, f : Double) -> MathgalerkinBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathgalerkinBuffer::add(self : MathgalerkinBuffer, other : MathgalerkinBuffer) -> MathgalerkinBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathgalerkinBuffer::copy(self : MathgalerkinBuffer) -> MathgalerkinBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathgalerkinBuffer::fill(self : MathgalerkinBuffer, v : Double) -> MathgalerkinBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathgalerkinBuffer::min(self : MathgalerkinBuffer) -> Double { @_common.min(self.data) }

pub fn MathgalerkinBuffer::max(self : MathgalerkinBuffer) -> Double { @_common.max(self.data) }

pub fn MathgalerkinBuffer::to_string(self : MathgalerkinBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathgalerkinCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_galerkin_cursor_make(size : Int) -> MathgalerkinCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathgalerkinCursor::len(self : MathgalerkinCursor) -> Int { self.size }

pub fn MathgalerkinCursor::get(self : MathgalerkinCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathgalerkinCursor::set(self : MathgalerkinCursor, i : Int, v : Double) -> MathgalerkinCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathgalerkinCursor::sum(self : MathgalerkinCursor) -> Double { @_common.sum(self.data) }

pub fn MathgalerkinCursor::mean(self : MathgalerkinCursor) -> Double { @_common.mean(self.data) }

pub fn MathgalerkinCursor::scale(self : MathgalerkinCursor, f : Double) -> MathgalerkinCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathgalerkinCursor::add(self : MathgalerkinCursor, other : MathgalerkinCursor) -> MathgalerkinCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathgalerkinCursor::copy(self : MathgalerkinCursor) -> MathgalerkinCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathgalerkinCursor::fill(self : MathgalerkinCursor, v : Double) -> MathgalerkinCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathgalerkinCursor::min(self : MathgalerkinCursor) -> Double { @_common.min(self.data) }

pub fn MathgalerkinCursor::max(self : MathgalerkinCursor) -> Double { @_common.max(self.data) }

pub fn MathgalerkinCursor::to_string(self : MathgalerkinCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathgalerkinView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_galerkin_view_make(size : Int) -> MathgalerkinView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathgalerkinView::len(self : MathgalerkinView) -> Int { self.size }

pub fn MathgalerkinView::get(self : MathgalerkinView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathgalerkinView::set(self : MathgalerkinView, i : Int, v : Double) -> MathgalerkinView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathgalerkinView::sum(self : MathgalerkinView) -> Double { @_common.sum(self.data) }

pub fn MathgalerkinView::mean(self : MathgalerkinView) -> Double { @_common.mean(self.data) }

pub fn MathgalerkinView::scale(self : MathgalerkinView, f : Double) -> MathgalerkinView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathgalerkinView::add(self : MathgalerkinView, other : MathgalerkinView) -> MathgalerkinView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathgalerkinView::copy(self : MathgalerkinView) -> MathgalerkinView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathgalerkinView::fill(self : MathgalerkinView, v : Double) -> MathgalerkinView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathgalerkinView::min(self : MathgalerkinView) -> Double { @_common.min(self.data) }

pub fn MathgalerkinView::max(self : MathgalerkinView) -> Double { @_common.max(self.data) }

pub fn MathgalerkinView::to_string(self : MathgalerkinView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathgalerkinRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_galerkin_range_make(size : Int) -> MathgalerkinRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathgalerkinRange::len(self : MathgalerkinRange) -> Int { self.size }

pub fn MathgalerkinRange::get(self : MathgalerkinRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathgalerkinRange::set(self : MathgalerkinRange, i : Int, v : Double) -> MathgalerkinRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathgalerkinRange::sum(self : MathgalerkinRange) -> Double { @_common.sum(self.data) }

pub fn MathgalerkinRange::mean(self : MathgalerkinRange) -> Double { @_common.mean(self.data) }

pub fn MathgalerkinRange::scale(self : MathgalerkinRange, f : Double) -> MathgalerkinRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathgalerkinRange::add(self : MathgalerkinRange, other : MathgalerkinRange) -> MathgalerkinRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathgalerkinRange::copy(self : MathgalerkinRange) -> MathgalerkinRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathgalerkinRange::fill(self : MathgalerkinRange, v : Double) -> MathgalerkinRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathgalerkinRange::min(self : MathgalerkinRange) -> Double { @_common.min(self.data) }

pub fn MathgalerkinRange::max(self : MathgalerkinRange) -> Double { @_common.max(self.data) }

pub fn MathgalerkinRange::to_string(self : MathgalerkinRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathgalerkinSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_galerkin_slice_make(size : Int) -> MathgalerkinSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathgalerkinSlice::len(self : MathgalerkinSlice) -> Int { self.size }

pub fn MathgalerkinSlice::get(self : MathgalerkinSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathgalerkinSlice::set(self : MathgalerkinSlice, i : Int, v : Double) -> MathgalerkinSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathgalerkinSlice::sum(self : MathgalerkinSlice) -> Double { @_common.sum(self.data) }

pub fn MathgalerkinSlice::mean(self : MathgalerkinSlice) -> Double { @_common.mean(self.data) }

pub fn MathgalerkinSlice::scale(self : MathgalerkinSlice, f : Double) -> MathgalerkinSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathgalerkinSlice::add(self : MathgalerkinSlice, other : MathgalerkinSlice) -> MathgalerkinSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathgalerkinSlice::copy(self : MathgalerkinSlice) -> MathgalerkinSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathgalerkinSlice::fill(self : MathgalerkinSlice, v : Double) -> MathgalerkinSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathgalerkinSlice::min(self : MathgalerkinSlice) -> Double { @_common.min(self.data) }

pub fn MathgalerkinSlice::max(self : MathgalerkinSlice) -> Double { @_common.max(self.data) }

pub fn MathgalerkinSlice::to_string(self : MathgalerkinSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

