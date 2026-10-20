///===
/// extcore/ml_metric_ranking

pub(all) struct MlmetricrankingPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_metric_ranking_make_point(x : Double, y : Double) -> MlmetricrankingPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_metric_ranking_make_point3(x : Double, y : Double, z : Double) -> MlmetricrankingPoint {
  { x, y, z, label: 0 }
}

pub fn MlmetricrankingPoint::x(self : MlmetricrankingPoint) -> Double { self.x }

pub fn MlmetricrankingPoint::y(self : MlmetricrankingPoint) -> Double { self.y }

pub fn MlmetricrankingPoint::z(self : MlmetricrankingPoint) -> Double { self.z }

pub fn MlmetricrankingPoint::label(self : MlmetricrankingPoint) -> Int { self.label }

pub fn MlmetricrankingPoint::dist(self : MlmetricrankingPoint, other : MlmetricrankingPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlmetricrankingPoint::add(self : MlmetricrankingPoint, other : MlmetricrankingPoint) -> MlmetricrankingPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlmetricrankingPoint::sub(self : MlmetricrankingPoint, other : MlmetricrankingPoint) -> MlmetricrankingPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlmetricrankingPoint::scale(self : MlmetricrankingPoint, s : Double) -> MlmetricrankingPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlmetricrankingPoint::dot(self : MlmetricrankingPoint, other : MlmetricrankingPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlmetricrankingPoint::cross(self : MlmetricrankingPoint, other : MlmetricrankingPoint) -> MlmetricrankingPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlmetricrankingPoint::norm(self : MlmetricrankingPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlmetricrankingPoint::normalize(self : MlmetricrankingPoint) -> MlmetricrankingPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlmetricrankingPoint::negate(self : MlmetricrankingPoint) -> MlmetricrankingPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlmetricrankingPoint::mid(self : MlmetricrankingPoint, other : MlmetricrankingPoint) -> MlmetricrankingPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlmetricrankingPoint::lerp(self : MlmetricrankingPoint, other : MlmetricrankingPoint, t : Double) -> MlmetricrankingPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlmetricrankingPoint::to_string(self : MlmetricrankingPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlmetricrankingSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_metric_ranking_make_series(vals : Array[Double], name : String) -> MlmetricrankingSeries {
  { vals, name, meta: 0 }
}

pub fn MlmetricrankingSeries::len(self : MlmetricrankingSeries) -> Int { self.vals.length() }

pub fn MlmetricrankingSeries::sum(self : MlmetricrankingSeries) -> Double { @_common.sum(self.vals) }

pub fn MlmetricrankingSeries::mean(self : MlmetricrankingSeries) -> Double { @_common.mean(self.vals) }

pub fn MlmetricrankingSeries::min(self : MlmetricrankingSeries) -> Double { @_common.min(self.vals) }

pub fn MlmetricrankingSeries::max(self : MlmetricrankingSeries) -> Double { @_common.max(self.vals) }

pub fn MlmetricrankingSeries::range(self : MlmetricrankingSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlmetricrankingSeries::variance(self : MlmetricrankingSeries) -> Double { @_common.variance(self.vals) }

pub fn MlmetricrankingSeries::std(self : MlmetricrankingSeries) -> Double { @_common.std(self.vals) }

pub fn MlmetricrankingSeries::median(self : MlmetricrankingSeries) -> Double { @_common.median(self.vals) }

pub fn MlmetricrankingSeries::scale(self : MlmetricrankingSeries, f : Double) -> MlmetricrankingSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlmetricrankingSeries::add(self : MlmetricrankingSeries, other : MlmetricrankingSeries) -> MlmetricrankingSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlmetricrankingSeries::sub(self : MlmetricrankingSeries, other : MlmetricrankingSeries) -> MlmetricrankingSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlmetricrankingSeries::normalize(self : MlmetricrankingSeries) -> MlmetricrankingSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlmetricrankingSeries::cumsum(self : MlmetricrankingSeries) -> MlmetricrankingSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlmetricrankingSeries::to_string(self : MlmetricrankingSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlmetricrankingMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_metric_ranking_make_matrix(rows : Int, cols : Int, val : Double) -> MlmetricrankingMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn ml_metric_ranking_matrix_identity(n : Int) -> MlmetricrankingMatrix {
  let m = ml_metric_ranking_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlmetricrankingMatrix::get(self : MlmetricrankingMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlmetricrankingMatrix::transpose(self : MlmetricrankingMatrix) -> MlmetricrankingMatrix {
  let result = ml_metric_ranking_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlmetricrankingMatrix::add(self : MlmetricrankingMatrix, other : MlmetricrankingMatrix) -> MlmetricrankingMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_metric_ranking_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlmetricrankingMatrix::scale(self : MlmetricrankingMatrix, s : Double) -> MlmetricrankingMatrix {
  let result = ml_metric_ranking_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlmetricrankingMatrix::multiply(self : MlmetricrankingMatrix, other : MlmetricrankingMatrix) -> MlmetricrankingMatrix {
  if self.cols != other.rows { return ml_metric_ranking_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_metric_ranking_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn MlmetricrankingMatrix::trace(self : MlmetricrankingMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlmetricrankingMatrix::det(self : MlmetricrankingMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlmetricrankingMatrix::norm(self : MlmetricrankingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlmetricrankingMatrix::to_string(self : MlmetricrankingMatrix) -> String {
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

pub(all) struct MlmetricrankingVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_metric_ranking_make_vector(comps : Array[Double]) -> MlmetricrankingVector {
  { comps, dim: comps.length() }
}

pub fn ml_metric_ranking_vector_zero(dim : Int) -> MlmetricrankingVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlmetricrankingVector::add(self : MlmetricrankingVector, other : MlmetricrankingVector) -> MlmetricrankingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlmetricrankingVector::sub(self : MlmetricrankingVector, other : MlmetricrankingVector) -> MlmetricrankingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlmetricrankingVector::scale(self : MlmetricrankingVector, s : Double) -> MlmetricrankingVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlmetricrankingVector::dot(self : MlmetricrankingVector, other : MlmetricrankingVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlmetricrankingVector::norm(self : MlmetricrankingVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlmetricrankingVector::normalize(self : MlmetricrankingVector) -> MlmetricrankingVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlmetricrankingVector::dist(self : MlmetricrankingVector, other : MlmetricrankingVector) -> Double {
  self.sub(other).norm()
}

pub fn MlmetricrankingVector::to_string(self : MlmetricrankingVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlmetricrankingFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_ranking_frame_make(size : Int) -> MlmetricrankingFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricrankingFrame::len(self : MlmetricrankingFrame) -> Int { self.size }

pub fn MlmetricrankingFrame::get(self : MlmetricrankingFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricrankingFrame::set(self : MlmetricrankingFrame, i : Int, v : Double) -> MlmetricrankingFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricrankingFrame::sum(self : MlmetricrankingFrame) -> Double { @_common.sum(self.data) }

pub fn MlmetricrankingFrame::mean(self : MlmetricrankingFrame) -> Double { @_common.mean(self.data) }

pub fn MlmetricrankingFrame::scale(self : MlmetricrankingFrame, f : Double) -> MlmetricrankingFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricrankingFrame::add(self : MlmetricrankingFrame, other : MlmetricrankingFrame) -> MlmetricrankingFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricrankingFrame::copy(self : MlmetricrankingFrame) -> MlmetricrankingFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricrankingFrame::fill(self : MlmetricrankingFrame, v : Double) -> MlmetricrankingFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricrankingFrame::min(self : MlmetricrankingFrame) -> Double { @_common.min(self.data) }

pub fn MlmetricrankingFrame::max(self : MlmetricrankingFrame) -> Double { @_common.max(self.data) }

pub fn MlmetricrankingFrame::to_string(self : MlmetricrankingFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricrankingTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_ranking_table_make(size : Int) -> MlmetricrankingTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricrankingTable::len(self : MlmetricrankingTable) -> Int { self.size }

pub fn MlmetricrankingTable::get(self : MlmetricrankingTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricrankingTable::set(self : MlmetricrankingTable, i : Int, v : Double) -> MlmetricrankingTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricrankingTable::sum(self : MlmetricrankingTable) -> Double { @_common.sum(self.data) }

pub fn MlmetricrankingTable::mean(self : MlmetricrankingTable) -> Double { @_common.mean(self.data) }

pub fn MlmetricrankingTable::scale(self : MlmetricrankingTable, f : Double) -> MlmetricrankingTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricrankingTable::add(self : MlmetricrankingTable, other : MlmetricrankingTable) -> MlmetricrankingTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricrankingTable::copy(self : MlmetricrankingTable) -> MlmetricrankingTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricrankingTable::fill(self : MlmetricrankingTable, v : Double) -> MlmetricrankingTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricrankingTable::min(self : MlmetricrankingTable) -> Double { @_common.min(self.data) }

pub fn MlmetricrankingTable::max(self : MlmetricrankingTable) -> Double { @_common.max(self.data) }

pub fn MlmetricrankingTable::to_string(self : MlmetricrankingTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricrankingGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_ranking_graphn_make(size : Int) -> MlmetricrankingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricrankingGraphN::len(self : MlmetricrankingGraphN) -> Int { self.size }

pub fn MlmetricrankingGraphN::get(self : MlmetricrankingGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricrankingGraphN::set(self : MlmetricrankingGraphN, i : Int, v : Double) -> MlmetricrankingGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricrankingGraphN::sum(self : MlmetricrankingGraphN) -> Double { @_common.sum(self.data) }

pub fn MlmetricrankingGraphN::mean(self : MlmetricrankingGraphN) -> Double { @_common.mean(self.data) }

pub fn MlmetricrankingGraphN::scale(self : MlmetricrankingGraphN, f : Double) -> MlmetricrankingGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricrankingGraphN::add(self : MlmetricrankingGraphN, other : MlmetricrankingGraphN) -> MlmetricrankingGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricrankingGraphN::copy(self : MlmetricrankingGraphN) -> MlmetricrankingGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricrankingGraphN::fill(self : MlmetricrankingGraphN, v : Double) -> MlmetricrankingGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricrankingGraphN::min(self : MlmetricrankingGraphN) -> Double { @_common.min(self.data) }

pub fn MlmetricrankingGraphN::max(self : MlmetricrankingGraphN) -> Double { @_common.max(self.data) }

pub fn MlmetricrankingGraphN::to_string(self : MlmetricrankingGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricrankingNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_ranking_node_make(size : Int) -> MlmetricrankingNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricrankingNode::len(self : MlmetricrankingNode) -> Int { self.size }

pub fn MlmetricrankingNode::get(self : MlmetricrankingNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricrankingNode::set(self : MlmetricrankingNode, i : Int, v : Double) -> MlmetricrankingNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricrankingNode::sum(self : MlmetricrankingNode) -> Double { @_common.sum(self.data) }

pub fn MlmetricrankingNode::mean(self : MlmetricrankingNode) -> Double { @_common.mean(self.data) }

pub fn MlmetricrankingNode::scale(self : MlmetricrankingNode, f : Double) -> MlmetricrankingNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricrankingNode::add(self : MlmetricrankingNode, other : MlmetricrankingNode) -> MlmetricrankingNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricrankingNode::copy(self : MlmetricrankingNode) -> MlmetricrankingNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricrankingNode::fill(self : MlmetricrankingNode, v : Double) -> MlmetricrankingNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricrankingNode::min(self : MlmetricrankingNode) -> Double { @_common.min(self.data) }

pub fn MlmetricrankingNode::max(self : MlmetricrankingNode) -> Double { @_common.max(self.data) }

pub fn MlmetricrankingNode::to_string(self : MlmetricrankingNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricrankingEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_ranking_edge_make(size : Int) -> MlmetricrankingEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricrankingEdge::len(self : MlmetricrankingEdge) -> Int { self.size }

pub fn MlmetricrankingEdge::get(self : MlmetricrankingEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricrankingEdge::set(self : MlmetricrankingEdge, i : Int, v : Double) -> MlmetricrankingEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricrankingEdge::sum(self : MlmetricrankingEdge) -> Double { @_common.sum(self.data) }

pub fn MlmetricrankingEdge::mean(self : MlmetricrankingEdge) -> Double { @_common.mean(self.data) }

pub fn MlmetricrankingEdge::scale(self : MlmetricrankingEdge, f : Double) -> MlmetricrankingEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricrankingEdge::add(self : MlmetricrankingEdge, other : MlmetricrankingEdge) -> MlmetricrankingEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricrankingEdge::copy(self : MlmetricrankingEdge) -> MlmetricrankingEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricrankingEdge::fill(self : MlmetricrankingEdge, v : Double) -> MlmetricrankingEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricrankingEdge::min(self : MlmetricrankingEdge) -> Double { @_common.min(self.data) }

pub fn MlmetricrankingEdge::max(self : MlmetricrankingEdge) -> Double { @_common.max(self.data) }

pub fn MlmetricrankingEdge::to_string(self : MlmetricrankingEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricrankingPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_ranking_path_make(size : Int) -> MlmetricrankingPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricrankingPath::len(self : MlmetricrankingPath) -> Int { self.size }

pub fn MlmetricrankingPath::get(self : MlmetricrankingPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricrankingPath::set(self : MlmetricrankingPath, i : Int, v : Double) -> MlmetricrankingPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricrankingPath::sum(self : MlmetricrankingPath) -> Double { @_common.sum(self.data) }

pub fn MlmetricrankingPath::mean(self : MlmetricrankingPath) -> Double { @_common.mean(self.data) }

pub fn MlmetricrankingPath::scale(self : MlmetricrankingPath, f : Double) -> MlmetricrankingPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricrankingPath::add(self : MlmetricrankingPath, other : MlmetricrankingPath) -> MlmetricrankingPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricrankingPath::copy(self : MlmetricrankingPath) -> MlmetricrankingPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricrankingPath::fill(self : MlmetricrankingPath, v : Double) -> MlmetricrankingPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricrankingPath::min(self : MlmetricrankingPath) -> Double { @_common.min(self.data) }

pub fn MlmetricrankingPath::max(self : MlmetricrankingPath) -> Double { @_common.max(self.data) }

pub fn MlmetricrankingPath::to_string(self : MlmetricrankingPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricrankingCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_ranking_cluster_make(size : Int) -> MlmetricrankingCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricrankingCluster::len(self : MlmetricrankingCluster) -> Int { self.size }

pub fn MlmetricrankingCluster::get(self : MlmetricrankingCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricrankingCluster::set(self : MlmetricrankingCluster, i : Int, v : Double) -> MlmetricrankingCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricrankingCluster::sum(self : MlmetricrankingCluster) -> Double { @_common.sum(self.data) }

pub fn MlmetricrankingCluster::mean(self : MlmetricrankingCluster) -> Double { @_common.mean(self.data) }

pub fn MlmetricrankingCluster::scale(self : MlmetricrankingCluster, f : Double) -> MlmetricrankingCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricrankingCluster::add(self : MlmetricrankingCluster, other : MlmetricrankingCluster) -> MlmetricrankingCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricrankingCluster::copy(self : MlmetricrankingCluster) -> MlmetricrankingCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricrankingCluster::fill(self : MlmetricrankingCluster, v : Double) -> MlmetricrankingCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricrankingCluster::min(self : MlmetricrankingCluster) -> Double { @_common.min(self.data) }

pub fn MlmetricrankingCluster::max(self : MlmetricrankingCluster) -> Double { @_common.max(self.data) }

pub fn MlmetricrankingCluster::to_string(self : MlmetricrankingCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricrankingModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_ranking_model_make(size : Int) -> MlmetricrankingModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricrankingModel::len(self : MlmetricrankingModel) -> Int { self.size }

pub fn MlmetricrankingModel::get(self : MlmetricrankingModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricrankingModel::set(self : MlmetricrankingModel, i : Int, v : Double) -> MlmetricrankingModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricrankingModel::sum(self : MlmetricrankingModel) -> Double { @_common.sum(self.data) }

pub fn MlmetricrankingModel::mean(self : MlmetricrankingModel) -> Double { @_common.mean(self.data) }

pub fn MlmetricrankingModel::scale(self : MlmetricrankingModel, f : Double) -> MlmetricrankingModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricrankingModel::add(self : MlmetricrankingModel, other : MlmetricrankingModel) -> MlmetricrankingModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricrankingModel::copy(self : MlmetricrankingModel) -> MlmetricrankingModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricrankingModel::fill(self : MlmetricrankingModel, v : Double) -> MlmetricrankingModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricrankingModel::min(self : MlmetricrankingModel) -> Double { @_common.min(self.data) }

pub fn MlmetricrankingModel::max(self : MlmetricrankingModel) -> Double { @_common.max(self.data) }

pub fn MlmetricrankingModel::to_string(self : MlmetricrankingModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricrankingLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_ranking_layer_make(size : Int) -> MlmetricrankingLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricrankingLayer::len(self : MlmetricrankingLayer) -> Int { self.size }

pub fn MlmetricrankingLayer::get(self : MlmetricrankingLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricrankingLayer::set(self : MlmetricrankingLayer, i : Int, v : Double) -> MlmetricrankingLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricrankingLayer::sum(self : MlmetricrankingLayer) -> Double { @_common.sum(self.data) }

pub fn MlmetricrankingLayer::mean(self : MlmetricrankingLayer) -> Double { @_common.mean(self.data) }

pub fn MlmetricrankingLayer::scale(self : MlmetricrankingLayer, f : Double) -> MlmetricrankingLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricrankingLayer::add(self : MlmetricrankingLayer, other : MlmetricrankingLayer) -> MlmetricrankingLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricrankingLayer::copy(self : MlmetricrankingLayer) -> MlmetricrankingLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricrankingLayer::fill(self : MlmetricrankingLayer, v : Double) -> MlmetricrankingLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricrankingLayer::min(self : MlmetricrankingLayer) -> Double { @_common.min(self.data) }

pub fn MlmetricrankingLayer::max(self : MlmetricrankingLayer) -> Double { @_common.max(self.data) }

pub fn MlmetricrankingLayer::to_string(self : MlmetricrankingLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricrankingBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_ranking_buffer_make(size : Int) -> MlmetricrankingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricrankingBuffer::len(self : MlmetricrankingBuffer) -> Int { self.size }

pub fn MlmetricrankingBuffer::get(self : MlmetricrankingBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricrankingBuffer::set(self : MlmetricrankingBuffer, i : Int, v : Double) -> MlmetricrankingBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricrankingBuffer::sum(self : MlmetricrankingBuffer) -> Double { @_common.sum(self.data) }

pub fn MlmetricrankingBuffer::mean(self : MlmetricrankingBuffer) -> Double { @_common.mean(self.data) }

pub fn MlmetricrankingBuffer::scale(self : MlmetricrankingBuffer, f : Double) -> MlmetricrankingBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricrankingBuffer::add(self : MlmetricrankingBuffer, other : MlmetricrankingBuffer) -> MlmetricrankingBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricrankingBuffer::copy(self : MlmetricrankingBuffer) -> MlmetricrankingBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricrankingBuffer::fill(self : MlmetricrankingBuffer, v : Double) -> MlmetricrankingBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricrankingBuffer::min(self : MlmetricrankingBuffer) -> Double { @_common.min(self.data) }

pub fn MlmetricrankingBuffer::max(self : MlmetricrankingBuffer) -> Double { @_common.max(self.data) }

pub fn MlmetricrankingBuffer::to_string(self : MlmetricrankingBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricrankingCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_ranking_cursor_make(size : Int) -> MlmetricrankingCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricrankingCursor::len(self : MlmetricrankingCursor) -> Int { self.size }

pub fn MlmetricrankingCursor::get(self : MlmetricrankingCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricrankingCursor::set(self : MlmetricrankingCursor, i : Int, v : Double) -> MlmetricrankingCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricrankingCursor::sum(self : MlmetricrankingCursor) -> Double { @_common.sum(self.data) }

pub fn MlmetricrankingCursor::mean(self : MlmetricrankingCursor) -> Double { @_common.mean(self.data) }

pub fn MlmetricrankingCursor::scale(self : MlmetricrankingCursor, f : Double) -> MlmetricrankingCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricrankingCursor::add(self : MlmetricrankingCursor, other : MlmetricrankingCursor) -> MlmetricrankingCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricrankingCursor::copy(self : MlmetricrankingCursor) -> MlmetricrankingCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricrankingCursor::fill(self : MlmetricrankingCursor, v : Double) -> MlmetricrankingCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricrankingCursor::min(self : MlmetricrankingCursor) -> Double { @_common.min(self.data) }

pub fn MlmetricrankingCursor::max(self : MlmetricrankingCursor) -> Double { @_common.max(self.data) }

pub fn MlmetricrankingCursor::to_string(self : MlmetricrankingCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricrankingView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_ranking_view_make(size : Int) -> MlmetricrankingView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricrankingView::len(self : MlmetricrankingView) -> Int { self.size }

pub fn MlmetricrankingView::get(self : MlmetricrankingView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricrankingView::set(self : MlmetricrankingView, i : Int, v : Double) -> MlmetricrankingView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricrankingView::sum(self : MlmetricrankingView) -> Double { @_common.sum(self.data) }

pub fn MlmetricrankingView::mean(self : MlmetricrankingView) -> Double { @_common.mean(self.data) }

pub fn MlmetricrankingView::scale(self : MlmetricrankingView, f : Double) -> MlmetricrankingView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricrankingView::add(self : MlmetricrankingView, other : MlmetricrankingView) -> MlmetricrankingView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricrankingView::copy(self : MlmetricrankingView) -> MlmetricrankingView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricrankingView::fill(self : MlmetricrankingView, v : Double) -> MlmetricrankingView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricrankingView::min(self : MlmetricrankingView) -> Double { @_common.min(self.data) }

pub fn MlmetricrankingView::max(self : MlmetricrankingView) -> Double { @_common.max(self.data) }

pub fn MlmetricrankingView::to_string(self : MlmetricrankingView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricrankingRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_ranking_range_make(size : Int) -> MlmetricrankingRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricrankingRange::len(self : MlmetricrankingRange) -> Int { self.size }

pub fn MlmetricrankingRange::get(self : MlmetricrankingRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricrankingRange::set(self : MlmetricrankingRange, i : Int, v : Double) -> MlmetricrankingRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricrankingRange::sum(self : MlmetricrankingRange) -> Double { @_common.sum(self.data) }

pub fn MlmetricrankingRange::mean(self : MlmetricrankingRange) -> Double { @_common.mean(self.data) }

pub fn MlmetricrankingRange::scale(self : MlmetricrankingRange, f : Double) -> MlmetricrankingRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricrankingRange::add(self : MlmetricrankingRange, other : MlmetricrankingRange) -> MlmetricrankingRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricrankingRange::copy(self : MlmetricrankingRange) -> MlmetricrankingRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricrankingRange::fill(self : MlmetricrankingRange, v : Double) -> MlmetricrankingRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricrankingRange::min(self : MlmetricrankingRange) -> Double { @_common.min(self.data) }

pub fn MlmetricrankingRange::max(self : MlmetricrankingRange) -> Double { @_common.max(self.data) }

pub fn MlmetricrankingRange::to_string(self : MlmetricrankingRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricrankingSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_ranking_slice_make(size : Int) -> MlmetricrankingSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricrankingSlice::len(self : MlmetricrankingSlice) -> Int { self.size }

pub fn MlmetricrankingSlice::get(self : MlmetricrankingSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricrankingSlice::set(self : MlmetricrankingSlice, i : Int, v : Double) -> MlmetricrankingSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricrankingSlice::sum(self : MlmetricrankingSlice) -> Double { @_common.sum(self.data) }

pub fn MlmetricrankingSlice::mean(self : MlmetricrankingSlice) -> Double { @_common.mean(self.data) }

pub fn MlmetricrankingSlice::scale(self : MlmetricrankingSlice, f : Double) -> MlmetricrankingSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricrankingSlice::add(self : MlmetricrankingSlice, other : MlmetricrankingSlice) -> MlmetricrankingSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricrankingSlice::copy(self : MlmetricrankingSlice) -> MlmetricrankingSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricrankingSlice::fill(self : MlmetricrankingSlice, v : Double) -> MlmetricrankingSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricrankingSlice::min(self : MlmetricrankingSlice) -> Double { @_common.min(self.data) }

pub fn MlmetricrankingSlice::max(self : MlmetricrankingSlice) -> Double { @_common.max(self.data) }

pub fn MlmetricrankingSlice::to_string(self : MlmetricrankingSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

