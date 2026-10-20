///===
/// extcore/chem_desc_topological

pub(all) struct ChemdesctopologicalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_desc_topological_make_point(x : Double, y : Double) -> ChemdesctopologicalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_desc_topological_make_point3(x : Double, y : Double, z : Double) -> ChemdesctopologicalPoint {
  { x, y, z, label: 0 }
}

pub fn ChemdesctopologicalPoint::x(self : ChemdesctopologicalPoint) -> Double { self.x }

pub fn ChemdesctopologicalPoint::y(self : ChemdesctopologicalPoint) -> Double { self.y }

pub fn ChemdesctopologicalPoint::z(self : ChemdesctopologicalPoint) -> Double { self.z }

pub fn ChemdesctopologicalPoint::label(self : ChemdesctopologicalPoint) -> Int { self.label }

pub fn ChemdesctopologicalPoint::dist(self : ChemdesctopologicalPoint, other : ChemdesctopologicalPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemdesctopologicalPoint::add(self : ChemdesctopologicalPoint, other : ChemdesctopologicalPoint) -> ChemdesctopologicalPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemdesctopologicalPoint::sub(self : ChemdesctopologicalPoint, other : ChemdesctopologicalPoint) -> ChemdesctopologicalPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemdesctopologicalPoint::scale(self : ChemdesctopologicalPoint, s : Double) -> ChemdesctopologicalPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemdesctopologicalPoint::dot(self : ChemdesctopologicalPoint, other : ChemdesctopologicalPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemdesctopologicalPoint::cross(self : ChemdesctopologicalPoint, other : ChemdesctopologicalPoint) -> ChemdesctopologicalPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemdesctopologicalPoint::norm(self : ChemdesctopologicalPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemdesctopologicalPoint::normalize(self : ChemdesctopologicalPoint) -> ChemdesctopologicalPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemdesctopologicalPoint::negate(self : ChemdesctopologicalPoint) -> ChemdesctopologicalPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemdesctopologicalPoint::mid(self : ChemdesctopologicalPoint, other : ChemdesctopologicalPoint) -> ChemdesctopologicalPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemdesctopologicalPoint::lerp(self : ChemdesctopologicalPoint, other : ChemdesctopologicalPoint, t : Double) -> ChemdesctopologicalPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemdesctopologicalPoint::to_string(self : ChemdesctopologicalPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemdesctopologicalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_desc_topological_make_series(vals : Array[Double], name : String) -> ChemdesctopologicalSeries {
  { vals, name, meta: 0 }
}

pub fn ChemdesctopologicalSeries::len(self : ChemdesctopologicalSeries) -> Int { self.vals.length() }

pub fn ChemdesctopologicalSeries::sum(self : ChemdesctopologicalSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemdesctopologicalSeries::mean(self : ChemdesctopologicalSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemdesctopologicalSeries::min(self : ChemdesctopologicalSeries) -> Double { @_common.min(self.vals) }

pub fn ChemdesctopologicalSeries::max(self : ChemdesctopologicalSeries) -> Double { @_common.max(self.vals) }

pub fn ChemdesctopologicalSeries::range(self : ChemdesctopologicalSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemdesctopologicalSeries::variance(self : ChemdesctopologicalSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemdesctopologicalSeries::std(self : ChemdesctopologicalSeries) -> Double { @_common.std(self.vals) }

pub fn ChemdesctopologicalSeries::median(self : ChemdesctopologicalSeries) -> Double { @_common.median(self.vals) }

pub fn ChemdesctopologicalSeries::scale(self : ChemdesctopologicalSeries, f : Double) -> ChemdesctopologicalSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemdesctopologicalSeries::add(self : ChemdesctopologicalSeries, other : ChemdesctopologicalSeries) -> ChemdesctopologicalSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemdesctopologicalSeries::sub(self : ChemdesctopologicalSeries, other : ChemdesctopologicalSeries) -> ChemdesctopologicalSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemdesctopologicalSeries::normalize(self : ChemdesctopologicalSeries) -> ChemdesctopologicalSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemdesctopologicalSeries::cumsum(self : ChemdesctopologicalSeries) -> ChemdesctopologicalSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemdesctopologicalSeries::to_string(self : ChemdesctopologicalSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemdesctopologicalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_desc_topological_make_matrix(rows : Int, cols : Int, val : Double) -> ChemdesctopologicalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_desc_topological_matrix_identity(n : Int) -> ChemdesctopologicalMatrix {
  let m = chem_desc_topological_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemdesctopologicalMatrix::get(self : ChemdesctopologicalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemdesctopologicalMatrix::transpose(self : ChemdesctopologicalMatrix) -> ChemdesctopologicalMatrix {
  let result = chem_desc_topological_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemdesctopologicalMatrix::add(self : ChemdesctopologicalMatrix, other : ChemdesctopologicalMatrix) -> ChemdesctopologicalMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_desc_topological_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemdesctopologicalMatrix::scale(self : ChemdesctopologicalMatrix, s : Double) -> ChemdesctopologicalMatrix {
  let result = chem_desc_topological_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemdesctopologicalMatrix::multiply(self : ChemdesctopologicalMatrix, other : ChemdesctopologicalMatrix) -> ChemdesctopologicalMatrix {
  if self.cols != other.rows { return chem_desc_topological_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_desc_topological_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn ChemdesctopologicalMatrix::trace(self : ChemdesctopologicalMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemdesctopologicalMatrix::det(self : ChemdesctopologicalMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemdesctopologicalMatrix::norm(self : ChemdesctopologicalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemdesctopologicalMatrix::to_string(self : ChemdesctopologicalMatrix) -> String {
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

pub(all) struct ChemdesctopologicalVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_desc_topological_make_vector(comps : Array[Double]) -> ChemdesctopologicalVector {
  { comps, dim: comps.length() }
}

pub fn chem_desc_topological_vector_zero(dim : Int) -> ChemdesctopologicalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemdesctopologicalVector::add(self : ChemdesctopologicalVector, other : ChemdesctopologicalVector) -> ChemdesctopologicalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemdesctopologicalVector::sub(self : ChemdesctopologicalVector, other : ChemdesctopologicalVector) -> ChemdesctopologicalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemdesctopologicalVector::scale(self : ChemdesctopologicalVector, s : Double) -> ChemdesctopologicalVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemdesctopologicalVector::dot(self : ChemdesctopologicalVector, other : ChemdesctopologicalVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemdesctopologicalVector::norm(self : ChemdesctopologicalVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemdesctopologicalVector::normalize(self : ChemdesctopologicalVector) -> ChemdesctopologicalVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemdesctopologicalVector::dist(self : ChemdesctopologicalVector, other : ChemdesctopologicalVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemdesctopologicalVector::to_string(self : ChemdesctopologicalVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemdesctopologicalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_topological_frame_make(size : Int) -> ChemdesctopologicalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdesctopologicalFrame::len(self : ChemdesctopologicalFrame) -> Int { self.size }

pub fn ChemdesctopologicalFrame::get(self : ChemdesctopologicalFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdesctopologicalFrame::set(self : ChemdesctopologicalFrame, i : Int, v : Double) -> ChemdesctopologicalFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalFrame::sum(self : ChemdesctopologicalFrame) -> Double { @_common.sum(self.data) }

pub fn ChemdesctopologicalFrame::mean(self : ChemdesctopologicalFrame) -> Double { @_common.mean(self.data) }

pub fn ChemdesctopologicalFrame::scale(self : ChemdesctopologicalFrame, f : Double) -> ChemdesctopologicalFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalFrame::add(self : ChemdesctopologicalFrame, other : ChemdesctopologicalFrame) -> ChemdesctopologicalFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdesctopologicalFrame::copy(self : ChemdesctopologicalFrame) -> ChemdesctopologicalFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalFrame::fill(self : ChemdesctopologicalFrame, v : Double) -> ChemdesctopologicalFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalFrame::min(self : ChemdesctopologicalFrame) -> Double { @_common.min(self.data) }

pub fn ChemdesctopologicalFrame::max(self : ChemdesctopologicalFrame) -> Double { @_common.max(self.data) }

pub fn ChemdesctopologicalFrame::to_string(self : ChemdesctopologicalFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdesctopologicalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_topological_table_make(size : Int) -> ChemdesctopologicalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdesctopologicalTable::len(self : ChemdesctopologicalTable) -> Int { self.size }

pub fn ChemdesctopologicalTable::get(self : ChemdesctopologicalTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdesctopologicalTable::set(self : ChemdesctopologicalTable, i : Int, v : Double) -> ChemdesctopologicalTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalTable::sum(self : ChemdesctopologicalTable) -> Double { @_common.sum(self.data) }

pub fn ChemdesctopologicalTable::mean(self : ChemdesctopologicalTable) -> Double { @_common.mean(self.data) }

pub fn ChemdesctopologicalTable::scale(self : ChemdesctopologicalTable, f : Double) -> ChemdesctopologicalTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalTable::add(self : ChemdesctopologicalTable, other : ChemdesctopologicalTable) -> ChemdesctopologicalTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdesctopologicalTable::copy(self : ChemdesctopologicalTable) -> ChemdesctopologicalTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalTable::fill(self : ChemdesctopologicalTable, v : Double) -> ChemdesctopologicalTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalTable::min(self : ChemdesctopologicalTable) -> Double { @_common.min(self.data) }

pub fn ChemdesctopologicalTable::max(self : ChemdesctopologicalTable) -> Double { @_common.max(self.data) }

pub fn ChemdesctopologicalTable::to_string(self : ChemdesctopologicalTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdesctopologicalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_topological_graphn_make(size : Int) -> ChemdesctopologicalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdesctopologicalGraphN::len(self : ChemdesctopologicalGraphN) -> Int { self.size }

pub fn ChemdesctopologicalGraphN::get(self : ChemdesctopologicalGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdesctopologicalGraphN::set(self : ChemdesctopologicalGraphN, i : Int, v : Double) -> ChemdesctopologicalGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalGraphN::sum(self : ChemdesctopologicalGraphN) -> Double { @_common.sum(self.data) }

pub fn ChemdesctopologicalGraphN::mean(self : ChemdesctopologicalGraphN) -> Double { @_common.mean(self.data) }

pub fn ChemdesctopologicalGraphN::scale(self : ChemdesctopologicalGraphN, f : Double) -> ChemdesctopologicalGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalGraphN::add(self : ChemdesctopologicalGraphN, other : ChemdesctopologicalGraphN) -> ChemdesctopologicalGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdesctopologicalGraphN::copy(self : ChemdesctopologicalGraphN) -> ChemdesctopologicalGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalGraphN::fill(self : ChemdesctopologicalGraphN, v : Double) -> ChemdesctopologicalGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalGraphN::min(self : ChemdesctopologicalGraphN) -> Double { @_common.min(self.data) }

pub fn ChemdesctopologicalGraphN::max(self : ChemdesctopologicalGraphN) -> Double { @_common.max(self.data) }

pub fn ChemdesctopologicalGraphN::to_string(self : ChemdesctopologicalGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdesctopologicalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_topological_node_make(size : Int) -> ChemdesctopologicalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdesctopologicalNode::len(self : ChemdesctopologicalNode) -> Int { self.size }

pub fn ChemdesctopologicalNode::get(self : ChemdesctopologicalNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdesctopologicalNode::set(self : ChemdesctopologicalNode, i : Int, v : Double) -> ChemdesctopologicalNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalNode::sum(self : ChemdesctopologicalNode) -> Double { @_common.sum(self.data) }

pub fn ChemdesctopologicalNode::mean(self : ChemdesctopologicalNode) -> Double { @_common.mean(self.data) }

pub fn ChemdesctopologicalNode::scale(self : ChemdesctopologicalNode, f : Double) -> ChemdesctopologicalNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalNode::add(self : ChemdesctopologicalNode, other : ChemdesctopologicalNode) -> ChemdesctopologicalNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdesctopologicalNode::copy(self : ChemdesctopologicalNode) -> ChemdesctopologicalNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalNode::fill(self : ChemdesctopologicalNode, v : Double) -> ChemdesctopologicalNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalNode::min(self : ChemdesctopologicalNode) -> Double { @_common.min(self.data) }

pub fn ChemdesctopologicalNode::max(self : ChemdesctopologicalNode) -> Double { @_common.max(self.data) }

pub fn ChemdesctopologicalNode::to_string(self : ChemdesctopologicalNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdesctopologicalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_topological_edge_make(size : Int) -> ChemdesctopologicalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdesctopologicalEdge::len(self : ChemdesctopologicalEdge) -> Int { self.size }

pub fn ChemdesctopologicalEdge::get(self : ChemdesctopologicalEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdesctopologicalEdge::set(self : ChemdesctopologicalEdge, i : Int, v : Double) -> ChemdesctopologicalEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalEdge::sum(self : ChemdesctopologicalEdge) -> Double { @_common.sum(self.data) }

pub fn ChemdesctopologicalEdge::mean(self : ChemdesctopologicalEdge) -> Double { @_common.mean(self.data) }

pub fn ChemdesctopologicalEdge::scale(self : ChemdesctopologicalEdge, f : Double) -> ChemdesctopologicalEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalEdge::add(self : ChemdesctopologicalEdge, other : ChemdesctopologicalEdge) -> ChemdesctopologicalEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdesctopologicalEdge::copy(self : ChemdesctopologicalEdge) -> ChemdesctopologicalEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalEdge::fill(self : ChemdesctopologicalEdge, v : Double) -> ChemdesctopologicalEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalEdge::min(self : ChemdesctopologicalEdge) -> Double { @_common.min(self.data) }

pub fn ChemdesctopologicalEdge::max(self : ChemdesctopologicalEdge) -> Double { @_common.max(self.data) }

pub fn ChemdesctopologicalEdge::to_string(self : ChemdesctopologicalEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdesctopologicalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_topological_path_make(size : Int) -> ChemdesctopologicalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdesctopologicalPath::len(self : ChemdesctopologicalPath) -> Int { self.size }

pub fn ChemdesctopologicalPath::get(self : ChemdesctopologicalPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdesctopologicalPath::set(self : ChemdesctopologicalPath, i : Int, v : Double) -> ChemdesctopologicalPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalPath::sum(self : ChemdesctopologicalPath) -> Double { @_common.sum(self.data) }

pub fn ChemdesctopologicalPath::mean(self : ChemdesctopologicalPath) -> Double { @_common.mean(self.data) }

pub fn ChemdesctopologicalPath::scale(self : ChemdesctopologicalPath, f : Double) -> ChemdesctopologicalPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalPath::add(self : ChemdesctopologicalPath, other : ChemdesctopologicalPath) -> ChemdesctopologicalPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdesctopologicalPath::copy(self : ChemdesctopologicalPath) -> ChemdesctopologicalPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalPath::fill(self : ChemdesctopologicalPath, v : Double) -> ChemdesctopologicalPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalPath::min(self : ChemdesctopologicalPath) -> Double { @_common.min(self.data) }

pub fn ChemdesctopologicalPath::max(self : ChemdesctopologicalPath) -> Double { @_common.max(self.data) }

pub fn ChemdesctopologicalPath::to_string(self : ChemdesctopologicalPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdesctopologicalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_topological_cluster_make(size : Int) -> ChemdesctopologicalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdesctopologicalCluster::len(self : ChemdesctopologicalCluster) -> Int { self.size }

pub fn ChemdesctopologicalCluster::get(self : ChemdesctopologicalCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdesctopologicalCluster::set(self : ChemdesctopologicalCluster, i : Int, v : Double) -> ChemdesctopologicalCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalCluster::sum(self : ChemdesctopologicalCluster) -> Double { @_common.sum(self.data) }

pub fn ChemdesctopologicalCluster::mean(self : ChemdesctopologicalCluster) -> Double { @_common.mean(self.data) }

pub fn ChemdesctopologicalCluster::scale(self : ChemdesctopologicalCluster, f : Double) -> ChemdesctopologicalCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalCluster::add(self : ChemdesctopologicalCluster, other : ChemdesctopologicalCluster) -> ChemdesctopologicalCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdesctopologicalCluster::copy(self : ChemdesctopologicalCluster) -> ChemdesctopologicalCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalCluster::fill(self : ChemdesctopologicalCluster, v : Double) -> ChemdesctopologicalCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalCluster::min(self : ChemdesctopologicalCluster) -> Double { @_common.min(self.data) }

pub fn ChemdesctopologicalCluster::max(self : ChemdesctopologicalCluster) -> Double { @_common.max(self.data) }

pub fn ChemdesctopologicalCluster::to_string(self : ChemdesctopologicalCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdesctopologicalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_topological_model_make(size : Int) -> ChemdesctopologicalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdesctopologicalModel::len(self : ChemdesctopologicalModel) -> Int { self.size }

pub fn ChemdesctopologicalModel::get(self : ChemdesctopologicalModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdesctopologicalModel::set(self : ChemdesctopologicalModel, i : Int, v : Double) -> ChemdesctopologicalModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalModel::sum(self : ChemdesctopologicalModel) -> Double { @_common.sum(self.data) }

pub fn ChemdesctopologicalModel::mean(self : ChemdesctopologicalModel) -> Double { @_common.mean(self.data) }

pub fn ChemdesctopologicalModel::scale(self : ChemdesctopologicalModel, f : Double) -> ChemdesctopologicalModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalModel::add(self : ChemdesctopologicalModel, other : ChemdesctopologicalModel) -> ChemdesctopologicalModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdesctopologicalModel::copy(self : ChemdesctopologicalModel) -> ChemdesctopologicalModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalModel::fill(self : ChemdesctopologicalModel, v : Double) -> ChemdesctopologicalModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalModel::min(self : ChemdesctopologicalModel) -> Double { @_common.min(self.data) }

pub fn ChemdesctopologicalModel::max(self : ChemdesctopologicalModel) -> Double { @_common.max(self.data) }

pub fn ChemdesctopologicalModel::to_string(self : ChemdesctopologicalModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdesctopologicalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_topological_layer_make(size : Int) -> ChemdesctopologicalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdesctopologicalLayer::len(self : ChemdesctopologicalLayer) -> Int { self.size }

pub fn ChemdesctopologicalLayer::get(self : ChemdesctopologicalLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdesctopologicalLayer::set(self : ChemdesctopologicalLayer, i : Int, v : Double) -> ChemdesctopologicalLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalLayer::sum(self : ChemdesctopologicalLayer) -> Double { @_common.sum(self.data) }

pub fn ChemdesctopologicalLayer::mean(self : ChemdesctopologicalLayer) -> Double { @_common.mean(self.data) }

pub fn ChemdesctopologicalLayer::scale(self : ChemdesctopologicalLayer, f : Double) -> ChemdesctopologicalLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalLayer::add(self : ChemdesctopologicalLayer, other : ChemdesctopologicalLayer) -> ChemdesctopologicalLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdesctopologicalLayer::copy(self : ChemdesctopologicalLayer) -> ChemdesctopologicalLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalLayer::fill(self : ChemdesctopologicalLayer, v : Double) -> ChemdesctopologicalLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalLayer::min(self : ChemdesctopologicalLayer) -> Double { @_common.min(self.data) }

pub fn ChemdesctopologicalLayer::max(self : ChemdesctopologicalLayer) -> Double { @_common.max(self.data) }

pub fn ChemdesctopologicalLayer::to_string(self : ChemdesctopologicalLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdesctopologicalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_topological_buffer_make(size : Int) -> ChemdesctopologicalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdesctopologicalBuffer::len(self : ChemdesctopologicalBuffer) -> Int { self.size }

pub fn ChemdesctopologicalBuffer::get(self : ChemdesctopologicalBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdesctopologicalBuffer::set(self : ChemdesctopologicalBuffer, i : Int, v : Double) -> ChemdesctopologicalBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalBuffer::sum(self : ChemdesctopologicalBuffer) -> Double { @_common.sum(self.data) }

pub fn ChemdesctopologicalBuffer::mean(self : ChemdesctopologicalBuffer) -> Double { @_common.mean(self.data) }

pub fn ChemdesctopologicalBuffer::scale(self : ChemdesctopologicalBuffer, f : Double) -> ChemdesctopologicalBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalBuffer::add(self : ChemdesctopologicalBuffer, other : ChemdesctopologicalBuffer) -> ChemdesctopologicalBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdesctopologicalBuffer::copy(self : ChemdesctopologicalBuffer) -> ChemdesctopologicalBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalBuffer::fill(self : ChemdesctopologicalBuffer, v : Double) -> ChemdesctopologicalBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalBuffer::min(self : ChemdesctopologicalBuffer) -> Double { @_common.min(self.data) }

pub fn ChemdesctopologicalBuffer::max(self : ChemdesctopologicalBuffer) -> Double { @_common.max(self.data) }

pub fn ChemdesctopologicalBuffer::to_string(self : ChemdesctopologicalBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdesctopologicalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_topological_cursor_make(size : Int) -> ChemdesctopologicalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdesctopologicalCursor::len(self : ChemdesctopologicalCursor) -> Int { self.size }

pub fn ChemdesctopologicalCursor::get(self : ChemdesctopologicalCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdesctopologicalCursor::set(self : ChemdesctopologicalCursor, i : Int, v : Double) -> ChemdesctopologicalCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalCursor::sum(self : ChemdesctopologicalCursor) -> Double { @_common.sum(self.data) }

pub fn ChemdesctopologicalCursor::mean(self : ChemdesctopologicalCursor) -> Double { @_common.mean(self.data) }

pub fn ChemdesctopologicalCursor::scale(self : ChemdesctopologicalCursor, f : Double) -> ChemdesctopologicalCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalCursor::add(self : ChemdesctopologicalCursor, other : ChemdesctopologicalCursor) -> ChemdesctopologicalCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdesctopologicalCursor::copy(self : ChemdesctopologicalCursor) -> ChemdesctopologicalCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalCursor::fill(self : ChemdesctopologicalCursor, v : Double) -> ChemdesctopologicalCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalCursor::min(self : ChemdesctopologicalCursor) -> Double { @_common.min(self.data) }

pub fn ChemdesctopologicalCursor::max(self : ChemdesctopologicalCursor) -> Double { @_common.max(self.data) }

pub fn ChemdesctopologicalCursor::to_string(self : ChemdesctopologicalCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdesctopologicalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_topological_view_make(size : Int) -> ChemdesctopologicalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdesctopologicalView::len(self : ChemdesctopologicalView) -> Int { self.size }

pub fn ChemdesctopologicalView::get(self : ChemdesctopologicalView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdesctopologicalView::set(self : ChemdesctopologicalView, i : Int, v : Double) -> ChemdesctopologicalView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalView::sum(self : ChemdesctopologicalView) -> Double { @_common.sum(self.data) }

pub fn ChemdesctopologicalView::mean(self : ChemdesctopologicalView) -> Double { @_common.mean(self.data) }

pub fn ChemdesctopologicalView::scale(self : ChemdesctopologicalView, f : Double) -> ChemdesctopologicalView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalView::add(self : ChemdesctopologicalView, other : ChemdesctopologicalView) -> ChemdesctopologicalView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdesctopologicalView::copy(self : ChemdesctopologicalView) -> ChemdesctopologicalView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalView::fill(self : ChemdesctopologicalView, v : Double) -> ChemdesctopologicalView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalView::min(self : ChemdesctopologicalView) -> Double { @_common.min(self.data) }

pub fn ChemdesctopologicalView::max(self : ChemdesctopologicalView) -> Double { @_common.max(self.data) }

pub fn ChemdesctopologicalView::to_string(self : ChemdesctopologicalView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdesctopologicalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_topological_range_make(size : Int) -> ChemdesctopologicalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdesctopologicalRange::len(self : ChemdesctopologicalRange) -> Int { self.size }

pub fn ChemdesctopologicalRange::get(self : ChemdesctopologicalRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdesctopologicalRange::set(self : ChemdesctopologicalRange, i : Int, v : Double) -> ChemdesctopologicalRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalRange::sum(self : ChemdesctopologicalRange) -> Double { @_common.sum(self.data) }

pub fn ChemdesctopologicalRange::mean(self : ChemdesctopologicalRange) -> Double { @_common.mean(self.data) }

pub fn ChemdesctopologicalRange::scale(self : ChemdesctopologicalRange, f : Double) -> ChemdesctopologicalRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalRange::add(self : ChemdesctopologicalRange, other : ChemdesctopologicalRange) -> ChemdesctopologicalRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdesctopologicalRange::copy(self : ChemdesctopologicalRange) -> ChemdesctopologicalRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalRange::fill(self : ChemdesctopologicalRange, v : Double) -> ChemdesctopologicalRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalRange::min(self : ChemdesctopologicalRange) -> Double { @_common.min(self.data) }

pub fn ChemdesctopologicalRange::max(self : ChemdesctopologicalRange) -> Double { @_common.max(self.data) }

pub fn ChemdesctopologicalRange::to_string(self : ChemdesctopologicalRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdesctopologicalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_topological_slice_make(size : Int) -> ChemdesctopologicalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdesctopologicalSlice::len(self : ChemdesctopologicalSlice) -> Int { self.size }

pub fn ChemdesctopologicalSlice::get(self : ChemdesctopologicalSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdesctopologicalSlice::set(self : ChemdesctopologicalSlice, i : Int, v : Double) -> ChemdesctopologicalSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalSlice::sum(self : ChemdesctopologicalSlice) -> Double { @_common.sum(self.data) }

pub fn ChemdesctopologicalSlice::mean(self : ChemdesctopologicalSlice) -> Double { @_common.mean(self.data) }

pub fn ChemdesctopologicalSlice::scale(self : ChemdesctopologicalSlice, f : Double) -> ChemdesctopologicalSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalSlice::add(self : ChemdesctopologicalSlice, other : ChemdesctopologicalSlice) -> ChemdesctopologicalSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdesctopologicalSlice::copy(self : ChemdesctopologicalSlice) -> ChemdesctopologicalSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalSlice::fill(self : ChemdesctopologicalSlice, v : Double) -> ChemdesctopologicalSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdesctopologicalSlice::min(self : ChemdesctopologicalSlice) -> Double { @_common.min(self.data) }

pub fn ChemdesctopologicalSlice::max(self : ChemdesctopologicalSlice) -> Double { @_common.max(self.data) }

pub fn ChemdesctopologicalSlice::to_string(self : ChemdesctopologicalSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

