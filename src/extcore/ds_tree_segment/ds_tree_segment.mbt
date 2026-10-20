///===
/// extcore/ds_tree_segment

pub(all) struct DstreesegmentPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_tree_segment_make_point(x : Double, y : Double) -> DstreesegmentPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_tree_segment_make_point3(x : Double, y : Double, z : Double) -> DstreesegmentPoint {
  { x, y, z, label: 0 }
}

pub fn DstreesegmentPoint::x(self : DstreesegmentPoint) -> Double { self.x }

pub fn DstreesegmentPoint::y(self : DstreesegmentPoint) -> Double { self.y }

pub fn DstreesegmentPoint::z(self : DstreesegmentPoint) -> Double { self.z }

pub fn DstreesegmentPoint::label(self : DstreesegmentPoint) -> Int { self.label }

pub fn DstreesegmentPoint::dist(self : DstreesegmentPoint, other : DstreesegmentPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DstreesegmentPoint::add(self : DstreesegmentPoint, other : DstreesegmentPoint) -> DstreesegmentPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DstreesegmentPoint::sub(self : DstreesegmentPoint, other : DstreesegmentPoint) -> DstreesegmentPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DstreesegmentPoint::scale(self : DstreesegmentPoint, s : Double) -> DstreesegmentPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DstreesegmentPoint::dot(self : DstreesegmentPoint, other : DstreesegmentPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DstreesegmentPoint::cross(self : DstreesegmentPoint, other : DstreesegmentPoint) -> DstreesegmentPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DstreesegmentPoint::norm(self : DstreesegmentPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DstreesegmentPoint::normalize(self : DstreesegmentPoint) -> DstreesegmentPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DstreesegmentPoint::negate(self : DstreesegmentPoint) -> DstreesegmentPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DstreesegmentPoint::mid(self : DstreesegmentPoint, other : DstreesegmentPoint) -> DstreesegmentPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DstreesegmentPoint::lerp(self : DstreesegmentPoint, other : DstreesegmentPoint, t : Double) -> DstreesegmentPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DstreesegmentPoint::to_string(self : DstreesegmentPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DstreesegmentSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_tree_segment_make_series(vals : Array[Double], name : String) -> DstreesegmentSeries {
  { vals, name, meta: 0 }
}

pub fn DstreesegmentSeries::len(self : DstreesegmentSeries) -> Int { self.vals.length() }

pub fn DstreesegmentSeries::sum(self : DstreesegmentSeries) -> Double { @_common.sum(self.vals) }

pub fn DstreesegmentSeries::mean(self : DstreesegmentSeries) -> Double { @_common.mean(self.vals) }

pub fn DstreesegmentSeries::min(self : DstreesegmentSeries) -> Double { @_common.min(self.vals) }

pub fn DstreesegmentSeries::max(self : DstreesegmentSeries) -> Double { @_common.max(self.vals) }

pub fn DstreesegmentSeries::range(self : DstreesegmentSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DstreesegmentSeries::variance(self : DstreesegmentSeries) -> Double { @_common.variance(self.vals) }

pub fn DstreesegmentSeries::std(self : DstreesegmentSeries) -> Double { @_common.std(self.vals) }

pub fn DstreesegmentSeries::median(self : DstreesegmentSeries) -> Double { @_common.median(self.vals) }

pub fn DstreesegmentSeries::scale(self : DstreesegmentSeries, f : Double) -> DstreesegmentSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DstreesegmentSeries::add(self : DstreesegmentSeries, other : DstreesegmentSeries) -> DstreesegmentSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DstreesegmentSeries::sub(self : DstreesegmentSeries, other : DstreesegmentSeries) -> DstreesegmentSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DstreesegmentSeries::normalize(self : DstreesegmentSeries) -> DstreesegmentSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DstreesegmentSeries::cumsum(self : DstreesegmentSeries) -> DstreesegmentSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DstreesegmentSeries::to_string(self : DstreesegmentSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DstreesegmentMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_tree_segment_make_matrix(rows : Int, cols : Int, val : Double) -> DstreesegmentMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_tree_segment_matrix_identity(n : Int) -> DstreesegmentMatrix {
  let m = ds_tree_segment_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DstreesegmentMatrix::get(self : DstreesegmentMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DstreesegmentMatrix::transpose(self : DstreesegmentMatrix) -> DstreesegmentMatrix {
  let result = ds_tree_segment_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DstreesegmentMatrix::add(self : DstreesegmentMatrix, other : DstreesegmentMatrix) -> DstreesegmentMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_tree_segment_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DstreesegmentMatrix::scale(self : DstreesegmentMatrix, s : Double) -> DstreesegmentMatrix {
  let result = ds_tree_segment_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DstreesegmentMatrix::multiply(self : DstreesegmentMatrix, other : DstreesegmentMatrix) -> DstreesegmentMatrix {
  if self.cols != other.rows { return ds_tree_segment_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_tree_segment_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DstreesegmentMatrix::trace(self : DstreesegmentMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DstreesegmentMatrix::det(self : DstreesegmentMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DstreesegmentMatrix::norm(self : DstreesegmentMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DstreesegmentMatrix::to_string(self : DstreesegmentMatrix) -> String {
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

pub(all) struct DstreesegmentVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_tree_segment_make_vector(comps : Array[Double]) -> DstreesegmentVector {
  { comps, dim: comps.length() }
}

pub fn ds_tree_segment_vector_zero(dim : Int) -> DstreesegmentVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DstreesegmentVector::add(self : DstreesegmentVector, other : DstreesegmentVector) -> DstreesegmentVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DstreesegmentVector::sub(self : DstreesegmentVector, other : DstreesegmentVector) -> DstreesegmentVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DstreesegmentVector::scale(self : DstreesegmentVector, s : Double) -> DstreesegmentVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DstreesegmentVector::dot(self : DstreesegmentVector, other : DstreesegmentVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DstreesegmentVector::norm(self : DstreesegmentVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DstreesegmentVector::normalize(self : DstreesegmentVector) -> DstreesegmentVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DstreesegmentVector::dist(self : DstreesegmentVector, other : DstreesegmentVector) -> Double {
  self.sub(other).norm()
}

pub fn DstreesegmentVector::to_string(self : DstreesegmentVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DstreesegmentFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_segment_frame_make(size : Int) -> DstreesegmentFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreesegmentFrame::len(self : DstreesegmentFrame) -> Int { self.size }

pub fn DstreesegmentFrame::get(self : DstreesegmentFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreesegmentFrame::set(self : DstreesegmentFrame, i : Int, v : Double) -> DstreesegmentFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreesegmentFrame::sum(self : DstreesegmentFrame) -> Double { @_common.sum(self.data) }

pub fn DstreesegmentFrame::mean(self : DstreesegmentFrame) -> Double { @_common.mean(self.data) }

pub fn DstreesegmentFrame::scale(self : DstreesegmentFrame, f : Double) -> DstreesegmentFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreesegmentFrame::add(self : DstreesegmentFrame, other : DstreesegmentFrame) -> DstreesegmentFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreesegmentFrame::copy(self : DstreesegmentFrame) -> DstreesegmentFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreesegmentFrame::fill(self : DstreesegmentFrame, v : Double) -> DstreesegmentFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreesegmentFrame::min(self : DstreesegmentFrame) -> Double { @_common.min(self.data) }

pub fn DstreesegmentFrame::max(self : DstreesegmentFrame) -> Double { @_common.max(self.data) }

pub fn DstreesegmentFrame::to_string(self : DstreesegmentFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreesegmentTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_segment_table_make(size : Int) -> DstreesegmentTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreesegmentTable::len(self : DstreesegmentTable) -> Int { self.size }

pub fn DstreesegmentTable::get(self : DstreesegmentTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreesegmentTable::set(self : DstreesegmentTable, i : Int, v : Double) -> DstreesegmentTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreesegmentTable::sum(self : DstreesegmentTable) -> Double { @_common.sum(self.data) }

pub fn DstreesegmentTable::mean(self : DstreesegmentTable) -> Double { @_common.mean(self.data) }

pub fn DstreesegmentTable::scale(self : DstreesegmentTable, f : Double) -> DstreesegmentTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreesegmentTable::add(self : DstreesegmentTable, other : DstreesegmentTable) -> DstreesegmentTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreesegmentTable::copy(self : DstreesegmentTable) -> DstreesegmentTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreesegmentTable::fill(self : DstreesegmentTable, v : Double) -> DstreesegmentTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreesegmentTable::min(self : DstreesegmentTable) -> Double { @_common.min(self.data) }

pub fn DstreesegmentTable::max(self : DstreesegmentTable) -> Double { @_common.max(self.data) }

pub fn DstreesegmentTable::to_string(self : DstreesegmentTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreesegmentGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_segment_graphn_make(size : Int) -> DstreesegmentGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreesegmentGraphN::len(self : DstreesegmentGraphN) -> Int { self.size }

pub fn DstreesegmentGraphN::get(self : DstreesegmentGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreesegmentGraphN::set(self : DstreesegmentGraphN, i : Int, v : Double) -> DstreesegmentGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreesegmentGraphN::sum(self : DstreesegmentGraphN) -> Double { @_common.sum(self.data) }

pub fn DstreesegmentGraphN::mean(self : DstreesegmentGraphN) -> Double { @_common.mean(self.data) }

pub fn DstreesegmentGraphN::scale(self : DstreesegmentGraphN, f : Double) -> DstreesegmentGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreesegmentGraphN::add(self : DstreesegmentGraphN, other : DstreesegmentGraphN) -> DstreesegmentGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreesegmentGraphN::copy(self : DstreesegmentGraphN) -> DstreesegmentGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreesegmentGraphN::fill(self : DstreesegmentGraphN, v : Double) -> DstreesegmentGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreesegmentGraphN::min(self : DstreesegmentGraphN) -> Double { @_common.min(self.data) }

pub fn DstreesegmentGraphN::max(self : DstreesegmentGraphN) -> Double { @_common.max(self.data) }

pub fn DstreesegmentGraphN::to_string(self : DstreesegmentGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreesegmentNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_segment_node_make(size : Int) -> DstreesegmentNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreesegmentNode::len(self : DstreesegmentNode) -> Int { self.size }

pub fn DstreesegmentNode::get(self : DstreesegmentNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreesegmentNode::set(self : DstreesegmentNode, i : Int, v : Double) -> DstreesegmentNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreesegmentNode::sum(self : DstreesegmentNode) -> Double { @_common.sum(self.data) }

pub fn DstreesegmentNode::mean(self : DstreesegmentNode) -> Double { @_common.mean(self.data) }

pub fn DstreesegmentNode::scale(self : DstreesegmentNode, f : Double) -> DstreesegmentNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreesegmentNode::add(self : DstreesegmentNode, other : DstreesegmentNode) -> DstreesegmentNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreesegmentNode::copy(self : DstreesegmentNode) -> DstreesegmentNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreesegmentNode::fill(self : DstreesegmentNode, v : Double) -> DstreesegmentNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreesegmentNode::min(self : DstreesegmentNode) -> Double { @_common.min(self.data) }

pub fn DstreesegmentNode::max(self : DstreesegmentNode) -> Double { @_common.max(self.data) }

pub fn DstreesegmentNode::to_string(self : DstreesegmentNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreesegmentEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_segment_edge_make(size : Int) -> DstreesegmentEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreesegmentEdge::len(self : DstreesegmentEdge) -> Int { self.size }

pub fn DstreesegmentEdge::get(self : DstreesegmentEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreesegmentEdge::set(self : DstreesegmentEdge, i : Int, v : Double) -> DstreesegmentEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreesegmentEdge::sum(self : DstreesegmentEdge) -> Double { @_common.sum(self.data) }

pub fn DstreesegmentEdge::mean(self : DstreesegmentEdge) -> Double { @_common.mean(self.data) }

pub fn DstreesegmentEdge::scale(self : DstreesegmentEdge, f : Double) -> DstreesegmentEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreesegmentEdge::add(self : DstreesegmentEdge, other : DstreesegmentEdge) -> DstreesegmentEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreesegmentEdge::copy(self : DstreesegmentEdge) -> DstreesegmentEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreesegmentEdge::fill(self : DstreesegmentEdge, v : Double) -> DstreesegmentEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreesegmentEdge::min(self : DstreesegmentEdge) -> Double { @_common.min(self.data) }

pub fn DstreesegmentEdge::max(self : DstreesegmentEdge) -> Double { @_common.max(self.data) }

pub fn DstreesegmentEdge::to_string(self : DstreesegmentEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreesegmentPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_segment_path_make(size : Int) -> DstreesegmentPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreesegmentPath::len(self : DstreesegmentPath) -> Int { self.size }

pub fn DstreesegmentPath::get(self : DstreesegmentPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreesegmentPath::set(self : DstreesegmentPath, i : Int, v : Double) -> DstreesegmentPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreesegmentPath::sum(self : DstreesegmentPath) -> Double { @_common.sum(self.data) }

pub fn DstreesegmentPath::mean(self : DstreesegmentPath) -> Double { @_common.mean(self.data) }

pub fn DstreesegmentPath::scale(self : DstreesegmentPath, f : Double) -> DstreesegmentPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreesegmentPath::add(self : DstreesegmentPath, other : DstreesegmentPath) -> DstreesegmentPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreesegmentPath::copy(self : DstreesegmentPath) -> DstreesegmentPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreesegmentPath::fill(self : DstreesegmentPath, v : Double) -> DstreesegmentPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreesegmentPath::min(self : DstreesegmentPath) -> Double { @_common.min(self.data) }

pub fn DstreesegmentPath::max(self : DstreesegmentPath) -> Double { @_common.max(self.data) }

pub fn DstreesegmentPath::to_string(self : DstreesegmentPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreesegmentCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_segment_cluster_make(size : Int) -> DstreesegmentCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreesegmentCluster::len(self : DstreesegmentCluster) -> Int { self.size }

pub fn DstreesegmentCluster::get(self : DstreesegmentCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreesegmentCluster::set(self : DstreesegmentCluster, i : Int, v : Double) -> DstreesegmentCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreesegmentCluster::sum(self : DstreesegmentCluster) -> Double { @_common.sum(self.data) }

pub fn DstreesegmentCluster::mean(self : DstreesegmentCluster) -> Double { @_common.mean(self.data) }

pub fn DstreesegmentCluster::scale(self : DstreesegmentCluster, f : Double) -> DstreesegmentCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreesegmentCluster::add(self : DstreesegmentCluster, other : DstreesegmentCluster) -> DstreesegmentCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreesegmentCluster::copy(self : DstreesegmentCluster) -> DstreesegmentCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreesegmentCluster::fill(self : DstreesegmentCluster, v : Double) -> DstreesegmentCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreesegmentCluster::min(self : DstreesegmentCluster) -> Double { @_common.min(self.data) }

pub fn DstreesegmentCluster::max(self : DstreesegmentCluster) -> Double { @_common.max(self.data) }

pub fn DstreesegmentCluster::to_string(self : DstreesegmentCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreesegmentModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_segment_model_make(size : Int) -> DstreesegmentModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreesegmentModel::len(self : DstreesegmentModel) -> Int { self.size }

pub fn DstreesegmentModel::get(self : DstreesegmentModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreesegmentModel::set(self : DstreesegmentModel, i : Int, v : Double) -> DstreesegmentModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreesegmentModel::sum(self : DstreesegmentModel) -> Double { @_common.sum(self.data) }

pub fn DstreesegmentModel::mean(self : DstreesegmentModel) -> Double { @_common.mean(self.data) }

pub fn DstreesegmentModel::scale(self : DstreesegmentModel, f : Double) -> DstreesegmentModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreesegmentModel::add(self : DstreesegmentModel, other : DstreesegmentModel) -> DstreesegmentModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreesegmentModel::copy(self : DstreesegmentModel) -> DstreesegmentModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreesegmentModel::fill(self : DstreesegmentModel, v : Double) -> DstreesegmentModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreesegmentModel::min(self : DstreesegmentModel) -> Double { @_common.min(self.data) }

pub fn DstreesegmentModel::max(self : DstreesegmentModel) -> Double { @_common.max(self.data) }

pub fn DstreesegmentModel::to_string(self : DstreesegmentModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreesegmentLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_segment_layer_make(size : Int) -> DstreesegmentLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreesegmentLayer::len(self : DstreesegmentLayer) -> Int { self.size }

pub fn DstreesegmentLayer::get(self : DstreesegmentLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreesegmentLayer::set(self : DstreesegmentLayer, i : Int, v : Double) -> DstreesegmentLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreesegmentLayer::sum(self : DstreesegmentLayer) -> Double { @_common.sum(self.data) }

pub fn DstreesegmentLayer::mean(self : DstreesegmentLayer) -> Double { @_common.mean(self.data) }

pub fn DstreesegmentLayer::scale(self : DstreesegmentLayer, f : Double) -> DstreesegmentLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreesegmentLayer::add(self : DstreesegmentLayer, other : DstreesegmentLayer) -> DstreesegmentLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreesegmentLayer::copy(self : DstreesegmentLayer) -> DstreesegmentLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreesegmentLayer::fill(self : DstreesegmentLayer, v : Double) -> DstreesegmentLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreesegmentLayer::min(self : DstreesegmentLayer) -> Double { @_common.min(self.data) }

pub fn DstreesegmentLayer::max(self : DstreesegmentLayer) -> Double { @_common.max(self.data) }

pub fn DstreesegmentLayer::to_string(self : DstreesegmentLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreesegmentBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_segment_buffer_make(size : Int) -> DstreesegmentBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreesegmentBuffer::len(self : DstreesegmentBuffer) -> Int { self.size }

pub fn DstreesegmentBuffer::get(self : DstreesegmentBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreesegmentBuffer::set(self : DstreesegmentBuffer, i : Int, v : Double) -> DstreesegmentBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreesegmentBuffer::sum(self : DstreesegmentBuffer) -> Double { @_common.sum(self.data) }

pub fn DstreesegmentBuffer::mean(self : DstreesegmentBuffer) -> Double { @_common.mean(self.data) }

pub fn DstreesegmentBuffer::scale(self : DstreesegmentBuffer, f : Double) -> DstreesegmentBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreesegmentBuffer::add(self : DstreesegmentBuffer, other : DstreesegmentBuffer) -> DstreesegmentBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreesegmentBuffer::copy(self : DstreesegmentBuffer) -> DstreesegmentBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreesegmentBuffer::fill(self : DstreesegmentBuffer, v : Double) -> DstreesegmentBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreesegmentBuffer::min(self : DstreesegmentBuffer) -> Double { @_common.min(self.data) }

pub fn DstreesegmentBuffer::max(self : DstreesegmentBuffer) -> Double { @_common.max(self.data) }

pub fn DstreesegmentBuffer::to_string(self : DstreesegmentBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreesegmentCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_segment_cursor_make(size : Int) -> DstreesegmentCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreesegmentCursor::len(self : DstreesegmentCursor) -> Int { self.size }

pub fn DstreesegmentCursor::get(self : DstreesegmentCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreesegmentCursor::set(self : DstreesegmentCursor, i : Int, v : Double) -> DstreesegmentCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreesegmentCursor::sum(self : DstreesegmentCursor) -> Double { @_common.sum(self.data) }

pub fn DstreesegmentCursor::mean(self : DstreesegmentCursor) -> Double { @_common.mean(self.data) }

pub fn DstreesegmentCursor::scale(self : DstreesegmentCursor, f : Double) -> DstreesegmentCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreesegmentCursor::add(self : DstreesegmentCursor, other : DstreesegmentCursor) -> DstreesegmentCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreesegmentCursor::copy(self : DstreesegmentCursor) -> DstreesegmentCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreesegmentCursor::fill(self : DstreesegmentCursor, v : Double) -> DstreesegmentCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreesegmentCursor::min(self : DstreesegmentCursor) -> Double { @_common.min(self.data) }

pub fn DstreesegmentCursor::max(self : DstreesegmentCursor) -> Double { @_common.max(self.data) }

pub fn DstreesegmentCursor::to_string(self : DstreesegmentCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreesegmentView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_segment_view_make(size : Int) -> DstreesegmentView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreesegmentView::len(self : DstreesegmentView) -> Int { self.size }

pub fn DstreesegmentView::get(self : DstreesegmentView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreesegmentView::set(self : DstreesegmentView, i : Int, v : Double) -> DstreesegmentView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreesegmentView::sum(self : DstreesegmentView) -> Double { @_common.sum(self.data) }

pub fn DstreesegmentView::mean(self : DstreesegmentView) -> Double { @_common.mean(self.data) }

pub fn DstreesegmentView::scale(self : DstreesegmentView, f : Double) -> DstreesegmentView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreesegmentView::add(self : DstreesegmentView, other : DstreesegmentView) -> DstreesegmentView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreesegmentView::copy(self : DstreesegmentView) -> DstreesegmentView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreesegmentView::fill(self : DstreesegmentView, v : Double) -> DstreesegmentView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreesegmentView::min(self : DstreesegmentView) -> Double { @_common.min(self.data) }

pub fn DstreesegmentView::max(self : DstreesegmentView) -> Double { @_common.max(self.data) }

pub fn DstreesegmentView::to_string(self : DstreesegmentView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreesegmentRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_segment_range_make(size : Int) -> DstreesegmentRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreesegmentRange::len(self : DstreesegmentRange) -> Int { self.size }

pub fn DstreesegmentRange::get(self : DstreesegmentRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreesegmentRange::set(self : DstreesegmentRange, i : Int, v : Double) -> DstreesegmentRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreesegmentRange::sum(self : DstreesegmentRange) -> Double { @_common.sum(self.data) }

pub fn DstreesegmentRange::mean(self : DstreesegmentRange) -> Double { @_common.mean(self.data) }

pub fn DstreesegmentRange::scale(self : DstreesegmentRange, f : Double) -> DstreesegmentRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreesegmentRange::add(self : DstreesegmentRange, other : DstreesegmentRange) -> DstreesegmentRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreesegmentRange::copy(self : DstreesegmentRange) -> DstreesegmentRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreesegmentRange::fill(self : DstreesegmentRange, v : Double) -> DstreesegmentRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreesegmentRange::min(self : DstreesegmentRange) -> Double { @_common.min(self.data) }

pub fn DstreesegmentRange::max(self : DstreesegmentRange) -> Double { @_common.max(self.data) }

pub fn DstreesegmentRange::to_string(self : DstreesegmentRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreesegmentSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_segment_slice_make(size : Int) -> DstreesegmentSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreesegmentSlice::len(self : DstreesegmentSlice) -> Int { self.size }

pub fn DstreesegmentSlice::get(self : DstreesegmentSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreesegmentSlice::set(self : DstreesegmentSlice, i : Int, v : Double) -> DstreesegmentSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreesegmentSlice::sum(self : DstreesegmentSlice) -> Double { @_common.sum(self.data) }

pub fn DstreesegmentSlice::mean(self : DstreesegmentSlice) -> Double { @_common.mean(self.data) }

pub fn DstreesegmentSlice::scale(self : DstreesegmentSlice, f : Double) -> DstreesegmentSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreesegmentSlice::add(self : DstreesegmentSlice, other : DstreesegmentSlice) -> DstreesegmentSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreesegmentSlice::copy(self : DstreesegmentSlice) -> DstreesegmentSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreesegmentSlice::fill(self : DstreesegmentSlice, v : Double) -> DstreesegmentSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreesegmentSlice::min(self : DstreesegmentSlice) -> Double { @_common.min(self.data) }

pub fn DstreesegmentSlice::max(self : DstreesegmentSlice) -> Double { @_common.max(self.data) }

pub fn DstreesegmentSlice::to_string(self : DstreesegmentSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

