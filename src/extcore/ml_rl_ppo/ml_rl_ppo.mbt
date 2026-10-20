///===
/// extcore/ml_rl_ppo

pub(all) struct MlrlppoPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_rl_ppo_make_point(x : Double, y : Double) -> MlrlppoPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_rl_ppo_make_point3(x : Double, y : Double, z : Double) -> MlrlppoPoint {
  { x, y, z, label: 0 }
}

pub fn MlrlppoPoint::x(self : MlrlppoPoint) -> Double { self.x }

pub fn MlrlppoPoint::y(self : MlrlppoPoint) -> Double { self.y }

pub fn MlrlppoPoint::z(self : MlrlppoPoint) -> Double { self.z }

pub fn MlrlppoPoint::label(self : MlrlppoPoint) -> Int { self.label }

pub fn MlrlppoPoint::dist(self : MlrlppoPoint, other : MlrlppoPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlrlppoPoint::add(self : MlrlppoPoint, other : MlrlppoPoint) -> MlrlppoPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlrlppoPoint::sub(self : MlrlppoPoint, other : MlrlppoPoint) -> MlrlppoPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlrlppoPoint::scale(self : MlrlppoPoint, s : Double) -> MlrlppoPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlrlppoPoint::dot(self : MlrlppoPoint, other : MlrlppoPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlrlppoPoint::cross(self : MlrlppoPoint, other : MlrlppoPoint) -> MlrlppoPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlrlppoPoint::norm(self : MlrlppoPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlrlppoPoint::normalize(self : MlrlppoPoint) -> MlrlppoPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlrlppoPoint::negate(self : MlrlppoPoint) -> MlrlppoPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlrlppoPoint::mid(self : MlrlppoPoint, other : MlrlppoPoint) -> MlrlppoPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlrlppoPoint::lerp(self : MlrlppoPoint, other : MlrlppoPoint, t : Double) -> MlrlppoPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlrlppoPoint::to_string(self : MlrlppoPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlrlppoSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_rl_ppo_make_series(vals : Array[Double], name : String) -> MlrlppoSeries {
  { vals, name, meta: 0 }
}

pub fn MlrlppoSeries::len(self : MlrlppoSeries) -> Int { self.vals.length() }

pub fn MlrlppoSeries::sum(self : MlrlppoSeries) -> Double { @_common.sum(self.vals) }

pub fn MlrlppoSeries::mean(self : MlrlppoSeries) -> Double { @_common.mean(self.vals) }

pub fn MlrlppoSeries::min(self : MlrlppoSeries) -> Double { @_common.min(self.vals) }

pub fn MlrlppoSeries::max(self : MlrlppoSeries) -> Double { @_common.max(self.vals) }

pub fn MlrlppoSeries::range(self : MlrlppoSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlrlppoSeries::variance(self : MlrlppoSeries) -> Double { @_common.variance(self.vals) }

pub fn MlrlppoSeries::std(self : MlrlppoSeries) -> Double { @_common.std(self.vals) }

pub fn MlrlppoSeries::median(self : MlrlppoSeries) -> Double { @_common.median(self.vals) }

pub fn MlrlppoSeries::scale(self : MlrlppoSeries, f : Double) -> MlrlppoSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlrlppoSeries::add(self : MlrlppoSeries, other : MlrlppoSeries) -> MlrlppoSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlrlppoSeries::sub(self : MlrlppoSeries, other : MlrlppoSeries) -> MlrlppoSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlrlppoSeries::normalize(self : MlrlppoSeries) -> MlrlppoSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlrlppoSeries::cumsum(self : MlrlppoSeries) -> MlrlppoSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlrlppoSeries::to_string(self : MlrlppoSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlrlppoMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_rl_ppo_make_matrix(rows : Int, cols : Int, val : Double) -> MlrlppoMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_rl_ppo_matrix_identity(n : Int) -> MlrlppoMatrix {
  let m = ml_rl_ppo_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlrlppoMatrix::get(self : MlrlppoMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlrlppoMatrix::transpose(self : MlrlppoMatrix) -> MlrlppoMatrix {
  let result = ml_rl_ppo_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlrlppoMatrix::add(self : MlrlppoMatrix, other : MlrlppoMatrix) -> MlrlppoMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_rl_ppo_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlrlppoMatrix::scale(self : MlrlppoMatrix, s : Double) -> MlrlppoMatrix {
  let result = ml_rl_ppo_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlrlppoMatrix::multiply(self : MlrlppoMatrix, other : MlrlppoMatrix) -> MlrlppoMatrix {
  if self.cols != other.rows { return ml_rl_ppo_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_rl_ppo_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MlrlppoMatrix::trace(self : MlrlppoMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlrlppoMatrix::det(self : MlrlppoMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlrlppoMatrix::norm(self : MlrlppoMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlrlppoMatrix::to_string(self : MlrlppoMatrix) -> String {
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

pub(all) struct MlrlppoVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_rl_ppo_make_vector(comps : Array[Double]) -> MlrlppoVector {
  { comps, dim: comps.length() }
}

pub fn ml_rl_ppo_vector_zero(dim : Int) -> MlrlppoVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlrlppoVector::add(self : MlrlppoVector, other : MlrlppoVector) -> MlrlppoVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlrlppoVector::sub(self : MlrlppoVector, other : MlrlppoVector) -> MlrlppoVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlrlppoVector::scale(self : MlrlppoVector, s : Double) -> MlrlppoVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlrlppoVector::dot(self : MlrlppoVector, other : MlrlppoVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlrlppoVector::norm(self : MlrlppoVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlrlppoVector::normalize(self : MlrlppoVector) -> MlrlppoVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlrlppoVector::dist(self : MlrlppoVector, other : MlrlppoVector) -> Double {
  self.sub(other).norm()
}

pub fn MlrlppoVector::to_string(self : MlrlppoVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlrlppoFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ppo_frame_make(size : Int) -> MlrlppoFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlppoFrame::len(self : MlrlppoFrame) -> Int { self.size }

pub fn MlrlppoFrame::get(self : MlrlppoFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlppoFrame::set(self : MlrlppoFrame, i : Int, v : Double) -> MlrlppoFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlppoFrame::sum(self : MlrlppoFrame) -> Double { @_common.sum(self.data) }

pub fn MlrlppoFrame::mean(self : MlrlppoFrame) -> Double { @_common.mean(self.data) }

pub fn MlrlppoFrame::scale(self : MlrlppoFrame, f : Double) -> MlrlppoFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlppoFrame::add(self : MlrlppoFrame, other : MlrlppoFrame) -> MlrlppoFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlppoFrame::copy(self : MlrlppoFrame) -> MlrlppoFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlppoFrame::fill(self : MlrlppoFrame, v : Double) -> MlrlppoFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlppoFrame::min(self : MlrlppoFrame) -> Double { @_common.min(self.data) }

pub fn MlrlppoFrame::max(self : MlrlppoFrame) -> Double { @_common.max(self.data) }

pub fn MlrlppoFrame::to_string(self : MlrlppoFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlppoTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ppo_table_make(size : Int) -> MlrlppoTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlppoTable::len(self : MlrlppoTable) -> Int { self.size }

pub fn MlrlppoTable::get(self : MlrlppoTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlppoTable::set(self : MlrlppoTable, i : Int, v : Double) -> MlrlppoTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlppoTable::sum(self : MlrlppoTable) -> Double { @_common.sum(self.data) }

pub fn MlrlppoTable::mean(self : MlrlppoTable) -> Double { @_common.mean(self.data) }

pub fn MlrlppoTable::scale(self : MlrlppoTable, f : Double) -> MlrlppoTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlppoTable::add(self : MlrlppoTable, other : MlrlppoTable) -> MlrlppoTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlppoTable::copy(self : MlrlppoTable) -> MlrlppoTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlppoTable::fill(self : MlrlppoTable, v : Double) -> MlrlppoTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlppoTable::min(self : MlrlppoTable) -> Double { @_common.min(self.data) }

pub fn MlrlppoTable::max(self : MlrlppoTable) -> Double { @_common.max(self.data) }

pub fn MlrlppoTable::to_string(self : MlrlppoTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlppoGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ppo_graphn_make(size : Int) -> MlrlppoGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlppoGraphN::len(self : MlrlppoGraphN) -> Int { self.size }

pub fn MlrlppoGraphN::get(self : MlrlppoGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlppoGraphN::set(self : MlrlppoGraphN, i : Int, v : Double) -> MlrlppoGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlppoGraphN::sum(self : MlrlppoGraphN) -> Double { @_common.sum(self.data) }

pub fn MlrlppoGraphN::mean(self : MlrlppoGraphN) -> Double { @_common.mean(self.data) }

pub fn MlrlppoGraphN::scale(self : MlrlppoGraphN, f : Double) -> MlrlppoGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlppoGraphN::add(self : MlrlppoGraphN, other : MlrlppoGraphN) -> MlrlppoGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlppoGraphN::copy(self : MlrlppoGraphN) -> MlrlppoGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlppoGraphN::fill(self : MlrlppoGraphN, v : Double) -> MlrlppoGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlppoGraphN::min(self : MlrlppoGraphN) -> Double { @_common.min(self.data) }

pub fn MlrlppoGraphN::max(self : MlrlppoGraphN) -> Double { @_common.max(self.data) }

pub fn MlrlppoGraphN::to_string(self : MlrlppoGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlppoNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ppo_node_make(size : Int) -> MlrlppoNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlppoNode::len(self : MlrlppoNode) -> Int { self.size }

pub fn MlrlppoNode::get(self : MlrlppoNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlppoNode::set(self : MlrlppoNode, i : Int, v : Double) -> MlrlppoNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlppoNode::sum(self : MlrlppoNode) -> Double { @_common.sum(self.data) }

pub fn MlrlppoNode::mean(self : MlrlppoNode) -> Double { @_common.mean(self.data) }

pub fn MlrlppoNode::scale(self : MlrlppoNode, f : Double) -> MlrlppoNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlppoNode::add(self : MlrlppoNode, other : MlrlppoNode) -> MlrlppoNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlppoNode::copy(self : MlrlppoNode) -> MlrlppoNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlppoNode::fill(self : MlrlppoNode, v : Double) -> MlrlppoNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlppoNode::min(self : MlrlppoNode) -> Double { @_common.min(self.data) }

pub fn MlrlppoNode::max(self : MlrlppoNode) -> Double { @_common.max(self.data) }

pub fn MlrlppoNode::to_string(self : MlrlppoNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlppoEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ppo_edge_make(size : Int) -> MlrlppoEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlppoEdge::len(self : MlrlppoEdge) -> Int { self.size }

pub fn MlrlppoEdge::get(self : MlrlppoEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlppoEdge::set(self : MlrlppoEdge, i : Int, v : Double) -> MlrlppoEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlppoEdge::sum(self : MlrlppoEdge) -> Double { @_common.sum(self.data) }

pub fn MlrlppoEdge::mean(self : MlrlppoEdge) -> Double { @_common.mean(self.data) }

pub fn MlrlppoEdge::scale(self : MlrlppoEdge, f : Double) -> MlrlppoEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlppoEdge::add(self : MlrlppoEdge, other : MlrlppoEdge) -> MlrlppoEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlppoEdge::copy(self : MlrlppoEdge) -> MlrlppoEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlppoEdge::fill(self : MlrlppoEdge, v : Double) -> MlrlppoEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlppoEdge::min(self : MlrlppoEdge) -> Double { @_common.min(self.data) }

pub fn MlrlppoEdge::max(self : MlrlppoEdge) -> Double { @_common.max(self.data) }

pub fn MlrlppoEdge::to_string(self : MlrlppoEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlppoPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ppo_path_make(size : Int) -> MlrlppoPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlppoPath::len(self : MlrlppoPath) -> Int { self.size }

pub fn MlrlppoPath::get(self : MlrlppoPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlppoPath::set(self : MlrlppoPath, i : Int, v : Double) -> MlrlppoPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlppoPath::sum(self : MlrlppoPath) -> Double { @_common.sum(self.data) }

pub fn MlrlppoPath::mean(self : MlrlppoPath) -> Double { @_common.mean(self.data) }

pub fn MlrlppoPath::scale(self : MlrlppoPath, f : Double) -> MlrlppoPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlppoPath::add(self : MlrlppoPath, other : MlrlppoPath) -> MlrlppoPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlppoPath::copy(self : MlrlppoPath) -> MlrlppoPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlppoPath::fill(self : MlrlppoPath, v : Double) -> MlrlppoPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlppoPath::min(self : MlrlppoPath) -> Double { @_common.min(self.data) }

pub fn MlrlppoPath::max(self : MlrlppoPath) -> Double { @_common.max(self.data) }

pub fn MlrlppoPath::to_string(self : MlrlppoPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlppoCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ppo_cluster_make(size : Int) -> MlrlppoCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlppoCluster::len(self : MlrlppoCluster) -> Int { self.size }

pub fn MlrlppoCluster::get(self : MlrlppoCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlppoCluster::set(self : MlrlppoCluster, i : Int, v : Double) -> MlrlppoCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlppoCluster::sum(self : MlrlppoCluster) -> Double { @_common.sum(self.data) }

pub fn MlrlppoCluster::mean(self : MlrlppoCluster) -> Double { @_common.mean(self.data) }

pub fn MlrlppoCluster::scale(self : MlrlppoCluster, f : Double) -> MlrlppoCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlppoCluster::add(self : MlrlppoCluster, other : MlrlppoCluster) -> MlrlppoCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlppoCluster::copy(self : MlrlppoCluster) -> MlrlppoCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlppoCluster::fill(self : MlrlppoCluster, v : Double) -> MlrlppoCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlppoCluster::min(self : MlrlppoCluster) -> Double { @_common.min(self.data) }

pub fn MlrlppoCluster::max(self : MlrlppoCluster) -> Double { @_common.max(self.data) }

pub fn MlrlppoCluster::to_string(self : MlrlppoCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlppoModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ppo_model_make(size : Int) -> MlrlppoModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlppoModel::len(self : MlrlppoModel) -> Int { self.size }

pub fn MlrlppoModel::get(self : MlrlppoModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlppoModel::set(self : MlrlppoModel, i : Int, v : Double) -> MlrlppoModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlppoModel::sum(self : MlrlppoModel) -> Double { @_common.sum(self.data) }

pub fn MlrlppoModel::mean(self : MlrlppoModel) -> Double { @_common.mean(self.data) }

pub fn MlrlppoModel::scale(self : MlrlppoModel, f : Double) -> MlrlppoModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlppoModel::add(self : MlrlppoModel, other : MlrlppoModel) -> MlrlppoModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlppoModel::copy(self : MlrlppoModel) -> MlrlppoModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlppoModel::fill(self : MlrlppoModel, v : Double) -> MlrlppoModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlppoModel::min(self : MlrlppoModel) -> Double { @_common.min(self.data) }

pub fn MlrlppoModel::max(self : MlrlppoModel) -> Double { @_common.max(self.data) }

pub fn MlrlppoModel::to_string(self : MlrlppoModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlppoLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ppo_layer_make(size : Int) -> MlrlppoLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlppoLayer::len(self : MlrlppoLayer) -> Int { self.size }

pub fn MlrlppoLayer::get(self : MlrlppoLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlppoLayer::set(self : MlrlppoLayer, i : Int, v : Double) -> MlrlppoLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlppoLayer::sum(self : MlrlppoLayer) -> Double { @_common.sum(self.data) }

pub fn MlrlppoLayer::mean(self : MlrlppoLayer) -> Double { @_common.mean(self.data) }

pub fn MlrlppoLayer::scale(self : MlrlppoLayer, f : Double) -> MlrlppoLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlppoLayer::add(self : MlrlppoLayer, other : MlrlppoLayer) -> MlrlppoLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlppoLayer::copy(self : MlrlppoLayer) -> MlrlppoLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlppoLayer::fill(self : MlrlppoLayer, v : Double) -> MlrlppoLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlppoLayer::min(self : MlrlppoLayer) -> Double { @_common.min(self.data) }

pub fn MlrlppoLayer::max(self : MlrlppoLayer) -> Double { @_common.max(self.data) }

pub fn MlrlppoLayer::to_string(self : MlrlppoLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlppoBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ppo_buffer_make(size : Int) -> MlrlppoBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlppoBuffer::len(self : MlrlppoBuffer) -> Int { self.size }

pub fn MlrlppoBuffer::get(self : MlrlppoBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlppoBuffer::set(self : MlrlppoBuffer, i : Int, v : Double) -> MlrlppoBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlppoBuffer::sum(self : MlrlppoBuffer) -> Double { @_common.sum(self.data) }

pub fn MlrlppoBuffer::mean(self : MlrlppoBuffer) -> Double { @_common.mean(self.data) }

pub fn MlrlppoBuffer::scale(self : MlrlppoBuffer, f : Double) -> MlrlppoBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlppoBuffer::add(self : MlrlppoBuffer, other : MlrlppoBuffer) -> MlrlppoBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlppoBuffer::copy(self : MlrlppoBuffer) -> MlrlppoBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlppoBuffer::fill(self : MlrlppoBuffer, v : Double) -> MlrlppoBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlppoBuffer::min(self : MlrlppoBuffer) -> Double { @_common.min(self.data) }

pub fn MlrlppoBuffer::max(self : MlrlppoBuffer) -> Double { @_common.max(self.data) }

pub fn MlrlppoBuffer::to_string(self : MlrlppoBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlppoCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ppo_cursor_make(size : Int) -> MlrlppoCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlppoCursor::len(self : MlrlppoCursor) -> Int { self.size }

pub fn MlrlppoCursor::get(self : MlrlppoCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlppoCursor::set(self : MlrlppoCursor, i : Int, v : Double) -> MlrlppoCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlppoCursor::sum(self : MlrlppoCursor) -> Double { @_common.sum(self.data) }

pub fn MlrlppoCursor::mean(self : MlrlppoCursor) -> Double { @_common.mean(self.data) }

pub fn MlrlppoCursor::scale(self : MlrlppoCursor, f : Double) -> MlrlppoCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlppoCursor::add(self : MlrlppoCursor, other : MlrlppoCursor) -> MlrlppoCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlppoCursor::copy(self : MlrlppoCursor) -> MlrlppoCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlppoCursor::fill(self : MlrlppoCursor, v : Double) -> MlrlppoCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlppoCursor::min(self : MlrlppoCursor) -> Double { @_common.min(self.data) }

pub fn MlrlppoCursor::max(self : MlrlppoCursor) -> Double { @_common.max(self.data) }

pub fn MlrlppoCursor::to_string(self : MlrlppoCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlppoView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ppo_view_make(size : Int) -> MlrlppoView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlppoView::len(self : MlrlppoView) -> Int { self.size }

pub fn MlrlppoView::get(self : MlrlppoView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlppoView::set(self : MlrlppoView, i : Int, v : Double) -> MlrlppoView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlppoView::sum(self : MlrlppoView) -> Double { @_common.sum(self.data) }

pub fn MlrlppoView::mean(self : MlrlppoView) -> Double { @_common.mean(self.data) }

pub fn MlrlppoView::scale(self : MlrlppoView, f : Double) -> MlrlppoView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlppoView::add(self : MlrlppoView, other : MlrlppoView) -> MlrlppoView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlppoView::copy(self : MlrlppoView) -> MlrlppoView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlppoView::fill(self : MlrlppoView, v : Double) -> MlrlppoView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlppoView::min(self : MlrlppoView) -> Double { @_common.min(self.data) }

pub fn MlrlppoView::max(self : MlrlppoView) -> Double { @_common.max(self.data) }

pub fn MlrlppoView::to_string(self : MlrlppoView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlppoRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ppo_range_make(size : Int) -> MlrlppoRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlppoRange::len(self : MlrlppoRange) -> Int { self.size }

pub fn MlrlppoRange::get(self : MlrlppoRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlppoRange::set(self : MlrlppoRange, i : Int, v : Double) -> MlrlppoRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlppoRange::sum(self : MlrlppoRange) -> Double { @_common.sum(self.data) }

pub fn MlrlppoRange::mean(self : MlrlppoRange) -> Double { @_common.mean(self.data) }

pub fn MlrlppoRange::scale(self : MlrlppoRange, f : Double) -> MlrlppoRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlppoRange::add(self : MlrlppoRange, other : MlrlppoRange) -> MlrlppoRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlppoRange::copy(self : MlrlppoRange) -> MlrlppoRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlppoRange::fill(self : MlrlppoRange, v : Double) -> MlrlppoRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlppoRange::min(self : MlrlppoRange) -> Double { @_common.min(self.data) }

pub fn MlrlppoRange::max(self : MlrlppoRange) -> Double { @_common.max(self.data) }

pub fn MlrlppoRange::to_string(self : MlrlppoRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlppoSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ppo_slice_make(size : Int) -> MlrlppoSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlppoSlice::len(self : MlrlppoSlice) -> Int { self.size }

pub fn MlrlppoSlice::get(self : MlrlppoSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlppoSlice::set(self : MlrlppoSlice, i : Int, v : Double) -> MlrlppoSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlppoSlice::sum(self : MlrlppoSlice) -> Double { @_common.sum(self.data) }

pub fn MlrlppoSlice::mean(self : MlrlppoSlice) -> Double { @_common.mean(self.data) }

pub fn MlrlppoSlice::scale(self : MlrlppoSlice, f : Double) -> MlrlppoSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlppoSlice::add(self : MlrlppoSlice, other : MlrlppoSlice) -> MlrlppoSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlppoSlice::copy(self : MlrlppoSlice) -> MlrlppoSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlppoSlice::fill(self : MlrlppoSlice, v : Double) -> MlrlppoSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlppoSlice::min(self : MlrlppoSlice) -> Double { @_common.min(self.data) }

pub fn MlrlppoSlice::max(self : MlrlppoSlice) -> Double { @_common.max(self.data) }

pub fn MlrlppoSlice::to_string(self : MlrlppoSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

