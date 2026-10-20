///===
/// extcore/ml_rl_actor_critic

pub(all) struct MlrlactorcriticPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_rl_actor_critic_make_point(x : Double, y : Double) -> MlrlactorcriticPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_rl_actor_critic_make_point3(x : Double, y : Double, z : Double) -> MlrlactorcriticPoint {
  { x, y, z, label: 0 }
}

pub fn MlrlactorcriticPoint::x(self : MlrlactorcriticPoint) -> Double { self.x }

pub fn MlrlactorcriticPoint::y(self : MlrlactorcriticPoint) -> Double { self.y }

pub fn MlrlactorcriticPoint::z(self : MlrlactorcriticPoint) -> Double { self.z }

pub fn MlrlactorcriticPoint::label(self : MlrlactorcriticPoint) -> Int { self.label }

pub fn MlrlactorcriticPoint::dist(self : MlrlactorcriticPoint, other : MlrlactorcriticPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlrlactorcriticPoint::add(self : MlrlactorcriticPoint, other : MlrlactorcriticPoint) -> MlrlactorcriticPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlrlactorcriticPoint::sub(self : MlrlactorcriticPoint, other : MlrlactorcriticPoint) -> MlrlactorcriticPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlrlactorcriticPoint::scale(self : MlrlactorcriticPoint, s : Double) -> MlrlactorcriticPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlrlactorcriticPoint::dot(self : MlrlactorcriticPoint, other : MlrlactorcriticPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlrlactorcriticPoint::cross(self : MlrlactorcriticPoint, other : MlrlactorcriticPoint) -> MlrlactorcriticPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlrlactorcriticPoint::norm(self : MlrlactorcriticPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlrlactorcriticPoint::normalize(self : MlrlactorcriticPoint) -> MlrlactorcriticPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlrlactorcriticPoint::negate(self : MlrlactorcriticPoint) -> MlrlactorcriticPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlrlactorcriticPoint::mid(self : MlrlactorcriticPoint, other : MlrlactorcriticPoint) -> MlrlactorcriticPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlrlactorcriticPoint::lerp(self : MlrlactorcriticPoint, other : MlrlactorcriticPoint, t : Double) -> MlrlactorcriticPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlrlactorcriticPoint::to_string(self : MlrlactorcriticPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlrlactorcriticSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_rl_actor_critic_make_series(vals : Array[Double], name : String) -> MlrlactorcriticSeries {
  { vals, name, meta: 0 }
}

pub fn MlrlactorcriticSeries::len(self : MlrlactorcriticSeries) -> Int { self.vals.length() }

pub fn MlrlactorcriticSeries::sum(self : MlrlactorcriticSeries) -> Double { @_common.sum(self.vals) }

pub fn MlrlactorcriticSeries::mean(self : MlrlactorcriticSeries) -> Double { @_common.mean(self.vals) }

pub fn MlrlactorcriticSeries::min(self : MlrlactorcriticSeries) -> Double { @_common.min(self.vals) }

pub fn MlrlactorcriticSeries::max(self : MlrlactorcriticSeries) -> Double { @_common.max(self.vals) }

pub fn MlrlactorcriticSeries::range(self : MlrlactorcriticSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlrlactorcriticSeries::variance(self : MlrlactorcriticSeries) -> Double { @_common.variance(self.vals) }

pub fn MlrlactorcriticSeries::std(self : MlrlactorcriticSeries) -> Double { @_common.std(self.vals) }

pub fn MlrlactorcriticSeries::median(self : MlrlactorcriticSeries) -> Double { @_common.median(self.vals) }

pub fn MlrlactorcriticSeries::scale(self : MlrlactorcriticSeries, f : Double) -> MlrlactorcriticSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlrlactorcriticSeries::add(self : MlrlactorcriticSeries, other : MlrlactorcriticSeries) -> MlrlactorcriticSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlrlactorcriticSeries::sub(self : MlrlactorcriticSeries, other : MlrlactorcriticSeries) -> MlrlactorcriticSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlrlactorcriticSeries::normalize(self : MlrlactorcriticSeries) -> MlrlactorcriticSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlrlactorcriticSeries::cumsum(self : MlrlactorcriticSeries) -> MlrlactorcriticSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlrlactorcriticSeries::to_string(self : MlrlactorcriticSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlrlactorcriticMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_rl_actor_critic_make_matrix(rows : Int, cols : Int, val : Double) -> MlrlactorcriticMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn ml_rl_actor_critic_matrix_identity(n : Int) -> MlrlactorcriticMatrix {
  let m = ml_rl_actor_critic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlrlactorcriticMatrix::get(self : MlrlactorcriticMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlrlactorcriticMatrix::transpose(self : MlrlactorcriticMatrix) -> MlrlactorcriticMatrix {
  let result = ml_rl_actor_critic_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlrlactorcriticMatrix::add(self : MlrlactorcriticMatrix, other : MlrlactorcriticMatrix) -> MlrlactorcriticMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_rl_actor_critic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlrlactorcriticMatrix::scale(self : MlrlactorcriticMatrix, s : Double) -> MlrlactorcriticMatrix {
  let result = ml_rl_actor_critic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlrlactorcriticMatrix::multiply(self : MlrlactorcriticMatrix, other : MlrlactorcriticMatrix) -> MlrlactorcriticMatrix {
  if self.cols != other.rows { return ml_rl_actor_critic_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_rl_actor_critic_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MlrlactorcriticMatrix::trace(self : MlrlactorcriticMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlrlactorcriticMatrix::det(self : MlrlactorcriticMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlrlactorcriticMatrix::norm(self : MlrlactorcriticMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlrlactorcriticMatrix::to_string(self : MlrlactorcriticMatrix) -> String {
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

pub(all) struct MlrlactorcriticVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_rl_actor_critic_make_vector(comps : Array[Double]) -> MlrlactorcriticVector {
  { comps, dim: comps.length() }
}

pub fn ml_rl_actor_critic_vector_zero(dim : Int) -> MlrlactorcriticVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlrlactorcriticVector::add(self : MlrlactorcriticVector, other : MlrlactorcriticVector) -> MlrlactorcriticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlrlactorcriticVector::sub(self : MlrlactorcriticVector, other : MlrlactorcriticVector) -> MlrlactorcriticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlrlactorcriticVector::scale(self : MlrlactorcriticVector, s : Double) -> MlrlactorcriticVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlrlactorcriticVector::dot(self : MlrlactorcriticVector, other : MlrlactorcriticVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlrlactorcriticVector::norm(self : MlrlactorcriticVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlrlactorcriticVector::normalize(self : MlrlactorcriticVector) -> MlrlactorcriticVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlrlactorcriticVector::dist(self : MlrlactorcriticVector, other : MlrlactorcriticVector) -> Double {
  self.sub(other).norm()
}

pub fn MlrlactorcriticVector::to_string(self : MlrlactorcriticVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlrlactorcriticFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_frame_make(size : Int) -> MlrlactorcriticFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlactorcriticFrame::len(self : MlrlactorcriticFrame) -> Int { self.size }

pub fn MlrlactorcriticFrame::get(self : MlrlactorcriticFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlactorcriticFrame::set(self : MlrlactorcriticFrame, i : Int, v : Double) -> MlrlactorcriticFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticFrame::sum(self : MlrlactorcriticFrame) -> Double { @_common.sum(self.data) }

pub fn MlrlactorcriticFrame::mean(self : MlrlactorcriticFrame) -> Double { @_common.mean(self.data) }

pub fn MlrlactorcriticFrame::scale(self : MlrlactorcriticFrame, f : Double) -> MlrlactorcriticFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticFrame::add(self : MlrlactorcriticFrame, other : MlrlactorcriticFrame) -> MlrlactorcriticFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlactorcriticFrame::copy(self : MlrlactorcriticFrame) -> MlrlactorcriticFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticFrame::fill(self : MlrlactorcriticFrame, v : Double) -> MlrlactorcriticFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticFrame::min(self : MlrlactorcriticFrame) -> Double { @_common.min(self.data) }

pub fn MlrlactorcriticFrame::max(self : MlrlactorcriticFrame) -> Double { @_common.max(self.data) }

pub fn MlrlactorcriticFrame::to_string(self : MlrlactorcriticFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_table_make(size : Int) -> MlrlactorcriticTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlactorcriticTable::len(self : MlrlactorcriticTable) -> Int { self.size }

pub fn MlrlactorcriticTable::get(self : MlrlactorcriticTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlactorcriticTable::set(self : MlrlactorcriticTable, i : Int, v : Double) -> MlrlactorcriticTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticTable::sum(self : MlrlactorcriticTable) -> Double { @_common.sum(self.data) }

pub fn MlrlactorcriticTable::mean(self : MlrlactorcriticTable) -> Double { @_common.mean(self.data) }

pub fn MlrlactorcriticTable::scale(self : MlrlactorcriticTable, f : Double) -> MlrlactorcriticTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticTable::add(self : MlrlactorcriticTable, other : MlrlactorcriticTable) -> MlrlactorcriticTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlactorcriticTable::copy(self : MlrlactorcriticTable) -> MlrlactorcriticTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticTable::fill(self : MlrlactorcriticTable, v : Double) -> MlrlactorcriticTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticTable::min(self : MlrlactorcriticTable) -> Double { @_common.min(self.data) }

pub fn MlrlactorcriticTable::max(self : MlrlactorcriticTable) -> Double { @_common.max(self.data) }

pub fn MlrlactorcriticTable::to_string(self : MlrlactorcriticTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_graphn_make(size : Int) -> MlrlactorcriticGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlactorcriticGraphN::len(self : MlrlactorcriticGraphN) -> Int { self.size }

pub fn MlrlactorcriticGraphN::get(self : MlrlactorcriticGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlactorcriticGraphN::set(self : MlrlactorcriticGraphN, i : Int, v : Double) -> MlrlactorcriticGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticGraphN::sum(self : MlrlactorcriticGraphN) -> Double { @_common.sum(self.data) }

pub fn MlrlactorcriticGraphN::mean(self : MlrlactorcriticGraphN) -> Double { @_common.mean(self.data) }

pub fn MlrlactorcriticGraphN::scale(self : MlrlactorcriticGraphN, f : Double) -> MlrlactorcriticGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticGraphN::add(self : MlrlactorcriticGraphN, other : MlrlactorcriticGraphN) -> MlrlactorcriticGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlactorcriticGraphN::copy(self : MlrlactorcriticGraphN) -> MlrlactorcriticGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticGraphN::fill(self : MlrlactorcriticGraphN, v : Double) -> MlrlactorcriticGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticGraphN::min(self : MlrlactorcriticGraphN) -> Double { @_common.min(self.data) }

pub fn MlrlactorcriticGraphN::max(self : MlrlactorcriticGraphN) -> Double { @_common.max(self.data) }

pub fn MlrlactorcriticGraphN::to_string(self : MlrlactorcriticGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_node_make(size : Int) -> MlrlactorcriticNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlactorcriticNode::len(self : MlrlactorcriticNode) -> Int { self.size }

pub fn MlrlactorcriticNode::get(self : MlrlactorcriticNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlactorcriticNode::set(self : MlrlactorcriticNode, i : Int, v : Double) -> MlrlactorcriticNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticNode::sum(self : MlrlactorcriticNode) -> Double { @_common.sum(self.data) }

pub fn MlrlactorcriticNode::mean(self : MlrlactorcriticNode) -> Double { @_common.mean(self.data) }

pub fn MlrlactorcriticNode::scale(self : MlrlactorcriticNode, f : Double) -> MlrlactorcriticNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticNode::add(self : MlrlactorcriticNode, other : MlrlactorcriticNode) -> MlrlactorcriticNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlactorcriticNode::copy(self : MlrlactorcriticNode) -> MlrlactorcriticNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticNode::fill(self : MlrlactorcriticNode, v : Double) -> MlrlactorcriticNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticNode::min(self : MlrlactorcriticNode) -> Double { @_common.min(self.data) }

pub fn MlrlactorcriticNode::max(self : MlrlactorcriticNode) -> Double { @_common.max(self.data) }

pub fn MlrlactorcriticNode::to_string(self : MlrlactorcriticNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_edge_make(size : Int) -> MlrlactorcriticEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlactorcriticEdge::len(self : MlrlactorcriticEdge) -> Int { self.size }

pub fn MlrlactorcriticEdge::get(self : MlrlactorcriticEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlactorcriticEdge::set(self : MlrlactorcriticEdge, i : Int, v : Double) -> MlrlactorcriticEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticEdge::sum(self : MlrlactorcriticEdge) -> Double { @_common.sum(self.data) }

pub fn MlrlactorcriticEdge::mean(self : MlrlactorcriticEdge) -> Double { @_common.mean(self.data) }

pub fn MlrlactorcriticEdge::scale(self : MlrlactorcriticEdge, f : Double) -> MlrlactorcriticEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticEdge::add(self : MlrlactorcriticEdge, other : MlrlactorcriticEdge) -> MlrlactorcriticEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlactorcriticEdge::copy(self : MlrlactorcriticEdge) -> MlrlactorcriticEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticEdge::fill(self : MlrlactorcriticEdge, v : Double) -> MlrlactorcriticEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticEdge::min(self : MlrlactorcriticEdge) -> Double { @_common.min(self.data) }

pub fn MlrlactorcriticEdge::max(self : MlrlactorcriticEdge) -> Double { @_common.max(self.data) }

pub fn MlrlactorcriticEdge::to_string(self : MlrlactorcriticEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_path_make(size : Int) -> MlrlactorcriticPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlactorcriticPath::len(self : MlrlactorcriticPath) -> Int { self.size }

pub fn MlrlactorcriticPath::get(self : MlrlactorcriticPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlactorcriticPath::set(self : MlrlactorcriticPath, i : Int, v : Double) -> MlrlactorcriticPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticPath::sum(self : MlrlactorcriticPath) -> Double { @_common.sum(self.data) }

pub fn MlrlactorcriticPath::mean(self : MlrlactorcriticPath) -> Double { @_common.mean(self.data) }

pub fn MlrlactorcriticPath::scale(self : MlrlactorcriticPath, f : Double) -> MlrlactorcriticPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticPath::add(self : MlrlactorcriticPath, other : MlrlactorcriticPath) -> MlrlactorcriticPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlactorcriticPath::copy(self : MlrlactorcriticPath) -> MlrlactorcriticPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticPath::fill(self : MlrlactorcriticPath, v : Double) -> MlrlactorcriticPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticPath::min(self : MlrlactorcriticPath) -> Double { @_common.min(self.data) }

pub fn MlrlactorcriticPath::max(self : MlrlactorcriticPath) -> Double { @_common.max(self.data) }

pub fn MlrlactorcriticPath::to_string(self : MlrlactorcriticPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_cluster_make(size : Int) -> MlrlactorcriticCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlactorcriticCluster::len(self : MlrlactorcriticCluster) -> Int { self.size }

pub fn MlrlactorcriticCluster::get(self : MlrlactorcriticCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlactorcriticCluster::set(self : MlrlactorcriticCluster, i : Int, v : Double) -> MlrlactorcriticCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticCluster::sum(self : MlrlactorcriticCluster) -> Double { @_common.sum(self.data) }

pub fn MlrlactorcriticCluster::mean(self : MlrlactorcriticCluster) -> Double { @_common.mean(self.data) }

pub fn MlrlactorcriticCluster::scale(self : MlrlactorcriticCluster, f : Double) -> MlrlactorcriticCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticCluster::add(self : MlrlactorcriticCluster, other : MlrlactorcriticCluster) -> MlrlactorcriticCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlactorcriticCluster::copy(self : MlrlactorcriticCluster) -> MlrlactorcriticCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticCluster::fill(self : MlrlactorcriticCluster, v : Double) -> MlrlactorcriticCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticCluster::min(self : MlrlactorcriticCluster) -> Double { @_common.min(self.data) }

pub fn MlrlactorcriticCluster::max(self : MlrlactorcriticCluster) -> Double { @_common.max(self.data) }

pub fn MlrlactorcriticCluster::to_string(self : MlrlactorcriticCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_model_make(size : Int) -> MlrlactorcriticModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlactorcriticModel::len(self : MlrlactorcriticModel) -> Int { self.size }

pub fn MlrlactorcriticModel::get(self : MlrlactorcriticModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlactorcriticModel::set(self : MlrlactorcriticModel, i : Int, v : Double) -> MlrlactorcriticModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticModel::sum(self : MlrlactorcriticModel) -> Double { @_common.sum(self.data) }

pub fn MlrlactorcriticModel::mean(self : MlrlactorcriticModel) -> Double { @_common.mean(self.data) }

pub fn MlrlactorcriticModel::scale(self : MlrlactorcriticModel, f : Double) -> MlrlactorcriticModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticModel::add(self : MlrlactorcriticModel, other : MlrlactorcriticModel) -> MlrlactorcriticModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlactorcriticModel::copy(self : MlrlactorcriticModel) -> MlrlactorcriticModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticModel::fill(self : MlrlactorcriticModel, v : Double) -> MlrlactorcriticModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticModel::min(self : MlrlactorcriticModel) -> Double { @_common.min(self.data) }

pub fn MlrlactorcriticModel::max(self : MlrlactorcriticModel) -> Double { @_common.max(self.data) }

pub fn MlrlactorcriticModel::to_string(self : MlrlactorcriticModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_layer_make(size : Int) -> MlrlactorcriticLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlactorcriticLayer::len(self : MlrlactorcriticLayer) -> Int { self.size }

pub fn MlrlactorcriticLayer::get(self : MlrlactorcriticLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlactorcriticLayer::set(self : MlrlactorcriticLayer, i : Int, v : Double) -> MlrlactorcriticLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticLayer::sum(self : MlrlactorcriticLayer) -> Double { @_common.sum(self.data) }

pub fn MlrlactorcriticLayer::mean(self : MlrlactorcriticLayer) -> Double { @_common.mean(self.data) }

pub fn MlrlactorcriticLayer::scale(self : MlrlactorcriticLayer, f : Double) -> MlrlactorcriticLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticLayer::add(self : MlrlactorcriticLayer, other : MlrlactorcriticLayer) -> MlrlactorcriticLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlactorcriticLayer::copy(self : MlrlactorcriticLayer) -> MlrlactorcriticLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticLayer::fill(self : MlrlactorcriticLayer, v : Double) -> MlrlactorcriticLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticLayer::min(self : MlrlactorcriticLayer) -> Double { @_common.min(self.data) }

pub fn MlrlactorcriticLayer::max(self : MlrlactorcriticLayer) -> Double { @_common.max(self.data) }

pub fn MlrlactorcriticLayer::to_string(self : MlrlactorcriticLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_buffer_make(size : Int) -> MlrlactorcriticBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlactorcriticBuffer::len(self : MlrlactorcriticBuffer) -> Int { self.size }

pub fn MlrlactorcriticBuffer::get(self : MlrlactorcriticBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlactorcriticBuffer::set(self : MlrlactorcriticBuffer, i : Int, v : Double) -> MlrlactorcriticBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticBuffer::sum(self : MlrlactorcriticBuffer) -> Double { @_common.sum(self.data) }

pub fn MlrlactorcriticBuffer::mean(self : MlrlactorcriticBuffer) -> Double { @_common.mean(self.data) }

pub fn MlrlactorcriticBuffer::scale(self : MlrlactorcriticBuffer, f : Double) -> MlrlactorcriticBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticBuffer::add(self : MlrlactorcriticBuffer, other : MlrlactorcriticBuffer) -> MlrlactorcriticBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlactorcriticBuffer::copy(self : MlrlactorcriticBuffer) -> MlrlactorcriticBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticBuffer::fill(self : MlrlactorcriticBuffer, v : Double) -> MlrlactorcriticBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticBuffer::min(self : MlrlactorcriticBuffer) -> Double { @_common.min(self.data) }

pub fn MlrlactorcriticBuffer::max(self : MlrlactorcriticBuffer) -> Double { @_common.max(self.data) }

pub fn MlrlactorcriticBuffer::to_string(self : MlrlactorcriticBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_cursor_make(size : Int) -> MlrlactorcriticCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlactorcriticCursor::len(self : MlrlactorcriticCursor) -> Int { self.size }

pub fn MlrlactorcriticCursor::get(self : MlrlactorcriticCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlactorcriticCursor::set(self : MlrlactorcriticCursor, i : Int, v : Double) -> MlrlactorcriticCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticCursor::sum(self : MlrlactorcriticCursor) -> Double { @_common.sum(self.data) }

pub fn MlrlactorcriticCursor::mean(self : MlrlactorcriticCursor) -> Double { @_common.mean(self.data) }

pub fn MlrlactorcriticCursor::scale(self : MlrlactorcriticCursor, f : Double) -> MlrlactorcriticCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticCursor::add(self : MlrlactorcriticCursor, other : MlrlactorcriticCursor) -> MlrlactorcriticCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlactorcriticCursor::copy(self : MlrlactorcriticCursor) -> MlrlactorcriticCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticCursor::fill(self : MlrlactorcriticCursor, v : Double) -> MlrlactorcriticCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticCursor::min(self : MlrlactorcriticCursor) -> Double { @_common.min(self.data) }

pub fn MlrlactorcriticCursor::max(self : MlrlactorcriticCursor) -> Double { @_common.max(self.data) }

pub fn MlrlactorcriticCursor::to_string(self : MlrlactorcriticCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_view_make(size : Int) -> MlrlactorcriticView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlactorcriticView::len(self : MlrlactorcriticView) -> Int { self.size }

pub fn MlrlactorcriticView::get(self : MlrlactorcriticView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlactorcriticView::set(self : MlrlactorcriticView, i : Int, v : Double) -> MlrlactorcriticView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticView::sum(self : MlrlactorcriticView) -> Double { @_common.sum(self.data) }

pub fn MlrlactorcriticView::mean(self : MlrlactorcriticView) -> Double { @_common.mean(self.data) }

pub fn MlrlactorcriticView::scale(self : MlrlactorcriticView, f : Double) -> MlrlactorcriticView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticView::add(self : MlrlactorcriticView, other : MlrlactorcriticView) -> MlrlactorcriticView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlactorcriticView::copy(self : MlrlactorcriticView) -> MlrlactorcriticView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticView::fill(self : MlrlactorcriticView, v : Double) -> MlrlactorcriticView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticView::min(self : MlrlactorcriticView) -> Double { @_common.min(self.data) }

pub fn MlrlactorcriticView::max(self : MlrlactorcriticView) -> Double { @_common.max(self.data) }

pub fn MlrlactorcriticView::to_string(self : MlrlactorcriticView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_range_make(size : Int) -> MlrlactorcriticRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlactorcriticRange::len(self : MlrlactorcriticRange) -> Int { self.size }

pub fn MlrlactorcriticRange::get(self : MlrlactorcriticRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlactorcriticRange::set(self : MlrlactorcriticRange, i : Int, v : Double) -> MlrlactorcriticRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticRange::sum(self : MlrlactorcriticRange) -> Double { @_common.sum(self.data) }

pub fn MlrlactorcriticRange::mean(self : MlrlactorcriticRange) -> Double { @_common.mean(self.data) }

pub fn MlrlactorcriticRange::scale(self : MlrlactorcriticRange, f : Double) -> MlrlactorcriticRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticRange::add(self : MlrlactorcriticRange, other : MlrlactorcriticRange) -> MlrlactorcriticRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlactorcriticRange::copy(self : MlrlactorcriticRange) -> MlrlactorcriticRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticRange::fill(self : MlrlactorcriticRange, v : Double) -> MlrlactorcriticRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticRange::min(self : MlrlactorcriticRange) -> Double { @_common.min(self.data) }

pub fn MlrlactorcriticRange::max(self : MlrlactorcriticRange) -> Double { @_common.max(self.data) }

pub fn MlrlactorcriticRange::to_string(self : MlrlactorcriticRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_slice_make(size : Int) -> MlrlactorcriticSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrlactorcriticSlice::len(self : MlrlactorcriticSlice) -> Int { self.size }

pub fn MlrlactorcriticSlice::get(self : MlrlactorcriticSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrlactorcriticSlice::set(self : MlrlactorcriticSlice, i : Int, v : Double) -> MlrlactorcriticSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticSlice::sum(self : MlrlactorcriticSlice) -> Double { @_common.sum(self.data) }

pub fn MlrlactorcriticSlice::mean(self : MlrlactorcriticSlice) -> Double { @_common.mean(self.data) }

pub fn MlrlactorcriticSlice::scale(self : MlrlactorcriticSlice, f : Double) -> MlrlactorcriticSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticSlice::add(self : MlrlactorcriticSlice, other : MlrlactorcriticSlice) -> MlrlactorcriticSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrlactorcriticSlice::copy(self : MlrlactorcriticSlice) -> MlrlactorcriticSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticSlice::fill(self : MlrlactorcriticSlice, v : Double) -> MlrlactorcriticSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrlactorcriticSlice::min(self : MlrlactorcriticSlice) -> Double { @_common.min(self.data) }

pub fn MlrlactorcriticSlice::max(self : MlrlactorcriticSlice) -> Double { @_common.max(self.data) }

pub fn MlrlactorcriticSlice::to_string(self : MlrlactorcriticSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

