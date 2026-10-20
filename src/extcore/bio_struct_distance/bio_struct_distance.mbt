///===
/// extcore/bio_struct_distance

pub(all) struct BiostructdistancePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_struct_distance_make_point(x : Double, y : Double) -> BiostructdistancePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_struct_distance_make_point3(x : Double, y : Double, z : Double) -> BiostructdistancePoint {
  { x, y, z, label: 0 }
}

pub fn BiostructdistancePoint::x(self : BiostructdistancePoint) -> Double { self.x }

pub fn BiostructdistancePoint::y(self : BiostructdistancePoint) -> Double { self.y }

pub fn BiostructdistancePoint::z(self : BiostructdistancePoint) -> Double { self.z }

pub fn BiostructdistancePoint::label(self : BiostructdistancePoint) -> Int { self.label }

pub fn BiostructdistancePoint::dist(self : BiostructdistancePoint, other : BiostructdistancePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BiostructdistancePoint::add(self : BiostructdistancePoint, other : BiostructdistancePoint) -> BiostructdistancePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BiostructdistancePoint::sub(self : BiostructdistancePoint, other : BiostructdistancePoint) -> BiostructdistancePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BiostructdistancePoint::scale(self : BiostructdistancePoint, s : Double) -> BiostructdistancePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BiostructdistancePoint::dot(self : BiostructdistancePoint, other : BiostructdistancePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BiostructdistancePoint::cross(self : BiostructdistancePoint, other : BiostructdistancePoint) -> BiostructdistancePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BiostructdistancePoint::norm(self : BiostructdistancePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BiostructdistancePoint::normalize(self : BiostructdistancePoint) -> BiostructdistancePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiostructdistancePoint::negate(self : BiostructdistancePoint) -> BiostructdistancePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BiostructdistancePoint::mid(self : BiostructdistancePoint, other : BiostructdistancePoint) -> BiostructdistancePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BiostructdistancePoint::lerp(self : BiostructdistancePoint, other : BiostructdistancePoint, t : Double) -> BiostructdistancePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BiostructdistancePoint::to_string(self : BiostructdistancePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BiostructdistanceSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_struct_distance_make_series(vals : Array[Double], name : String) -> BiostructdistanceSeries {
  { vals, name, meta: 0 }
}

pub fn BiostructdistanceSeries::len(self : BiostructdistanceSeries) -> Int { self.vals.length() }

pub fn BiostructdistanceSeries::sum(self : BiostructdistanceSeries) -> Double { @_common.sum(self.vals) }

pub fn BiostructdistanceSeries::mean(self : BiostructdistanceSeries) -> Double { @_common.mean(self.vals) }

pub fn BiostructdistanceSeries::min(self : BiostructdistanceSeries) -> Double { @_common.min(self.vals) }

pub fn BiostructdistanceSeries::max(self : BiostructdistanceSeries) -> Double { @_common.max(self.vals) }

pub fn BiostructdistanceSeries::range(self : BiostructdistanceSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BiostructdistanceSeries::variance(self : BiostructdistanceSeries) -> Double { @_common.variance(self.vals) }

pub fn BiostructdistanceSeries::std(self : BiostructdistanceSeries) -> Double { @_common.std(self.vals) }

pub fn BiostructdistanceSeries::median(self : BiostructdistanceSeries) -> Double { @_common.median(self.vals) }

pub fn BiostructdistanceSeries::scale(self : BiostructdistanceSeries, f : Double) -> BiostructdistanceSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BiostructdistanceSeries::add(self : BiostructdistanceSeries, other : BiostructdistanceSeries) -> BiostructdistanceSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BiostructdistanceSeries::sub(self : BiostructdistanceSeries, other : BiostructdistanceSeries) -> BiostructdistanceSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BiostructdistanceSeries::normalize(self : BiostructdistanceSeries) -> BiostructdistanceSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BiostructdistanceSeries::cumsum(self : BiostructdistanceSeries) -> BiostructdistanceSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BiostructdistanceSeries::to_string(self : BiostructdistanceSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiostructdistanceMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_struct_distance_make_matrix(rows : Int, cols : Int, val : Double) -> BiostructdistanceMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_struct_distance_matrix_identity(n : Int) -> BiostructdistanceMatrix {
  let m = bio_struct_distance_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BiostructdistanceMatrix::get(self : BiostructdistanceMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BiostructdistanceMatrix::transpose(self : BiostructdistanceMatrix) -> BiostructdistanceMatrix {
  let result = bio_struct_distance_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BiostructdistanceMatrix::add(self : BiostructdistanceMatrix, other : BiostructdistanceMatrix) -> BiostructdistanceMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_struct_distance_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BiostructdistanceMatrix::scale(self : BiostructdistanceMatrix, s : Double) -> BiostructdistanceMatrix {
  let result = bio_struct_distance_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BiostructdistanceMatrix::multiply(self : BiostructdistanceMatrix, other : BiostructdistanceMatrix) -> BiostructdistanceMatrix {
  if self.cols != other.rows { return bio_struct_distance_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_struct_distance_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn BiostructdistanceMatrix::trace(self : BiostructdistanceMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BiostructdistanceMatrix::det(self : BiostructdistanceMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BiostructdistanceMatrix::norm(self : BiostructdistanceMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BiostructdistanceMatrix::to_string(self : BiostructdistanceMatrix) -> String {
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

pub(all) struct BiostructdistanceVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_struct_distance_make_vector(comps : Array[Double]) -> BiostructdistanceVector {
  { comps, dim: comps.length() }
}

pub fn bio_struct_distance_vector_zero(dim : Int) -> BiostructdistanceVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BiostructdistanceVector::add(self : BiostructdistanceVector, other : BiostructdistanceVector) -> BiostructdistanceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BiostructdistanceVector::sub(self : BiostructdistanceVector, other : BiostructdistanceVector) -> BiostructdistanceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BiostructdistanceVector::scale(self : BiostructdistanceVector, s : Double) -> BiostructdistanceVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BiostructdistanceVector::dot(self : BiostructdistanceVector, other : BiostructdistanceVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BiostructdistanceVector::norm(self : BiostructdistanceVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BiostructdistanceVector::normalize(self : BiostructdistanceVector) -> BiostructdistanceVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiostructdistanceVector::dist(self : BiostructdistanceVector, other : BiostructdistanceVector) -> Double {
  self.sub(other).norm()
}

pub fn BiostructdistanceVector::to_string(self : BiostructdistanceVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiostructdistanceFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_distance_frame_make(size : Int) -> BiostructdistanceFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructdistanceFrame::len(self : BiostructdistanceFrame) -> Int { self.size }

pub fn BiostructdistanceFrame::get(self : BiostructdistanceFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructdistanceFrame::set(self : BiostructdistanceFrame, i : Int, v : Double) -> BiostructdistanceFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructdistanceFrame::sum(self : BiostructdistanceFrame) -> Double { @_common.sum(self.data) }

pub fn BiostructdistanceFrame::mean(self : BiostructdistanceFrame) -> Double { @_common.mean(self.data) }

pub fn BiostructdistanceFrame::scale(self : BiostructdistanceFrame, f : Double) -> BiostructdistanceFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructdistanceFrame::add(self : BiostructdistanceFrame, other : BiostructdistanceFrame) -> BiostructdistanceFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructdistanceFrame::copy(self : BiostructdistanceFrame) -> BiostructdistanceFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructdistanceFrame::fill(self : BiostructdistanceFrame, v : Double) -> BiostructdistanceFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructdistanceFrame::min(self : BiostructdistanceFrame) -> Double { @_common.min(self.data) }

pub fn BiostructdistanceFrame::max(self : BiostructdistanceFrame) -> Double { @_common.max(self.data) }

pub fn BiostructdistanceFrame::to_string(self : BiostructdistanceFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructdistanceTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_distance_table_make(size : Int) -> BiostructdistanceTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructdistanceTable::len(self : BiostructdistanceTable) -> Int { self.size }

pub fn BiostructdistanceTable::get(self : BiostructdistanceTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructdistanceTable::set(self : BiostructdistanceTable, i : Int, v : Double) -> BiostructdistanceTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructdistanceTable::sum(self : BiostructdistanceTable) -> Double { @_common.sum(self.data) }

pub fn BiostructdistanceTable::mean(self : BiostructdistanceTable) -> Double { @_common.mean(self.data) }

pub fn BiostructdistanceTable::scale(self : BiostructdistanceTable, f : Double) -> BiostructdistanceTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructdistanceTable::add(self : BiostructdistanceTable, other : BiostructdistanceTable) -> BiostructdistanceTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructdistanceTable::copy(self : BiostructdistanceTable) -> BiostructdistanceTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructdistanceTable::fill(self : BiostructdistanceTable, v : Double) -> BiostructdistanceTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructdistanceTable::min(self : BiostructdistanceTable) -> Double { @_common.min(self.data) }

pub fn BiostructdistanceTable::max(self : BiostructdistanceTable) -> Double { @_common.max(self.data) }

pub fn BiostructdistanceTable::to_string(self : BiostructdistanceTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructdistanceGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_distance_graphn_make(size : Int) -> BiostructdistanceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructdistanceGraphN::len(self : BiostructdistanceGraphN) -> Int { self.size }

pub fn BiostructdistanceGraphN::get(self : BiostructdistanceGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructdistanceGraphN::set(self : BiostructdistanceGraphN, i : Int, v : Double) -> BiostructdistanceGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructdistanceGraphN::sum(self : BiostructdistanceGraphN) -> Double { @_common.sum(self.data) }

pub fn BiostructdistanceGraphN::mean(self : BiostructdistanceGraphN) -> Double { @_common.mean(self.data) }

pub fn BiostructdistanceGraphN::scale(self : BiostructdistanceGraphN, f : Double) -> BiostructdistanceGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructdistanceGraphN::add(self : BiostructdistanceGraphN, other : BiostructdistanceGraphN) -> BiostructdistanceGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructdistanceGraphN::copy(self : BiostructdistanceGraphN) -> BiostructdistanceGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructdistanceGraphN::fill(self : BiostructdistanceGraphN, v : Double) -> BiostructdistanceGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructdistanceGraphN::min(self : BiostructdistanceGraphN) -> Double { @_common.min(self.data) }

pub fn BiostructdistanceGraphN::max(self : BiostructdistanceGraphN) -> Double { @_common.max(self.data) }

pub fn BiostructdistanceGraphN::to_string(self : BiostructdistanceGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructdistanceNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_distance_node_make(size : Int) -> BiostructdistanceNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructdistanceNode::len(self : BiostructdistanceNode) -> Int { self.size }

pub fn BiostructdistanceNode::get(self : BiostructdistanceNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructdistanceNode::set(self : BiostructdistanceNode, i : Int, v : Double) -> BiostructdistanceNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructdistanceNode::sum(self : BiostructdistanceNode) -> Double { @_common.sum(self.data) }

pub fn BiostructdistanceNode::mean(self : BiostructdistanceNode) -> Double { @_common.mean(self.data) }

pub fn BiostructdistanceNode::scale(self : BiostructdistanceNode, f : Double) -> BiostructdistanceNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructdistanceNode::add(self : BiostructdistanceNode, other : BiostructdistanceNode) -> BiostructdistanceNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructdistanceNode::copy(self : BiostructdistanceNode) -> BiostructdistanceNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructdistanceNode::fill(self : BiostructdistanceNode, v : Double) -> BiostructdistanceNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructdistanceNode::min(self : BiostructdistanceNode) -> Double { @_common.min(self.data) }

pub fn BiostructdistanceNode::max(self : BiostructdistanceNode) -> Double { @_common.max(self.data) }

pub fn BiostructdistanceNode::to_string(self : BiostructdistanceNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructdistanceEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_distance_edge_make(size : Int) -> BiostructdistanceEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructdistanceEdge::len(self : BiostructdistanceEdge) -> Int { self.size }

pub fn BiostructdistanceEdge::get(self : BiostructdistanceEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructdistanceEdge::set(self : BiostructdistanceEdge, i : Int, v : Double) -> BiostructdistanceEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructdistanceEdge::sum(self : BiostructdistanceEdge) -> Double { @_common.sum(self.data) }

pub fn BiostructdistanceEdge::mean(self : BiostructdistanceEdge) -> Double { @_common.mean(self.data) }

pub fn BiostructdistanceEdge::scale(self : BiostructdistanceEdge, f : Double) -> BiostructdistanceEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructdistanceEdge::add(self : BiostructdistanceEdge, other : BiostructdistanceEdge) -> BiostructdistanceEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructdistanceEdge::copy(self : BiostructdistanceEdge) -> BiostructdistanceEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructdistanceEdge::fill(self : BiostructdistanceEdge, v : Double) -> BiostructdistanceEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructdistanceEdge::min(self : BiostructdistanceEdge) -> Double { @_common.min(self.data) }

pub fn BiostructdistanceEdge::max(self : BiostructdistanceEdge) -> Double { @_common.max(self.data) }

pub fn BiostructdistanceEdge::to_string(self : BiostructdistanceEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructdistancePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_distance_path_make(size : Int) -> BiostructdistancePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructdistancePath::len(self : BiostructdistancePath) -> Int { self.size }

pub fn BiostructdistancePath::get(self : BiostructdistancePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructdistancePath::set(self : BiostructdistancePath, i : Int, v : Double) -> BiostructdistancePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructdistancePath::sum(self : BiostructdistancePath) -> Double { @_common.sum(self.data) }

pub fn BiostructdistancePath::mean(self : BiostructdistancePath) -> Double { @_common.mean(self.data) }

pub fn BiostructdistancePath::scale(self : BiostructdistancePath, f : Double) -> BiostructdistancePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructdistancePath::add(self : BiostructdistancePath, other : BiostructdistancePath) -> BiostructdistancePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructdistancePath::copy(self : BiostructdistancePath) -> BiostructdistancePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructdistancePath::fill(self : BiostructdistancePath, v : Double) -> BiostructdistancePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructdistancePath::min(self : BiostructdistancePath) -> Double { @_common.min(self.data) }

pub fn BiostructdistancePath::max(self : BiostructdistancePath) -> Double { @_common.max(self.data) }

pub fn BiostructdistancePath::to_string(self : BiostructdistancePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructdistanceCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_distance_cluster_make(size : Int) -> BiostructdistanceCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructdistanceCluster::len(self : BiostructdistanceCluster) -> Int { self.size }

pub fn BiostructdistanceCluster::get(self : BiostructdistanceCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructdistanceCluster::set(self : BiostructdistanceCluster, i : Int, v : Double) -> BiostructdistanceCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructdistanceCluster::sum(self : BiostructdistanceCluster) -> Double { @_common.sum(self.data) }

pub fn BiostructdistanceCluster::mean(self : BiostructdistanceCluster) -> Double { @_common.mean(self.data) }

pub fn BiostructdistanceCluster::scale(self : BiostructdistanceCluster, f : Double) -> BiostructdistanceCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructdistanceCluster::add(self : BiostructdistanceCluster, other : BiostructdistanceCluster) -> BiostructdistanceCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructdistanceCluster::copy(self : BiostructdistanceCluster) -> BiostructdistanceCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructdistanceCluster::fill(self : BiostructdistanceCluster, v : Double) -> BiostructdistanceCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructdistanceCluster::min(self : BiostructdistanceCluster) -> Double { @_common.min(self.data) }

pub fn BiostructdistanceCluster::max(self : BiostructdistanceCluster) -> Double { @_common.max(self.data) }

pub fn BiostructdistanceCluster::to_string(self : BiostructdistanceCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructdistanceModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_distance_model_make(size : Int) -> BiostructdistanceModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructdistanceModel::len(self : BiostructdistanceModel) -> Int { self.size }

pub fn BiostructdistanceModel::get(self : BiostructdistanceModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructdistanceModel::set(self : BiostructdistanceModel, i : Int, v : Double) -> BiostructdistanceModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructdistanceModel::sum(self : BiostructdistanceModel) -> Double { @_common.sum(self.data) }

pub fn BiostructdistanceModel::mean(self : BiostructdistanceModel) -> Double { @_common.mean(self.data) }

pub fn BiostructdistanceModel::scale(self : BiostructdistanceModel, f : Double) -> BiostructdistanceModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructdistanceModel::add(self : BiostructdistanceModel, other : BiostructdistanceModel) -> BiostructdistanceModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructdistanceModel::copy(self : BiostructdistanceModel) -> BiostructdistanceModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructdistanceModel::fill(self : BiostructdistanceModel, v : Double) -> BiostructdistanceModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructdistanceModel::min(self : BiostructdistanceModel) -> Double { @_common.min(self.data) }

pub fn BiostructdistanceModel::max(self : BiostructdistanceModel) -> Double { @_common.max(self.data) }

pub fn BiostructdistanceModel::to_string(self : BiostructdistanceModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructdistanceLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_distance_layer_make(size : Int) -> BiostructdistanceLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructdistanceLayer::len(self : BiostructdistanceLayer) -> Int { self.size }

pub fn BiostructdistanceLayer::get(self : BiostructdistanceLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructdistanceLayer::set(self : BiostructdistanceLayer, i : Int, v : Double) -> BiostructdistanceLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructdistanceLayer::sum(self : BiostructdistanceLayer) -> Double { @_common.sum(self.data) }

pub fn BiostructdistanceLayer::mean(self : BiostructdistanceLayer) -> Double { @_common.mean(self.data) }

pub fn BiostructdistanceLayer::scale(self : BiostructdistanceLayer, f : Double) -> BiostructdistanceLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructdistanceLayer::add(self : BiostructdistanceLayer, other : BiostructdistanceLayer) -> BiostructdistanceLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructdistanceLayer::copy(self : BiostructdistanceLayer) -> BiostructdistanceLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructdistanceLayer::fill(self : BiostructdistanceLayer, v : Double) -> BiostructdistanceLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructdistanceLayer::min(self : BiostructdistanceLayer) -> Double { @_common.min(self.data) }

pub fn BiostructdistanceLayer::max(self : BiostructdistanceLayer) -> Double { @_common.max(self.data) }

pub fn BiostructdistanceLayer::to_string(self : BiostructdistanceLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructdistanceBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_distance_buffer_make(size : Int) -> BiostructdistanceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructdistanceBuffer::len(self : BiostructdistanceBuffer) -> Int { self.size }

pub fn BiostructdistanceBuffer::get(self : BiostructdistanceBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructdistanceBuffer::set(self : BiostructdistanceBuffer, i : Int, v : Double) -> BiostructdistanceBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructdistanceBuffer::sum(self : BiostructdistanceBuffer) -> Double { @_common.sum(self.data) }

pub fn BiostructdistanceBuffer::mean(self : BiostructdistanceBuffer) -> Double { @_common.mean(self.data) }

pub fn BiostructdistanceBuffer::scale(self : BiostructdistanceBuffer, f : Double) -> BiostructdistanceBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructdistanceBuffer::add(self : BiostructdistanceBuffer, other : BiostructdistanceBuffer) -> BiostructdistanceBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructdistanceBuffer::copy(self : BiostructdistanceBuffer) -> BiostructdistanceBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructdistanceBuffer::fill(self : BiostructdistanceBuffer, v : Double) -> BiostructdistanceBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructdistanceBuffer::min(self : BiostructdistanceBuffer) -> Double { @_common.min(self.data) }

pub fn BiostructdistanceBuffer::max(self : BiostructdistanceBuffer) -> Double { @_common.max(self.data) }

pub fn BiostructdistanceBuffer::to_string(self : BiostructdistanceBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructdistanceCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_distance_cursor_make(size : Int) -> BiostructdistanceCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructdistanceCursor::len(self : BiostructdistanceCursor) -> Int { self.size }

pub fn BiostructdistanceCursor::get(self : BiostructdistanceCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructdistanceCursor::set(self : BiostructdistanceCursor, i : Int, v : Double) -> BiostructdistanceCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructdistanceCursor::sum(self : BiostructdistanceCursor) -> Double { @_common.sum(self.data) }

pub fn BiostructdistanceCursor::mean(self : BiostructdistanceCursor) -> Double { @_common.mean(self.data) }

pub fn BiostructdistanceCursor::scale(self : BiostructdistanceCursor, f : Double) -> BiostructdistanceCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructdistanceCursor::add(self : BiostructdistanceCursor, other : BiostructdistanceCursor) -> BiostructdistanceCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructdistanceCursor::copy(self : BiostructdistanceCursor) -> BiostructdistanceCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructdistanceCursor::fill(self : BiostructdistanceCursor, v : Double) -> BiostructdistanceCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructdistanceCursor::min(self : BiostructdistanceCursor) -> Double { @_common.min(self.data) }

pub fn BiostructdistanceCursor::max(self : BiostructdistanceCursor) -> Double { @_common.max(self.data) }

pub fn BiostructdistanceCursor::to_string(self : BiostructdistanceCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructdistanceView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_distance_view_make(size : Int) -> BiostructdistanceView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructdistanceView::len(self : BiostructdistanceView) -> Int { self.size }

pub fn BiostructdistanceView::get(self : BiostructdistanceView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructdistanceView::set(self : BiostructdistanceView, i : Int, v : Double) -> BiostructdistanceView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructdistanceView::sum(self : BiostructdistanceView) -> Double { @_common.sum(self.data) }

pub fn BiostructdistanceView::mean(self : BiostructdistanceView) -> Double { @_common.mean(self.data) }

pub fn BiostructdistanceView::scale(self : BiostructdistanceView, f : Double) -> BiostructdistanceView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructdistanceView::add(self : BiostructdistanceView, other : BiostructdistanceView) -> BiostructdistanceView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructdistanceView::copy(self : BiostructdistanceView) -> BiostructdistanceView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructdistanceView::fill(self : BiostructdistanceView, v : Double) -> BiostructdistanceView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructdistanceView::min(self : BiostructdistanceView) -> Double { @_common.min(self.data) }

pub fn BiostructdistanceView::max(self : BiostructdistanceView) -> Double { @_common.max(self.data) }

pub fn BiostructdistanceView::to_string(self : BiostructdistanceView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructdistanceRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_distance_range_make(size : Int) -> BiostructdistanceRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructdistanceRange::len(self : BiostructdistanceRange) -> Int { self.size }

pub fn BiostructdistanceRange::get(self : BiostructdistanceRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructdistanceRange::set(self : BiostructdistanceRange, i : Int, v : Double) -> BiostructdistanceRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructdistanceRange::sum(self : BiostructdistanceRange) -> Double { @_common.sum(self.data) }

pub fn BiostructdistanceRange::mean(self : BiostructdistanceRange) -> Double { @_common.mean(self.data) }

pub fn BiostructdistanceRange::scale(self : BiostructdistanceRange, f : Double) -> BiostructdistanceRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructdistanceRange::add(self : BiostructdistanceRange, other : BiostructdistanceRange) -> BiostructdistanceRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructdistanceRange::copy(self : BiostructdistanceRange) -> BiostructdistanceRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructdistanceRange::fill(self : BiostructdistanceRange, v : Double) -> BiostructdistanceRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructdistanceRange::min(self : BiostructdistanceRange) -> Double { @_common.min(self.data) }

pub fn BiostructdistanceRange::max(self : BiostructdistanceRange) -> Double { @_common.max(self.data) }

pub fn BiostructdistanceRange::to_string(self : BiostructdistanceRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructdistanceSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_distance_slice_make(size : Int) -> BiostructdistanceSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructdistanceSlice::len(self : BiostructdistanceSlice) -> Int { self.size }

pub fn BiostructdistanceSlice::get(self : BiostructdistanceSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructdistanceSlice::set(self : BiostructdistanceSlice, i : Int, v : Double) -> BiostructdistanceSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructdistanceSlice::sum(self : BiostructdistanceSlice) -> Double { @_common.sum(self.data) }

pub fn BiostructdistanceSlice::mean(self : BiostructdistanceSlice) -> Double { @_common.mean(self.data) }

pub fn BiostructdistanceSlice::scale(self : BiostructdistanceSlice, f : Double) -> BiostructdistanceSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructdistanceSlice::add(self : BiostructdistanceSlice, other : BiostructdistanceSlice) -> BiostructdistanceSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructdistanceSlice::copy(self : BiostructdistanceSlice) -> BiostructdistanceSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructdistanceSlice::fill(self : BiostructdistanceSlice, v : Double) -> BiostructdistanceSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructdistanceSlice::min(self : BiostructdistanceSlice) -> Double { @_common.min(self.data) }

pub fn BiostructdistanceSlice::max(self : BiostructdistanceSlice) -> Double { @_common.max(self.data) }

pub fn BiostructdistanceSlice::to_string(self : BiostructdistanceSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

