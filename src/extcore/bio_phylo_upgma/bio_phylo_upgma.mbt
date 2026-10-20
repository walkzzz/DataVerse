///===
/// extcore/bio_phylo_upgma

pub(all) struct BiophyloupgmaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_phylo_upgma_make_point(x : Double, y : Double) -> BiophyloupgmaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_phylo_upgma_make_point3(x : Double, y : Double, z : Double) -> BiophyloupgmaPoint {
  { x, y, z, label: 0 }
}

pub fn BiophyloupgmaPoint::x(self : BiophyloupgmaPoint) -> Double { self.x }

pub fn BiophyloupgmaPoint::y(self : BiophyloupgmaPoint) -> Double { self.y }

pub fn BiophyloupgmaPoint::z(self : BiophyloupgmaPoint) -> Double { self.z }

pub fn BiophyloupgmaPoint::label(self : BiophyloupgmaPoint) -> Int { self.label }

pub fn BiophyloupgmaPoint::dist(self : BiophyloupgmaPoint, other : BiophyloupgmaPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BiophyloupgmaPoint::add(self : BiophyloupgmaPoint, other : BiophyloupgmaPoint) -> BiophyloupgmaPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BiophyloupgmaPoint::sub(self : BiophyloupgmaPoint, other : BiophyloupgmaPoint) -> BiophyloupgmaPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BiophyloupgmaPoint::scale(self : BiophyloupgmaPoint, s : Double) -> BiophyloupgmaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BiophyloupgmaPoint::dot(self : BiophyloupgmaPoint, other : BiophyloupgmaPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BiophyloupgmaPoint::cross(self : BiophyloupgmaPoint, other : BiophyloupgmaPoint) -> BiophyloupgmaPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BiophyloupgmaPoint::norm(self : BiophyloupgmaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BiophyloupgmaPoint::normalize(self : BiophyloupgmaPoint) -> BiophyloupgmaPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiophyloupgmaPoint::negate(self : BiophyloupgmaPoint) -> BiophyloupgmaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BiophyloupgmaPoint::mid(self : BiophyloupgmaPoint, other : BiophyloupgmaPoint) -> BiophyloupgmaPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BiophyloupgmaPoint::lerp(self : BiophyloupgmaPoint, other : BiophyloupgmaPoint, t : Double) -> BiophyloupgmaPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BiophyloupgmaPoint::to_string(self : BiophyloupgmaPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BiophyloupgmaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_phylo_upgma_make_series(vals : Array[Double], name : String) -> BiophyloupgmaSeries {
  { vals, name, meta: 0 }
}

pub fn BiophyloupgmaSeries::len(self : BiophyloupgmaSeries) -> Int { self.vals.length() }

pub fn BiophyloupgmaSeries::sum(self : BiophyloupgmaSeries) -> Double { @_common.sum(self.vals) }

pub fn BiophyloupgmaSeries::mean(self : BiophyloupgmaSeries) -> Double { @_common.mean(self.vals) }

pub fn BiophyloupgmaSeries::min(self : BiophyloupgmaSeries) -> Double { @_common.min(self.vals) }

pub fn BiophyloupgmaSeries::max(self : BiophyloupgmaSeries) -> Double { @_common.max(self.vals) }

pub fn BiophyloupgmaSeries::range(self : BiophyloupgmaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BiophyloupgmaSeries::variance(self : BiophyloupgmaSeries) -> Double { @_common.variance(self.vals) }

pub fn BiophyloupgmaSeries::std(self : BiophyloupgmaSeries) -> Double { @_common.std(self.vals) }

pub fn BiophyloupgmaSeries::median(self : BiophyloupgmaSeries) -> Double { @_common.median(self.vals) }

pub fn BiophyloupgmaSeries::scale(self : BiophyloupgmaSeries, f : Double) -> BiophyloupgmaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BiophyloupgmaSeries::add(self : BiophyloupgmaSeries, other : BiophyloupgmaSeries) -> BiophyloupgmaSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BiophyloupgmaSeries::sub(self : BiophyloupgmaSeries, other : BiophyloupgmaSeries) -> BiophyloupgmaSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BiophyloupgmaSeries::normalize(self : BiophyloupgmaSeries) -> BiophyloupgmaSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BiophyloupgmaSeries::cumsum(self : BiophyloupgmaSeries) -> BiophyloupgmaSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BiophyloupgmaSeries::to_string(self : BiophyloupgmaSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiophyloupgmaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_phylo_upgma_make_matrix(rows : Int, cols : Int, val : Double) -> BiophyloupgmaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_phylo_upgma_matrix_identity(n : Int) -> BiophyloupgmaMatrix {
  let m = bio_phylo_upgma_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BiophyloupgmaMatrix::get(self : BiophyloupgmaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BiophyloupgmaMatrix::transpose(self : BiophyloupgmaMatrix) -> BiophyloupgmaMatrix {
  let result = bio_phylo_upgma_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BiophyloupgmaMatrix::add(self : BiophyloupgmaMatrix, other : BiophyloupgmaMatrix) -> BiophyloupgmaMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_phylo_upgma_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BiophyloupgmaMatrix::scale(self : BiophyloupgmaMatrix, s : Double) -> BiophyloupgmaMatrix {
  let result = bio_phylo_upgma_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BiophyloupgmaMatrix::multiply(self : BiophyloupgmaMatrix, other : BiophyloupgmaMatrix) -> BiophyloupgmaMatrix {
  if self.cols != other.rows { return bio_phylo_upgma_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_phylo_upgma_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn BiophyloupgmaMatrix::trace(self : BiophyloupgmaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BiophyloupgmaMatrix::det(self : BiophyloupgmaMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BiophyloupgmaMatrix::norm(self : BiophyloupgmaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BiophyloupgmaMatrix::to_string(self : BiophyloupgmaMatrix) -> String {
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

pub(all) struct BiophyloupgmaVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_phylo_upgma_make_vector(comps : Array[Double]) -> BiophyloupgmaVector {
  { comps, dim: comps.length() }
}

pub fn bio_phylo_upgma_vector_zero(dim : Int) -> BiophyloupgmaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BiophyloupgmaVector::add(self : BiophyloupgmaVector, other : BiophyloupgmaVector) -> BiophyloupgmaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BiophyloupgmaVector::sub(self : BiophyloupgmaVector, other : BiophyloupgmaVector) -> BiophyloupgmaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BiophyloupgmaVector::scale(self : BiophyloupgmaVector, s : Double) -> BiophyloupgmaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BiophyloupgmaVector::dot(self : BiophyloupgmaVector, other : BiophyloupgmaVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BiophyloupgmaVector::norm(self : BiophyloupgmaVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BiophyloupgmaVector::normalize(self : BiophyloupgmaVector) -> BiophyloupgmaVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiophyloupgmaVector::dist(self : BiophyloupgmaVector, other : BiophyloupgmaVector) -> Double {
  self.sub(other).norm()
}

pub fn BiophyloupgmaVector::to_string(self : BiophyloupgmaVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiophyloupgmaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_upgma_frame_make(size : Int) -> BiophyloupgmaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloupgmaFrame::len(self : BiophyloupgmaFrame) -> Int { self.size }

pub fn BiophyloupgmaFrame::get(self : BiophyloupgmaFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloupgmaFrame::set(self : BiophyloupgmaFrame, i : Int, v : Double) -> BiophyloupgmaFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaFrame::sum(self : BiophyloupgmaFrame) -> Double { @_common.sum(self.data) }

pub fn BiophyloupgmaFrame::mean(self : BiophyloupgmaFrame) -> Double { @_common.mean(self.data) }

pub fn BiophyloupgmaFrame::scale(self : BiophyloupgmaFrame, f : Double) -> BiophyloupgmaFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaFrame::add(self : BiophyloupgmaFrame, other : BiophyloupgmaFrame) -> BiophyloupgmaFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloupgmaFrame::copy(self : BiophyloupgmaFrame) -> BiophyloupgmaFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaFrame::fill(self : BiophyloupgmaFrame, v : Double) -> BiophyloupgmaFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaFrame::min(self : BiophyloupgmaFrame) -> Double { @_common.min(self.data) }

pub fn BiophyloupgmaFrame::max(self : BiophyloupgmaFrame) -> Double { @_common.max(self.data) }

pub fn BiophyloupgmaFrame::to_string(self : BiophyloupgmaFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloupgmaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_upgma_table_make(size : Int) -> BiophyloupgmaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloupgmaTable::len(self : BiophyloupgmaTable) -> Int { self.size }

pub fn BiophyloupgmaTable::get(self : BiophyloupgmaTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloupgmaTable::set(self : BiophyloupgmaTable, i : Int, v : Double) -> BiophyloupgmaTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaTable::sum(self : BiophyloupgmaTable) -> Double { @_common.sum(self.data) }

pub fn BiophyloupgmaTable::mean(self : BiophyloupgmaTable) -> Double { @_common.mean(self.data) }

pub fn BiophyloupgmaTable::scale(self : BiophyloupgmaTable, f : Double) -> BiophyloupgmaTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaTable::add(self : BiophyloupgmaTable, other : BiophyloupgmaTable) -> BiophyloupgmaTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloupgmaTable::copy(self : BiophyloupgmaTable) -> BiophyloupgmaTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaTable::fill(self : BiophyloupgmaTable, v : Double) -> BiophyloupgmaTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaTable::min(self : BiophyloupgmaTable) -> Double { @_common.min(self.data) }

pub fn BiophyloupgmaTable::max(self : BiophyloupgmaTable) -> Double { @_common.max(self.data) }

pub fn BiophyloupgmaTable::to_string(self : BiophyloupgmaTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloupgmaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_upgma_graphn_make(size : Int) -> BiophyloupgmaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloupgmaGraphN::len(self : BiophyloupgmaGraphN) -> Int { self.size }

pub fn BiophyloupgmaGraphN::get(self : BiophyloupgmaGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloupgmaGraphN::set(self : BiophyloupgmaGraphN, i : Int, v : Double) -> BiophyloupgmaGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaGraphN::sum(self : BiophyloupgmaGraphN) -> Double { @_common.sum(self.data) }

pub fn BiophyloupgmaGraphN::mean(self : BiophyloupgmaGraphN) -> Double { @_common.mean(self.data) }

pub fn BiophyloupgmaGraphN::scale(self : BiophyloupgmaGraphN, f : Double) -> BiophyloupgmaGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaGraphN::add(self : BiophyloupgmaGraphN, other : BiophyloupgmaGraphN) -> BiophyloupgmaGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloupgmaGraphN::copy(self : BiophyloupgmaGraphN) -> BiophyloupgmaGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaGraphN::fill(self : BiophyloupgmaGraphN, v : Double) -> BiophyloupgmaGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaGraphN::min(self : BiophyloupgmaGraphN) -> Double { @_common.min(self.data) }

pub fn BiophyloupgmaGraphN::max(self : BiophyloupgmaGraphN) -> Double { @_common.max(self.data) }

pub fn BiophyloupgmaGraphN::to_string(self : BiophyloupgmaGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloupgmaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_upgma_node_make(size : Int) -> BiophyloupgmaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloupgmaNode::len(self : BiophyloupgmaNode) -> Int { self.size }

pub fn BiophyloupgmaNode::get(self : BiophyloupgmaNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloupgmaNode::set(self : BiophyloupgmaNode, i : Int, v : Double) -> BiophyloupgmaNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaNode::sum(self : BiophyloupgmaNode) -> Double { @_common.sum(self.data) }

pub fn BiophyloupgmaNode::mean(self : BiophyloupgmaNode) -> Double { @_common.mean(self.data) }

pub fn BiophyloupgmaNode::scale(self : BiophyloupgmaNode, f : Double) -> BiophyloupgmaNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaNode::add(self : BiophyloupgmaNode, other : BiophyloupgmaNode) -> BiophyloupgmaNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloupgmaNode::copy(self : BiophyloupgmaNode) -> BiophyloupgmaNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaNode::fill(self : BiophyloupgmaNode, v : Double) -> BiophyloupgmaNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaNode::min(self : BiophyloupgmaNode) -> Double { @_common.min(self.data) }

pub fn BiophyloupgmaNode::max(self : BiophyloupgmaNode) -> Double { @_common.max(self.data) }

pub fn BiophyloupgmaNode::to_string(self : BiophyloupgmaNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloupgmaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_upgma_edge_make(size : Int) -> BiophyloupgmaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloupgmaEdge::len(self : BiophyloupgmaEdge) -> Int { self.size }

pub fn BiophyloupgmaEdge::get(self : BiophyloupgmaEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloupgmaEdge::set(self : BiophyloupgmaEdge, i : Int, v : Double) -> BiophyloupgmaEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaEdge::sum(self : BiophyloupgmaEdge) -> Double { @_common.sum(self.data) }

pub fn BiophyloupgmaEdge::mean(self : BiophyloupgmaEdge) -> Double { @_common.mean(self.data) }

pub fn BiophyloupgmaEdge::scale(self : BiophyloupgmaEdge, f : Double) -> BiophyloupgmaEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaEdge::add(self : BiophyloupgmaEdge, other : BiophyloupgmaEdge) -> BiophyloupgmaEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloupgmaEdge::copy(self : BiophyloupgmaEdge) -> BiophyloupgmaEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaEdge::fill(self : BiophyloupgmaEdge, v : Double) -> BiophyloupgmaEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaEdge::min(self : BiophyloupgmaEdge) -> Double { @_common.min(self.data) }

pub fn BiophyloupgmaEdge::max(self : BiophyloupgmaEdge) -> Double { @_common.max(self.data) }

pub fn BiophyloupgmaEdge::to_string(self : BiophyloupgmaEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloupgmaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_upgma_path_make(size : Int) -> BiophyloupgmaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloupgmaPath::len(self : BiophyloupgmaPath) -> Int { self.size }

pub fn BiophyloupgmaPath::get(self : BiophyloupgmaPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloupgmaPath::set(self : BiophyloupgmaPath, i : Int, v : Double) -> BiophyloupgmaPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaPath::sum(self : BiophyloupgmaPath) -> Double { @_common.sum(self.data) }

pub fn BiophyloupgmaPath::mean(self : BiophyloupgmaPath) -> Double { @_common.mean(self.data) }

pub fn BiophyloupgmaPath::scale(self : BiophyloupgmaPath, f : Double) -> BiophyloupgmaPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaPath::add(self : BiophyloupgmaPath, other : BiophyloupgmaPath) -> BiophyloupgmaPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloupgmaPath::copy(self : BiophyloupgmaPath) -> BiophyloupgmaPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaPath::fill(self : BiophyloupgmaPath, v : Double) -> BiophyloupgmaPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaPath::min(self : BiophyloupgmaPath) -> Double { @_common.min(self.data) }

pub fn BiophyloupgmaPath::max(self : BiophyloupgmaPath) -> Double { @_common.max(self.data) }

pub fn BiophyloupgmaPath::to_string(self : BiophyloupgmaPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloupgmaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_upgma_cluster_make(size : Int) -> BiophyloupgmaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloupgmaCluster::len(self : BiophyloupgmaCluster) -> Int { self.size }

pub fn BiophyloupgmaCluster::get(self : BiophyloupgmaCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloupgmaCluster::set(self : BiophyloupgmaCluster, i : Int, v : Double) -> BiophyloupgmaCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaCluster::sum(self : BiophyloupgmaCluster) -> Double { @_common.sum(self.data) }

pub fn BiophyloupgmaCluster::mean(self : BiophyloupgmaCluster) -> Double { @_common.mean(self.data) }

pub fn BiophyloupgmaCluster::scale(self : BiophyloupgmaCluster, f : Double) -> BiophyloupgmaCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaCluster::add(self : BiophyloupgmaCluster, other : BiophyloupgmaCluster) -> BiophyloupgmaCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloupgmaCluster::copy(self : BiophyloupgmaCluster) -> BiophyloupgmaCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaCluster::fill(self : BiophyloupgmaCluster, v : Double) -> BiophyloupgmaCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaCluster::min(self : BiophyloupgmaCluster) -> Double { @_common.min(self.data) }

pub fn BiophyloupgmaCluster::max(self : BiophyloupgmaCluster) -> Double { @_common.max(self.data) }

pub fn BiophyloupgmaCluster::to_string(self : BiophyloupgmaCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloupgmaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_upgma_model_make(size : Int) -> BiophyloupgmaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloupgmaModel::len(self : BiophyloupgmaModel) -> Int { self.size }

pub fn BiophyloupgmaModel::get(self : BiophyloupgmaModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloupgmaModel::set(self : BiophyloupgmaModel, i : Int, v : Double) -> BiophyloupgmaModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaModel::sum(self : BiophyloupgmaModel) -> Double { @_common.sum(self.data) }

pub fn BiophyloupgmaModel::mean(self : BiophyloupgmaModel) -> Double { @_common.mean(self.data) }

pub fn BiophyloupgmaModel::scale(self : BiophyloupgmaModel, f : Double) -> BiophyloupgmaModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaModel::add(self : BiophyloupgmaModel, other : BiophyloupgmaModel) -> BiophyloupgmaModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloupgmaModel::copy(self : BiophyloupgmaModel) -> BiophyloupgmaModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaModel::fill(self : BiophyloupgmaModel, v : Double) -> BiophyloupgmaModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaModel::min(self : BiophyloupgmaModel) -> Double { @_common.min(self.data) }

pub fn BiophyloupgmaModel::max(self : BiophyloupgmaModel) -> Double { @_common.max(self.data) }

pub fn BiophyloupgmaModel::to_string(self : BiophyloupgmaModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloupgmaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_upgma_layer_make(size : Int) -> BiophyloupgmaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloupgmaLayer::len(self : BiophyloupgmaLayer) -> Int { self.size }

pub fn BiophyloupgmaLayer::get(self : BiophyloupgmaLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloupgmaLayer::set(self : BiophyloupgmaLayer, i : Int, v : Double) -> BiophyloupgmaLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaLayer::sum(self : BiophyloupgmaLayer) -> Double { @_common.sum(self.data) }

pub fn BiophyloupgmaLayer::mean(self : BiophyloupgmaLayer) -> Double { @_common.mean(self.data) }

pub fn BiophyloupgmaLayer::scale(self : BiophyloupgmaLayer, f : Double) -> BiophyloupgmaLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaLayer::add(self : BiophyloupgmaLayer, other : BiophyloupgmaLayer) -> BiophyloupgmaLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloupgmaLayer::copy(self : BiophyloupgmaLayer) -> BiophyloupgmaLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaLayer::fill(self : BiophyloupgmaLayer, v : Double) -> BiophyloupgmaLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaLayer::min(self : BiophyloupgmaLayer) -> Double { @_common.min(self.data) }

pub fn BiophyloupgmaLayer::max(self : BiophyloupgmaLayer) -> Double { @_common.max(self.data) }

pub fn BiophyloupgmaLayer::to_string(self : BiophyloupgmaLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloupgmaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_upgma_buffer_make(size : Int) -> BiophyloupgmaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloupgmaBuffer::len(self : BiophyloupgmaBuffer) -> Int { self.size }

pub fn BiophyloupgmaBuffer::get(self : BiophyloupgmaBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloupgmaBuffer::set(self : BiophyloupgmaBuffer, i : Int, v : Double) -> BiophyloupgmaBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaBuffer::sum(self : BiophyloupgmaBuffer) -> Double { @_common.sum(self.data) }

pub fn BiophyloupgmaBuffer::mean(self : BiophyloupgmaBuffer) -> Double { @_common.mean(self.data) }

pub fn BiophyloupgmaBuffer::scale(self : BiophyloupgmaBuffer, f : Double) -> BiophyloupgmaBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaBuffer::add(self : BiophyloupgmaBuffer, other : BiophyloupgmaBuffer) -> BiophyloupgmaBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloupgmaBuffer::copy(self : BiophyloupgmaBuffer) -> BiophyloupgmaBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaBuffer::fill(self : BiophyloupgmaBuffer, v : Double) -> BiophyloupgmaBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaBuffer::min(self : BiophyloupgmaBuffer) -> Double { @_common.min(self.data) }

pub fn BiophyloupgmaBuffer::max(self : BiophyloupgmaBuffer) -> Double { @_common.max(self.data) }

pub fn BiophyloupgmaBuffer::to_string(self : BiophyloupgmaBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloupgmaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_upgma_cursor_make(size : Int) -> BiophyloupgmaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloupgmaCursor::len(self : BiophyloupgmaCursor) -> Int { self.size }

pub fn BiophyloupgmaCursor::get(self : BiophyloupgmaCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloupgmaCursor::set(self : BiophyloupgmaCursor, i : Int, v : Double) -> BiophyloupgmaCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaCursor::sum(self : BiophyloupgmaCursor) -> Double { @_common.sum(self.data) }

pub fn BiophyloupgmaCursor::mean(self : BiophyloupgmaCursor) -> Double { @_common.mean(self.data) }

pub fn BiophyloupgmaCursor::scale(self : BiophyloupgmaCursor, f : Double) -> BiophyloupgmaCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaCursor::add(self : BiophyloupgmaCursor, other : BiophyloupgmaCursor) -> BiophyloupgmaCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloupgmaCursor::copy(self : BiophyloupgmaCursor) -> BiophyloupgmaCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaCursor::fill(self : BiophyloupgmaCursor, v : Double) -> BiophyloupgmaCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaCursor::min(self : BiophyloupgmaCursor) -> Double { @_common.min(self.data) }

pub fn BiophyloupgmaCursor::max(self : BiophyloupgmaCursor) -> Double { @_common.max(self.data) }

pub fn BiophyloupgmaCursor::to_string(self : BiophyloupgmaCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloupgmaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_upgma_view_make(size : Int) -> BiophyloupgmaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloupgmaView::len(self : BiophyloupgmaView) -> Int { self.size }

pub fn BiophyloupgmaView::get(self : BiophyloupgmaView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloupgmaView::set(self : BiophyloupgmaView, i : Int, v : Double) -> BiophyloupgmaView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaView::sum(self : BiophyloupgmaView) -> Double { @_common.sum(self.data) }

pub fn BiophyloupgmaView::mean(self : BiophyloupgmaView) -> Double { @_common.mean(self.data) }

pub fn BiophyloupgmaView::scale(self : BiophyloupgmaView, f : Double) -> BiophyloupgmaView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaView::add(self : BiophyloupgmaView, other : BiophyloupgmaView) -> BiophyloupgmaView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloupgmaView::copy(self : BiophyloupgmaView) -> BiophyloupgmaView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaView::fill(self : BiophyloupgmaView, v : Double) -> BiophyloupgmaView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaView::min(self : BiophyloupgmaView) -> Double { @_common.min(self.data) }

pub fn BiophyloupgmaView::max(self : BiophyloupgmaView) -> Double { @_common.max(self.data) }

pub fn BiophyloupgmaView::to_string(self : BiophyloupgmaView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloupgmaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_upgma_range_make(size : Int) -> BiophyloupgmaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloupgmaRange::len(self : BiophyloupgmaRange) -> Int { self.size }

pub fn BiophyloupgmaRange::get(self : BiophyloupgmaRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloupgmaRange::set(self : BiophyloupgmaRange, i : Int, v : Double) -> BiophyloupgmaRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaRange::sum(self : BiophyloupgmaRange) -> Double { @_common.sum(self.data) }

pub fn BiophyloupgmaRange::mean(self : BiophyloupgmaRange) -> Double { @_common.mean(self.data) }

pub fn BiophyloupgmaRange::scale(self : BiophyloupgmaRange, f : Double) -> BiophyloupgmaRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaRange::add(self : BiophyloupgmaRange, other : BiophyloupgmaRange) -> BiophyloupgmaRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloupgmaRange::copy(self : BiophyloupgmaRange) -> BiophyloupgmaRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaRange::fill(self : BiophyloupgmaRange, v : Double) -> BiophyloupgmaRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaRange::min(self : BiophyloupgmaRange) -> Double { @_common.min(self.data) }

pub fn BiophyloupgmaRange::max(self : BiophyloupgmaRange) -> Double { @_common.max(self.data) }

pub fn BiophyloupgmaRange::to_string(self : BiophyloupgmaRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloupgmaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_upgma_slice_make(size : Int) -> BiophyloupgmaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloupgmaSlice::len(self : BiophyloupgmaSlice) -> Int { self.size }

pub fn BiophyloupgmaSlice::get(self : BiophyloupgmaSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloupgmaSlice::set(self : BiophyloupgmaSlice, i : Int, v : Double) -> BiophyloupgmaSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaSlice::sum(self : BiophyloupgmaSlice) -> Double { @_common.sum(self.data) }

pub fn BiophyloupgmaSlice::mean(self : BiophyloupgmaSlice) -> Double { @_common.mean(self.data) }

pub fn BiophyloupgmaSlice::scale(self : BiophyloupgmaSlice, f : Double) -> BiophyloupgmaSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaSlice::add(self : BiophyloupgmaSlice, other : BiophyloupgmaSlice) -> BiophyloupgmaSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloupgmaSlice::copy(self : BiophyloupgmaSlice) -> BiophyloupgmaSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaSlice::fill(self : BiophyloupgmaSlice, v : Double) -> BiophyloupgmaSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloupgmaSlice::min(self : BiophyloupgmaSlice) -> Double { @_common.min(self.data) }

pub fn BiophyloupgmaSlice::max(self : BiophyloupgmaSlice) -> Double { @_common.max(self.data) }

pub fn BiophyloupgmaSlice::to_string(self : BiophyloupgmaSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

