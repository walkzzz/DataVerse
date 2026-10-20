///===
/// extcore/graph_flow_stable_marriage

pub(all) struct GraphflowstablemarriagePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_flow_stable_marriage_make_point(x : Double, y : Double) -> GraphflowstablemarriagePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_flow_stable_marriage_make_point3(x : Double, y : Double, z : Double) -> GraphflowstablemarriagePoint {
  { x, y, z, label: 0 }
}

pub fn GraphflowstablemarriagePoint::x(self : GraphflowstablemarriagePoint) -> Double { self.x }

pub fn GraphflowstablemarriagePoint::y(self : GraphflowstablemarriagePoint) -> Double { self.y }

pub fn GraphflowstablemarriagePoint::z(self : GraphflowstablemarriagePoint) -> Double { self.z }

pub fn GraphflowstablemarriagePoint::label(self : GraphflowstablemarriagePoint) -> Int { self.label }

pub fn GraphflowstablemarriagePoint::dist(self : GraphflowstablemarriagePoint, other : GraphflowstablemarriagePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphflowstablemarriagePoint::add(self : GraphflowstablemarriagePoint, other : GraphflowstablemarriagePoint) -> GraphflowstablemarriagePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphflowstablemarriagePoint::sub(self : GraphflowstablemarriagePoint, other : GraphflowstablemarriagePoint) -> GraphflowstablemarriagePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphflowstablemarriagePoint::scale(self : GraphflowstablemarriagePoint, s : Double) -> GraphflowstablemarriagePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphflowstablemarriagePoint::dot(self : GraphflowstablemarriagePoint, other : GraphflowstablemarriagePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphflowstablemarriagePoint::cross(self : GraphflowstablemarriagePoint, other : GraphflowstablemarriagePoint) -> GraphflowstablemarriagePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphflowstablemarriagePoint::norm(self : GraphflowstablemarriagePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphflowstablemarriagePoint::normalize(self : GraphflowstablemarriagePoint) -> GraphflowstablemarriagePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphflowstablemarriagePoint::negate(self : GraphflowstablemarriagePoint) -> GraphflowstablemarriagePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphflowstablemarriagePoint::mid(self : GraphflowstablemarriagePoint, other : GraphflowstablemarriagePoint) -> GraphflowstablemarriagePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphflowstablemarriagePoint::lerp(self : GraphflowstablemarriagePoint, other : GraphflowstablemarriagePoint, t : Double) -> GraphflowstablemarriagePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphflowstablemarriagePoint::to_string(self : GraphflowstablemarriagePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphflowstablemarriageSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_flow_stable_marriage_make_series(vals : Array[Double], name : String) -> GraphflowstablemarriageSeries {
  { vals, name, meta: 0 }
}

pub fn GraphflowstablemarriageSeries::len(self : GraphflowstablemarriageSeries) -> Int { self.vals.length() }

pub fn GraphflowstablemarriageSeries::sum(self : GraphflowstablemarriageSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphflowstablemarriageSeries::mean(self : GraphflowstablemarriageSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphflowstablemarriageSeries::min(self : GraphflowstablemarriageSeries) -> Double { @_common.min(self.vals) }

pub fn GraphflowstablemarriageSeries::max(self : GraphflowstablemarriageSeries) -> Double { @_common.max(self.vals) }

pub fn GraphflowstablemarriageSeries::range(self : GraphflowstablemarriageSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphflowstablemarriageSeries::variance(self : GraphflowstablemarriageSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphflowstablemarriageSeries::std(self : GraphflowstablemarriageSeries) -> Double { @_common.std(self.vals) }

pub fn GraphflowstablemarriageSeries::median(self : GraphflowstablemarriageSeries) -> Double { @_common.median(self.vals) }

pub fn GraphflowstablemarriageSeries::scale(self : GraphflowstablemarriageSeries, f : Double) -> GraphflowstablemarriageSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphflowstablemarriageSeries::add(self : GraphflowstablemarriageSeries, other : GraphflowstablemarriageSeries) -> GraphflowstablemarriageSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphflowstablemarriageSeries::sub(self : GraphflowstablemarriageSeries, other : GraphflowstablemarriageSeries) -> GraphflowstablemarriageSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphflowstablemarriageSeries::normalize(self : GraphflowstablemarriageSeries) -> GraphflowstablemarriageSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphflowstablemarriageSeries::cumsum(self : GraphflowstablemarriageSeries) -> GraphflowstablemarriageSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphflowstablemarriageSeries::to_string(self : GraphflowstablemarriageSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphflowstablemarriageMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_flow_stable_marriage_make_matrix(rows : Int, cols : Int, val : Double) -> GraphflowstablemarriageMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_flow_stable_marriage_matrix_identity(n : Int) -> GraphflowstablemarriageMatrix {
  let m = graph_flow_stable_marriage_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphflowstablemarriageMatrix::get(self : GraphflowstablemarriageMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphflowstablemarriageMatrix::transpose(self : GraphflowstablemarriageMatrix) -> GraphflowstablemarriageMatrix {
  let result = graph_flow_stable_marriage_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphflowstablemarriageMatrix::add(self : GraphflowstablemarriageMatrix, other : GraphflowstablemarriageMatrix) -> GraphflowstablemarriageMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_flow_stable_marriage_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphflowstablemarriageMatrix::scale(self : GraphflowstablemarriageMatrix, s : Double) -> GraphflowstablemarriageMatrix {
  let result = graph_flow_stable_marriage_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphflowstablemarriageMatrix::multiply(self : GraphflowstablemarriageMatrix, other : GraphflowstablemarriageMatrix) -> GraphflowstablemarriageMatrix {
  if self.cols != other.rows { return graph_flow_stable_marriage_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_flow_stable_marriage_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphflowstablemarriageMatrix::trace(self : GraphflowstablemarriageMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphflowstablemarriageMatrix::det(self : GraphflowstablemarriageMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphflowstablemarriageMatrix::norm(self : GraphflowstablemarriageMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphflowstablemarriageMatrix::to_string(self : GraphflowstablemarriageMatrix) -> String {
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

pub(all) struct GraphflowstablemarriageVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_flow_stable_marriage_make_vector(comps : Array[Double]) -> GraphflowstablemarriageVector {
  { comps, dim: comps.length() }
}

pub fn graph_flow_stable_marriage_vector_zero(dim : Int) -> GraphflowstablemarriageVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphflowstablemarriageVector::add(self : GraphflowstablemarriageVector, other : GraphflowstablemarriageVector) -> GraphflowstablemarriageVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphflowstablemarriageVector::sub(self : GraphflowstablemarriageVector, other : GraphflowstablemarriageVector) -> GraphflowstablemarriageVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphflowstablemarriageVector::scale(self : GraphflowstablemarriageVector, s : Double) -> GraphflowstablemarriageVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphflowstablemarriageVector::dot(self : GraphflowstablemarriageVector, other : GraphflowstablemarriageVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphflowstablemarriageVector::norm(self : GraphflowstablemarriageVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphflowstablemarriageVector::normalize(self : GraphflowstablemarriageVector) -> GraphflowstablemarriageVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphflowstablemarriageVector::dist(self : GraphflowstablemarriageVector, other : GraphflowstablemarriageVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphflowstablemarriageVector::to_string(self : GraphflowstablemarriageVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphflowstablemarriageFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_stable_marriage_frame_make(size : Int) -> GraphflowstablemarriageFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowstablemarriageFrame::len(self : GraphflowstablemarriageFrame) -> Int { self.size }

pub fn GraphflowstablemarriageFrame::get(self : GraphflowstablemarriageFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowstablemarriageFrame::set(self : GraphflowstablemarriageFrame, i : Int, v : Double) -> GraphflowstablemarriageFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageFrame::sum(self : GraphflowstablemarriageFrame) -> Double { @_common.sum(self.data) }

pub fn GraphflowstablemarriageFrame::mean(self : GraphflowstablemarriageFrame) -> Double { @_common.mean(self.data) }

pub fn GraphflowstablemarriageFrame::scale(self : GraphflowstablemarriageFrame, f : Double) -> GraphflowstablemarriageFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageFrame::add(self : GraphflowstablemarriageFrame, other : GraphflowstablemarriageFrame) -> GraphflowstablemarriageFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowstablemarriageFrame::copy(self : GraphflowstablemarriageFrame) -> GraphflowstablemarriageFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageFrame::fill(self : GraphflowstablemarriageFrame, v : Double) -> GraphflowstablemarriageFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageFrame::min(self : GraphflowstablemarriageFrame) -> Double { @_common.min(self.data) }

pub fn GraphflowstablemarriageFrame::max(self : GraphflowstablemarriageFrame) -> Double { @_common.max(self.data) }

pub fn GraphflowstablemarriageFrame::to_string(self : GraphflowstablemarriageFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowstablemarriageTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_stable_marriage_table_make(size : Int) -> GraphflowstablemarriageTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowstablemarriageTable::len(self : GraphflowstablemarriageTable) -> Int { self.size }

pub fn GraphflowstablemarriageTable::get(self : GraphflowstablemarriageTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowstablemarriageTable::set(self : GraphflowstablemarriageTable, i : Int, v : Double) -> GraphflowstablemarriageTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageTable::sum(self : GraphflowstablemarriageTable) -> Double { @_common.sum(self.data) }

pub fn GraphflowstablemarriageTable::mean(self : GraphflowstablemarriageTable) -> Double { @_common.mean(self.data) }

pub fn GraphflowstablemarriageTable::scale(self : GraphflowstablemarriageTable, f : Double) -> GraphflowstablemarriageTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageTable::add(self : GraphflowstablemarriageTable, other : GraphflowstablemarriageTable) -> GraphflowstablemarriageTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowstablemarriageTable::copy(self : GraphflowstablemarriageTable) -> GraphflowstablemarriageTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageTable::fill(self : GraphflowstablemarriageTable, v : Double) -> GraphflowstablemarriageTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageTable::min(self : GraphflowstablemarriageTable) -> Double { @_common.min(self.data) }

pub fn GraphflowstablemarriageTable::max(self : GraphflowstablemarriageTable) -> Double { @_common.max(self.data) }

pub fn GraphflowstablemarriageTable::to_string(self : GraphflowstablemarriageTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowstablemarriageGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_stable_marriage_graphn_make(size : Int) -> GraphflowstablemarriageGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowstablemarriageGraphN::len(self : GraphflowstablemarriageGraphN) -> Int { self.size }

pub fn GraphflowstablemarriageGraphN::get(self : GraphflowstablemarriageGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowstablemarriageGraphN::set(self : GraphflowstablemarriageGraphN, i : Int, v : Double) -> GraphflowstablemarriageGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageGraphN::sum(self : GraphflowstablemarriageGraphN) -> Double { @_common.sum(self.data) }

pub fn GraphflowstablemarriageGraphN::mean(self : GraphflowstablemarriageGraphN) -> Double { @_common.mean(self.data) }

pub fn GraphflowstablemarriageGraphN::scale(self : GraphflowstablemarriageGraphN, f : Double) -> GraphflowstablemarriageGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageGraphN::add(self : GraphflowstablemarriageGraphN, other : GraphflowstablemarriageGraphN) -> GraphflowstablemarriageGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowstablemarriageGraphN::copy(self : GraphflowstablemarriageGraphN) -> GraphflowstablemarriageGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageGraphN::fill(self : GraphflowstablemarriageGraphN, v : Double) -> GraphflowstablemarriageGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageGraphN::min(self : GraphflowstablemarriageGraphN) -> Double { @_common.min(self.data) }

pub fn GraphflowstablemarriageGraphN::max(self : GraphflowstablemarriageGraphN) -> Double { @_common.max(self.data) }

pub fn GraphflowstablemarriageGraphN::to_string(self : GraphflowstablemarriageGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowstablemarriageNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_stable_marriage_node_make(size : Int) -> GraphflowstablemarriageNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowstablemarriageNode::len(self : GraphflowstablemarriageNode) -> Int { self.size }

pub fn GraphflowstablemarriageNode::get(self : GraphflowstablemarriageNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowstablemarriageNode::set(self : GraphflowstablemarriageNode, i : Int, v : Double) -> GraphflowstablemarriageNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageNode::sum(self : GraphflowstablemarriageNode) -> Double { @_common.sum(self.data) }

pub fn GraphflowstablemarriageNode::mean(self : GraphflowstablemarriageNode) -> Double { @_common.mean(self.data) }

pub fn GraphflowstablemarriageNode::scale(self : GraphflowstablemarriageNode, f : Double) -> GraphflowstablemarriageNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageNode::add(self : GraphflowstablemarriageNode, other : GraphflowstablemarriageNode) -> GraphflowstablemarriageNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowstablemarriageNode::copy(self : GraphflowstablemarriageNode) -> GraphflowstablemarriageNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageNode::fill(self : GraphflowstablemarriageNode, v : Double) -> GraphflowstablemarriageNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageNode::min(self : GraphflowstablemarriageNode) -> Double { @_common.min(self.data) }

pub fn GraphflowstablemarriageNode::max(self : GraphflowstablemarriageNode) -> Double { @_common.max(self.data) }

pub fn GraphflowstablemarriageNode::to_string(self : GraphflowstablemarriageNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowstablemarriageEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_stable_marriage_edge_make(size : Int) -> GraphflowstablemarriageEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowstablemarriageEdge::len(self : GraphflowstablemarriageEdge) -> Int { self.size }

pub fn GraphflowstablemarriageEdge::get(self : GraphflowstablemarriageEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowstablemarriageEdge::set(self : GraphflowstablemarriageEdge, i : Int, v : Double) -> GraphflowstablemarriageEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageEdge::sum(self : GraphflowstablemarriageEdge) -> Double { @_common.sum(self.data) }

pub fn GraphflowstablemarriageEdge::mean(self : GraphflowstablemarriageEdge) -> Double { @_common.mean(self.data) }

pub fn GraphflowstablemarriageEdge::scale(self : GraphflowstablemarriageEdge, f : Double) -> GraphflowstablemarriageEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageEdge::add(self : GraphflowstablemarriageEdge, other : GraphflowstablemarriageEdge) -> GraphflowstablemarriageEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowstablemarriageEdge::copy(self : GraphflowstablemarriageEdge) -> GraphflowstablemarriageEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageEdge::fill(self : GraphflowstablemarriageEdge, v : Double) -> GraphflowstablemarriageEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageEdge::min(self : GraphflowstablemarriageEdge) -> Double { @_common.min(self.data) }

pub fn GraphflowstablemarriageEdge::max(self : GraphflowstablemarriageEdge) -> Double { @_common.max(self.data) }

pub fn GraphflowstablemarriageEdge::to_string(self : GraphflowstablemarriageEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowstablemarriagePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_stable_marriage_path_make(size : Int) -> GraphflowstablemarriagePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowstablemarriagePath::len(self : GraphflowstablemarriagePath) -> Int { self.size }

pub fn GraphflowstablemarriagePath::get(self : GraphflowstablemarriagePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowstablemarriagePath::set(self : GraphflowstablemarriagePath, i : Int, v : Double) -> GraphflowstablemarriagePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriagePath::sum(self : GraphflowstablemarriagePath) -> Double { @_common.sum(self.data) }

pub fn GraphflowstablemarriagePath::mean(self : GraphflowstablemarriagePath) -> Double { @_common.mean(self.data) }

pub fn GraphflowstablemarriagePath::scale(self : GraphflowstablemarriagePath, f : Double) -> GraphflowstablemarriagePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriagePath::add(self : GraphflowstablemarriagePath, other : GraphflowstablemarriagePath) -> GraphflowstablemarriagePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowstablemarriagePath::copy(self : GraphflowstablemarriagePath) -> GraphflowstablemarriagePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriagePath::fill(self : GraphflowstablemarriagePath, v : Double) -> GraphflowstablemarriagePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriagePath::min(self : GraphflowstablemarriagePath) -> Double { @_common.min(self.data) }

pub fn GraphflowstablemarriagePath::max(self : GraphflowstablemarriagePath) -> Double { @_common.max(self.data) }

pub fn GraphflowstablemarriagePath::to_string(self : GraphflowstablemarriagePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowstablemarriageCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_stable_marriage_cluster_make(size : Int) -> GraphflowstablemarriageCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowstablemarriageCluster::len(self : GraphflowstablemarriageCluster) -> Int { self.size }

pub fn GraphflowstablemarriageCluster::get(self : GraphflowstablemarriageCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowstablemarriageCluster::set(self : GraphflowstablemarriageCluster, i : Int, v : Double) -> GraphflowstablemarriageCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageCluster::sum(self : GraphflowstablemarriageCluster) -> Double { @_common.sum(self.data) }

pub fn GraphflowstablemarriageCluster::mean(self : GraphflowstablemarriageCluster) -> Double { @_common.mean(self.data) }

pub fn GraphflowstablemarriageCluster::scale(self : GraphflowstablemarriageCluster, f : Double) -> GraphflowstablemarriageCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageCluster::add(self : GraphflowstablemarriageCluster, other : GraphflowstablemarriageCluster) -> GraphflowstablemarriageCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowstablemarriageCluster::copy(self : GraphflowstablemarriageCluster) -> GraphflowstablemarriageCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageCluster::fill(self : GraphflowstablemarriageCluster, v : Double) -> GraphflowstablemarriageCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageCluster::min(self : GraphflowstablemarriageCluster) -> Double { @_common.min(self.data) }

pub fn GraphflowstablemarriageCluster::max(self : GraphflowstablemarriageCluster) -> Double { @_common.max(self.data) }

pub fn GraphflowstablemarriageCluster::to_string(self : GraphflowstablemarriageCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowstablemarriageModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_stable_marriage_model_make(size : Int) -> GraphflowstablemarriageModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowstablemarriageModel::len(self : GraphflowstablemarriageModel) -> Int { self.size }

pub fn GraphflowstablemarriageModel::get(self : GraphflowstablemarriageModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowstablemarriageModel::set(self : GraphflowstablemarriageModel, i : Int, v : Double) -> GraphflowstablemarriageModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageModel::sum(self : GraphflowstablemarriageModel) -> Double { @_common.sum(self.data) }

pub fn GraphflowstablemarriageModel::mean(self : GraphflowstablemarriageModel) -> Double { @_common.mean(self.data) }

pub fn GraphflowstablemarriageModel::scale(self : GraphflowstablemarriageModel, f : Double) -> GraphflowstablemarriageModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageModel::add(self : GraphflowstablemarriageModel, other : GraphflowstablemarriageModel) -> GraphflowstablemarriageModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowstablemarriageModel::copy(self : GraphflowstablemarriageModel) -> GraphflowstablemarriageModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageModel::fill(self : GraphflowstablemarriageModel, v : Double) -> GraphflowstablemarriageModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageModel::min(self : GraphflowstablemarriageModel) -> Double { @_common.min(self.data) }

pub fn GraphflowstablemarriageModel::max(self : GraphflowstablemarriageModel) -> Double { @_common.max(self.data) }

pub fn GraphflowstablemarriageModel::to_string(self : GraphflowstablemarriageModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowstablemarriageLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_stable_marriage_layer_make(size : Int) -> GraphflowstablemarriageLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowstablemarriageLayer::len(self : GraphflowstablemarriageLayer) -> Int { self.size }

pub fn GraphflowstablemarriageLayer::get(self : GraphflowstablemarriageLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowstablemarriageLayer::set(self : GraphflowstablemarriageLayer, i : Int, v : Double) -> GraphflowstablemarriageLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageLayer::sum(self : GraphflowstablemarriageLayer) -> Double { @_common.sum(self.data) }

pub fn GraphflowstablemarriageLayer::mean(self : GraphflowstablemarriageLayer) -> Double { @_common.mean(self.data) }

pub fn GraphflowstablemarriageLayer::scale(self : GraphflowstablemarriageLayer, f : Double) -> GraphflowstablemarriageLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageLayer::add(self : GraphflowstablemarriageLayer, other : GraphflowstablemarriageLayer) -> GraphflowstablemarriageLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowstablemarriageLayer::copy(self : GraphflowstablemarriageLayer) -> GraphflowstablemarriageLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageLayer::fill(self : GraphflowstablemarriageLayer, v : Double) -> GraphflowstablemarriageLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageLayer::min(self : GraphflowstablemarriageLayer) -> Double { @_common.min(self.data) }

pub fn GraphflowstablemarriageLayer::max(self : GraphflowstablemarriageLayer) -> Double { @_common.max(self.data) }

pub fn GraphflowstablemarriageLayer::to_string(self : GraphflowstablemarriageLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowstablemarriageBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_stable_marriage_buffer_make(size : Int) -> GraphflowstablemarriageBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowstablemarriageBuffer::len(self : GraphflowstablemarriageBuffer) -> Int { self.size }

pub fn GraphflowstablemarriageBuffer::get(self : GraphflowstablemarriageBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowstablemarriageBuffer::set(self : GraphflowstablemarriageBuffer, i : Int, v : Double) -> GraphflowstablemarriageBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageBuffer::sum(self : GraphflowstablemarriageBuffer) -> Double { @_common.sum(self.data) }

pub fn GraphflowstablemarriageBuffer::mean(self : GraphflowstablemarriageBuffer) -> Double { @_common.mean(self.data) }

pub fn GraphflowstablemarriageBuffer::scale(self : GraphflowstablemarriageBuffer, f : Double) -> GraphflowstablemarriageBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageBuffer::add(self : GraphflowstablemarriageBuffer, other : GraphflowstablemarriageBuffer) -> GraphflowstablemarriageBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowstablemarriageBuffer::copy(self : GraphflowstablemarriageBuffer) -> GraphflowstablemarriageBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageBuffer::fill(self : GraphflowstablemarriageBuffer, v : Double) -> GraphflowstablemarriageBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageBuffer::min(self : GraphflowstablemarriageBuffer) -> Double { @_common.min(self.data) }

pub fn GraphflowstablemarriageBuffer::max(self : GraphflowstablemarriageBuffer) -> Double { @_common.max(self.data) }

pub fn GraphflowstablemarriageBuffer::to_string(self : GraphflowstablemarriageBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowstablemarriageCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_stable_marriage_cursor_make(size : Int) -> GraphflowstablemarriageCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowstablemarriageCursor::len(self : GraphflowstablemarriageCursor) -> Int { self.size }

pub fn GraphflowstablemarriageCursor::get(self : GraphflowstablemarriageCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowstablemarriageCursor::set(self : GraphflowstablemarriageCursor, i : Int, v : Double) -> GraphflowstablemarriageCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageCursor::sum(self : GraphflowstablemarriageCursor) -> Double { @_common.sum(self.data) }

pub fn GraphflowstablemarriageCursor::mean(self : GraphflowstablemarriageCursor) -> Double { @_common.mean(self.data) }

pub fn GraphflowstablemarriageCursor::scale(self : GraphflowstablemarriageCursor, f : Double) -> GraphflowstablemarriageCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageCursor::add(self : GraphflowstablemarriageCursor, other : GraphflowstablemarriageCursor) -> GraphflowstablemarriageCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowstablemarriageCursor::copy(self : GraphflowstablemarriageCursor) -> GraphflowstablemarriageCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageCursor::fill(self : GraphflowstablemarriageCursor, v : Double) -> GraphflowstablemarriageCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageCursor::min(self : GraphflowstablemarriageCursor) -> Double { @_common.min(self.data) }

pub fn GraphflowstablemarriageCursor::max(self : GraphflowstablemarriageCursor) -> Double { @_common.max(self.data) }

pub fn GraphflowstablemarriageCursor::to_string(self : GraphflowstablemarriageCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowstablemarriageView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_stable_marriage_view_make(size : Int) -> GraphflowstablemarriageView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowstablemarriageView::len(self : GraphflowstablemarriageView) -> Int { self.size }

pub fn GraphflowstablemarriageView::get(self : GraphflowstablemarriageView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowstablemarriageView::set(self : GraphflowstablemarriageView, i : Int, v : Double) -> GraphflowstablemarriageView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageView::sum(self : GraphflowstablemarriageView) -> Double { @_common.sum(self.data) }

pub fn GraphflowstablemarriageView::mean(self : GraphflowstablemarriageView) -> Double { @_common.mean(self.data) }

pub fn GraphflowstablemarriageView::scale(self : GraphflowstablemarriageView, f : Double) -> GraphflowstablemarriageView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageView::add(self : GraphflowstablemarriageView, other : GraphflowstablemarriageView) -> GraphflowstablemarriageView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowstablemarriageView::copy(self : GraphflowstablemarriageView) -> GraphflowstablemarriageView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageView::fill(self : GraphflowstablemarriageView, v : Double) -> GraphflowstablemarriageView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageView::min(self : GraphflowstablemarriageView) -> Double { @_common.min(self.data) }

pub fn GraphflowstablemarriageView::max(self : GraphflowstablemarriageView) -> Double { @_common.max(self.data) }

pub fn GraphflowstablemarriageView::to_string(self : GraphflowstablemarriageView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowstablemarriageRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_stable_marriage_range_make(size : Int) -> GraphflowstablemarriageRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowstablemarriageRange::len(self : GraphflowstablemarriageRange) -> Int { self.size }

pub fn GraphflowstablemarriageRange::get(self : GraphflowstablemarriageRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowstablemarriageRange::set(self : GraphflowstablemarriageRange, i : Int, v : Double) -> GraphflowstablemarriageRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageRange::sum(self : GraphflowstablemarriageRange) -> Double { @_common.sum(self.data) }

pub fn GraphflowstablemarriageRange::mean(self : GraphflowstablemarriageRange) -> Double { @_common.mean(self.data) }

pub fn GraphflowstablemarriageRange::scale(self : GraphflowstablemarriageRange, f : Double) -> GraphflowstablemarriageRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageRange::add(self : GraphflowstablemarriageRange, other : GraphflowstablemarriageRange) -> GraphflowstablemarriageRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowstablemarriageRange::copy(self : GraphflowstablemarriageRange) -> GraphflowstablemarriageRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageRange::fill(self : GraphflowstablemarriageRange, v : Double) -> GraphflowstablemarriageRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageRange::min(self : GraphflowstablemarriageRange) -> Double { @_common.min(self.data) }

pub fn GraphflowstablemarriageRange::max(self : GraphflowstablemarriageRange) -> Double { @_common.max(self.data) }

pub fn GraphflowstablemarriageRange::to_string(self : GraphflowstablemarriageRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowstablemarriageSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_stable_marriage_slice_make(size : Int) -> GraphflowstablemarriageSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowstablemarriageSlice::len(self : GraphflowstablemarriageSlice) -> Int { self.size }

pub fn GraphflowstablemarriageSlice::get(self : GraphflowstablemarriageSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowstablemarriageSlice::set(self : GraphflowstablemarriageSlice, i : Int, v : Double) -> GraphflowstablemarriageSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageSlice::sum(self : GraphflowstablemarriageSlice) -> Double { @_common.sum(self.data) }

pub fn GraphflowstablemarriageSlice::mean(self : GraphflowstablemarriageSlice) -> Double { @_common.mean(self.data) }

pub fn GraphflowstablemarriageSlice::scale(self : GraphflowstablemarriageSlice, f : Double) -> GraphflowstablemarriageSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageSlice::add(self : GraphflowstablemarriageSlice, other : GraphflowstablemarriageSlice) -> GraphflowstablemarriageSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowstablemarriageSlice::copy(self : GraphflowstablemarriageSlice) -> GraphflowstablemarriageSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageSlice::fill(self : GraphflowstablemarriageSlice, v : Double) -> GraphflowstablemarriageSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowstablemarriageSlice::min(self : GraphflowstablemarriageSlice) -> Double { @_common.min(self.data) }

pub fn GraphflowstablemarriageSlice::max(self : GraphflowstablemarriageSlice) -> Double { @_common.max(self.data) }

pub fn GraphflowstablemarriageSlice::to_string(self : GraphflowstablemarriageSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

