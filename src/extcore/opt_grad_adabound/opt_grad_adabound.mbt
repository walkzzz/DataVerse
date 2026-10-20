///===
/// extcore/opt_grad_adabound

pub(all) struct OptgradadaboundPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_grad_adabound_make_point(x : Double, y : Double) -> OptgradadaboundPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_grad_adabound_make_point3(x : Double, y : Double, z : Double) -> OptgradadaboundPoint {
  { x, y, z, label: 0 }
}

pub fn OptgradadaboundPoint::x(self : OptgradadaboundPoint) -> Double { self.x }

pub fn OptgradadaboundPoint::y(self : OptgradadaboundPoint) -> Double { self.y }

pub fn OptgradadaboundPoint::z(self : OptgradadaboundPoint) -> Double { self.z }

pub fn OptgradadaboundPoint::label(self : OptgradadaboundPoint) -> Int { self.label }

pub fn OptgradadaboundPoint::dist(self : OptgradadaboundPoint, other : OptgradadaboundPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn OptgradadaboundPoint::add(self : OptgradadaboundPoint, other : OptgradadaboundPoint) -> OptgradadaboundPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn OptgradadaboundPoint::sub(self : OptgradadaboundPoint, other : OptgradadaboundPoint) -> OptgradadaboundPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn OptgradadaboundPoint::scale(self : OptgradadaboundPoint, s : Double) -> OptgradadaboundPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn OptgradadaboundPoint::dot(self : OptgradadaboundPoint, other : OptgradadaboundPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn OptgradadaboundPoint::cross(self : OptgradadaboundPoint, other : OptgradadaboundPoint) -> OptgradadaboundPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn OptgradadaboundPoint::norm(self : OptgradadaboundPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn OptgradadaboundPoint::normalize(self : OptgradadaboundPoint) -> OptgradadaboundPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptgradadaboundPoint::negate(self : OptgradadaboundPoint) -> OptgradadaboundPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn OptgradadaboundPoint::mid(self : OptgradadaboundPoint, other : OptgradadaboundPoint) -> OptgradadaboundPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn OptgradadaboundPoint::lerp(self : OptgradadaboundPoint, other : OptgradadaboundPoint, t : Double) -> OptgradadaboundPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn OptgradadaboundPoint::to_string(self : OptgradadaboundPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct OptgradadaboundSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_grad_adabound_make_series(vals : Array[Double], name : String) -> OptgradadaboundSeries {
  { vals, name, meta: 0 }
}

pub fn OptgradadaboundSeries::len(self : OptgradadaboundSeries) -> Int { self.vals.length() }

pub fn OptgradadaboundSeries::sum(self : OptgradadaboundSeries) -> Double { @_common.sum(self.vals) }

pub fn OptgradadaboundSeries::mean(self : OptgradadaboundSeries) -> Double { @_common.mean(self.vals) }

pub fn OptgradadaboundSeries::min(self : OptgradadaboundSeries) -> Double { @_common.min(self.vals) }

pub fn OptgradadaboundSeries::max(self : OptgradadaboundSeries) -> Double { @_common.max(self.vals) }

pub fn OptgradadaboundSeries::range(self : OptgradadaboundSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn OptgradadaboundSeries::variance(self : OptgradadaboundSeries) -> Double { @_common.variance(self.vals) }

pub fn OptgradadaboundSeries::std(self : OptgradadaboundSeries) -> Double { @_common.std(self.vals) }

pub fn OptgradadaboundSeries::median(self : OptgradadaboundSeries) -> Double { @_common.median(self.vals) }

pub fn OptgradadaboundSeries::scale(self : OptgradadaboundSeries, f : Double) -> OptgradadaboundSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn OptgradadaboundSeries::add(self : OptgradadaboundSeries, other : OptgradadaboundSeries) -> OptgradadaboundSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn OptgradadaboundSeries::sub(self : OptgradadaboundSeries, other : OptgradadaboundSeries) -> OptgradadaboundSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn OptgradadaboundSeries::normalize(self : OptgradadaboundSeries) -> OptgradadaboundSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn OptgradadaboundSeries::cumsum(self : OptgradadaboundSeries) -> OptgradadaboundSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn OptgradadaboundSeries::to_string(self : OptgradadaboundSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptgradadaboundMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_grad_adabound_make_matrix(rows : Int, cols : Int, val : Double) -> OptgradadaboundMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_grad_adabound_matrix_identity(n : Int) -> OptgradadaboundMatrix {
  let m = opt_grad_adabound_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn OptgradadaboundMatrix::get(self : OptgradadaboundMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn OptgradadaboundMatrix::transpose(self : OptgradadaboundMatrix) -> OptgradadaboundMatrix {
  let result = opt_grad_adabound_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn OptgradadaboundMatrix::add(self : OptgradadaboundMatrix, other : OptgradadaboundMatrix) -> OptgradadaboundMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = opt_grad_adabound_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn OptgradadaboundMatrix::scale(self : OptgradadaboundMatrix, s : Double) -> OptgradadaboundMatrix {
  let result = opt_grad_adabound_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn OptgradadaboundMatrix::multiply(self : OptgradadaboundMatrix, other : OptgradadaboundMatrix) -> OptgradadaboundMatrix {
  if self.cols != other.rows { return opt_grad_adabound_make_matrix(self.rows, other.cols, 0.0) }
  let result = opt_grad_adabound_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn OptgradadaboundMatrix::trace(self : OptgradadaboundMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn OptgradadaboundMatrix::det(self : OptgradadaboundMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn OptgradadaboundMatrix::norm(self : OptgradadaboundMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn OptgradadaboundMatrix::to_string(self : OptgradadaboundMatrix) -> String {
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

pub(all) struct OptgradadaboundVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_grad_adabound_make_vector(comps : Array[Double]) -> OptgradadaboundVector {
  { comps, dim: comps.length() }
}

pub fn opt_grad_adabound_vector_zero(dim : Int) -> OptgradadaboundVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn OptgradadaboundVector::add(self : OptgradadaboundVector, other : OptgradadaboundVector) -> OptgradadaboundVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn OptgradadaboundVector::sub(self : OptgradadaboundVector, other : OptgradadaboundVector) -> OptgradadaboundVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn OptgradadaboundVector::scale(self : OptgradadaboundVector, s : Double) -> OptgradadaboundVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn OptgradadaboundVector::dot(self : OptgradadaboundVector, other : OptgradadaboundVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn OptgradadaboundVector::norm(self : OptgradadaboundVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn OptgradadaboundVector::normalize(self : OptgradadaboundVector) -> OptgradadaboundVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptgradadaboundVector::dist(self : OptgradadaboundVector, other : OptgradadaboundVector) -> Double {
  self.sub(other).norm()
}

pub fn OptgradadaboundVector::to_string(self : OptgradadaboundVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptgradadaboundFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adabound_frame_make(size : Int) -> OptgradadaboundFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradadaboundFrame::len(self : OptgradadaboundFrame) -> Int { self.size }

pub fn OptgradadaboundFrame::get(self : OptgradadaboundFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradadaboundFrame::set(self : OptgradadaboundFrame, i : Int, v : Double) -> OptgradadaboundFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradadaboundFrame::sum(self : OptgradadaboundFrame) -> Double { @_common.sum(self.data) }

pub fn OptgradadaboundFrame::mean(self : OptgradadaboundFrame) -> Double { @_common.mean(self.data) }

pub fn OptgradadaboundFrame::scale(self : OptgradadaboundFrame, f : Double) -> OptgradadaboundFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradadaboundFrame::add(self : OptgradadaboundFrame, other : OptgradadaboundFrame) -> OptgradadaboundFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradadaboundFrame::copy(self : OptgradadaboundFrame) -> OptgradadaboundFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradadaboundFrame::fill(self : OptgradadaboundFrame, v : Double) -> OptgradadaboundFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradadaboundFrame::min(self : OptgradadaboundFrame) -> Double { @_common.min(self.data) }

pub fn OptgradadaboundFrame::max(self : OptgradadaboundFrame) -> Double { @_common.max(self.data) }

pub fn OptgradadaboundFrame::to_string(self : OptgradadaboundFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradadaboundTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adabound_table_make(size : Int) -> OptgradadaboundTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradadaboundTable::len(self : OptgradadaboundTable) -> Int { self.size }

pub fn OptgradadaboundTable::get(self : OptgradadaboundTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradadaboundTable::set(self : OptgradadaboundTable, i : Int, v : Double) -> OptgradadaboundTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradadaboundTable::sum(self : OptgradadaboundTable) -> Double { @_common.sum(self.data) }

pub fn OptgradadaboundTable::mean(self : OptgradadaboundTable) -> Double { @_common.mean(self.data) }

pub fn OptgradadaboundTable::scale(self : OptgradadaboundTable, f : Double) -> OptgradadaboundTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradadaboundTable::add(self : OptgradadaboundTable, other : OptgradadaboundTable) -> OptgradadaboundTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradadaboundTable::copy(self : OptgradadaboundTable) -> OptgradadaboundTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradadaboundTable::fill(self : OptgradadaboundTable, v : Double) -> OptgradadaboundTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradadaboundTable::min(self : OptgradadaboundTable) -> Double { @_common.min(self.data) }

pub fn OptgradadaboundTable::max(self : OptgradadaboundTable) -> Double { @_common.max(self.data) }

pub fn OptgradadaboundTable::to_string(self : OptgradadaboundTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradadaboundGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adabound_graphn_make(size : Int) -> OptgradadaboundGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradadaboundGraphN::len(self : OptgradadaboundGraphN) -> Int { self.size }

pub fn OptgradadaboundGraphN::get(self : OptgradadaboundGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradadaboundGraphN::set(self : OptgradadaboundGraphN, i : Int, v : Double) -> OptgradadaboundGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradadaboundGraphN::sum(self : OptgradadaboundGraphN) -> Double { @_common.sum(self.data) }

pub fn OptgradadaboundGraphN::mean(self : OptgradadaboundGraphN) -> Double { @_common.mean(self.data) }

pub fn OptgradadaboundGraphN::scale(self : OptgradadaboundGraphN, f : Double) -> OptgradadaboundGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradadaboundGraphN::add(self : OptgradadaboundGraphN, other : OptgradadaboundGraphN) -> OptgradadaboundGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradadaboundGraphN::copy(self : OptgradadaboundGraphN) -> OptgradadaboundGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradadaboundGraphN::fill(self : OptgradadaboundGraphN, v : Double) -> OptgradadaboundGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradadaboundGraphN::min(self : OptgradadaboundGraphN) -> Double { @_common.min(self.data) }

pub fn OptgradadaboundGraphN::max(self : OptgradadaboundGraphN) -> Double { @_common.max(self.data) }

pub fn OptgradadaboundGraphN::to_string(self : OptgradadaboundGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradadaboundNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adabound_node_make(size : Int) -> OptgradadaboundNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradadaboundNode::len(self : OptgradadaboundNode) -> Int { self.size }

pub fn OptgradadaboundNode::get(self : OptgradadaboundNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradadaboundNode::set(self : OptgradadaboundNode, i : Int, v : Double) -> OptgradadaboundNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradadaboundNode::sum(self : OptgradadaboundNode) -> Double { @_common.sum(self.data) }

pub fn OptgradadaboundNode::mean(self : OptgradadaboundNode) -> Double { @_common.mean(self.data) }

pub fn OptgradadaboundNode::scale(self : OptgradadaboundNode, f : Double) -> OptgradadaboundNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradadaboundNode::add(self : OptgradadaboundNode, other : OptgradadaboundNode) -> OptgradadaboundNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradadaboundNode::copy(self : OptgradadaboundNode) -> OptgradadaboundNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradadaboundNode::fill(self : OptgradadaboundNode, v : Double) -> OptgradadaboundNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradadaboundNode::min(self : OptgradadaboundNode) -> Double { @_common.min(self.data) }

pub fn OptgradadaboundNode::max(self : OptgradadaboundNode) -> Double { @_common.max(self.data) }

pub fn OptgradadaboundNode::to_string(self : OptgradadaboundNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradadaboundEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adabound_edge_make(size : Int) -> OptgradadaboundEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradadaboundEdge::len(self : OptgradadaboundEdge) -> Int { self.size }

pub fn OptgradadaboundEdge::get(self : OptgradadaboundEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradadaboundEdge::set(self : OptgradadaboundEdge, i : Int, v : Double) -> OptgradadaboundEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradadaboundEdge::sum(self : OptgradadaboundEdge) -> Double { @_common.sum(self.data) }

pub fn OptgradadaboundEdge::mean(self : OptgradadaboundEdge) -> Double { @_common.mean(self.data) }

pub fn OptgradadaboundEdge::scale(self : OptgradadaboundEdge, f : Double) -> OptgradadaboundEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradadaboundEdge::add(self : OptgradadaboundEdge, other : OptgradadaboundEdge) -> OptgradadaboundEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradadaboundEdge::copy(self : OptgradadaboundEdge) -> OptgradadaboundEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradadaboundEdge::fill(self : OptgradadaboundEdge, v : Double) -> OptgradadaboundEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradadaboundEdge::min(self : OptgradadaboundEdge) -> Double { @_common.min(self.data) }

pub fn OptgradadaboundEdge::max(self : OptgradadaboundEdge) -> Double { @_common.max(self.data) }

pub fn OptgradadaboundEdge::to_string(self : OptgradadaboundEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradadaboundPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adabound_path_make(size : Int) -> OptgradadaboundPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradadaboundPath::len(self : OptgradadaboundPath) -> Int { self.size }

pub fn OptgradadaboundPath::get(self : OptgradadaboundPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradadaboundPath::set(self : OptgradadaboundPath, i : Int, v : Double) -> OptgradadaboundPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradadaboundPath::sum(self : OptgradadaboundPath) -> Double { @_common.sum(self.data) }

pub fn OptgradadaboundPath::mean(self : OptgradadaboundPath) -> Double { @_common.mean(self.data) }

pub fn OptgradadaboundPath::scale(self : OptgradadaboundPath, f : Double) -> OptgradadaboundPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradadaboundPath::add(self : OptgradadaboundPath, other : OptgradadaboundPath) -> OptgradadaboundPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradadaboundPath::copy(self : OptgradadaboundPath) -> OptgradadaboundPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradadaboundPath::fill(self : OptgradadaboundPath, v : Double) -> OptgradadaboundPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradadaboundPath::min(self : OptgradadaboundPath) -> Double { @_common.min(self.data) }

pub fn OptgradadaboundPath::max(self : OptgradadaboundPath) -> Double { @_common.max(self.data) }

pub fn OptgradadaboundPath::to_string(self : OptgradadaboundPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradadaboundCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adabound_cluster_make(size : Int) -> OptgradadaboundCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradadaboundCluster::len(self : OptgradadaboundCluster) -> Int { self.size }

pub fn OptgradadaboundCluster::get(self : OptgradadaboundCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradadaboundCluster::set(self : OptgradadaboundCluster, i : Int, v : Double) -> OptgradadaboundCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradadaboundCluster::sum(self : OptgradadaboundCluster) -> Double { @_common.sum(self.data) }

pub fn OptgradadaboundCluster::mean(self : OptgradadaboundCluster) -> Double { @_common.mean(self.data) }

pub fn OptgradadaboundCluster::scale(self : OptgradadaboundCluster, f : Double) -> OptgradadaboundCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradadaboundCluster::add(self : OptgradadaboundCluster, other : OptgradadaboundCluster) -> OptgradadaboundCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradadaboundCluster::copy(self : OptgradadaboundCluster) -> OptgradadaboundCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradadaboundCluster::fill(self : OptgradadaboundCluster, v : Double) -> OptgradadaboundCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradadaboundCluster::min(self : OptgradadaboundCluster) -> Double { @_common.min(self.data) }

pub fn OptgradadaboundCluster::max(self : OptgradadaboundCluster) -> Double { @_common.max(self.data) }

pub fn OptgradadaboundCluster::to_string(self : OptgradadaboundCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradadaboundModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adabound_model_make(size : Int) -> OptgradadaboundModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradadaboundModel::len(self : OptgradadaboundModel) -> Int { self.size }

pub fn OptgradadaboundModel::get(self : OptgradadaboundModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradadaboundModel::set(self : OptgradadaboundModel, i : Int, v : Double) -> OptgradadaboundModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradadaboundModel::sum(self : OptgradadaboundModel) -> Double { @_common.sum(self.data) }

pub fn OptgradadaboundModel::mean(self : OptgradadaboundModel) -> Double { @_common.mean(self.data) }

pub fn OptgradadaboundModel::scale(self : OptgradadaboundModel, f : Double) -> OptgradadaboundModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradadaboundModel::add(self : OptgradadaboundModel, other : OptgradadaboundModel) -> OptgradadaboundModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradadaboundModel::copy(self : OptgradadaboundModel) -> OptgradadaboundModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradadaboundModel::fill(self : OptgradadaboundModel, v : Double) -> OptgradadaboundModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradadaboundModel::min(self : OptgradadaboundModel) -> Double { @_common.min(self.data) }

pub fn OptgradadaboundModel::max(self : OptgradadaboundModel) -> Double { @_common.max(self.data) }

pub fn OptgradadaboundModel::to_string(self : OptgradadaboundModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradadaboundLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adabound_layer_make(size : Int) -> OptgradadaboundLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradadaboundLayer::len(self : OptgradadaboundLayer) -> Int { self.size }

pub fn OptgradadaboundLayer::get(self : OptgradadaboundLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradadaboundLayer::set(self : OptgradadaboundLayer, i : Int, v : Double) -> OptgradadaboundLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradadaboundLayer::sum(self : OptgradadaboundLayer) -> Double { @_common.sum(self.data) }

pub fn OptgradadaboundLayer::mean(self : OptgradadaboundLayer) -> Double { @_common.mean(self.data) }

pub fn OptgradadaboundLayer::scale(self : OptgradadaboundLayer, f : Double) -> OptgradadaboundLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradadaboundLayer::add(self : OptgradadaboundLayer, other : OptgradadaboundLayer) -> OptgradadaboundLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradadaboundLayer::copy(self : OptgradadaboundLayer) -> OptgradadaboundLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradadaboundLayer::fill(self : OptgradadaboundLayer, v : Double) -> OptgradadaboundLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradadaboundLayer::min(self : OptgradadaboundLayer) -> Double { @_common.min(self.data) }

pub fn OptgradadaboundLayer::max(self : OptgradadaboundLayer) -> Double { @_common.max(self.data) }

pub fn OptgradadaboundLayer::to_string(self : OptgradadaboundLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradadaboundBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adabound_buffer_make(size : Int) -> OptgradadaboundBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradadaboundBuffer::len(self : OptgradadaboundBuffer) -> Int { self.size }

pub fn OptgradadaboundBuffer::get(self : OptgradadaboundBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradadaboundBuffer::set(self : OptgradadaboundBuffer, i : Int, v : Double) -> OptgradadaboundBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradadaboundBuffer::sum(self : OptgradadaboundBuffer) -> Double { @_common.sum(self.data) }

pub fn OptgradadaboundBuffer::mean(self : OptgradadaboundBuffer) -> Double { @_common.mean(self.data) }

pub fn OptgradadaboundBuffer::scale(self : OptgradadaboundBuffer, f : Double) -> OptgradadaboundBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradadaboundBuffer::add(self : OptgradadaboundBuffer, other : OptgradadaboundBuffer) -> OptgradadaboundBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradadaboundBuffer::copy(self : OptgradadaboundBuffer) -> OptgradadaboundBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradadaboundBuffer::fill(self : OptgradadaboundBuffer, v : Double) -> OptgradadaboundBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradadaboundBuffer::min(self : OptgradadaboundBuffer) -> Double { @_common.min(self.data) }

pub fn OptgradadaboundBuffer::max(self : OptgradadaboundBuffer) -> Double { @_common.max(self.data) }

pub fn OptgradadaboundBuffer::to_string(self : OptgradadaboundBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradadaboundCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adabound_cursor_make(size : Int) -> OptgradadaboundCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradadaboundCursor::len(self : OptgradadaboundCursor) -> Int { self.size }

pub fn OptgradadaboundCursor::get(self : OptgradadaboundCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradadaboundCursor::set(self : OptgradadaboundCursor, i : Int, v : Double) -> OptgradadaboundCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradadaboundCursor::sum(self : OptgradadaboundCursor) -> Double { @_common.sum(self.data) }

pub fn OptgradadaboundCursor::mean(self : OptgradadaboundCursor) -> Double { @_common.mean(self.data) }

pub fn OptgradadaboundCursor::scale(self : OptgradadaboundCursor, f : Double) -> OptgradadaboundCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradadaboundCursor::add(self : OptgradadaboundCursor, other : OptgradadaboundCursor) -> OptgradadaboundCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradadaboundCursor::copy(self : OptgradadaboundCursor) -> OptgradadaboundCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradadaboundCursor::fill(self : OptgradadaboundCursor, v : Double) -> OptgradadaboundCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradadaboundCursor::min(self : OptgradadaboundCursor) -> Double { @_common.min(self.data) }

pub fn OptgradadaboundCursor::max(self : OptgradadaboundCursor) -> Double { @_common.max(self.data) }

pub fn OptgradadaboundCursor::to_string(self : OptgradadaboundCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradadaboundView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adabound_view_make(size : Int) -> OptgradadaboundView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradadaboundView::len(self : OptgradadaboundView) -> Int { self.size }

pub fn OptgradadaboundView::get(self : OptgradadaboundView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradadaboundView::set(self : OptgradadaboundView, i : Int, v : Double) -> OptgradadaboundView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradadaboundView::sum(self : OptgradadaboundView) -> Double { @_common.sum(self.data) }

pub fn OptgradadaboundView::mean(self : OptgradadaboundView) -> Double { @_common.mean(self.data) }

pub fn OptgradadaboundView::scale(self : OptgradadaboundView, f : Double) -> OptgradadaboundView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradadaboundView::add(self : OptgradadaboundView, other : OptgradadaboundView) -> OptgradadaboundView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradadaboundView::copy(self : OptgradadaboundView) -> OptgradadaboundView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradadaboundView::fill(self : OptgradadaboundView, v : Double) -> OptgradadaboundView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradadaboundView::min(self : OptgradadaboundView) -> Double { @_common.min(self.data) }

pub fn OptgradadaboundView::max(self : OptgradadaboundView) -> Double { @_common.max(self.data) }

pub fn OptgradadaboundView::to_string(self : OptgradadaboundView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradadaboundRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adabound_range_make(size : Int) -> OptgradadaboundRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradadaboundRange::len(self : OptgradadaboundRange) -> Int { self.size }

pub fn OptgradadaboundRange::get(self : OptgradadaboundRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradadaboundRange::set(self : OptgradadaboundRange, i : Int, v : Double) -> OptgradadaboundRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradadaboundRange::sum(self : OptgradadaboundRange) -> Double { @_common.sum(self.data) }

pub fn OptgradadaboundRange::mean(self : OptgradadaboundRange) -> Double { @_common.mean(self.data) }

pub fn OptgradadaboundRange::scale(self : OptgradadaboundRange, f : Double) -> OptgradadaboundRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradadaboundRange::add(self : OptgradadaboundRange, other : OptgradadaboundRange) -> OptgradadaboundRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradadaboundRange::copy(self : OptgradadaboundRange) -> OptgradadaboundRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradadaboundRange::fill(self : OptgradadaboundRange, v : Double) -> OptgradadaboundRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradadaboundRange::min(self : OptgradadaboundRange) -> Double { @_common.min(self.data) }

pub fn OptgradadaboundRange::max(self : OptgradadaboundRange) -> Double { @_common.max(self.data) }

pub fn OptgradadaboundRange::to_string(self : OptgradadaboundRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradadaboundSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adabound_slice_make(size : Int) -> OptgradadaboundSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradadaboundSlice::len(self : OptgradadaboundSlice) -> Int { self.size }

pub fn OptgradadaboundSlice::get(self : OptgradadaboundSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradadaboundSlice::set(self : OptgradadaboundSlice, i : Int, v : Double) -> OptgradadaboundSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradadaboundSlice::sum(self : OptgradadaboundSlice) -> Double { @_common.sum(self.data) }

pub fn OptgradadaboundSlice::mean(self : OptgradadaboundSlice) -> Double { @_common.mean(self.data) }

pub fn OptgradadaboundSlice::scale(self : OptgradadaboundSlice, f : Double) -> OptgradadaboundSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradadaboundSlice::add(self : OptgradadaboundSlice, other : OptgradadaboundSlice) -> OptgradadaboundSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradadaboundSlice::copy(self : OptgradadaboundSlice) -> OptgradadaboundSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradadaboundSlice::fill(self : OptgradadaboundSlice, v : Double) -> OptgradadaboundSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradadaboundSlice::min(self : OptgradadaboundSlice) -> Double { @_common.min(self.data) }

pub fn OptgradadaboundSlice::max(self : OptgradadaboundSlice) -> Double { @_common.max(self.data) }

pub fn OptgradadaboundSlice::to_string(self : OptgradadaboundSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

