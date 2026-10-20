///===
/// extcore/ds_list_xor

pub(all) struct DslistxorPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_list_xor_make_point(x : Double, y : Double) -> DslistxorPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_list_xor_make_point3(x : Double, y : Double, z : Double) -> DslistxorPoint {
  { x, y, z, label: 0 }
}

pub fn DslistxorPoint::x(self : DslistxorPoint) -> Double { self.x }

pub fn DslistxorPoint::y(self : DslistxorPoint) -> Double { self.y }

pub fn DslistxorPoint::z(self : DslistxorPoint) -> Double { self.z }

pub fn DslistxorPoint::label(self : DslistxorPoint) -> Int { self.label }

pub fn DslistxorPoint::dist(self : DslistxorPoint, other : DslistxorPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DslistxorPoint::add(self : DslistxorPoint, other : DslistxorPoint) -> DslistxorPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DslistxorPoint::sub(self : DslistxorPoint, other : DslistxorPoint) -> DslistxorPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DslistxorPoint::scale(self : DslistxorPoint, s : Double) -> DslistxorPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DslistxorPoint::dot(self : DslistxorPoint, other : DslistxorPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DslistxorPoint::cross(self : DslistxorPoint, other : DslistxorPoint) -> DslistxorPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DslistxorPoint::norm(self : DslistxorPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DslistxorPoint::normalize(self : DslistxorPoint) -> DslistxorPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DslistxorPoint::negate(self : DslistxorPoint) -> DslistxorPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DslistxorPoint::mid(self : DslistxorPoint, other : DslistxorPoint) -> DslistxorPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DslistxorPoint::lerp(self : DslistxorPoint, other : DslistxorPoint, t : Double) -> DslistxorPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DslistxorPoint::to_string(self : DslistxorPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DslistxorSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_list_xor_make_series(vals : Array[Double], name : String) -> DslistxorSeries {
  { vals, name, meta: 0 }
}

pub fn DslistxorSeries::len(self : DslistxorSeries) -> Int { self.vals.length() }

pub fn DslistxorSeries::sum(self : DslistxorSeries) -> Double { @_common.sum(self.vals) }

pub fn DslistxorSeries::mean(self : DslistxorSeries) -> Double { @_common.mean(self.vals) }

pub fn DslistxorSeries::min(self : DslistxorSeries) -> Double { @_common.min(self.vals) }

pub fn DslistxorSeries::max(self : DslistxorSeries) -> Double { @_common.max(self.vals) }

pub fn DslistxorSeries::range(self : DslistxorSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DslistxorSeries::variance(self : DslistxorSeries) -> Double { @_common.variance(self.vals) }

pub fn DslistxorSeries::std(self : DslistxorSeries) -> Double { @_common.std(self.vals) }

pub fn DslistxorSeries::median(self : DslistxorSeries) -> Double { @_common.median(self.vals) }

pub fn DslistxorSeries::scale(self : DslistxorSeries, f : Double) -> DslistxorSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DslistxorSeries::add(self : DslistxorSeries, other : DslistxorSeries) -> DslistxorSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DslistxorSeries::sub(self : DslistxorSeries, other : DslistxorSeries) -> DslistxorSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DslistxorSeries::normalize(self : DslistxorSeries) -> DslistxorSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DslistxorSeries::cumsum(self : DslistxorSeries) -> DslistxorSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DslistxorSeries::to_string(self : DslistxorSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DslistxorMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_list_xor_make_matrix(rows : Int, cols : Int, val : Double) -> DslistxorMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_list_xor_matrix_identity(n : Int) -> DslistxorMatrix {
  let m = ds_list_xor_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DslistxorMatrix::get(self : DslistxorMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DslistxorMatrix::transpose(self : DslistxorMatrix) -> DslistxorMatrix {
  let result = ds_list_xor_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DslistxorMatrix::add(self : DslistxorMatrix, other : DslistxorMatrix) -> DslistxorMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_list_xor_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DslistxorMatrix::scale(self : DslistxorMatrix, s : Double) -> DslistxorMatrix {
  let result = ds_list_xor_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DslistxorMatrix::multiply(self : DslistxorMatrix, other : DslistxorMatrix) -> DslistxorMatrix {
  if self.cols != other.rows { return ds_list_xor_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_list_xor_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn DslistxorMatrix::trace(self : DslistxorMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DslistxorMatrix::det(self : DslistxorMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DslistxorMatrix::norm(self : DslistxorMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DslistxorMatrix::to_string(self : DslistxorMatrix) -> String {
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

pub(all) struct DslistxorVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_list_xor_make_vector(comps : Array[Double]) -> DslistxorVector {
  { comps, dim: comps.length() }
}

pub fn ds_list_xor_vector_zero(dim : Int) -> DslistxorVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DslistxorVector::add(self : DslistxorVector, other : DslistxorVector) -> DslistxorVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DslistxorVector::sub(self : DslistxorVector, other : DslistxorVector) -> DslistxorVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DslistxorVector::scale(self : DslistxorVector, s : Double) -> DslistxorVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DslistxorVector::dot(self : DslistxorVector, other : DslistxorVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DslistxorVector::norm(self : DslistxorVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DslistxorVector::normalize(self : DslistxorVector) -> DslistxorVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DslistxorVector::dist(self : DslistxorVector, other : DslistxorVector) -> Double {
  self.sub(other).norm()
}

pub fn DslistxorVector::to_string(self : DslistxorVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DslistxorFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_xor_frame_make(size : Int) -> DslistxorFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistxorFrame::len(self : DslistxorFrame) -> Int { self.size }

pub fn DslistxorFrame::get(self : DslistxorFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistxorFrame::set(self : DslistxorFrame, i : Int, v : Double) -> DslistxorFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistxorFrame::sum(self : DslistxorFrame) -> Double { @_common.sum(self.data) }

pub fn DslistxorFrame::mean(self : DslistxorFrame) -> Double { @_common.mean(self.data) }

pub fn DslistxorFrame::scale(self : DslistxorFrame, f : Double) -> DslistxorFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistxorFrame::add(self : DslistxorFrame, other : DslistxorFrame) -> DslistxorFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistxorFrame::copy(self : DslistxorFrame) -> DslistxorFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistxorFrame::fill(self : DslistxorFrame, v : Double) -> DslistxorFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistxorFrame::min(self : DslistxorFrame) -> Double { @_common.min(self.data) }

pub fn DslistxorFrame::max(self : DslistxorFrame) -> Double { @_common.max(self.data) }

pub fn DslistxorFrame::to_string(self : DslistxorFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistxorTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_xor_table_make(size : Int) -> DslistxorTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistxorTable::len(self : DslistxorTable) -> Int { self.size }

pub fn DslistxorTable::get(self : DslistxorTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistxorTable::set(self : DslistxorTable, i : Int, v : Double) -> DslistxorTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistxorTable::sum(self : DslistxorTable) -> Double { @_common.sum(self.data) }

pub fn DslistxorTable::mean(self : DslistxorTable) -> Double { @_common.mean(self.data) }

pub fn DslistxorTable::scale(self : DslistxorTable, f : Double) -> DslistxorTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistxorTable::add(self : DslistxorTable, other : DslistxorTable) -> DslistxorTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistxorTable::copy(self : DslistxorTable) -> DslistxorTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistxorTable::fill(self : DslistxorTable, v : Double) -> DslistxorTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistxorTable::min(self : DslistxorTable) -> Double { @_common.min(self.data) }

pub fn DslistxorTable::max(self : DslistxorTable) -> Double { @_common.max(self.data) }

pub fn DslistxorTable::to_string(self : DslistxorTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistxorGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_xor_graphn_make(size : Int) -> DslistxorGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistxorGraphN::len(self : DslistxorGraphN) -> Int { self.size }

pub fn DslistxorGraphN::get(self : DslistxorGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistxorGraphN::set(self : DslistxorGraphN, i : Int, v : Double) -> DslistxorGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistxorGraphN::sum(self : DslistxorGraphN) -> Double { @_common.sum(self.data) }

pub fn DslistxorGraphN::mean(self : DslistxorGraphN) -> Double { @_common.mean(self.data) }

pub fn DslistxorGraphN::scale(self : DslistxorGraphN, f : Double) -> DslistxorGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistxorGraphN::add(self : DslistxorGraphN, other : DslistxorGraphN) -> DslistxorGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistxorGraphN::copy(self : DslistxorGraphN) -> DslistxorGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistxorGraphN::fill(self : DslistxorGraphN, v : Double) -> DslistxorGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistxorGraphN::min(self : DslistxorGraphN) -> Double { @_common.min(self.data) }

pub fn DslistxorGraphN::max(self : DslistxorGraphN) -> Double { @_common.max(self.data) }

pub fn DslistxorGraphN::to_string(self : DslistxorGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistxorNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_xor_node_make(size : Int) -> DslistxorNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistxorNode::len(self : DslistxorNode) -> Int { self.size }

pub fn DslistxorNode::get(self : DslistxorNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistxorNode::set(self : DslistxorNode, i : Int, v : Double) -> DslistxorNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistxorNode::sum(self : DslistxorNode) -> Double { @_common.sum(self.data) }

pub fn DslistxorNode::mean(self : DslistxorNode) -> Double { @_common.mean(self.data) }

pub fn DslistxorNode::scale(self : DslistxorNode, f : Double) -> DslistxorNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistxorNode::add(self : DslistxorNode, other : DslistxorNode) -> DslistxorNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistxorNode::copy(self : DslistxorNode) -> DslistxorNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistxorNode::fill(self : DslistxorNode, v : Double) -> DslistxorNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistxorNode::min(self : DslistxorNode) -> Double { @_common.min(self.data) }

pub fn DslistxorNode::max(self : DslistxorNode) -> Double { @_common.max(self.data) }

pub fn DslistxorNode::to_string(self : DslistxorNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistxorEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_xor_edge_make(size : Int) -> DslistxorEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistxorEdge::len(self : DslistxorEdge) -> Int { self.size }

pub fn DslistxorEdge::get(self : DslistxorEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistxorEdge::set(self : DslistxorEdge, i : Int, v : Double) -> DslistxorEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistxorEdge::sum(self : DslistxorEdge) -> Double { @_common.sum(self.data) }

pub fn DslistxorEdge::mean(self : DslistxorEdge) -> Double { @_common.mean(self.data) }

pub fn DslistxorEdge::scale(self : DslistxorEdge, f : Double) -> DslistxorEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistxorEdge::add(self : DslistxorEdge, other : DslistxorEdge) -> DslistxorEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistxorEdge::copy(self : DslistxorEdge) -> DslistxorEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistxorEdge::fill(self : DslistxorEdge, v : Double) -> DslistxorEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistxorEdge::min(self : DslistxorEdge) -> Double { @_common.min(self.data) }

pub fn DslistxorEdge::max(self : DslistxorEdge) -> Double { @_common.max(self.data) }

pub fn DslistxorEdge::to_string(self : DslistxorEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistxorPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_xor_path_make(size : Int) -> DslistxorPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistxorPath::len(self : DslistxorPath) -> Int { self.size }

pub fn DslistxorPath::get(self : DslistxorPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistxorPath::set(self : DslistxorPath, i : Int, v : Double) -> DslistxorPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistxorPath::sum(self : DslistxorPath) -> Double { @_common.sum(self.data) }

pub fn DslistxorPath::mean(self : DslistxorPath) -> Double { @_common.mean(self.data) }

pub fn DslistxorPath::scale(self : DslistxorPath, f : Double) -> DslistxorPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistxorPath::add(self : DslistxorPath, other : DslistxorPath) -> DslistxorPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistxorPath::copy(self : DslistxorPath) -> DslistxorPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistxorPath::fill(self : DslistxorPath, v : Double) -> DslistxorPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistxorPath::min(self : DslistxorPath) -> Double { @_common.min(self.data) }

pub fn DslistxorPath::max(self : DslistxorPath) -> Double { @_common.max(self.data) }

pub fn DslistxorPath::to_string(self : DslistxorPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistxorCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_xor_cluster_make(size : Int) -> DslistxorCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistxorCluster::len(self : DslistxorCluster) -> Int { self.size }

pub fn DslistxorCluster::get(self : DslistxorCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistxorCluster::set(self : DslistxorCluster, i : Int, v : Double) -> DslistxorCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistxorCluster::sum(self : DslistxorCluster) -> Double { @_common.sum(self.data) }

pub fn DslistxorCluster::mean(self : DslistxorCluster) -> Double { @_common.mean(self.data) }

pub fn DslistxorCluster::scale(self : DslistxorCluster, f : Double) -> DslistxorCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistxorCluster::add(self : DslistxorCluster, other : DslistxorCluster) -> DslistxorCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistxorCluster::copy(self : DslistxorCluster) -> DslistxorCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistxorCluster::fill(self : DslistxorCluster, v : Double) -> DslistxorCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistxorCluster::min(self : DslistxorCluster) -> Double { @_common.min(self.data) }

pub fn DslistxorCluster::max(self : DslistxorCluster) -> Double { @_common.max(self.data) }

pub fn DslistxorCluster::to_string(self : DslistxorCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistxorModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_xor_model_make(size : Int) -> DslistxorModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistxorModel::len(self : DslistxorModel) -> Int { self.size }

pub fn DslistxorModel::get(self : DslistxorModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistxorModel::set(self : DslistxorModel, i : Int, v : Double) -> DslistxorModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistxorModel::sum(self : DslistxorModel) -> Double { @_common.sum(self.data) }

pub fn DslistxorModel::mean(self : DslistxorModel) -> Double { @_common.mean(self.data) }

pub fn DslistxorModel::scale(self : DslistxorModel, f : Double) -> DslistxorModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistxorModel::add(self : DslistxorModel, other : DslistxorModel) -> DslistxorModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistxorModel::copy(self : DslistxorModel) -> DslistxorModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistxorModel::fill(self : DslistxorModel, v : Double) -> DslistxorModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistxorModel::min(self : DslistxorModel) -> Double { @_common.min(self.data) }

pub fn DslistxorModel::max(self : DslistxorModel) -> Double { @_common.max(self.data) }

pub fn DslistxorModel::to_string(self : DslistxorModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistxorLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_xor_layer_make(size : Int) -> DslistxorLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistxorLayer::len(self : DslistxorLayer) -> Int { self.size }

pub fn DslistxorLayer::get(self : DslistxorLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistxorLayer::set(self : DslistxorLayer, i : Int, v : Double) -> DslistxorLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistxorLayer::sum(self : DslistxorLayer) -> Double { @_common.sum(self.data) }

pub fn DslistxorLayer::mean(self : DslistxorLayer) -> Double { @_common.mean(self.data) }

pub fn DslistxorLayer::scale(self : DslistxorLayer, f : Double) -> DslistxorLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistxorLayer::add(self : DslistxorLayer, other : DslistxorLayer) -> DslistxorLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistxorLayer::copy(self : DslistxorLayer) -> DslistxorLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistxorLayer::fill(self : DslistxorLayer, v : Double) -> DslistxorLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistxorLayer::min(self : DslistxorLayer) -> Double { @_common.min(self.data) }

pub fn DslistxorLayer::max(self : DslistxorLayer) -> Double { @_common.max(self.data) }

pub fn DslistxorLayer::to_string(self : DslistxorLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistxorBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_xor_buffer_make(size : Int) -> DslistxorBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistxorBuffer::len(self : DslistxorBuffer) -> Int { self.size }

pub fn DslistxorBuffer::get(self : DslistxorBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistxorBuffer::set(self : DslistxorBuffer, i : Int, v : Double) -> DslistxorBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistxorBuffer::sum(self : DslistxorBuffer) -> Double { @_common.sum(self.data) }

pub fn DslistxorBuffer::mean(self : DslistxorBuffer) -> Double { @_common.mean(self.data) }

pub fn DslistxorBuffer::scale(self : DslistxorBuffer, f : Double) -> DslistxorBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistxorBuffer::add(self : DslistxorBuffer, other : DslistxorBuffer) -> DslistxorBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistxorBuffer::copy(self : DslistxorBuffer) -> DslistxorBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistxorBuffer::fill(self : DslistxorBuffer, v : Double) -> DslistxorBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistxorBuffer::min(self : DslistxorBuffer) -> Double { @_common.min(self.data) }

pub fn DslistxorBuffer::max(self : DslistxorBuffer) -> Double { @_common.max(self.data) }

pub fn DslistxorBuffer::to_string(self : DslistxorBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistxorCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_xor_cursor_make(size : Int) -> DslistxorCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistxorCursor::len(self : DslistxorCursor) -> Int { self.size }

pub fn DslistxorCursor::get(self : DslistxorCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistxorCursor::set(self : DslistxorCursor, i : Int, v : Double) -> DslistxorCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistxorCursor::sum(self : DslistxorCursor) -> Double { @_common.sum(self.data) }

pub fn DslistxorCursor::mean(self : DslistxorCursor) -> Double { @_common.mean(self.data) }

pub fn DslistxorCursor::scale(self : DslistxorCursor, f : Double) -> DslistxorCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistxorCursor::add(self : DslistxorCursor, other : DslistxorCursor) -> DslistxorCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistxorCursor::copy(self : DslistxorCursor) -> DslistxorCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistxorCursor::fill(self : DslistxorCursor, v : Double) -> DslistxorCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistxorCursor::min(self : DslistxorCursor) -> Double { @_common.min(self.data) }

pub fn DslistxorCursor::max(self : DslistxorCursor) -> Double { @_common.max(self.data) }

pub fn DslistxorCursor::to_string(self : DslistxorCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistxorView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_xor_view_make(size : Int) -> DslistxorView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistxorView::len(self : DslistxorView) -> Int { self.size }

pub fn DslistxorView::get(self : DslistxorView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistxorView::set(self : DslistxorView, i : Int, v : Double) -> DslistxorView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistxorView::sum(self : DslistxorView) -> Double { @_common.sum(self.data) }

pub fn DslistxorView::mean(self : DslistxorView) -> Double { @_common.mean(self.data) }

pub fn DslistxorView::scale(self : DslistxorView, f : Double) -> DslistxorView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistxorView::add(self : DslistxorView, other : DslistxorView) -> DslistxorView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistxorView::copy(self : DslistxorView) -> DslistxorView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistxorView::fill(self : DslistxorView, v : Double) -> DslistxorView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistxorView::min(self : DslistxorView) -> Double { @_common.min(self.data) }

pub fn DslistxorView::max(self : DslistxorView) -> Double { @_common.max(self.data) }

pub fn DslistxorView::to_string(self : DslistxorView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistxorRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_xor_range_make(size : Int) -> DslistxorRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistxorRange::len(self : DslistxorRange) -> Int { self.size }

pub fn DslistxorRange::get(self : DslistxorRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistxorRange::set(self : DslistxorRange, i : Int, v : Double) -> DslistxorRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistxorRange::sum(self : DslistxorRange) -> Double { @_common.sum(self.data) }

pub fn DslistxorRange::mean(self : DslistxorRange) -> Double { @_common.mean(self.data) }

pub fn DslistxorRange::scale(self : DslistxorRange, f : Double) -> DslistxorRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistxorRange::add(self : DslistxorRange, other : DslistxorRange) -> DslistxorRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistxorRange::copy(self : DslistxorRange) -> DslistxorRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistxorRange::fill(self : DslistxorRange, v : Double) -> DslistxorRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistxorRange::min(self : DslistxorRange) -> Double { @_common.min(self.data) }

pub fn DslistxorRange::max(self : DslistxorRange) -> Double { @_common.max(self.data) }

pub fn DslistxorRange::to_string(self : DslistxorRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistxorSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_xor_slice_make(size : Int) -> DslistxorSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistxorSlice::len(self : DslistxorSlice) -> Int { self.size }

pub fn DslistxorSlice::get(self : DslistxorSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistxorSlice::set(self : DslistxorSlice, i : Int, v : Double) -> DslistxorSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistxorSlice::sum(self : DslistxorSlice) -> Double { @_common.sum(self.data) }

pub fn DslistxorSlice::mean(self : DslistxorSlice) -> Double { @_common.mean(self.data) }

pub fn DslistxorSlice::scale(self : DslistxorSlice, f : Double) -> DslistxorSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistxorSlice::add(self : DslistxorSlice, other : DslistxorSlice) -> DslistxorSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistxorSlice::copy(self : DslistxorSlice) -> DslistxorSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistxorSlice::fill(self : DslistxorSlice, v : Double) -> DslistxorSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistxorSlice::min(self : DslistxorSlice) -> Double { @_common.min(self.data) }

pub fn DslistxorSlice::max(self : DslistxorSlice) -> Double { @_common.max(self.data) }

pub fn DslistxorSlice::to_string(self : DslistxorSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

