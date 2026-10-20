///===
/// extcore/math_approx_pade

pub(all) struct MathapproxpadePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_approx_pade_make_point(x : Double, y : Double) -> MathapproxpadePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_approx_pade_make_point3(x : Double, y : Double, z : Double) -> MathapproxpadePoint {
  { x, y, z, label: 0 }
}

pub fn MathapproxpadePoint::x(self : MathapproxpadePoint) -> Double { self.x }

pub fn MathapproxpadePoint::y(self : MathapproxpadePoint) -> Double { self.y }

pub fn MathapproxpadePoint::z(self : MathapproxpadePoint) -> Double { self.z }

pub fn MathapproxpadePoint::label(self : MathapproxpadePoint) -> Int { self.label }

pub fn MathapproxpadePoint::dist(self : MathapproxpadePoint, other : MathapproxpadePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathapproxpadePoint::add(self : MathapproxpadePoint, other : MathapproxpadePoint) -> MathapproxpadePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathapproxpadePoint::sub(self : MathapproxpadePoint, other : MathapproxpadePoint) -> MathapproxpadePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathapproxpadePoint::scale(self : MathapproxpadePoint, s : Double) -> MathapproxpadePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathapproxpadePoint::dot(self : MathapproxpadePoint, other : MathapproxpadePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathapproxpadePoint::cross(self : MathapproxpadePoint, other : MathapproxpadePoint) -> MathapproxpadePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathapproxpadePoint::norm(self : MathapproxpadePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathapproxpadePoint::normalize(self : MathapproxpadePoint) -> MathapproxpadePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathapproxpadePoint::negate(self : MathapproxpadePoint) -> MathapproxpadePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathapproxpadePoint::mid(self : MathapproxpadePoint, other : MathapproxpadePoint) -> MathapproxpadePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathapproxpadePoint::lerp(self : MathapproxpadePoint, other : MathapproxpadePoint, t : Double) -> MathapproxpadePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathapproxpadePoint::to_string(self : MathapproxpadePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathapproxpadeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_approx_pade_make_series(vals : Array[Double], name : String) -> MathapproxpadeSeries {
  { vals, name, meta: 0 }
}

pub fn MathapproxpadeSeries::len(self : MathapproxpadeSeries) -> Int { self.vals.length() }

pub fn MathapproxpadeSeries::sum(self : MathapproxpadeSeries) -> Double { @_common.sum(self.vals) }

pub fn MathapproxpadeSeries::mean(self : MathapproxpadeSeries) -> Double { @_common.mean(self.vals) }

pub fn MathapproxpadeSeries::min(self : MathapproxpadeSeries) -> Double { @_common.min(self.vals) }

pub fn MathapproxpadeSeries::max(self : MathapproxpadeSeries) -> Double { @_common.max(self.vals) }

pub fn MathapproxpadeSeries::range(self : MathapproxpadeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathapproxpadeSeries::variance(self : MathapproxpadeSeries) -> Double { @_common.variance(self.vals) }

pub fn MathapproxpadeSeries::std(self : MathapproxpadeSeries) -> Double { @_common.std(self.vals) }

pub fn MathapproxpadeSeries::median(self : MathapproxpadeSeries) -> Double { @_common.median(self.vals) }

pub fn MathapproxpadeSeries::scale(self : MathapproxpadeSeries, f : Double) -> MathapproxpadeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathapproxpadeSeries::add(self : MathapproxpadeSeries, other : MathapproxpadeSeries) -> MathapproxpadeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathapproxpadeSeries::sub(self : MathapproxpadeSeries, other : MathapproxpadeSeries) -> MathapproxpadeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathapproxpadeSeries::normalize(self : MathapproxpadeSeries) -> MathapproxpadeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathapproxpadeSeries::cumsum(self : MathapproxpadeSeries) -> MathapproxpadeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathapproxpadeSeries::to_string(self : MathapproxpadeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathapproxpadeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_approx_pade_make_matrix(rows : Int, cols : Int, val : Double) -> MathapproxpadeMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn math_approx_pade_matrix_identity(n : Int) -> MathapproxpadeMatrix {
  let m = math_approx_pade_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathapproxpadeMatrix::get(self : MathapproxpadeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathapproxpadeMatrix::transpose(self : MathapproxpadeMatrix) -> MathapproxpadeMatrix {
  let result = math_approx_pade_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathapproxpadeMatrix::add(self : MathapproxpadeMatrix, other : MathapproxpadeMatrix) -> MathapproxpadeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_approx_pade_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathapproxpadeMatrix::scale(self : MathapproxpadeMatrix, s : Double) -> MathapproxpadeMatrix {
  let result = math_approx_pade_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathapproxpadeMatrix::multiply(self : MathapproxpadeMatrix, other : MathapproxpadeMatrix) -> MathapproxpadeMatrix {
  if self.cols != other.rows { return math_approx_pade_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_approx_pade_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MathapproxpadeMatrix::trace(self : MathapproxpadeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathapproxpadeMatrix::det(self : MathapproxpadeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathapproxpadeMatrix::norm(self : MathapproxpadeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathapproxpadeMatrix::to_string(self : MathapproxpadeMatrix) -> String {
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

pub(all) struct MathapproxpadeVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_approx_pade_make_vector(comps : Array[Double]) -> MathapproxpadeVector {
  { comps, dim: comps.length() }
}

pub fn math_approx_pade_vector_zero(dim : Int) -> MathapproxpadeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathapproxpadeVector::add(self : MathapproxpadeVector, other : MathapproxpadeVector) -> MathapproxpadeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathapproxpadeVector::sub(self : MathapproxpadeVector, other : MathapproxpadeVector) -> MathapproxpadeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathapproxpadeVector::scale(self : MathapproxpadeVector, s : Double) -> MathapproxpadeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathapproxpadeVector::dot(self : MathapproxpadeVector, other : MathapproxpadeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathapproxpadeVector::norm(self : MathapproxpadeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathapproxpadeVector::normalize(self : MathapproxpadeVector) -> MathapproxpadeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathapproxpadeVector::dist(self : MathapproxpadeVector, other : MathapproxpadeVector) -> Double {
  self.sub(other).norm()
}

pub fn MathapproxpadeVector::to_string(self : MathapproxpadeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathapproxpadeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_pade_frame_make(size : Int) -> MathapproxpadeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxpadeFrame::len(self : MathapproxpadeFrame) -> Int { self.size }

pub fn MathapproxpadeFrame::get(self : MathapproxpadeFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxpadeFrame::set(self : MathapproxpadeFrame, i : Int, v : Double) -> MathapproxpadeFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxpadeFrame::sum(self : MathapproxpadeFrame) -> Double { @_common.sum(self.data) }

pub fn MathapproxpadeFrame::mean(self : MathapproxpadeFrame) -> Double { @_common.mean(self.data) }

pub fn MathapproxpadeFrame::scale(self : MathapproxpadeFrame, f : Double) -> MathapproxpadeFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxpadeFrame::add(self : MathapproxpadeFrame, other : MathapproxpadeFrame) -> MathapproxpadeFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxpadeFrame::copy(self : MathapproxpadeFrame) -> MathapproxpadeFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxpadeFrame::fill(self : MathapproxpadeFrame, v : Double) -> MathapproxpadeFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxpadeFrame::min(self : MathapproxpadeFrame) -> Double { @_common.min(self.data) }

pub fn MathapproxpadeFrame::max(self : MathapproxpadeFrame) -> Double { @_common.max(self.data) }

pub fn MathapproxpadeFrame::to_string(self : MathapproxpadeFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxpadeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_pade_table_make(size : Int) -> MathapproxpadeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxpadeTable::len(self : MathapproxpadeTable) -> Int { self.size }

pub fn MathapproxpadeTable::get(self : MathapproxpadeTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxpadeTable::set(self : MathapproxpadeTable, i : Int, v : Double) -> MathapproxpadeTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxpadeTable::sum(self : MathapproxpadeTable) -> Double { @_common.sum(self.data) }

pub fn MathapproxpadeTable::mean(self : MathapproxpadeTable) -> Double { @_common.mean(self.data) }

pub fn MathapproxpadeTable::scale(self : MathapproxpadeTable, f : Double) -> MathapproxpadeTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxpadeTable::add(self : MathapproxpadeTable, other : MathapproxpadeTable) -> MathapproxpadeTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxpadeTable::copy(self : MathapproxpadeTable) -> MathapproxpadeTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxpadeTable::fill(self : MathapproxpadeTable, v : Double) -> MathapproxpadeTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxpadeTable::min(self : MathapproxpadeTable) -> Double { @_common.min(self.data) }

pub fn MathapproxpadeTable::max(self : MathapproxpadeTable) -> Double { @_common.max(self.data) }

pub fn MathapproxpadeTable::to_string(self : MathapproxpadeTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxpadeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_pade_graphn_make(size : Int) -> MathapproxpadeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxpadeGraphN::len(self : MathapproxpadeGraphN) -> Int { self.size }

pub fn MathapproxpadeGraphN::get(self : MathapproxpadeGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxpadeGraphN::set(self : MathapproxpadeGraphN, i : Int, v : Double) -> MathapproxpadeGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxpadeGraphN::sum(self : MathapproxpadeGraphN) -> Double { @_common.sum(self.data) }

pub fn MathapproxpadeGraphN::mean(self : MathapproxpadeGraphN) -> Double { @_common.mean(self.data) }

pub fn MathapproxpadeGraphN::scale(self : MathapproxpadeGraphN, f : Double) -> MathapproxpadeGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxpadeGraphN::add(self : MathapproxpadeGraphN, other : MathapproxpadeGraphN) -> MathapproxpadeGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxpadeGraphN::copy(self : MathapproxpadeGraphN) -> MathapproxpadeGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxpadeGraphN::fill(self : MathapproxpadeGraphN, v : Double) -> MathapproxpadeGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxpadeGraphN::min(self : MathapproxpadeGraphN) -> Double { @_common.min(self.data) }

pub fn MathapproxpadeGraphN::max(self : MathapproxpadeGraphN) -> Double { @_common.max(self.data) }

pub fn MathapproxpadeGraphN::to_string(self : MathapproxpadeGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxpadeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_pade_node_make(size : Int) -> MathapproxpadeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxpadeNode::len(self : MathapproxpadeNode) -> Int { self.size }

pub fn MathapproxpadeNode::get(self : MathapproxpadeNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxpadeNode::set(self : MathapproxpadeNode, i : Int, v : Double) -> MathapproxpadeNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxpadeNode::sum(self : MathapproxpadeNode) -> Double { @_common.sum(self.data) }

pub fn MathapproxpadeNode::mean(self : MathapproxpadeNode) -> Double { @_common.mean(self.data) }

pub fn MathapproxpadeNode::scale(self : MathapproxpadeNode, f : Double) -> MathapproxpadeNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxpadeNode::add(self : MathapproxpadeNode, other : MathapproxpadeNode) -> MathapproxpadeNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxpadeNode::copy(self : MathapproxpadeNode) -> MathapproxpadeNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxpadeNode::fill(self : MathapproxpadeNode, v : Double) -> MathapproxpadeNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxpadeNode::min(self : MathapproxpadeNode) -> Double { @_common.min(self.data) }

pub fn MathapproxpadeNode::max(self : MathapproxpadeNode) -> Double { @_common.max(self.data) }

pub fn MathapproxpadeNode::to_string(self : MathapproxpadeNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxpadeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_pade_edge_make(size : Int) -> MathapproxpadeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxpadeEdge::len(self : MathapproxpadeEdge) -> Int { self.size }

pub fn MathapproxpadeEdge::get(self : MathapproxpadeEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxpadeEdge::set(self : MathapproxpadeEdge, i : Int, v : Double) -> MathapproxpadeEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxpadeEdge::sum(self : MathapproxpadeEdge) -> Double { @_common.sum(self.data) }

pub fn MathapproxpadeEdge::mean(self : MathapproxpadeEdge) -> Double { @_common.mean(self.data) }

pub fn MathapproxpadeEdge::scale(self : MathapproxpadeEdge, f : Double) -> MathapproxpadeEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxpadeEdge::add(self : MathapproxpadeEdge, other : MathapproxpadeEdge) -> MathapproxpadeEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxpadeEdge::copy(self : MathapproxpadeEdge) -> MathapproxpadeEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxpadeEdge::fill(self : MathapproxpadeEdge, v : Double) -> MathapproxpadeEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxpadeEdge::min(self : MathapproxpadeEdge) -> Double { @_common.min(self.data) }

pub fn MathapproxpadeEdge::max(self : MathapproxpadeEdge) -> Double { @_common.max(self.data) }

pub fn MathapproxpadeEdge::to_string(self : MathapproxpadeEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxpadePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_pade_path_make(size : Int) -> MathapproxpadePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxpadePath::len(self : MathapproxpadePath) -> Int { self.size }

pub fn MathapproxpadePath::get(self : MathapproxpadePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxpadePath::set(self : MathapproxpadePath, i : Int, v : Double) -> MathapproxpadePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxpadePath::sum(self : MathapproxpadePath) -> Double { @_common.sum(self.data) }

pub fn MathapproxpadePath::mean(self : MathapproxpadePath) -> Double { @_common.mean(self.data) }

pub fn MathapproxpadePath::scale(self : MathapproxpadePath, f : Double) -> MathapproxpadePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxpadePath::add(self : MathapproxpadePath, other : MathapproxpadePath) -> MathapproxpadePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxpadePath::copy(self : MathapproxpadePath) -> MathapproxpadePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxpadePath::fill(self : MathapproxpadePath, v : Double) -> MathapproxpadePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxpadePath::min(self : MathapproxpadePath) -> Double { @_common.min(self.data) }

pub fn MathapproxpadePath::max(self : MathapproxpadePath) -> Double { @_common.max(self.data) }

pub fn MathapproxpadePath::to_string(self : MathapproxpadePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxpadeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_pade_cluster_make(size : Int) -> MathapproxpadeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxpadeCluster::len(self : MathapproxpadeCluster) -> Int { self.size }

pub fn MathapproxpadeCluster::get(self : MathapproxpadeCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxpadeCluster::set(self : MathapproxpadeCluster, i : Int, v : Double) -> MathapproxpadeCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxpadeCluster::sum(self : MathapproxpadeCluster) -> Double { @_common.sum(self.data) }

pub fn MathapproxpadeCluster::mean(self : MathapproxpadeCluster) -> Double { @_common.mean(self.data) }

pub fn MathapproxpadeCluster::scale(self : MathapproxpadeCluster, f : Double) -> MathapproxpadeCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxpadeCluster::add(self : MathapproxpadeCluster, other : MathapproxpadeCluster) -> MathapproxpadeCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxpadeCluster::copy(self : MathapproxpadeCluster) -> MathapproxpadeCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxpadeCluster::fill(self : MathapproxpadeCluster, v : Double) -> MathapproxpadeCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxpadeCluster::min(self : MathapproxpadeCluster) -> Double { @_common.min(self.data) }

pub fn MathapproxpadeCluster::max(self : MathapproxpadeCluster) -> Double { @_common.max(self.data) }

pub fn MathapproxpadeCluster::to_string(self : MathapproxpadeCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxpadeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_pade_model_make(size : Int) -> MathapproxpadeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxpadeModel::len(self : MathapproxpadeModel) -> Int { self.size }

pub fn MathapproxpadeModel::get(self : MathapproxpadeModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxpadeModel::set(self : MathapproxpadeModel, i : Int, v : Double) -> MathapproxpadeModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxpadeModel::sum(self : MathapproxpadeModel) -> Double { @_common.sum(self.data) }

pub fn MathapproxpadeModel::mean(self : MathapproxpadeModel) -> Double { @_common.mean(self.data) }

pub fn MathapproxpadeModel::scale(self : MathapproxpadeModel, f : Double) -> MathapproxpadeModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxpadeModel::add(self : MathapproxpadeModel, other : MathapproxpadeModel) -> MathapproxpadeModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxpadeModel::copy(self : MathapproxpadeModel) -> MathapproxpadeModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxpadeModel::fill(self : MathapproxpadeModel, v : Double) -> MathapproxpadeModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxpadeModel::min(self : MathapproxpadeModel) -> Double { @_common.min(self.data) }

pub fn MathapproxpadeModel::max(self : MathapproxpadeModel) -> Double { @_common.max(self.data) }

pub fn MathapproxpadeModel::to_string(self : MathapproxpadeModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxpadeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_pade_layer_make(size : Int) -> MathapproxpadeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxpadeLayer::len(self : MathapproxpadeLayer) -> Int { self.size }

pub fn MathapproxpadeLayer::get(self : MathapproxpadeLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxpadeLayer::set(self : MathapproxpadeLayer, i : Int, v : Double) -> MathapproxpadeLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxpadeLayer::sum(self : MathapproxpadeLayer) -> Double { @_common.sum(self.data) }

pub fn MathapproxpadeLayer::mean(self : MathapproxpadeLayer) -> Double { @_common.mean(self.data) }

pub fn MathapproxpadeLayer::scale(self : MathapproxpadeLayer, f : Double) -> MathapproxpadeLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxpadeLayer::add(self : MathapproxpadeLayer, other : MathapproxpadeLayer) -> MathapproxpadeLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxpadeLayer::copy(self : MathapproxpadeLayer) -> MathapproxpadeLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxpadeLayer::fill(self : MathapproxpadeLayer, v : Double) -> MathapproxpadeLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxpadeLayer::min(self : MathapproxpadeLayer) -> Double { @_common.min(self.data) }

pub fn MathapproxpadeLayer::max(self : MathapproxpadeLayer) -> Double { @_common.max(self.data) }

pub fn MathapproxpadeLayer::to_string(self : MathapproxpadeLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxpadeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_pade_buffer_make(size : Int) -> MathapproxpadeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxpadeBuffer::len(self : MathapproxpadeBuffer) -> Int { self.size }

pub fn MathapproxpadeBuffer::get(self : MathapproxpadeBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxpadeBuffer::set(self : MathapproxpadeBuffer, i : Int, v : Double) -> MathapproxpadeBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxpadeBuffer::sum(self : MathapproxpadeBuffer) -> Double { @_common.sum(self.data) }

pub fn MathapproxpadeBuffer::mean(self : MathapproxpadeBuffer) -> Double { @_common.mean(self.data) }

pub fn MathapproxpadeBuffer::scale(self : MathapproxpadeBuffer, f : Double) -> MathapproxpadeBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxpadeBuffer::add(self : MathapproxpadeBuffer, other : MathapproxpadeBuffer) -> MathapproxpadeBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxpadeBuffer::copy(self : MathapproxpadeBuffer) -> MathapproxpadeBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxpadeBuffer::fill(self : MathapproxpadeBuffer, v : Double) -> MathapproxpadeBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxpadeBuffer::min(self : MathapproxpadeBuffer) -> Double { @_common.min(self.data) }

pub fn MathapproxpadeBuffer::max(self : MathapproxpadeBuffer) -> Double { @_common.max(self.data) }

pub fn MathapproxpadeBuffer::to_string(self : MathapproxpadeBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxpadeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_pade_cursor_make(size : Int) -> MathapproxpadeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxpadeCursor::len(self : MathapproxpadeCursor) -> Int { self.size }

pub fn MathapproxpadeCursor::get(self : MathapproxpadeCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxpadeCursor::set(self : MathapproxpadeCursor, i : Int, v : Double) -> MathapproxpadeCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxpadeCursor::sum(self : MathapproxpadeCursor) -> Double { @_common.sum(self.data) }

pub fn MathapproxpadeCursor::mean(self : MathapproxpadeCursor) -> Double { @_common.mean(self.data) }

pub fn MathapproxpadeCursor::scale(self : MathapproxpadeCursor, f : Double) -> MathapproxpadeCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxpadeCursor::add(self : MathapproxpadeCursor, other : MathapproxpadeCursor) -> MathapproxpadeCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxpadeCursor::copy(self : MathapproxpadeCursor) -> MathapproxpadeCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxpadeCursor::fill(self : MathapproxpadeCursor, v : Double) -> MathapproxpadeCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxpadeCursor::min(self : MathapproxpadeCursor) -> Double { @_common.min(self.data) }

pub fn MathapproxpadeCursor::max(self : MathapproxpadeCursor) -> Double { @_common.max(self.data) }

pub fn MathapproxpadeCursor::to_string(self : MathapproxpadeCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxpadeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_pade_view_make(size : Int) -> MathapproxpadeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxpadeView::len(self : MathapproxpadeView) -> Int { self.size }

pub fn MathapproxpadeView::get(self : MathapproxpadeView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxpadeView::set(self : MathapproxpadeView, i : Int, v : Double) -> MathapproxpadeView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxpadeView::sum(self : MathapproxpadeView) -> Double { @_common.sum(self.data) }

pub fn MathapproxpadeView::mean(self : MathapproxpadeView) -> Double { @_common.mean(self.data) }

pub fn MathapproxpadeView::scale(self : MathapproxpadeView, f : Double) -> MathapproxpadeView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxpadeView::add(self : MathapproxpadeView, other : MathapproxpadeView) -> MathapproxpadeView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxpadeView::copy(self : MathapproxpadeView) -> MathapproxpadeView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxpadeView::fill(self : MathapproxpadeView, v : Double) -> MathapproxpadeView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxpadeView::min(self : MathapproxpadeView) -> Double { @_common.min(self.data) }

pub fn MathapproxpadeView::max(self : MathapproxpadeView) -> Double { @_common.max(self.data) }

pub fn MathapproxpadeView::to_string(self : MathapproxpadeView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxpadeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_pade_range_make(size : Int) -> MathapproxpadeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxpadeRange::len(self : MathapproxpadeRange) -> Int { self.size }

pub fn MathapproxpadeRange::get(self : MathapproxpadeRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxpadeRange::set(self : MathapproxpadeRange, i : Int, v : Double) -> MathapproxpadeRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxpadeRange::sum(self : MathapproxpadeRange) -> Double { @_common.sum(self.data) }

pub fn MathapproxpadeRange::mean(self : MathapproxpadeRange) -> Double { @_common.mean(self.data) }

pub fn MathapproxpadeRange::scale(self : MathapproxpadeRange, f : Double) -> MathapproxpadeRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxpadeRange::add(self : MathapproxpadeRange, other : MathapproxpadeRange) -> MathapproxpadeRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxpadeRange::copy(self : MathapproxpadeRange) -> MathapproxpadeRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxpadeRange::fill(self : MathapproxpadeRange, v : Double) -> MathapproxpadeRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxpadeRange::min(self : MathapproxpadeRange) -> Double { @_common.min(self.data) }

pub fn MathapproxpadeRange::max(self : MathapproxpadeRange) -> Double { @_common.max(self.data) }

pub fn MathapproxpadeRange::to_string(self : MathapproxpadeRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxpadeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_pade_slice_make(size : Int) -> MathapproxpadeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxpadeSlice::len(self : MathapproxpadeSlice) -> Int { self.size }

pub fn MathapproxpadeSlice::get(self : MathapproxpadeSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxpadeSlice::set(self : MathapproxpadeSlice, i : Int, v : Double) -> MathapproxpadeSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxpadeSlice::sum(self : MathapproxpadeSlice) -> Double { @_common.sum(self.data) }

pub fn MathapproxpadeSlice::mean(self : MathapproxpadeSlice) -> Double { @_common.mean(self.data) }

pub fn MathapproxpadeSlice::scale(self : MathapproxpadeSlice, f : Double) -> MathapproxpadeSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxpadeSlice::add(self : MathapproxpadeSlice, other : MathapproxpadeSlice) -> MathapproxpadeSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxpadeSlice::copy(self : MathapproxpadeSlice) -> MathapproxpadeSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxpadeSlice::fill(self : MathapproxpadeSlice, v : Double) -> MathapproxpadeSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxpadeSlice::min(self : MathapproxpadeSlice) -> Double { @_common.min(self.data) }

pub fn MathapproxpadeSlice::max(self : MathapproxpadeSlice) -> Double { @_common.max(self.data) }

pub fn MathapproxpadeSlice::to_string(self : MathapproxpadeSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

