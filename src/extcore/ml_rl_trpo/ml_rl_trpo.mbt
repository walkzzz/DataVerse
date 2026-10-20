///===
/// extcore/ml_rl_trpo

pub(all) struct MlrltrpoPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_rl_trpo_make_point(x : Double, y : Double) -> MlrltrpoPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_rl_trpo_make_point3(x : Double, y : Double, z : Double) -> MlrltrpoPoint {
  { x, y, z, label: 0 }
}

pub fn MlrltrpoPoint::x(self : MlrltrpoPoint) -> Double { self.x }

pub fn MlrltrpoPoint::y(self : MlrltrpoPoint) -> Double { self.y }

pub fn MlrltrpoPoint::z(self : MlrltrpoPoint) -> Double { self.z }

pub fn MlrltrpoPoint::label(self : MlrltrpoPoint) -> Int { self.label }

pub fn MlrltrpoPoint::dist(self : MlrltrpoPoint, other : MlrltrpoPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlrltrpoPoint::add(self : MlrltrpoPoint, other : MlrltrpoPoint) -> MlrltrpoPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlrltrpoPoint::sub(self : MlrltrpoPoint, other : MlrltrpoPoint) -> MlrltrpoPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlrltrpoPoint::scale(self : MlrltrpoPoint, s : Double) -> MlrltrpoPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlrltrpoPoint::dot(self : MlrltrpoPoint, other : MlrltrpoPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlrltrpoPoint::cross(self : MlrltrpoPoint, other : MlrltrpoPoint) -> MlrltrpoPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlrltrpoPoint::norm(self : MlrltrpoPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlrltrpoPoint::normalize(self : MlrltrpoPoint) -> MlrltrpoPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlrltrpoPoint::negate(self : MlrltrpoPoint) -> MlrltrpoPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlrltrpoPoint::mid(self : MlrltrpoPoint, other : MlrltrpoPoint) -> MlrltrpoPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlrltrpoPoint::lerp(self : MlrltrpoPoint, other : MlrltrpoPoint, t : Double) -> MlrltrpoPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlrltrpoPoint::to_string(self : MlrltrpoPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlrltrpoSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_rl_trpo_make_series(vals : Array[Double], name : String) -> MlrltrpoSeries {
  { vals, name, meta: 0 }
}

pub fn MlrltrpoSeries::len(self : MlrltrpoSeries) -> Int { self.vals.length() }

pub fn MlrltrpoSeries::sum(self : MlrltrpoSeries) -> Double { @_common.sum(self.vals) }

pub fn MlrltrpoSeries::mean(self : MlrltrpoSeries) -> Double { @_common.mean(self.vals) }

pub fn MlrltrpoSeries::min(self : MlrltrpoSeries) -> Double { @_common.min(self.vals) }

pub fn MlrltrpoSeries::max(self : MlrltrpoSeries) -> Double { @_common.max(self.vals) }

pub fn MlrltrpoSeries::range(self : MlrltrpoSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlrltrpoSeries::variance(self : MlrltrpoSeries) -> Double { @_common.variance(self.vals) }

pub fn MlrltrpoSeries::std(self : MlrltrpoSeries) -> Double { @_common.std(self.vals) }

pub fn MlrltrpoSeries::median(self : MlrltrpoSeries) -> Double { @_common.median(self.vals) }

pub fn MlrltrpoSeries::scale(self : MlrltrpoSeries, f : Double) -> MlrltrpoSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlrltrpoSeries::add(self : MlrltrpoSeries, other : MlrltrpoSeries) -> MlrltrpoSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlrltrpoSeries::sub(self : MlrltrpoSeries, other : MlrltrpoSeries) -> MlrltrpoSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlrltrpoSeries::normalize(self : MlrltrpoSeries) -> MlrltrpoSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlrltrpoSeries::cumsum(self : MlrltrpoSeries) -> MlrltrpoSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlrltrpoSeries::to_string(self : MlrltrpoSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlrltrpoMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_rl_trpo_make_matrix(rows : Int, cols : Int, val : Double) -> MlrltrpoMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_rl_trpo_matrix_identity(n : Int) -> MlrltrpoMatrix {
  let m = ml_rl_trpo_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlrltrpoMatrix::get(self : MlrltrpoMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlrltrpoMatrix::transpose(self : MlrltrpoMatrix) -> MlrltrpoMatrix {
  let result = ml_rl_trpo_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlrltrpoMatrix::add(self : MlrltrpoMatrix, other : MlrltrpoMatrix) -> MlrltrpoMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_rl_trpo_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlrltrpoMatrix::scale(self : MlrltrpoMatrix, s : Double) -> MlrltrpoMatrix {
  let result = ml_rl_trpo_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlrltrpoMatrix::multiply(self : MlrltrpoMatrix, other : MlrltrpoMatrix) -> MlrltrpoMatrix {
  if self.cols != other.rows { return ml_rl_trpo_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_rl_trpo_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlrltrpoMatrix::trace(self : MlrltrpoMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlrltrpoMatrix::det(self : MlrltrpoMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlrltrpoMatrix::norm(self : MlrltrpoMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlrltrpoMatrix::to_string(self : MlrltrpoMatrix) -> String {
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

pub(all) struct MlrltrpoVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_rl_trpo_make_vector(comps : Array[Double]) -> MlrltrpoVector {
  { comps, dim: comps.length() }
}

pub fn ml_rl_trpo_vector_zero(dim : Int) -> MlrltrpoVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlrltrpoVector::add(self : MlrltrpoVector, other : MlrltrpoVector) -> MlrltrpoVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlrltrpoVector::sub(self : MlrltrpoVector, other : MlrltrpoVector) -> MlrltrpoVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlrltrpoVector::scale(self : MlrltrpoVector, s : Double) -> MlrltrpoVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlrltrpoVector::dot(self : MlrltrpoVector, other : MlrltrpoVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlrltrpoVector::norm(self : MlrltrpoVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlrltrpoVector::normalize(self : MlrltrpoVector) -> MlrltrpoVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlrltrpoVector::dist(self : MlrltrpoVector, other : MlrltrpoVector) -> Double {
  self.sub(other).norm()
}

pub fn MlrltrpoVector::to_string(self : MlrltrpoVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlrltrpoFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_trpo_frame_make(size : Int) -> MlrltrpoFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrltrpoFrame::len(self : MlrltrpoFrame) -> Int { self.size }

pub fn MlrltrpoFrame::get(self : MlrltrpoFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrltrpoFrame::set(self : MlrltrpoFrame, i : Int, v : Double) -> MlrltrpoFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrltrpoFrame::sum(self : MlrltrpoFrame) -> Double { @_common.sum(self.data) }

pub fn MlrltrpoFrame::mean(self : MlrltrpoFrame) -> Double { @_common.mean(self.data) }

pub fn MlrltrpoFrame::scale(self : MlrltrpoFrame, f : Double) -> MlrltrpoFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrltrpoFrame::add(self : MlrltrpoFrame, other : MlrltrpoFrame) -> MlrltrpoFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrltrpoFrame::copy(self : MlrltrpoFrame) -> MlrltrpoFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrltrpoFrame::fill(self : MlrltrpoFrame, v : Double) -> MlrltrpoFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrltrpoFrame::min(self : MlrltrpoFrame) -> Double { @_common.min(self.data) }

pub fn MlrltrpoFrame::max(self : MlrltrpoFrame) -> Double { @_common.max(self.data) }

pub fn MlrltrpoFrame::to_string(self : MlrltrpoFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrltrpoTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_trpo_table_make(size : Int) -> MlrltrpoTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrltrpoTable::len(self : MlrltrpoTable) -> Int { self.size }

pub fn MlrltrpoTable::get(self : MlrltrpoTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrltrpoTable::set(self : MlrltrpoTable, i : Int, v : Double) -> MlrltrpoTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrltrpoTable::sum(self : MlrltrpoTable) -> Double { @_common.sum(self.data) }

pub fn MlrltrpoTable::mean(self : MlrltrpoTable) -> Double { @_common.mean(self.data) }

pub fn MlrltrpoTable::scale(self : MlrltrpoTable, f : Double) -> MlrltrpoTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrltrpoTable::add(self : MlrltrpoTable, other : MlrltrpoTable) -> MlrltrpoTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrltrpoTable::copy(self : MlrltrpoTable) -> MlrltrpoTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrltrpoTable::fill(self : MlrltrpoTable, v : Double) -> MlrltrpoTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrltrpoTable::min(self : MlrltrpoTable) -> Double { @_common.min(self.data) }

pub fn MlrltrpoTable::max(self : MlrltrpoTable) -> Double { @_common.max(self.data) }

pub fn MlrltrpoTable::to_string(self : MlrltrpoTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrltrpoGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_trpo_graphn_make(size : Int) -> MlrltrpoGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrltrpoGraphN::len(self : MlrltrpoGraphN) -> Int { self.size }

pub fn MlrltrpoGraphN::get(self : MlrltrpoGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrltrpoGraphN::set(self : MlrltrpoGraphN, i : Int, v : Double) -> MlrltrpoGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrltrpoGraphN::sum(self : MlrltrpoGraphN) -> Double { @_common.sum(self.data) }

pub fn MlrltrpoGraphN::mean(self : MlrltrpoGraphN) -> Double { @_common.mean(self.data) }

pub fn MlrltrpoGraphN::scale(self : MlrltrpoGraphN, f : Double) -> MlrltrpoGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrltrpoGraphN::add(self : MlrltrpoGraphN, other : MlrltrpoGraphN) -> MlrltrpoGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrltrpoGraphN::copy(self : MlrltrpoGraphN) -> MlrltrpoGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrltrpoGraphN::fill(self : MlrltrpoGraphN, v : Double) -> MlrltrpoGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrltrpoGraphN::min(self : MlrltrpoGraphN) -> Double { @_common.min(self.data) }

pub fn MlrltrpoGraphN::max(self : MlrltrpoGraphN) -> Double { @_common.max(self.data) }

pub fn MlrltrpoGraphN::to_string(self : MlrltrpoGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrltrpoNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_trpo_node_make(size : Int) -> MlrltrpoNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrltrpoNode::len(self : MlrltrpoNode) -> Int { self.size }

pub fn MlrltrpoNode::get(self : MlrltrpoNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrltrpoNode::set(self : MlrltrpoNode, i : Int, v : Double) -> MlrltrpoNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrltrpoNode::sum(self : MlrltrpoNode) -> Double { @_common.sum(self.data) }

pub fn MlrltrpoNode::mean(self : MlrltrpoNode) -> Double { @_common.mean(self.data) }

pub fn MlrltrpoNode::scale(self : MlrltrpoNode, f : Double) -> MlrltrpoNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrltrpoNode::add(self : MlrltrpoNode, other : MlrltrpoNode) -> MlrltrpoNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrltrpoNode::copy(self : MlrltrpoNode) -> MlrltrpoNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrltrpoNode::fill(self : MlrltrpoNode, v : Double) -> MlrltrpoNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrltrpoNode::min(self : MlrltrpoNode) -> Double { @_common.min(self.data) }

pub fn MlrltrpoNode::max(self : MlrltrpoNode) -> Double { @_common.max(self.data) }

pub fn MlrltrpoNode::to_string(self : MlrltrpoNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrltrpoEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_trpo_edge_make(size : Int) -> MlrltrpoEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrltrpoEdge::len(self : MlrltrpoEdge) -> Int { self.size }

pub fn MlrltrpoEdge::get(self : MlrltrpoEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrltrpoEdge::set(self : MlrltrpoEdge, i : Int, v : Double) -> MlrltrpoEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrltrpoEdge::sum(self : MlrltrpoEdge) -> Double { @_common.sum(self.data) }

pub fn MlrltrpoEdge::mean(self : MlrltrpoEdge) -> Double { @_common.mean(self.data) }

pub fn MlrltrpoEdge::scale(self : MlrltrpoEdge, f : Double) -> MlrltrpoEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrltrpoEdge::add(self : MlrltrpoEdge, other : MlrltrpoEdge) -> MlrltrpoEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrltrpoEdge::copy(self : MlrltrpoEdge) -> MlrltrpoEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrltrpoEdge::fill(self : MlrltrpoEdge, v : Double) -> MlrltrpoEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrltrpoEdge::min(self : MlrltrpoEdge) -> Double { @_common.min(self.data) }

pub fn MlrltrpoEdge::max(self : MlrltrpoEdge) -> Double { @_common.max(self.data) }

pub fn MlrltrpoEdge::to_string(self : MlrltrpoEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrltrpoPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_trpo_path_make(size : Int) -> MlrltrpoPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrltrpoPath::len(self : MlrltrpoPath) -> Int { self.size }

pub fn MlrltrpoPath::get(self : MlrltrpoPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrltrpoPath::set(self : MlrltrpoPath, i : Int, v : Double) -> MlrltrpoPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrltrpoPath::sum(self : MlrltrpoPath) -> Double { @_common.sum(self.data) }

pub fn MlrltrpoPath::mean(self : MlrltrpoPath) -> Double { @_common.mean(self.data) }

pub fn MlrltrpoPath::scale(self : MlrltrpoPath, f : Double) -> MlrltrpoPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrltrpoPath::add(self : MlrltrpoPath, other : MlrltrpoPath) -> MlrltrpoPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrltrpoPath::copy(self : MlrltrpoPath) -> MlrltrpoPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrltrpoPath::fill(self : MlrltrpoPath, v : Double) -> MlrltrpoPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrltrpoPath::min(self : MlrltrpoPath) -> Double { @_common.min(self.data) }

pub fn MlrltrpoPath::max(self : MlrltrpoPath) -> Double { @_common.max(self.data) }

pub fn MlrltrpoPath::to_string(self : MlrltrpoPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrltrpoCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_trpo_cluster_make(size : Int) -> MlrltrpoCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrltrpoCluster::len(self : MlrltrpoCluster) -> Int { self.size }

pub fn MlrltrpoCluster::get(self : MlrltrpoCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrltrpoCluster::set(self : MlrltrpoCluster, i : Int, v : Double) -> MlrltrpoCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrltrpoCluster::sum(self : MlrltrpoCluster) -> Double { @_common.sum(self.data) }

pub fn MlrltrpoCluster::mean(self : MlrltrpoCluster) -> Double { @_common.mean(self.data) }

pub fn MlrltrpoCluster::scale(self : MlrltrpoCluster, f : Double) -> MlrltrpoCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrltrpoCluster::add(self : MlrltrpoCluster, other : MlrltrpoCluster) -> MlrltrpoCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrltrpoCluster::copy(self : MlrltrpoCluster) -> MlrltrpoCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrltrpoCluster::fill(self : MlrltrpoCluster, v : Double) -> MlrltrpoCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrltrpoCluster::min(self : MlrltrpoCluster) -> Double { @_common.min(self.data) }

pub fn MlrltrpoCluster::max(self : MlrltrpoCluster) -> Double { @_common.max(self.data) }

pub fn MlrltrpoCluster::to_string(self : MlrltrpoCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrltrpoModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_trpo_model_make(size : Int) -> MlrltrpoModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrltrpoModel::len(self : MlrltrpoModel) -> Int { self.size }

pub fn MlrltrpoModel::get(self : MlrltrpoModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrltrpoModel::set(self : MlrltrpoModel, i : Int, v : Double) -> MlrltrpoModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrltrpoModel::sum(self : MlrltrpoModel) -> Double { @_common.sum(self.data) }

pub fn MlrltrpoModel::mean(self : MlrltrpoModel) -> Double { @_common.mean(self.data) }

pub fn MlrltrpoModel::scale(self : MlrltrpoModel, f : Double) -> MlrltrpoModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrltrpoModel::add(self : MlrltrpoModel, other : MlrltrpoModel) -> MlrltrpoModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrltrpoModel::copy(self : MlrltrpoModel) -> MlrltrpoModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrltrpoModel::fill(self : MlrltrpoModel, v : Double) -> MlrltrpoModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrltrpoModel::min(self : MlrltrpoModel) -> Double { @_common.min(self.data) }

pub fn MlrltrpoModel::max(self : MlrltrpoModel) -> Double { @_common.max(self.data) }

pub fn MlrltrpoModel::to_string(self : MlrltrpoModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrltrpoLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_trpo_layer_make(size : Int) -> MlrltrpoLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrltrpoLayer::len(self : MlrltrpoLayer) -> Int { self.size }

pub fn MlrltrpoLayer::get(self : MlrltrpoLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrltrpoLayer::set(self : MlrltrpoLayer, i : Int, v : Double) -> MlrltrpoLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrltrpoLayer::sum(self : MlrltrpoLayer) -> Double { @_common.sum(self.data) }

pub fn MlrltrpoLayer::mean(self : MlrltrpoLayer) -> Double { @_common.mean(self.data) }

pub fn MlrltrpoLayer::scale(self : MlrltrpoLayer, f : Double) -> MlrltrpoLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrltrpoLayer::add(self : MlrltrpoLayer, other : MlrltrpoLayer) -> MlrltrpoLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrltrpoLayer::copy(self : MlrltrpoLayer) -> MlrltrpoLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrltrpoLayer::fill(self : MlrltrpoLayer, v : Double) -> MlrltrpoLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrltrpoLayer::min(self : MlrltrpoLayer) -> Double { @_common.min(self.data) }

pub fn MlrltrpoLayer::max(self : MlrltrpoLayer) -> Double { @_common.max(self.data) }

pub fn MlrltrpoLayer::to_string(self : MlrltrpoLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrltrpoBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_trpo_buffer_make(size : Int) -> MlrltrpoBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrltrpoBuffer::len(self : MlrltrpoBuffer) -> Int { self.size }

pub fn MlrltrpoBuffer::get(self : MlrltrpoBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrltrpoBuffer::set(self : MlrltrpoBuffer, i : Int, v : Double) -> MlrltrpoBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrltrpoBuffer::sum(self : MlrltrpoBuffer) -> Double { @_common.sum(self.data) }

pub fn MlrltrpoBuffer::mean(self : MlrltrpoBuffer) -> Double { @_common.mean(self.data) }

pub fn MlrltrpoBuffer::scale(self : MlrltrpoBuffer, f : Double) -> MlrltrpoBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrltrpoBuffer::add(self : MlrltrpoBuffer, other : MlrltrpoBuffer) -> MlrltrpoBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrltrpoBuffer::copy(self : MlrltrpoBuffer) -> MlrltrpoBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrltrpoBuffer::fill(self : MlrltrpoBuffer, v : Double) -> MlrltrpoBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrltrpoBuffer::min(self : MlrltrpoBuffer) -> Double { @_common.min(self.data) }

pub fn MlrltrpoBuffer::max(self : MlrltrpoBuffer) -> Double { @_common.max(self.data) }

pub fn MlrltrpoBuffer::to_string(self : MlrltrpoBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrltrpoCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_trpo_cursor_make(size : Int) -> MlrltrpoCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrltrpoCursor::len(self : MlrltrpoCursor) -> Int { self.size }

pub fn MlrltrpoCursor::get(self : MlrltrpoCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrltrpoCursor::set(self : MlrltrpoCursor, i : Int, v : Double) -> MlrltrpoCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrltrpoCursor::sum(self : MlrltrpoCursor) -> Double { @_common.sum(self.data) }

pub fn MlrltrpoCursor::mean(self : MlrltrpoCursor) -> Double { @_common.mean(self.data) }

pub fn MlrltrpoCursor::scale(self : MlrltrpoCursor, f : Double) -> MlrltrpoCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrltrpoCursor::add(self : MlrltrpoCursor, other : MlrltrpoCursor) -> MlrltrpoCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrltrpoCursor::copy(self : MlrltrpoCursor) -> MlrltrpoCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrltrpoCursor::fill(self : MlrltrpoCursor, v : Double) -> MlrltrpoCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrltrpoCursor::min(self : MlrltrpoCursor) -> Double { @_common.min(self.data) }

pub fn MlrltrpoCursor::max(self : MlrltrpoCursor) -> Double { @_common.max(self.data) }

pub fn MlrltrpoCursor::to_string(self : MlrltrpoCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrltrpoView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_trpo_view_make(size : Int) -> MlrltrpoView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrltrpoView::len(self : MlrltrpoView) -> Int { self.size }

pub fn MlrltrpoView::get(self : MlrltrpoView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrltrpoView::set(self : MlrltrpoView, i : Int, v : Double) -> MlrltrpoView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrltrpoView::sum(self : MlrltrpoView) -> Double { @_common.sum(self.data) }

pub fn MlrltrpoView::mean(self : MlrltrpoView) -> Double { @_common.mean(self.data) }

pub fn MlrltrpoView::scale(self : MlrltrpoView, f : Double) -> MlrltrpoView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrltrpoView::add(self : MlrltrpoView, other : MlrltrpoView) -> MlrltrpoView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrltrpoView::copy(self : MlrltrpoView) -> MlrltrpoView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrltrpoView::fill(self : MlrltrpoView, v : Double) -> MlrltrpoView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrltrpoView::min(self : MlrltrpoView) -> Double { @_common.min(self.data) }

pub fn MlrltrpoView::max(self : MlrltrpoView) -> Double { @_common.max(self.data) }

pub fn MlrltrpoView::to_string(self : MlrltrpoView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrltrpoRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_trpo_range_make(size : Int) -> MlrltrpoRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrltrpoRange::len(self : MlrltrpoRange) -> Int { self.size }

pub fn MlrltrpoRange::get(self : MlrltrpoRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrltrpoRange::set(self : MlrltrpoRange, i : Int, v : Double) -> MlrltrpoRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrltrpoRange::sum(self : MlrltrpoRange) -> Double { @_common.sum(self.data) }

pub fn MlrltrpoRange::mean(self : MlrltrpoRange) -> Double { @_common.mean(self.data) }

pub fn MlrltrpoRange::scale(self : MlrltrpoRange, f : Double) -> MlrltrpoRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrltrpoRange::add(self : MlrltrpoRange, other : MlrltrpoRange) -> MlrltrpoRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrltrpoRange::copy(self : MlrltrpoRange) -> MlrltrpoRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrltrpoRange::fill(self : MlrltrpoRange, v : Double) -> MlrltrpoRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrltrpoRange::min(self : MlrltrpoRange) -> Double { @_common.min(self.data) }

pub fn MlrltrpoRange::max(self : MlrltrpoRange) -> Double { @_common.max(self.data) }

pub fn MlrltrpoRange::to_string(self : MlrltrpoRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlrltrpoSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_trpo_slice_make(size : Int) -> MlrltrpoSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlrltrpoSlice::len(self : MlrltrpoSlice) -> Int { self.size }

pub fn MlrltrpoSlice::get(self : MlrltrpoSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlrltrpoSlice::set(self : MlrltrpoSlice, i : Int, v : Double) -> MlrltrpoSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlrltrpoSlice::sum(self : MlrltrpoSlice) -> Double { @_common.sum(self.data) }

pub fn MlrltrpoSlice::mean(self : MlrltrpoSlice) -> Double { @_common.mean(self.data) }

pub fn MlrltrpoSlice::scale(self : MlrltrpoSlice, f : Double) -> MlrltrpoSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlrltrpoSlice::add(self : MlrltrpoSlice, other : MlrltrpoSlice) -> MlrltrpoSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlrltrpoSlice::copy(self : MlrltrpoSlice) -> MlrltrpoSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlrltrpoSlice::fill(self : MlrltrpoSlice, v : Double) -> MlrltrpoSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlrltrpoSlice::min(self : MlrltrpoSlice) -> Double { @_common.min(self.data) }

pub fn MlrltrpoSlice::max(self : MlrltrpoSlice) -> Double { @_common.max(self.data) }

pub fn MlrltrpoSlice::to_string(self : MlrltrpoSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

