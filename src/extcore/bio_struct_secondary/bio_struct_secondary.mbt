///===
/// extcore/bio_struct_secondary

pub(all) struct BiostructsecondaryPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_struct_secondary_make_point(x : Double, y : Double) -> BiostructsecondaryPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_struct_secondary_make_point3(x : Double, y : Double, z : Double) -> BiostructsecondaryPoint {
  { x, y, z, label: 0 }
}

pub fn BiostructsecondaryPoint::x(self : BiostructsecondaryPoint) -> Double { self.x }

pub fn BiostructsecondaryPoint::y(self : BiostructsecondaryPoint) -> Double { self.y }

pub fn BiostructsecondaryPoint::z(self : BiostructsecondaryPoint) -> Double { self.z }

pub fn BiostructsecondaryPoint::label(self : BiostructsecondaryPoint) -> Int { self.label }

pub fn BiostructsecondaryPoint::dist(self : BiostructsecondaryPoint, other : BiostructsecondaryPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BiostructsecondaryPoint::add(self : BiostructsecondaryPoint, other : BiostructsecondaryPoint) -> BiostructsecondaryPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BiostructsecondaryPoint::sub(self : BiostructsecondaryPoint, other : BiostructsecondaryPoint) -> BiostructsecondaryPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BiostructsecondaryPoint::scale(self : BiostructsecondaryPoint, s : Double) -> BiostructsecondaryPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BiostructsecondaryPoint::dot(self : BiostructsecondaryPoint, other : BiostructsecondaryPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BiostructsecondaryPoint::cross(self : BiostructsecondaryPoint, other : BiostructsecondaryPoint) -> BiostructsecondaryPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BiostructsecondaryPoint::norm(self : BiostructsecondaryPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BiostructsecondaryPoint::normalize(self : BiostructsecondaryPoint) -> BiostructsecondaryPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiostructsecondaryPoint::negate(self : BiostructsecondaryPoint) -> BiostructsecondaryPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BiostructsecondaryPoint::mid(self : BiostructsecondaryPoint, other : BiostructsecondaryPoint) -> BiostructsecondaryPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BiostructsecondaryPoint::lerp(self : BiostructsecondaryPoint, other : BiostructsecondaryPoint, t : Double) -> BiostructsecondaryPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BiostructsecondaryPoint::to_string(self : BiostructsecondaryPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BiostructsecondarySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_struct_secondary_make_series(vals : Array[Double], name : String) -> BiostructsecondarySeries {
  { vals, name, meta: 0 }
}

pub fn BiostructsecondarySeries::len(self : BiostructsecondarySeries) -> Int { self.vals.length() }

pub fn BiostructsecondarySeries::sum(self : BiostructsecondarySeries) -> Double { @_common.sum(self.vals) }

pub fn BiostructsecondarySeries::mean(self : BiostructsecondarySeries) -> Double { @_common.mean(self.vals) }

pub fn BiostructsecondarySeries::min(self : BiostructsecondarySeries) -> Double { @_common.min(self.vals) }

pub fn BiostructsecondarySeries::max(self : BiostructsecondarySeries) -> Double { @_common.max(self.vals) }

pub fn BiostructsecondarySeries::range(self : BiostructsecondarySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BiostructsecondarySeries::variance(self : BiostructsecondarySeries) -> Double { @_common.variance(self.vals) }

pub fn BiostructsecondarySeries::std(self : BiostructsecondarySeries) -> Double { @_common.std(self.vals) }

pub fn BiostructsecondarySeries::median(self : BiostructsecondarySeries) -> Double { @_common.median(self.vals) }

pub fn BiostructsecondarySeries::scale(self : BiostructsecondarySeries, f : Double) -> BiostructsecondarySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BiostructsecondarySeries::add(self : BiostructsecondarySeries, other : BiostructsecondarySeries) -> BiostructsecondarySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BiostructsecondarySeries::sub(self : BiostructsecondarySeries, other : BiostructsecondarySeries) -> BiostructsecondarySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BiostructsecondarySeries::normalize(self : BiostructsecondarySeries) -> BiostructsecondarySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BiostructsecondarySeries::cumsum(self : BiostructsecondarySeries) -> BiostructsecondarySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BiostructsecondarySeries::to_string(self : BiostructsecondarySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiostructsecondaryMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_struct_secondary_make_matrix(rows : Int, cols : Int, val : Double) -> BiostructsecondaryMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_struct_secondary_matrix_identity(n : Int) -> BiostructsecondaryMatrix {
  let m = bio_struct_secondary_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BiostructsecondaryMatrix::get(self : BiostructsecondaryMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BiostructsecondaryMatrix::transpose(self : BiostructsecondaryMatrix) -> BiostructsecondaryMatrix {
  let result = bio_struct_secondary_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BiostructsecondaryMatrix::add(self : BiostructsecondaryMatrix, other : BiostructsecondaryMatrix) -> BiostructsecondaryMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_struct_secondary_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BiostructsecondaryMatrix::scale(self : BiostructsecondaryMatrix, s : Double) -> BiostructsecondaryMatrix {
  let result = bio_struct_secondary_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BiostructsecondaryMatrix::multiply(self : BiostructsecondaryMatrix, other : BiostructsecondaryMatrix) -> BiostructsecondaryMatrix {
  if self.cols != other.rows { return bio_struct_secondary_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_struct_secondary_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn BiostructsecondaryMatrix::trace(self : BiostructsecondaryMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BiostructsecondaryMatrix::det(self : BiostructsecondaryMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BiostructsecondaryMatrix::norm(self : BiostructsecondaryMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BiostructsecondaryMatrix::to_string(self : BiostructsecondaryMatrix) -> String {
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

pub(all) struct BiostructsecondaryVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_struct_secondary_make_vector(comps : Array[Double]) -> BiostructsecondaryVector {
  { comps, dim: comps.length() }
}

pub fn bio_struct_secondary_vector_zero(dim : Int) -> BiostructsecondaryVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BiostructsecondaryVector::add(self : BiostructsecondaryVector, other : BiostructsecondaryVector) -> BiostructsecondaryVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BiostructsecondaryVector::sub(self : BiostructsecondaryVector, other : BiostructsecondaryVector) -> BiostructsecondaryVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BiostructsecondaryVector::scale(self : BiostructsecondaryVector, s : Double) -> BiostructsecondaryVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BiostructsecondaryVector::dot(self : BiostructsecondaryVector, other : BiostructsecondaryVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BiostructsecondaryVector::norm(self : BiostructsecondaryVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BiostructsecondaryVector::normalize(self : BiostructsecondaryVector) -> BiostructsecondaryVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiostructsecondaryVector::dist(self : BiostructsecondaryVector, other : BiostructsecondaryVector) -> Double {
  self.sub(other).norm()
}

pub fn BiostructsecondaryVector::to_string(self : BiostructsecondaryVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiostructsecondaryFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_secondary_frame_make(size : Int) -> BiostructsecondaryFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructsecondaryFrame::len(self : BiostructsecondaryFrame) -> Int { self.size }

pub fn BiostructsecondaryFrame::get(self : BiostructsecondaryFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructsecondaryFrame::set(self : BiostructsecondaryFrame, i : Int, v : Double) -> BiostructsecondaryFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryFrame::sum(self : BiostructsecondaryFrame) -> Double { @_common.sum(self.data) }

pub fn BiostructsecondaryFrame::mean(self : BiostructsecondaryFrame) -> Double { @_common.mean(self.data) }

pub fn BiostructsecondaryFrame::scale(self : BiostructsecondaryFrame, f : Double) -> BiostructsecondaryFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryFrame::add(self : BiostructsecondaryFrame, other : BiostructsecondaryFrame) -> BiostructsecondaryFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructsecondaryFrame::copy(self : BiostructsecondaryFrame) -> BiostructsecondaryFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryFrame::fill(self : BiostructsecondaryFrame, v : Double) -> BiostructsecondaryFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryFrame::min(self : BiostructsecondaryFrame) -> Double { @_common.min(self.data) }

pub fn BiostructsecondaryFrame::max(self : BiostructsecondaryFrame) -> Double { @_common.max(self.data) }

pub fn BiostructsecondaryFrame::to_string(self : BiostructsecondaryFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructsecondaryTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_secondary_table_make(size : Int) -> BiostructsecondaryTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructsecondaryTable::len(self : BiostructsecondaryTable) -> Int { self.size }

pub fn BiostructsecondaryTable::get(self : BiostructsecondaryTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructsecondaryTable::set(self : BiostructsecondaryTable, i : Int, v : Double) -> BiostructsecondaryTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryTable::sum(self : BiostructsecondaryTable) -> Double { @_common.sum(self.data) }

pub fn BiostructsecondaryTable::mean(self : BiostructsecondaryTable) -> Double { @_common.mean(self.data) }

pub fn BiostructsecondaryTable::scale(self : BiostructsecondaryTable, f : Double) -> BiostructsecondaryTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryTable::add(self : BiostructsecondaryTable, other : BiostructsecondaryTable) -> BiostructsecondaryTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructsecondaryTable::copy(self : BiostructsecondaryTable) -> BiostructsecondaryTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryTable::fill(self : BiostructsecondaryTable, v : Double) -> BiostructsecondaryTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryTable::min(self : BiostructsecondaryTable) -> Double { @_common.min(self.data) }

pub fn BiostructsecondaryTable::max(self : BiostructsecondaryTable) -> Double { @_common.max(self.data) }

pub fn BiostructsecondaryTable::to_string(self : BiostructsecondaryTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructsecondaryGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_secondary_graphn_make(size : Int) -> BiostructsecondaryGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructsecondaryGraphN::len(self : BiostructsecondaryGraphN) -> Int { self.size }

pub fn BiostructsecondaryGraphN::get(self : BiostructsecondaryGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructsecondaryGraphN::set(self : BiostructsecondaryGraphN, i : Int, v : Double) -> BiostructsecondaryGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryGraphN::sum(self : BiostructsecondaryGraphN) -> Double { @_common.sum(self.data) }

pub fn BiostructsecondaryGraphN::mean(self : BiostructsecondaryGraphN) -> Double { @_common.mean(self.data) }

pub fn BiostructsecondaryGraphN::scale(self : BiostructsecondaryGraphN, f : Double) -> BiostructsecondaryGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryGraphN::add(self : BiostructsecondaryGraphN, other : BiostructsecondaryGraphN) -> BiostructsecondaryGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructsecondaryGraphN::copy(self : BiostructsecondaryGraphN) -> BiostructsecondaryGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryGraphN::fill(self : BiostructsecondaryGraphN, v : Double) -> BiostructsecondaryGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryGraphN::min(self : BiostructsecondaryGraphN) -> Double { @_common.min(self.data) }

pub fn BiostructsecondaryGraphN::max(self : BiostructsecondaryGraphN) -> Double { @_common.max(self.data) }

pub fn BiostructsecondaryGraphN::to_string(self : BiostructsecondaryGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructsecondaryNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_secondary_node_make(size : Int) -> BiostructsecondaryNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructsecondaryNode::len(self : BiostructsecondaryNode) -> Int { self.size }

pub fn BiostructsecondaryNode::get(self : BiostructsecondaryNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructsecondaryNode::set(self : BiostructsecondaryNode, i : Int, v : Double) -> BiostructsecondaryNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryNode::sum(self : BiostructsecondaryNode) -> Double { @_common.sum(self.data) }

pub fn BiostructsecondaryNode::mean(self : BiostructsecondaryNode) -> Double { @_common.mean(self.data) }

pub fn BiostructsecondaryNode::scale(self : BiostructsecondaryNode, f : Double) -> BiostructsecondaryNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryNode::add(self : BiostructsecondaryNode, other : BiostructsecondaryNode) -> BiostructsecondaryNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructsecondaryNode::copy(self : BiostructsecondaryNode) -> BiostructsecondaryNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryNode::fill(self : BiostructsecondaryNode, v : Double) -> BiostructsecondaryNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryNode::min(self : BiostructsecondaryNode) -> Double { @_common.min(self.data) }

pub fn BiostructsecondaryNode::max(self : BiostructsecondaryNode) -> Double { @_common.max(self.data) }

pub fn BiostructsecondaryNode::to_string(self : BiostructsecondaryNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructsecondaryEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_secondary_edge_make(size : Int) -> BiostructsecondaryEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructsecondaryEdge::len(self : BiostructsecondaryEdge) -> Int { self.size }

pub fn BiostructsecondaryEdge::get(self : BiostructsecondaryEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructsecondaryEdge::set(self : BiostructsecondaryEdge, i : Int, v : Double) -> BiostructsecondaryEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryEdge::sum(self : BiostructsecondaryEdge) -> Double { @_common.sum(self.data) }

pub fn BiostructsecondaryEdge::mean(self : BiostructsecondaryEdge) -> Double { @_common.mean(self.data) }

pub fn BiostructsecondaryEdge::scale(self : BiostructsecondaryEdge, f : Double) -> BiostructsecondaryEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryEdge::add(self : BiostructsecondaryEdge, other : BiostructsecondaryEdge) -> BiostructsecondaryEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructsecondaryEdge::copy(self : BiostructsecondaryEdge) -> BiostructsecondaryEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryEdge::fill(self : BiostructsecondaryEdge, v : Double) -> BiostructsecondaryEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryEdge::min(self : BiostructsecondaryEdge) -> Double { @_common.min(self.data) }

pub fn BiostructsecondaryEdge::max(self : BiostructsecondaryEdge) -> Double { @_common.max(self.data) }

pub fn BiostructsecondaryEdge::to_string(self : BiostructsecondaryEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructsecondaryPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_secondary_path_make(size : Int) -> BiostructsecondaryPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructsecondaryPath::len(self : BiostructsecondaryPath) -> Int { self.size }

pub fn BiostructsecondaryPath::get(self : BiostructsecondaryPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructsecondaryPath::set(self : BiostructsecondaryPath, i : Int, v : Double) -> BiostructsecondaryPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryPath::sum(self : BiostructsecondaryPath) -> Double { @_common.sum(self.data) }

pub fn BiostructsecondaryPath::mean(self : BiostructsecondaryPath) -> Double { @_common.mean(self.data) }

pub fn BiostructsecondaryPath::scale(self : BiostructsecondaryPath, f : Double) -> BiostructsecondaryPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryPath::add(self : BiostructsecondaryPath, other : BiostructsecondaryPath) -> BiostructsecondaryPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructsecondaryPath::copy(self : BiostructsecondaryPath) -> BiostructsecondaryPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryPath::fill(self : BiostructsecondaryPath, v : Double) -> BiostructsecondaryPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryPath::min(self : BiostructsecondaryPath) -> Double { @_common.min(self.data) }

pub fn BiostructsecondaryPath::max(self : BiostructsecondaryPath) -> Double { @_common.max(self.data) }

pub fn BiostructsecondaryPath::to_string(self : BiostructsecondaryPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructsecondaryCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_secondary_cluster_make(size : Int) -> BiostructsecondaryCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructsecondaryCluster::len(self : BiostructsecondaryCluster) -> Int { self.size }

pub fn BiostructsecondaryCluster::get(self : BiostructsecondaryCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructsecondaryCluster::set(self : BiostructsecondaryCluster, i : Int, v : Double) -> BiostructsecondaryCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryCluster::sum(self : BiostructsecondaryCluster) -> Double { @_common.sum(self.data) }

pub fn BiostructsecondaryCluster::mean(self : BiostructsecondaryCluster) -> Double { @_common.mean(self.data) }

pub fn BiostructsecondaryCluster::scale(self : BiostructsecondaryCluster, f : Double) -> BiostructsecondaryCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryCluster::add(self : BiostructsecondaryCluster, other : BiostructsecondaryCluster) -> BiostructsecondaryCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructsecondaryCluster::copy(self : BiostructsecondaryCluster) -> BiostructsecondaryCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryCluster::fill(self : BiostructsecondaryCluster, v : Double) -> BiostructsecondaryCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryCluster::min(self : BiostructsecondaryCluster) -> Double { @_common.min(self.data) }

pub fn BiostructsecondaryCluster::max(self : BiostructsecondaryCluster) -> Double { @_common.max(self.data) }

pub fn BiostructsecondaryCluster::to_string(self : BiostructsecondaryCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructsecondaryModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_secondary_model_make(size : Int) -> BiostructsecondaryModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructsecondaryModel::len(self : BiostructsecondaryModel) -> Int { self.size }

pub fn BiostructsecondaryModel::get(self : BiostructsecondaryModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructsecondaryModel::set(self : BiostructsecondaryModel, i : Int, v : Double) -> BiostructsecondaryModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryModel::sum(self : BiostructsecondaryModel) -> Double { @_common.sum(self.data) }

pub fn BiostructsecondaryModel::mean(self : BiostructsecondaryModel) -> Double { @_common.mean(self.data) }

pub fn BiostructsecondaryModel::scale(self : BiostructsecondaryModel, f : Double) -> BiostructsecondaryModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryModel::add(self : BiostructsecondaryModel, other : BiostructsecondaryModel) -> BiostructsecondaryModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructsecondaryModel::copy(self : BiostructsecondaryModel) -> BiostructsecondaryModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryModel::fill(self : BiostructsecondaryModel, v : Double) -> BiostructsecondaryModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryModel::min(self : BiostructsecondaryModel) -> Double { @_common.min(self.data) }

pub fn BiostructsecondaryModel::max(self : BiostructsecondaryModel) -> Double { @_common.max(self.data) }

pub fn BiostructsecondaryModel::to_string(self : BiostructsecondaryModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructsecondaryLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_secondary_layer_make(size : Int) -> BiostructsecondaryLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructsecondaryLayer::len(self : BiostructsecondaryLayer) -> Int { self.size }

pub fn BiostructsecondaryLayer::get(self : BiostructsecondaryLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructsecondaryLayer::set(self : BiostructsecondaryLayer, i : Int, v : Double) -> BiostructsecondaryLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryLayer::sum(self : BiostructsecondaryLayer) -> Double { @_common.sum(self.data) }

pub fn BiostructsecondaryLayer::mean(self : BiostructsecondaryLayer) -> Double { @_common.mean(self.data) }

pub fn BiostructsecondaryLayer::scale(self : BiostructsecondaryLayer, f : Double) -> BiostructsecondaryLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryLayer::add(self : BiostructsecondaryLayer, other : BiostructsecondaryLayer) -> BiostructsecondaryLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructsecondaryLayer::copy(self : BiostructsecondaryLayer) -> BiostructsecondaryLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryLayer::fill(self : BiostructsecondaryLayer, v : Double) -> BiostructsecondaryLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryLayer::min(self : BiostructsecondaryLayer) -> Double { @_common.min(self.data) }

pub fn BiostructsecondaryLayer::max(self : BiostructsecondaryLayer) -> Double { @_common.max(self.data) }

pub fn BiostructsecondaryLayer::to_string(self : BiostructsecondaryLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructsecondaryBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_secondary_buffer_make(size : Int) -> BiostructsecondaryBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructsecondaryBuffer::len(self : BiostructsecondaryBuffer) -> Int { self.size }

pub fn BiostructsecondaryBuffer::get(self : BiostructsecondaryBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructsecondaryBuffer::set(self : BiostructsecondaryBuffer, i : Int, v : Double) -> BiostructsecondaryBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryBuffer::sum(self : BiostructsecondaryBuffer) -> Double { @_common.sum(self.data) }

pub fn BiostructsecondaryBuffer::mean(self : BiostructsecondaryBuffer) -> Double { @_common.mean(self.data) }

pub fn BiostructsecondaryBuffer::scale(self : BiostructsecondaryBuffer, f : Double) -> BiostructsecondaryBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryBuffer::add(self : BiostructsecondaryBuffer, other : BiostructsecondaryBuffer) -> BiostructsecondaryBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructsecondaryBuffer::copy(self : BiostructsecondaryBuffer) -> BiostructsecondaryBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryBuffer::fill(self : BiostructsecondaryBuffer, v : Double) -> BiostructsecondaryBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryBuffer::min(self : BiostructsecondaryBuffer) -> Double { @_common.min(self.data) }

pub fn BiostructsecondaryBuffer::max(self : BiostructsecondaryBuffer) -> Double { @_common.max(self.data) }

pub fn BiostructsecondaryBuffer::to_string(self : BiostructsecondaryBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructsecondaryCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_secondary_cursor_make(size : Int) -> BiostructsecondaryCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructsecondaryCursor::len(self : BiostructsecondaryCursor) -> Int { self.size }

pub fn BiostructsecondaryCursor::get(self : BiostructsecondaryCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructsecondaryCursor::set(self : BiostructsecondaryCursor, i : Int, v : Double) -> BiostructsecondaryCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryCursor::sum(self : BiostructsecondaryCursor) -> Double { @_common.sum(self.data) }

pub fn BiostructsecondaryCursor::mean(self : BiostructsecondaryCursor) -> Double { @_common.mean(self.data) }

pub fn BiostructsecondaryCursor::scale(self : BiostructsecondaryCursor, f : Double) -> BiostructsecondaryCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryCursor::add(self : BiostructsecondaryCursor, other : BiostructsecondaryCursor) -> BiostructsecondaryCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructsecondaryCursor::copy(self : BiostructsecondaryCursor) -> BiostructsecondaryCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryCursor::fill(self : BiostructsecondaryCursor, v : Double) -> BiostructsecondaryCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryCursor::min(self : BiostructsecondaryCursor) -> Double { @_common.min(self.data) }

pub fn BiostructsecondaryCursor::max(self : BiostructsecondaryCursor) -> Double { @_common.max(self.data) }

pub fn BiostructsecondaryCursor::to_string(self : BiostructsecondaryCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructsecondaryView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_secondary_view_make(size : Int) -> BiostructsecondaryView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructsecondaryView::len(self : BiostructsecondaryView) -> Int { self.size }

pub fn BiostructsecondaryView::get(self : BiostructsecondaryView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructsecondaryView::set(self : BiostructsecondaryView, i : Int, v : Double) -> BiostructsecondaryView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryView::sum(self : BiostructsecondaryView) -> Double { @_common.sum(self.data) }

pub fn BiostructsecondaryView::mean(self : BiostructsecondaryView) -> Double { @_common.mean(self.data) }

pub fn BiostructsecondaryView::scale(self : BiostructsecondaryView, f : Double) -> BiostructsecondaryView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryView::add(self : BiostructsecondaryView, other : BiostructsecondaryView) -> BiostructsecondaryView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructsecondaryView::copy(self : BiostructsecondaryView) -> BiostructsecondaryView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryView::fill(self : BiostructsecondaryView, v : Double) -> BiostructsecondaryView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryView::min(self : BiostructsecondaryView) -> Double { @_common.min(self.data) }

pub fn BiostructsecondaryView::max(self : BiostructsecondaryView) -> Double { @_common.max(self.data) }

pub fn BiostructsecondaryView::to_string(self : BiostructsecondaryView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructsecondaryRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_secondary_range_make(size : Int) -> BiostructsecondaryRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructsecondaryRange::len(self : BiostructsecondaryRange) -> Int { self.size }

pub fn BiostructsecondaryRange::get(self : BiostructsecondaryRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructsecondaryRange::set(self : BiostructsecondaryRange, i : Int, v : Double) -> BiostructsecondaryRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryRange::sum(self : BiostructsecondaryRange) -> Double { @_common.sum(self.data) }

pub fn BiostructsecondaryRange::mean(self : BiostructsecondaryRange) -> Double { @_common.mean(self.data) }

pub fn BiostructsecondaryRange::scale(self : BiostructsecondaryRange, f : Double) -> BiostructsecondaryRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryRange::add(self : BiostructsecondaryRange, other : BiostructsecondaryRange) -> BiostructsecondaryRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructsecondaryRange::copy(self : BiostructsecondaryRange) -> BiostructsecondaryRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryRange::fill(self : BiostructsecondaryRange, v : Double) -> BiostructsecondaryRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructsecondaryRange::min(self : BiostructsecondaryRange) -> Double { @_common.min(self.data) }

pub fn BiostructsecondaryRange::max(self : BiostructsecondaryRange) -> Double { @_common.max(self.data) }

pub fn BiostructsecondaryRange::to_string(self : BiostructsecondaryRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructsecondarySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_secondary_slice_make(size : Int) -> BiostructsecondarySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructsecondarySlice::len(self : BiostructsecondarySlice) -> Int { self.size }

pub fn BiostructsecondarySlice::get(self : BiostructsecondarySlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructsecondarySlice::set(self : BiostructsecondarySlice, i : Int, v : Double) -> BiostructsecondarySlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructsecondarySlice::sum(self : BiostructsecondarySlice) -> Double { @_common.sum(self.data) }

pub fn BiostructsecondarySlice::mean(self : BiostructsecondarySlice) -> Double { @_common.mean(self.data) }

pub fn BiostructsecondarySlice::scale(self : BiostructsecondarySlice, f : Double) -> BiostructsecondarySlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructsecondarySlice::add(self : BiostructsecondarySlice, other : BiostructsecondarySlice) -> BiostructsecondarySlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructsecondarySlice::copy(self : BiostructsecondarySlice) -> BiostructsecondarySlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructsecondarySlice::fill(self : BiostructsecondarySlice, v : Double) -> BiostructsecondarySlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructsecondarySlice::min(self : BiostructsecondarySlice) -> Double { @_common.min(self.data) }

pub fn BiostructsecondarySlice::max(self : BiostructsecondarySlice) -> Double { @_common.max(self.data) }

pub fn BiostructsecondarySlice::to_string(self : BiostructsecondarySlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

