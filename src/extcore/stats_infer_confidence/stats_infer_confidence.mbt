///===
/// extcore/stats_infer_confidence

pub(all) struct StatsinferconfidencePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_infer_confidence_make_point(x : Double, y : Double) -> StatsinferconfidencePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_infer_confidence_make_point3(x : Double, y : Double, z : Double) -> StatsinferconfidencePoint {
  { x, y, z, label: 0 }
}

pub fn StatsinferconfidencePoint::x(self : StatsinferconfidencePoint) -> Double { self.x }

pub fn StatsinferconfidencePoint::y(self : StatsinferconfidencePoint) -> Double { self.y }

pub fn StatsinferconfidencePoint::z(self : StatsinferconfidencePoint) -> Double { self.z }

pub fn StatsinferconfidencePoint::label(self : StatsinferconfidencePoint) -> Int { self.label }

pub fn StatsinferconfidencePoint::dist(self : StatsinferconfidencePoint, other : StatsinferconfidencePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsinferconfidencePoint::add(self : StatsinferconfidencePoint, other : StatsinferconfidencePoint) -> StatsinferconfidencePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsinferconfidencePoint::sub(self : StatsinferconfidencePoint, other : StatsinferconfidencePoint) -> StatsinferconfidencePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsinferconfidencePoint::scale(self : StatsinferconfidencePoint, s : Double) -> StatsinferconfidencePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsinferconfidencePoint::dot(self : StatsinferconfidencePoint, other : StatsinferconfidencePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsinferconfidencePoint::cross(self : StatsinferconfidencePoint, other : StatsinferconfidencePoint) -> StatsinferconfidencePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsinferconfidencePoint::norm(self : StatsinferconfidencePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsinferconfidencePoint::normalize(self : StatsinferconfidencePoint) -> StatsinferconfidencePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsinferconfidencePoint::negate(self : StatsinferconfidencePoint) -> StatsinferconfidencePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsinferconfidencePoint::mid(self : StatsinferconfidencePoint, other : StatsinferconfidencePoint) -> StatsinferconfidencePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsinferconfidencePoint::lerp(self : StatsinferconfidencePoint, other : StatsinferconfidencePoint, t : Double) -> StatsinferconfidencePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsinferconfidencePoint::to_string(self : StatsinferconfidencePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsinferconfidenceSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_infer_confidence_make_series(vals : Array[Double], name : String) -> StatsinferconfidenceSeries {
  { vals, name, meta: 0 }
}

pub fn StatsinferconfidenceSeries::len(self : StatsinferconfidenceSeries) -> Int { self.vals.length() }

pub fn StatsinferconfidenceSeries::sum(self : StatsinferconfidenceSeries) -> Double { @_common.sum(self.vals) }

pub fn StatsinferconfidenceSeries::mean(self : StatsinferconfidenceSeries) -> Double { @_common.mean(self.vals) }

pub fn StatsinferconfidenceSeries::min(self : StatsinferconfidenceSeries) -> Double { @_common.min(self.vals) }

pub fn StatsinferconfidenceSeries::max(self : StatsinferconfidenceSeries) -> Double { @_common.max(self.vals) }

pub fn StatsinferconfidenceSeries::range(self : StatsinferconfidenceSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsinferconfidenceSeries::variance(self : StatsinferconfidenceSeries) -> Double { @_common.variance(self.vals) }

pub fn StatsinferconfidenceSeries::std(self : StatsinferconfidenceSeries) -> Double { @_common.std(self.vals) }

pub fn StatsinferconfidenceSeries::median(self : StatsinferconfidenceSeries) -> Double { @_common.median(self.vals) }

pub fn StatsinferconfidenceSeries::scale(self : StatsinferconfidenceSeries, f : Double) -> StatsinferconfidenceSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsinferconfidenceSeries::add(self : StatsinferconfidenceSeries, other : StatsinferconfidenceSeries) -> StatsinferconfidenceSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsinferconfidenceSeries::sub(self : StatsinferconfidenceSeries, other : StatsinferconfidenceSeries) -> StatsinferconfidenceSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsinferconfidenceSeries::normalize(self : StatsinferconfidenceSeries) -> StatsinferconfidenceSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsinferconfidenceSeries::cumsum(self : StatsinferconfidenceSeries) -> StatsinferconfidenceSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsinferconfidenceSeries::to_string(self : StatsinferconfidenceSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsinferconfidenceMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_infer_confidence_make_matrix(rows : Int, cols : Int, val : Double) -> StatsinferconfidenceMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_infer_confidence_matrix_identity(n : Int) -> StatsinferconfidenceMatrix {
  let m = stats_infer_confidence_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsinferconfidenceMatrix::get(self : StatsinferconfidenceMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsinferconfidenceMatrix::transpose(self : StatsinferconfidenceMatrix) -> StatsinferconfidenceMatrix {
  let result = stats_infer_confidence_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsinferconfidenceMatrix::add(self : StatsinferconfidenceMatrix, other : StatsinferconfidenceMatrix) -> StatsinferconfidenceMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_infer_confidence_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsinferconfidenceMatrix::scale(self : StatsinferconfidenceMatrix, s : Double) -> StatsinferconfidenceMatrix {
  let result = stats_infer_confidence_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsinferconfidenceMatrix::multiply(self : StatsinferconfidenceMatrix, other : StatsinferconfidenceMatrix) -> StatsinferconfidenceMatrix {
  if self.cols != other.rows { return stats_infer_confidence_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_infer_confidence_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn StatsinferconfidenceMatrix::trace(self : StatsinferconfidenceMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsinferconfidenceMatrix::det(self : StatsinferconfidenceMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsinferconfidenceMatrix::norm(self : StatsinferconfidenceMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsinferconfidenceMatrix::to_string(self : StatsinferconfidenceMatrix) -> String {
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

pub(all) struct StatsinferconfidenceVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_infer_confidence_make_vector(comps : Array[Double]) -> StatsinferconfidenceVector {
  { comps, dim: comps.length() }
}

pub fn stats_infer_confidence_vector_zero(dim : Int) -> StatsinferconfidenceVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsinferconfidenceVector::add(self : StatsinferconfidenceVector, other : StatsinferconfidenceVector) -> StatsinferconfidenceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsinferconfidenceVector::sub(self : StatsinferconfidenceVector, other : StatsinferconfidenceVector) -> StatsinferconfidenceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsinferconfidenceVector::scale(self : StatsinferconfidenceVector, s : Double) -> StatsinferconfidenceVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsinferconfidenceVector::dot(self : StatsinferconfidenceVector, other : StatsinferconfidenceVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsinferconfidenceVector::norm(self : StatsinferconfidenceVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsinferconfidenceVector::normalize(self : StatsinferconfidenceVector) -> StatsinferconfidenceVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsinferconfidenceVector::dist(self : StatsinferconfidenceVector, other : StatsinferconfidenceVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsinferconfidenceVector::to_string(self : StatsinferconfidenceVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsinferconfidenceFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_confidence_frame_make(size : Int) -> StatsinferconfidenceFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferconfidenceFrame::len(self : StatsinferconfidenceFrame) -> Int { self.size }

pub fn StatsinferconfidenceFrame::get(self : StatsinferconfidenceFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferconfidenceFrame::set(self : StatsinferconfidenceFrame, i : Int, v : Double) -> StatsinferconfidenceFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceFrame::sum(self : StatsinferconfidenceFrame) -> Double { @_common.sum(self.data) }

pub fn StatsinferconfidenceFrame::mean(self : StatsinferconfidenceFrame) -> Double { @_common.mean(self.data) }

pub fn StatsinferconfidenceFrame::scale(self : StatsinferconfidenceFrame, f : Double) -> StatsinferconfidenceFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceFrame::add(self : StatsinferconfidenceFrame, other : StatsinferconfidenceFrame) -> StatsinferconfidenceFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferconfidenceFrame::copy(self : StatsinferconfidenceFrame) -> StatsinferconfidenceFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceFrame::fill(self : StatsinferconfidenceFrame, v : Double) -> StatsinferconfidenceFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceFrame::min(self : StatsinferconfidenceFrame) -> Double { @_common.min(self.data) }

pub fn StatsinferconfidenceFrame::max(self : StatsinferconfidenceFrame) -> Double { @_common.max(self.data) }

pub fn StatsinferconfidenceFrame::to_string(self : StatsinferconfidenceFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferconfidenceTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_confidence_table_make(size : Int) -> StatsinferconfidenceTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferconfidenceTable::len(self : StatsinferconfidenceTable) -> Int { self.size }

pub fn StatsinferconfidenceTable::get(self : StatsinferconfidenceTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferconfidenceTable::set(self : StatsinferconfidenceTable, i : Int, v : Double) -> StatsinferconfidenceTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceTable::sum(self : StatsinferconfidenceTable) -> Double { @_common.sum(self.data) }

pub fn StatsinferconfidenceTable::mean(self : StatsinferconfidenceTable) -> Double { @_common.mean(self.data) }

pub fn StatsinferconfidenceTable::scale(self : StatsinferconfidenceTable, f : Double) -> StatsinferconfidenceTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceTable::add(self : StatsinferconfidenceTable, other : StatsinferconfidenceTable) -> StatsinferconfidenceTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferconfidenceTable::copy(self : StatsinferconfidenceTable) -> StatsinferconfidenceTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceTable::fill(self : StatsinferconfidenceTable, v : Double) -> StatsinferconfidenceTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceTable::min(self : StatsinferconfidenceTable) -> Double { @_common.min(self.data) }

pub fn StatsinferconfidenceTable::max(self : StatsinferconfidenceTable) -> Double { @_common.max(self.data) }

pub fn StatsinferconfidenceTable::to_string(self : StatsinferconfidenceTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferconfidenceGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_confidence_graphn_make(size : Int) -> StatsinferconfidenceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferconfidenceGraphN::len(self : StatsinferconfidenceGraphN) -> Int { self.size }

pub fn StatsinferconfidenceGraphN::get(self : StatsinferconfidenceGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferconfidenceGraphN::set(self : StatsinferconfidenceGraphN, i : Int, v : Double) -> StatsinferconfidenceGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceGraphN::sum(self : StatsinferconfidenceGraphN) -> Double { @_common.sum(self.data) }

pub fn StatsinferconfidenceGraphN::mean(self : StatsinferconfidenceGraphN) -> Double { @_common.mean(self.data) }

pub fn StatsinferconfidenceGraphN::scale(self : StatsinferconfidenceGraphN, f : Double) -> StatsinferconfidenceGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceGraphN::add(self : StatsinferconfidenceGraphN, other : StatsinferconfidenceGraphN) -> StatsinferconfidenceGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferconfidenceGraphN::copy(self : StatsinferconfidenceGraphN) -> StatsinferconfidenceGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceGraphN::fill(self : StatsinferconfidenceGraphN, v : Double) -> StatsinferconfidenceGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceGraphN::min(self : StatsinferconfidenceGraphN) -> Double { @_common.min(self.data) }

pub fn StatsinferconfidenceGraphN::max(self : StatsinferconfidenceGraphN) -> Double { @_common.max(self.data) }

pub fn StatsinferconfidenceGraphN::to_string(self : StatsinferconfidenceGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferconfidenceNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_confidence_node_make(size : Int) -> StatsinferconfidenceNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferconfidenceNode::len(self : StatsinferconfidenceNode) -> Int { self.size }

pub fn StatsinferconfidenceNode::get(self : StatsinferconfidenceNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferconfidenceNode::set(self : StatsinferconfidenceNode, i : Int, v : Double) -> StatsinferconfidenceNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceNode::sum(self : StatsinferconfidenceNode) -> Double { @_common.sum(self.data) }

pub fn StatsinferconfidenceNode::mean(self : StatsinferconfidenceNode) -> Double { @_common.mean(self.data) }

pub fn StatsinferconfidenceNode::scale(self : StatsinferconfidenceNode, f : Double) -> StatsinferconfidenceNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceNode::add(self : StatsinferconfidenceNode, other : StatsinferconfidenceNode) -> StatsinferconfidenceNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferconfidenceNode::copy(self : StatsinferconfidenceNode) -> StatsinferconfidenceNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceNode::fill(self : StatsinferconfidenceNode, v : Double) -> StatsinferconfidenceNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceNode::min(self : StatsinferconfidenceNode) -> Double { @_common.min(self.data) }

pub fn StatsinferconfidenceNode::max(self : StatsinferconfidenceNode) -> Double { @_common.max(self.data) }

pub fn StatsinferconfidenceNode::to_string(self : StatsinferconfidenceNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferconfidenceEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_confidence_edge_make(size : Int) -> StatsinferconfidenceEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferconfidenceEdge::len(self : StatsinferconfidenceEdge) -> Int { self.size }

pub fn StatsinferconfidenceEdge::get(self : StatsinferconfidenceEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferconfidenceEdge::set(self : StatsinferconfidenceEdge, i : Int, v : Double) -> StatsinferconfidenceEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceEdge::sum(self : StatsinferconfidenceEdge) -> Double { @_common.sum(self.data) }

pub fn StatsinferconfidenceEdge::mean(self : StatsinferconfidenceEdge) -> Double { @_common.mean(self.data) }

pub fn StatsinferconfidenceEdge::scale(self : StatsinferconfidenceEdge, f : Double) -> StatsinferconfidenceEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceEdge::add(self : StatsinferconfidenceEdge, other : StatsinferconfidenceEdge) -> StatsinferconfidenceEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferconfidenceEdge::copy(self : StatsinferconfidenceEdge) -> StatsinferconfidenceEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceEdge::fill(self : StatsinferconfidenceEdge, v : Double) -> StatsinferconfidenceEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceEdge::min(self : StatsinferconfidenceEdge) -> Double { @_common.min(self.data) }

pub fn StatsinferconfidenceEdge::max(self : StatsinferconfidenceEdge) -> Double { @_common.max(self.data) }

pub fn StatsinferconfidenceEdge::to_string(self : StatsinferconfidenceEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferconfidencePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_confidence_path_make(size : Int) -> StatsinferconfidencePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferconfidencePath::len(self : StatsinferconfidencePath) -> Int { self.size }

pub fn StatsinferconfidencePath::get(self : StatsinferconfidencePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferconfidencePath::set(self : StatsinferconfidencePath, i : Int, v : Double) -> StatsinferconfidencePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferconfidencePath::sum(self : StatsinferconfidencePath) -> Double { @_common.sum(self.data) }

pub fn StatsinferconfidencePath::mean(self : StatsinferconfidencePath) -> Double { @_common.mean(self.data) }

pub fn StatsinferconfidencePath::scale(self : StatsinferconfidencePath, f : Double) -> StatsinferconfidencePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferconfidencePath::add(self : StatsinferconfidencePath, other : StatsinferconfidencePath) -> StatsinferconfidencePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferconfidencePath::copy(self : StatsinferconfidencePath) -> StatsinferconfidencePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferconfidencePath::fill(self : StatsinferconfidencePath, v : Double) -> StatsinferconfidencePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferconfidencePath::min(self : StatsinferconfidencePath) -> Double { @_common.min(self.data) }

pub fn StatsinferconfidencePath::max(self : StatsinferconfidencePath) -> Double { @_common.max(self.data) }

pub fn StatsinferconfidencePath::to_string(self : StatsinferconfidencePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferconfidenceCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_confidence_cluster_make(size : Int) -> StatsinferconfidenceCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferconfidenceCluster::len(self : StatsinferconfidenceCluster) -> Int { self.size }

pub fn StatsinferconfidenceCluster::get(self : StatsinferconfidenceCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferconfidenceCluster::set(self : StatsinferconfidenceCluster, i : Int, v : Double) -> StatsinferconfidenceCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceCluster::sum(self : StatsinferconfidenceCluster) -> Double { @_common.sum(self.data) }

pub fn StatsinferconfidenceCluster::mean(self : StatsinferconfidenceCluster) -> Double { @_common.mean(self.data) }

pub fn StatsinferconfidenceCluster::scale(self : StatsinferconfidenceCluster, f : Double) -> StatsinferconfidenceCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceCluster::add(self : StatsinferconfidenceCluster, other : StatsinferconfidenceCluster) -> StatsinferconfidenceCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferconfidenceCluster::copy(self : StatsinferconfidenceCluster) -> StatsinferconfidenceCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceCluster::fill(self : StatsinferconfidenceCluster, v : Double) -> StatsinferconfidenceCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceCluster::min(self : StatsinferconfidenceCluster) -> Double { @_common.min(self.data) }

pub fn StatsinferconfidenceCluster::max(self : StatsinferconfidenceCluster) -> Double { @_common.max(self.data) }

pub fn StatsinferconfidenceCluster::to_string(self : StatsinferconfidenceCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferconfidenceModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_confidence_model_make(size : Int) -> StatsinferconfidenceModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferconfidenceModel::len(self : StatsinferconfidenceModel) -> Int { self.size }

pub fn StatsinferconfidenceModel::get(self : StatsinferconfidenceModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferconfidenceModel::set(self : StatsinferconfidenceModel, i : Int, v : Double) -> StatsinferconfidenceModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceModel::sum(self : StatsinferconfidenceModel) -> Double { @_common.sum(self.data) }

pub fn StatsinferconfidenceModel::mean(self : StatsinferconfidenceModel) -> Double { @_common.mean(self.data) }

pub fn StatsinferconfidenceModel::scale(self : StatsinferconfidenceModel, f : Double) -> StatsinferconfidenceModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceModel::add(self : StatsinferconfidenceModel, other : StatsinferconfidenceModel) -> StatsinferconfidenceModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferconfidenceModel::copy(self : StatsinferconfidenceModel) -> StatsinferconfidenceModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceModel::fill(self : StatsinferconfidenceModel, v : Double) -> StatsinferconfidenceModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceModel::min(self : StatsinferconfidenceModel) -> Double { @_common.min(self.data) }

pub fn StatsinferconfidenceModel::max(self : StatsinferconfidenceModel) -> Double { @_common.max(self.data) }

pub fn StatsinferconfidenceModel::to_string(self : StatsinferconfidenceModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferconfidenceLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_confidence_layer_make(size : Int) -> StatsinferconfidenceLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferconfidenceLayer::len(self : StatsinferconfidenceLayer) -> Int { self.size }

pub fn StatsinferconfidenceLayer::get(self : StatsinferconfidenceLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferconfidenceLayer::set(self : StatsinferconfidenceLayer, i : Int, v : Double) -> StatsinferconfidenceLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceLayer::sum(self : StatsinferconfidenceLayer) -> Double { @_common.sum(self.data) }

pub fn StatsinferconfidenceLayer::mean(self : StatsinferconfidenceLayer) -> Double { @_common.mean(self.data) }

pub fn StatsinferconfidenceLayer::scale(self : StatsinferconfidenceLayer, f : Double) -> StatsinferconfidenceLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceLayer::add(self : StatsinferconfidenceLayer, other : StatsinferconfidenceLayer) -> StatsinferconfidenceLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferconfidenceLayer::copy(self : StatsinferconfidenceLayer) -> StatsinferconfidenceLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceLayer::fill(self : StatsinferconfidenceLayer, v : Double) -> StatsinferconfidenceLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceLayer::min(self : StatsinferconfidenceLayer) -> Double { @_common.min(self.data) }

pub fn StatsinferconfidenceLayer::max(self : StatsinferconfidenceLayer) -> Double { @_common.max(self.data) }

pub fn StatsinferconfidenceLayer::to_string(self : StatsinferconfidenceLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferconfidenceBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_confidence_buffer_make(size : Int) -> StatsinferconfidenceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferconfidenceBuffer::len(self : StatsinferconfidenceBuffer) -> Int { self.size }

pub fn StatsinferconfidenceBuffer::get(self : StatsinferconfidenceBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferconfidenceBuffer::set(self : StatsinferconfidenceBuffer, i : Int, v : Double) -> StatsinferconfidenceBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceBuffer::sum(self : StatsinferconfidenceBuffer) -> Double { @_common.sum(self.data) }

pub fn StatsinferconfidenceBuffer::mean(self : StatsinferconfidenceBuffer) -> Double { @_common.mean(self.data) }

pub fn StatsinferconfidenceBuffer::scale(self : StatsinferconfidenceBuffer, f : Double) -> StatsinferconfidenceBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceBuffer::add(self : StatsinferconfidenceBuffer, other : StatsinferconfidenceBuffer) -> StatsinferconfidenceBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferconfidenceBuffer::copy(self : StatsinferconfidenceBuffer) -> StatsinferconfidenceBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceBuffer::fill(self : StatsinferconfidenceBuffer, v : Double) -> StatsinferconfidenceBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceBuffer::min(self : StatsinferconfidenceBuffer) -> Double { @_common.min(self.data) }

pub fn StatsinferconfidenceBuffer::max(self : StatsinferconfidenceBuffer) -> Double { @_common.max(self.data) }

pub fn StatsinferconfidenceBuffer::to_string(self : StatsinferconfidenceBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferconfidenceCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_confidence_cursor_make(size : Int) -> StatsinferconfidenceCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferconfidenceCursor::len(self : StatsinferconfidenceCursor) -> Int { self.size }

pub fn StatsinferconfidenceCursor::get(self : StatsinferconfidenceCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferconfidenceCursor::set(self : StatsinferconfidenceCursor, i : Int, v : Double) -> StatsinferconfidenceCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceCursor::sum(self : StatsinferconfidenceCursor) -> Double { @_common.sum(self.data) }

pub fn StatsinferconfidenceCursor::mean(self : StatsinferconfidenceCursor) -> Double { @_common.mean(self.data) }

pub fn StatsinferconfidenceCursor::scale(self : StatsinferconfidenceCursor, f : Double) -> StatsinferconfidenceCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceCursor::add(self : StatsinferconfidenceCursor, other : StatsinferconfidenceCursor) -> StatsinferconfidenceCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferconfidenceCursor::copy(self : StatsinferconfidenceCursor) -> StatsinferconfidenceCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceCursor::fill(self : StatsinferconfidenceCursor, v : Double) -> StatsinferconfidenceCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceCursor::min(self : StatsinferconfidenceCursor) -> Double { @_common.min(self.data) }

pub fn StatsinferconfidenceCursor::max(self : StatsinferconfidenceCursor) -> Double { @_common.max(self.data) }

pub fn StatsinferconfidenceCursor::to_string(self : StatsinferconfidenceCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferconfidenceView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_confidence_view_make(size : Int) -> StatsinferconfidenceView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferconfidenceView::len(self : StatsinferconfidenceView) -> Int { self.size }

pub fn StatsinferconfidenceView::get(self : StatsinferconfidenceView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferconfidenceView::set(self : StatsinferconfidenceView, i : Int, v : Double) -> StatsinferconfidenceView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceView::sum(self : StatsinferconfidenceView) -> Double { @_common.sum(self.data) }

pub fn StatsinferconfidenceView::mean(self : StatsinferconfidenceView) -> Double { @_common.mean(self.data) }

pub fn StatsinferconfidenceView::scale(self : StatsinferconfidenceView, f : Double) -> StatsinferconfidenceView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceView::add(self : StatsinferconfidenceView, other : StatsinferconfidenceView) -> StatsinferconfidenceView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferconfidenceView::copy(self : StatsinferconfidenceView) -> StatsinferconfidenceView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceView::fill(self : StatsinferconfidenceView, v : Double) -> StatsinferconfidenceView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceView::min(self : StatsinferconfidenceView) -> Double { @_common.min(self.data) }

pub fn StatsinferconfidenceView::max(self : StatsinferconfidenceView) -> Double { @_common.max(self.data) }

pub fn StatsinferconfidenceView::to_string(self : StatsinferconfidenceView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferconfidenceRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_confidence_range_make(size : Int) -> StatsinferconfidenceRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferconfidenceRange::len(self : StatsinferconfidenceRange) -> Int { self.size }

pub fn StatsinferconfidenceRange::get(self : StatsinferconfidenceRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferconfidenceRange::set(self : StatsinferconfidenceRange, i : Int, v : Double) -> StatsinferconfidenceRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceRange::sum(self : StatsinferconfidenceRange) -> Double { @_common.sum(self.data) }

pub fn StatsinferconfidenceRange::mean(self : StatsinferconfidenceRange) -> Double { @_common.mean(self.data) }

pub fn StatsinferconfidenceRange::scale(self : StatsinferconfidenceRange, f : Double) -> StatsinferconfidenceRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceRange::add(self : StatsinferconfidenceRange, other : StatsinferconfidenceRange) -> StatsinferconfidenceRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferconfidenceRange::copy(self : StatsinferconfidenceRange) -> StatsinferconfidenceRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceRange::fill(self : StatsinferconfidenceRange, v : Double) -> StatsinferconfidenceRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceRange::min(self : StatsinferconfidenceRange) -> Double { @_common.min(self.data) }

pub fn StatsinferconfidenceRange::max(self : StatsinferconfidenceRange) -> Double { @_common.max(self.data) }

pub fn StatsinferconfidenceRange::to_string(self : StatsinferconfidenceRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferconfidenceSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_confidence_slice_make(size : Int) -> StatsinferconfidenceSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferconfidenceSlice::len(self : StatsinferconfidenceSlice) -> Int { self.size }

pub fn StatsinferconfidenceSlice::get(self : StatsinferconfidenceSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferconfidenceSlice::set(self : StatsinferconfidenceSlice, i : Int, v : Double) -> StatsinferconfidenceSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceSlice::sum(self : StatsinferconfidenceSlice) -> Double { @_common.sum(self.data) }

pub fn StatsinferconfidenceSlice::mean(self : StatsinferconfidenceSlice) -> Double { @_common.mean(self.data) }

pub fn StatsinferconfidenceSlice::scale(self : StatsinferconfidenceSlice, f : Double) -> StatsinferconfidenceSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceSlice::add(self : StatsinferconfidenceSlice, other : StatsinferconfidenceSlice) -> StatsinferconfidenceSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferconfidenceSlice::copy(self : StatsinferconfidenceSlice) -> StatsinferconfidenceSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceSlice::fill(self : StatsinferconfidenceSlice, v : Double) -> StatsinferconfidenceSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferconfidenceSlice::min(self : StatsinferconfidenceSlice) -> Double { @_common.min(self.data) }

pub fn StatsinferconfidenceSlice::max(self : StatsinferconfidenceSlice) -> Double { @_common.max(self.data) }

pub fn StatsinferconfidenceSlice::to_string(self : StatsinferconfidenceSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

