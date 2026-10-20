///===
/// extcore/chem_desc_rdkit

pub(all) struct ChemdescrdkitPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_desc_rdkit_make_point(x : Double, y : Double) -> ChemdescrdkitPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_desc_rdkit_make_point3(x : Double, y : Double, z : Double) -> ChemdescrdkitPoint {
  { x, y, z, label: 0 }
}

pub fn ChemdescrdkitPoint::x(self : ChemdescrdkitPoint) -> Double { self.x }

pub fn ChemdescrdkitPoint::y(self : ChemdescrdkitPoint) -> Double { self.y }

pub fn ChemdescrdkitPoint::z(self : ChemdescrdkitPoint) -> Double { self.z }

pub fn ChemdescrdkitPoint::label(self : ChemdescrdkitPoint) -> Int { self.label }

pub fn ChemdescrdkitPoint::dist(self : ChemdescrdkitPoint, other : ChemdescrdkitPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemdescrdkitPoint::add(self : ChemdescrdkitPoint, other : ChemdescrdkitPoint) -> ChemdescrdkitPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemdescrdkitPoint::sub(self : ChemdescrdkitPoint, other : ChemdescrdkitPoint) -> ChemdescrdkitPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemdescrdkitPoint::scale(self : ChemdescrdkitPoint, s : Double) -> ChemdescrdkitPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemdescrdkitPoint::dot(self : ChemdescrdkitPoint, other : ChemdescrdkitPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemdescrdkitPoint::cross(self : ChemdescrdkitPoint, other : ChemdescrdkitPoint) -> ChemdescrdkitPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemdescrdkitPoint::norm(self : ChemdescrdkitPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemdescrdkitPoint::normalize(self : ChemdescrdkitPoint) -> ChemdescrdkitPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemdescrdkitPoint::negate(self : ChemdescrdkitPoint) -> ChemdescrdkitPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemdescrdkitPoint::mid(self : ChemdescrdkitPoint, other : ChemdescrdkitPoint) -> ChemdescrdkitPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemdescrdkitPoint::lerp(self : ChemdescrdkitPoint, other : ChemdescrdkitPoint, t : Double) -> ChemdescrdkitPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemdescrdkitPoint::to_string(self : ChemdescrdkitPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemdescrdkitSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_desc_rdkit_make_series(vals : Array[Double], name : String) -> ChemdescrdkitSeries {
  { vals, name, meta: 0 }
}

pub fn ChemdescrdkitSeries::len(self : ChemdescrdkitSeries) -> Int { self.vals.length() }

pub fn ChemdescrdkitSeries::sum(self : ChemdescrdkitSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemdescrdkitSeries::mean(self : ChemdescrdkitSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemdescrdkitSeries::min(self : ChemdescrdkitSeries) -> Double { @_common.min(self.vals) }

pub fn ChemdescrdkitSeries::max(self : ChemdescrdkitSeries) -> Double { @_common.max(self.vals) }

pub fn ChemdescrdkitSeries::range(self : ChemdescrdkitSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemdescrdkitSeries::variance(self : ChemdescrdkitSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemdescrdkitSeries::std(self : ChemdescrdkitSeries) -> Double { @_common.std(self.vals) }

pub fn ChemdescrdkitSeries::median(self : ChemdescrdkitSeries) -> Double { @_common.median(self.vals) }

pub fn ChemdescrdkitSeries::scale(self : ChemdescrdkitSeries, f : Double) -> ChemdescrdkitSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemdescrdkitSeries::add(self : ChemdescrdkitSeries, other : ChemdescrdkitSeries) -> ChemdescrdkitSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemdescrdkitSeries::sub(self : ChemdescrdkitSeries, other : ChemdescrdkitSeries) -> ChemdescrdkitSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemdescrdkitSeries::normalize(self : ChemdescrdkitSeries) -> ChemdescrdkitSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemdescrdkitSeries::cumsum(self : ChemdescrdkitSeries) -> ChemdescrdkitSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemdescrdkitSeries::to_string(self : ChemdescrdkitSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemdescrdkitMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_desc_rdkit_make_matrix(rows : Int, cols : Int, val : Double) -> ChemdescrdkitMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_desc_rdkit_matrix_identity(n : Int) -> ChemdescrdkitMatrix {
  let m = chem_desc_rdkit_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemdescrdkitMatrix::get(self : ChemdescrdkitMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemdescrdkitMatrix::transpose(self : ChemdescrdkitMatrix) -> ChemdescrdkitMatrix {
  let result = chem_desc_rdkit_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemdescrdkitMatrix::add(self : ChemdescrdkitMatrix, other : ChemdescrdkitMatrix) -> ChemdescrdkitMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_desc_rdkit_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemdescrdkitMatrix::scale(self : ChemdescrdkitMatrix, s : Double) -> ChemdescrdkitMatrix {
  let result = chem_desc_rdkit_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemdescrdkitMatrix::multiply(self : ChemdescrdkitMatrix, other : ChemdescrdkitMatrix) -> ChemdescrdkitMatrix {
  if self.cols != other.rows { return chem_desc_rdkit_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_desc_rdkit_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ChemdescrdkitMatrix::trace(self : ChemdescrdkitMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemdescrdkitMatrix::det(self : ChemdescrdkitMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemdescrdkitMatrix::norm(self : ChemdescrdkitMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemdescrdkitMatrix::to_string(self : ChemdescrdkitMatrix) -> String {
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

pub(all) struct ChemdescrdkitVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_desc_rdkit_make_vector(comps : Array[Double]) -> ChemdescrdkitVector {
  { comps, dim: comps.length() }
}

pub fn chem_desc_rdkit_vector_zero(dim : Int) -> ChemdescrdkitVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemdescrdkitVector::add(self : ChemdescrdkitVector, other : ChemdescrdkitVector) -> ChemdescrdkitVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemdescrdkitVector::sub(self : ChemdescrdkitVector, other : ChemdescrdkitVector) -> ChemdescrdkitVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemdescrdkitVector::scale(self : ChemdescrdkitVector, s : Double) -> ChemdescrdkitVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemdescrdkitVector::dot(self : ChemdescrdkitVector, other : ChemdescrdkitVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemdescrdkitVector::norm(self : ChemdescrdkitVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemdescrdkitVector::normalize(self : ChemdescrdkitVector) -> ChemdescrdkitVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemdescrdkitVector::dist(self : ChemdescrdkitVector, other : ChemdescrdkitVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemdescrdkitVector::to_string(self : ChemdescrdkitVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemdescrdkitFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_rdkit_frame_make(size : Int) -> ChemdescrdkitFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescrdkitFrame::len(self : ChemdescrdkitFrame) -> Int { self.size }

pub fn ChemdescrdkitFrame::get(self : ChemdescrdkitFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescrdkitFrame::set(self : ChemdescrdkitFrame, i : Int, v : Double) -> ChemdescrdkitFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitFrame::sum(self : ChemdescrdkitFrame) -> Double { @_common.sum(self.data) }

pub fn ChemdescrdkitFrame::mean(self : ChemdescrdkitFrame) -> Double { @_common.mean(self.data) }

pub fn ChemdescrdkitFrame::scale(self : ChemdescrdkitFrame, f : Double) -> ChemdescrdkitFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitFrame::add(self : ChemdescrdkitFrame, other : ChemdescrdkitFrame) -> ChemdescrdkitFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescrdkitFrame::copy(self : ChemdescrdkitFrame) -> ChemdescrdkitFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitFrame::fill(self : ChemdescrdkitFrame, v : Double) -> ChemdescrdkitFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitFrame::min(self : ChemdescrdkitFrame) -> Double { @_common.min(self.data) }

pub fn ChemdescrdkitFrame::max(self : ChemdescrdkitFrame) -> Double { @_common.max(self.data) }

pub fn ChemdescrdkitFrame::to_string(self : ChemdescrdkitFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescrdkitTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_rdkit_table_make(size : Int) -> ChemdescrdkitTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescrdkitTable::len(self : ChemdescrdkitTable) -> Int { self.size }

pub fn ChemdescrdkitTable::get(self : ChemdescrdkitTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescrdkitTable::set(self : ChemdescrdkitTable, i : Int, v : Double) -> ChemdescrdkitTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitTable::sum(self : ChemdescrdkitTable) -> Double { @_common.sum(self.data) }

pub fn ChemdescrdkitTable::mean(self : ChemdescrdkitTable) -> Double { @_common.mean(self.data) }

pub fn ChemdescrdkitTable::scale(self : ChemdescrdkitTable, f : Double) -> ChemdescrdkitTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitTable::add(self : ChemdescrdkitTable, other : ChemdescrdkitTable) -> ChemdescrdkitTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescrdkitTable::copy(self : ChemdescrdkitTable) -> ChemdescrdkitTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitTable::fill(self : ChemdescrdkitTable, v : Double) -> ChemdescrdkitTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitTable::min(self : ChemdescrdkitTable) -> Double { @_common.min(self.data) }

pub fn ChemdescrdkitTable::max(self : ChemdescrdkitTable) -> Double { @_common.max(self.data) }

pub fn ChemdescrdkitTable::to_string(self : ChemdescrdkitTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescrdkitGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_rdkit_graphn_make(size : Int) -> ChemdescrdkitGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescrdkitGraphN::len(self : ChemdescrdkitGraphN) -> Int { self.size }

pub fn ChemdescrdkitGraphN::get(self : ChemdescrdkitGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescrdkitGraphN::set(self : ChemdescrdkitGraphN, i : Int, v : Double) -> ChemdescrdkitGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitGraphN::sum(self : ChemdescrdkitGraphN) -> Double { @_common.sum(self.data) }

pub fn ChemdescrdkitGraphN::mean(self : ChemdescrdkitGraphN) -> Double { @_common.mean(self.data) }

pub fn ChemdescrdkitGraphN::scale(self : ChemdescrdkitGraphN, f : Double) -> ChemdescrdkitGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitGraphN::add(self : ChemdescrdkitGraphN, other : ChemdescrdkitGraphN) -> ChemdescrdkitGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescrdkitGraphN::copy(self : ChemdescrdkitGraphN) -> ChemdescrdkitGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitGraphN::fill(self : ChemdescrdkitGraphN, v : Double) -> ChemdescrdkitGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitGraphN::min(self : ChemdescrdkitGraphN) -> Double { @_common.min(self.data) }

pub fn ChemdescrdkitGraphN::max(self : ChemdescrdkitGraphN) -> Double { @_common.max(self.data) }

pub fn ChemdescrdkitGraphN::to_string(self : ChemdescrdkitGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescrdkitNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_rdkit_node_make(size : Int) -> ChemdescrdkitNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescrdkitNode::len(self : ChemdescrdkitNode) -> Int { self.size }

pub fn ChemdescrdkitNode::get(self : ChemdescrdkitNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescrdkitNode::set(self : ChemdescrdkitNode, i : Int, v : Double) -> ChemdescrdkitNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitNode::sum(self : ChemdescrdkitNode) -> Double { @_common.sum(self.data) }

pub fn ChemdescrdkitNode::mean(self : ChemdescrdkitNode) -> Double { @_common.mean(self.data) }

pub fn ChemdescrdkitNode::scale(self : ChemdescrdkitNode, f : Double) -> ChemdescrdkitNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitNode::add(self : ChemdescrdkitNode, other : ChemdescrdkitNode) -> ChemdescrdkitNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescrdkitNode::copy(self : ChemdescrdkitNode) -> ChemdescrdkitNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitNode::fill(self : ChemdescrdkitNode, v : Double) -> ChemdescrdkitNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitNode::min(self : ChemdescrdkitNode) -> Double { @_common.min(self.data) }

pub fn ChemdescrdkitNode::max(self : ChemdescrdkitNode) -> Double { @_common.max(self.data) }

pub fn ChemdescrdkitNode::to_string(self : ChemdescrdkitNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescrdkitEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_rdkit_edge_make(size : Int) -> ChemdescrdkitEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescrdkitEdge::len(self : ChemdescrdkitEdge) -> Int { self.size }

pub fn ChemdescrdkitEdge::get(self : ChemdescrdkitEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescrdkitEdge::set(self : ChemdescrdkitEdge, i : Int, v : Double) -> ChemdescrdkitEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitEdge::sum(self : ChemdescrdkitEdge) -> Double { @_common.sum(self.data) }

pub fn ChemdescrdkitEdge::mean(self : ChemdescrdkitEdge) -> Double { @_common.mean(self.data) }

pub fn ChemdescrdkitEdge::scale(self : ChemdescrdkitEdge, f : Double) -> ChemdescrdkitEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitEdge::add(self : ChemdescrdkitEdge, other : ChemdescrdkitEdge) -> ChemdescrdkitEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescrdkitEdge::copy(self : ChemdescrdkitEdge) -> ChemdescrdkitEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitEdge::fill(self : ChemdescrdkitEdge, v : Double) -> ChemdescrdkitEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitEdge::min(self : ChemdescrdkitEdge) -> Double { @_common.min(self.data) }

pub fn ChemdescrdkitEdge::max(self : ChemdescrdkitEdge) -> Double { @_common.max(self.data) }

pub fn ChemdescrdkitEdge::to_string(self : ChemdescrdkitEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescrdkitPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_rdkit_path_make(size : Int) -> ChemdescrdkitPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescrdkitPath::len(self : ChemdescrdkitPath) -> Int { self.size }

pub fn ChemdescrdkitPath::get(self : ChemdescrdkitPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescrdkitPath::set(self : ChemdescrdkitPath, i : Int, v : Double) -> ChemdescrdkitPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitPath::sum(self : ChemdescrdkitPath) -> Double { @_common.sum(self.data) }

pub fn ChemdescrdkitPath::mean(self : ChemdescrdkitPath) -> Double { @_common.mean(self.data) }

pub fn ChemdescrdkitPath::scale(self : ChemdescrdkitPath, f : Double) -> ChemdescrdkitPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitPath::add(self : ChemdescrdkitPath, other : ChemdescrdkitPath) -> ChemdescrdkitPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescrdkitPath::copy(self : ChemdescrdkitPath) -> ChemdescrdkitPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitPath::fill(self : ChemdescrdkitPath, v : Double) -> ChemdescrdkitPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitPath::min(self : ChemdescrdkitPath) -> Double { @_common.min(self.data) }

pub fn ChemdescrdkitPath::max(self : ChemdescrdkitPath) -> Double { @_common.max(self.data) }

pub fn ChemdescrdkitPath::to_string(self : ChemdescrdkitPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescrdkitCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_rdkit_cluster_make(size : Int) -> ChemdescrdkitCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescrdkitCluster::len(self : ChemdescrdkitCluster) -> Int { self.size }

pub fn ChemdescrdkitCluster::get(self : ChemdescrdkitCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescrdkitCluster::set(self : ChemdescrdkitCluster, i : Int, v : Double) -> ChemdescrdkitCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitCluster::sum(self : ChemdescrdkitCluster) -> Double { @_common.sum(self.data) }

pub fn ChemdescrdkitCluster::mean(self : ChemdescrdkitCluster) -> Double { @_common.mean(self.data) }

pub fn ChemdescrdkitCluster::scale(self : ChemdescrdkitCluster, f : Double) -> ChemdescrdkitCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitCluster::add(self : ChemdescrdkitCluster, other : ChemdescrdkitCluster) -> ChemdescrdkitCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescrdkitCluster::copy(self : ChemdescrdkitCluster) -> ChemdescrdkitCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitCluster::fill(self : ChemdescrdkitCluster, v : Double) -> ChemdescrdkitCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitCluster::min(self : ChemdescrdkitCluster) -> Double { @_common.min(self.data) }

pub fn ChemdescrdkitCluster::max(self : ChemdescrdkitCluster) -> Double { @_common.max(self.data) }

pub fn ChemdescrdkitCluster::to_string(self : ChemdescrdkitCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescrdkitModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_rdkit_model_make(size : Int) -> ChemdescrdkitModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescrdkitModel::len(self : ChemdescrdkitModel) -> Int { self.size }

pub fn ChemdescrdkitModel::get(self : ChemdescrdkitModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescrdkitModel::set(self : ChemdescrdkitModel, i : Int, v : Double) -> ChemdescrdkitModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitModel::sum(self : ChemdescrdkitModel) -> Double { @_common.sum(self.data) }

pub fn ChemdescrdkitModel::mean(self : ChemdescrdkitModel) -> Double { @_common.mean(self.data) }

pub fn ChemdescrdkitModel::scale(self : ChemdescrdkitModel, f : Double) -> ChemdescrdkitModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitModel::add(self : ChemdescrdkitModel, other : ChemdescrdkitModel) -> ChemdescrdkitModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescrdkitModel::copy(self : ChemdescrdkitModel) -> ChemdescrdkitModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitModel::fill(self : ChemdescrdkitModel, v : Double) -> ChemdescrdkitModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitModel::min(self : ChemdescrdkitModel) -> Double { @_common.min(self.data) }

pub fn ChemdescrdkitModel::max(self : ChemdescrdkitModel) -> Double { @_common.max(self.data) }

pub fn ChemdescrdkitModel::to_string(self : ChemdescrdkitModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescrdkitLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_rdkit_layer_make(size : Int) -> ChemdescrdkitLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescrdkitLayer::len(self : ChemdescrdkitLayer) -> Int { self.size }

pub fn ChemdescrdkitLayer::get(self : ChemdescrdkitLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescrdkitLayer::set(self : ChemdescrdkitLayer, i : Int, v : Double) -> ChemdescrdkitLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitLayer::sum(self : ChemdescrdkitLayer) -> Double { @_common.sum(self.data) }

pub fn ChemdescrdkitLayer::mean(self : ChemdescrdkitLayer) -> Double { @_common.mean(self.data) }

pub fn ChemdescrdkitLayer::scale(self : ChemdescrdkitLayer, f : Double) -> ChemdescrdkitLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitLayer::add(self : ChemdescrdkitLayer, other : ChemdescrdkitLayer) -> ChemdescrdkitLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescrdkitLayer::copy(self : ChemdescrdkitLayer) -> ChemdescrdkitLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitLayer::fill(self : ChemdescrdkitLayer, v : Double) -> ChemdescrdkitLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitLayer::min(self : ChemdescrdkitLayer) -> Double { @_common.min(self.data) }

pub fn ChemdescrdkitLayer::max(self : ChemdescrdkitLayer) -> Double { @_common.max(self.data) }

pub fn ChemdescrdkitLayer::to_string(self : ChemdescrdkitLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescrdkitBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_rdkit_buffer_make(size : Int) -> ChemdescrdkitBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescrdkitBuffer::len(self : ChemdescrdkitBuffer) -> Int { self.size }

pub fn ChemdescrdkitBuffer::get(self : ChemdescrdkitBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescrdkitBuffer::set(self : ChemdescrdkitBuffer, i : Int, v : Double) -> ChemdescrdkitBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitBuffer::sum(self : ChemdescrdkitBuffer) -> Double { @_common.sum(self.data) }

pub fn ChemdescrdkitBuffer::mean(self : ChemdescrdkitBuffer) -> Double { @_common.mean(self.data) }

pub fn ChemdescrdkitBuffer::scale(self : ChemdescrdkitBuffer, f : Double) -> ChemdescrdkitBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitBuffer::add(self : ChemdescrdkitBuffer, other : ChemdescrdkitBuffer) -> ChemdescrdkitBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescrdkitBuffer::copy(self : ChemdescrdkitBuffer) -> ChemdescrdkitBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitBuffer::fill(self : ChemdescrdkitBuffer, v : Double) -> ChemdescrdkitBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitBuffer::min(self : ChemdescrdkitBuffer) -> Double { @_common.min(self.data) }

pub fn ChemdescrdkitBuffer::max(self : ChemdescrdkitBuffer) -> Double { @_common.max(self.data) }

pub fn ChemdescrdkitBuffer::to_string(self : ChemdescrdkitBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescrdkitCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_rdkit_cursor_make(size : Int) -> ChemdescrdkitCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescrdkitCursor::len(self : ChemdescrdkitCursor) -> Int { self.size }

pub fn ChemdescrdkitCursor::get(self : ChemdescrdkitCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescrdkitCursor::set(self : ChemdescrdkitCursor, i : Int, v : Double) -> ChemdescrdkitCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitCursor::sum(self : ChemdescrdkitCursor) -> Double { @_common.sum(self.data) }

pub fn ChemdescrdkitCursor::mean(self : ChemdescrdkitCursor) -> Double { @_common.mean(self.data) }

pub fn ChemdescrdkitCursor::scale(self : ChemdescrdkitCursor, f : Double) -> ChemdescrdkitCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitCursor::add(self : ChemdescrdkitCursor, other : ChemdescrdkitCursor) -> ChemdescrdkitCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescrdkitCursor::copy(self : ChemdescrdkitCursor) -> ChemdescrdkitCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitCursor::fill(self : ChemdescrdkitCursor, v : Double) -> ChemdescrdkitCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitCursor::min(self : ChemdescrdkitCursor) -> Double { @_common.min(self.data) }

pub fn ChemdescrdkitCursor::max(self : ChemdescrdkitCursor) -> Double { @_common.max(self.data) }

pub fn ChemdescrdkitCursor::to_string(self : ChemdescrdkitCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescrdkitView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_rdkit_view_make(size : Int) -> ChemdescrdkitView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescrdkitView::len(self : ChemdescrdkitView) -> Int { self.size }

pub fn ChemdescrdkitView::get(self : ChemdescrdkitView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescrdkitView::set(self : ChemdescrdkitView, i : Int, v : Double) -> ChemdescrdkitView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitView::sum(self : ChemdescrdkitView) -> Double { @_common.sum(self.data) }

pub fn ChemdescrdkitView::mean(self : ChemdescrdkitView) -> Double { @_common.mean(self.data) }

pub fn ChemdescrdkitView::scale(self : ChemdescrdkitView, f : Double) -> ChemdescrdkitView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitView::add(self : ChemdescrdkitView, other : ChemdescrdkitView) -> ChemdescrdkitView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescrdkitView::copy(self : ChemdescrdkitView) -> ChemdescrdkitView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitView::fill(self : ChemdescrdkitView, v : Double) -> ChemdescrdkitView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitView::min(self : ChemdescrdkitView) -> Double { @_common.min(self.data) }

pub fn ChemdescrdkitView::max(self : ChemdescrdkitView) -> Double { @_common.max(self.data) }

pub fn ChemdescrdkitView::to_string(self : ChemdescrdkitView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescrdkitRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_rdkit_range_make(size : Int) -> ChemdescrdkitRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescrdkitRange::len(self : ChemdescrdkitRange) -> Int { self.size }

pub fn ChemdescrdkitRange::get(self : ChemdescrdkitRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescrdkitRange::set(self : ChemdescrdkitRange, i : Int, v : Double) -> ChemdescrdkitRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitRange::sum(self : ChemdescrdkitRange) -> Double { @_common.sum(self.data) }

pub fn ChemdescrdkitRange::mean(self : ChemdescrdkitRange) -> Double { @_common.mean(self.data) }

pub fn ChemdescrdkitRange::scale(self : ChemdescrdkitRange, f : Double) -> ChemdescrdkitRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitRange::add(self : ChemdescrdkitRange, other : ChemdescrdkitRange) -> ChemdescrdkitRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescrdkitRange::copy(self : ChemdescrdkitRange) -> ChemdescrdkitRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitRange::fill(self : ChemdescrdkitRange, v : Double) -> ChemdescrdkitRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitRange::min(self : ChemdescrdkitRange) -> Double { @_common.min(self.data) }

pub fn ChemdescrdkitRange::max(self : ChemdescrdkitRange) -> Double { @_common.max(self.data) }

pub fn ChemdescrdkitRange::to_string(self : ChemdescrdkitRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescrdkitSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_rdkit_slice_make(size : Int) -> ChemdescrdkitSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescrdkitSlice::len(self : ChemdescrdkitSlice) -> Int { self.size }

pub fn ChemdescrdkitSlice::get(self : ChemdescrdkitSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescrdkitSlice::set(self : ChemdescrdkitSlice, i : Int, v : Double) -> ChemdescrdkitSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitSlice::sum(self : ChemdescrdkitSlice) -> Double { @_common.sum(self.data) }

pub fn ChemdescrdkitSlice::mean(self : ChemdescrdkitSlice) -> Double { @_common.mean(self.data) }

pub fn ChemdescrdkitSlice::scale(self : ChemdescrdkitSlice, f : Double) -> ChemdescrdkitSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitSlice::add(self : ChemdescrdkitSlice, other : ChemdescrdkitSlice) -> ChemdescrdkitSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescrdkitSlice::copy(self : ChemdescrdkitSlice) -> ChemdescrdkitSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitSlice::fill(self : ChemdescrdkitSlice, v : Double) -> ChemdescrdkitSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescrdkitSlice::min(self : ChemdescrdkitSlice) -> Double { @_common.min(self.data) }

pub fn ChemdescrdkitSlice::max(self : ChemdescrdkitSlice) -> Double { @_common.max(self.data) }

pub fn ChemdescrdkitSlice::to_string(self : ChemdescrdkitSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

