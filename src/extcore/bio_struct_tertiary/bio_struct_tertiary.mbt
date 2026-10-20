///===
/// extcore/bio_struct_tertiary

pub(all) struct BiostructtertiaryPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_struct_tertiary_make_point(x : Double, y : Double) -> BiostructtertiaryPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_struct_tertiary_make_point3(x : Double, y : Double, z : Double) -> BiostructtertiaryPoint {
  { x, y, z, label: 0 }
}

pub fn BiostructtertiaryPoint::x(self : BiostructtertiaryPoint) -> Double { self.x }

pub fn BiostructtertiaryPoint::y(self : BiostructtertiaryPoint) -> Double { self.y }

pub fn BiostructtertiaryPoint::z(self : BiostructtertiaryPoint) -> Double { self.z }

pub fn BiostructtertiaryPoint::label(self : BiostructtertiaryPoint) -> Int { self.label }

pub fn BiostructtertiaryPoint::dist(self : BiostructtertiaryPoint, other : BiostructtertiaryPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BiostructtertiaryPoint::add(self : BiostructtertiaryPoint, other : BiostructtertiaryPoint) -> BiostructtertiaryPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BiostructtertiaryPoint::sub(self : BiostructtertiaryPoint, other : BiostructtertiaryPoint) -> BiostructtertiaryPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BiostructtertiaryPoint::scale(self : BiostructtertiaryPoint, s : Double) -> BiostructtertiaryPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BiostructtertiaryPoint::dot(self : BiostructtertiaryPoint, other : BiostructtertiaryPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BiostructtertiaryPoint::cross(self : BiostructtertiaryPoint, other : BiostructtertiaryPoint) -> BiostructtertiaryPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BiostructtertiaryPoint::norm(self : BiostructtertiaryPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BiostructtertiaryPoint::normalize(self : BiostructtertiaryPoint) -> BiostructtertiaryPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiostructtertiaryPoint::negate(self : BiostructtertiaryPoint) -> BiostructtertiaryPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BiostructtertiaryPoint::mid(self : BiostructtertiaryPoint, other : BiostructtertiaryPoint) -> BiostructtertiaryPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BiostructtertiaryPoint::lerp(self : BiostructtertiaryPoint, other : BiostructtertiaryPoint, t : Double) -> BiostructtertiaryPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BiostructtertiaryPoint::to_string(self : BiostructtertiaryPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BiostructtertiarySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_struct_tertiary_make_series(vals : Array[Double], name : String) -> BiostructtertiarySeries {
  { vals, name, meta: 0 }
}

pub fn BiostructtertiarySeries::len(self : BiostructtertiarySeries) -> Int { self.vals.length() }

pub fn BiostructtertiarySeries::sum(self : BiostructtertiarySeries) -> Double { @_common.sum(self.vals) }

pub fn BiostructtertiarySeries::mean(self : BiostructtertiarySeries) -> Double { @_common.mean(self.vals) }

pub fn BiostructtertiarySeries::min(self : BiostructtertiarySeries) -> Double { @_common.min(self.vals) }

pub fn BiostructtertiarySeries::max(self : BiostructtertiarySeries) -> Double { @_common.max(self.vals) }

pub fn BiostructtertiarySeries::range(self : BiostructtertiarySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BiostructtertiarySeries::variance(self : BiostructtertiarySeries) -> Double { @_common.variance(self.vals) }

pub fn BiostructtertiarySeries::std(self : BiostructtertiarySeries) -> Double { @_common.std(self.vals) }

pub fn BiostructtertiarySeries::median(self : BiostructtertiarySeries) -> Double { @_common.median(self.vals) }

pub fn BiostructtertiarySeries::scale(self : BiostructtertiarySeries, f : Double) -> BiostructtertiarySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BiostructtertiarySeries::add(self : BiostructtertiarySeries, other : BiostructtertiarySeries) -> BiostructtertiarySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BiostructtertiarySeries::sub(self : BiostructtertiarySeries, other : BiostructtertiarySeries) -> BiostructtertiarySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BiostructtertiarySeries::normalize(self : BiostructtertiarySeries) -> BiostructtertiarySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BiostructtertiarySeries::cumsum(self : BiostructtertiarySeries) -> BiostructtertiarySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BiostructtertiarySeries::to_string(self : BiostructtertiarySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiostructtertiaryMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_struct_tertiary_make_matrix(rows : Int, cols : Int, val : Double) -> BiostructtertiaryMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_struct_tertiary_matrix_identity(n : Int) -> BiostructtertiaryMatrix {
  let m = bio_struct_tertiary_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BiostructtertiaryMatrix::get(self : BiostructtertiaryMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BiostructtertiaryMatrix::transpose(self : BiostructtertiaryMatrix) -> BiostructtertiaryMatrix {
  let result = bio_struct_tertiary_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BiostructtertiaryMatrix::add(self : BiostructtertiaryMatrix, other : BiostructtertiaryMatrix) -> BiostructtertiaryMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_struct_tertiary_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BiostructtertiaryMatrix::scale(self : BiostructtertiaryMatrix, s : Double) -> BiostructtertiaryMatrix {
  let result = bio_struct_tertiary_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BiostructtertiaryMatrix::multiply(self : BiostructtertiaryMatrix, other : BiostructtertiaryMatrix) -> BiostructtertiaryMatrix {
  if self.cols != other.rows { return bio_struct_tertiary_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_struct_tertiary_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn BiostructtertiaryMatrix::trace(self : BiostructtertiaryMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BiostructtertiaryMatrix::det(self : BiostructtertiaryMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BiostructtertiaryMatrix::norm(self : BiostructtertiaryMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BiostructtertiaryMatrix::to_string(self : BiostructtertiaryMatrix) -> String {
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

pub(all) struct BiostructtertiaryVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_struct_tertiary_make_vector(comps : Array[Double]) -> BiostructtertiaryVector {
  { comps, dim: comps.length() }
}

pub fn bio_struct_tertiary_vector_zero(dim : Int) -> BiostructtertiaryVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BiostructtertiaryVector::add(self : BiostructtertiaryVector, other : BiostructtertiaryVector) -> BiostructtertiaryVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BiostructtertiaryVector::sub(self : BiostructtertiaryVector, other : BiostructtertiaryVector) -> BiostructtertiaryVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BiostructtertiaryVector::scale(self : BiostructtertiaryVector, s : Double) -> BiostructtertiaryVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BiostructtertiaryVector::dot(self : BiostructtertiaryVector, other : BiostructtertiaryVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BiostructtertiaryVector::norm(self : BiostructtertiaryVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BiostructtertiaryVector::normalize(self : BiostructtertiaryVector) -> BiostructtertiaryVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiostructtertiaryVector::dist(self : BiostructtertiaryVector, other : BiostructtertiaryVector) -> Double {
  self.sub(other).norm()
}

pub fn BiostructtertiaryVector::to_string(self : BiostructtertiaryVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiostructtertiaryFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_tertiary_frame_make(size : Int) -> BiostructtertiaryFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructtertiaryFrame::len(self : BiostructtertiaryFrame) -> Int { self.size }

pub fn BiostructtertiaryFrame::get(self : BiostructtertiaryFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructtertiaryFrame::set(self : BiostructtertiaryFrame, i : Int, v : Double) -> BiostructtertiaryFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryFrame::sum(self : BiostructtertiaryFrame) -> Double { @_common.sum(self.data) }

pub fn BiostructtertiaryFrame::mean(self : BiostructtertiaryFrame) -> Double { @_common.mean(self.data) }

pub fn BiostructtertiaryFrame::scale(self : BiostructtertiaryFrame, f : Double) -> BiostructtertiaryFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryFrame::add(self : BiostructtertiaryFrame, other : BiostructtertiaryFrame) -> BiostructtertiaryFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructtertiaryFrame::copy(self : BiostructtertiaryFrame) -> BiostructtertiaryFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryFrame::fill(self : BiostructtertiaryFrame, v : Double) -> BiostructtertiaryFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryFrame::min(self : BiostructtertiaryFrame) -> Double { @_common.min(self.data) }

pub fn BiostructtertiaryFrame::max(self : BiostructtertiaryFrame) -> Double { @_common.max(self.data) }

pub fn BiostructtertiaryFrame::to_string(self : BiostructtertiaryFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructtertiaryTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_tertiary_table_make(size : Int) -> BiostructtertiaryTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructtertiaryTable::len(self : BiostructtertiaryTable) -> Int { self.size }

pub fn BiostructtertiaryTable::get(self : BiostructtertiaryTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructtertiaryTable::set(self : BiostructtertiaryTable, i : Int, v : Double) -> BiostructtertiaryTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryTable::sum(self : BiostructtertiaryTable) -> Double { @_common.sum(self.data) }

pub fn BiostructtertiaryTable::mean(self : BiostructtertiaryTable) -> Double { @_common.mean(self.data) }

pub fn BiostructtertiaryTable::scale(self : BiostructtertiaryTable, f : Double) -> BiostructtertiaryTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryTable::add(self : BiostructtertiaryTable, other : BiostructtertiaryTable) -> BiostructtertiaryTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructtertiaryTable::copy(self : BiostructtertiaryTable) -> BiostructtertiaryTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryTable::fill(self : BiostructtertiaryTable, v : Double) -> BiostructtertiaryTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryTable::min(self : BiostructtertiaryTable) -> Double { @_common.min(self.data) }

pub fn BiostructtertiaryTable::max(self : BiostructtertiaryTable) -> Double { @_common.max(self.data) }

pub fn BiostructtertiaryTable::to_string(self : BiostructtertiaryTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructtertiaryGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_tertiary_graphn_make(size : Int) -> BiostructtertiaryGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructtertiaryGraphN::len(self : BiostructtertiaryGraphN) -> Int { self.size }

pub fn BiostructtertiaryGraphN::get(self : BiostructtertiaryGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructtertiaryGraphN::set(self : BiostructtertiaryGraphN, i : Int, v : Double) -> BiostructtertiaryGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryGraphN::sum(self : BiostructtertiaryGraphN) -> Double { @_common.sum(self.data) }

pub fn BiostructtertiaryGraphN::mean(self : BiostructtertiaryGraphN) -> Double { @_common.mean(self.data) }

pub fn BiostructtertiaryGraphN::scale(self : BiostructtertiaryGraphN, f : Double) -> BiostructtertiaryGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryGraphN::add(self : BiostructtertiaryGraphN, other : BiostructtertiaryGraphN) -> BiostructtertiaryGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructtertiaryGraphN::copy(self : BiostructtertiaryGraphN) -> BiostructtertiaryGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryGraphN::fill(self : BiostructtertiaryGraphN, v : Double) -> BiostructtertiaryGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryGraphN::min(self : BiostructtertiaryGraphN) -> Double { @_common.min(self.data) }

pub fn BiostructtertiaryGraphN::max(self : BiostructtertiaryGraphN) -> Double { @_common.max(self.data) }

pub fn BiostructtertiaryGraphN::to_string(self : BiostructtertiaryGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructtertiaryNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_tertiary_node_make(size : Int) -> BiostructtertiaryNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructtertiaryNode::len(self : BiostructtertiaryNode) -> Int { self.size }

pub fn BiostructtertiaryNode::get(self : BiostructtertiaryNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructtertiaryNode::set(self : BiostructtertiaryNode, i : Int, v : Double) -> BiostructtertiaryNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryNode::sum(self : BiostructtertiaryNode) -> Double { @_common.sum(self.data) }

pub fn BiostructtertiaryNode::mean(self : BiostructtertiaryNode) -> Double { @_common.mean(self.data) }

pub fn BiostructtertiaryNode::scale(self : BiostructtertiaryNode, f : Double) -> BiostructtertiaryNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryNode::add(self : BiostructtertiaryNode, other : BiostructtertiaryNode) -> BiostructtertiaryNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructtertiaryNode::copy(self : BiostructtertiaryNode) -> BiostructtertiaryNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryNode::fill(self : BiostructtertiaryNode, v : Double) -> BiostructtertiaryNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryNode::min(self : BiostructtertiaryNode) -> Double { @_common.min(self.data) }

pub fn BiostructtertiaryNode::max(self : BiostructtertiaryNode) -> Double { @_common.max(self.data) }

pub fn BiostructtertiaryNode::to_string(self : BiostructtertiaryNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructtertiaryEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_tertiary_edge_make(size : Int) -> BiostructtertiaryEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructtertiaryEdge::len(self : BiostructtertiaryEdge) -> Int { self.size }

pub fn BiostructtertiaryEdge::get(self : BiostructtertiaryEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructtertiaryEdge::set(self : BiostructtertiaryEdge, i : Int, v : Double) -> BiostructtertiaryEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryEdge::sum(self : BiostructtertiaryEdge) -> Double { @_common.sum(self.data) }

pub fn BiostructtertiaryEdge::mean(self : BiostructtertiaryEdge) -> Double { @_common.mean(self.data) }

pub fn BiostructtertiaryEdge::scale(self : BiostructtertiaryEdge, f : Double) -> BiostructtertiaryEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryEdge::add(self : BiostructtertiaryEdge, other : BiostructtertiaryEdge) -> BiostructtertiaryEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructtertiaryEdge::copy(self : BiostructtertiaryEdge) -> BiostructtertiaryEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryEdge::fill(self : BiostructtertiaryEdge, v : Double) -> BiostructtertiaryEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryEdge::min(self : BiostructtertiaryEdge) -> Double { @_common.min(self.data) }

pub fn BiostructtertiaryEdge::max(self : BiostructtertiaryEdge) -> Double { @_common.max(self.data) }

pub fn BiostructtertiaryEdge::to_string(self : BiostructtertiaryEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructtertiaryPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_tertiary_path_make(size : Int) -> BiostructtertiaryPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructtertiaryPath::len(self : BiostructtertiaryPath) -> Int { self.size }

pub fn BiostructtertiaryPath::get(self : BiostructtertiaryPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructtertiaryPath::set(self : BiostructtertiaryPath, i : Int, v : Double) -> BiostructtertiaryPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryPath::sum(self : BiostructtertiaryPath) -> Double { @_common.sum(self.data) }

pub fn BiostructtertiaryPath::mean(self : BiostructtertiaryPath) -> Double { @_common.mean(self.data) }

pub fn BiostructtertiaryPath::scale(self : BiostructtertiaryPath, f : Double) -> BiostructtertiaryPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryPath::add(self : BiostructtertiaryPath, other : BiostructtertiaryPath) -> BiostructtertiaryPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructtertiaryPath::copy(self : BiostructtertiaryPath) -> BiostructtertiaryPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryPath::fill(self : BiostructtertiaryPath, v : Double) -> BiostructtertiaryPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryPath::min(self : BiostructtertiaryPath) -> Double { @_common.min(self.data) }

pub fn BiostructtertiaryPath::max(self : BiostructtertiaryPath) -> Double { @_common.max(self.data) }

pub fn BiostructtertiaryPath::to_string(self : BiostructtertiaryPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructtertiaryCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_tertiary_cluster_make(size : Int) -> BiostructtertiaryCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructtertiaryCluster::len(self : BiostructtertiaryCluster) -> Int { self.size }

pub fn BiostructtertiaryCluster::get(self : BiostructtertiaryCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructtertiaryCluster::set(self : BiostructtertiaryCluster, i : Int, v : Double) -> BiostructtertiaryCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryCluster::sum(self : BiostructtertiaryCluster) -> Double { @_common.sum(self.data) }

pub fn BiostructtertiaryCluster::mean(self : BiostructtertiaryCluster) -> Double { @_common.mean(self.data) }

pub fn BiostructtertiaryCluster::scale(self : BiostructtertiaryCluster, f : Double) -> BiostructtertiaryCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryCluster::add(self : BiostructtertiaryCluster, other : BiostructtertiaryCluster) -> BiostructtertiaryCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructtertiaryCluster::copy(self : BiostructtertiaryCluster) -> BiostructtertiaryCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryCluster::fill(self : BiostructtertiaryCluster, v : Double) -> BiostructtertiaryCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryCluster::min(self : BiostructtertiaryCluster) -> Double { @_common.min(self.data) }

pub fn BiostructtertiaryCluster::max(self : BiostructtertiaryCluster) -> Double { @_common.max(self.data) }

pub fn BiostructtertiaryCluster::to_string(self : BiostructtertiaryCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructtertiaryModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_tertiary_model_make(size : Int) -> BiostructtertiaryModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructtertiaryModel::len(self : BiostructtertiaryModel) -> Int { self.size }

pub fn BiostructtertiaryModel::get(self : BiostructtertiaryModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructtertiaryModel::set(self : BiostructtertiaryModel, i : Int, v : Double) -> BiostructtertiaryModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryModel::sum(self : BiostructtertiaryModel) -> Double { @_common.sum(self.data) }

pub fn BiostructtertiaryModel::mean(self : BiostructtertiaryModel) -> Double { @_common.mean(self.data) }

pub fn BiostructtertiaryModel::scale(self : BiostructtertiaryModel, f : Double) -> BiostructtertiaryModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryModel::add(self : BiostructtertiaryModel, other : BiostructtertiaryModel) -> BiostructtertiaryModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructtertiaryModel::copy(self : BiostructtertiaryModel) -> BiostructtertiaryModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryModel::fill(self : BiostructtertiaryModel, v : Double) -> BiostructtertiaryModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryModel::min(self : BiostructtertiaryModel) -> Double { @_common.min(self.data) }

pub fn BiostructtertiaryModel::max(self : BiostructtertiaryModel) -> Double { @_common.max(self.data) }

pub fn BiostructtertiaryModel::to_string(self : BiostructtertiaryModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructtertiaryLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_tertiary_layer_make(size : Int) -> BiostructtertiaryLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructtertiaryLayer::len(self : BiostructtertiaryLayer) -> Int { self.size }

pub fn BiostructtertiaryLayer::get(self : BiostructtertiaryLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructtertiaryLayer::set(self : BiostructtertiaryLayer, i : Int, v : Double) -> BiostructtertiaryLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryLayer::sum(self : BiostructtertiaryLayer) -> Double { @_common.sum(self.data) }

pub fn BiostructtertiaryLayer::mean(self : BiostructtertiaryLayer) -> Double { @_common.mean(self.data) }

pub fn BiostructtertiaryLayer::scale(self : BiostructtertiaryLayer, f : Double) -> BiostructtertiaryLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryLayer::add(self : BiostructtertiaryLayer, other : BiostructtertiaryLayer) -> BiostructtertiaryLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructtertiaryLayer::copy(self : BiostructtertiaryLayer) -> BiostructtertiaryLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryLayer::fill(self : BiostructtertiaryLayer, v : Double) -> BiostructtertiaryLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryLayer::min(self : BiostructtertiaryLayer) -> Double { @_common.min(self.data) }

pub fn BiostructtertiaryLayer::max(self : BiostructtertiaryLayer) -> Double { @_common.max(self.data) }

pub fn BiostructtertiaryLayer::to_string(self : BiostructtertiaryLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructtertiaryBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_tertiary_buffer_make(size : Int) -> BiostructtertiaryBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructtertiaryBuffer::len(self : BiostructtertiaryBuffer) -> Int { self.size }

pub fn BiostructtertiaryBuffer::get(self : BiostructtertiaryBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructtertiaryBuffer::set(self : BiostructtertiaryBuffer, i : Int, v : Double) -> BiostructtertiaryBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryBuffer::sum(self : BiostructtertiaryBuffer) -> Double { @_common.sum(self.data) }

pub fn BiostructtertiaryBuffer::mean(self : BiostructtertiaryBuffer) -> Double { @_common.mean(self.data) }

pub fn BiostructtertiaryBuffer::scale(self : BiostructtertiaryBuffer, f : Double) -> BiostructtertiaryBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryBuffer::add(self : BiostructtertiaryBuffer, other : BiostructtertiaryBuffer) -> BiostructtertiaryBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructtertiaryBuffer::copy(self : BiostructtertiaryBuffer) -> BiostructtertiaryBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryBuffer::fill(self : BiostructtertiaryBuffer, v : Double) -> BiostructtertiaryBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryBuffer::min(self : BiostructtertiaryBuffer) -> Double { @_common.min(self.data) }

pub fn BiostructtertiaryBuffer::max(self : BiostructtertiaryBuffer) -> Double { @_common.max(self.data) }

pub fn BiostructtertiaryBuffer::to_string(self : BiostructtertiaryBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructtertiaryCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_tertiary_cursor_make(size : Int) -> BiostructtertiaryCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructtertiaryCursor::len(self : BiostructtertiaryCursor) -> Int { self.size }

pub fn BiostructtertiaryCursor::get(self : BiostructtertiaryCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructtertiaryCursor::set(self : BiostructtertiaryCursor, i : Int, v : Double) -> BiostructtertiaryCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryCursor::sum(self : BiostructtertiaryCursor) -> Double { @_common.sum(self.data) }

pub fn BiostructtertiaryCursor::mean(self : BiostructtertiaryCursor) -> Double { @_common.mean(self.data) }

pub fn BiostructtertiaryCursor::scale(self : BiostructtertiaryCursor, f : Double) -> BiostructtertiaryCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryCursor::add(self : BiostructtertiaryCursor, other : BiostructtertiaryCursor) -> BiostructtertiaryCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructtertiaryCursor::copy(self : BiostructtertiaryCursor) -> BiostructtertiaryCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryCursor::fill(self : BiostructtertiaryCursor, v : Double) -> BiostructtertiaryCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryCursor::min(self : BiostructtertiaryCursor) -> Double { @_common.min(self.data) }

pub fn BiostructtertiaryCursor::max(self : BiostructtertiaryCursor) -> Double { @_common.max(self.data) }

pub fn BiostructtertiaryCursor::to_string(self : BiostructtertiaryCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructtertiaryView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_tertiary_view_make(size : Int) -> BiostructtertiaryView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructtertiaryView::len(self : BiostructtertiaryView) -> Int { self.size }

pub fn BiostructtertiaryView::get(self : BiostructtertiaryView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructtertiaryView::set(self : BiostructtertiaryView, i : Int, v : Double) -> BiostructtertiaryView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryView::sum(self : BiostructtertiaryView) -> Double { @_common.sum(self.data) }

pub fn BiostructtertiaryView::mean(self : BiostructtertiaryView) -> Double { @_common.mean(self.data) }

pub fn BiostructtertiaryView::scale(self : BiostructtertiaryView, f : Double) -> BiostructtertiaryView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryView::add(self : BiostructtertiaryView, other : BiostructtertiaryView) -> BiostructtertiaryView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructtertiaryView::copy(self : BiostructtertiaryView) -> BiostructtertiaryView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryView::fill(self : BiostructtertiaryView, v : Double) -> BiostructtertiaryView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryView::min(self : BiostructtertiaryView) -> Double { @_common.min(self.data) }

pub fn BiostructtertiaryView::max(self : BiostructtertiaryView) -> Double { @_common.max(self.data) }

pub fn BiostructtertiaryView::to_string(self : BiostructtertiaryView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructtertiaryRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_tertiary_range_make(size : Int) -> BiostructtertiaryRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructtertiaryRange::len(self : BiostructtertiaryRange) -> Int { self.size }

pub fn BiostructtertiaryRange::get(self : BiostructtertiaryRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructtertiaryRange::set(self : BiostructtertiaryRange, i : Int, v : Double) -> BiostructtertiaryRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryRange::sum(self : BiostructtertiaryRange) -> Double { @_common.sum(self.data) }

pub fn BiostructtertiaryRange::mean(self : BiostructtertiaryRange) -> Double { @_common.mean(self.data) }

pub fn BiostructtertiaryRange::scale(self : BiostructtertiaryRange, f : Double) -> BiostructtertiaryRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryRange::add(self : BiostructtertiaryRange, other : BiostructtertiaryRange) -> BiostructtertiaryRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructtertiaryRange::copy(self : BiostructtertiaryRange) -> BiostructtertiaryRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryRange::fill(self : BiostructtertiaryRange, v : Double) -> BiostructtertiaryRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructtertiaryRange::min(self : BiostructtertiaryRange) -> Double { @_common.min(self.data) }

pub fn BiostructtertiaryRange::max(self : BiostructtertiaryRange) -> Double { @_common.max(self.data) }

pub fn BiostructtertiaryRange::to_string(self : BiostructtertiaryRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructtertiarySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_tertiary_slice_make(size : Int) -> BiostructtertiarySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructtertiarySlice::len(self : BiostructtertiarySlice) -> Int { self.size }

pub fn BiostructtertiarySlice::get(self : BiostructtertiarySlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructtertiarySlice::set(self : BiostructtertiarySlice, i : Int, v : Double) -> BiostructtertiarySlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructtertiarySlice::sum(self : BiostructtertiarySlice) -> Double { @_common.sum(self.data) }

pub fn BiostructtertiarySlice::mean(self : BiostructtertiarySlice) -> Double { @_common.mean(self.data) }

pub fn BiostructtertiarySlice::scale(self : BiostructtertiarySlice, f : Double) -> BiostructtertiarySlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructtertiarySlice::add(self : BiostructtertiarySlice, other : BiostructtertiarySlice) -> BiostructtertiarySlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructtertiarySlice::copy(self : BiostructtertiarySlice) -> BiostructtertiarySlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructtertiarySlice::fill(self : BiostructtertiarySlice, v : Double) -> BiostructtertiarySlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructtertiarySlice::min(self : BiostructtertiarySlice) -> Double { @_common.min(self.data) }

pub fn BiostructtertiarySlice::max(self : BiostructtertiarySlice) -> Double { @_common.max(self.data) }

pub fn BiostructtertiarySlice::to_string(self : BiostructtertiarySlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

