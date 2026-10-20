///===
/// extcore/ml_rl_ddpg

pub(all) struct MlrlddpgPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_rl_ddpg_make_point(x : Double, y : Double) -> MlrlddpgPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_rl_ddpg_make_point3(x : Double, y : Double, z : Double) -> MlrlddpgPoint {
  { x, y, z, label: 0 }
}

pub fn MlrlddpgPoint::x(self : MlrlddpgPoint) -> Double { self.x }

pub fn MlrlddpgPoint::y(self : MlrlddpgPoint) -> Double { self.y }

pub fn MlrlddpgPoint::z(self : MlrlddpgPoint) -> Double { self.z }

pub fn MlrlddpgPoint::label(self : MlrlddpgPoint) -> Int { self.label }

pub fn MlrlddpgPoint::dist(self : MlrlddpgPoint, other : MlrlddpgPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlrlddpgPoint::add(self : MlrlddpgPoint, other : MlrlddpgPoint) -> MlrlddpgPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlrlddpgPoint::sub(self : MlrlddpgPoint, other : MlrlddpgPoint) -> MlrlddpgPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlrlddpgPoint::scale(self : MlrlddpgPoint, s : Double) -> MlrlddpgPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlrlddpgPoint::dot(self : MlrlddpgPoint, other : MlrlddpgPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlrlddpgPoint::cross(self : MlrlddpgPoint, other : MlrlddpgPoint) -> MlrlddpgPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlrlddpgPoint::norm(self : MlrlddpgPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlrlddpgPoint::normalize(self : MlrlddpgPoint) -> MlrlddpgPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlrlddpgPoint::negate(self : MlrlddpgPoint) -> MlrlddpgPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlrlddpgPoint::mid(self : MlrlddpgPoint, other : MlrlddpgPoint) -> MlrlddpgPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlrlddpgPoint::lerp(self : MlrlddpgPoint, other : MlrlddpgPoint, t : Double) -> MlrlddpgPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlrlddpgPoint::to_string(self : MlrlddpgPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlrlddpgSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_rl_ddpg_make_series(vals : Array[Double], name : String) -> MlrlddpgSeries {
  { vals, name, meta: 0 }
}

pub fn MlrlddpgSeries::len(self : MlrlddpgSeries) -> Int { self.vals.length() }

pub fn MlrlddpgSeries::sum(self : MlrlddpgSeries) -> Double { @_common.sum(self.vals) }

pub fn MlrlddpgSeries::mean(self : MlrlddpgSeries) -> Double { @_common.mean(self.vals) }

pub fn MlrlddpgSeries::min(self : MlrlddpgSeries) -> Double { @_common.min(self.vals) }

pub fn MlrlddpgSeries::max(self : MlrlddpgSeries) -> Double { @_common.max(self.vals) }

pub fn MlrlddpgSeries::range(self : MlrlddpgSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlrlddpgSeries::variance(self : MlrlddpgSeries) -> Double { @_common.variance(self.vals) }

pub fn MlrlddpgSeries::std(self : MlrlddpgSeries) -> Double { @_common.std(self.vals) }

pub fn MlrlddpgSeries::median(self : MlrlddpgSeries) -> Double { @_common.median(self.vals) }

pub fn MlrlddpgSeries::scale(self : MlrlddpgSeries, f : Double) -> MlrlddpgSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlrlddpgSeries::add(self : MlrlddpgSeries, other : MlrlddpgSeries) -> MlrlddpgSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlrlddpgSeries::sub(self : MlrlddpgSeries, other : MlrlddpgSeries) -> MlrlddpgSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlrlddpgSeries::normalize(self : MlrlddpgSeries) -> MlrlddpgSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlrlddpgSeries::cumsum(self : MlrlddpgSeries) -> MlrlddpgSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlrlddpgSeries::to_string(self : MlrlddpgSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlrlddpgMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_rl_ddpg_make_matrix(rows : Int, cols : Int, val : Double) -> MlrlddpgMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn ml_rl_ddpg_matrix_identity(n : Int) -> MlrlddpgMatrix {
  let m = ml_rl_ddpg_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlrlddpgMatrix::get(self : MlrlddpgMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlrlddpgMatrix::transpose(self : MlrlddpgMatrix) -> MlrlddpgMatrix {
  let result = ml_rl_ddpg_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlrlddpgMatrix::add(self : MlrlddpgMatrix, other : MlrlddpgMatrix) -> MlrlddpgMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_rl_ddpg_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlrlddpgMatrix::scale(self : MlrlddpgMatrix, s : Double) -> MlrlddpgMatrix {
  let result = ml_rl_ddpg_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlrlddpgMatrix::multiply(self : MlrlddpgMatrix, other : MlrlddpgMatrix) -> MlrlddpgMatrix {
  if self.cols != other.rows { return ml_rl_ddpg_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_rl_ddpg_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MlrlddpgMatrix::trace(self : MlrlddpgMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlrlddpgMatrix::det(self : MlrlddpgMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlrlddpgMatrix::norm(self : MlrlddpgMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlrlddpgMatrix::to_string(self : MlrlddpgMatrix) -> String {
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

pub(all) struct MlrlddpgVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_rl_ddpg_make_vector(comps : Array[Double]) -> MlrlddpgVector {
  { comps, dim: comps.length() }
}

pub fn ml_rl_ddpg_vector_zero(dim : Int) -> MlrlddpgVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlrlddpgVector::add(self : MlrlddpgVector, other : MlrlddpgVector) -> MlrlddpgVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlrlddpgVector::sub(self : MlrlddpgVector, other : MlrlddpgVector) -> MlrlddpgVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlrlddpgVector::scale(self : MlrlddpgVector, s : Double) -> MlrlddpgVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlrlddpgVector::dot(self : MlrlddpgVector, other : MlrlddpgVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlrlddpgVector::norm(self : MlrlddpgVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlrlddpgVector::normalize(self : MlrlddpgVector) -> MlrlddpgVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlrlddpgVector::dist(self : MlrlddpgVector, other : MlrlddpgVector) -> Double {
  self.sub(other).norm()
}

pub fn MlrlddpgVector::to_string(self : MlrlddpgVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlrlddpgFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ddpg_frame_make(size : Int) -> MlrlddpgFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlddpgFrame::len(self : MlrlddpgFrame) -> Int { self.size }

pub fn MlrlddpgFrame::get(self : MlrlddpgFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlddpgFrame::set(self : MlrlddpgFrame, i : Int, v : Double) -> MlrlddpgFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlddpgFrame::sum(self : MlrlddpgFrame) -> Double { @_common.sum(self.data) }

pub fn MlrlddpgFrame::mean(self : MlrlddpgFrame) -> Double { @_common.mean(self.data) }

pub fn MlrlddpgFrame::scale(self : MlrlddpgFrame, f : Double) -> MlrlddpgFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlddpgFrame::add(self : MlrlddpgFrame, other : MlrlddpgFrame) -> MlrlddpgFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlddpgFrame::copy(self : MlrlddpgFrame) -> MlrlddpgFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlddpgFrame::fill(self : MlrlddpgFrame, v : Double) -> MlrlddpgFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlddpgFrame::min(self : MlrlddpgFrame) -> Double { @_common.min(self.data) }

pub fn MlrlddpgFrame::max(self : MlrlddpgFrame) -> Double { @_common.max(self.data) }

pub fn MlrlddpgFrame::to_string(self : MlrlddpgFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlddpgTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ddpg_table_make(size : Int) -> MlrlddpgTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlddpgTable::len(self : MlrlddpgTable) -> Int { self.size }

pub fn MlrlddpgTable::get(self : MlrlddpgTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlddpgTable::set(self : MlrlddpgTable, i : Int, v : Double) -> MlrlddpgTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlddpgTable::sum(self : MlrlddpgTable) -> Double { @_common.sum(self.data) }

pub fn MlrlddpgTable::mean(self : MlrlddpgTable) -> Double { @_common.mean(self.data) }

pub fn MlrlddpgTable::scale(self : MlrlddpgTable, f : Double) -> MlrlddpgTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlddpgTable::add(self : MlrlddpgTable, other : MlrlddpgTable) -> MlrlddpgTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlddpgTable::copy(self : MlrlddpgTable) -> MlrlddpgTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlddpgTable::fill(self : MlrlddpgTable, v : Double) -> MlrlddpgTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlddpgTable::min(self : MlrlddpgTable) -> Double { @_common.min(self.data) }

pub fn MlrlddpgTable::max(self : MlrlddpgTable) -> Double { @_common.max(self.data) }

pub fn MlrlddpgTable::to_string(self : MlrlddpgTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlddpgGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ddpg_graphn_make(size : Int) -> MlrlddpgGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlddpgGraphN::len(self : MlrlddpgGraphN) -> Int { self.size }

pub fn MlrlddpgGraphN::get(self : MlrlddpgGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlddpgGraphN::set(self : MlrlddpgGraphN, i : Int, v : Double) -> MlrlddpgGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlddpgGraphN::sum(self : MlrlddpgGraphN) -> Double { @_common.sum(self.data) }

pub fn MlrlddpgGraphN::mean(self : MlrlddpgGraphN) -> Double { @_common.mean(self.data) }

pub fn MlrlddpgGraphN::scale(self : MlrlddpgGraphN, f : Double) -> MlrlddpgGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlddpgGraphN::add(self : MlrlddpgGraphN, other : MlrlddpgGraphN) -> MlrlddpgGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlddpgGraphN::copy(self : MlrlddpgGraphN) -> MlrlddpgGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlddpgGraphN::fill(self : MlrlddpgGraphN, v : Double) -> MlrlddpgGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlddpgGraphN::min(self : MlrlddpgGraphN) -> Double { @_common.min(self.data) }

pub fn MlrlddpgGraphN::max(self : MlrlddpgGraphN) -> Double { @_common.max(self.data) }

pub fn MlrlddpgGraphN::to_string(self : MlrlddpgGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlddpgNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ddpg_node_make(size : Int) -> MlrlddpgNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlddpgNode::len(self : MlrlddpgNode) -> Int { self.size }

pub fn MlrlddpgNode::get(self : MlrlddpgNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlddpgNode::set(self : MlrlddpgNode, i : Int, v : Double) -> MlrlddpgNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlddpgNode::sum(self : MlrlddpgNode) -> Double { @_common.sum(self.data) }

pub fn MlrlddpgNode::mean(self : MlrlddpgNode) -> Double { @_common.mean(self.data) }

pub fn MlrlddpgNode::scale(self : MlrlddpgNode, f : Double) -> MlrlddpgNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlddpgNode::add(self : MlrlddpgNode, other : MlrlddpgNode) -> MlrlddpgNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlddpgNode::copy(self : MlrlddpgNode) -> MlrlddpgNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlddpgNode::fill(self : MlrlddpgNode, v : Double) -> MlrlddpgNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlddpgNode::min(self : MlrlddpgNode) -> Double { @_common.min(self.data) }

pub fn MlrlddpgNode::max(self : MlrlddpgNode) -> Double { @_common.max(self.data) }

pub fn MlrlddpgNode::to_string(self : MlrlddpgNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlddpgEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ddpg_edge_make(size : Int) -> MlrlddpgEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlddpgEdge::len(self : MlrlddpgEdge) -> Int { self.size }

pub fn MlrlddpgEdge::get(self : MlrlddpgEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlddpgEdge::set(self : MlrlddpgEdge, i : Int, v : Double) -> MlrlddpgEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlddpgEdge::sum(self : MlrlddpgEdge) -> Double { @_common.sum(self.data) }

pub fn MlrlddpgEdge::mean(self : MlrlddpgEdge) -> Double { @_common.mean(self.data) }

pub fn MlrlddpgEdge::scale(self : MlrlddpgEdge, f : Double) -> MlrlddpgEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlddpgEdge::add(self : MlrlddpgEdge, other : MlrlddpgEdge) -> MlrlddpgEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlddpgEdge::copy(self : MlrlddpgEdge) -> MlrlddpgEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlddpgEdge::fill(self : MlrlddpgEdge, v : Double) -> MlrlddpgEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlddpgEdge::min(self : MlrlddpgEdge) -> Double { @_common.min(self.data) }

pub fn MlrlddpgEdge::max(self : MlrlddpgEdge) -> Double { @_common.max(self.data) }

pub fn MlrlddpgEdge::to_string(self : MlrlddpgEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlddpgPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ddpg_path_make(size : Int) -> MlrlddpgPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlddpgPath::len(self : MlrlddpgPath) -> Int { self.size }

pub fn MlrlddpgPath::get(self : MlrlddpgPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlddpgPath::set(self : MlrlddpgPath, i : Int, v : Double) -> MlrlddpgPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlddpgPath::sum(self : MlrlddpgPath) -> Double { @_common.sum(self.data) }

pub fn MlrlddpgPath::mean(self : MlrlddpgPath) -> Double { @_common.mean(self.data) }

pub fn MlrlddpgPath::scale(self : MlrlddpgPath, f : Double) -> MlrlddpgPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlddpgPath::add(self : MlrlddpgPath, other : MlrlddpgPath) -> MlrlddpgPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlddpgPath::copy(self : MlrlddpgPath) -> MlrlddpgPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlddpgPath::fill(self : MlrlddpgPath, v : Double) -> MlrlddpgPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlddpgPath::min(self : MlrlddpgPath) -> Double { @_common.min(self.data) }

pub fn MlrlddpgPath::max(self : MlrlddpgPath) -> Double { @_common.max(self.data) }

pub fn MlrlddpgPath::to_string(self : MlrlddpgPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlddpgCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ddpg_cluster_make(size : Int) -> MlrlddpgCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlddpgCluster::len(self : MlrlddpgCluster) -> Int { self.size }

pub fn MlrlddpgCluster::get(self : MlrlddpgCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlddpgCluster::set(self : MlrlddpgCluster, i : Int, v : Double) -> MlrlddpgCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlddpgCluster::sum(self : MlrlddpgCluster) -> Double { @_common.sum(self.data) }

pub fn MlrlddpgCluster::mean(self : MlrlddpgCluster) -> Double { @_common.mean(self.data) }

pub fn MlrlddpgCluster::scale(self : MlrlddpgCluster, f : Double) -> MlrlddpgCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlddpgCluster::add(self : MlrlddpgCluster, other : MlrlddpgCluster) -> MlrlddpgCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlddpgCluster::copy(self : MlrlddpgCluster) -> MlrlddpgCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlddpgCluster::fill(self : MlrlddpgCluster, v : Double) -> MlrlddpgCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlddpgCluster::min(self : MlrlddpgCluster) -> Double { @_common.min(self.data) }

pub fn MlrlddpgCluster::max(self : MlrlddpgCluster) -> Double { @_common.max(self.data) }

pub fn MlrlddpgCluster::to_string(self : MlrlddpgCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlddpgModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ddpg_model_make(size : Int) -> MlrlddpgModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlddpgModel::len(self : MlrlddpgModel) -> Int { self.size }

pub fn MlrlddpgModel::get(self : MlrlddpgModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlddpgModel::set(self : MlrlddpgModel, i : Int, v : Double) -> MlrlddpgModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlddpgModel::sum(self : MlrlddpgModel) -> Double { @_common.sum(self.data) }

pub fn MlrlddpgModel::mean(self : MlrlddpgModel) -> Double { @_common.mean(self.data) }

pub fn MlrlddpgModel::scale(self : MlrlddpgModel, f : Double) -> MlrlddpgModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlddpgModel::add(self : MlrlddpgModel, other : MlrlddpgModel) -> MlrlddpgModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlddpgModel::copy(self : MlrlddpgModel) -> MlrlddpgModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlddpgModel::fill(self : MlrlddpgModel, v : Double) -> MlrlddpgModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlddpgModel::min(self : MlrlddpgModel) -> Double { @_common.min(self.data) }

pub fn MlrlddpgModel::max(self : MlrlddpgModel) -> Double { @_common.max(self.data) }

pub fn MlrlddpgModel::to_string(self : MlrlddpgModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlddpgLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ddpg_layer_make(size : Int) -> MlrlddpgLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlddpgLayer::len(self : MlrlddpgLayer) -> Int { self.size }

pub fn MlrlddpgLayer::get(self : MlrlddpgLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlddpgLayer::set(self : MlrlddpgLayer, i : Int, v : Double) -> MlrlddpgLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlddpgLayer::sum(self : MlrlddpgLayer) -> Double { @_common.sum(self.data) }

pub fn MlrlddpgLayer::mean(self : MlrlddpgLayer) -> Double { @_common.mean(self.data) }

pub fn MlrlddpgLayer::scale(self : MlrlddpgLayer, f : Double) -> MlrlddpgLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlddpgLayer::add(self : MlrlddpgLayer, other : MlrlddpgLayer) -> MlrlddpgLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlddpgLayer::copy(self : MlrlddpgLayer) -> MlrlddpgLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlddpgLayer::fill(self : MlrlddpgLayer, v : Double) -> MlrlddpgLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlddpgLayer::min(self : MlrlddpgLayer) -> Double { @_common.min(self.data) }

pub fn MlrlddpgLayer::max(self : MlrlddpgLayer) -> Double { @_common.max(self.data) }

pub fn MlrlddpgLayer::to_string(self : MlrlddpgLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlddpgBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ddpg_buffer_make(size : Int) -> MlrlddpgBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlddpgBuffer::len(self : MlrlddpgBuffer) -> Int { self.size }

pub fn MlrlddpgBuffer::get(self : MlrlddpgBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlddpgBuffer::set(self : MlrlddpgBuffer, i : Int, v : Double) -> MlrlddpgBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlddpgBuffer::sum(self : MlrlddpgBuffer) -> Double { @_common.sum(self.data) }

pub fn MlrlddpgBuffer::mean(self : MlrlddpgBuffer) -> Double { @_common.mean(self.data) }

pub fn MlrlddpgBuffer::scale(self : MlrlddpgBuffer, f : Double) -> MlrlddpgBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlddpgBuffer::add(self : MlrlddpgBuffer, other : MlrlddpgBuffer) -> MlrlddpgBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlddpgBuffer::copy(self : MlrlddpgBuffer) -> MlrlddpgBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlddpgBuffer::fill(self : MlrlddpgBuffer, v : Double) -> MlrlddpgBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlddpgBuffer::min(self : MlrlddpgBuffer) -> Double { @_common.min(self.data) }

pub fn MlrlddpgBuffer::max(self : MlrlddpgBuffer) -> Double { @_common.max(self.data) }

pub fn MlrlddpgBuffer::to_string(self : MlrlddpgBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlddpgCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ddpg_cursor_make(size : Int) -> MlrlddpgCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlddpgCursor::len(self : MlrlddpgCursor) -> Int { self.size }

pub fn MlrlddpgCursor::get(self : MlrlddpgCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlddpgCursor::set(self : MlrlddpgCursor, i : Int, v : Double) -> MlrlddpgCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlddpgCursor::sum(self : MlrlddpgCursor) -> Double { @_common.sum(self.data) }

pub fn MlrlddpgCursor::mean(self : MlrlddpgCursor) -> Double { @_common.mean(self.data) }

pub fn MlrlddpgCursor::scale(self : MlrlddpgCursor, f : Double) -> MlrlddpgCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlddpgCursor::add(self : MlrlddpgCursor, other : MlrlddpgCursor) -> MlrlddpgCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlddpgCursor::copy(self : MlrlddpgCursor) -> MlrlddpgCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlddpgCursor::fill(self : MlrlddpgCursor, v : Double) -> MlrlddpgCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlddpgCursor::min(self : MlrlddpgCursor) -> Double { @_common.min(self.data) }

pub fn MlrlddpgCursor::max(self : MlrlddpgCursor) -> Double { @_common.max(self.data) }

pub fn MlrlddpgCursor::to_string(self : MlrlddpgCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlddpgView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ddpg_view_make(size : Int) -> MlrlddpgView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlddpgView::len(self : MlrlddpgView) -> Int { self.size }

pub fn MlrlddpgView::get(self : MlrlddpgView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlddpgView::set(self : MlrlddpgView, i : Int, v : Double) -> MlrlddpgView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlddpgView::sum(self : MlrlddpgView) -> Double { @_common.sum(self.data) }

pub fn MlrlddpgView::mean(self : MlrlddpgView) -> Double { @_common.mean(self.data) }

pub fn MlrlddpgView::scale(self : MlrlddpgView, f : Double) -> MlrlddpgView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlddpgView::add(self : MlrlddpgView, other : MlrlddpgView) -> MlrlddpgView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlddpgView::copy(self : MlrlddpgView) -> MlrlddpgView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlddpgView::fill(self : MlrlddpgView, v : Double) -> MlrlddpgView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlddpgView::min(self : MlrlddpgView) -> Double { @_common.min(self.data) }

pub fn MlrlddpgView::max(self : MlrlddpgView) -> Double { @_common.max(self.data) }

pub fn MlrlddpgView::to_string(self : MlrlddpgView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlddpgRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ddpg_range_make(size : Int) -> MlrlddpgRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlddpgRange::len(self : MlrlddpgRange) -> Int { self.size }

pub fn MlrlddpgRange::get(self : MlrlddpgRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlddpgRange::set(self : MlrlddpgRange, i : Int, v : Double) -> MlrlddpgRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlddpgRange::sum(self : MlrlddpgRange) -> Double { @_common.sum(self.data) }

pub fn MlrlddpgRange::mean(self : MlrlddpgRange) -> Double { @_common.mean(self.data) }

pub fn MlrlddpgRange::scale(self : MlrlddpgRange, f : Double) -> MlrlddpgRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlddpgRange::add(self : MlrlddpgRange, other : MlrlddpgRange) -> MlrlddpgRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlddpgRange::copy(self : MlrlddpgRange) -> MlrlddpgRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlddpgRange::fill(self : MlrlddpgRange, v : Double) -> MlrlddpgRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlddpgRange::min(self : MlrlddpgRange) -> Double { @_common.min(self.data) }

pub fn MlrlddpgRange::max(self : MlrlddpgRange) -> Double { @_common.max(self.data) }

pub fn MlrlddpgRange::to_string(self : MlrlddpgRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlddpgSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ddpg_slice_make(size : Int) -> MlrlddpgSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlddpgSlice::len(self : MlrlddpgSlice) -> Int { self.size }

pub fn MlrlddpgSlice::get(self : MlrlddpgSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlddpgSlice::set(self : MlrlddpgSlice, i : Int, v : Double) -> MlrlddpgSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlddpgSlice::sum(self : MlrlddpgSlice) -> Double { @_common.sum(self.data) }

pub fn MlrlddpgSlice::mean(self : MlrlddpgSlice) -> Double { @_common.mean(self.data) }

pub fn MlrlddpgSlice::scale(self : MlrlddpgSlice, f : Double) -> MlrlddpgSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlddpgSlice::add(self : MlrlddpgSlice, other : MlrlddpgSlice) -> MlrlddpgSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlddpgSlice::copy(self : MlrlddpgSlice) -> MlrlddpgSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlddpgSlice::fill(self : MlrlddpgSlice, v : Double) -> MlrlddpgSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlddpgSlice::min(self : MlrlddpgSlice) -> Double { @_common.min(self.data) }

pub fn MlrlddpgSlice::max(self : MlrlddpgSlice) -> Double { @_common.max(self.data) }

pub fn MlrlddpgSlice::to_string(self : MlrlddpgSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

