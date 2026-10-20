///===
/// extcore/opt_grad_rmsprop

pub(all) struct OptgradrmspropPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_grad_rmsprop_make_point(x : Double, y : Double) -> OptgradrmspropPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_grad_rmsprop_make_point3(x : Double, y : Double, z : Double) -> OptgradrmspropPoint {
  { x, y, z, label: 0 }
}

pub fn OptgradrmspropPoint::x(self : OptgradrmspropPoint) -> Double { self.x }

pub fn OptgradrmspropPoint::y(self : OptgradrmspropPoint) -> Double { self.y }

pub fn OptgradrmspropPoint::z(self : OptgradrmspropPoint) -> Double { self.z }

pub fn OptgradrmspropPoint::label(self : OptgradrmspropPoint) -> Int { self.label }

pub fn OptgradrmspropPoint::dist(self : OptgradrmspropPoint, other : OptgradrmspropPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn OptgradrmspropPoint::add(self : OptgradrmspropPoint, other : OptgradrmspropPoint) -> OptgradrmspropPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn OptgradrmspropPoint::sub(self : OptgradrmspropPoint, other : OptgradrmspropPoint) -> OptgradrmspropPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn OptgradrmspropPoint::scale(self : OptgradrmspropPoint, s : Double) -> OptgradrmspropPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn OptgradrmspropPoint::dot(self : OptgradrmspropPoint, other : OptgradrmspropPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn OptgradrmspropPoint::cross(self : OptgradrmspropPoint, other : OptgradrmspropPoint) -> OptgradrmspropPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn OptgradrmspropPoint::norm(self : OptgradrmspropPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn OptgradrmspropPoint::normalize(self : OptgradrmspropPoint) -> OptgradrmspropPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptgradrmspropPoint::negate(self : OptgradrmspropPoint) -> OptgradrmspropPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn OptgradrmspropPoint::mid(self : OptgradrmspropPoint, other : OptgradrmspropPoint) -> OptgradrmspropPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn OptgradrmspropPoint::lerp(self : OptgradrmspropPoint, other : OptgradrmspropPoint, t : Double) -> OptgradrmspropPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn OptgradrmspropPoint::to_string(self : OptgradrmspropPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct OptgradrmspropSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_grad_rmsprop_make_series(vals : Array[Double], name : String) -> OptgradrmspropSeries {
  { vals, name, meta: 0 }
}

pub fn OptgradrmspropSeries::len(self : OptgradrmspropSeries) -> Int { self.vals.length() }

pub fn OptgradrmspropSeries::sum(self : OptgradrmspropSeries) -> Double { @_common.sum(self.vals) }

pub fn OptgradrmspropSeries::mean(self : OptgradrmspropSeries) -> Double { @_common.mean(self.vals) }

pub fn OptgradrmspropSeries::min(self : OptgradrmspropSeries) -> Double { @_common.min(self.vals) }

pub fn OptgradrmspropSeries::max(self : OptgradrmspropSeries) -> Double { @_common.max(self.vals) }

pub fn OptgradrmspropSeries::range(self : OptgradrmspropSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn OptgradrmspropSeries::variance(self : OptgradrmspropSeries) -> Double { @_common.variance(self.vals) }

pub fn OptgradrmspropSeries::std(self : OptgradrmspropSeries) -> Double { @_common.std(self.vals) }

pub fn OptgradrmspropSeries::median(self : OptgradrmspropSeries) -> Double { @_common.median(self.vals) }

pub fn OptgradrmspropSeries::scale(self : OptgradrmspropSeries, f : Double) -> OptgradrmspropSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn OptgradrmspropSeries::add(self : OptgradrmspropSeries, other : OptgradrmspropSeries) -> OptgradrmspropSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn OptgradrmspropSeries::sub(self : OptgradrmspropSeries, other : OptgradrmspropSeries) -> OptgradrmspropSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn OptgradrmspropSeries::normalize(self : OptgradrmspropSeries) -> OptgradrmspropSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn OptgradrmspropSeries::cumsum(self : OptgradrmspropSeries) -> OptgradrmspropSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn OptgradrmspropSeries::to_string(self : OptgradrmspropSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptgradrmspropMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_grad_rmsprop_make_matrix(rows : Int, cols : Int, val : Double) -> OptgradrmspropMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_grad_rmsprop_matrix_identity(n : Int) -> OptgradrmspropMatrix {
  let m = opt_grad_rmsprop_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn OptgradrmspropMatrix::get(self : OptgradrmspropMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn OptgradrmspropMatrix::transpose(self : OptgradrmspropMatrix) -> OptgradrmspropMatrix {
  let result = opt_grad_rmsprop_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn OptgradrmspropMatrix::add(self : OptgradrmspropMatrix, other : OptgradrmspropMatrix) -> OptgradrmspropMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = opt_grad_rmsprop_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn OptgradrmspropMatrix::scale(self : OptgradrmspropMatrix, s : Double) -> OptgradrmspropMatrix {
  let result = opt_grad_rmsprop_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn OptgradrmspropMatrix::multiply(self : OptgradrmspropMatrix, other : OptgradrmspropMatrix) -> OptgradrmspropMatrix {
  if self.cols != other.rows { return opt_grad_rmsprop_make_matrix(self.rows, other.cols, 0.0) }
  let result = opt_grad_rmsprop_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn OptgradrmspropMatrix::trace(self : OptgradrmspropMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn OptgradrmspropMatrix::det(self : OptgradrmspropMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn OptgradrmspropMatrix::norm(self : OptgradrmspropMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn OptgradrmspropMatrix::to_string(self : OptgradrmspropMatrix) -> String {
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

pub(all) struct OptgradrmspropVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_grad_rmsprop_make_vector(comps : Array[Double]) -> OptgradrmspropVector {
  { comps, dim: comps.length() }
}

pub fn opt_grad_rmsprop_vector_zero(dim : Int) -> OptgradrmspropVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn OptgradrmspropVector::add(self : OptgradrmspropVector, other : OptgradrmspropVector) -> OptgradrmspropVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn OptgradrmspropVector::sub(self : OptgradrmspropVector, other : OptgradrmspropVector) -> OptgradrmspropVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn OptgradrmspropVector::scale(self : OptgradrmspropVector, s : Double) -> OptgradrmspropVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn OptgradrmspropVector::dot(self : OptgradrmspropVector, other : OptgradrmspropVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn OptgradrmspropVector::norm(self : OptgradrmspropVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn OptgradrmspropVector::normalize(self : OptgradrmspropVector) -> OptgradrmspropVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptgradrmspropVector::dist(self : OptgradrmspropVector, other : OptgradrmspropVector) -> Double {
  self.sub(other).norm()
}

pub fn OptgradrmspropVector::to_string(self : OptgradrmspropVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptgradrmspropFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_rmsprop_frame_make(size : Int) -> OptgradrmspropFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradrmspropFrame::len(self : OptgradrmspropFrame) -> Int { self.size }

pub fn OptgradrmspropFrame::get(self : OptgradrmspropFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradrmspropFrame::set(self : OptgradrmspropFrame, i : Int, v : Double) -> OptgradrmspropFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradrmspropFrame::sum(self : OptgradrmspropFrame) -> Double { @_common.sum(self.data) }

pub fn OptgradrmspropFrame::mean(self : OptgradrmspropFrame) -> Double { @_common.mean(self.data) }

pub fn OptgradrmspropFrame::scale(self : OptgradrmspropFrame, f : Double) -> OptgradrmspropFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradrmspropFrame::add(self : OptgradrmspropFrame, other : OptgradrmspropFrame) -> OptgradrmspropFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradrmspropFrame::copy(self : OptgradrmspropFrame) -> OptgradrmspropFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradrmspropFrame::fill(self : OptgradrmspropFrame, v : Double) -> OptgradrmspropFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradrmspropFrame::min(self : OptgradrmspropFrame) -> Double { @_common.min(self.data) }

pub fn OptgradrmspropFrame::max(self : OptgradrmspropFrame) -> Double { @_common.max(self.data) }

pub fn OptgradrmspropFrame::to_string(self : OptgradrmspropFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradrmspropTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_rmsprop_table_make(size : Int) -> OptgradrmspropTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradrmspropTable::len(self : OptgradrmspropTable) -> Int { self.size }

pub fn OptgradrmspropTable::get(self : OptgradrmspropTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradrmspropTable::set(self : OptgradrmspropTable, i : Int, v : Double) -> OptgradrmspropTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradrmspropTable::sum(self : OptgradrmspropTable) -> Double { @_common.sum(self.data) }

pub fn OptgradrmspropTable::mean(self : OptgradrmspropTable) -> Double { @_common.mean(self.data) }

pub fn OptgradrmspropTable::scale(self : OptgradrmspropTable, f : Double) -> OptgradrmspropTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradrmspropTable::add(self : OptgradrmspropTable, other : OptgradrmspropTable) -> OptgradrmspropTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradrmspropTable::copy(self : OptgradrmspropTable) -> OptgradrmspropTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradrmspropTable::fill(self : OptgradrmspropTable, v : Double) -> OptgradrmspropTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradrmspropTable::min(self : OptgradrmspropTable) -> Double { @_common.min(self.data) }

pub fn OptgradrmspropTable::max(self : OptgradrmspropTable) -> Double { @_common.max(self.data) }

pub fn OptgradrmspropTable::to_string(self : OptgradrmspropTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradrmspropGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_rmsprop_graphn_make(size : Int) -> OptgradrmspropGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradrmspropGraphN::len(self : OptgradrmspropGraphN) -> Int { self.size }

pub fn OptgradrmspropGraphN::get(self : OptgradrmspropGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradrmspropGraphN::set(self : OptgradrmspropGraphN, i : Int, v : Double) -> OptgradrmspropGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradrmspropGraphN::sum(self : OptgradrmspropGraphN) -> Double { @_common.sum(self.data) }

pub fn OptgradrmspropGraphN::mean(self : OptgradrmspropGraphN) -> Double { @_common.mean(self.data) }

pub fn OptgradrmspropGraphN::scale(self : OptgradrmspropGraphN, f : Double) -> OptgradrmspropGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradrmspropGraphN::add(self : OptgradrmspropGraphN, other : OptgradrmspropGraphN) -> OptgradrmspropGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradrmspropGraphN::copy(self : OptgradrmspropGraphN) -> OptgradrmspropGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradrmspropGraphN::fill(self : OptgradrmspropGraphN, v : Double) -> OptgradrmspropGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradrmspropGraphN::min(self : OptgradrmspropGraphN) -> Double { @_common.min(self.data) }

pub fn OptgradrmspropGraphN::max(self : OptgradrmspropGraphN) -> Double { @_common.max(self.data) }

pub fn OptgradrmspropGraphN::to_string(self : OptgradrmspropGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradrmspropNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_rmsprop_node_make(size : Int) -> OptgradrmspropNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradrmspropNode::len(self : OptgradrmspropNode) -> Int { self.size }

pub fn OptgradrmspropNode::get(self : OptgradrmspropNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradrmspropNode::set(self : OptgradrmspropNode, i : Int, v : Double) -> OptgradrmspropNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradrmspropNode::sum(self : OptgradrmspropNode) -> Double { @_common.sum(self.data) }

pub fn OptgradrmspropNode::mean(self : OptgradrmspropNode) -> Double { @_common.mean(self.data) }

pub fn OptgradrmspropNode::scale(self : OptgradrmspropNode, f : Double) -> OptgradrmspropNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradrmspropNode::add(self : OptgradrmspropNode, other : OptgradrmspropNode) -> OptgradrmspropNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradrmspropNode::copy(self : OptgradrmspropNode) -> OptgradrmspropNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradrmspropNode::fill(self : OptgradrmspropNode, v : Double) -> OptgradrmspropNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradrmspropNode::min(self : OptgradrmspropNode) -> Double { @_common.min(self.data) }

pub fn OptgradrmspropNode::max(self : OptgradrmspropNode) -> Double { @_common.max(self.data) }

pub fn OptgradrmspropNode::to_string(self : OptgradrmspropNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradrmspropEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_rmsprop_edge_make(size : Int) -> OptgradrmspropEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradrmspropEdge::len(self : OptgradrmspropEdge) -> Int { self.size }

pub fn OptgradrmspropEdge::get(self : OptgradrmspropEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradrmspropEdge::set(self : OptgradrmspropEdge, i : Int, v : Double) -> OptgradrmspropEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradrmspropEdge::sum(self : OptgradrmspropEdge) -> Double { @_common.sum(self.data) }

pub fn OptgradrmspropEdge::mean(self : OptgradrmspropEdge) -> Double { @_common.mean(self.data) }

pub fn OptgradrmspropEdge::scale(self : OptgradrmspropEdge, f : Double) -> OptgradrmspropEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradrmspropEdge::add(self : OptgradrmspropEdge, other : OptgradrmspropEdge) -> OptgradrmspropEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradrmspropEdge::copy(self : OptgradrmspropEdge) -> OptgradrmspropEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradrmspropEdge::fill(self : OptgradrmspropEdge, v : Double) -> OptgradrmspropEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradrmspropEdge::min(self : OptgradrmspropEdge) -> Double { @_common.min(self.data) }

pub fn OptgradrmspropEdge::max(self : OptgradrmspropEdge) -> Double { @_common.max(self.data) }

pub fn OptgradrmspropEdge::to_string(self : OptgradrmspropEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradrmspropPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_rmsprop_path_make(size : Int) -> OptgradrmspropPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradrmspropPath::len(self : OptgradrmspropPath) -> Int { self.size }

pub fn OptgradrmspropPath::get(self : OptgradrmspropPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradrmspropPath::set(self : OptgradrmspropPath, i : Int, v : Double) -> OptgradrmspropPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradrmspropPath::sum(self : OptgradrmspropPath) -> Double { @_common.sum(self.data) }

pub fn OptgradrmspropPath::mean(self : OptgradrmspropPath) -> Double { @_common.mean(self.data) }

pub fn OptgradrmspropPath::scale(self : OptgradrmspropPath, f : Double) -> OptgradrmspropPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradrmspropPath::add(self : OptgradrmspropPath, other : OptgradrmspropPath) -> OptgradrmspropPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradrmspropPath::copy(self : OptgradrmspropPath) -> OptgradrmspropPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradrmspropPath::fill(self : OptgradrmspropPath, v : Double) -> OptgradrmspropPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradrmspropPath::min(self : OptgradrmspropPath) -> Double { @_common.min(self.data) }

pub fn OptgradrmspropPath::max(self : OptgradrmspropPath) -> Double { @_common.max(self.data) }

pub fn OptgradrmspropPath::to_string(self : OptgradrmspropPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradrmspropCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_rmsprop_cluster_make(size : Int) -> OptgradrmspropCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradrmspropCluster::len(self : OptgradrmspropCluster) -> Int { self.size }

pub fn OptgradrmspropCluster::get(self : OptgradrmspropCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradrmspropCluster::set(self : OptgradrmspropCluster, i : Int, v : Double) -> OptgradrmspropCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradrmspropCluster::sum(self : OptgradrmspropCluster) -> Double { @_common.sum(self.data) }

pub fn OptgradrmspropCluster::mean(self : OptgradrmspropCluster) -> Double { @_common.mean(self.data) }

pub fn OptgradrmspropCluster::scale(self : OptgradrmspropCluster, f : Double) -> OptgradrmspropCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradrmspropCluster::add(self : OptgradrmspropCluster, other : OptgradrmspropCluster) -> OptgradrmspropCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradrmspropCluster::copy(self : OptgradrmspropCluster) -> OptgradrmspropCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradrmspropCluster::fill(self : OptgradrmspropCluster, v : Double) -> OptgradrmspropCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradrmspropCluster::min(self : OptgradrmspropCluster) -> Double { @_common.min(self.data) }

pub fn OptgradrmspropCluster::max(self : OptgradrmspropCluster) -> Double { @_common.max(self.data) }

pub fn OptgradrmspropCluster::to_string(self : OptgradrmspropCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradrmspropModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_rmsprop_model_make(size : Int) -> OptgradrmspropModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradrmspropModel::len(self : OptgradrmspropModel) -> Int { self.size }

pub fn OptgradrmspropModel::get(self : OptgradrmspropModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradrmspropModel::set(self : OptgradrmspropModel, i : Int, v : Double) -> OptgradrmspropModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradrmspropModel::sum(self : OptgradrmspropModel) -> Double { @_common.sum(self.data) }

pub fn OptgradrmspropModel::mean(self : OptgradrmspropModel) -> Double { @_common.mean(self.data) }

pub fn OptgradrmspropModel::scale(self : OptgradrmspropModel, f : Double) -> OptgradrmspropModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradrmspropModel::add(self : OptgradrmspropModel, other : OptgradrmspropModel) -> OptgradrmspropModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradrmspropModel::copy(self : OptgradrmspropModel) -> OptgradrmspropModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradrmspropModel::fill(self : OptgradrmspropModel, v : Double) -> OptgradrmspropModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradrmspropModel::min(self : OptgradrmspropModel) -> Double { @_common.min(self.data) }

pub fn OptgradrmspropModel::max(self : OptgradrmspropModel) -> Double { @_common.max(self.data) }

pub fn OptgradrmspropModel::to_string(self : OptgradrmspropModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradrmspropLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_rmsprop_layer_make(size : Int) -> OptgradrmspropLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradrmspropLayer::len(self : OptgradrmspropLayer) -> Int { self.size }

pub fn OptgradrmspropLayer::get(self : OptgradrmspropLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradrmspropLayer::set(self : OptgradrmspropLayer, i : Int, v : Double) -> OptgradrmspropLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradrmspropLayer::sum(self : OptgradrmspropLayer) -> Double { @_common.sum(self.data) }

pub fn OptgradrmspropLayer::mean(self : OptgradrmspropLayer) -> Double { @_common.mean(self.data) }

pub fn OptgradrmspropLayer::scale(self : OptgradrmspropLayer, f : Double) -> OptgradrmspropLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradrmspropLayer::add(self : OptgradrmspropLayer, other : OptgradrmspropLayer) -> OptgradrmspropLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradrmspropLayer::copy(self : OptgradrmspropLayer) -> OptgradrmspropLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradrmspropLayer::fill(self : OptgradrmspropLayer, v : Double) -> OptgradrmspropLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradrmspropLayer::min(self : OptgradrmspropLayer) -> Double { @_common.min(self.data) }

pub fn OptgradrmspropLayer::max(self : OptgradrmspropLayer) -> Double { @_common.max(self.data) }

pub fn OptgradrmspropLayer::to_string(self : OptgradrmspropLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradrmspropBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_rmsprop_buffer_make(size : Int) -> OptgradrmspropBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradrmspropBuffer::len(self : OptgradrmspropBuffer) -> Int { self.size }

pub fn OptgradrmspropBuffer::get(self : OptgradrmspropBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradrmspropBuffer::set(self : OptgradrmspropBuffer, i : Int, v : Double) -> OptgradrmspropBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradrmspropBuffer::sum(self : OptgradrmspropBuffer) -> Double { @_common.sum(self.data) }

pub fn OptgradrmspropBuffer::mean(self : OptgradrmspropBuffer) -> Double { @_common.mean(self.data) }

pub fn OptgradrmspropBuffer::scale(self : OptgradrmspropBuffer, f : Double) -> OptgradrmspropBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradrmspropBuffer::add(self : OptgradrmspropBuffer, other : OptgradrmspropBuffer) -> OptgradrmspropBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradrmspropBuffer::copy(self : OptgradrmspropBuffer) -> OptgradrmspropBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradrmspropBuffer::fill(self : OptgradrmspropBuffer, v : Double) -> OptgradrmspropBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradrmspropBuffer::min(self : OptgradrmspropBuffer) -> Double { @_common.min(self.data) }

pub fn OptgradrmspropBuffer::max(self : OptgradrmspropBuffer) -> Double { @_common.max(self.data) }

pub fn OptgradrmspropBuffer::to_string(self : OptgradrmspropBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradrmspropCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_rmsprop_cursor_make(size : Int) -> OptgradrmspropCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradrmspropCursor::len(self : OptgradrmspropCursor) -> Int { self.size }

pub fn OptgradrmspropCursor::get(self : OptgradrmspropCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradrmspropCursor::set(self : OptgradrmspropCursor, i : Int, v : Double) -> OptgradrmspropCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradrmspropCursor::sum(self : OptgradrmspropCursor) -> Double { @_common.sum(self.data) }

pub fn OptgradrmspropCursor::mean(self : OptgradrmspropCursor) -> Double { @_common.mean(self.data) }

pub fn OptgradrmspropCursor::scale(self : OptgradrmspropCursor, f : Double) -> OptgradrmspropCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradrmspropCursor::add(self : OptgradrmspropCursor, other : OptgradrmspropCursor) -> OptgradrmspropCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradrmspropCursor::copy(self : OptgradrmspropCursor) -> OptgradrmspropCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradrmspropCursor::fill(self : OptgradrmspropCursor, v : Double) -> OptgradrmspropCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradrmspropCursor::min(self : OptgradrmspropCursor) -> Double { @_common.min(self.data) }

pub fn OptgradrmspropCursor::max(self : OptgradrmspropCursor) -> Double { @_common.max(self.data) }

pub fn OptgradrmspropCursor::to_string(self : OptgradrmspropCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradrmspropView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_rmsprop_view_make(size : Int) -> OptgradrmspropView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradrmspropView::len(self : OptgradrmspropView) -> Int { self.size }

pub fn OptgradrmspropView::get(self : OptgradrmspropView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradrmspropView::set(self : OptgradrmspropView, i : Int, v : Double) -> OptgradrmspropView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradrmspropView::sum(self : OptgradrmspropView) -> Double { @_common.sum(self.data) }

pub fn OptgradrmspropView::mean(self : OptgradrmspropView) -> Double { @_common.mean(self.data) }

pub fn OptgradrmspropView::scale(self : OptgradrmspropView, f : Double) -> OptgradrmspropView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradrmspropView::add(self : OptgradrmspropView, other : OptgradrmspropView) -> OptgradrmspropView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradrmspropView::copy(self : OptgradrmspropView) -> OptgradrmspropView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradrmspropView::fill(self : OptgradrmspropView, v : Double) -> OptgradrmspropView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradrmspropView::min(self : OptgradrmspropView) -> Double { @_common.min(self.data) }

pub fn OptgradrmspropView::max(self : OptgradrmspropView) -> Double { @_common.max(self.data) }

pub fn OptgradrmspropView::to_string(self : OptgradrmspropView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradrmspropRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_rmsprop_range_make(size : Int) -> OptgradrmspropRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradrmspropRange::len(self : OptgradrmspropRange) -> Int { self.size }

pub fn OptgradrmspropRange::get(self : OptgradrmspropRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradrmspropRange::set(self : OptgradrmspropRange, i : Int, v : Double) -> OptgradrmspropRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradrmspropRange::sum(self : OptgradrmspropRange) -> Double { @_common.sum(self.data) }

pub fn OptgradrmspropRange::mean(self : OptgradrmspropRange) -> Double { @_common.mean(self.data) }

pub fn OptgradrmspropRange::scale(self : OptgradrmspropRange, f : Double) -> OptgradrmspropRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradrmspropRange::add(self : OptgradrmspropRange, other : OptgradrmspropRange) -> OptgradrmspropRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradrmspropRange::copy(self : OptgradrmspropRange) -> OptgradrmspropRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradrmspropRange::fill(self : OptgradrmspropRange, v : Double) -> OptgradrmspropRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradrmspropRange::min(self : OptgradrmspropRange) -> Double { @_common.min(self.data) }

pub fn OptgradrmspropRange::max(self : OptgradrmspropRange) -> Double { @_common.max(self.data) }

pub fn OptgradrmspropRange::to_string(self : OptgradrmspropRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradrmspropSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_rmsprop_slice_make(size : Int) -> OptgradrmspropSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradrmspropSlice::len(self : OptgradrmspropSlice) -> Int { self.size }

pub fn OptgradrmspropSlice::get(self : OptgradrmspropSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradrmspropSlice::set(self : OptgradrmspropSlice, i : Int, v : Double) -> OptgradrmspropSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradrmspropSlice::sum(self : OptgradrmspropSlice) -> Double { @_common.sum(self.data) }

pub fn OptgradrmspropSlice::mean(self : OptgradrmspropSlice) -> Double { @_common.mean(self.data) }

pub fn OptgradrmspropSlice::scale(self : OptgradrmspropSlice, f : Double) -> OptgradrmspropSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradrmspropSlice::add(self : OptgradrmspropSlice, other : OptgradrmspropSlice) -> OptgradrmspropSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradrmspropSlice::copy(self : OptgradrmspropSlice) -> OptgradrmspropSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradrmspropSlice::fill(self : OptgradrmspropSlice, v : Double) -> OptgradrmspropSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradrmspropSlice::min(self : OptgradrmspropSlice) -> Double { @_common.min(self.data) }

pub fn OptgradrmspropSlice::max(self : OptgradrmspropSlice) -> Double { @_common.max(self.data) }

pub fn OptgradrmspropSlice::to_string(self : OptgradrmspropSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

