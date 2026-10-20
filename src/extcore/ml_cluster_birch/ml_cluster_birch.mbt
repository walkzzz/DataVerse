///===
/// extcore/ml_cluster_birch

pub(all) struct MlclusterbirchPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_cluster_birch_make_point(x : Double, y : Double) -> MlclusterbirchPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_cluster_birch_make_point3(x : Double, y : Double, z : Double) -> MlclusterbirchPoint {
  { x, y, z, label: 0 }
}

pub fn MlclusterbirchPoint::x(self : MlclusterbirchPoint) -> Double { self.x }

pub fn MlclusterbirchPoint::y(self : MlclusterbirchPoint) -> Double { self.y }

pub fn MlclusterbirchPoint::z(self : MlclusterbirchPoint) -> Double { self.z }

pub fn MlclusterbirchPoint::label(self : MlclusterbirchPoint) -> Int { self.label }

pub fn MlclusterbirchPoint::dist(self : MlclusterbirchPoint, other : MlclusterbirchPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlclusterbirchPoint::add(self : MlclusterbirchPoint, other : MlclusterbirchPoint) -> MlclusterbirchPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlclusterbirchPoint::sub(self : MlclusterbirchPoint, other : MlclusterbirchPoint) -> MlclusterbirchPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlclusterbirchPoint::scale(self : MlclusterbirchPoint, s : Double) -> MlclusterbirchPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlclusterbirchPoint::dot(self : MlclusterbirchPoint, other : MlclusterbirchPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlclusterbirchPoint::cross(self : MlclusterbirchPoint, other : MlclusterbirchPoint) -> MlclusterbirchPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlclusterbirchPoint::norm(self : MlclusterbirchPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlclusterbirchPoint::normalize(self : MlclusterbirchPoint) -> MlclusterbirchPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclusterbirchPoint::negate(self : MlclusterbirchPoint) -> MlclusterbirchPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlclusterbirchPoint::mid(self : MlclusterbirchPoint, other : MlclusterbirchPoint) -> MlclusterbirchPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlclusterbirchPoint::lerp(self : MlclusterbirchPoint, other : MlclusterbirchPoint, t : Double) -> MlclusterbirchPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlclusterbirchPoint::to_string(self : MlclusterbirchPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlclusterbirchSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_cluster_birch_make_series(vals : Array[Double], name : String) -> MlclusterbirchSeries {
  { vals, name, meta: 0 }
}

pub fn MlclusterbirchSeries::len(self : MlclusterbirchSeries) -> Int { self.vals.length() }

pub fn MlclusterbirchSeries::sum(self : MlclusterbirchSeries) -> Double { @_common.sum(self.vals) }

pub fn MlclusterbirchSeries::mean(self : MlclusterbirchSeries) -> Double { @_common.mean(self.vals) }

pub fn MlclusterbirchSeries::min(self : MlclusterbirchSeries) -> Double { @_common.min(self.vals) }

pub fn MlclusterbirchSeries::max(self : MlclusterbirchSeries) -> Double { @_common.max(self.vals) }

pub fn MlclusterbirchSeries::range(self : MlclusterbirchSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlclusterbirchSeries::variance(self : MlclusterbirchSeries) -> Double { @_common.variance(self.vals) }

pub fn MlclusterbirchSeries::std(self : MlclusterbirchSeries) -> Double { @_common.std(self.vals) }

pub fn MlclusterbirchSeries::median(self : MlclusterbirchSeries) -> Double { @_common.median(self.vals) }

pub fn MlclusterbirchSeries::scale(self : MlclusterbirchSeries, f : Double) -> MlclusterbirchSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlclusterbirchSeries::add(self : MlclusterbirchSeries, other : MlclusterbirchSeries) -> MlclusterbirchSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlclusterbirchSeries::sub(self : MlclusterbirchSeries, other : MlclusterbirchSeries) -> MlclusterbirchSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlclusterbirchSeries::normalize(self : MlclusterbirchSeries) -> MlclusterbirchSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlclusterbirchSeries::cumsum(self : MlclusterbirchSeries) -> MlclusterbirchSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlclusterbirchSeries::to_string(self : MlclusterbirchSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclusterbirchMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_cluster_birch_make_matrix(rows : Int, cols : Int, val : Double) -> MlclusterbirchMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_cluster_birch_matrix_identity(n : Int) -> MlclusterbirchMatrix {
  let m = ml_cluster_birch_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlclusterbirchMatrix::get(self : MlclusterbirchMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlclusterbirchMatrix::transpose(self : MlclusterbirchMatrix) -> MlclusterbirchMatrix {
  let result = ml_cluster_birch_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlclusterbirchMatrix::add(self : MlclusterbirchMatrix, other : MlclusterbirchMatrix) -> MlclusterbirchMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_cluster_birch_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlclusterbirchMatrix::scale(self : MlclusterbirchMatrix, s : Double) -> MlclusterbirchMatrix {
  let result = ml_cluster_birch_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlclusterbirchMatrix::multiply(self : MlclusterbirchMatrix, other : MlclusterbirchMatrix) -> MlclusterbirchMatrix {
  if self.cols != other.rows { return ml_cluster_birch_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_cluster_birch_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlclusterbirchMatrix::trace(self : MlclusterbirchMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlclusterbirchMatrix::det(self : MlclusterbirchMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlclusterbirchMatrix::norm(self : MlclusterbirchMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlclusterbirchMatrix::to_string(self : MlclusterbirchMatrix) -> String {
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

pub(all) struct MlclusterbirchVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_cluster_birch_make_vector(comps : Array[Double]) -> MlclusterbirchVector {
  { comps, dim: comps.length() }
}

pub fn ml_cluster_birch_vector_zero(dim : Int) -> MlclusterbirchVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlclusterbirchVector::add(self : MlclusterbirchVector, other : MlclusterbirchVector) -> MlclusterbirchVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlclusterbirchVector::sub(self : MlclusterbirchVector, other : MlclusterbirchVector) -> MlclusterbirchVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlclusterbirchVector::scale(self : MlclusterbirchVector, s : Double) -> MlclusterbirchVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlclusterbirchVector::dot(self : MlclusterbirchVector, other : MlclusterbirchVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlclusterbirchVector::norm(self : MlclusterbirchVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlclusterbirchVector::normalize(self : MlclusterbirchVector) -> MlclusterbirchVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclusterbirchVector::dist(self : MlclusterbirchVector, other : MlclusterbirchVector) -> Double {
  self.sub(other).norm()
}

pub fn MlclusterbirchVector::to_string(self : MlclusterbirchVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclusterbirchFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_birch_frame_make(size : Int) -> MlclusterbirchFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusterbirchFrame::len(self : MlclusterbirchFrame) -> Int { self.size }

pub fn MlclusterbirchFrame::get(self : MlclusterbirchFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusterbirchFrame::set(self : MlclusterbirchFrame, i : Int, v : Double) -> MlclusterbirchFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusterbirchFrame::sum(self : MlclusterbirchFrame) -> Double { @_common.sum(self.data) }

pub fn MlclusterbirchFrame::mean(self : MlclusterbirchFrame) -> Double { @_common.mean(self.data) }

pub fn MlclusterbirchFrame::scale(self : MlclusterbirchFrame, f : Double) -> MlclusterbirchFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusterbirchFrame::add(self : MlclusterbirchFrame, other : MlclusterbirchFrame) -> MlclusterbirchFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusterbirchFrame::copy(self : MlclusterbirchFrame) -> MlclusterbirchFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusterbirchFrame::fill(self : MlclusterbirchFrame, v : Double) -> MlclusterbirchFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusterbirchFrame::min(self : MlclusterbirchFrame) -> Double { @_common.min(self.data) }

pub fn MlclusterbirchFrame::max(self : MlclusterbirchFrame) -> Double { @_common.max(self.data) }

pub fn MlclusterbirchFrame::to_string(self : MlclusterbirchFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusterbirchTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_birch_table_make(size : Int) -> MlclusterbirchTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusterbirchTable::len(self : MlclusterbirchTable) -> Int { self.size }

pub fn MlclusterbirchTable::get(self : MlclusterbirchTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusterbirchTable::set(self : MlclusterbirchTable, i : Int, v : Double) -> MlclusterbirchTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusterbirchTable::sum(self : MlclusterbirchTable) -> Double { @_common.sum(self.data) }

pub fn MlclusterbirchTable::mean(self : MlclusterbirchTable) -> Double { @_common.mean(self.data) }

pub fn MlclusterbirchTable::scale(self : MlclusterbirchTable, f : Double) -> MlclusterbirchTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusterbirchTable::add(self : MlclusterbirchTable, other : MlclusterbirchTable) -> MlclusterbirchTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusterbirchTable::copy(self : MlclusterbirchTable) -> MlclusterbirchTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusterbirchTable::fill(self : MlclusterbirchTable, v : Double) -> MlclusterbirchTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusterbirchTable::min(self : MlclusterbirchTable) -> Double { @_common.min(self.data) }

pub fn MlclusterbirchTable::max(self : MlclusterbirchTable) -> Double { @_common.max(self.data) }

pub fn MlclusterbirchTable::to_string(self : MlclusterbirchTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusterbirchGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_birch_graphn_make(size : Int) -> MlclusterbirchGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusterbirchGraphN::len(self : MlclusterbirchGraphN) -> Int { self.size }

pub fn MlclusterbirchGraphN::get(self : MlclusterbirchGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusterbirchGraphN::set(self : MlclusterbirchGraphN, i : Int, v : Double) -> MlclusterbirchGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusterbirchGraphN::sum(self : MlclusterbirchGraphN) -> Double { @_common.sum(self.data) }

pub fn MlclusterbirchGraphN::mean(self : MlclusterbirchGraphN) -> Double { @_common.mean(self.data) }

pub fn MlclusterbirchGraphN::scale(self : MlclusterbirchGraphN, f : Double) -> MlclusterbirchGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusterbirchGraphN::add(self : MlclusterbirchGraphN, other : MlclusterbirchGraphN) -> MlclusterbirchGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusterbirchGraphN::copy(self : MlclusterbirchGraphN) -> MlclusterbirchGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusterbirchGraphN::fill(self : MlclusterbirchGraphN, v : Double) -> MlclusterbirchGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusterbirchGraphN::min(self : MlclusterbirchGraphN) -> Double { @_common.min(self.data) }

pub fn MlclusterbirchGraphN::max(self : MlclusterbirchGraphN) -> Double { @_common.max(self.data) }

pub fn MlclusterbirchGraphN::to_string(self : MlclusterbirchGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusterbirchNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_birch_node_make(size : Int) -> MlclusterbirchNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusterbirchNode::len(self : MlclusterbirchNode) -> Int { self.size }

pub fn MlclusterbirchNode::get(self : MlclusterbirchNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusterbirchNode::set(self : MlclusterbirchNode, i : Int, v : Double) -> MlclusterbirchNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusterbirchNode::sum(self : MlclusterbirchNode) -> Double { @_common.sum(self.data) }

pub fn MlclusterbirchNode::mean(self : MlclusterbirchNode) -> Double { @_common.mean(self.data) }

pub fn MlclusterbirchNode::scale(self : MlclusterbirchNode, f : Double) -> MlclusterbirchNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusterbirchNode::add(self : MlclusterbirchNode, other : MlclusterbirchNode) -> MlclusterbirchNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusterbirchNode::copy(self : MlclusterbirchNode) -> MlclusterbirchNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusterbirchNode::fill(self : MlclusterbirchNode, v : Double) -> MlclusterbirchNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusterbirchNode::min(self : MlclusterbirchNode) -> Double { @_common.min(self.data) }

pub fn MlclusterbirchNode::max(self : MlclusterbirchNode) -> Double { @_common.max(self.data) }

pub fn MlclusterbirchNode::to_string(self : MlclusterbirchNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusterbirchEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_birch_edge_make(size : Int) -> MlclusterbirchEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusterbirchEdge::len(self : MlclusterbirchEdge) -> Int { self.size }

pub fn MlclusterbirchEdge::get(self : MlclusterbirchEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusterbirchEdge::set(self : MlclusterbirchEdge, i : Int, v : Double) -> MlclusterbirchEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusterbirchEdge::sum(self : MlclusterbirchEdge) -> Double { @_common.sum(self.data) }

pub fn MlclusterbirchEdge::mean(self : MlclusterbirchEdge) -> Double { @_common.mean(self.data) }

pub fn MlclusterbirchEdge::scale(self : MlclusterbirchEdge, f : Double) -> MlclusterbirchEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusterbirchEdge::add(self : MlclusterbirchEdge, other : MlclusterbirchEdge) -> MlclusterbirchEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusterbirchEdge::copy(self : MlclusterbirchEdge) -> MlclusterbirchEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusterbirchEdge::fill(self : MlclusterbirchEdge, v : Double) -> MlclusterbirchEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusterbirchEdge::min(self : MlclusterbirchEdge) -> Double { @_common.min(self.data) }

pub fn MlclusterbirchEdge::max(self : MlclusterbirchEdge) -> Double { @_common.max(self.data) }

pub fn MlclusterbirchEdge::to_string(self : MlclusterbirchEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusterbirchPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_birch_path_make(size : Int) -> MlclusterbirchPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusterbirchPath::len(self : MlclusterbirchPath) -> Int { self.size }

pub fn MlclusterbirchPath::get(self : MlclusterbirchPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusterbirchPath::set(self : MlclusterbirchPath, i : Int, v : Double) -> MlclusterbirchPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusterbirchPath::sum(self : MlclusterbirchPath) -> Double { @_common.sum(self.data) }

pub fn MlclusterbirchPath::mean(self : MlclusterbirchPath) -> Double { @_common.mean(self.data) }

pub fn MlclusterbirchPath::scale(self : MlclusterbirchPath, f : Double) -> MlclusterbirchPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusterbirchPath::add(self : MlclusterbirchPath, other : MlclusterbirchPath) -> MlclusterbirchPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusterbirchPath::copy(self : MlclusterbirchPath) -> MlclusterbirchPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusterbirchPath::fill(self : MlclusterbirchPath, v : Double) -> MlclusterbirchPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusterbirchPath::min(self : MlclusterbirchPath) -> Double { @_common.min(self.data) }

pub fn MlclusterbirchPath::max(self : MlclusterbirchPath) -> Double { @_common.max(self.data) }

pub fn MlclusterbirchPath::to_string(self : MlclusterbirchPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusterbirchCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_birch_cluster_make(size : Int) -> MlclusterbirchCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusterbirchCluster::len(self : MlclusterbirchCluster) -> Int { self.size }

pub fn MlclusterbirchCluster::get(self : MlclusterbirchCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusterbirchCluster::set(self : MlclusterbirchCluster, i : Int, v : Double) -> MlclusterbirchCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusterbirchCluster::sum(self : MlclusterbirchCluster) -> Double { @_common.sum(self.data) }

pub fn MlclusterbirchCluster::mean(self : MlclusterbirchCluster) -> Double { @_common.mean(self.data) }

pub fn MlclusterbirchCluster::scale(self : MlclusterbirchCluster, f : Double) -> MlclusterbirchCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusterbirchCluster::add(self : MlclusterbirchCluster, other : MlclusterbirchCluster) -> MlclusterbirchCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusterbirchCluster::copy(self : MlclusterbirchCluster) -> MlclusterbirchCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusterbirchCluster::fill(self : MlclusterbirchCluster, v : Double) -> MlclusterbirchCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusterbirchCluster::min(self : MlclusterbirchCluster) -> Double { @_common.min(self.data) }

pub fn MlclusterbirchCluster::max(self : MlclusterbirchCluster) -> Double { @_common.max(self.data) }

pub fn MlclusterbirchCluster::to_string(self : MlclusterbirchCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusterbirchModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_birch_model_make(size : Int) -> MlclusterbirchModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusterbirchModel::len(self : MlclusterbirchModel) -> Int { self.size }

pub fn MlclusterbirchModel::get(self : MlclusterbirchModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusterbirchModel::set(self : MlclusterbirchModel, i : Int, v : Double) -> MlclusterbirchModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusterbirchModel::sum(self : MlclusterbirchModel) -> Double { @_common.sum(self.data) }

pub fn MlclusterbirchModel::mean(self : MlclusterbirchModel) -> Double { @_common.mean(self.data) }

pub fn MlclusterbirchModel::scale(self : MlclusterbirchModel, f : Double) -> MlclusterbirchModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusterbirchModel::add(self : MlclusterbirchModel, other : MlclusterbirchModel) -> MlclusterbirchModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusterbirchModel::copy(self : MlclusterbirchModel) -> MlclusterbirchModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusterbirchModel::fill(self : MlclusterbirchModel, v : Double) -> MlclusterbirchModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusterbirchModel::min(self : MlclusterbirchModel) -> Double { @_common.min(self.data) }

pub fn MlclusterbirchModel::max(self : MlclusterbirchModel) -> Double { @_common.max(self.data) }

pub fn MlclusterbirchModel::to_string(self : MlclusterbirchModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusterbirchLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_birch_layer_make(size : Int) -> MlclusterbirchLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusterbirchLayer::len(self : MlclusterbirchLayer) -> Int { self.size }

pub fn MlclusterbirchLayer::get(self : MlclusterbirchLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusterbirchLayer::set(self : MlclusterbirchLayer, i : Int, v : Double) -> MlclusterbirchLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusterbirchLayer::sum(self : MlclusterbirchLayer) -> Double { @_common.sum(self.data) }

pub fn MlclusterbirchLayer::mean(self : MlclusterbirchLayer) -> Double { @_common.mean(self.data) }

pub fn MlclusterbirchLayer::scale(self : MlclusterbirchLayer, f : Double) -> MlclusterbirchLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusterbirchLayer::add(self : MlclusterbirchLayer, other : MlclusterbirchLayer) -> MlclusterbirchLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusterbirchLayer::copy(self : MlclusterbirchLayer) -> MlclusterbirchLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusterbirchLayer::fill(self : MlclusterbirchLayer, v : Double) -> MlclusterbirchLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusterbirchLayer::min(self : MlclusterbirchLayer) -> Double { @_common.min(self.data) }

pub fn MlclusterbirchLayer::max(self : MlclusterbirchLayer) -> Double { @_common.max(self.data) }

pub fn MlclusterbirchLayer::to_string(self : MlclusterbirchLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusterbirchBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_birch_buffer_make(size : Int) -> MlclusterbirchBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusterbirchBuffer::len(self : MlclusterbirchBuffer) -> Int { self.size }

pub fn MlclusterbirchBuffer::get(self : MlclusterbirchBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusterbirchBuffer::set(self : MlclusterbirchBuffer, i : Int, v : Double) -> MlclusterbirchBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusterbirchBuffer::sum(self : MlclusterbirchBuffer) -> Double { @_common.sum(self.data) }

pub fn MlclusterbirchBuffer::mean(self : MlclusterbirchBuffer) -> Double { @_common.mean(self.data) }

pub fn MlclusterbirchBuffer::scale(self : MlclusterbirchBuffer, f : Double) -> MlclusterbirchBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusterbirchBuffer::add(self : MlclusterbirchBuffer, other : MlclusterbirchBuffer) -> MlclusterbirchBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusterbirchBuffer::copy(self : MlclusterbirchBuffer) -> MlclusterbirchBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusterbirchBuffer::fill(self : MlclusterbirchBuffer, v : Double) -> MlclusterbirchBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusterbirchBuffer::min(self : MlclusterbirchBuffer) -> Double { @_common.min(self.data) }

pub fn MlclusterbirchBuffer::max(self : MlclusterbirchBuffer) -> Double { @_common.max(self.data) }

pub fn MlclusterbirchBuffer::to_string(self : MlclusterbirchBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusterbirchCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_birch_cursor_make(size : Int) -> MlclusterbirchCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusterbirchCursor::len(self : MlclusterbirchCursor) -> Int { self.size }

pub fn MlclusterbirchCursor::get(self : MlclusterbirchCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusterbirchCursor::set(self : MlclusterbirchCursor, i : Int, v : Double) -> MlclusterbirchCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusterbirchCursor::sum(self : MlclusterbirchCursor) -> Double { @_common.sum(self.data) }

pub fn MlclusterbirchCursor::mean(self : MlclusterbirchCursor) -> Double { @_common.mean(self.data) }

pub fn MlclusterbirchCursor::scale(self : MlclusterbirchCursor, f : Double) -> MlclusterbirchCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusterbirchCursor::add(self : MlclusterbirchCursor, other : MlclusterbirchCursor) -> MlclusterbirchCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusterbirchCursor::copy(self : MlclusterbirchCursor) -> MlclusterbirchCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusterbirchCursor::fill(self : MlclusterbirchCursor, v : Double) -> MlclusterbirchCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusterbirchCursor::min(self : MlclusterbirchCursor) -> Double { @_common.min(self.data) }

pub fn MlclusterbirchCursor::max(self : MlclusterbirchCursor) -> Double { @_common.max(self.data) }

pub fn MlclusterbirchCursor::to_string(self : MlclusterbirchCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusterbirchView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_birch_view_make(size : Int) -> MlclusterbirchView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusterbirchView::len(self : MlclusterbirchView) -> Int { self.size }

pub fn MlclusterbirchView::get(self : MlclusterbirchView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusterbirchView::set(self : MlclusterbirchView, i : Int, v : Double) -> MlclusterbirchView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusterbirchView::sum(self : MlclusterbirchView) -> Double { @_common.sum(self.data) }

pub fn MlclusterbirchView::mean(self : MlclusterbirchView) -> Double { @_common.mean(self.data) }

pub fn MlclusterbirchView::scale(self : MlclusterbirchView, f : Double) -> MlclusterbirchView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusterbirchView::add(self : MlclusterbirchView, other : MlclusterbirchView) -> MlclusterbirchView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusterbirchView::copy(self : MlclusterbirchView) -> MlclusterbirchView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusterbirchView::fill(self : MlclusterbirchView, v : Double) -> MlclusterbirchView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusterbirchView::min(self : MlclusterbirchView) -> Double { @_common.min(self.data) }

pub fn MlclusterbirchView::max(self : MlclusterbirchView) -> Double { @_common.max(self.data) }

pub fn MlclusterbirchView::to_string(self : MlclusterbirchView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusterbirchRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_birch_range_make(size : Int) -> MlclusterbirchRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusterbirchRange::len(self : MlclusterbirchRange) -> Int { self.size }

pub fn MlclusterbirchRange::get(self : MlclusterbirchRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusterbirchRange::set(self : MlclusterbirchRange, i : Int, v : Double) -> MlclusterbirchRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusterbirchRange::sum(self : MlclusterbirchRange) -> Double { @_common.sum(self.data) }

pub fn MlclusterbirchRange::mean(self : MlclusterbirchRange) -> Double { @_common.mean(self.data) }

pub fn MlclusterbirchRange::scale(self : MlclusterbirchRange, f : Double) -> MlclusterbirchRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusterbirchRange::add(self : MlclusterbirchRange, other : MlclusterbirchRange) -> MlclusterbirchRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusterbirchRange::copy(self : MlclusterbirchRange) -> MlclusterbirchRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusterbirchRange::fill(self : MlclusterbirchRange, v : Double) -> MlclusterbirchRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusterbirchRange::min(self : MlclusterbirchRange) -> Double { @_common.min(self.data) }

pub fn MlclusterbirchRange::max(self : MlclusterbirchRange) -> Double { @_common.max(self.data) }

pub fn MlclusterbirchRange::to_string(self : MlclusterbirchRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlclusterbirchSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_birch_slice_make(size : Int) -> MlclusterbirchSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlclusterbirchSlice::len(self : MlclusterbirchSlice) -> Int { self.size }

pub fn MlclusterbirchSlice::get(self : MlclusterbirchSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlclusterbirchSlice::set(self : MlclusterbirchSlice, i : Int, v : Double) -> MlclusterbirchSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlclusterbirchSlice::sum(self : MlclusterbirchSlice) -> Double { @_common.sum(self.data) }

pub fn MlclusterbirchSlice::mean(self : MlclusterbirchSlice) -> Double { @_common.mean(self.data) }

pub fn MlclusterbirchSlice::scale(self : MlclusterbirchSlice, f : Double) -> MlclusterbirchSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlclusterbirchSlice::add(self : MlclusterbirchSlice, other : MlclusterbirchSlice) -> MlclusterbirchSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlclusterbirchSlice::copy(self : MlclusterbirchSlice) -> MlclusterbirchSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlclusterbirchSlice::fill(self : MlclusterbirchSlice, v : Double) -> MlclusterbirchSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlclusterbirchSlice::min(self : MlclusterbirchSlice) -> Double { @_common.min(self.data) }

pub fn MlclusterbirchSlice::max(self : MlclusterbirchSlice) -> Double { @_common.max(self.data) }

pub fn MlclusterbirchSlice::to_string(self : MlclusterbirchSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

