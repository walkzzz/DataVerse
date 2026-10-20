///===
/// extcore/ds_tree_suffix

pub(all) struct DstreesuffixPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_tree_suffix_make_point(x : Double, y : Double) -> DstreesuffixPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_tree_suffix_make_point3(x : Double, y : Double, z : Double) -> DstreesuffixPoint {
  { x, y, z, label: 0 }
}

pub fn DstreesuffixPoint::x(self : DstreesuffixPoint) -> Double { self.x }

pub fn DstreesuffixPoint::y(self : DstreesuffixPoint) -> Double { self.y }

pub fn DstreesuffixPoint::z(self : DstreesuffixPoint) -> Double { self.z }

pub fn DstreesuffixPoint::label(self : DstreesuffixPoint) -> Int { self.label }

pub fn DstreesuffixPoint::dist(self : DstreesuffixPoint, other : DstreesuffixPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DstreesuffixPoint::add(self : DstreesuffixPoint, other : DstreesuffixPoint) -> DstreesuffixPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DstreesuffixPoint::sub(self : DstreesuffixPoint, other : DstreesuffixPoint) -> DstreesuffixPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DstreesuffixPoint::scale(self : DstreesuffixPoint, s : Double) -> DstreesuffixPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DstreesuffixPoint::dot(self : DstreesuffixPoint, other : DstreesuffixPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DstreesuffixPoint::cross(self : DstreesuffixPoint, other : DstreesuffixPoint) -> DstreesuffixPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DstreesuffixPoint::norm(self : DstreesuffixPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DstreesuffixPoint::normalize(self : DstreesuffixPoint) -> DstreesuffixPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DstreesuffixPoint::negate(self : DstreesuffixPoint) -> DstreesuffixPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DstreesuffixPoint::mid(self : DstreesuffixPoint, other : DstreesuffixPoint) -> DstreesuffixPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DstreesuffixPoint::lerp(self : DstreesuffixPoint, other : DstreesuffixPoint, t : Double) -> DstreesuffixPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DstreesuffixPoint::to_string(self : DstreesuffixPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DstreesuffixSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_tree_suffix_make_series(vals : Array[Double], name : String) -> DstreesuffixSeries {
  { vals, name, meta: 0 }
}

pub fn DstreesuffixSeries::len(self : DstreesuffixSeries) -> Int { self.vals.length() }

pub fn DstreesuffixSeries::sum(self : DstreesuffixSeries) -> Double { @_common.sum(self.vals) }

pub fn DstreesuffixSeries::mean(self : DstreesuffixSeries) -> Double { @_common.mean(self.vals) }

pub fn DstreesuffixSeries::min(self : DstreesuffixSeries) -> Double { @_common.min(self.vals) }

pub fn DstreesuffixSeries::max(self : DstreesuffixSeries) -> Double { @_common.max(self.vals) }

pub fn DstreesuffixSeries::range(self : DstreesuffixSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DstreesuffixSeries::variance(self : DstreesuffixSeries) -> Double { @_common.variance(self.vals) }

pub fn DstreesuffixSeries::std(self : DstreesuffixSeries) -> Double { @_common.std(self.vals) }

pub fn DstreesuffixSeries::median(self : DstreesuffixSeries) -> Double { @_common.median(self.vals) }

pub fn DstreesuffixSeries::scale(self : DstreesuffixSeries, f : Double) -> DstreesuffixSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DstreesuffixSeries::add(self : DstreesuffixSeries, other : DstreesuffixSeries) -> DstreesuffixSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DstreesuffixSeries::sub(self : DstreesuffixSeries, other : DstreesuffixSeries) -> DstreesuffixSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DstreesuffixSeries::normalize(self : DstreesuffixSeries) -> DstreesuffixSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DstreesuffixSeries::cumsum(self : DstreesuffixSeries) -> DstreesuffixSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DstreesuffixSeries::to_string(self : DstreesuffixSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DstreesuffixMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_tree_suffix_make_matrix(rows : Int, cols : Int, val : Double) -> DstreesuffixMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn ds_tree_suffix_matrix_identity(n : Int) -> DstreesuffixMatrix {
  let m = ds_tree_suffix_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DstreesuffixMatrix::get(self : DstreesuffixMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DstreesuffixMatrix::transpose(self : DstreesuffixMatrix) -> DstreesuffixMatrix {
  let result = ds_tree_suffix_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DstreesuffixMatrix::add(self : DstreesuffixMatrix, other : DstreesuffixMatrix) -> DstreesuffixMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_tree_suffix_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DstreesuffixMatrix::scale(self : DstreesuffixMatrix, s : Double) -> DstreesuffixMatrix {
  let result = ds_tree_suffix_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DstreesuffixMatrix::multiply(self : DstreesuffixMatrix, other : DstreesuffixMatrix) -> DstreesuffixMatrix {
  if self.cols != other.rows { return ds_tree_suffix_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_tree_suffix_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn DstreesuffixMatrix::trace(self : DstreesuffixMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DstreesuffixMatrix::det(self : DstreesuffixMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DstreesuffixMatrix::norm(self : DstreesuffixMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DstreesuffixMatrix::to_string(self : DstreesuffixMatrix) -> String {
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

pub(all) struct DstreesuffixVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_tree_suffix_make_vector(comps : Array[Double]) -> DstreesuffixVector {
  { comps, dim: comps.length() }
}

pub fn ds_tree_suffix_vector_zero(dim : Int) -> DstreesuffixVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DstreesuffixVector::add(self : DstreesuffixVector, other : DstreesuffixVector) -> DstreesuffixVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DstreesuffixVector::sub(self : DstreesuffixVector, other : DstreesuffixVector) -> DstreesuffixVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DstreesuffixVector::scale(self : DstreesuffixVector, s : Double) -> DstreesuffixVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DstreesuffixVector::dot(self : DstreesuffixVector, other : DstreesuffixVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DstreesuffixVector::norm(self : DstreesuffixVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DstreesuffixVector::normalize(self : DstreesuffixVector) -> DstreesuffixVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DstreesuffixVector::dist(self : DstreesuffixVector, other : DstreesuffixVector) -> Double {
  self.sub(other).norm()
}

pub fn DstreesuffixVector::to_string(self : DstreesuffixVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DstreesuffixFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_suffix_frame_make(size : Int) -> DstreesuffixFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreesuffixFrame::len(self : DstreesuffixFrame) -> Int { self.size }

pub fn DstreesuffixFrame::get(self : DstreesuffixFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreesuffixFrame::set(self : DstreesuffixFrame, i : Int, v : Double) -> DstreesuffixFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreesuffixFrame::sum(self : DstreesuffixFrame) -> Double { @_common.sum(self.data) }

pub fn DstreesuffixFrame::mean(self : DstreesuffixFrame) -> Double { @_common.mean(self.data) }

pub fn DstreesuffixFrame::scale(self : DstreesuffixFrame, f : Double) -> DstreesuffixFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreesuffixFrame::add(self : DstreesuffixFrame, other : DstreesuffixFrame) -> DstreesuffixFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreesuffixFrame::copy(self : DstreesuffixFrame) -> DstreesuffixFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreesuffixFrame::fill(self : DstreesuffixFrame, v : Double) -> DstreesuffixFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreesuffixFrame::min(self : DstreesuffixFrame) -> Double { @_common.min(self.data) }

pub fn DstreesuffixFrame::max(self : DstreesuffixFrame) -> Double { @_common.max(self.data) }

pub fn DstreesuffixFrame::to_string(self : DstreesuffixFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreesuffixTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_suffix_table_make(size : Int) -> DstreesuffixTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreesuffixTable::len(self : DstreesuffixTable) -> Int { self.size }

pub fn DstreesuffixTable::get(self : DstreesuffixTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreesuffixTable::set(self : DstreesuffixTable, i : Int, v : Double) -> DstreesuffixTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreesuffixTable::sum(self : DstreesuffixTable) -> Double { @_common.sum(self.data) }

pub fn DstreesuffixTable::mean(self : DstreesuffixTable) -> Double { @_common.mean(self.data) }

pub fn DstreesuffixTable::scale(self : DstreesuffixTable, f : Double) -> DstreesuffixTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreesuffixTable::add(self : DstreesuffixTable, other : DstreesuffixTable) -> DstreesuffixTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreesuffixTable::copy(self : DstreesuffixTable) -> DstreesuffixTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreesuffixTable::fill(self : DstreesuffixTable, v : Double) -> DstreesuffixTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreesuffixTable::min(self : DstreesuffixTable) -> Double { @_common.min(self.data) }

pub fn DstreesuffixTable::max(self : DstreesuffixTable) -> Double { @_common.max(self.data) }

pub fn DstreesuffixTable::to_string(self : DstreesuffixTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreesuffixGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_suffix_graphn_make(size : Int) -> DstreesuffixGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreesuffixGraphN::len(self : DstreesuffixGraphN) -> Int { self.size }

pub fn DstreesuffixGraphN::get(self : DstreesuffixGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreesuffixGraphN::set(self : DstreesuffixGraphN, i : Int, v : Double) -> DstreesuffixGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreesuffixGraphN::sum(self : DstreesuffixGraphN) -> Double { @_common.sum(self.data) }

pub fn DstreesuffixGraphN::mean(self : DstreesuffixGraphN) -> Double { @_common.mean(self.data) }

pub fn DstreesuffixGraphN::scale(self : DstreesuffixGraphN, f : Double) -> DstreesuffixGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreesuffixGraphN::add(self : DstreesuffixGraphN, other : DstreesuffixGraphN) -> DstreesuffixGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreesuffixGraphN::copy(self : DstreesuffixGraphN) -> DstreesuffixGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreesuffixGraphN::fill(self : DstreesuffixGraphN, v : Double) -> DstreesuffixGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreesuffixGraphN::min(self : DstreesuffixGraphN) -> Double { @_common.min(self.data) }

pub fn DstreesuffixGraphN::max(self : DstreesuffixGraphN) -> Double { @_common.max(self.data) }

pub fn DstreesuffixGraphN::to_string(self : DstreesuffixGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreesuffixNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_suffix_node_make(size : Int) -> DstreesuffixNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreesuffixNode::len(self : DstreesuffixNode) -> Int { self.size }

pub fn DstreesuffixNode::get(self : DstreesuffixNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreesuffixNode::set(self : DstreesuffixNode, i : Int, v : Double) -> DstreesuffixNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreesuffixNode::sum(self : DstreesuffixNode) -> Double { @_common.sum(self.data) }

pub fn DstreesuffixNode::mean(self : DstreesuffixNode) -> Double { @_common.mean(self.data) }

pub fn DstreesuffixNode::scale(self : DstreesuffixNode, f : Double) -> DstreesuffixNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreesuffixNode::add(self : DstreesuffixNode, other : DstreesuffixNode) -> DstreesuffixNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreesuffixNode::copy(self : DstreesuffixNode) -> DstreesuffixNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreesuffixNode::fill(self : DstreesuffixNode, v : Double) -> DstreesuffixNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreesuffixNode::min(self : DstreesuffixNode) -> Double { @_common.min(self.data) }

pub fn DstreesuffixNode::max(self : DstreesuffixNode) -> Double { @_common.max(self.data) }

pub fn DstreesuffixNode::to_string(self : DstreesuffixNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreesuffixEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_suffix_edge_make(size : Int) -> DstreesuffixEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreesuffixEdge::len(self : DstreesuffixEdge) -> Int { self.size }

pub fn DstreesuffixEdge::get(self : DstreesuffixEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreesuffixEdge::set(self : DstreesuffixEdge, i : Int, v : Double) -> DstreesuffixEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreesuffixEdge::sum(self : DstreesuffixEdge) -> Double { @_common.sum(self.data) }

pub fn DstreesuffixEdge::mean(self : DstreesuffixEdge) -> Double { @_common.mean(self.data) }

pub fn DstreesuffixEdge::scale(self : DstreesuffixEdge, f : Double) -> DstreesuffixEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreesuffixEdge::add(self : DstreesuffixEdge, other : DstreesuffixEdge) -> DstreesuffixEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreesuffixEdge::copy(self : DstreesuffixEdge) -> DstreesuffixEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreesuffixEdge::fill(self : DstreesuffixEdge, v : Double) -> DstreesuffixEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreesuffixEdge::min(self : DstreesuffixEdge) -> Double { @_common.min(self.data) }

pub fn DstreesuffixEdge::max(self : DstreesuffixEdge) -> Double { @_common.max(self.data) }

pub fn DstreesuffixEdge::to_string(self : DstreesuffixEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreesuffixPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_suffix_path_make(size : Int) -> DstreesuffixPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreesuffixPath::len(self : DstreesuffixPath) -> Int { self.size }

pub fn DstreesuffixPath::get(self : DstreesuffixPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreesuffixPath::set(self : DstreesuffixPath, i : Int, v : Double) -> DstreesuffixPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreesuffixPath::sum(self : DstreesuffixPath) -> Double { @_common.sum(self.data) }

pub fn DstreesuffixPath::mean(self : DstreesuffixPath) -> Double { @_common.mean(self.data) }

pub fn DstreesuffixPath::scale(self : DstreesuffixPath, f : Double) -> DstreesuffixPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreesuffixPath::add(self : DstreesuffixPath, other : DstreesuffixPath) -> DstreesuffixPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreesuffixPath::copy(self : DstreesuffixPath) -> DstreesuffixPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreesuffixPath::fill(self : DstreesuffixPath, v : Double) -> DstreesuffixPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreesuffixPath::min(self : DstreesuffixPath) -> Double { @_common.min(self.data) }

pub fn DstreesuffixPath::max(self : DstreesuffixPath) -> Double { @_common.max(self.data) }

pub fn DstreesuffixPath::to_string(self : DstreesuffixPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreesuffixCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_suffix_cluster_make(size : Int) -> DstreesuffixCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreesuffixCluster::len(self : DstreesuffixCluster) -> Int { self.size }

pub fn DstreesuffixCluster::get(self : DstreesuffixCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreesuffixCluster::set(self : DstreesuffixCluster, i : Int, v : Double) -> DstreesuffixCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreesuffixCluster::sum(self : DstreesuffixCluster) -> Double { @_common.sum(self.data) }

pub fn DstreesuffixCluster::mean(self : DstreesuffixCluster) -> Double { @_common.mean(self.data) }

pub fn DstreesuffixCluster::scale(self : DstreesuffixCluster, f : Double) -> DstreesuffixCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreesuffixCluster::add(self : DstreesuffixCluster, other : DstreesuffixCluster) -> DstreesuffixCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreesuffixCluster::copy(self : DstreesuffixCluster) -> DstreesuffixCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreesuffixCluster::fill(self : DstreesuffixCluster, v : Double) -> DstreesuffixCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreesuffixCluster::min(self : DstreesuffixCluster) -> Double { @_common.min(self.data) }

pub fn DstreesuffixCluster::max(self : DstreesuffixCluster) -> Double { @_common.max(self.data) }

pub fn DstreesuffixCluster::to_string(self : DstreesuffixCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreesuffixModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_suffix_model_make(size : Int) -> DstreesuffixModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreesuffixModel::len(self : DstreesuffixModel) -> Int { self.size }

pub fn DstreesuffixModel::get(self : DstreesuffixModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreesuffixModel::set(self : DstreesuffixModel, i : Int, v : Double) -> DstreesuffixModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreesuffixModel::sum(self : DstreesuffixModel) -> Double { @_common.sum(self.data) }

pub fn DstreesuffixModel::mean(self : DstreesuffixModel) -> Double { @_common.mean(self.data) }

pub fn DstreesuffixModel::scale(self : DstreesuffixModel, f : Double) -> DstreesuffixModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreesuffixModel::add(self : DstreesuffixModel, other : DstreesuffixModel) -> DstreesuffixModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreesuffixModel::copy(self : DstreesuffixModel) -> DstreesuffixModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreesuffixModel::fill(self : DstreesuffixModel, v : Double) -> DstreesuffixModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreesuffixModel::min(self : DstreesuffixModel) -> Double { @_common.min(self.data) }

pub fn DstreesuffixModel::max(self : DstreesuffixModel) -> Double { @_common.max(self.data) }

pub fn DstreesuffixModel::to_string(self : DstreesuffixModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreesuffixLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_suffix_layer_make(size : Int) -> DstreesuffixLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreesuffixLayer::len(self : DstreesuffixLayer) -> Int { self.size }

pub fn DstreesuffixLayer::get(self : DstreesuffixLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreesuffixLayer::set(self : DstreesuffixLayer, i : Int, v : Double) -> DstreesuffixLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreesuffixLayer::sum(self : DstreesuffixLayer) -> Double { @_common.sum(self.data) }

pub fn DstreesuffixLayer::mean(self : DstreesuffixLayer) -> Double { @_common.mean(self.data) }

pub fn DstreesuffixLayer::scale(self : DstreesuffixLayer, f : Double) -> DstreesuffixLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreesuffixLayer::add(self : DstreesuffixLayer, other : DstreesuffixLayer) -> DstreesuffixLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreesuffixLayer::copy(self : DstreesuffixLayer) -> DstreesuffixLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreesuffixLayer::fill(self : DstreesuffixLayer, v : Double) -> DstreesuffixLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreesuffixLayer::min(self : DstreesuffixLayer) -> Double { @_common.min(self.data) }

pub fn DstreesuffixLayer::max(self : DstreesuffixLayer) -> Double { @_common.max(self.data) }

pub fn DstreesuffixLayer::to_string(self : DstreesuffixLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreesuffixBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_suffix_buffer_make(size : Int) -> DstreesuffixBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreesuffixBuffer::len(self : DstreesuffixBuffer) -> Int { self.size }

pub fn DstreesuffixBuffer::get(self : DstreesuffixBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreesuffixBuffer::set(self : DstreesuffixBuffer, i : Int, v : Double) -> DstreesuffixBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreesuffixBuffer::sum(self : DstreesuffixBuffer) -> Double { @_common.sum(self.data) }

pub fn DstreesuffixBuffer::mean(self : DstreesuffixBuffer) -> Double { @_common.mean(self.data) }

pub fn DstreesuffixBuffer::scale(self : DstreesuffixBuffer, f : Double) -> DstreesuffixBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreesuffixBuffer::add(self : DstreesuffixBuffer, other : DstreesuffixBuffer) -> DstreesuffixBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreesuffixBuffer::copy(self : DstreesuffixBuffer) -> DstreesuffixBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreesuffixBuffer::fill(self : DstreesuffixBuffer, v : Double) -> DstreesuffixBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreesuffixBuffer::min(self : DstreesuffixBuffer) -> Double { @_common.min(self.data) }

pub fn DstreesuffixBuffer::max(self : DstreesuffixBuffer) -> Double { @_common.max(self.data) }

pub fn DstreesuffixBuffer::to_string(self : DstreesuffixBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreesuffixCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_suffix_cursor_make(size : Int) -> DstreesuffixCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreesuffixCursor::len(self : DstreesuffixCursor) -> Int { self.size }

pub fn DstreesuffixCursor::get(self : DstreesuffixCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreesuffixCursor::set(self : DstreesuffixCursor, i : Int, v : Double) -> DstreesuffixCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreesuffixCursor::sum(self : DstreesuffixCursor) -> Double { @_common.sum(self.data) }

pub fn DstreesuffixCursor::mean(self : DstreesuffixCursor) -> Double { @_common.mean(self.data) }

pub fn DstreesuffixCursor::scale(self : DstreesuffixCursor, f : Double) -> DstreesuffixCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreesuffixCursor::add(self : DstreesuffixCursor, other : DstreesuffixCursor) -> DstreesuffixCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreesuffixCursor::copy(self : DstreesuffixCursor) -> DstreesuffixCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreesuffixCursor::fill(self : DstreesuffixCursor, v : Double) -> DstreesuffixCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreesuffixCursor::min(self : DstreesuffixCursor) -> Double { @_common.min(self.data) }

pub fn DstreesuffixCursor::max(self : DstreesuffixCursor) -> Double { @_common.max(self.data) }

pub fn DstreesuffixCursor::to_string(self : DstreesuffixCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreesuffixView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_suffix_view_make(size : Int) -> DstreesuffixView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreesuffixView::len(self : DstreesuffixView) -> Int { self.size }

pub fn DstreesuffixView::get(self : DstreesuffixView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreesuffixView::set(self : DstreesuffixView, i : Int, v : Double) -> DstreesuffixView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreesuffixView::sum(self : DstreesuffixView) -> Double { @_common.sum(self.data) }

pub fn DstreesuffixView::mean(self : DstreesuffixView) -> Double { @_common.mean(self.data) }

pub fn DstreesuffixView::scale(self : DstreesuffixView, f : Double) -> DstreesuffixView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreesuffixView::add(self : DstreesuffixView, other : DstreesuffixView) -> DstreesuffixView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreesuffixView::copy(self : DstreesuffixView) -> DstreesuffixView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreesuffixView::fill(self : DstreesuffixView, v : Double) -> DstreesuffixView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreesuffixView::min(self : DstreesuffixView) -> Double { @_common.min(self.data) }

pub fn DstreesuffixView::max(self : DstreesuffixView) -> Double { @_common.max(self.data) }

pub fn DstreesuffixView::to_string(self : DstreesuffixView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreesuffixRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_suffix_range_make(size : Int) -> DstreesuffixRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreesuffixRange::len(self : DstreesuffixRange) -> Int { self.size }

pub fn DstreesuffixRange::get(self : DstreesuffixRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreesuffixRange::set(self : DstreesuffixRange, i : Int, v : Double) -> DstreesuffixRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreesuffixRange::sum(self : DstreesuffixRange) -> Double { @_common.sum(self.data) }

pub fn DstreesuffixRange::mean(self : DstreesuffixRange) -> Double { @_common.mean(self.data) }

pub fn DstreesuffixRange::scale(self : DstreesuffixRange, f : Double) -> DstreesuffixRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreesuffixRange::add(self : DstreesuffixRange, other : DstreesuffixRange) -> DstreesuffixRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreesuffixRange::copy(self : DstreesuffixRange) -> DstreesuffixRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreesuffixRange::fill(self : DstreesuffixRange, v : Double) -> DstreesuffixRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreesuffixRange::min(self : DstreesuffixRange) -> Double { @_common.min(self.data) }

pub fn DstreesuffixRange::max(self : DstreesuffixRange) -> Double { @_common.max(self.data) }

pub fn DstreesuffixRange::to_string(self : DstreesuffixRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreesuffixSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_suffix_slice_make(size : Int) -> DstreesuffixSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreesuffixSlice::len(self : DstreesuffixSlice) -> Int { self.size }

pub fn DstreesuffixSlice::get(self : DstreesuffixSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreesuffixSlice::set(self : DstreesuffixSlice, i : Int, v : Double) -> DstreesuffixSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreesuffixSlice::sum(self : DstreesuffixSlice) -> Double { @_common.sum(self.data) }

pub fn DstreesuffixSlice::mean(self : DstreesuffixSlice) -> Double { @_common.mean(self.data) }

pub fn DstreesuffixSlice::scale(self : DstreesuffixSlice, f : Double) -> DstreesuffixSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreesuffixSlice::add(self : DstreesuffixSlice, other : DstreesuffixSlice) -> DstreesuffixSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreesuffixSlice::copy(self : DstreesuffixSlice) -> DstreesuffixSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreesuffixSlice::fill(self : DstreesuffixSlice, v : Double) -> DstreesuffixSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreesuffixSlice::min(self : DstreesuffixSlice) -> Double { @_common.min(self.data) }

pub fn DstreesuffixSlice::max(self : DstreesuffixSlice) -> Double { @_common.max(self.data) }

pub fn DstreesuffixSlice::to_string(self : DstreesuffixSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

