///===
/// extcore/ds_tree_redblack

pub(all) struct DstreeredblackPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_tree_redblack_make_point(x : Double, y : Double) -> DstreeredblackPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_tree_redblack_make_point3(x : Double, y : Double, z : Double) -> DstreeredblackPoint {
  { x, y, z, label: 0 }
}

pub fn DstreeredblackPoint::x(self : DstreeredblackPoint) -> Double { self.x }

pub fn DstreeredblackPoint::y(self : DstreeredblackPoint) -> Double { self.y }

pub fn DstreeredblackPoint::z(self : DstreeredblackPoint) -> Double { self.z }

pub fn DstreeredblackPoint::label(self : DstreeredblackPoint) -> Int { self.label }

pub fn DstreeredblackPoint::dist(self : DstreeredblackPoint, other : DstreeredblackPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DstreeredblackPoint::add(self : DstreeredblackPoint, other : DstreeredblackPoint) -> DstreeredblackPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DstreeredblackPoint::sub(self : DstreeredblackPoint, other : DstreeredblackPoint) -> DstreeredblackPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DstreeredblackPoint::scale(self : DstreeredblackPoint, s : Double) -> DstreeredblackPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DstreeredblackPoint::dot(self : DstreeredblackPoint, other : DstreeredblackPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DstreeredblackPoint::cross(self : DstreeredblackPoint, other : DstreeredblackPoint) -> DstreeredblackPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DstreeredblackPoint::norm(self : DstreeredblackPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DstreeredblackPoint::normalize(self : DstreeredblackPoint) -> DstreeredblackPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DstreeredblackPoint::negate(self : DstreeredblackPoint) -> DstreeredblackPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DstreeredblackPoint::mid(self : DstreeredblackPoint, other : DstreeredblackPoint) -> DstreeredblackPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DstreeredblackPoint::lerp(self : DstreeredblackPoint, other : DstreeredblackPoint, t : Double) -> DstreeredblackPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DstreeredblackPoint::to_string(self : DstreeredblackPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DstreeredblackSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_tree_redblack_make_series(vals : Array[Double], name : String) -> DstreeredblackSeries {
  { vals, name, meta: 0 }
}

pub fn DstreeredblackSeries::len(self : DstreeredblackSeries) -> Int { self.vals.length() }

pub fn DstreeredblackSeries::sum(self : DstreeredblackSeries) -> Double { @_common.sum(self.vals) }

pub fn DstreeredblackSeries::mean(self : DstreeredblackSeries) -> Double { @_common.mean(self.vals) }

pub fn DstreeredblackSeries::min(self : DstreeredblackSeries) -> Double { @_common.min(self.vals) }

pub fn DstreeredblackSeries::max(self : DstreeredblackSeries) -> Double { @_common.max(self.vals) }

pub fn DstreeredblackSeries::range(self : DstreeredblackSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DstreeredblackSeries::variance(self : DstreeredblackSeries) -> Double { @_common.variance(self.vals) }

pub fn DstreeredblackSeries::std(self : DstreeredblackSeries) -> Double { @_common.std(self.vals) }

pub fn DstreeredblackSeries::median(self : DstreeredblackSeries) -> Double { @_common.median(self.vals) }

pub fn DstreeredblackSeries::scale(self : DstreeredblackSeries, f : Double) -> DstreeredblackSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DstreeredblackSeries::add(self : DstreeredblackSeries, other : DstreeredblackSeries) -> DstreeredblackSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DstreeredblackSeries::sub(self : DstreeredblackSeries, other : DstreeredblackSeries) -> DstreeredblackSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DstreeredblackSeries::normalize(self : DstreeredblackSeries) -> DstreeredblackSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DstreeredblackSeries::cumsum(self : DstreeredblackSeries) -> DstreeredblackSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DstreeredblackSeries::to_string(self : DstreeredblackSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DstreeredblackMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_tree_redblack_make_matrix(rows : Int, cols : Int, val : Double) -> DstreeredblackMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_tree_redblack_matrix_identity(n : Int) -> DstreeredblackMatrix {
  let m = ds_tree_redblack_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DstreeredblackMatrix::get(self : DstreeredblackMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DstreeredblackMatrix::transpose(self : DstreeredblackMatrix) -> DstreeredblackMatrix {
  let result = ds_tree_redblack_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DstreeredblackMatrix::add(self : DstreeredblackMatrix, other : DstreeredblackMatrix) -> DstreeredblackMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_tree_redblack_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DstreeredblackMatrix::scale(self : DstreeredblackMatrix, s : Double) -> DstreeredblackMatrix {
  let result = ds_tree_redblack_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DstreeredblackMatrix::multiply(self : DstreeredblackMatrix, other : DstreeredblackMatrix) -> DstreeredblackMatrix {
  if self.cols != other.rows { return ds_tree_redblack_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_tree_redblack_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn DstreeredblackMatrix::trace(self : DstreeredblackMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DstreeredblackMatrix::det(self : DstreeredblackMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DstreeredblackMatrix::norm(self : DstreeredblackMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DstreeredblackMatrix::to_string(self : DstreeredblackMatrix) -> String {
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

pub(all) struct DstreeredblackVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_tree_redblack_make_vector(comps : Array[Double]) -> DstreeredblackVector {
  { comps, dim: comps.length() }
}

pub fn ds_tree_redblack_vector_zero(dim : Int) -> DstreeredblackVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DstreeredblackVector::add(self : DstreeredblackVector, other : DstreeredblackVector) -> DstreeredblackVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DstreeredblackVector::sub(self : DstreeredblackVector, other : DstreeredblackVector) -> DstreeredblackVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DstreeredblackVector::scale(self : DstreeredblackVector, s : Double) -> DstreeredblackVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DstreeredblackVector::dot(self : DstreeredblackVector, other : DstreeredblackVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DstreeredblackVector::norm(self : DstreeredblackVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DstreeredblackVector::normalize(self : DstreeredblackVector) -> DstreeredblackVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DstreeredblackVector::dist(self : DstreeredblackVector, other : DstreeredblackVector) -> Double {
  self.sub(other).norm()
}

pub fn DstreeredblackVector::to_string(self : DstreeredblackVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DstreeredblackFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_redblack_frame_make(size : Int) -> DstreeredblackFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreeredblackFrame::len(self : DstreeredblackFrame) -> Int { self.size }

pub fn DstreeredblackFrame::get(self : DstreeredblackFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreeredblackFrame::set(self : DstreeredblackFrame, i : Int, v : Double) -> DstreeredblackFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreeredblackFrame::sum(self : DstreeredblackFrame) -> Double { @_common.sum(self.data) }

pub fn DstreeredblackFrame::mean(self : DstreeredblackFrame) -> Double { @_common.mean(self.data) }

pub fn DstreeredblackFrame::scale(self : DstreeredblackFrame, f : Double) -> DstreeredblackFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreeredblackFrame::add(self : DstreeredblackFrame, other : DstreeredblackFrame) -> DstreeredblackFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreeredblackFrame::copy(self : DstreeredblackFrame) -> DstreeredblackFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreeredblackFrame::fill(self : DstreeredblackFrame, v : Double) -> DstreeredblackFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreeredblackFrame::min(self : DstreeredblackFrame) -> Double { @_common.min(self.data) }

pub fn DstreeredblackFrame::max(self : DstreeredblackFrame) -> Double { @_common.max(self.data) }

pub fn DstreeredblackFrame::to_string(self : DstreeredblackFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreeredblackTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_redblack_table_make(size : Int) -> DstreeredblackTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreeredblackTable::len(self : DstreeredblackTable) -> Int { self.size }

pub fn DstreeredblackTable::get(self : DstreeredblackTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreeredblackTable::set(self : DstreeredblackTable, i : Int, v : Double) -> DstreeredblackTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreeredblackTable::sum(self : DstreeredblackTable) -> Double { @_common.sum(self.data) }

pub fn DstreeredblackTable::mean(self : DstreeredblackTable) -> Double { @_common.mean(self.data) }

pub fn DstreeredblackTable::scale(self : DstreeredblackTable, f : Double) -> DstreeredblackTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreeredblackTable::add(self : DstreeredblackTable, other : DstreeredblackTable) -> DstreeredblackTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreeredblackTable::copy(self : DstreeredblackTable) -> DstreeredblackTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreeredblackTable::fill(self : DstreeredblackTable, v : Double) -> DstreeredblackTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreeredblackTable::min(self : DstreeredblackTable) -> Double { @_common.min(self.data) }

pub fn DstreeredblackTable::max(self : DstreeredblackTable) -> Double { @_common.max(self.data) }

pub fn DstreeredblackTable::to_string(self : DstreeredblackTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreeredblackGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_redblack_graphn_make(size : Int) -> DstreeredblackGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreeredblackGraphN::len(self : DstreeredblackGraphN) -> Int { self.size }

pub fn DstreeredblackGraphN::get(self : DstreeredblackGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreeredblackGraphN::set(self : DstreeredblackGraphN, i : Int, v : Double) -> DstreeredblackGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreeredblackGraphN::sum(self : DstreeredblackGraphN) -> Double { @_common.sum(self.data) }

pub fn DstreeredblackGraphN::mean(self : DstreeredblackGraphN) -> Double { @_common.mean(self.data) }

pub fn DstreeredblackGraphN::scale(self : DstreeredblackGraphN, f : Double) -> DstreeredblackGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreeredblackGraphN::add(self : DstreeredblackGraphN, other : DstreeredblackGraphN) -> DstreeredblackGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreeredblackGraphN::copy(self : DstreeredblackGraphN) -> DstreeredblackGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreeredblackGraphN::fill(self : DstreeredblackGraphN, v : Double) -> DstreeredblackGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreeredblackGraphN::min(self : DstreeredblackGraphN) -> Double { @_common.min(self.data) }

pub fn DstreeredblackGraphN::max(self : DstreeredblackGraphN) -> Double { @_common.max(self.data) }

pub fn DstreeredblackGraphN::to_string(self : DstreeredblackGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreeredblackNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_redblack_node_make(size : Int) -> DstreeredblackNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreeredblackNode::len(self : DstreeredblackNode) -> Int { self.size }

pub fn DstreeredblackNode::get(self : DstreeredblackNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreeredblackNode::set(self : DstreeredblackNode, i : Int, v : Double) -> DstreeredblackNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreeredblackNode::sum(self : DstreeredblackNode) -> Double { @_common.sum(self.data) }

pub fn DstreeredblackNode::mean(self : DstreeredblackNode) -> Double { @_common.mean(self.data) }

pub fn DstreeredblackNode::scale(self : DstreeredblackNode, f : Double) -> DstreeredblackNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreeredblackNode::add(self : DstreeredblackNode, other : DstreeredblackNode) -> DstreeredblackNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreeredblackNode::copy(self : DstreeredblackNode) -> DstreeredblackNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreeredblackNode::fill(self : DstreeredblackNode, v : Double) -> DstreeredblackNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreeredblackNode::min(self : DstreeredblackNode) -> Double { @_common.min(self.data) }

pub fn DstreeredblackNode::max(self : DstreeredblackNode) -> Double { @_common.max(self.data) }

pub fn DstreeredblackNode::to_string(self : DstreeredblackNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreeredblackEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_redblack_edge_make(size : Int) -> DstreeredblackEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreeredblackEdge::len(self : DstreeredblackEdge) -> Int { self.size }

pub fn DstreeredblackEdge::get(self : DstreeredblackEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreeredblackEdge::set(self : DstreeredblackEdge, i : Int, v : Double) -> DstreeredblackEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreeredblackEdge::sum(self : DstreeredblackEdge) -> Double { @_common.sum(self.data) }

pub fn DstreeredblackEdge::mean(self : DstreeredblackEdge) -> Double { @_common.mean(self.data) }

pub fn DstreeredblackEdge::scale(self : DstreeredblackEdge, f : Double) -> DstreeredblackEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreeredblackEdge::add(self : DstreeredblackEdge, other : DstreeredblackEdge) -> DstreeredblackEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreeredblackEdge::copy(self : DstreeredblackEdge) -> DstreeredblackEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreeredblackEdge::fill(self : DstreeredblackEdge, v : Double) -> DstreeredblackEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreeredblackEdge::min(self : DstreeredblackEdge) -> Double { @_common.min(self.data) }

pub fn DstreeredblackEdge::max(self : DstreeredblackEdge) -> Double { @_common.max(self.data) }

pub fn DstreeredblackEdge::to_string(self : DstreeredblackEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreeredblackPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_redblack_path_make(size : Int) -> DstreeredblackPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreeredblackPath::len(self : DstreeredblackPath) -> Int { self.size }

pub fn DstreeredblackPath::get(self : DstreeredblackPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreeredblackPath::set(self : DstreeredblackPath, i : Int, v : Double) -> DstreeredblackPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreeredblackPath::sum(self : DstreeredblackPath) -> Double { @_common.sum(self.data) }

pub fn DstreeredblackPath::mean(self : DstreeredblackPath) -> Double { @_common.mean(self.data) }

pub fn DstreeredblackPath::scale(self : DstreeredblackPath, f : Double) -> DstreeredblackPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreeredblackPath::add(self : DstreeredblackPath, other : DstreeredblackPath) -> DstreeredblackPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreeredblackPath::copy(self : DstreeredblackPath) -> DstreeredblackPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreeredblackPath::fill(self : DstreeredblackPath, v : Double) -> DstreeredblackPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreeredblackPath::min(self : DstreeredblackPath) -> Double { @_common.min(self.data) }

pub fn DstreeredblackPath::max(self : DstreeredblackPath) -> Double { @_common.max(self.data) }

pub fn DstreeredblackPath::to_string(self : DstreeredblackPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreeredblackCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_redblack_cluster_make(size : Int) -> DstreeredblackCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreeredblackCluster::len(self : DstreeredblackCluster) -> Int { self.size }

pub fn DstreeredblackCluster::get(self : DstreeredblackCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreeredblackCluster::set(self : DstreeredblackCluster, i : Int, v : Double) -> DstreeredblackCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreeredblackCluster::sum(self : DstreeredblackCluster) -> Double { @_common.sum(self.data) }

pub fn DstreeredblackCluster::mean(self : DstreeredblackCluster) -> Double { @_common.mean(self.data) }

pub fn DstreeredblackCluster::scale(self : DstreeredblackCluster, f : Double) -> DstreeredblackCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreeredblackCluster::add(self : DstreeredblackCluster, other : DstreeredblackCluster) -> DstreeredblackCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreeredblackCluster::copy(self : DstreeredblackCluster) -> DstreeredblackCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreeredblackCluster::fill(self : DstreeredblackCluster, v : Double) -> DstreeredblackCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreeredblackCluster::min(self : DstreeredblackCluster) -> Double { @_common.min(self.data) }

pub fn DstreeredblackCluster::max(self : DstreeredblackCluster) -> Double { @_common.max(self.data) }

pub fn DstreeredblackCluster::to_string(self : DstreeredblackCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreeredblackModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_redblack_model_make(size : Int) -> DstreeredblackModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreeredblackModel::len(self : DstreeredblackModel) -> Int { self.size }

pub fn DstreeredblackModel::get(self : DstreeredblackModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreeredblackModel::set(self : DstreeredblackModel, i : Int, v : Double) -> DstreeredblackModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreeredblackModel::sum(self : DstreeredblackModel) -> Double { @_common.sum(self.data) }

pub fn DstreeredblackModel::mean(self : DstreeredblackModel) -> Double { @_common.mean(self.data) }

pub fn DstreeredblackModel::scale(self : DstreeredblackModel, f : Double) -> DstreeredblackModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreeredblackModel::add(self : DstreeredblackModel, other : DstreeredblackModel) -> DstreeredblackModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreeredblackModel::copy(self : DstreeredblackModel) -> DstreeredblackModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreeredblackModel::fill(self : DstreeredblackModel, v : Double) -> DstreeredblackModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreeredblackModel::min(self : DstreeredblackModel) -> Double { @_common.min(self.data) }

pub fn DstreeredblackModel::max(self : DstreeredblackModel) -> Double { @_common.max(self.data) }

pub fn DstreeredblackModel::to_string(self : DstreeredblackModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreeredblackLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_redblack_layer_make(size : Int) -> DstreeredblackLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreeredblackLayer::len(self : DstreeredblackLayer) -> Int { self.size }

pub fn DstreeredblackLayer::get(self : DstreeredblackLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreeredblackLayer::set(self : DstreeredblackLayer, i : Int, v : Double) -> DstreeredblackLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreeredblackLayer::sum(self : DstreeredblackLayer) -> Double { @_common.sum(self.data) }

pub fn DstreeredblackLayer::mean(self : DstreeredblackLayer) -> Double { @_common.mean(self.data) }

pub fn DstreeredblackLayer::scale(self : DstreeredblackLayer, f : Double) -> DstreeredblackLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreeredblackLayer::add(self : DstreeredblackLayer, other : DstreeredblackLayer) -> DstreeredblackLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreeredblackLayer::copy(self : DstreeredblackLayer) -> DstreeredblackLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreeredblackLayer::fill(self : DstreeredblackLayer, v : Double) -> DstreeredblackLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreeredblackLayer::min(self : DstreeredblackLayer) -> Double { @_common.min(self.data) }

pub fn DstreeredblackLayer::max(self : DstreeredblackLayer) -> Double { @_common.max(self.data) }

pub fn DstreeredblackLayer::to_string(self : DstreeredblackLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreeredblackBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_redblack_buffer_make(size : Int) -> DstreeredblackBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreeredblackBuffer::len(self : DstreeredblackBuffer) -> Int { self.size }

pub fn DstreeredblackBuffer::get(self : DstreeredblackBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreeredblackBuffer::set(self : DstreeredblackBuffer, i : Int, v : Double) -> DstreeredblackBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreeredblackBuffer::sum(self : DstreeredblackBuffer) -> Double { @_common.sum(self.data) }

pub fn DstreeredblackBuffer::mean(self : DstreeredblackBuffer) -> Double { @_common.mean(self.data) }

pub fn DstreeredblackBuffer::scale(self : DstreeredblackBuffer, f : Double) -> DstreeredblackBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreeredblackBuffer::add(self : DstreeredblackBuffer, other : DstreeredblackBuffer) -> DstreeredblackBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreeredblackBuffer::copy(self : DstreeredblackBuffer) -> DstreeredblackBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreeredblackBuffer::fill(self : DstreeredblackBuffer, v : Double) -> DstreeredblackBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreeredblackBuffer::min(self : DstreeredblackBuffer) -> Double { @_common.min(self.data) }

pub fn DstreeredblackBuffer::max(self : DstreeredblackBuffer) -> Double { @_common.max(self.data) }

pub fn DstreeredblackBuffer::to_string(self : DstreeredblackBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreeredblackCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_redblack_cursor_make(size : Int) -> DstreeredblackCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreeredblackCursor::len(self : DstreeredblackCursor) -> Int { self.size }

pub fn DstreeredblackCursor::get(self : DstreeredblackCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreeredblackCursor::set(self : DstreeredblackCursor, i : Int, v : Double) -> DstreeredblackCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreeredblackCursor::sum(self : DstreeredblackCursor) -> Double { @_common.sum(self.data) }

pub fn DstreeredblackCursor::mean(self : DstreeredblackCursor) -> Double { @_common.mean(self.data) }

pub fn DstreeredblackCursor::scale(self : DstreeredblackCursor, f : Double) -> DstreeredblackCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreeredblackCursor::add(self : DstreeredblackCursor, other : DstreeredblackCursor) -> DstreeredblackCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreeredblackCursor::copy(self : DstreeredblackCursor) -> DstreeredblackCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreeredblackCursor::fill(self : DstreeredblackCursor, v : Double) -> DstreeredblackCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreeredblackCursor::min(self : DstreeredblackCursor) -> Double { @_common.min(self.data) }

pub fn DstreeredblackCursor::max(self : DstreeredblackCursor) -> Double { @_common.max(self.data) }

pub fn DstreeredblackCursor::to_string(self : DstreeredblackCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreeredblackView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_redblack_view_make(size : Int) -> DstreeredblackView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreeredblackView::len(self : DstreeredblackView) -> Int { self.size }

pub fn DstreeredblackView::get(self : DstreeredblackView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreeredblackView::set(self : DstreeredblackView, i : Int, v : Double) -> DstreeredblackView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreeredblackView::sum(self : DstreeredblackView) -> Double { @_common.sum(self.data) }

pub fn DstreeredblackView::mean(self : DstreeredblackView) -> Double { @_common.mean(self.data) }

pub fn DstreeredblackView::scale(self : DstreeredblackView, f : Double) -> DstreeredblackView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreeredblackView::add(self : DstreeredblackView, other : DstreeredblackView) -> DstreeredblackView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreeredblackView::copy(self : DstreeredblackView) -> DstreeredblackView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreeredblackView::fill(self : DstreeredblackView, v : Double) -> DstreeredblackView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreeredblackView::min(self : DstreeredblackView) -> Double { @_common.min(self.data) }

pub fn DstreeredblackView::max(self : DstreeredblackView) -> Double { @_common.max(self.data) }

pub fn DstreeredblackView::to_string(self : DstreeredblackView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreeredblackRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_redblack_range_make(size : Int) -> DstreeredblackRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreeredblackRange::len(self : DstreeredblackRange) -> Int { self.size }

pub fn DstreeredblackRange::get(self : DstreeredblackRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreeredblackRange::set(self : DstreeredblackRange, i : Int, v : Double) -> DstreeredblackRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreeredblackRange::sum(self : DstreeredblackRange) -> Double { @_common.sum(self.data) }

pub fn DstreeredblackRange::mean(self : DstreeredblackRange) -> Double { @_common.mean(self.data) }

pub fn DstreeredblackRange::scale(self : DstreeredblackRange, f : Double) -> DstreeredblackRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreeredblackRange::add(self : DstreeredblackRange, other : DstreeredblackRange) -> DstreeredblackRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreeredblackRange::copy(self : DstreeredblackRange) -> DstreeredblackRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreeredblackRange::fill(self : DstreeredblackRange, v : Double) -> DstreeredblackRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreeredblackRange::min(self : DstreeredblackRange) -> Double { @_common.min(self.data) }

pub fn DstreeredblackRange::max(self : DstreeredblackRange) -> Double { @_common.max(self.data) }

pub fn DstreeredblackRange::to_string(self : DstreeredblackRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreeredblackSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_redblack_slice_make(size : Int) -> DstreeredblackSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreeredblackSlice::len(self : DstreeredblackSlice) -> Int { self.size }

pub fn DstreeredblackSlice::get(self : DstreeredblackSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreeredblackSlice::set(self : DstreeredblackSlice, i : Int, v : Double) -> DstreeredblackSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreeredblackSlice::sum(self : DstreeredblackSlice) -> Double { @_common.sum(self.data) }

pub fn DstreeredblackSlice::mean(self : DstreeredblackSlice) -> Double { @_common.mean(self.data) }

pub fn DstreeredblackSlice::scale(self : DstreeredblackSlice, f : Double) -> DstreeredblackSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreeredblackSlice::add(self : DstreeredblackSlice, other : DstreeredblackSlice) -> DstreeredblackSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreeredblackSlice::copy(self : DstreeredblackSlice) -> DstreeredblackSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreeredblackSlice::fill(self : DstreeredblackSlice, v : Double) -> DstreeredblackSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreeredblackSlice::min(self : DstreeredblackSlice) -> Double { @_common.min(self.data) }

pub fn DstreeredblackSlice::max(self : DstreeredblackSlice) -> Double { @_common.max(self.data) }

pub fn DstreeredblackSlice::to_string(self : DstreeredblackSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

