///===
/// extcore/opt_meta_evolution

pub(all) struct OptmetaevolutionPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_meta_evolution_make_point(x : Double, y : Double) -> OptmetaevolutionPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_meta_evolution_make_point3(x : Double, y : Double, z : Double) -> OptmetaevolutionPoint {
  { x, y, z, label: 0 }
}

pub fn OptmetaevolutionPoint::x(self : OptmetaevolutionPoint) -> Double { self.x }

pub fn OptmetaevolutionPoint::y(self : OptmetaevolutionPoint) -> Double { self.y }

pub fn OptmetaevolutionPoint::z(self : OptmetaevolutionPoint) -> Double { self.z }

pub fn OptmetaevolutionPoint::label(self : OptmetaevolutionPoint) -> Int { self.label }

pub fn OptmetaevolutionPoint::dist(self : OptmetaevolutionPoint, other : OptmetaevolutionPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn OptmetaevolutionPoint::add(self : OptmetaevolutionPoint, other : OptmetaevolutionPoint) -> OptmetaevolutionPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn OptmetaevolutionPoint::sub(self : OptmetaevolutionPoint, other : OptmetaevolutionPoint) -> OptmetaevolutionPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn OptmetaevolutionPoint::scale(self : OptmetaevolutionPoint, s : Double) -> OptmetaevolutionPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn OptmetaevolutionPoint::dot(self : OptmetaevolutionPoint, other : OptmetaevolutionPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn OptmetaevolutionPoint::cross(self : OptmetaevolutionPoint, other : OptmetaevolutionPoint) -> OptmetaevolutionPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn OptmetaevolutionPoint::norm(self : OptmetaevolutionPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn OptmetaevolutionPoint::normalize(self : OptmetaevolutionPoint) -> OptmetaevolutionPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptmetaevolutionPoint::negate(self : OptmetaevolutionPoint) -> OptmetaevolutionPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn OptmetaevolutionPoint::mid(self : OptmetaevolutionPoint, other : OptmetaevolutionPoint) -> OptmetaevolutionPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn OptmetaevolutionPoint::lerp(self : OptmetaevolutionPoint, other : OptmetaevolutionPoint, t : Double) -> OptmetaevolutionPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn OptmetaevolutionPoint::to_string(self : OptmetaevolutionPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct OptmetaevolutionSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_meta_evolution_make_series(vals : Array[Double], name : String) -> OptmetaevolutionSeries {
  { vals, name, meta: 0 }
}

pub fn OptmetaevolutionSeries::len(self : OptmetaevolutionSeries) -> Int { self.vals.length() }

pub fn OptmetaevolutionSeries::sum(self : OptmetaevolutionSeries) -> Double { @_common.sum(self.vals) }

pub fn OptmetaevolutionSeries::mean(self : OptmetaevolutionSeries) -> Double { @_common.mean(self.vals) }

pub fn OptmetaevolutionSeries::min(self : OptmetaevolutionSeries) -> Double { @_common.min(self.vals) }

pub fn OptmetaevolutionSeries::max(self : OptmetaevolutionSeries) -> Double { @_common.max(self.vals) }

pub fn OptmetaevolutionSeries::range(self : OptmetaevolutionSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn OptmetaevolutionSeries::variance(self : OptmetaevolutionSeries) -> Double { @_common.variance(self.vals) }

pub fn OptmetaevolutionSeries::std(self : OptmetaevolutionSeries) -> Double { @_common.std(self.vals) }

pub fn OptmetaevolutionSeries::median(self : OptmetaevolutionSeries) -> Double { @_common.median(self.vals) }

pub fn OptmetaevolutionSeries::scale(self : OptmetaevolutionSeries, f : Double) -> OptmetaevolutionSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn OptmetaevolutionSeries::add(self : OptmetaevolutionSeries, other : OptmetaevolutionSeries) -> OptmetaevolutionSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn OptmetaevolutionSeries::sub(self : OptmetaevolutionSeries, other : OptmetaevolutionSeries) -> OptmetaevolutionSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn OptmetaevolutionSeries::normalize(self : OptmetaevolutionSeries) -> OptmetaevolutionSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn OptmetaevolutionSeries::cumsum(self : OptmetaevolutionSeries) -> OptmetaevolutionSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn OptmetaevolutionSeries::to_string(self : OptmetaevolutionSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptmetaevolutionMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_meta_evolution_make_matrix(rows : Int, cols : Int, val : Double) -> OptmetaevolutionMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_meta_evolution_matrix_identity(n : Int) -> OptmetaevolutionMatrix {
  let m = opt_meta_evolution_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn OptmetaevolutionMatrix::get(self : OptmetaevolutionMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn OptmetaevolutionMatrix::transpose(self : OptmetaevolutionMatrix) -> OptmetaevolutionMatrix {
  let result = opt_meta_evolution_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn OptmetaevolutionMatrix::add(self : OptmetaevolutionMatrix, other : OptmetaevolutionMatrix) -> OptmetaevolutionMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = opt_meta_evolution_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn OptmetaevolutionMatrix::scale(self : OptmetaevolutionMatrix, s : Double) -> OptmetaevolutionMatrix {
  let result = opt_meta_evolution_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn OptmetaevolutionMatrix::multiply(self : OptmetaevolutionMatrix, other : OptmetaevolutionMatrix) -> OptmetaevolutionMatrix {
  if self.cols != other.rows { return opt_meta_evolution_make_matrix(self.rows, other.cols, 0.0) }
  let result = opt_meta_evolution_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn OptmetaevolutionMatrix::trace(self : OptmetaevolutionMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn OptmetaevolutionMatrix::det(self : OptmetaevolutionMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn OptmetaevolutionMatrix::norm(self : OptmetaevolutionMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn OptmetaevolutionMatrix::to_string(self : OptmetaevolutionMatrix) -> String {
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

pub(all) struct OptmetaevolutionVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_meta_evolution_make_vector(comps : Array[Double]) -> OptmetaevolutionVector {
  { comps, dim: comps.length() }
}

pub fn opt_meta_evolution_vector_zero(dim : Int) -> OptmetaevolutionVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn OptmetaevolutionVector::add(self : OptmetaevolutionVector, other : OptmetaevolutionVector) -> OptmetaevolutionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn OptmetaevolutionVector::sub(self : OptmetaevolutionVector, other : OptmetaevolutionVector) -> OptmetaevolutionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn OptmetaevolutionVector::scale(self : OptmetaevolutionVector, s : Double) -> OptmetaevolutionVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn OptmetaevolutionVector::dot(self : OptmetaevolutionVector, other : OptmetaevolutionVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn OptmetaevolutionVector::norm(self : OptmetaevolutionVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn OptmetaevolutionVector::normalize(self : OptmetaevolutionVector) -> OptmetaevolutionVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptmetaevolutionVector::dist(self : OptmetaevolutionVector, other : OptmetaevolutionVector) -> Double {
  self.sub(other).norm()
}

pub fn OptmetaevolutionVector::to_string(self : OptmetaevolutionVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptmetaevolutionFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_frame_make(size : Int) -> OptmetaevolutionFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetaevolutionFrame::len(self : OptmetaevolutionFrame) -> Int { self.size }

pub fn OptmetaevolutionFrame::get(self : OptmetaevolutionFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetaevolutionFrame::set(self : OptmetaevolutionFrame, i : Int, v : Double) -> OptmetaevolutionFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionFrame::sum(self : OptmetaevolutionFrame) -> Double { @_common.sum(self.data) }

pub fn OptmetaevolutionFrame::mean(self : OptmetaevolutionFrame) -> Double { @_common.mean(self.data) }

pub fn OptmetaevolutionFrame::scale(self : OptmetaevolutionFrame, f : Double) -> OptmetaevolutionFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionFrame::add(self : OptmetaevolutionFrame, other : OptmetaevolutionFrame) -> OptmetaevolutionFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetaevolutionFrame::copy(self : OptmetaevolutionFrame) -> OptmetaevolutionFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionFrame::fill(self : OptmetaevolutionFrame, v : Double) -> OptmetaevolutionFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionFrame::min(self : OptmetaevolutionFrame) -> Double { @_common.min(self.data) }

pub fn OptmetaevolutionFrame::max(self : OptmetaevolutionFrame) -> Double { @_common.max(self.data) }

pub fn OptmetaevolutionFrame::to_string(self : OptmetaevolutionFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_table_make(size : Int) -> OptmetaevolutionTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetaevolutionTable::len(self : OptmetaevolutionTable) -> Int { self.size }

pub fn OptmetaevolutionTable::get(self : OptmetaevolutionTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetaevolutionTable::set(self : OptmetaevolutionTable, i : Int, v : Double) -> OptmetaevolutionTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionTable::sum(self : OptmetaevolutionTable) -> Double { @_common.sum(self.data) }

pub fn OptmetaevolutionTable::mean(self : OptmetaevolutionTable) -> Double { @_common.mean(self.data) }

pub fn OptmetaevolutionTable::scale(self : OptmetaevolutionTable, f : Double) -> OptmetaevolutionTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionTable::add(self : OptmetaevolutionTable, other : OptmetaevolutionTable) -> OptmetaevolutionTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetaevolutionTable::copy(self : OptmetaevolutionTable) -> OptmetaevolutionTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionTable::fill(self : OptmetaevolutionTable, v : Double) -> OptmetaevolutionTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionTable::min(self : OptmetaevolutionTable) -> Double { @_common.min(self.data) }

pub fn OptmetaevolutionTable::max(self : OptmetaevolutionTable) -> Double { @_common.max(self.data) }

pub fn OptmetaevolutionTable::to_string(self : OptmetaevolutionTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_graphn_make(size : Int) -> OptmetaevolutionGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetaevolutionGraphN::len(self : OptmetaevolutionGraphN) -> Int { self.size }

pub fn OptmetaevolutionGraphN::get(self : OptmetaevolutionGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetaevolutionGraphN::set(self : OptmetaevolutionGraphN, i : Int, v : Double) -> OptmetaevolutionGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionGraphN::sum(self : OptmetaevolutionGraphN) -> Double { @_common.sum(self.data) }

pub fn OptmetaevolutionGraphN::mean(self : OptmetaevolutionGraphN) -> Double { @_common.mean(self.data) }

pub fn OptmetaevolutionGraphN::scale(self : OptmetaevolutionGraphN, f : Double) -> OptmetaevolutionGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionGraphN::add(self : OptmetaevolutionGraphN, other : OptmetaevolutionGraphN) -> OptmetaevolutionGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetaevolutionGraphN::copy(self : OptmetaevolutionGraphN) -> OptmetaevolutionGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionGraphN::fill(self : OptmetaevolutionGraphN, v : Double) -> OptmetaevolutionGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionGraphN::min(self : OptmetaevolutionGraphN) -> Double { @_common.min(self.data) }

pub fn OptmetaevolutionGraphN::max(self : OptmetaevolutionGraphN) -> Double { @_common.max(self.data) }

pub fn OptmetaevolutionGraphN::to_string(self : OptmetaevolutionGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_node_make(size : Int) -> OptmetaevolutionNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetaevolutionNode::len(self : OptmetaevolutionNode) -> Int { self.size }

pub fn OptmetaevolutionNode::get(self : OptmetaevolutionNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetaevolutionNode::set(self : OptmetaevolutionNode, i : Int, v : Double) -> OptmetaevolutionNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionNode::sum(self : OptmetaevolutionNode) -> Double { @_common.sum(self.data) }

pub fn OptmetaevolutionNode::mean(self : OptmetaevolutionNode) -> Double { @_common.mean(self.data) }

pub fn OptmetaevolutionNode::scale(self : OptmetaevolutionNode, f : Double) -> OptmetaevolutionNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionNode::add(self : OptmetaevolutionNode, other : OptmetaevolutionNode) -> OptmetaevolutionNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetaevolutionNode::copy(self : OptmetaevolutionNode) -> OptmetaevolutionNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionNode::fill(self : OptmetaevolutionNode, v : Double) -> OptmetaevolutionNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionNode::min(self : OptmetaevolutionNode) -> Double { @_common.min(self.data) }

pub fn OptmetaevolutionNode::max(self : OptmetaevolutionNode) -> Double { @_common.max(self.data) }

pub fn OptmetaevolutionNode::to_string(self : OptmetaevolutionNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_edge_make(size : Int) -> OptmetaevolutionEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetaevolutionEdge::len(self : OptmetaevolutionEdge) -> Int { self.size }

pub fn OptmetaevolutionEdge::get(self : OptmetaevolutionEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetaevolutionEdge::set(self : OptmetaevolutionEdge, i : Int, v : Double) -> OptmetaevolutionEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionEdge::sum(self : OptmetaevolutionEdge) -> Double { @_common.sum(self.data) }

pub fn OptmetaevolutionEdge::mean(self : OptmetaevolutionEdge) -> Double { @_common.mean(self.data) }

pub fn OptmetaevolutionEdge::scale(self : OptmetaevolutionEdge, f : Double) -> OptmetaevolutionEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionEdge::add(self : OptmetaevolutionEdge, other : OptmetaevolutionEdge) -> OptmetaevolutionEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetaevolutionEdge::copy(self : OptmetaevolutionEdge) -> OptmetaevolutionEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionEdge::fill(self : OptmetaevolutionEdge, v : Double) -> OptmetaevolutionEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionEdge::min(self : OptmetaevolutionEdge) -> Double { @_common.min(self.data) }

pub fn OptmetaevolutionEdge::max(self : OptmetaevolutionEdge) -> Double { @_common.max(self.data) }

pub fn OptmetaevolutionEdge::to_string(self : OptmetaevolutionEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_path_make(size : Int) -> OptmetaevolutionPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetaevolutionPath::len(self : OptmetaevolutionPath) -> Int { self.size }

pub fn OptmetaevolutionPath::get(self : OptmetaevolutionPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetaevolutionPath::set(self : OptmetaevolutionPath, i : Int, v : Double) -> OptmetaevolutionPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionPath::sum(self : OptmetaevolutionPath) -> Double { @_common.sum(self.data) }

pub fn OptmetaevolutionPath::mean(self : OptmetaevolutionPath) -> Double { @_common.mean(self.data) }

pub fn OptmetaevolutionPath::scale(self : OptmetaevolutionPath, f : Double) -> OptmetaevolutionPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionPath::add(self : OptmetaevolutionPath, other : OptmetaevolutionPath) -> OptmetaevolutionPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetaevolutionPath::copy(self : OptmetaevolutionPath) -> OptmetaevolutionPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionPath::fill(self : OptmetaevolutionPath, v : Double) -> OptmetaevolutionPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionPath::min(self : OptmetaevolutionPath) -> Double { @_common.min(self.data) }

pub fn OptmetaevolutionPath::max(self : OptmetaevolutionPath) -> Double { @_common.max(self.data) }

pub fn OptmetaevolutionPath::to_string(self : OptmetaevolutionPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_cluster_make(size : Int) -> OptmetaevolutionCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetaevolutionCluster::len(self : OptmetaevolutionCluster) -> Int { self.size }

pub fn OptmetaevolutionCluster::get(self : OptmetaevolutionCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetaevolutionCluster::set(self : OptmetaevolutionCluster, i : Int, v : Double) -> OptmetaevolutionCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionCluster::sum(self : OptmetaevolutionCluster) -> Double { @_common.sum(self.data) }

pub fn OptmetaevolutionCluster::mean(self : OptmetaevolutionCluster) -> Double { @_common.mean(self.data) }

pub fn OptmetaevolutionCluster::scale(self : OptmetaevolutionCluster, f : Double) -> OptmetaevolutionCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionCluster::add(self : OptmetaevolutionCluster, other : OptmetaevolutionCluster) -> OptmetaevolutionCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetaevolutionCluster::copy(self : OptmetaevolutionCluster) -> OptmetaevolutionCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionCluster::fill(self : OptmetaevolutionCluster, v : Double) -> OptmetaevolutionCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionCluster::min(self : OptmetaevolutionCluster) -> Double { @_common.min(self.data) }

pub fn OptmetaevolutionCluster::max(self : OptmetaevolutionCluster) -> Double { @_common.max(self.data) }

pub fn OptmetaevolutionCluster::to_string(self : OptmetaevolutionCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_model_make(size : Int) -> OptmetaevolutionModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetaevolutionModel::len(self : OptmetaevolutionModel) -> Int { self.size }

pub fn OptmetaevolutionModel::get(self : OptmetaevolutionModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetaevolutionModel::set(self : OptmetaevolutionModel, i : Int, v : Double) -> OptmetaevolutionModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionModel::sum(self : OptmetaevolutionModel) -> Double { @_common.sum(self.data) }

pub fn OptmetaevolutionModel::mean(self : OptmetaevolutionModel) -> Double { @_common.mean(self.data) }

pub fn OptmetaevolutionModel::scale(self : OptmetaevolutionModel, f : Double) -> OptmetaevolutionModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionModel::add(self : OptmetaevolutionModel, other : OptmetaevolutionModel) -> OptmetaevolutionModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetaevolutionModel::copy(self : OptmetaevolutionModel) -> OptmetaevolutionModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionModel::fill(self : OptmetaevolutionModel, v : Double) -> OptmetaevolutionModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionModel::min(self : OptmetaevolutionModel) -> Double { @_common.min(self.data) }

pub fn OptmetaevolutionModel::max(self : OptmetaevolutionModel) -> Double { @_common.max(self.data) }

pub fn OptmetaevolutionModel::to_string(self : OptmetaevolutionModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_layer_make(size : Int) -> OptmetaevolutionLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetaevolutionLayer::len(self : OptmetaevolutionLayer) -> Int { self.size }

pub fn OptmetaevolutionLayer::get(self : OptmetaevolutionLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetaevolutionLayer::set(self : OptmetaevolutionLayer, i : Int, v : Double) -> OptmetaevolutionLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionLayer::sum(self : OptmetaevolutionLayer) -> Double { @_common.sum(self.data) }

pub fn OptmetaevolutionLayer::mean(self : OptmetaevolutionLayer) -> Double { @_common.mean(self.data) }

pub fn OptmetaevolutionLayer::scale(self : OptmetaevolutionLayer, f : Double) -> OptmetaevolutionLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionLayer::add(self : OptmetaevolutionLayer, other : OptmetaevolutionLayer) -> OptmetaevolutionLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetaevolutionLayer::copy(self : OptmetaevolutionLayer) -> OptmetaevolutionLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionLayer::fill(self : OptmetaevolutionLayer, v : Double) -> OptmetaevolutionLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionLayer::min(self : OptmetaevolutionLayer) -> Double { @_common.min(self.data) }

pub fn OptmetaevolutionLayer::max(self : OptmetaevolutionLayer) -> Double { @_common.max(self.data) }

pub fn OptmetaevolutionLayer::to_string(self : OptmetaevolutionLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_buffer_make(size : Int) -> OptmetaevolutionBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetaevolutionBuffer::len(self : OptmetaevolutionBuffer) -> Int { self.size }

pub fn OptmetaevolutionBuffer::get(self : OptmetaevolutionBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetaevolutionBuffer::set(self : OptmetaevolutionBuffer, i : Int, v : Double) -> OptmetaevolutionBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionBuffer::sum(self : OptmetaevolutionBuffer) -> Double { @_common.sum(self.data) }

pub fn OptmetaevolutionBuffer::mean(self : OptmetaevolutionBuffer) -> Double { @_common.mean(self.data) }

pub fn OptmetaevolutionBuffer::scale(self : OptmetaevolutionBuffer, f : Double) -> OptmetaevolutionBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionBuffer::add(self : OptmetaevolutionBuffer, other : OptmetaevolutionBuffer) -> OptmetaevolutionBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetaevolutionBuffer::copy(self : OptmetaevolutionBuffer) -> OptmetaevolutionBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionBuffer::fill(self : OptmetaevolutionBuffer, v : Double) -> OptmetaevolutionBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionBuffer::min(self : OptmetaevolutionBuffer) -> Double { @_common.min(self.data) }

pub fn OptmetaevolutionBuffer::max(self : OptmetaevolutionBuffer) -> Double { @_common.max(self.data) }

pub fn OptmetaevolutionBuffer::to_string(self : OptmetaevolutionBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_cursor_make(size : Int) -> OptmetaevolutionCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetaevolutionCursor::len(self : OptmetaevolutionCursor) -> Int { self.size }

pub fn OptmetaevolutionCursor::get(self : OptmetaevolutionCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetaevolutionCursor::set(self : OptmetaevolutionCursor, i : Int, v : Double) -> OptmetaevolutionCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionCursor::sum(self : OptmetaevolutionCursor) -> Double { @_common.sum(self.data) }

pub fn OptmetaevolutionCursor::mean(self : OptmetaevolutionCursor) -> Double { @_common.mean(self.data) }

pub fn OptmetaevolutionCursor::scale(self : OptmetaevolutionCursor, f : Double) -> OptmetaevolutionCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionCursor::add(self : OptmetaevolutionCursor, other : OptmetaevolutionCursor) -> OptmetaevolutionCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetaevolutionCursor::copy(self : OptmetaevolutionCursor) -> OptmetaevolutionCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionCursor::fill(self : OptmetaevolutionCursor, v : Double) -> OptmetaevolutionCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionCursor::min(self : OptmetaevolutionCursor) -> Double { @_common.min(self.data) }

pub fn OptmetaevolutionCursor::max(self : OptmetaevolutionCursor) -> Double { @_common.max(self.data) }

pub fn OptmetaevolutionCursor::to_string(self : OptmetaevolutionCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_view_make(size : Int) -> OptmetaevolutionView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetaevolutionView::len(self : OptmetaevolutionView) -> Int { self.size }

pub fn OptmetaevolutionView::get(self : OptmetaevolutionView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetaevolutionView::set(self : OptmetaevolutionView, i : Int, v : Double) -> OptmetaevolutionView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionView::sum(self : OptmetaevolutionView) -> Double { @_common.sum(self.data) }

pub fn OptmetaevolutionView::mean(self : OptmetaevolutionView) -> Double { @_common.mean(self.data) }

pub fn OptmetaevolutionView::scale(self : OptmetaevolutionView, f : Double) -> OptmetaevolutionView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionView::add(self : OptmetaevolutionView, other : OptmetaevolutionView) -> OptmetaevolutionView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetaevolutionView::copy(self : OptmetaevolutionView) -> OptmetaevolutionView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionView::fill(self : OptmetaevolutionView, v : Double) -> OptmetaevolutionView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionView::min(self : OptmetaevolutionView) -> Double { @_common.min(self.data) }

pub fn OptmetaevolutionView::max(self : OptmetaevolutionView) -> Double { @_common.max(self.data) }

pub fn OptmetaevolutionView::to_string(self : OptmetaevolutionView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_range_make(size : Int) -> OptmetaevolutionRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetaevolutionRange::len(self : OptmetaevolutionRange) -> Int { self.size }

pub fn OptmetaevolutionRange::get(self : OptmetaevolutionRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetaevolutionRange::set(self : OptmetaevolutionRange, i : Int, v : Double) -> OptmetaevolutionRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionRange::sum(self : OptmetaevolutionRange) -> Double { @_common.sum(self.data) }

pub fn OptmetaevolutionRange::mean(self : OptmetaevolutionRange) -> Double { @_common.mean(self.data) }

pub fn OptmetaevolutionRange::scale(self : OptmetaevolutionRange, f : Double) -> OptmetaevolutionRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionRange::add(self : OptmetaevolutionRange, other : OptmetaevolutionRange) -> OptmetaevolutionRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetaevolutionRange::copy(self : OptmetaevolutionRange) -> OptmetaevolutionRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionRange::fill(self : OptmetaevolutionRange, v : Double) -> OptmetaevolutionRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionRange::min(self : OptmetaevolutionRange) -> Double { @_common.min(self.data) }

pub fn OptmetaevolutionRange::max(self : OptmetaevolutionRange) -> Double { @_common.max(self.data) }

pub fn OptmetaevolutionRange::to_string(self : OptmetaevolutionRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_slice_make(size : Int) -> OptmetaevolutionSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetaevolutionSlice::len(self : OptmetaevolutionSlice) -> Int { self.size }

pub fn OptmetaevolutionSlice::get(self : OptmetaevolutionSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetaevolutionSlice::set(self : OptmetaevolutionSlice, i : Int, v : Double) -> OptmetaevolutionSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionSlice::sum(self : OptmetaevolutionSlice) -> Double { @_common.sum(self.data) }

pub fn OptmetaevolutionSlice::mean(self : OptmetaevolutionSlice) -> Double { @_common.mean(self.data) }

pub fn OptmetaevolutionSlice::scale(self : OptmetaevolutionSlice, f : Double) -> OptmetaevolutionSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionSlice::add(self : OptmetaevolutionSlice, other : OptmetaevolutionSlice) -> OptmetaevolutionSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetaevolutionSlice::copy(self : OptmetaevolutionSlice) -> OptmetaevolutionSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionSlice::fill(self : OptmetaevolutionSlice, v : Double) -> OptmetaevolutionSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetaevolutionSlice::min(self : OptmetaevolutionSlice) -> Double { @_common.min(self.data) }

pub fn OptmetaevolutionSlice::max(self : OptmetaevolutionSlice) -> Double { @_common.max(self.data) }

pub fn OptmetaevolutionSlice::to_string(self : OptmetaevolutionSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

