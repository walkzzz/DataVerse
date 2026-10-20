///===
/// extcore/ml_rl_dqn

pub(all) struct MlrldqnPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_rl_dqn_make_point(x : Double, y : Double) -> MlrldqnPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_rl_dqn_make_point3(x : Double, y : Double, z : Double) -> MlrldqnPoint {
  { x, y, z, label: 0 }
}

pub fn MlrldqnPoint::x(self : MlrldqnPoint) -> Double { self.x }

pub fn MlrldqnPoint::y(self : MlrldqnPoint) -> Double { self.y }

pub fn MlrldqnPoint::z(self : MlrldqnPoint) -> Double { self.z }

pub fn MlrldqnPoint::label(self : MlrldqnPoint) -> Int { self.label }

pub fn MlrldqnPoint::dist(self : MlrldqnPoint, other : MlrldqnPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlrldqnPoint::add(self : MlrldqnPoint, other : MlrldqnPoint) -> MlrldqnPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlrldqnPoint::sub(self : MlrldqnPoint, other : MlrldqnPoint) -> MlrldqnPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlrldqnPoint::scale(self : MlrldqnPoint, s : Double) -> MlrldqnPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlrldqnPoint::dot(self : MlrldqnPoint, other : MlrldqnPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlrldqnPoint::cross(self : MlrldqnPoint, other : MlrldqnPoint) -> MlrldqnPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlrldqnPoint::norm(self : MlrldqnPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlrldqnPoint::normalize(self : MlrldqnPoint) -> MlrldqnPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlrldqnPoint::negate(self : MlrldqnPoint) -> MlrldqnPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlrldqnPoint::mid(self : MlrldqnPoint, other : MlrldqnPoint) -> MlrldqnPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlrldqnPoint::lerp(self : MlrldqnPoint, other : MlrldqnPoint, t : Double) -> MlrldqnPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlrldqnPoint::to_string(self : MlrldqnPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlrldqnSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_rl_dqn_make_series(vals : Array[Double], name : String) -> MlrldqnSeries {
  { vals, name, meta: 0 }
}

pub fn MlrldqnSeries::len(self : MlrldqnSeries) -> Int { self.vals.length() }

pub fn MlrldqnSeries::sum(self : MlrldqnSeries) -> Double { @_common.sum(self.vals) }

pub fn MlrldqnSeries::mean(self : MlrldqnSeries) -> Double { @_common.mean(self.vals) }

pub fn MlrldqnSeries::min(self : MlrldqnSeries) -> Double { @_common.min(self.vals) }

pub fn MlrldqnSeries::max(self : MlrldqnSeries) -> Double { @_common.max(self.vals) }

pub fn MlrldqnSeries::range(self : MlrldqnSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlrldqnSeries::variance(self : MlrldqnSeries) -> Double { @_common.variance(self.vals) }

pub fn MlrldqnSeries::std(self : MlrldqnSeries) -> Double { @_common.std(self.vals) }

pub fn MlrldqnSeries::median(self : MlrldqnSeries) -> Double { @_common.median(self.vals) }

pub fn MlrldqnSeries::scale(self : MlrldqnSeries, f : Double) -> MlrldqnSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlrldqnSeries::add(self : MlrldqnSeries, other : MlrldqnSeries) -> MlrldqnSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlrldqnSeries::sub(self : MlrldqnSeries, other : MlrldqnSeries) -> MlrldqnSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlrldqnSeries::normalize(self : MlrldqnSeries) -> MlrldqnSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlrldqnSeries::cumsum(self : MlrldqnSeries) -> MlrldqnSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlrldqnSeries::to_string(self : MlrldqnSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlrldqnMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_rl_dqn_make_matrix(rows : Int, cols : Int, val : Double) -> MlrldqnMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn ml_rl_dqn_matrix_identity(n : Int) -> MlrldqnMatrix {
  let m = ml_rl_dqn_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlrldqnMatrix::get(self : MlrldqnMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlrldqnMatrix::transpose(self : MlrldqnMatrix) -> MlrldqnMatrix {
  let result = ml_rl_dqn_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlrldqnMatrix::add(self : MlrldqnMatrix, other : MlrldqnMatrix) -> MlrldqnMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_rl_dqn_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlrldqnMatrix::scale(self : MlrldqnMatrix, s : Double) -> MlrldqnMatrix {
  let result = ml_rl_dqn_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlrldqnMatrix::multiply(self : MlrldqnMatrix, other : MlrldqnMatrix) -> MlrldqnMatrix {
  if self.cols != other.rows { return ml_rl_dqn_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_rl_dqn_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MlrldqnMatrix::trace(self : MlrldqnMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlrldqnMatrix::det(self : MlrldqnMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlrldqnMatrix::norm(self : MlrldqnMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlrldqnMatrix::to_string(self : MlrldqnMatrix) -> String {
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

pub(all) struct MlrldqnVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_rl_dqn_make_vector(comps : Array[Double]) -> MlrldqnVector {
  { comps, dim: comps.length() }
}

pub fn ml_rl_dqn_vector_zero(dim : Int) -> MlrldqnVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlrldqnVector::add(self : MlrldqnVector, other : MlrldqnVector) -> MlrldqnVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlrldqnVector::sub(self : MlrldqnVector, other : MlrldqnVector) -> MlrldqnVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlrldqnVector::scale(self : MlrldqnVector, s : Double) -> MlrldqnVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlrldqnVector::dot(self : MlrldqnVector, other : MlrldqnVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlrldqnVector::norm(self : MlrldqnVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlrldqnVector::normalize(self : MlrldqnVector) -> MlrldqnVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlrldqnVector::dist(self : MlrldqnVector, other : MlrldqnVector) -> Double {
  self.sub(other).norm()
}

pub fn MlrldqnVector::to_string(self : MlrldqnVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlrldqnFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_dqn_frame_make(size : Int) -> MlrldqnFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrldqnFrame::len(self : MlrldqnFrame) -> Int { self.size }

pub fn MlrldqnFrame::get(self : MlrldqnFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrldqnFrame::set(self : MlrldqnFrame, i : Int, v : Double) -> MlrldqnFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrldqnFrame::sum(self : MlrldqnFrame) -> Double { @_common.sum(self.data) }

pub fn MlrldqnFrame::mean(self : MlrldqnFrame) -> Double { @_common.mean(self.data) }

pub fn MlrldqnFrame::scale(self : MlrldqnFrame, f : Double) -> MlrldqnFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrldqnFrame::add(self : MlrldqnFrame, other : MlrldqnFrame) -> MlrldqnFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrldqnFrame::copy(self : MlrldqnFrame) -> MlrldqnFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrldqnFrame::fill(self : MlrldqnFrame, v : Double) -> MlrldqnFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrldqnFrame::min(self : MlrldqnFrame) -> Double { @_common.min(self.data) }

pub fn MlrldqnFrame::max(self : MlrldqnFrame) -> Double { @_common.max(self.data) }

pub fn MlrldqnFrame::to_string(self : MlrldqnFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrldqnTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_dqn_table_make(size : Int) -> MlrldqnTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrldqnTable::len(self : MlrldqnTable) -> Int { self.size }

pub fn MlrldqnTable::get(self : MlrldqnTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrldqnTable::set(self : MlrldqnTable, i : Int, v : Double) -> MlrldqnTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrldqnTable::sum(self : MlrldqnTable) -> Double { @_common.sum(self.data) }

pub fn MlrldqnTable::mean(self : MlrldqnTable) -> Double { @_common.mean(self.data) }

pub fn MlrldqnTable::scale(self : MlrldqnTable, f : Double) -> MlrldqnTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrldqnTable::add(self : MlrldqnTable, other : MlrldqnTable) -> MlrldqnTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrldqnTable::copy(self : MlrldqnTable) -> MlrldqnTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrldqnTable::fill(self : MlrldqnTable, v : Double) -> MlrldqnTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrldqnTable::min(self : MlrldqnTable) -> Double { @_common.min(self.data) }

pub fn MlrldqnTable::max(self : MlrldqnTable) -> Double { @_common.max(self.data) }

pub fn MlrldqnTable::to_string(self : MlrldqnTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrldqnGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_dqn_graphn_make(size : Int) -> MlrldqnGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrldqnGraphN::len(self : MlrldqnGraphN) -> Int { self.size }

pub fn MlrldqnGraphN::get(self : MlrldqnGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrldqnGraphN::set(self : MlrldqnGraphN, i : Int, v : Double) -> MlrldqnGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrldqnGraphN::sum(self : MlrldqnGraphN) -> Double { @_common.sum(self.data) }

pub fn MlrldqnGraphN::mean(self : MlrldqnGraphN) -> Double { @_common.mean(self.data) }

pub fn MlrldqnGraphN::scale(self : MlrldqnGraphN, f : Double) -> MlrldqnGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrldqnGraphN::add(self : MlrldqnGraphN, other : MlrldqnGraphN) -> MlrldqnGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrldqnGraphN::copy(self : MlrldqnGraphN) -> MlrldqnGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrldqnGraphN::fill(self : MlrldqnGraphN, v : Double) -> MlrldqnGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrldqnGraphN::min(self : MlrldqnGraphN) -> Double { @_common.min(self.data) }

pub fn MlrldqnGraphN::max(self : MlrldqnGraphN) -> Double { @_common.max(self.data) }

pub fn MlrldqnGraphN::to_string(self : MlrldqnGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrldqnNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_dqn_node_make(size : Int) -> MlrldqnNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrldqnNode::len(self : MlrldqnNode) -> Int { self.size }

pub fn MlrldqnNode::get(self : MlrldqnNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrldqnNode::set(self : MlrldqnNode, i : Int, v : Double) -> MlrldqnNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrldqnNode::sum(self : MlrldqnNode) -> Double { @_common.sum(self.data) }

pub fn MlrldqnNode::mean(self : MlrldqnNode) -> Double { @_common.mean(self.data) }

pub fn MlrldqnNode::scale(self : MlrldqnNode, f : Double) -> MlrldqnNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrldqnNode::add(self : MlrldqnNode, other : MlrldqnNode) -> MlrldqnNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrldqnNode::copy(self : MlrldqnNode) -> MlrldqnNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrldqnNode::fill(self : MlrldqnNode, v : Double) -> MlrldqnNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrldqnNode::min(self : MlrldqnNode) -> Double { @_common.min(self.data) }

pub fn MlrldqnNode::max(self : MlrldqnNode) -> Double { @_common.max(self.data) }

pub fn MlrldqnNode::to_string(self : MlrldqnNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrldqnEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_dqn_edge_make(size : Int) -> MlrldqnEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrldqnEdge::len(self : MlrldqnEdge) -> Int { self.size }

pub fn MlrldqnEdge::get(self : MlrldqnEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrldqnEdge::set(self : MlrldqnEdge, i : Int, v : Double) -> MlrldqnEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrldqnEdge::sum(self : MlrldqnEdge) -> Double { @_common.sum(self.data) }

pub fn MlrldqnEdge::mean(self : MlrldqnEdge) -> Double { @_common.mean(self.data) }

pub fn MlrldqnEdge::scale(self : MlrldqnEdge, f : Double) -> MlrldqnEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrldqnEdge::add(self : MlrldqnEdge, other : MlrldqnEdge) -> MlrldqnEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrldqnEdge::copy(self : MlrldqnEdge) -> MlrldqnEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrldqnEdge::fill(self : MlrldqnEdge, v : Double) -> MlrldqnEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrldqnEdge::min(self : MlrldqnEdge) -> Double { @_common.min(self.data) }

pub fn MlrldqnEdge::max(self : MlrldqnEdge) -> Double { @_common.max(self.data) }

pub fn MlrldqnEdge::to_string(self : MlrldqnEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrldqnPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_dqn_path_make(size : Int) -> MlrldqnPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrldqnPath::len(self : MlrldqnPath) -> Int { self.size }

pub fn MlrldqnPath::get(self : MlrldqnPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrldqnPath::set(self : MlrldqnPath, i : Int, v : Double) -> MlrldqnPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrldqnPath::sum(self : MlrldqnPath) -> Double { @_common.sum(self.data) }

pub fn MlrldqnPath::mean(self : MlrldqnPath) -> Double { @_common.mean(self.data) }

pub fn MlrldqnPath::scale(self : MlrldqnPath, f : Double) -> MlrldqnPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrldqnPath::add(self : MlrldqnPath, other : MlrldqnPath) -> MlrldqnPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrldqnPath::copy(self : MlrldqnPath) -> MlrldqnPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrldqnPath::fill(self : MlrldqnPath, v : Double) -> MlrldqnPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrldqnPath::min(self : MlrldqnPath) -> Double { @_common.min(self.data) }

pub fn MlrldqnPath::max(self : MlrldqnPath) -> Double { @_common.max(self.data) }

pub fn MlrldqnPath::to_string(self : MlrldqnPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrldqnCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_dqn_cluster_make(size : Int) -> MlrldqnCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrldqnCluster::len(self : MlrldqnCluster) -> Int { self.size }

pub fn MlrldqnCluster::get(self : MlrldqnCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrldqnCluster::set(self : MlrldqnCluster, i : Int, v : Double) -> MlrldqnCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrldqnCluster::sum(self : MlrldqnCluster) -> Double { @_common.sum(self.data) }

pub fn MlrldqnCluster::mean(self : MlrldqnCluster) -> Double { @_common.mean(self.data) }

pub fn MlrldqnCluster::scale(self : MlrldqnCluster, f : Double) -> MlrldqnCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrldqnCluster::add(self : MlrldqnCluster, other : MlrldqnCluster) -> MlrldqnCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrldqnCluster::copy(self : MlrldqnCluster) -> MlrldqnCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrldqnCluster::fill(self : MlrldqnCluster, v : Double) -> MlrldqnCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrldqnCluster::min(self : MlrldqnCluster) -> Double { @_common.min(self.data) }

pub fn MlrldqnCluster::max(self : MlrldqnCluster) -> Double { @_common.max(self.data) }

pub fn MlrldqnCluster::to_string(self : MlrldqnCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrldqnModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_dqn_model_make(size : Int) -> MlrldqnModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrldqnModel::len(self : MlrldqnModel) -> Int { self.size }

pub fn MlrldqnModel::get(self : MlrldqnModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrldqnModel::set(self : MlrldqnModel, i : Int, v : Double) -> MlrldqnModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrldqnModel::sum(self : MlrldqnModel) -> Double { @_common.sum(self.data) }

pub fn MlrldqnModel::mean(self : MlrldqnModel) -> Double { @_common.mean(self.data) }

pub fn MlrldqnModel::scale(self : MlrldqnModel, f : Double) -> MlrldqnModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrldqnModel::add(self : MlrldqnModel, other : MlrldqnModel) -> MlrldqnModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrldqnModel::copy(self : MlrldqnModel) -> MlrldqnModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrldqnModel::fill(self : MlrldqnModel, v : Double) -> MlrldqnModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrldqnModel::min(self : MlrldqnModel) -> Double { @_common.min(self.data) }

pub fn MlrldqnModel::max(self : MlrldqnModel) -> Double { @_common.max(self.data) }

pub fn MlrldqnModel::to_string(self : MlrldqnModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrldqnLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_dqn_layer_make(size : Int) -> MlrldqnLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrldqnLayer::len(self : MlrldqnLayer) -> Int { self.size }

pub fn MlrldqnLayer::get(self : MlrldqnLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrldqnLayer::set(self : MlrldqnLayer, i : Int, v : Double) -> MlrldqnLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrldqnLayer::sum(self : MlrldqnLayer) -> Double { @_common.sum(self.data) }

pub fn MlrldqnLayer::mean(self : MlrldqnLayer) -> Double { @_common.mean(self.data) }

pub fn MlrldqnLayer::scale(self : MlrldqnLayer, f : Double) -> MlrldqnLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrldqnLayer::add(self : MlrldqnLayer, other : MlrldqnLayer) -> MlrldqnLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrldqnLayer::copy(self : MlrldqnLayer) -> MlrldqnLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrldqnLayer::fill(self : MlrldqnLayer, v : Double) -> MlrldqnLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrldqnLayer::min(self : MlrldqnLayer) -> Double { @_common.min(self.data) }

pub fn MlrldqnLayer::max(self : MlrldqnLayer) -> Double { @_common.max(self.data) }

pub fn MlrldqnLayer::to_string(self : MlrldqnLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrldqnBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_dqn_buffer_make(size : Int) -> MlrldqnBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrldqnBuffer::len(self : MlrldqnBuffer) -> Int { self.size }

pub fn MlrldqnBuffer::get(self : MlrldqnBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrldqnBuffer::set(self : MlrldqnBuffer, i : Int, v : Double) -> MlrldqnBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrldqnBuffer::sum(self : MlrldqnBuffer) -> Double { @_common.sum(self.data) }

pub fn MlrldqnBuffer::mean(self : MlrldqnBuffer) -> Double { @_common.mean(self.data) }

pub fn MlrldqnBuffer::scale(self : MlrldqnBuffer, f : Double) -> MlrldqnBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrldqnBuffer::add(self : MlrldqnBuffer, other : MlrldqnBuffer) -> MlrldqnBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrldqnBuffer::copy(self : MlrldqnBuffer) -> MlrldqnBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrldqnBuffer::fill(self : MlrldqnBuffer, v : Double) -> MlrldqnBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrldqnBuffer::min(self : MlrldqnBuffer) -> Double { @_common.min(self.data) }

pub fn MlrldqnBuffer::max(self : MlrldqnBuffer) -> Double { @_common.max(self.data) }

pub fn MlrldqnBuffer::to_string(self : MlrldqnBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrldqnCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_dqn_cursor_make(size : Int) -> MlrldqnCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrldqnCursor::len(self : MlrldqnCursor) -> Int { self.size }

pub fn MlrldqnCursor::get(self : MlrldqnCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrldqnCursor::set(self : MlrldqnCursor, i : Int, v : Double) -> MlrldqnCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrldqnCursor::sum(self : MlrldqnCursor) -> Double { @_common.sum(self.data) }

pub fn MlrldqnCursor::mean(self : MlrldqnCursor) -> Double { @_common.mean(self.data) }

pub fn MlrldqnCursor::scale(self : MlrldqnCursor, f : Double) -> MlrldqnCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrldqnCursor::add(self : MlrldqnCursor, other : MlrldqnCursor) -> MlrldqnCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrldqnCursor::copy(self : MlrldqnCursor) -> MlrldqnCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrldqnCursor::fill(self : MlrldqnCursor, v : Double) -> MlrldqnCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrldqnCursor::min(self : MlrldqnCursor) -> Double { @_common.min(self.data) }

pub fn MlrldqnCursor::max(self : MlrldqnCursor) -> Double { @_common.max(self.data) }

pub fn MlrldqnCursor::to_string(self : MlrldqnCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrldqnView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_dqn_view_make(size : Int) -> MlrldqnView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrldqnView::len(self : MlrldqnView) -> Int { self.size }

pub fn MlrldqnView::get(self : MlrldqnView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrldqnView::set(self : MlrldqnView, i : Int, v : Double) -> MlrldqnView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrldqnView::sum(self : MlrldqnView) -> Double { @_common.sum(self.data) }

pub fn MlrldqnView::mean(self : MlrldqnView) -> Double { @_common.mean(self.data) }

pub fn MlrldqnView::scale(self : MlrldqnView, f : Double) -> MlrldqnView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrldqnView::add(self : MlrldqnView, other : MlrldqnView) -> MlrldqnView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrldqnView::copy(self : MlrldqnView) -> MlrldqnView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrldqnView::fill(self : MlrldqnView, v : Double) -> MlrldqnView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrldqnView::min(self : MlrldqnView) -> Double { @_common.min(self.data) }

pub fn MlrldqnView::max(self : MlrldqnView) -> Double { @_common.max(self.data) }

pub fn MlrldqnView::to_string(self : MlrldqnView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrldqnRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_dqn_range_make(size : Int) -> MlrldqnRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrldqnRange::len(self : MlrldqnRange) -> Int { self.size }

pub fn MlrldqnRange::get(self : MlrldqnRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrldqnRange::set(self : MlrldqnRange, i : Int, v : Double) -> MlrldqnRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrldqnRange::sum(self : MlrldqnRange) -> Double { @_common.sum(self.data) }

pub fn MlrldqnRange::mean(self : MlrldqnRange) -> Double { @_common.mean(self.data) }

pub fn MlrldqnRange::scale(self : MlrldqnRange, f : Double) -> MlrldqnRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrldqnRange::add(self : MlrldqnRange, other : MlrldqnRange) -> MlrldqnRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrldqnRange::copy(self : MlrldqnRange) -> MlrldqnRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrldqnRange::fill(self : MlrldqnRange, v : Double) -> MlrldqnRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrldqnRange::min(self : MlrldqnRange) -> Double { @_common.min(self.data) }

pub fn MlrldqnRange::max(self : MlrldqnRange) -> Double { @_common.max(self.data) }

pub fn MlrldqnRange::to_string(self : MlrldqnRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrldqnSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_dqn_slice_make(size : Int) -> MlrldqnSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrldqnSlice::len(self : MlrldqnSlice) -> Int { self.size }

pub fn MlrldqnSlice::get(self : MlrldqnSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrldqnSlice::set(self : MlrldqnSlice, i : Int, v : Double) -> MlrldqnSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrldqnSlice::sum(self : MlrldqnSlice) -> Double { @_common.sum(self.data) }

pub fn MlrldqnSlice::mean(self : MlrldqnSlice) -> Double { @_common.mean(self.data) }

pub fn MlrldqnSlice::scale(self : MlrldqnSlice, f : Double) -> MlrldqnSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrldqnSlice::add(self : MlrldqnSlice, other : MlrldqnSlice) -> MlrldqnSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrldqnSlice::copy(self : MlrldqnSlice) -> MlrldqnSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrldqnSlice::fill(self : MlrldqnSlice, v : Double) -> MlrldqnSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrldqnSlice::min(self : MlrldqnSlice) -> Double { @_common.min(self.data) }

pub fn MlrldqnSlice::max(self : MlrldqnSlice) -> Double { @_common.max(self.data) }

pub fn MlrldqnSlice::to_string(self : MlrldqnSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

