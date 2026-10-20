///===
/// extcore/bio_phylo_distance

pub(all) struct BiophylodistancePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_phylo_distance_make_point(x : Double, y : Double) -> BiophylodistancePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_phylo_distance_make_point3(x : Double, y : Double, z : Double) -> BiophylodistancePoint {
  { x, y, z, label: 0 }
}

pub fn BiophylodistancePoint::x(self : BiophylodistancePoint) -> Double { self.x }

pub fn BiophylodistancePoint::y(self : BiophylodistancePoint) -> Double { self.y }

pub fn BiophylodistancePoint::z(self : BiophylodistancePoint) -> Double { self.z }

pub fn BiophylodistancePoint::label(self : BiophylodistancePoint) -> Int { self.label }

pub fn BiophylodistancePoint::dist(self : BiophylodistancePoint, other : BiophylodistancePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BiophylodistancePoint::add(self : BiophylodistancePoint, other : BiophylodistancePoint) -> BiophylodistancePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BiophylodistancePoint::sub(self : BiophylodistancePoint, other : BiophylodistancePoint) -> BiophylodistancePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BiophylodistancePoint::scale(self : BiophylodistancePoint, s : Double) -> BiophylodistancePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BiophylodistancePoint::dot(self : BiophylodistancePoint, other : BiophylodistancePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BiophylodistancePoint::cross(self : BiophylodistancePoint, other : BiophylodistancePoint) -> BiophylodistancePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BiophylodistancePoint::norm(self : BiophylodistancePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BiophylodistancePoint::normalize(self : BiophylodistancePoint) -> BiophylodistancePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiophylodistancePoint::negate(self : BiophylodistancePoint) -> BiophylodistancePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BiophylodistancePoint::mid(self : BiophylodistancePoint, other : BiophylodistancePoint) -> BiophylodistancePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BiophylodistancePoint::lerp(self : BiophylodistancePoint, other : BiophylodistancePoint, t : Double) -> BiophylodistancePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BiophylodistancePoint::to_string(self : BiophylodistancePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BiophylodistanceSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_phylo_distance_make_series(vals : Array[Double], name : String) -> BiophylodistanceSeries {
  { vals, name, meta: 0 }
}

pub fn BiophylodistanceSeries::len(self : BiophylodistanceSeries) -> Int { self.vals.length() }

pub fn BiophylodistanceSeries::sum(self : BiophylodistanceSeries) -> Double { @_common.sum(self.vals) }

pub fn BiophylodistanceSeries::mean(self : BiophylodistanceSeries) -> Double { @_common.mean(self.vals) }

pub fn BiophylodistanceSeries::min(self : BiophylodistanceSeries) -> Double { @_common.min(self.vals) }

pub fn BiophylodistanceSeries::max(self : BiophylodistanceSeries) -> Double { @_common.max(self.vals) }

pub fn BiophylodistanceSeries::range(self : BiophylodistanceSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BiophylodistanceSeries::variance(self : BiophylodistanceSeries) -> Double { @_common.variance(self.vals) }

pub fn BiophylodistanceSeries::std(self : BiophylodistanceSeries) -> Double { @_common.std(self.vals) }

pub fn BiophylodistanceSeries::median(self : BiophylodistanceSeries) -> Double { @_common.median(self.vals) }

pub fn BiophylodistanceSeries::scale(self : BiophylodistanceSeries, f : Double) -> BiophylodistanceSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BiophylodistanceSeries::add(self : BiophylodistanceSeries, other : BiophylodistanceSeries) -> BiophylodistanceSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BiophylodistanceSeries::sub(self : BiophylodistanceSeries, other : BiophylodistanceSeries) -> BiophylodistanceSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BiophylodistanceSeries::normalize(self : BiophylodistanceSeries) -> BiophylodistanceSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BiophylodistanceSeries::cumsum(self : BiophylodistanceSeries) -> BiophylodistanceSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BiophylodistanceSeries::to_string(self : BiophylodistanceSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiophylodistanceMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_phylo_distance_make_matrix(rows : Int, cols : Int, val : Double) -> BiophylodistanceMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn bio_phylo_distance_matrix_identity(n : Int) -> BiophylodistanceMatrix {
  let m = bio_phylo_distance_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BiophylodistanceMatrix::get(self : BiophylodistanceMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BiophylodistanceMatrix::transpose(self : BiophylodistanceMatrix) -> BiophylodistanceMatrix {
  let result = bio_phylo_distance_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BiophylodistanceMatrix::add(self : BiophylodistanceMatrix, other : BiophylodistanceMatrix) -> BiophylodistanceMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_phylo_distance_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BiophylodistanceMatrix::scale(self : BiophylodistanceMatrix, s : Double) -> BiophylodistanceMatrix {
  let result = bio_phylo_distance_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BiophylodistanceMatrix::multiply(self : BiophylodistanceMatrix, other : BiophylodistanceMatrix) -> BiophylodistanceMatrix {
  if self.cols != other.rows { return bio_phylo_distance_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_phylo_distance_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn BiophylodistanceMatrix::trace(self : BiophylodistanceMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BiophylodistanceMatrix::det(self : BiophylodistanceMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BiophylodistanceMatrix::norm(self : BiophylodistanceMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BiophylodistanceMatrix::to_string(self : BiophylodistanceMatrix) -> String {
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

pub(all) struct BiophylodistanceVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_phylo_distance_make_vector(comps : Array[Double]) -> BiophylodistanceVector {
  { comps, dim: comps.length() }
}

pub fn bio_phylo_distance_vector_zero(dim : Int) -> BiophylodistanceVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BiophylodistanceVector::add(self : BiophylodistanceVector, other : BiophylodistanceVector) -> BiophylodistanceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BiophylodistanceVector::sub(self : BiophylodistanceVector, other : BiophylodistanceVector) -> BiophylodistanceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BiophylodistanceVector::scale(self : BiophylodistanceVector, s : Double) -> BiophylodistanceVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BiophylodistanceVector::dot(self : BiophylodistanceVector, other : BiophylodistanceVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BiophylodistanceVector::norm(self : BiophylodistanceVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BiophylodistanceVector::normalize(self : BiophylodistanceVector) -> BiophylodistanceVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiophylodistanceVector::dist(self : BiophylodistanceVector, other : BiophylodistanceVector) -> Double {
  self.sub(other).norm()
}

pub fn BiophylodistanceVector::to_string(self : BiophylodistanceVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiophylodistanceFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_distance_frame_make(size : Int) -> BiophylodistanceFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylodistanceFrame::len(self : BiophylodistanceFrame) -> Int { self.size }

pub fn BiophylodistanceFrame::get(self : BiophylodistanceFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylodistanceFrame::set(self : BiophylodistanceFrame, i : Int, v : Double) -> BiophylodistanceFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylodistanceFrame::sum(self : BiophylodistanceFrame) -> Double { @_common.sum(self.data) }

pub fn BiophylodistanceFrame::mean(self : BiophylodistanceFrame) -> Double { @_common.mean(self.data) }

pub fn BiophylodistanceFrame::scale(self : BiophylodistanceFrame, f : Double) -> BiophylodistanceFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylodistanceFrame::add(self : BiophylodistanceFrame, other : BiophylodistanceFrame) -> BiophylodistanceFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylodistanceFrame::copy(self : BiophylodistanceFrame) -> BiophylodistanceFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylodistanceFrame::fill(self : BiophylodistanceFrame, v : Double) -> BiophylodistanceFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylodistanceFrame::min(self : BiophylodistanceFrame) -> Double { @_common.min(self.data) }

pub fn BiophylodistanceFrame::max(self : BiophylodistanceFrame) -> Double { @_common.max(self.data) }

pub fn BiophylodistanceFrame::to_string(self : BiophylodistanceFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylodistanceTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_distance_table_make(size : Int) -> BiophylodistanceTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylodistanceTable::len(self : BiophylodistanceTable) -> Int { self.size }

pub fn BiophylodistanceTable::get(self : BiophylodistanceTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylodistanceTable::set(self : BiophylodistanceTable, i : Int, v : Double) -> BiophylodistanceTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylodistanceTable::sum(self : BiophylodistanceTable) -> Double { @_common.sum(self.data) }

pub fn BiophylodistanceTable::mean(self : BiophylodistanceTable) -> Double { @_common.mean(self.data) }

pub fn BiophylodistanceTable::scale(self : BiophylodistanceTable, f : Double) -> BiophylodistanceTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylodistanceTable::add(self : BiophylodistanceTable, other : BiophylodistanceTable) -> BiophylodistanceTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylodistanceTable::copy(self : BiophylodistanceTable) -> BiophylodistanceTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylodistanceTable::fill(self : BiophylodistanceTable, v : Double) -> BiophylodistanceTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylodistanceTable::min(self : BiophylodistanceTable) -> Double { @_common.min(self.data) }

pub fn BiophylodistanceTable::max(self : BiophylodistanceTable) -> Double { @_common.max(self.data) }

pub fn BiophylodistanceTable::to_string(self : BiophylodistanceTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylodistanceGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_distance_graphn_make(size : Int) -> BiophylodistanceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylodistanceGraphN::len(self : BiophylodistanceGraphN) -> Int { self.size }

pub fn BiophylodistanceGraphN::get(self : BiophylodistanceGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylodistanceGraphN::set(self : BiophylodistanceGraphN, i : Int, v : Double) -> BiophylodistanceGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylodistanceGraphN::sum(self : BiophylodistanceGraphN) -> Double { @_common.sum(self.data) }

pub fn BiophylodistanceGraphN::mean(self : BiophylodistanceGraphN) -> Double { @_common.mean(self.data) }

pub fn BiophylodistanceGraphN::scale(self : BiophylodistanceGraphN, f : Double) -> BiophylodistanceGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylodistanceGraphN::add(self : BiophylodistanceGraphN, other : BiophylodistanceGraphN) -> BiophylodistanceGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylodistanceGraphN::copy(self : BiophylodistanceGraphN) -> BiophylodistanceGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylodistanceGraphN::fill(self : BiophylodistanceGraphN, v : Double) -> BiophylodistanceGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylodistanceGraphN::min(self : BiophylodistanceGraphN) -> Double { @_common.min(self.data) }

pub fn BiophylodistanceGraphN::max(self : BiophylodistanceGraphN) -> Double { @_common.max(self.data) }

pub fn BiophylodistanceGraphN::to_string(self : BiophylodistanceGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylodistanceNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_distance_node_make(size : Int) -> BiophylodistanceNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylodistanceNode::len(self : BiophylodistanceNode) -> Int { self.size }

pub fn BiophylodistanceNode::get(self : BiophylodistanceNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylodistanceNode::set(self : BiophylodistanceNode, i : Int, v : Double) -> BiophylodistanceNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylodistanceNode::sum(self : BiophylodistanceNode) -> Double { @_common.sum(self.data) }

pub fn BiophylodistanceNode::mean(self : BiophylodistanceNode) -> Double { @_common.mean(self.data) }

pub fn BiophylodistanceNode::scale(self : BiophylodistanceNode, f : Double) -> BiophylodistanceNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylodistanceNode::add(self : BiophylodistanceNode, other : BiophylodistanceNode) -> BiophylodistanceNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylodistanceNode::copy(self : BiophylodistanceNode) -> BiophylodistanceNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylodistanceNode::fill(self : BiophylodistanceNode, v : Double) -> BiophylodistanceNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylodistanceNode::min(self : BiophylodistanceNode) -> Double { @_common.min(self.data) }

pub fn BiophylodistanceNode::max(self : BiophylodistanceNode) -> Double { @_common.max(self.data) }

pub fn BiophylodistanceNode::to_string(self : BiophylodistanceNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylodistanceEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_distance_edge_make(size : Int) -> BiophylodistanceEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylodistanceEdge::len(self : BiophylodistanceEdge) -> Int { self.size }

pub fn BiophylodistanceEdge::get(self : BiophylodistanceEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylodistanceEdge::set(self : BiophylodistanceEdge, i : Int, v : Double) -> BiophylodistanceEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylodistanceEdge::sum(self : BiophylodistanceEdge) -> Double { @_common.sum(self.data) }

pub fn BiophylodistanceEdge::mean(self : BiophylodistanceEdge) -> Double { @_common.mean(self.data) }

pub fn BiophylodistanceEdge::scale(self : BiophylodistanceEdge, f : Double) -> BiophylodistanceEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylodistanceEdge::add(self : BiophylodistanceEdge, other : BiophylodistanceEdge) -> BiophylodistanceEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylodistanceEdge::copy(self : BiophylodistanceEdge) -> BiophylodistanceEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylodistanceEdge::fill(self : BiophylodistanceEdge, v : Double) -> BiophylodistanceEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylodistanceEdge::min(self : BiophylodistanceEdge) -> Double { @_common.min(self.data) }

pub fn BiophylodistanceEdge::max(self : BiophylodistanceEdge) -> Double { @_common.max(self.data) }

pub fn BiophylodistanceEdge::to_string(self : BiophylodistanceEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylodistancePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_distance_path_make(size : Int) -> BiophylodistancePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylodistancePath::len(self : BiophylodistancePath) -> Int { self.size }

pub fn BiophylodistancePath::get(self : BiophylodistancePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylodistancePath::set(self : BiophylodistancePath, i : Int, v : Double) -> BiophylodistancePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylodistancePath::sum(self : BiophylodistancePath) -> Double { @_common.sum(self.data) }

pub fn BiophylodistancePath::mean(self : BiophylodistancePath) -> Double { @_common.mean(self.data) }

pub fn BiophylodistancePath::scale(self : BiophylodistancePath, f : Double) -> BiophylodistancePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylodistancePath::add(self : BiophylodistancePath, other : BiophylodistancePath) -> BiophylodistancePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylodistancePath::copy(self : BiophylodistancePath) -> BiophylodistancePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylodistancePath::fill(self : BiophylodistancePath, v : Double) -> BiophylodistancePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylodistancePath::min(self : BiophylodistancePath) -> Double { @_common.min(self.data) }

pub fn BiophylodistancePath::max(self : BiophylodistancePath) -> Double { @_common.max(self.data) }

pub fn BiophylodistancePath::to_string(self : BiophylodistancePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylodistanceCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_distance_cluster_make(size : Int) -> BiophylodistanceCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylodistanceCluster::len(self : BiophylodistanceCluster) -> Int { self.size }

pub fn BiophylodistanceCluster::get(self : BiophylodistanceCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylodistanceCluster::set(self : BiophylodistanceCluster, i : Int, v : Double) -> BiophylodistanceCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylodistanceCluster::sum(self : BiophylodistanceCluster) -> Double { @_common.sum(self.data) }

pub fn BiophylodistanceCluster::mean(self : BiophylodistanceCluster) -> Double { @_common.mean(self.data) }

pub fn BiophylodistanceCluster::scale(self : BiophylodistanceCluster, f : Double) -> BiophylodistanceCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylodistanceCluster::add(self : BiophylodistanceCluster, other : BiophylodistanceCluster) -> BiophylodistanceCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylodistanceCluster::copy(self : BiophylodistanceCluster) -> BiophylodistanceCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylodistanceCluster::fill(self : BiophylodistanceCluster, v : Double) -> BiophylodistanceCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylodistanceCluster::min(self : BiophylodistanceCluster) -> Double { @_common.min(self.data) }

pub fn BiophylodistanceCluster::max(self : BiophylodistanceCluster) -> Double { @_common.max(self.data) }

pub fn BiophylodistanceCluster::to_string(self : BiophylodistanceCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylodistanceModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_distance_model_make(size : Int) -> BiophylodistanceModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylodistanceModel::len(self : BiophylodistanceModel) -> Int { self.size }

pub fn BiophylodistanceModel::get(self : BiophylodistanceModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylodistanceModel::set(self : BiophylodistanceModel, i : Int, v : Double) -> BiophylodistanceModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylodistanceModel::sum(self : BiophylodistanceModel) -> Double { @_common.sum(self.data) }

pub fn BiophylodistanceModel::mean(self : BiophylodistanceModel) -> Double { @_common.mean(self.data) }

pub fn BiophylodistanceModel::scale(self : BiophylodistanceModel, f : Double) -> BiophylodistanceModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylodistanceModel::add(self : BiophylodistanceModel, other : BiophylodistanceModel) -> BiophylodistanceModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylodistanceModel::copy(self : BiophylodistanceModel) -> BiophylodistanceModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylodistanceModel::fill(self : BiophylodistanceModel, v : Double) -> BiophylodistanceModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylodistanceModel::min(self : BiophylodistanceModel) -> Double { @_common.min(self.data) }

pub fn BiophylodistanceModel::max(self : BiophylodistanceModel) -> Double { @_common.max(self.data) }

pub fn BiophylodistanceModel::to_string(self : BiophylodistanceModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylodistanceLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_distance_layer_make(size : Int) -> BiophylodistanceLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylodistanceLayer::len(self : BiophylodistanceLayer) -> Int { self.size }

pub fn BiophylodistanceLayer::get(self : BiophylodistanceLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylodistanceLayer::set(self : BiophylodistanceLayer, i : Int, v : Double) -> BiophylodistanceLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylodistanceLayer::sum(self : BiophylodistanceLayer) -> Double { @_common.sum(self.data) }

pub fn BiophylodistanceLayer::mean(self : BiophylodistanceLayer) -> Double { @_common.mean(self.data) }

pub fn BiophylodistanceLayer::scale(self : BiophylodistanceLayer, f : Double) -> BiophylodistanceLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylodistanceLayer::add(self : BiophylodistanceLayer, other : BiophylodistanceLayer) -> BiophylodistanceLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylodistanceLayer::copy(self : BiophylodistanceLayer) -> BiophylodistanceLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylodistanceLayer::fill(self : BiophylodistanceLayer, v : Double) -> BiophylodistanceLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylodistanceLayer::min(self : BiophylodistanceLayer) -> Double { @_common.min(self.data) }

pub fn BiophylodistanceLayer::max(self : BiophylodistanceLayer) -> Double { @_common.max(self.data) }

pub fn BiophylodistanceLayer::to_string(self : BiophylodistanceLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylodistanceBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_distance_buffer_make(size : Int) -> BiophylodistanceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylodistanceBuffer::len(self : BiophylodistanceBuffer) -> Int { self.size }

pub fn BiophylodistanceBuffer::get(self : BiophylodistanceBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylodistanceBuffer::set(self : BiophylodistanceBuffer, i : Int, v : Double) -> BiophylodistanceBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylodistanceBuffer::sum(self : BiophylodistanceBuffer) -> Double { @_common.sum(self.data) }

pub fn BiophylodistanceBuffer::mean(self : BiophylodistanceBuffer) -> Double { @_common.mean(self.data) }

pub fn BiophylodistanceBuffer::scale(self : BiophylodistanceBuffer, f : Double) -> BiophylodistanceBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylodistanceBuffer::add(self : BiophylodistanceBuffer, other : BiophylodistanceBuffer) -> BiophylodistanceBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylodistanceBuffer::copy(self : BiophylodistanceBuffer) -> BiophylodistanceBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylodistanceBuffer::fill(self : BiophylodistanceBuffer, v : Double) -> BiophylodistanceBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylodistanceBuffer::min(self : BiophylodistanceBuffer) -> Double { @_common.min(self.data) }

pub fn BiophylodistanceBuffer::max(self : BiophylodistanceBuffer) -> Double { @_common.max(self.data) }

pub fn BiophylodistanceBuffer::to_string(self : BiophylodistanceBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylodistanceCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_distance_cursor_make(size : Int) -> BiophylodistanceCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylodistanceCursor::len(self : BiophylodistanceCursor) -> Int { self.size }

pub fn BiophylodistanceCursor::get(self : BiophylodistanceCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylodistanceCursor::set(self : BiophylodistanceCursor, i : Int, v : Double) -> BiophylodistanceCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylodistanceCursor::sum(self : BiophylodistanceCursor) -> Double { @_common.sum(self.data) }

pub fn BiophylodistanceCursor::mean(self : BiophylodistanceCursor) -> Double { @_common.mean(self.data) }

pub fn BiophylodistanceCursor::scale(self : BiophylodistanceCursor, f : Double) -> BiophylodistanceCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylodistanceCursor::add(self : BiophylodistanceCursor, other : BiophylodistanceCursor) -> BiophylodistanceCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylodistanceCursor::copy(self : BiophylodistanceCursor) -> BiophylodistanceCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylodistanceCursor::fill(self : BiophylodistanceCursor, v : Double) -> BiophylodistanceCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylodistanceCursor::min(self : BiophylodistanceCursor) -> Double { @_common.min(self.data) }

pub fn BiophylodistanceCursor::max(self : BiophylodistanceCursor) -> Double { @_common.max(self.data) }

pub fn BiophylodistanceCursor::to_string(self : BiophylodistanceCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylodistanceView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_distance_view_make(size : Int) -> BiophylodistanceView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylodistanceView::len(self : BiophylodistanceView) -> Int { self.size }

pub fn BiophylodistanceView::get(self : BiophylodistanceView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylodistanceView::set(self : BiophylodistanceView, i : Int, v : Double) -> BiophylodistanceView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylodistanceView::sum(self : BiophylodistanceView) -> Double { @_common.sum(self.data) }

pub fn BiophylodistanceView::mean(self : BiophylodistanceView) -> Double { @_common.mean(self.data) }

pub fn BiophylodistanceView::scale(self : BiophylodistanceView, f : Double) -> BiophylodistanceView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylodistanceView::add(self : BiophylodistanceView, other : BiophylodistanceView) -> BiophylodistanceView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylodistanceView::copy(self : BiophylodistanceView) -> BiophylodistanceView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylodistanceView::fill(self : BiophylodistanceView, v : Double) -> BiophylodistanceView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylodistanceView::min(self : BiophylodistanceView) -> Double { @_common.min(self.data) }

pub fn BiophylodistanceView::max(self : BiophylodistanceView) -> Double { @_common.max(self.data) }

pub fn BiophylodistanceView::to_string(self : BiophylodistanceView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylodistanceRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_distance_range_make(size : Int) -> BiophylodistanceRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylodistanceRange::len(self : BiophylodistanceRange) -> Int { self.size }

pub fn BiophylodistanceRange::get(self : BiophylodistanceRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylodistanceRange::set(self : BiophylodistanceRange, i : Int, v : Double) -> BiophylodistanceRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylodistanceRange::sum(self : BiophylodistanceRange) -> Double { @_common.sum(self.data) }

pub fn BiophylodistanceRange::mean(self : BiophylodistanceRange) -> Double { @_common.mean(self.data) }

pub fn BiophylodistanceRange::scale(self : BiophylodistanceRange, f : Double) -> BiophylodistanceRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylodistanceRange::add(self : BiophylodistanceRange, other : BiophylodistanceRange) -> BiophylodistanceRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylodistanceRange::copy(self : BiophylodistanceRange) -> BiophylodistanceRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylodistanceRange::fill(self : BiophylodistanceRange, v : Double) -> BiophylodistanceRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylodistanceRange::min(self : BiophylodistanceRange) -> Double { @_common.min(self.data) }

pub fn BiophylodistanceRange::max(self : BiophylodistanceRange) -> Double { @_common.max(self.data) }

pub fn BiophylodistanceRange::to_string(self : BiophylodistanceRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiophylodistanceSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_distance_slice_make(size : Int) -> BiophylodistanceSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiophylodistanceSlice::len(self : BiophylodistanceSlice) -> Int { self.size }

pub fn BiophylodistanceSlice::get(self : BiophylodistanceSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiophylodistanceSlice::set(self : BiophylodistanceSlice, i : Int, v : Double) -> BiophylodistanceSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiophylodistanceSlice::sum(self : BiophylodistanceSlice) -> Double { @_common.sum(self.data) }

pub fn BiophylodistanceSlice::mean(self : BiophylodistanceSlice) -> Double { @_common.mean(self.data) }

pub fn BiophylodistanceSlice::scale(self : BiophylodistanceSlice, f : Double) -> BiophylodistanceSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiophylodistanceSlice::add(self : BiophylodistanceSlice, other : BiophylodistanceSlice) -> BiophylodistanceSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiophylodistanceSlice::copy(self : BiophylodistanceSlice) -> BiophylodistanceSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiophylodistanceSlice::fill(self : BiophylodistanceSlice, v : Double) -> BiophylodistanceSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiophylodistanceSlice::min(self : BiophylodistanceSlice) -> Double { @_common.min(self.data) }

pub fn BiophylodistanceSlice::max(self : BiophylodistanceSlice) -> Double { @_common.max(self.data) }

pub fn BiophylodistanceSlice::to_string(self : BiophylodistanceSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

