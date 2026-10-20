///===
/// extcore/ds_heap_d_ary

pub(all) struct DsheapdaryPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_heap_d_ary_make_point(x : Double, y : Double) -> DsheapdaryPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_heap_d_ary_make_point3(x : Double, y : Double, z : Double) -> DsheapdaryPoint {
  { x, y, z, label: 0 }
}

pub fn DsheapdaryPoint::x(self : DsheapdaryPoint) -> Double { self.x }

pub fn DsheapdaryPoint::y(self : DsheapdaryPoint) -> Double { self.y }

pub fn DsheapdaryPoint::z(self : DsheapdaryPoint) -> Double { self.z }

pub fn DsheapdaryPoint::label(self : DsheapdaryPoint) -> Int { self.label }

pub fn DsheapdaryPoint::dist(self : DsheapdaryPoint, other : DsheapdaryPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DsheapdaryPoint::add(self : DsheapdaryPoint, other : DsheapdaryPoint) -> DsheapdaryPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DsheapdaryPoint::sub(self : DsheapdaryPoint, other : DsheapdaryPoint) -> DsheapdaryPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DsheapdaryPoint::scale(self : DsheapdaryPoint, s : Double) -> DsheapdaryPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DsheapdaryPoint::dot(self : DsheapdaryPoint, other : DsheapdaryPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DsheapdaryPoint::cross(self : DsheapdaryPoint, other : DsheapdaryPoint) -> DsheapdaryPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DsheapdaryPoint::norm(self : DsheapdaryPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DsheapdaryPoint::normalize(self : DsheapdaryPoint) -> DsheapdaryPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsheapdaryPoint::negate(self : DsheapdaryPoint) -> DsheapdaryPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DsheapdaryPoint::mid(self : DsheapdaryPoint, other : DsheapdaryPoint) -> DsheapdaryPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DsheapdaryPoint::lerp(self : DsheapdaryPoint, other : DsheapdaryPoint, t : Double) -> DsheapdaryPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DsheapdaryPoint::to_string(self : DsheapdaryPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DsheapdarySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_heap_d_ary_make_series(vals : Array[Double], name : String) -> DsheapdarySeries {
  { vals, name, meta: 0 }
}

pub fn DsheapdarySeries::len(self : DsheapdarySeries) -> Int { self.vals.length() }

pub fn DsheapdarySeries::sum(self : DsheapdarySeries) -> Double { @_common.sum(self.vals) }

pub fn DsheapdarySeries::mean(self : DsheapdarySeries) -> Double { @_common.mean(self.vals) }

pub fn DsheapdarySeries::min(self : DsheapdarySeries) -> Double { @_common.min(self.vals) }

pub fn DsheapdarySeries::max(self : DsheapdarySeries) -> Double { @_common.max(self.vals) }

pub fn DsheapdarySeries::range(self : DsheapdarySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DsheapdarySeries::variance(self : DsheapdarySeries) -> Double { @_common.variance(self.vals) }

pub fn DsheapdarySeries::std(self : DsheapdarySeries) -> Double { @_common.std(self.vals) }

pub fn DsheapdarySeries::median(self : DsheapdarySeries) -> Double { @_common.median(self.vals) }

pub fn DsheapdarySeries::scale(self : DsheapdarySeries, f : Double) -> DsheapdarySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DsheapdarySeries::add(self : DsheapdarySeries, other : DsheapdarySeries) -> DsheapdarySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DsheapdarySeries::sub(self : DsheapdarySeries, other : DsheapdarySeries) -> DsheapdarySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DsheapdarySeries::normalize(self : DsheapdarySeries) -> DsheapdarySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DsheapdarySeries::cumsum(self : DsheapdarySeries) -> DsheapdarySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DsheapdarySeries::to_string(self : DsheapdarySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsheapdaryMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_heap_d_ary_make_matrix(rows : Int, cols : Int, val : Double) -> DsheapdaryMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_heap_d_ary_matrix_identity(n : Int) -> DsheapdaryMatrix {
  let m = ds_heap_d_ary_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DsheapdaryMatrix::get(self : DsheapdaryMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DsheapdaryMatrix::transpose(self : DsheapdaryMatrix) -> DsheapdaryMatrix {
  let result = ds_heap_d_ary_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DsheapdaryMatrix::add(self : DsheapdaryMatrix, other : DsheapdaryMatrix) -> DsheapdaryMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_heap_d_ary_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DsheapdaryMatrix::scale(self : DsheapdaryMatrix, s : Double) -> DsheapdaryMatrix {
  let result = ds_heap_d_ary_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DsheapdaryMatrix::multiply(self : DsheapdaryMatrix, other : DsheapdaryMatrix) -> DsheapdaryMatrix {
  if self.cols != other.rows { return ds_heap_d_ary_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_heap_d_ary_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DsheapdaryMatrix::trace(self : DsheapdaryMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DsheapdaryMatrix::det(self : DsheapdaryMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DsheapdaryMatrix::norm(self : DsheapdaryMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DsheapdaryMatrix::to_string(self : DsheapdaryMatrix) -> String {
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

pub(all) struct DsheapdaryVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_heap_d_ary_make_vector(comps : Array[Double]) -> DsheapdaryVector {
  { comps, dim: comps.length() }
}

pub fn ds_heap_d_ary_vector_zero(dim : Int) -> DsheapdaryVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DsheapdaryVector::add(self : DsheapdaryVector, other : DsheapdaryVector) -> DsheapdaryVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DsheapdaryVector::sub(self : DsheapdaryVector, other : DsheapdaryVector) -> DsheapdaryVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DsheapdaryVector::scale(self : DsheapdaryVector, s : Double) -> DsheapdaryVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DsheapdaryVector::dot(self : DsheapdaryVector, other : DsheapdaryVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DsheapdaryVector::norm(self : DsheapdaryVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DsheapdaryVector::normalize(self : DsheapdaryVector) -> DsheapdaryVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsheapdaryVector::dist(self : DsheapdaryVector, other : DsheapdaryVector) -> Double {
  self.sub(other).norm()
}

pub fn DsheapdaryVector::to_string(self : DsheapdaryVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsheapdaryFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_d_ary_frame_make(size : Int) -> DsheapdaryFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapdaryFrame::len(self : DsheapdaryFrame) -> Int { self.size }

pub fn DsheapdaryFrame::get(self : DsheapdaryFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapdaryFrame::set(self : DsheapdaryFrame, i : Int, v : Double) -> DsheapdaryFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapdaryFrame::sum(self : DsheapdaryFrame) -> Double { @_common.sum(self.data) }

pub fn DsheapdaryFrame::mean(self : DsheapdaryFrame) -> Double { @_common.mean(self.data) }

pub fn DsheapdaryFrame::scale(self : DsheapdaryFrame, f : Double) -> DsheapdaryFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapdaryFrame::add(self : DsheapdaryFrame, other : DsheapdaryFrame) -> DsheapdaryFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapdaryFrame::copy(self : DsheapdaryFrame) -> DsheapdaryFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapdaryFrame::fill(self : DsheapdaryFrame, v : Double) -> DsheapdaryFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapdaryFrame::min(self : DsheapdaryFrame) -> Double { @_common.min(self.data) }

pub fn DsheapdaryFrame::max(self : DsheapdaryFrame) -> Double { @_common.max(self.data) }

pub fn DsheapdaryFrame::to_string(self : DsheapdaryFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapdaryTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_d_ary_table_make(size : Int) -> DsheapdaryTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapdaryTable::len(self : DsheapdaryTable) -> Int { self.size }

pub fn DsheapdaryTable::get(self : DsheapdaryTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapdaryTable::set(self : DsheapdaryTable, i : Int, v : Double) -> DsheapdaryTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapdaryTable::sum(self : DsheapdaryTable) -> Double { @_common.sum(self.data) }

pub fn DsheapdaryTable::mean(self : DsheapdaryTable) -> Double { @_common.mean(self.data) }

pub fn DsheapdaryTable::scale(self : DsheapdaryTable, f : Double) -> DsheapdaryTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapdaryTable::add(self : DsheapdaryTable, other : DsheapdaryTable) -> DsheapdaryTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapdaryTable::copy(self : DsheapdaryTable) -> DsheapdaryTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapdaryTable::fill(self : DsheapdaryTable, v : Double) -> DsheapdaryTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapdaryTable::min(self : DsheapdaryTable) -> Double { @_common.min(self.data) }

pub fn DsheapdaryTable::max(self : DsheapdaryTable) -> Double { @_common.max(self.data) }

pub fn DsheapdaryTable::to_string(self : DsheapdaryTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapdaryGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_d_ary_graphn_make(size : Int) -> DsheapdaryGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapdaryGraphN::len(self : DsheapdaryGraphN) -> Int { self.size }

pub fn DsheapdaryGraphN::get(self : DsheapdaryGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapdaryGraphN::set(self : DsheapdaryGraphN, i : Int, v : Double) -> DsheapdaryGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapdaryGraphN::sum(self : DsheapdaryGraphN) -> Double { @_common.sum(self.data) }

pub fn DsheapdaryGraphN::mean(self : DsheapdaryGraphN) -> Double { @_common.mean(self.data) }

pub fn DsheapdaryGraphN::scale(self : DsheapdaryGraphN, f : Double) -> DsheapdaryGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapdaryGraphN::add(self : DsheapdaryGraphN, other : DsheapdaryGraphN) -> DsheapdaryGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapdaryGraphN::copy(self : DsheapdaryGraphN) -> DsheapdaryGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapdaryGraphN::fill(self : DsheapdaryGraphN, v : Double) -> DsheapdaryGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapdaryGraphN::min(self : DsheapdaryGraphN) -> Double { @_common.min(self.data) }

pub fn DsheapdaryGraphN::max(self : DsheapdaryGraphN) -> Double { @_common.max(self.data) }

pub fn DsheapdaryGraphN::to_string(self : DsheapdaryGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapdaryNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_d_ary_node_make(size : Int) -> DsheapdaryNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapdaryNode::len(self : DsheapdaryNode) -> Int { self.size }

pub fn DsheapdaryNode::get(self : DsheapdaryNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapdaryNode::set(self : DsheapdaryNode, i : Int, v : Double) -> DsheapdaryNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapdaryNode::sum(self : DsheapdaryNode) -> Double { @_common.sum(self.data) }

pub fn DsheapdaryNode::mean(self : DsheapdaryNode) -> Double { @_common.mean(self.data) }

pub fn DsheapdaryNode::scale(self : DsheapdaryNode, f : Double) -> DsheapdaryNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapdaryNode::add(self : DsheapdaryNode, other : DsheapdaryNode) -> DsheapdaryNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapdaryNode::copy(self : DsheapdaryNode) -> DsheapdaryNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapdaryNode::fill(self : DsheapdaryNode, v : Double) -> DsheapdaryNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapdaryNode::min(self : DsheapdaryNode) -> Double { @_common.min(self.data) }

pub fn DsheapdaryNode::max(self : DsheapdaryNode) -> Double { @_common.max(self.data) }

pub fn DsheapdaryNode::to_string(self : DsheapdaryNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapdaryEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_d_ary_edge_make(size : Int) -> DsheapdaryEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapdaryEdge::len(self : DsheapdaryEdge) -> Int { self.size }

pub fn DsheapdaryEdge::get(self : DsheapdaryEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapdaryEdge::set(self : DsheapdaryEdge, i : Int, v : Double) -> DsheapdaryEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapdaryEdge::sum(self : DsheapdaryEdge) -> Double { @_common.sum(self.data) }

pub fn DsheapdaryEdge::mean(self : DsheapdaryEdge) -> Double { @_common.mean(self.data) }

pub fn DsheapdaryEdge::scale(self : DsheapdaryEdge, f : Double) -> DsheapdaryEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapdaryEdge::add(self : DsheapdaryEdge, other : DsheapdaryEdge) -> DsheapdaryEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapdaryEdge::copy(self : DsheapdaryEdge) -> DsheapdaryEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapdaryEdge::fill(self : DsheapdaryEdge, v : Double) -> DsheapdaryEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapdaryEdge::min(self : DsheapdaryEdge) -> Double { @_common.min(self.data) }

pub fn DsheapdaryEdge::max(self : DsheapdaryEdge) -> Double { @_common.max(self.data) }

pub fn DsheapdaryEdge::to_string(self : DsheapdaryEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapdaryPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_d_ary_path_make(size : Int) -> DsheapdaryPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapdaryPath::len(self : DsheapdaryPath) -> Int { self.size }

pub fn DsheapdaryPath::get(self : DsheapdaryPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapdaryPath::set(self : DsheapdaryPath, i : Int, v : Double) -> DsheapdaryPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapdaryPath::sum(self : DsheapdaryPath) -> Double { @_common.sum(self.data) }

pub fn DsheapdaryPath::mean(self : DsheapdaryPath) -> Double { @_common.mean(self.data) }

pub fn DsheapdaryPath::scale(self : DsheapdaryPath, f : Double) -> DsheapdaryPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapdaryPath::add(self : DsheapdaryPath, other : DsheapdaryPath) -> DsheapdaryPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapdaryPath::copy(self : DsheapdaryPath) -> DsheapdaryPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapdaryPath::fill(self : DsheapdaryPath, v : Double) -> DsheapdaryPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapdaryPath::min(self : DsheapdaryPath) -> Double { @_common.min(self.data) }

pub fn DsheapdaryPath::max(self : DsheapdaryPath) -> Double { @_common.max(self.data) }

pub fn DsheapdaryPath::to_string(self : DsheapdaryPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapdaryCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_d_ary_cluster_make(size : Int) -> DsheapdaryCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapdaryCluster::len(self : DsheapdaryCluster) -> Int { self.size }

pub fn DsheapdaryCluster::get(self : DsheapdaryCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapdaryCluster::set(self : DsheapdaryCluster, i : Int, v : Double) -> DsheapdaryCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapdaryCluster::sum(self : DsheapdaryCluster) -> Double { @_common.sum(self.data) }

pub fn DsheapdaryCluster::mean(self : DsheapdaryCluster) -> Double { @_common.mean(self.data) }

pub fn DsheapdaryCluster::scale(self : DsheapdaryCluster, f : Double) -> DsheapdaryCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapdaryCluster::add(self : DsheapdaryCluster, other : DsheapdaryCluster) -> DsheapdaryCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapdaryCluster::copy(self : DsheapdaryCluster) -> DsheapdaryCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapdaryCluster::fill(self : DsheapdaryCluster, v : Double) -> DsheapdaryCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapdaryCluster::min(self : DsheapdaryCluster) -> Double { @_common.min(self.data) }

pub fn DsheapdaryCluster::max(self : DsheapdaryCluster) -> Double { @_common.max(self.data) }

pub fn DsheapdaryCluster::to_string(self : DsheapdaryCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapdaryModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_d_ary_model_make(size : Int) -> DsheapdaryModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapdaryModel::len(self : DsheapdaryModel) -> Int { self.size }

pub fn DsheapdaryModel::get(self : DsheapdaryModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapdaryModel::set(self : DsheapdaryModel, i : Int, v : Double) -> DsheapdaryModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapdaryModel::sum(self : DsheapdaryModel) -> Double { @_common.sum(self.data) }

pub fn DsheapdaryModel::mean(self : DsheapdaryModel) -> Double { @_common.mean(self.data) }

pub fn DsheapdaryModel::scale(self : DsheapdaryModel, f : Double) -> DsheapdaryModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapdaryModel::add(self : DsheapdaryModel, other : DsheapdaryModel) -> DsheapdaryModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapdaryModel::copy(self : DsheapdaryModel) -> DsheapdaryModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapdaryModel::fill(self : DsheapdaryModel, v : Double) -> DsheapdaryModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapdaryModel::min(self : DsheapdaryModel) -> Double { @_common.min(self.data) }

pub fn DsheapdaryModel::max(self : DsheapdaryModel) -> Double { @_common.max(self.data) }

pub fn DsheapdaryModel::to_string(self : DsheapdaryModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapdaryLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_d_ary_layer_make(size : Int) -> DsheapdaryLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapdaryLayer::len(self : DsheapdaryLayer) -> Int { self.size }

pub fn DsheapdaryLayer::get(self : DsheapdaryLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapdaryLayer::set(self : DsheapdaryLayer, i : Int, v : Double) -> DsheapdaryLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapdaryLayer::sum(self : DsheapdaryLayer) -> Double { @_common.sum(self.data) }

pub fn DsheapdaryLayer::mean(self : DsheapdaryLayer) -> Double { @_common.mean(self.data) }

pub fn DsheapdaryLayer::scale(self : DsheapdaryLayer, f : Double) -> DsheapdaryLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapdaryLayer::add(self : DsheapdaryLayer, other : DsheapdaryLayer) -> DsheapdaryLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapdaryLayer::copy(self : DsheapdaryLayer) -> DsheapdaryLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapdaryLayer::fill(self : DsheapdaryLayer, v : Double) -> DsheapdaryLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapdaryLayer::min(self : DsheapdaryLayer) -> Double { @_common.min(self.data) }

pub fn DsheapdaryLayer::max(self : DsheapdaryLayer) -> Double { @_common.max(self.data) }

pub fn DsheapdaryLayer::to_string(self : DsheapdaryLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapdaryBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_d_ary_buffer_make(size : Int) -> DsheapdaryBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapdaryBuffer::len(self : DsheapdaryBuffer) -> Int { self.size }

pub fn DsheapdaryBuffer::get(self : DsheapdaryBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapdaryBuffer::set(self : DsheapdaryBuffer, i : Int, v : Double) -> DsheapdaryBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapdaryBuffer::sum(self : DsheapdaryBuffer) -> Double { @_common.sum(self.data) }

pub fn DsheapdaryBuffer::mean(self : DsheapdaryBuffer) -> Double { @_common.mean(self.data) }

pub fn DsheapdaryBuffer::scale(self : DsheapdaryBuffer, f : Double) -> DsheapdaryBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapdaryBuffer::add(self : DsheapdaryBuffer, other : DsheapdaryBuffer) -> DsheapdaryBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapdaryBuffer::copy(self : DsheapdaryBuffer) -> DsheapdaryBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapdaryBuffer::fill(self : DsheapdaryBuffer, v : Double) -> DsheapdaryBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapdaryBuffer::min(self : DsheapdaryBuffer) -> Double { @_common.min(self.data) }

pub fn DsheapdaryBuffer::max(self : DsheapdaryBuffer) -> Double { @_common.max(self.data) }

pub fn DsheapdaryBuffer::to_string(self : DsheapdaryBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapdaryCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_d_ary_cursor_make(size : Int) -> DsheapdaryCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapdaryCursor::len(self : DsheapdaryCursor) -> Int { self.size }

pub fn DsheapdaryCursor::get(self : DsheapdaryCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapdaryCursor::set(self : DsheapdaryCursor, i : Int, v : Double) -> DsheapdaryCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapdaryCursor::sum(self : DsheapdaryCursor) -> Double { @_common.sum(self.data) }

pub fn DsheapdaryCursor::mean(self : DsheapdaryCursor) -> Double { @_common.mean(self.data) }

pub fn DsheapdaryCursor::scale(self : DsheapdaryCursor, f : Double) -> DsheapdaryCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapdaryCursor::add(self : DsheapdaryCursor, other : DsheapdaryCursor) -> DsheapdaryCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapdaryCursor::copy(self : DsheapdaryCursor) -> DsheapdaryCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapdaryCursor::fill(self : DsheapdaryCursor, v : Double) -> DsheapdaryCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapdaryCursor::min(self : DsheapdaryCursor) -> Double { @_common.min(self.data) }

pub fn DsheapdaryCursor::max(self : DsheapdaryCursor) -> Double { @_common.max(self.data) }

pub fn DsheapdaryCursor::to_string(self : DsheapdaryCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapdaryView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_d_ary_view_make(size : Int) -> DsheapdaryView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapdaryView::len(self : DsheapdaryView) -> Int { self.size }

pub fn DsheapdaryView::get(self : DsheapdaryView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapdaryView::set(self : DsheapdaryView, i : Int, v : Double) -> DsheapdaryView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapdaryView::sum(self : DsheapdaryView) -> Double { @_common.sum(self.data) }

pub fn DsheapdaryView::mean(self : DsheapdaryView) -> Double { @_common.mean(self.data) }

pub fn DsheapdaryView::scale(self : DsheapdaryView, f : Double) -> DsheapdaryView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapdaryView::add(self : DsheapdaryView, other : DsheapdaryView) -> DsheapdaryView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapdaryView::copy(self : DsheapdaryView) -> DsheapdaryView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapdaryView::fill(self : DsheapdaryView, v : Double) -> DsheapdaryView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapdaryView::min(self : DsheapdaryView) -> Double { @_common.min(self.data) }

pub fn DsheapdaryView::max(self : DsheapdaryView) -> Double { @_common.max(self.data) }

pub fn DsheapdaryView::to_string(self : DsheapdaryView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapdaryRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_d_ary_range_make(size : Int) -> DsheapdaryRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapdaryRange::len(self : DsheapdaryRange) -> Int { self.size }

pub fn DsheapdaryRange::get(self : DsheapdaryRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapdaryRange::set(self : DsheapdaryRange, i : Int, v : Double) -> DsheapdaryRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapdaryRange::sum(self : DsheapdaryRange) -> Double { @_common.sum(self.data) }

pub fn DsheapdaryRange::mean(self : DsheapdaryRange) -> Double { @_common.mean(self.data) }

pub fn DsheapdaryRange::scale(self : DsheapdaryRange, f : Double) -> DsheapdaryRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapdaryRange::add(self : DsheapdaryRange, other : DsheapdaryRange) -> DsheapdaryRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapdaryRange::copy(self : DsheapdaryRange) -> DsheapdaryRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapdaryRange::fill(self : DsheapdaryRange, v : Double) -> DsheapdaryRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapdaryRange::min(self : DsheapdaryRange) -> Double { @_common.min(self.data) }

pub fn DsheapdaryRange::max(self : DsheapdaryRange) -> Double { @_common.max(self.data) }

pub fn DsheapdaryRange::to_string(self : DsheapdaryRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapdarySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_d_ary_slice_make(size : Int) -> DsheapdarySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapdarySlice::len(self : DsheapdarySlice) -> Int { self.size }

pub fn DsheapdarySlice::get(self : DsheapdarySlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapdarySlice::set(self : DsheapdarySlice, i : Int, v : Double) -> DsheapdarySlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapdarySlice::sum(self : DsheapdarySlice) -> Double { @_common.sum(self.data) }

pub fn DsheapdarySlice::mean(self : DsheapdarySlice) -> Double { @_common.mean(self.data) }

pub fn DsheapdarySlice::scale(self : DsheapdarySlice, f : Double) -> DsheapdarySlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapdarySlice::add(self : DsheapdarySlice, other : DsheapdarySlice) -> DsheapdarySlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapdarySlice::copy(self : DsheapdarySlice) -> DsheapdarySlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapdarySlice::fill(self : DsheapdarySlice, v : Double) -> DsheapdarySlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapdarySlice::min(self : DsheapdarySlice) -> Double { @_common.min(self.data) }

pub fn DsheapdarySlice::max(self : DsheapdarySlice) -> Double { @_common.max(self.data) }

pub fn DsheapdarySlice::to_string(self : DsheapdarySlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

