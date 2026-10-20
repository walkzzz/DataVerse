///===
/// extcore/bio_phylo_neighbor

pub(all) struct BiophyloneighborPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_phylo_neighbor_make_point(x : Double, y : Double) -> BiophyloneighborPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_phylo_neighbor_make_point3(x : Double, y : Double, z : Double) -> BiophyloneighborPoint {
  { x, y, z, label: 0 }
}

pub fn BiophyloneighborPoint::x(self : BiophyloneighborPoint) -> Double { self.x }

pub fn BiophyloneighborPoint::y(self : BiophyloneighborPoint) -> Double { self.y }

pub fn BiophyloneighborPoint::z(self : BiophyloneighborPoint) -> Double { self.z }

pub fn BiophyloneighborPoint::label(self : BiophyloneighborPoint) -> Int { self.label }

pub fn BiophyloneighborPoint::dist(self : BiophyloneighborPoint, other : BiophyloneighborPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BiophyloneighborPoint::add(self : BiophyloneighborPoint, other : BiophyloneighborPoint) -> BiophyloneighborPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BiophyloneighborPoint::sub(self : BiophyloneighborPoint, other : BiophyloneighborPoint) -> BiophyloneighborPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BiophyloneighborPoint::scale(self : BiophyloneighborPoint, s : Double) -> BiophyloneighborPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BiophyloneighborPoint::dot(self : BiophyloneighborPoint, other : BiophyloneighborPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BiophyloneighborPoint::cross(self : BiophyloneighborPoint, other : BiophyloneighborPoint) -> BiophyloneighborPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BiophyloneighborPoint::norm(self : BiophyloneighborPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BiophyloneighborPoint::normalize(self : BiophyloneighborPoint) -> BiophyloneighborPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiophyloneighborPoint::negate(self : BiophyloneighborPoint) -> BiophyloneighborPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BiophyloneighborPoint::mid(self : BiophyloneighborPoint, other : BiophyloneighborPoint) -> BiophyloneighborPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BiophyloneighborPoint::lerp(self : BiophyloneighborPoint, other : BiophyloneighborPoint, t : Double) -> BiophyloneighborPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BiophyloneighborPoint::to_string(self : BiophyloneighborPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BiophyloneighborSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_phylo_neighbor_make_series(vals : Array[Double], name : String) -> BiophyloneighborSeries {
  { vals, name, meta: 0 }
}

pub fn BiophyloneighborSeries::len(self : BiophyloneighborSeries) -> Int { self.vals.length() }

pub fn BiophyloneighborSeries::sum(self : BiophyloneighborSeries) -> Double { @_common.sum(self.vals) }

pub fn BiophyloneighborSeries::mean(self : BiophyloneighborSeries) -> Double { @_common.mean(self.vals) }

pub fn BiophyloneighborSeries::min(self : BiophyloneighborSeries) -> Double { @_common.min(self.vals) }

pub fn BiophyloneighborSeries::max(self : BiophyloneighborSeries) -> Double { @_common.max(self.vals) }

pub fn BiophyloneighborSeries::range(self : BiophyloneighborSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BiophyloneighborSeries::variance(self : BiophyloneighborSeries) -> Double { @_common.variance(self.vals) }

pub fn BiophyloneighborSeries::std(self : BiophyloneighborSeries) -> Double { @_common.std(self.vals) }

pub fn BiophyloneighborSeries::median(self : BiophyloneighborSeries) -> Double { @_common.median(self.vals) }

pub fn BiophyloneighborSeries::scale(self : BiophyloneighborSeries, f : Double) -> BiophyloneighborSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BiophyloneighborSeries::add(self : BiophyloneighborSeries, other : BiophyloneighborSeries) -> BiophyloneighborSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BiophyloneighborSeries::sub(self : BiophyloneighborSeries, other : BiophyloneighborSeries) -> BiophyloneighborSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BiophyloneighborSeries::normalize(self : BiophyloneighborSeries) -> BiophyloneighborSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BiophyloneighborSeries::cumsum(self : BiophyloneighborSeries) -> BiophyloneighborSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BiophyloneighborSeries::to_string(self : BiophyloneighborSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiophyloneighborMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_phylo_neighbor_make_matrix(rows : Int, cols : Int, val : Double) -> BiophyloneighborMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn bio_phylo_neighbor_matrix_identity(n : Int) -> BiophyloneighborMatrix {
  let m = bio_phylo_neighbor_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BiophyloneighborMatrix::get(self : BiophyloneighborMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BiophyloneighborMatrix::transpose(self : BiophyloneighborMatrix) -> BiophyloneighborMatrix {
  let result = bio_phylo_neighbor_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BiophyloneighborMatrix::add(self : BiophyloneighborMatrix, other : BiophyloneighborMatrix) -> BiophyloneighborMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_phylo_neighbor_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BiophyloneighborMatrix::scale(self : BiophyloneighborMatrix, s : Double) -> BiophyloneighborMatrix {
  let result = bio_phylo_neighbor_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BiophyloneighborMatrix::multiply(self : BiophyloneighborMatrix, other : BiophyloneighborMatrix) -> BiophyloneighborMatrix {
  if self.cols != other.rows { return bio_phylo_neighbor_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_phylo_neighbor_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn BiophyloneighborMatrix::trace(self : BiophyloneighborMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BiophyloneighborMatrix::det(self : BiophyloneighborMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BiophyloneighborMatrix::norm(self : BiophyloneighborMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BiophyloneighborMatrix::to_string(self : BiophyloneighborMatrix) -> String {
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

pub(all) struct BiophyloneighborVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_phylo_neighbor_make_vector(comps : Array[Double]) -> BiophyloneighborVector {
  { comps, dim: comps.length() }
}

pub fn bio_phylo_neighbor_vector_zero(dim : Int) -> BiophyloneighborVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BiophyloneighborVector::add(self : BiophyloneighborVector, other : BiophyloneighborVector) -> BiophyloneighborVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BiophyloneighborVector::sub(self : BiophyloneighborVector, other : BiophyloneighborVector) -> BiophyloneighborVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BiophyloneighborVector::scale(self : BiophyloneighborVector, s : Double) -> BiophyloneighborVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BiophyloneighborVector::dot(self : BiophyloneighborVector, other : BiophyloneighborVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BiophyloneighborVector::norm(self : BiophyloneighborVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BiophyloneighborVector::normalize(self : BiophyloneighborVector) -> BiophyloneighborVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiophyloneighborVector::dist(self : BiophyloneighborVector, other : BiophyloneighborVector) -> Double {
  self.sub(other).norm()
}

pub fn BiophyloneighborVector::to_string(self : BiophyloneighborVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiophyloneighborFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_neighbor_frame_make(size : Int) -> BiophyloneighborFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloneighborFrame::len(self : BiophyloneighborFrame) -> Int { self.size }

pub fn BiophyloneighborFrame::get(self : BiophyloneighborFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloneighborFrame::set(self : BiophyloneighborFrame, i : Int, v : Double) -> BiophyloneighborFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloneighborFrame::sum(self : BiophyloneighborFrame) -> Double { @_common.sum(self.data) }

pub fn BiophyloneighborFrame::mean(self : BiophyloneighborFrame) -> Double { @_common.mean(self.data) }

pub fn BiophyloneighborFrame::scale(self : BiophyloneighborFrame, f : Double) -> BiophyloneighborFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloneighborFrame::add(self : BiophyloneighborFrame, other : BiophyloneighborFrame) -> BiophyloneighborFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloneighborFrame::copy(self : BiophyloneighborFrame) -> BiophyloneighborFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloneighborFrame::fill(self : BiophyloneighborFrame, v : Double) -> BiophyloneighborFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloneighborFrame::min(self : BiophyloneighborFrame) -> Double { @_common.min(self.data) }

pub fn BiophyloneighborFrame::max(self : BiophyloneighborFrame) -> Double { @_common.max(self.data) }

pub fn BiophyloneighborFrame::to_string(self : BiophyloneighborFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloneighborTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_neighbor_table_make(size : Int) -> BiophyloneighborTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloneighborTable::len(self : BiophyloneighborTable) -> Int { self.size }

pub fn BiophyloneighborTable::get(self : BiophyloneighborTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloneighborTable::set(self : BiophyloneighborTable, i : Int, v : Double) -> BiophyloneighborTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloneighborTable::sum(self : BiophyloneighborTable) -> Double { @_common.sum(self.data) }

pub fn BiophyloneighborTable::mean(self : BiophyloneighborTable) -> Double { @_common.mean(self.data) }

pub fn BiophyloneighborTable::scale(self : BiophyloneighborTable, f : Double) -> BiophyloneighborTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloneighborTable::add(self : BiophyloneighborTable, other : BiophyloneighborTable) -> BiophyloneighborTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloneighborTable::copy(self : BiophyloneighborTable) -> BiophyloneighborTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloneighborTable::fill(self : BiophyloneighborTable, v : Double) -> BiophyloneighborTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloneighborTable::min(self : BiophyloneighborTable) -> Double { @_common.min(self.data) }

pub fn BiophyloneighborTable::max(self : BiophyloneighborTable) -> Double { @_common.max(self.data) }

pub fn BiophyloneighborTable::to_string(self : BiophyloneighborTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloneighborGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_neighbor_graphn_make(size : Int) -> BiophyloneighborGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloneighborGraphN::len(self : BiophyloneighborGraphN) -> Int { self.size }

pub fn BiophyloneighborGraphN::get(self : BiophyloneighborGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloneighborGraphN::set(self : BiophyloneighborGraphN, i : Int, v : Double) -> BiophyloneighborGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloneighborGraphN::sum(self : BiophyloneighborGraphN) -> Double { @_common.sum(self.data) }

pub fn BiophyloneighborGraphN::mean(self : BiophyloneighborGraphN) -> Double { @_common.mean(self.data) }

pub fn BiophyloneighborGraphN::scale(self : BiophyloneighborGraphN, f : Double) -> BiophyloneighborGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloneighborGraphN::add(self : BiophyloneighborGraphN, other : BiophyloneighborGraphN) -> BiophyloneighborGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloneighborGraphN::copy(self : BiophyloneighborGraphN) -> BiophyloneighborGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloneighborGraphN::fill(self : BiophyloneighborGraphN, v : Double) -> BiophyloneighborGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloneighborGraphN::min(self : BiophyloneighborGraphN) -> Double { @_common.min(self.data) }

pub fn BiophyloneighborGraphN::max(self : BiophyloneighborGraphN) -> Double { @_common.max(self.data) }

pub fn BiophyloneighborGraphN::to_string(self : BiophyloneighborGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloneighborNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_neighbor_node_make(size : Int) -> BiophyloneighborNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloneighborNode::len(self : BiophyloneighborNode) -> Int { self.size }

pub fn BiophyloneighborNode::get(self : BiophyloneighborNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloneighborNode::set(self : BiophyloneighborNode, i : Int, v : Double) -> BiophyloneighborNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloneighborNode::sum(self : BiophyloneighborNode) -> Double { @_common.sum(self.data) }

pub fn BiophyloneighborNode::mean(self : BiophyloneighborNode) -> Double { @_common.mean(self.data) }

pub fn BiophyloneighborNode::scale(self : BiophyloneighborNode, f : Double) -> BiophyloneighborNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloneighborNode::add(self : BiophyloneighborNode, other : BiophyloneighborNode) -> BiophyloneighborNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloneighborNode::copy(self : BiophyloneighborNode) -> BiophyloneighborNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloneighborNode::fill(self : BiophyloneighborNode, v : Double) -> BiophyloneighborNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloneighborNode::min(self : BiophyloneighborNode) -> Double { @_common.min(self.data) }

pub fn BiophyloneighborNode::max(self : BiophyloneighborNode) -> Double { @_common.max(self.data) }

pub fn BiophyloneighborNode::to_string(self : BiophyloneighborNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloneighborEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_neighbor_edge_make(size : Int) -> BiophyloneighborEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloneighborEdge::len(self : BiophyloneighborEdge) -> Int { self.size }

pub fn BiophyloneighborEdge::get(self : BiophyloneighborEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloneighborEdge::set(self : BiophyloneighborEdge, i : Int, v : Double) -> BiophyloneighborEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloneighborEdge::sum(self : BiophyloneighborEdge) -> Double { @_common.sum(self.data) }

pub fn BiophyloneighborEdge::mean(self : BiophyloneighborEdge) -> Double { @_common.mean(self.data) }

pub fn BiophyloneighborEdge::scale(self : BiophyloneighborEdge, f : Double) -> BiophyloneighborEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloneighborEdge::add(self : BiophyloneighborEdge, other : BiophyloneighborEdge) -> BiophyloneighborEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloneighborEdge::copy(self : BiophyloneighborEdge) -> BiophyloneighborEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloneighborEdge::fill(self : BiophyloneighborEdge, v : Double) -> BiophyloneighborEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloneighborEdge::min(self : BiophyloneighborEdge) -> Double { @_common.min(self.data) }

pub fn BiophyloneighborEdge::max(self : BiophyloneighborEdge) -> Double { @_common.max(self.data) }

pub fn BiophyloneighborEdge::to_string(self : BiophyloneighborEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloneighborPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_neighbor_path_make(size : Int) -> BiophyloneighborPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloneighborPath::len(self : BiophyloneighborPath) -> Int { self.size }

pub fn BiophyloneighborPath::get(self : BiophyloneighborPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloneighborPath::set(self : BiophyloneighborPath, i : Int, v : Double) -> BiophyloneighborPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloneighborPath::sum(self : BiophyloneighborPath) -> Double { @_common.sum(self.data) }

pub fn BiophyloneighborPath::mean(self : BiophyloneighborPath) -> Double { @_common.mean(self.data) }

pub fn BiophyloneighborPath::scale(self : BiophyloneighborPath, f : Double) -> BiophyloneighborPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloneighborPath::add(self : BiophyloneighborPath, other : BiophyloneighborPath) -> BiophyloneighborPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloneighborPath::copy(self : BiophyloneighborPath) -> BiophyloneighborPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloneighborPath::fill(self : BiophyloneighborPath, v : Double) -> BiophyloneighborPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloneighborPath::min(self : BiophyloneighborPath) -> Double { @_common.min(self.data) }

pub fn BiophyloneighborPath::max(self : BiophyloneighborPath) -> Double { @_common.max(self.data) }

pub fn BiophyloneighborPath::to_string(self : BiophyloneighborPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloneighborCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_neighbor_cluster_make(size : Int) -> BiophyloneighborCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloneighborCluster::len(self : BiophyloneighborCluster) -> Int { self.size }

pub fn BiophyloneighborCluster::get(self : BiophyloneighborCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloneighborCluster::set(self : BiophyloneighborCluster, i : Int, v : Double) -> BiophyloneighborCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloneighborCluster::sum(self : BiophyloneighborCluster) -> Double { @_common.sum(self.data) }

pub fn BiophyloneighborCluster::mean(self : BiophyloneighborCluster) -> Double { @_common.mean(self.data) }

pub fn BiophyloneighborCluster::scale(self : BiophyloneighborCluster, f : Double) -> BiophyloneighborCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloneighborCluster::add(self : BiophyloneighborCluster, other : BiophyloneighborCluster) -> BiophyloneighborCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloneighborCluster::copy(self : BiophyloneighborCluster) -> BiophyloneighborCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloneighborCluster::fill(self : BiophyloneighborCluster, v : Double) -> BiophyloneighborCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloneighborCluster::min(self : BiophyloneighborCluster) -> Double { @_common.min(self.data) }

pub fn BiophyloneighborCluster::max(self : BiophyloneighborCluster) -> Double { @_common.max(self.data) }

pub fn BiophyloneighborCluster::to_string(self : BiophyloneighborCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloneighborModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_neighbor_model_make(size : Int) -> BiophyloneighborModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloneighborModel::len(self : BiophyloneighborModel) -> Int { self.size }

pub fn BiophyloneighborModel::get(self : BiophyloneighborModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloneighborModel::set(self : BiophyloneighborModel, i : Int, v : Double) -> BiophyloneighborModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloneighborModel::sum(self : BiophyloneighborModel) -> Double { @_common.sum(self.data) }

pub fn BiophyloneighborModel::mean(self : BiophyloneighborModel) -> Double { @_common.mean(self.data) }

pub fn BiophyloneighborModel::scale(self : BiophyloneighborModel, f : Double) -> BiophyloneighborModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloneighborModel::add(self : BiophyloneighborModel, other : BiophyloneighborModel) -> BiophyloneighborModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloneighborModel::copy(self : BiophyloneighborModel) -> BiophyloneighborModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloneighborModel::fill(self : BiophyloneighborModel, v : Double) -> BiophyloneighborModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloneighborModel::min(self : BiophyloneighborModel) -> Double { @_common.min(self.data) }

pub fn BiophyloneighborModel::max(self : BiophyloneighborModel) -> Double { @_common.max(self.data) }

pub fn BiophyloneighborModel::to_string(self : BiophyloneighborModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloneighborLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_neighbor_layer_make(size : Int) -> BiophyloneighborLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloneighborLayer::len(self : BiophyloneighborLayer) -> Int { self.size }

pub fn BiophyloneighborLayer::get(self : BiophyloneighborLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloneighborLayer::set(self : BiophyloneighborLayer, i : Int, v : Double) -> BiophyloneighborLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloneighborLayer::sum(self : BiophyloneighborLayer) -> Double { @_common.sum(self.data) }

pub fn BiophyloneighborLayer::mean(self : BiophyloneighborLayer) -> Double { @_common.mean(self.data) }

pub fn BiophyloneighborLayer::scale(self : BiophyloneighborLayer, f : Double) -> BiophyloneighborLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloneighborLayer::add(self : BiophyloneighborLayer, other : BiophyloneighborLayer) -> BiophyloneighborLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloneighborLayer::copy(self : BiophyloneighborLayer) -> BiophyloneighborLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloneighborLayer::fill(self : BiophyloneighborLayer, v : Double) -> BiophyloneighborLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloneighborLayer::min(self : BiophyloneighborLayer) -> Double { @_common.min(self.data) }

pub fn BiophyloneighborLayer::max(self : BiophyloneighborLayer) -> Double { @_common.max(self.data) }

pub fn BiophyloneighborLayer::to_string(self : BiophyloneighborLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloneighborBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_neighbor_buffer_make(size : Int) -> BiophyloneighborBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloneighborBuffer::len(self : BiophyloneighborBuffer) -> Int { self.size }

pub fn BiophyloneighborBuffer::get(self : BiophyloneighborBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloneighborBuffer::set(self : BiophyloneighborBuffer, i : Int, v : Double) -> BiophyloneighborBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloneighborBuffer::sum(self : BiophyloneighborBuffer) -> Double { @_common.sum(self.data) }

pub fn BiophyloneighborBuffer::mean(self : BiophyloneighborBuffer) -> Double { @_common.mean(self.data) }

pub fn BiophyloneighborBuffer::scale(self : BiophyloneighborBuffer, f : Double) -> BiophyloneighborBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloneighborBuffer::add(self : BiophyloneighborBuffer, other : BiophyloneighborBuffer) -> BiophyloneighborBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloneighborBuffer::copy(self : BiophyloneighborBuffer) -> BiophyloneighborBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloneighborBuffer::fill(self : BiophyloneighborBuffer, v : Double) -> BiophyloneighborBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloneighborBuffer::min(self : BiophyloneighborBuffer) -> Double { @_common.min(self.data) }

pub fn BiophyloneighborBuffer::max(self : BiophyloneighborBuffer) -> Double { @_common.max(self.data) }

pub fn BiophyloneighborBuffer::to_string(self : BiophyloneighborBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloneighborCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_neighbor_cursor_make(size : Int) -> BiophyloneighborCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloneighborCursor::len(self : BiophyloneighborCursor) -> Int { self.size }

pub fn BiophyloneighborCursor::get(self : BiophyloneighborCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloneighborCursor::set(self : BiophyloneighborCursor, i : Int, v : Double) -> BiophyloneighborCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloneighborCursor::sum(self : BiophyloneighborCursor) -> Double { @_common.sum(self.data) }

pub fn BiophyloneighborCursor::mean(self : BiophyloneighborCursor) -> Double { @_common.mean(self.data) }

pub fn BiophyloneighborCursor::scale(self : BiophyloneighborCursor, f : Double) -> BiophyloneighborCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloneighborCursor::add(self : BiophyloneighborCursor, other : BiophyloneighborCursor) -> BiophyloneighborCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloneighborCursor::copy(self : BiophyloneighborCursor) -> BiophyloneighborCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloneighborCursor::fill(self : BiophyloneighborCursor, v : Double) -> BiophyloneighborCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloneighborCursor::min(self : BiophyloneighborCursor) -> Double { @_common.min(self.data) }

pub fn BiophyloneighborCursor::max(self : BiophyloneighborCursor) -> Double { @_common.max(self.data) }

pub fn BiophyloneighborCursor::to_string(self : BiophyloneighborCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloneighborView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_neighbor_view_make(size : Int) -> BiophyloneighborView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloneighborView::len(self : BiophyloneighborView) -> Int { self.size }

pub fn BiophyloneighborView::get(self : BiophyloneighborView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloneighborView::set(self : BiophyloneighborView, i : Int, v : Double) -> BiophyloneighborView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloneighborView::sum(self : BiophyloneighborView) -> Double { @_common.sum(self.data) }

pub fn BiophyloneighborView::mean(self : BiophyloneighborView) -> Double { @_common.mean(self.data) }

pub fn BiophyloneighborView::scale(self : BiophyloneighborView, f : Double) -> BiophyloneighborView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloneighborView::add(self : BiophyloneighborView, other : BiophyloneighborView) -> BiophyloneighborView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloneighborView::copy(self : BiophyloneighborView) -> BiophyloneighborView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloneighborView::fill(self : BiophyloneighborView, v : Double) -> BiophyloneighborView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloneighborView::min(self : BiophyloneighborView) -> Double { @_common.min(self.data) }

pub fn BiophyloneighborView::max(self : BiophyloneighborView) -> Double { @_common.max(self.data) }

pub fn BiophyloneighborView::to_string(self : BiophyloneighborView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloneighborRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_neighbor_range_make(size : Int) -> BiophyloneighborRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloneighborRange::len(self : BiophyloneighborRange) -> Int { self.size }

pub fn BiophyloneighborRange::get(self : BiophyloneighborRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloneighborRange::set(self : BiophyloneighborRange, i : Int, v : Double) -> BiophyloneighborRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloneighborRange::sum(self : BiophyloneighborRange) -> Double { @_common.sum(self.data) }

pub fn BiophyloneighborRange::mean(self : BiophyloneighborRange) -> Double { @_common.mean(self.data) }

pub fn BiophyloneighborRange::scale(self : BiophyloneighborRange, f : Double) -> BiophyloneighborRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloneighborRange::add(self : BiophyloneighborRange, other : BiophyloneighborRange) -> BiophyloneighborRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloneighborRange::copy(self : BiophyloneighborRange) -> BiophyloneighborRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloneighborRange::fill(self : BiophyloneighborRange, v : Double) -> BiophyloneighborRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloneighborRange::min(self : BiophyloneighborRange) -> Double { @_common.min(self.data) }

pub fn BiophyloneighborRange::max(self : BiophyloneighborRange) -> Double { @_common.max(self.data) }

pub fn BiophyloneighborRange::to_string(self : BiophyloneighborRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophyloneighborSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_neighbor_slice_make(size : Int) -> BiophyloneighborSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophyloneighborSlice::len(self : BiophyloneighborSlice) -> Int { self.size }

pub fn BiophyloneighborSlice::get(self : BiophyloneighborSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophyloneighborSlice::set(self : BiophyloneighborSlice, i : Int, v : Double) -> BiophyloneighborSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophyloneighborSlice::sum(self : BiophyloneighborSlice) -> Double { @_common.sum(self.data) }

pub fn BiophyloneighborSlice::mean(self : BiophyloneighborSlice) -> Double { @_common.mean(self.data) }

pub fn BiophyloneighborSlice::scale(self : BiophyloneighborSlice, f : Double) -> BiophyloneighborSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophyloneighborSlice::add(self : BiophyloneighborSlice, other : BiophyloneighborSlice) -> BiophyloneighborSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophyloneighborSlice::copy(self : BiophyloneighborSlice) -> BiophyloneighborSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophyloneighborSlice::fill(self : BiophyloneighborSlice, v : Double) -> BiophyloneighborSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophyloneighborSlice::min(self : BiophyloneighborSlice) -> Double { @_common.min(self.data) }

pub fn BiophyloneighborSlice::max(self : BiophyloneighborSlice) -> Double { @_common.max(self.data) }

pub fn BiophyloneighborSlice::to_string(self : BiophyloneighborSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

