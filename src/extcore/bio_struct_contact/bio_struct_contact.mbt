///===
/// extcore/bio_struct_contact

pub(all) struct BiostructcontactPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_struct_contact_make_point(x : Double, y : Double) -> BiostructcontactPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_struct_contact_make_point3(x : Double, y : Double, z : Double) -> BiostructcontactPoint {
  { x, y, z, label: 0 }
}

pub fn BiostructcontactPoint::x(self : BiostructcontactPoint) -> Double { self.x }

pub fn BiostructcontactPoint::y(self : BiostructcontactPoint) -> Double { self.y }

pub fn BiostructcontactPoint::z(self : BiostructcontactPoint) -> Double { self.z }

pub fn BiostructcontactPoint::label(self : BiostructcontactPoint) -> Int { self.label }

pub fn BiostructcontactPoint::dist(self : BiostructcontactPoint, other : BiostructcontactPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BiostructcontactPoint::add(self : BiostructcontactPoint, other : BiostructcontactPoint) -> BiostructcontactPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BiostructcontactPoint::sub(self : BiostructcontactPoint, other : BiostructcontactPoint) -> BiostructcontactPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BiostructcontactPoint::scale(self : BiostructcontactPoint, s : Double) -> BiostructcontactPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BiostructcontactPoint::dot(self : BiostructcontactPoint, other : BiostructcontactPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BiostructcontactPoint::cross(self : BiostructcontactPoint, other : BiostructcontactPoint) -> BiostructcontactPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BiostructcontactPoint::norm(self : BiostructcontactPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BiostructcontactPoint::normalize(self : BiostructcontactPoint) -> BiostructcontactPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiostructcontactPoint::negate(self : BiostructcontactPoint) -> BiostructcontactPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BiostructcontactPoint::mid(self : BiostructcontactPoint, other : BiostructcontactPoint) -> BiostructcontactPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BiostructcontactPoint::lerp(self : BiostructcontactPoint, other : BiostructcontactPoint, t : Double) -> BiostructcontactPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BiostructcontactPoint::to_string(self : BiostructcontactPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BiostructcontactSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_struct_contact_make_series(vals : Array[Double], name : String) -> BiostructcontactSeries {
  { vals, name, meta: 0 }
}

pub fn BiostructcontactSeries::len(self : BiostructcontactSeries) -> Int { self.vals.length() }

pub fn BiostructcontactSeries::sum(self : BiostructcontactSeries) -> Double { @_common.sum(self.vals) }

pub fn BiostructcontactSeries::mean(self : BiostructcontactSeries) -> Double { @_common.mean(self.vals) }

pub fn BiostructcontactSeries::min(self : BiostructcontactSeries) -> Double { @_common.min(self.vals) }

pub fn BiostructcontactSeries::max(self : BiostructcontactSeries) -> Double { @_common.max(self.vals) }

pub fn BiostructcontactSeries::range(self : BiostructcontactSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BiostructcontactSeries::variance(self : BiostructcontactSeries) -> Double { @_common.variance(self.vals) }

pub fn BiostructcontactSeries::std(self : BiostructcontactSeries) -> Double { @_common.std(self.vals) }

pub fn BiostructcontactSeries::median(self : BiostructcontactSeries) -> Double { @_common.median(self.vals) }

pub fn BiostructcontactSeries::scale(self : BiostructcontactSeries, f : Double) -> BiostructcontactSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BiostructcontactSeries::add(self : BiostructcontactSeries, other : BiostructcontactSeries) -> BiostructcontactSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BiostructcontactSeries::sub(self : BiostructcontactSeries, other : BiostructcontactSeries) -> BiostructcontactSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BiostructcontactSeries::normalize(self : BiostructcontactSeries) -> BiostructcontactSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BiostructcontactSeries::cumsum(self : BiostructcontactSeries) -> BiostructcontactSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BiostructcontactSeries::to_string(self : BiostructcontactSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiostructcontactMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_struct_contact_make_matrix(rows : Int, cols : Int, val : Double) -> BiostructcontactMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn bio_struct_contact_matrix_identity(n : Int) -> BiostructcontactMatrix {
  let m = bio_struct_contact_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BiostructcontactMatrix::get(self : BiostructcontactMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BiostructcontactMatrix::transpose(self : BiostructcontactMatrix) -> BiostructcontactMatrix {
  let result = bio_struct_contact_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BiostructcontactMatrix::add(self : BiostructcontactMatrix, other : BiostructcontactMatrix) -> BiostructcontactMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_struct_contact_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BiostructcontactMatrix::scale(self : BiostructcontactMatrix, s : Double) -> BiostructcontactMatrix {
  let result = bio_struct_contact_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BiostructcontactMatrix::multiply(self : BiostructcontactMatrix, other : BiostructcontactMatrix) -> BiostructcontactMatrix {
  if self.cols != other.rows { return bio_struct_contact_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_struct_contact_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn BiostructcontactMatrix::trace(self : BiostructcontactMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BiostructcontactMatrix::det(self : BiostructcontactMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BiostructcontactMatrix::norm(self : BiostructcontactMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BiostructcontactMatrix::to_string(self : BiostructcontactMatrix) -> String {
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

pub(all) struct BiostructcontactVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_struct_contact_make_vector(comps : Array[Double]) -> BiostructcontactVector {
  { comps, dim: comps.length() }
}

pub fn bio_struct_contact_vector_zero(dim : Int) -> BiostructcontactVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BiostructcontactVector::add(self : BiostructcontactVector, other : BiostructcontactVector) -> BiostructcontactVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BiostructcontactVector::sub(self : BiostructcontactVector, other : BiostructcontactVector) -> BiostructcontactVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BiostructcontactVector::scale(self : BiostructcontactVector, s : Double) -> BiostructcontactVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BiostructcontactVector::dot(self : BiostructcontactVector, other : BiostructcontactVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BiostructcontactVector::norm(self : BiostructcontactVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BiostructcontactVector::normalize(self : BiostructcontactVector) -> BiostructcontactVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiostructcontactVector::dist(self : BiostructcontactVector, other : BiostructcontactVector) -> Double {
  self.sub(other).norm()
}

pub fn BiostructcontactVector::to_string(self : BiostructcontactVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiostructcontactFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_contact_frame_make(size : Int) -> BiostructcontactFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructcontactFrame::len(self : BiostructcontactFrame) -> Int { self.size }

pub fn BiostructcontactFrame::get(self : BiostructcontactFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructcontactFrame::set(self : BiostructcontactFrame, i : Int, v : Double) -> BiostructcontactFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructcontactFrame::sum(self : BiostructcontactFrame) -> Double { @_common.sum(self.data) }

pub fn BiostructcontactFrame::mean(self : BiostructcontactFrame) -> Double { @_common.mean(self.data) }

pub fn BiostructcontactFrame::scale(self : BiostructcontactFrame, f : Double) -> BiostructcontactFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructcontactFrame::add(self : BiostructcontactFrame, other : BiostructcontactFrame) -> BiostructcontactFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructcontactFrame::copy(self : BiostructcontactFrame) -> BiostructcontactFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructcontactFrame::fill(self : BiostructcontactFrame, v : Double) -> BiostructcontactFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructcontactFrame::min(self : BiostructcontactFrame) -> Double { @_common.min(self.data) }

pub fn BiostructcontactFrame::max(self : BiostructcontactFrame) -> Double { @_common.max(self.data) }

pub fn BiostructcontactFrame::to_string(self : BiostructcontactFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructcontactTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_contact_table_make(size : Int) -> BiostructcontactTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructcontactTable::len(self : BiostructcontactTable) -> Int { self.size }

pub fn BiostructcontactTable::get(self : BiostructcontactTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructcontactTable::set(self : BiostructcontactTable, i : Int, v : Double) -> BiostructcontactTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructcontactTable::sum(self : BiostructcontactTable) -> Double { @_common.sum(self.data) }

pub fn BiostructcontactTable::mean(self : BiostructcontactTable) -> Double { @_common.mean(self.data) }

pub fn BiostructcontactTable::scale(self : BiostructcontactTable, f : Double) -> BiostructcontactTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructcontactTable::add(self : BiostructcontactTable, other : BiostructcontactTable) -> BiostructcontactTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructcontactTable::copy(self : BiostructcontactTable) -> BiostructcontactTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructcontactTable::fill(self : BiostructcontactTable, v : Double) -> BiostructcontactTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructcontactTable::min(self : BiostructcontactTable) -> Double { @_common.min(self.data) }

pub fn BiostructcontactTable::max(self : BiostructcontactTable) -> Double { @_common.max(self.data) }

pub fn BiostructcontactTable::to_string(self : BiostructcontactTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructcontactGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_contact_graphn_make(size : Int) -> BiostructcontactGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructcontactGraphN::len(self : BiostructcontactGraphN) -> Int { self.size }

pub fn BiostructcontactGraphN::get(self : BiostructcontactGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructcontactGraphN::set(self : BiostructcontactGraphN, i : Int, v : Double) -> BiostructcontactGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructcontactGraphN::sum(self : BiostructcontactGraphN) -> Double { @_common.sum(self.data) }

pub fn BiostructcontactGraphN::mean(self : BiostructcontactGraphN) -> Double { @_common.mean(self.data) }

pub fn BiostructcontactGraphN::scale(self : BiostructcontactGraphN, f : Double) -> BiostructcontactGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructcontactGraphN::add(self : BiostructcontactGraphN, other : BiostructcontactGraphN) -> BiostructcontactGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructcontactGraphN::copy(self : BiostructcontactGraphN) -> BiostructcontactGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructcontactGraphN::fill(self : BiostructcontactGraphN, v : Double) -> BiostructcontactGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructcontactGraphN::min(self : BiostructcontactGraphN) -> Double { @_common.min(self.data) }

pub fn BiostructcontactGraphN::max(self : BiostructcontactGraphN) -> Double { @_common.max(self.data) }

pub fn BiostructcontactGraphN::to_string(self : BiostructcontactGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructcontactNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_contact_node_make(size : Int) -> BiostructcontactNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructcontactNode::len(self : BiostructcontactNode) -> Int { self.size }

pub fn BiostructcontactNode::get(self : BiostructcontactNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructcontactNode::set(self : BiostructcontactNode, i : Int, v : Double) -> BiostructcontactNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructcontactNode::sum(self : BiostructcontactNode) -> Double { @_common.sum(self.data) }

pub fn BiostructcontactNode::mean(self : BiostructcontactNode) -> Double { @_common.mean(self.data) }

pub fn BiostructcontactNode::scale(self : BiostructcontactNode, f : Double) -> BiostructcontactNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructcontactNode::add(self : BiostructcontactNode, other : BiostructcontactNode) -> BiostructcontactNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructcontactNode::copy(self : BiostructcontactNode) -> BiostructcontactNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructcontactNode::fill(self : BiostructcontactNode, v : Double) -> BiostructcontactNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructcontactNode::min(self : BiostructcontactNode) -> Double { @_common.min(self.data) }

pub fn BiostructcontactNode::max(self : BiostructcontactNode) -> Double { @_common.max(self.data) }

pub fn BiostructcontactNode::to_string(self : BiostructcontactNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructcontactEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_contact_edge_make(size : Int) -> BiostructcontactEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructcontactEdge::len(self : BiostructcontactEdge) -> Int { self.size }

pub fn BiostructcontactEdge::get(self : BiostructcontactEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructcontactEdge::set(self : BiostructcontactEdge, i : Int, v : Double) -> BiostructcontactEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructcontactEdge::sum(self : BiostructcontactEdge) -> Double { @_common.sum(self.data) }

pub fn BiostructcontactEdge::mean(self : BiostructcontactEdge) -> Double { @_common.mean(self.data) }

pub fn BiostructcontactEdge::scale(self : BiostructcontactEdge, f : Double) -> BiostructcontactEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructcontactEdge::add(self : BiostructcontactEdge, other : BiostructcontactEdge) -> BiostructcontactEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructcontactEdge::copy(self : BiostructcontactEdge) -> BiostructcontactEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructcontactEdge::fill(self : BiostructcontactEdge, v : Double) -> BiostructcontactEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructcontactEdge::min(self : BiostructcontactEdge) -> Double { @_common.min(self.data) }

pub fn BiostructcontactEdge::max(self : BiostructcontactEdge) -> Double { @_common.max(self.data) }

pub fn BiostructcontactEdge::to_string(self : BiostructcontactEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructcontactPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_contact_path_make(size : Int) -> BiostructcontactPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructcontactPath::len(self : BiostructcontactPath) -> Int { self.size }

pub fn BiostructcontactPath::get(self : BiostructcontactPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructcontactPath::set(self : BiostructcontactPath, i : Int, v : Double) -> BiostructcontactPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructcontactPath::sum(self : BiostructcontactPath) -> Double { @_common.sum(self.data) }

pub fn BiostructcontactPath::mean(self : BiostructcontactPath) -> Double { @_common.mean(self.data) }

pub fn BiostructcontactPath::scale(self : BiostructcontactPath, f : Double) -> BiostructcontactPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructcontactPath::add(self : BiostructcontactPath, other : BiostructcontactPath) -> BiostructcontactPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructcontactPath::copy(self : BiostructcontactPath) -> BiostructcontactPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructcontactPath::fill(self : BiostructcontactPath, v : Double) -> BiostructcontactPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructcontactPath::min(self : BiostructcontactPath) -> Double { @_common.min(self.data) }

pub fn BiostructcontactPath::max(self : BiostructcontactPath) -> Double { @_common.max(self.data) }

pub fn BiostructcontactPath::to_string(self : BiostructcontactPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructcontactCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_contact_cluster_make(size : Int) -> BiostructcontactCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructcontactCluster::len(self : BiostructcontactCluster) -> Int { self.size }

pub fn BiostructcontactCluster::get(self : BiostructcontactCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructcontactCluster::set(self : BiostructcontactCluster, i : Int, v : Double) -> BiostructcontactCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructcontactCluster::sum(self : BiostructcontactCluster) -> Double { @_common.sum(self.data) }

pub fn BiostructcontactCluster::mean(self : BiostructcontactCluster) -> Double { @_common.mean(self.data) }

pub fn BiostructcontactCluster::scale(self : BiostructcontactCluster, f : Double) -> BiostructcontactCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructcontactCluster::add(self : BiostructcontactCluster, other : BiostructcontactCluster) -> BiostructcontactCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructcontactCluster::copy(self : BiostructcontactCluster) -> BiostructcontactCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructcontactCluster::fill(self : BiostructcontactCluster, v : Double) -> BiostructcontactCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructcontactCluster::min(self : BiostructcontactCluster) -> Double { @_common.min(self.data) }

pub fn BiostructcontactCluster::max(self : BiostructcontactCluster) -> Double { @_common.max(self.data) }

pub fn BiostructcontactCluster::to_string(self : BiostructcontactCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructcontactModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_contact_model_make(size : Int) -> BiostructcontactModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructcontactModel::len(self : BiostructcontactModel) -> Int { self.size }

pub fn BiostructcontactModel::get(self : BiostructcontactModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructcontactModel::set(self : BiostructcontactModel, i : Int, v : Double) -> BiostructcontactModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructcontactModel::sum(self : BiostructcontactModel) -> Double { @_common.sum(self.data) }

pub fn BiostructcontactModel::mean(self : BiostructcontactModel) -> Double { @_common.mean(self.data) }

pub fn BiostructcontactModel::scale(self : BiostructcontactModel, f : Double) -> BiostructcontactModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructcontactModel::add(self : BiostructcontactModel, other : BiostructcontactModel) -> BiostructcontactModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructcontactModel::copy(self : BiostructcontactModel) -> BiostructcontactModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructcontactModel::fill(self : BiostructcontactModel, v : Double) -> BiostructcontactModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructcontactModel::min(self : BiostructcontactModel) -> Double { @_common.min(self.data) }

pub fn BiostructcontactModel::max(self : BiostructcontactModel) -> Double { @_common.max(self.data) }

pub fn BiostructcontactModel::to_string(self : BiostructcontactModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructcontactLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_contact_layer_make(size : Int) -> BiostructcontactLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructcontactLayer::len(self : BiostructcontactLayer) -> Int { self.size }

pub fn BiostructcontactLayer::get(self : BiostructcontactLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructcontactLayer::set(self : BiostructcontactLayer, i : Int, v : Double) -> BiostructcontactLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructcontactLayer::sum(self : BiostructcontactLayer) -> Double { @_common.sum(self.data) }

pub fn BiostructcontactLayer::mean(self : BiostructcontactLayer) -> Double { @_common.mean(self.data) }

pub fn BiostructcontactLayer::scale(self : BiostructcontactLayer, f : Double) -> BiostructcontactLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructcontactLayer::add(self : BiostructcontactLayer, other : BiostructcontactLayer) -> BiostructcontactLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructcontactLayer::copy(self : BiostructcontactLayer) -> BiostructcontactLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructcontactLayer::fill(self : BiostructcontactLayer, v : Double) -> BiostructcontactLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructcontactLayer::min(self : BiostructcontactLayer) -> Double { @_common.min(self.data) }

pub fn BiostructcontactLayer::max(self : BiostructcontactLayer) -> Double { @_common.max(self.data) }

pub fn BiostructcontactLayer::to_string(self : BiostructcontactLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructcontactBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_contact_buffer_make(size : Int) -> BiostructcontactBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructcontactBuffer::len(self : BiostructcontactBuffer) -> Int { self.size }

pub fn BiostructcontactBuffer::get(self : BiostructcontactBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructcontactBuffer::set(self : BiostructcontactBuffer, i : Int, v : Double) -> BiostructcontactBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructcontactBuffer::sum(self : BiostructcontactBuffer) -> Double { @_common.sum(self.data) }

pub fn BiostructcontactBuffer::mean(self : BiostructcontactBuffer) -> Double { @_common.mean(self.data) }

pub fn BiostructcontactBuffer::scale(self : BiostructcontactBuffer, f : Double) -> BiostructcontactBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructcontactBuffer::add(self : BiostructcontactBuffer, other : BiostructcontactBuffer) -> BiostructcontactBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructcontactBuffer::copy(self : BiostructcontactBuffer) -> BiostructcontactBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructcontactBuffer::fill(self : BiostructcontactBuffer, v : Double) -> BiostructcontactBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructcontactBuffer::min(self : BiostructcontactBuffer) -> Double { @_common.min(self.data) }

pub fn BiostructcontactBuffer::max(self : BiostructcontactBuffer) -> Double { @_common.max(self.data) }

pub fn BiostructcontactBuffer::to_string(self : BiostructcontactBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructcontactCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_contact_cursor_make(size : Int) -> BiostructcontactCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructcontactCursor::len(self : BiostructcontactCursor) -> Int { self.size }

pub fn BiostructcontactCursor::get(self : BiostructcontactCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructcontactCursor::set(self : BiostructcontactCursor, i : Int, v : Double) -> BiostructcontactCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructcontactCursor::sum(self : BiostructcontactCursor) -> Double { @_common.sum(self.data) }

pub fn BiostructcontactCursor::mean(self : BiostructcontactCursor) -> Double { @_common.mean(self.data) }

pub fn BiostructcontactCursor::scale(self : BiostructcontactCursor, f : Double) -> BiostructcontactCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructcontactCursor::add(self : BiostructcontactCursor, other : BiostructcontactCursor) -> BiostructcontactCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructcontactCursor::copy(self : BiostructcontactCursor) -> BiostructcontactCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructcontactCursor::fill(self : BiostructcontactCursor, v : Double) -> BiostructcontactCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructcontactCursor::min(self : BiostructcontactCursor) -> Double { @_common.min(self.data) }

pub fn BiostructcontactCursor::max(self : BiostructcontactCursor) -> Double { @_common.max(self.data) }

pub fn BiostructcontactCursor::to_string(self : BiostructcontactCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructcontactView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_contact_view_make(size : Int) -> BiostructcontactView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructcontactView::len(self : BiostructcontactView) -> Int { self.size }

pub fn BiostructcontactView::get(self : BiostructcontactView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructcontactView::set(self : BiostructcontactView, i : Int, v : Double) -> BiostructcontactView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructcontactView::sum(self : BiostructcontactView) -> Double { @_common.sum(self.data) }

pub fn BiostructcontactView::mean(self : BiostructcontactView) -> Double { @_common.mean(self.data) }

pub fn BiostructcontactView::scale(self : BiostructcontactView, f : Double) -> BiostructcontactView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructcontactView::add(self : BiostructcontactView, other : BiostructcontactView) -> BiostructcontactView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructcontactView::copy(self : BiostructcontactView) -> BiostructcontactView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructcontactView::fill(self : BiostructcontactView, v : Double) -> BiostructcontactView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructcontactView::min(self : BiostructcontactView) -> Double { @_common.min(self.data) }

pub fn BiostructcontactView::max(self : BiostructcontactView) -> Double { @_common.max(self.data) }

pub fn BiostructcontactView::to_string(self : BiostructcontactView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructcontactRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_contact_range_make(size : Int) -> BiostructcontactRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructcontactRange::len(self : BiostructcontactRange) -> Int { self.size }

pub fn BiostructcontactRange::get(self : BiostructcontactRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructcontactRange::set(self : BiostructcontactRange, i : Int, v : Double) -> BiostructcontactRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructcontactRange::sum(self : BiostructcontactRange) -> Double { @_common.sum(self.data) }

pub fn BiostructcontactRange::mean(self : BiostructcontactRange) -> Double { @_common.mean(self.data) }

pub fn BiostructcontactRange::scale(self : BiostructcontactRange, f : Double) -> BiostructcontactRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructcontactRange::add(self : BiostructcontactRange, other : BiostructcontactRange) -> BiostructcontactRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructcontactRange::copy(self : BiostructcontactRange) -> BiostructcontactRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructcontactRange::fill(self : BiostructcontactRange, v : Double) -> BiostructcontactRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructcontactRange::min(self : BiostructcontactRange) -> Double { @_common.min(self.data) }

pub fn BiostructcontactRange::max(self : BiostructcontactRange) -> Double { @_common.max(self.data) }

pub fn BiostructcontactRange::to_string(self : BiostructcontactRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructcontactSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_contact_slice_make(size : Int) -> BiostructcontactSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructcontactSlice::len(self : BiostructcontactSlice) -> Int { self.size }

pub fn BiostructcontactSlice::get(self : BiostructcontactSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructcontactSlice::set(self : BiostructcontactSlice, i : Int, v : Double) -> BiostructcontactSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructcontactSlice::sum(self : BiostructcontactSlice) -> Double { @_common.sum(self.data) }

pub fn BiostructcontactSlice::mean(self : BiostructcontactSlice) -> Double { @_common.mean(self.data) }

pub fn BiostructcontactSlice::scale(self : BiostructcontactSlice, f : Double) -> BiostructcontactSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructcontactSlice::add(self : BiostructcontactSlice, other : BiostructcontactSlice) -> BiostructcontactSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructcontactSlice::copy(self : BiostructcontactSlice) -> BiostructcontactSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructcontactSlice::fill(self : BiostructcontactSlice, v : Double) -> BiostructcontactSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructcontactSlice::min(self : BiostructcontactSlice) -> Double { @_common.min(self.data) }

pub fn BiostructcontactSlice::max(self : BiostructcontactSlice) -> Double { @_common.max(self.data) }

pub fn BiostructcontactSlice::to_string(self : BiostructcontactSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

