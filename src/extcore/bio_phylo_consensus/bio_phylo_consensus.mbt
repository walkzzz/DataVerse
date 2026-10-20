///===
/// extcore/bio_phylo_consensus

pub(all) struct BiophyloconsensusPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_phylo_consensus_make_point(x : Double, y : Double) -> BiophyloconsensusPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_phylo_consensus_make_point3(x : Double, y : Double, z : Double) -> BiophyloconsensusPoint {
  { x, y, z, label: 0 }
}

pub fn BiophyloconsensusPoint::x(self : BiophyloconsensusPoint) -> Double { self.x }

pub fn BiophyloconsensusPoint::y(self : BiophyloconsensusPoint) -> Double { self.y }

pub fn BiophyloconsensusPoint::z(self : BiophyloconsensusPoint) -> Double { self.z }

pub fn BiophyloconsensusPoint::label(self : BiophyloconsensusPoint) -> Int { self.label }

pub fn BiophyloconsensusPoint::dist(self : BiophyloconsensusPoint, other : BiophyloconsensusPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BiophyloconsensusPoint::add(self : BiophyloconsensusPoint, other : BiophyloconsensusPoint) -> BiophyloconsensusPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BiophyloconsensusPoint::sub(self : BiophyloconsensusPoint, other : BiophyloconsensusPoint) -> BiophyloconsensusPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BiophyloconsensusPoint::scale(self : BiophyloconsensusPoint, s : Double) -> BiophyloconsensusPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BiophyloconsensusPoint::dot(self : BiophyloconsensusPoint, other : BiophyloconsensusPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BiophyloconsensusPoint::cross(self : BiophyloconsensusPoint, other : BiophyloconsensusPoint) -> BiophyloconsensusPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BiophyloconsensusPoint::norm(self : BiophyloconsensusPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BiophyloconsensusPoint::normalize(self : BiophyloconsensusPoint) -> BiophyloconsensusPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiophyloconsensusPoint::negate(self : BiophyloconsensusPoint) -> BiophyloconsensusPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BiophyloconsensusPoint::mid(self : BiophyloconsensusPoint, other : BiophyloconsensusPoint) -> BiophyloconsensusPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BiophyloconsensusPoint::lerp(self : BiophyloconsensusPoint, other : BiophyloconsensusPoint, t : Double) -> BiophyloconsensusPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BiophyloconsensusPoint::to_string(self : BiophyloconsensusPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BiophyloconsensusSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_phylo_consensus_make_series(vals : Array[Double], name : String) -> BiophyloconsensusSeries {
  { vals, name, meta: 0 }
}

pub fn BiophyloconsensusSeries::len(self : BiophyloconsensusSeries) -> Int { self.vals.length() }

pub fn BiophyloconsensusSeries::sum(self : BiophyloconsensusSeries) -> Double { @_common.sum(self.vals) }

pub fn BiophyloconsensusSeries::mean(self : BiophyloconsensusSeries) -> Double { @_common.mean(self.vals) }

pub fn BiophyloconsensusSeries::min(self : BiophyloconsensusSeries) -> Double { @_common.min(self.vals) }

pub fn BiophyloconsensusSeries::max(self : BiophyloconsensusSeries) -> Double { @_common.max(self.vals) }

pub fn BiophyloconsensusSeries::range(self : BiophyloconsensusSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BiophyloconsensusSeries::variance(self : BiophyloconsensusSeries) -> Double { @_common.variance(self.vals) }

pub fn BiophyloconsensusSeries::std(self : BiophyloconsensusSeries) -> Double { @_common.std(self.vals) }

pub fn BiophyloconsensusSeries::median(self : BiophyloconsensusSeries) -> Double { @_common.median(self.vals) }

pub fn BiophyloconsensusSeries::scale(self : BiophyloconsensusSeries, f : Double) -> BiophyloconsensusSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BiophyloconsensusSeries::add(self : BiophyloconsensusSeries, other : BiophyloconsensusSeries) -> BiophyloconsensusSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BiophyloconsensusSeries::sub(self : BiophyloconsensusSeries, other : BiophyloconsensusSeries) -> BiophyloconsensusSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BiophyloconsensusSeries::normalize(self : BiophyloconsensusSeries) -> BiophyloconsensusSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BiophyloconsensusSeries::cumsum(self : BiophyloconsensusSeries) -> BiophyloconsensusSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BiophyloconsensusSeries::to_string(self : BiophyloconsensusSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiophyloconsensusMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_phylo_consensus_make_matrix(rows : Int, cols : Int, val : Double) -> BiophyloconsensusMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_phylo_consensus_matrix_identity(n : Int) -> BiophyloconsensusMatrix {
  let m = bio_phylo_consensus_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BiophyloconsensusMatrix::get(self : BiophyloconsensusMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BiophyloconsensusMatrix::transpose(self : BiophyloconsensusMatrix) -> BiophyloconsensusMatrix {
  let result = bio_phylo_consensus_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BiophyloconsensusMatrix::add(self : BiophyloconsensusMatrix, other : BiophyloconsensusMatrix) -> BiophyloconsensusMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_phylo_consensus_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BiophyloconsensusMatrix::scale(self : BiophyloconsensusMatrix, s : Double) -> BiophyloconsensusMatrix {
  let result = bio_phylo_consensus_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BiophyloconsensusMatrix::multiply(self : BiophyloconsensusMatrix, other : BiophyloconsensusMatrix) -> BiophyloconsensusMatrix {
  if self.cols != other.rows { return bio_phylo_consensus_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_phylo_consensus_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn BiophyloconsensusMatrix::trace(self : BiophyloconsensusMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BiophyloconsensusMatrix::det(self : BiophyloconsensusMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BiophyloconsensusMatrix::norm(self : BiophyloconsensusMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BiophyloconsensusMatrix::to_string(self : BiophyloconsensusMatrix) -> String {
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

pub(all) struct BiophyloconsensusVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_phylo_consensus_make_vector(comps : Array[Double]) -> BiophyloconsensusVector {
  { comps, dim: comps.length() }
}

pub fn bio_phylo_consensus_vector_zero(dim : Int) -> BiophyloconsensusVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BiophyloconsensusVector::add(self : BiophyloconsensusVector, other : BiophyloconsensusVector) -> BiophyloconsensusVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BiophyloconsensusVector::sub(self : BiophyloconsensusVector, other : BiophyloconsensusVector) -> BiophyloconsensusVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BiophyloconsensusVector::scale(self : BiophyloconsensusVector, s : Double) -> BiophyloconsensusVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BiophyloconsensusVector::dot(self : BiophyloconsensusVector, other : BiophyloconsensusVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BiophyloconsensusVector::norm(self : BiophyloconsensusVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BiophyloconsensusVector::normalize(self : BiophyloconsensusVector) -> BiophyloconsensusVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiophyloconsensusVector::dist(self : BiophyloconsensusVector, other : BiophyloconsensusVector) -> Double {
  self.sub(other).norm()
}

pub fn BiophyloconsensusVector::to_string(self : BiophyloconsensusVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiophyloconsensusFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_consensus_frame_make(size : Int) -> BiophyloconsensusFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloconsensusFrame::len(self : BiophyloconsensusFrame) -> Int { self.size }

pub fn BiophyloconsensusFrame::get(self : BiophyloconsensusFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloconsensusFrame::set(self : BiophyloconsensusFrame, i : Int, v : Double) -> BiophyloconsensusFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusFrame::sum(self : BiophyloconsensusFrame) -> Double { @_common.sum(self.data) }

pub fn BiophyloconsensusFrame::mean(self : BiophyloconsensusFrame) -> Double { @_common.mean(self.data) }

pub fn BiophyloconsensusFrame::scale(self : BiophyloconsensusFrame, f : Double) -> BiophyloconsensusFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusFrame::add(self : BiophyloconsensusFrame, other : BiophyloconsensusFrame) -> BiophyloconsensusFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloconsensusFrame::copy(self : BiophyloconsensusFrame) -> BiophyloconsensusFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusFrame::fill(self : BiophyloconsensusFrame, v : Double) -> BiophyloconsensusFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusFrame::min(self : BiophyloconsensusFrame) -> Double { @_common.min(self.data) }

pub fn BiophyloconsensusFrame::max(self : BiophyloconsensusFrame) -> Double { @_common.max(self.data) }

pub fn BiophyloconsensusFrame::to_string(self : BiophyloconsensusFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloconsensusTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_consensus_table_make(size : Int) -> BiophyloconsensusTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloconsensusTable::len(self : BiophyloconsensusTable) -> Int { self.size }

pub fn BiophyloconsensusTable::get(self : BiophyloconsensusTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloconsensusTable::set(self : BiophyloconsensusTable, i : Int, v : Double) -> BiophyloconsensusTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusTable::sum(self : BiophyloconsensusTable) -> Double { @_common.sum(self.data) }

pub fn BiophyloconsensusTable::mean(self : BiophyloconsensusTable) -> Double { @_common.mean(self.data) }

pub fn BiophyloconsensusTable::scale(self : BiophyloconsensusTable, f : Double) -> BiophyloconsensusTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusTable::add(self : BiophyloconsensusTable, other : BiophyloconsensusTable) -> BiophyloconsensusTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloconsensusTable::copy(self : BiophyloconsensusTable) -> BiophyloconsensusTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusTable::fill(self : BiophyloconsensusTable, v : Double) -> BiophyloconsensusTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusTable::min(self : BiophyloconsensusTable) -> Double { @_common.min(self.data) }

pub fn BiophyloconsensusTable::max(self : BiophyloconsensusTable) -> Double { @_common.max(self.data) }

pub fn BiophyloconsensusTable::to_string(self : BiophyloconsensusTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloconsensusGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_consensus_graphn_make(size : Int) -> BiophyloconsensusGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloconsensusGraphN::len(self : BiophyloconsensusGraphN) -> Int { self.size }

pub fn BiophyloconsensusGraphN::get(self : BiophyloconsensusGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloconsensusGraphN::set(self : BiophyloconsensusGraphN, i : Int, v : Double) -> BiophyloconsensusGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusGraphN::sum(self : BiophyloconsensusGraphN) -> Double { @_common.sum(self.data) }

pub fn BiophyloconsensusGraphN::mean(self : BiophyloconsensusGraphN) -> Double { @_common.mean(self.data) }

pub fn BiophyloconsensusGraphN::scale(self : BiophyloconsensusGraphN, f : Double) -> BiophyloconsensusGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusGraphN::add(self : BiophyloconsensusGraphN, other : BiophyloconsensusGraphN) -> BiophyloconsensusGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloconsensusGraphN::copy(self : BiophyloconsensusGraphN) -> BiophyloconsensusGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusGraphN::fill(self : BiophyloconsensusGraphN, v : Double) -> BiophyloconsensusGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusGraphN::min(self : BiophyloconsensusGraphN) -> Double { @_common.min(self.data) }

pub fn BiophyloconsensusGraphN::max(self : BiophyloconsensusGraphN) -> Double { @_common.max(self.data) }

pub fn BiophyloconsensusGraphN::to_string(self : BiophyloconsensusGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloconsensusNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_consensus_node_make(size : Int) -> BiophyloconsensusNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloconsensusNode::len(self : BiophyloconsensusNode) -> Int { self.size }

pub fn BiophyloconsensusNode::get(self : BiophyloconsensusNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloconsensusNode::set(self : BiophyloconsensusNode, i : Int, v : Double) -> BiophyloconsensusNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusNode::sum(self : BiophyloconsensusNode) -> Double { @_common.sum(self.data) }

pub fn BiophyloconsensusNode::mean(self : BiophyloconsensusNode) -> Double { @_common.mean(self.data) }

pub fn BiophyloconsensusNode::scale(self : BiophyloconsensusNode, f : Double) -> BiophyloconsensusNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusNode::add(self : BiophyloconsensusNode, other : BiophyloconsensusNode) -> BiophyloconsensusNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloconsensusNode::copy(self : BiophyloconsensusNode) -> BiophyloconsensusNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusNode::fill(self : BiophyloconsensusNode, v : Double) -> BiophyloconsensusNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusNode::min(self : BiophyloconsensusNode) -> Double { @_common.min(self.data) }

pub fn BiophyloconsensusNode::max(self : BiophyloconsensusNode) -> Double { @_common.max(self.data) }

pub fn BiophyloconsensusNode::to_string(self : BiophyloconsensusNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloconsensusEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_consensus_edge_make(size : Int) -> BiophyloconsensusEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloconsensusEdge::len(self : BiophyloconsensusEdge) -> Int { self.size }

pub fn BiophyloconsensusEdge::get(self : BiophyloconsensusEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloconsensusEdge::set(self : BiophyloconsensusEdge, i : Int, v : Double) -> BiophyloconsensusEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusEdge::sum(self : BiophyloconsensusEdge) -> Double { @_common.sum(self.data) }

pub fn BiophyloconsensusEdge::mean(self : BiophyloconsensusEdge) -> Double { @_common.mean(self.data) }

pub fn BiophyloconsensusEdge::scale(self : BiophyloconsensusEdge, f : Double) -> BiophyloconsensusEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusEdge::add(self : BiophyloconsensusEdge, other : BiophyloconsensusEdge) -> BiophyloconsensusEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloconsensusEdge::copy(self : BiophyloconsensusEdge) -> BiophyloconsensusEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusEdge::fill(self : BiophyloconsensusEdge, v : Double) -> BiophyloconsensusEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusEdge::min(self : BiophyloconsensusEdge) -> Double { @_common.min(self.data) }

pub fn BiophyloconsensusEdge::max(self : BiophyloconsensusEdge) -> Double { @_common.max(self.data) }

pub fn BiophyloconsensusEdge::to_string(self : BiophyloconsensusEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloconsensusPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_consensus_path_make(size : Int) -> BiophyloconsensusPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloconsensusPath::len(self : BiophyloconsensusPath) -> Int { self.size }

pub fn BiophyloconsensusPath::get(self : BiophyloconsensusPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloconsensusPath::set(self : BiophyloconsensusPath, i : Int, v : Double) -> BiophyloconsensusPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusPath::sum(self : BiophyloconsensusPath) -> Double { @_common.sum(self.data) }

pub fn BiophyloconsensusPath::mean(self : BiophyloconsensusPath) -> Double { @_common.mean(self.data) }

pub fn BiophyloconsensusPath::scale(self : BiophyloconsensusPath, f : Double) -> BiophyloconsensusPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusPath::add(self : BiophyloconsensusPath, other : BiophyloconsensusPath) -> BiophyloconsensusPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloconsensusPath::copy(self : BiophyloconsensusPath) -> BiophyloconsensusPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusPath::fill(self : BiophyloconsensusPath, v : Double) -> BiophyloconsensusPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusPath::min(self : BiophyloconsensusPath) -> Double { @_common.min(self.data) }

pub fn BiophyloconsensusPath::max(self : BiophyloconsensusPath) -> Double { @_common.max(self.data) }

pub fn BiophyloconsensusPath::to_string(self : BiophyloconsensusPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloconsensusCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_consensus_cluster_make(size : Int) -> BiophyloconsensusCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloconsensusCluster::len(self : BiophyloconsensusCluster) -> Int { self.size }

pub fn BiophyloconsensusCluster::get(self : BiophyloconsensusCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloconsensusCluster::set(self : BiophyloconsensusCluster, i : Int, v : Double) -> BiophyloconsensusCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusCluster::sum(self : BiophyloconsensusCluster) -> Double { @_common.sum(self.data) }

pub fn BiophyloconsensusCluster::mean(self : BiophyloconsensusCluster) -> Double { @_common.mean(self.data) }

pub fn BiophyloconsensusCluster::scale(self : BiophyloconsensusCluster, f : Double) -> BiophyloconsensusCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusCluster::add(self : BiophyloconsensusCluster, other : BiophyloconsensusCluster) -> BiophyloconsensusCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloconsensusCluster::copy(self : BiophyloconsensusCluster) -> BiophyloconsensusCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusCluster::fill(self : BiophyloconsensusCluster, v : Double) -> BiophyloconsensusCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusCluster::min(self : BiophyloconsensusCluster) -> Double { @_common.min(self.data) }

pub fn BiophyloconsensusCluster::max(self : BiophyloconsensusCluster) -> Double { @_common.max(self.data) }

pub fn BiophyloconsensusCluster::to_string(self : BiophyloconsensusCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloconsensusModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_consensus_model_make(size : Int) -> BiophyloconsensusModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloconsensusModel::len(self : BiophyloconsensusModel) -> Int { self.size }

pub fn BiophyloconsensusModel::get(self : BiophyloconsensusModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloconsensusModel::set(self : BiophyloconsensusModel, i : Int, v : Double) -> BiophyloconsensusModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusModel::sum(self : BiophyloconsensusModel) -> Double { @_common.sum(self.data) }

pub fn BiophyloconsensusModel::mean(self : BiophyloconsensusModel) -> Double { @_common.mean(self.data) }

pub fn BiophyloconsensusModel::scale(self : BiophyloconsensusModel, f : Double) -> BiophyloconsensusModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusModel::add(self : BiophyloconsensusModel, other : BiophyloconsensusModel) -> BiophyloconsensusModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloconsensusModel::copy(self : BiophyloconsensusModel) -> BiophyloconsensusModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusModel::fill(self : BiophyloconsensusModel, v : Double) -> BiophyloconsensusModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusModel::min(self : BiophyloconsensusModel) -> Double { @_common.min(self.data) }

pub fn BiophyloconsensusModel::max(self : BiophyloconsensusModel) -> Double { @_common.max(self.data) }

pub fn BiophyloconsensusModel::to_string(self : BiophyloconsensusModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloconsensusLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_consensus_layer_make(size : Int) -> BiophyloconsensusLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloconsensusLayer::len(self : BiophyloconsensusLayer) -> Int { self.size }

pub fn BiophyloconsensusLayer::get(self : BiophyloconsensusLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloconsensusLayer::set(self : BiophyloconsensusLayer, i : Int, v : Double) -> BiophyloconsensusLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusLayer::sum(self : BiophyloconsensusLayer) -> Double { @_common.sum(self.data) }

pub fn BiophyloconsensusLayer::mean(self : BiophyloconsensusLayer) -> Double { @_common.mean(self.data) }

pub fn BiophyloconsensusLayer::scale(self : BiophyloconsensusLayer, f : Double) -> BiophyloconsensusLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusLayer::add(self : BiophyloconsensusLayer, other : BiophyloconsensusLayer) -> BiophyloconsensusLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloconsensusLayer::copy(self : BiophyloconsensusLayer) -> BiophyloconsensusLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusLayer::fill(self : BiophyloconsensusLayer, v : Double) -> BiophyloconsensusLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusLayer::min(self : BiophyloconsensusLayer) -> Double { @_common.min(self.data) }

pub fn BiophyloconsensusLayer::max(self : BiophyloconsensusLayer) -> Double { @_common.max(self.data) }

pub fn BiophyloconsensusLayer::to_string(self : BiophyloconsensusLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloconsensusBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_consensus_buffer_make(size : Int) -> BiophyloconsensusBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloconsensusBuffer::len(self : BiophyloconsensusBuffer) -> Int { self.size }

pub fn BiophyloconsensusBuffer::get(self : BiophyloconsensusBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloconsensusBuffer::set(self : BiophyloconsensusBuffer, i : Int, v : Double) -> BiophyloconsensusBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusBuffer::sum(self : BiophyloconsensusBuffer) -> Double { @_common.sum(self.data) }

pub fn BiophyloconsensusBuffer::mean(self : BiophyloconsensusBuffer) -> Double { @_common.mean(self.data) }

pub fn BiophyloconsensusBuffer::scale(self : BiophyloconsensusBuffer, f : Double) -> BiophyloconsensusBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusBuffer::add(self : BiophyloconsensusBuffer, other : BiophyloconsensusBuffer) -> BiophyloconsensusBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloconsensusBuffer::copy(self : BiophyloconsensusBuffer) -> BiophyloconsensusBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusBuffer::fill(self : BiophyloconsensusBuffer, v : Double) -> BiophyloconsensusBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusBuffer::min(self : BiophyloconsensusBuffer) -> Double { @_common.min(self.data) }

pub fn BiophyloconsensusBuffer::max(self : BiophyloconsensusBuffer) -> Double { @_common.max(self.data) }

pub fn BiophyloconsensusBuffer::to_string(self : BiophyloconsensusBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloconsensusCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_consensus_cursor_make(size : Int) -> BiophyloconsensusCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloconsensusCursor::len(self : BiophyloconsensusCursor) -> Int { self.size }

pub fn BiophyloconsensusCursor::get(self : BiophyloconsensusCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloconsensusCursor::set(self : BiophyloconsensusCursor, i : Int, v : Double) -> BiophyloconsensusCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusCursor::sum(self : BiophyloconsensusCursor) -> Double { @_common.sum(self.data) }

pub fn BiophyloconsensusCursor::mean(self : BiophyloconsensusCursor) -> Double { @_common.mean(self.data) }

pub fn BiophyloconsensusCursor::scale(self : BiophyloconsensusCursor, f : Double) -> BiophyloconsensusCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusCursor::add(self : BiophyloconsensusCursor, other : BiophyloconsensusCursor) -> BiophyloconsensusCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloconsensusCursor::copy(self : BiophyloconsensusCursor) -> BiophyloconsensusCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusCursor::fill(self : BiophyloconsensusCursor, v : Double) -> BiophyloconsensusCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusCursor::min(self : BiophyloconsensusCursor) -> Double { @_common.min(self.data) }

pub fn BiophyloconsensusCursor::max(self : BiophyloconsensusCursor) -> Double { @_common.max(self.data) }

pub fn BiophyloconsensusCursor::to_string(self : BiophyloconsensusCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloconsensusView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_consensus_view_make(size : Int) -> BiophyloconsensusView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloconsensusView::len(self : BiophyloconsensusView) -> Int { self.size }

pub fn BiophyloconsensusView::get(self : BiophyloconsensusView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloconsensusView::set(self : BiophyloconsensusView, i : Int, v : Double) -> BiophyloconsensusView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusView::sum(self : BiophyloconsensusView) -> Double { @_common.sum(self.data) }

pub fn BiophyloconsensusView::mean(self : BiophyloconsensusView) -> Double { @_common.mean(self.data) }

pub fn BiophyloconsensusView::scale(self : BiophyloconsensusView, f : Double) -> BiophyloconsensusView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusView::add(self : BiophyloconsensusView, other : BiophyloconsensusView) -> BiophyloconsensusView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloconsensusView::copy(self : BiophyloconsensusView) -> BiophyloconsensusView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusView::fill(self : BiophyloconsensusView, v : Double) -> BiophyloconsensusView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusView::min(self : BiophyloconsensusView) -> Double { @_common.min(self.data) }

pub fn BiophyloconsensusView::max(self : BiophyloconsensusView) -> Double { @_common.max(self.data) }

pub fn BiophyloconsensusView::to_string(self : BiophyloconsensusView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloconsensusRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_consensus_range_make(size : Int) -> BiophyloconsensusRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloconsensusRange::len(self : BiophyloconsensusRange) -> Int { self.size }

pub fn BiophyloconsensusRange::get(self : BiophyloconsensusRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloconsensusRange::set(self : BiophyloconsensusRange, i : Int, v : Double) -> BiophyloconsensusRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusRange::sum(self : BiophyloconsensusRange) -> Double { @_common.sum(self.data) }

pub fn BiophyloconsensusRange::mean(self : BiophyloconsensusRange) -> Double { @_common.mean(self.data) }

pub fn BiophyloconsensusRange::scale(self : BiophyloconsensusRange, f : Double) -> BiophyloconsensusRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusRange::add(self : BiophyloconsensusRange, other : BiophyloconsensusRange) -> BiophyloconsensusRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloconsensusRange::copy(self : BiophyloconsensusRange) -> BiophyloconsensusRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusRange::fill(self : BiophyloconsensusRange, v : Double) -> BiophyloconsensusRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusRange::min(self : BiophyloconsensusRange) -> Double { @_common.min(self.data) }

pub fn BiophyloconsensusRange::max(self : BiophyloconsensusRange) -> Double { @_common.max(self.data) }

pub fn BiophyloconsensusRange::to_string(self : BiophyloconsensusRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloconsensusSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_consensus_slice_make(size : Int) -> BiophyloconsensusSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloconsensusSlice::len(self : BiophyloconsensusSlice) -> Int { self.size }

pub fn BiophyloconsensusSlice::get(self : BiophyloconsensusSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloconsensusSlice::set(self : BiophyloconsensusSlice, i : Int, v : Double) -> BiophyloconsensusSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusSlice::sum(self : BiophyloconsensusSlice) -> Double { @_common.sum(self.data) }

pub fn BiophyloconsensusSlice::mean(self : BiophyloconsensusSlice) -> Double { @_common.mean(self.data) }

pub fn BiophyloconsensusSlice::scale(self : BiophyloconsensusSlice, f : Double) -> BiophyloconsensusSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusSlice::add(self : BiophyloconsensusSlice, other : BiophyloconsensusSlice) -> BiophyloconsensusSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloconsensusSlice::copy(self : BiophyloconsensusSlice) -> BiophyloconsensusSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusSlice::fill(self : BiophyloconsensusSlice, v : Double) -> BiophyloconsensusSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloconsensusSlice::min(self : BiophyloconsensusSlice) -> Double { @_common.min(self.data) }

pub fn BiophyloconsensusSlice::max(self : BiophyloconsensusSlice) -> Double { @_common.max(self.data) }

pub fn BiophyloconsensusSlice::to_string(self : BiophyloconsensusSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

