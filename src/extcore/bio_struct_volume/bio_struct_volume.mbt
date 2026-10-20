///===
/// extcore/bio_struct_volume

pub(all) struct BiostructvolumePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_struct_volume_make_point(x : Double, y : Double) -> BiostructvolumePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_struct_volume_make_point3(x : Double, y : Double, z : Double) -> BiostructvolumePoint {
  { x, y, z, label: 0 }
}

pub fn BiostructvolumePoint::x(self : BiostructvolumePoint) -> Double { self.x }

pub fn BiostructvolumePoint::y(self : BiostructvolumePoint) -> Double { self.y }

pub fn BiostructvolumePoint::z(self : BiostructvolumePoint) -> Double { self.z }

pub fn BiostructvolumePoint::label(self : BiostructvolumePoint) -> Int { self.label }

pub fn BiostructvolumePoint::dist(self : BiostructvolumePoint, other : BiostructvolumePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BiostructvolumePoint::add(self : BiostructvolumePoint, other : BiostructvolumePoint) -> BiostructvolumePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BiostructvolumePoint::sub(self : BiostructvolumePoint, other : BiostructvolumePoint) -> BiostructvolumePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BiostructvolumePoint::scale(self : BiostructvolumePoint, s : Double) -> BiostructvolumePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BiostructvolumePoint::dot(self : BiostructvolumePoint, other : BiostructvolumePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BiostructvolumePoint::cross(self : BiostructvolumePoint, other : BiostructvolumePoint) -> BiostructvolumePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BiostructvolumePoint::norm(self : BiostructvolumePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BiostructvolumePoint::normalize(self : BiostructvolumePoint) -> BiostructvolumePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiostructvolumePoint::negate(self : BiostructvolumePoint) -> BiostructvolumePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BiostructvolumePoint::mid(self : BiostructvolumePoint, other : BiostructvolumePoint) -> BiostructvolumePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BiostructvolumePoint::lerp(self : BiostructvolumePoint, other : BiostructvolumePoint, t : Double) -> BiostructvolumePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BiostructvolumePoint::to_string(self : BiostructvolumePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BiostructvolumeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_struct_volume_make_series(vals : Array[Double], name : String) -> BiostructvolumeSeries {
  { vals, name, meta: 0 }
}

pub fn BiostructvolumeSeries::len(self : BiostructvolumeSeries) -> Int { self.vals.length() }

pub fn BiostructvolumeSeries::sum(self : BiostructvolumeSeries) -> Double { @_common.sum(self.vals) }

pub fn BiostructvolumeSeries::mean(self : BiostructvolumeSeries) -> Double { @_common.mean(self.vals) }

pub fn BiostructvolumeSeries::min(self : BiostructvolumeSeries) -> Double { @_common.min(self.vals) }

pub fn BiostructvolumeSeries::max(self : BiostructvolumeSeries) -> Double { @_common.max(self.vals) }

pub fn BiostructvolumeSeries::range(self : BiostructvolumeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BiostructvolumeSeries::variance(self : BiostructvolumeSeries) -> Double { @_common.variance(self.vals) }

pub fn BiostructvolumeSeries::std(self : BiostructvolumeSeries) -> Double { @_common.std(self.vals) }

pub fn BiostructvolumeSeries::median(self : BiostructvolumeSeries) -> Double { @_common.median(self.vals) }

pub fn BiostructvolumeSeries::scale(self : BiostructvolumeSeries, f : Double) -> BiostructvolumeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BiostructvolumeSeries::add(self : BiostructvolumeSeries, other : BiostructvolumeSeries) -> BiostructvolumeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BiostructvolumeSeries::sub(self : BiostructvolumeSeries, other : BiostructvolumeSeries) -> BiostructvolumeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BiostructvolumeSeries::normalize(self : BiostructvolumeSeries) -> BiostructvolumeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BiostructvolumeSeries::cumsum(self : BiostructvolumeSeries) -> BiostructvolumeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BiostructvolumeSeries::to_string(self : BiostructvolumeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiostructvolumeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_struct_volume_make_matrix(rows : Int, cols : Int, val : Double) -> BiostructvolumeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_struct_volume_matrix_identity(n : Int) -> BiostructvolumeMatrix {
  let m = bio_struct_volume_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BiostructvolumeMatrix::get(self : BiostructvolumeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BiostructvolumeMatrix::transpose(self : BiostructvolumeMatrix) -> BiostructvolumeMatrix {
  let result = bio_struct_volume_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BiostructvolumeMatrix::add(self : BiostructvolumeMatrix, other : BiostructvolumeMatrix) -> BiostructvolumeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_struct_volume_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BiostructvolumeMatrix::scale(self : BiostructvolumeMatrix, s : Double) -> BiostructvolumeMatrix {
  let result = bio_struct_volume_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BiostructvolumeMatrix::multiply(self : BiostructvolumeMatrix, other : BiostructvolumeMatrix) -> BiostructvolumeMatrix {
  if self.cols != other.rows { return bio_struct_volume_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_struct_volume_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn BiostructvolumeMatrix::trace(self : BiostructvolumeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BiostructvolumeMatrix::det(self : BiostructvolumeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BiostructvolumeMatrix::norm(self : BiostructvolumeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BiostructvolumeMatrix::to_string(self : BiostructvolumeMatrix) -> String {
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

pub(all) struct BiostructvolumeVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_struct_volume_make_vector(comps : Array[Double]) -> BiostructvolumeVector {
  { comps, dim: comps.length() }
}

pub fn bio_struct_volume_vector_zero(dim : Int) -> BiostructvolumeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BiostructvolumeVector::add(self : BiostructvolumeVector, other : BiostructvolumeVector) -> BiostructvolumeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BiostructvolumeVector::sub(self : BiostructvolumeVector, other : BiostructvolumeVector) -> BiostructvolumeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BiostructvolumeVector::scale(self : BiostructvolumeVector, s : Double) -> BiostructvolumeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BiostructvolumeVector::dot(self : BiostructvolumeVector, other : BiostructvolumeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BiostructvolumeVector::norm(self : BiostructvolumeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BiostructvolumeVector::normalize(self : BiostructvolumeVector) -> BiostructvolumeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiostructvolumeVector::dist(self : BiostructvolumeVector, other : BiostructvolumeVector) -> Double {
  self.sub(other).norm()
}

pub fn BiostructvolumeVector::to_string(self : BiostructvolumeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiostructvolumeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_volume_frame_make(size : Int) -> BiostructvolumeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructvolumeFrame::len(self : BiostructvolumeFrame) -> Int { self.size }

pub fn BiostructvolumeFrame::get(self : BiostructvolumeFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructvolumeFrame::set(self : BiostructvolumeFrame, i : Int, v : Double) -> BiostructvolumeFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructvolumeFrame::sum(self : BiostructvolumeFrame) -> Double { @_common.sum(self.data) }

pub fn BiostructvolumeFrame::mean(self : BiostructvolumeFrame) -> Double { @_common.mean(self.data) }

pub fn BiostructvolumeFrame::scale(self : BiostructvolumeFrame, f : Double) -> BiostructvolumeFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructvolumeFrame::add(self : BiostructvolumeFrame, other : BiostructvolumeFrame) -> BiostructvolumeFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructvolumeFrame::copy(self : BiostructvolumeFrame) -> BiostructvolumeFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructvolumeFrame::fill(self : BiostructvolumeFrame, v : Double) -> BiostructvolumeFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructvolumeFrame::min(self : BiostructvolumeFrame) -> Double { @_common.min(self.data) }

pub fn BiostructvolumeFrame::max(self : BiostructvolumeFrame) -> Double { @_common.max(self.data) }

pub fn BiostructvolumeFrame::to_string(self : BiostructvolumeFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructvolumeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_volume_table_make(size : Int) -> BiostructvolumeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructvolumeTable::len(self : BiostructvolumeTable) -> Int { self.size }

pub fn BiostructvolumeTable::get(self : BiostructvolumeTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructvolumeTable::set(self : BiostructvolumeTable, i : Int, v : Double) -> BiostructvolumeTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructvolumeTable::sum(self : BiostructvolumeTable) -> Double { @_common.sum(self.data) }

pub fn BiostructvolumeTable::mean(self : BiostructvolumeTable) -> Double { @_common.mean(self.data) }

pub fn BiostructvolumeTable::scale(self : BiostructvolumeTable, f : Double) -> BiostructvolumeTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructvolumeTable::add(self : BiostructvolumeTable, other : BiostructvolumeTable) -> BiostructvolumeTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructvolumeTable::copy(self : BiostructvolumeTable) -> BiostructvolumeTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructvolumeTable::fill(self : BiostructvolumeTable, v : Double) -> BiostructvolumeTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructvolumeTable::min(self : BiostructvolumeTable) -> Double { @_common.min(self.data) }

pub fn BiostructvolumeTable::max(self : BiostructvolumeTable) -> Double { @_common.max(self.data) }

pub fn BiostructvolumeTable::to_string(self : BiostructvolumeTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructvolumeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_volume_graphn_make(size : Int) -> BiostructvolumeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructvolumeGraphN::len(self : BiostructvolumeGraphN) -> Int { self.size }

pub fn BiostructvolumeGraphN::get(self : BiostructvolumeGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructvolumeGraphN::set(self : BiostructvolumeGraphN, i : Int, v : Double) -> BiostructvolumeGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructvolumeGraphN::sum(self : BiostructvolumeGraphN) -> Double { @_common.sum(self.data) }

pub fn BiostructvolumeGraphN::mean(self : BiostructvolumeGraphN) -> Double { @_common.mean(self.data) }

pub fn BiostructvolumeGraphN::scale(self : BiostructvolumeGraphN, f : Double) -> BiostructvolumeGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructvolumeGraphN::add(self : BiostructvolumeGraphN, other : BiostructvolumeGraphN) -> BiostructvolumeGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructvolumeGraphN::copy(self : BiostructvolumeGraphN) -> BiostructvolumeGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructvolumeGraphN::fill(self : BiostructvolumeGraphN, v : Double) -> BiostructvolumeGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructvolumeGraphN::min(self : BiostructvolumeGraphN) -> Double { @_common.min(self.data) }

pub fn BiostructvolumeGraphN::max(self : BiostructvolumeGraphN) -> Double { @_common.max(self.data) }

pub fn BiostructvolumeGraphN::to_string(self : BiostructvolumeGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructvolumeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_volume_node_make(size : Int) -> BiostructvolumeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructvolumeNode::len(self : BiostructvolumeNode) -> Int { self.size }

pub fn BiostructvolumeNode::get(self : BiostructvolumeNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructvolumeNode::set(self : BiostructvolumeNode, i : Int, v : Double) -> BiostructvolumeNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructvolumeNode::sum(self : BiostructvolumeNode) -> Double { @_common.sum(self.data) }

pub fn BiostructvolumeNode::mean(self : BiostructvolumeNode) -> Double { @_common.mean(self.data) }

pub fn BiostructvolumeNode::scale(self : BiostructvolumeNode, f : Double) -> BiostructvolumeNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructvolumeNode::add(self : BiostructvolumeNode, other : BiostructvolumeNode) -> BiostructvolumeNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructvolumeNode::copy(self : BiostructvolumeNode) -> BiostructvolumeNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructvolumeNode::fill(self : BiostructvolumeNode, v : Double) -> BiostructvolumeNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructvolumeNode::min(self : BiostructvolumeNode) -> Double { @_common.min(self.data) }

pub fn BiostructvolumeNode::max(self : BiostructvolumeNode) -> Double { @_common.max(self.data) }

pub fn BiostructvolumeNode::to_string(self : BiostructvolumeNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructvolumeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_volume_edge_make(size : Int) -> BiostructvolumeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructvolumeEdge::len(self : BiostructvolumeEdge) -> Int { self.size }

pub fn BiostructvolumeEdge::get(self : BiostructvolumeEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructvolumeEdge::set(self : BiostructvolumeEdge, i : Int, v : Double) -> BiostructvolumeEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructvolumeEdge::sum(self : BiostructvolumeEdge) -> Double { @_common.sum(self.data) }

pub fn BiostructvolumeEdge::mean(self : BiostructvolumeEdge) -> Double { @_common.mean(self.data) }

pub fn BiostructvolumeEdge::scale(self : BiostructvolumeEdge, f : Double) -> BiostructvolumeEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructvolumeEdge::add(self : BiostructvolumeEdge, other : BiostructvolumeEdge) -> BiostructvolumeEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructvolumeEdge::copy(self : BiostructvolumeEdge) -> BiostructvolumeEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructvolumeEdge::fill(self : BiostructvolumeEdge, v : Double) -> BiostructvolumeEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructvolumeEdge::min(self : BiostructvolumeEdge) -> Double { @_common.min(self.data) }

pub fn BiostructvolumeEdge::max(self : BiostructvolumeEdge) -> Double { @_common.max(self.data) }

pub fn BiostructvolumeEdge::to_string(self : BiostructvolumeEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructvolumePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_volume_path_make(size : Int) -> BiostructvolumePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructvolumePath::len(self : BiostructvolumePath) -> Int { self.size }

pub fn BiostructvolumePath::get(self : BiostructvolumePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructvolumePath::set(self : BiostructvolumePath, i : Int, v : Double) -> BiostructvolumePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructvolumePath::sum(self : BiostructvolumePath) -> Double { @_common.sum(self.data) }

pub fn BiostructvolumePath::mean(self : BiostructvolumePath) -> Double { @_common.mean(self.data) }

pub fn BiostructvolumePath::scale(self : BiostructvolumePath, f : Double) -> BiostructvolumePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructvolumePath::add(self : BiostructvolumePath, other : BiostructvolumePath) -> BiostructvolumePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructvolumePath::copy(self : BiostructvolumePath) -> BiostructvolumePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructvolumePath::fill(self : BiostructvolumePath, v : Double) -> BiostructvolumePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructvolumePath::min(self : BiostructvolumePath) -> Double { @_common.min(self.data) }

pub fn BiostructvolumePath::max(self : BiostructvolumePath) -> Double { @_common.max(self.data) }

pub fn BiostructvolumePath::to_string(self : BiostructvolumePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructvolumeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_volume_cluster_make(size : Int) -> BiostructvolumeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructvolumeCluster::len(self : BiostructvolumeCluster) -> Int { self.size }

pub fn BiostructvolumeCluster::get(self : BiostructvolumeCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructvolumeCluster::set(self : BiostructvolumeCluster, i : Int, v : Double) -> BiostructvolumeCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructvolumeCluster::sum(self : BiostructvolumeCluster) -> Double { @_common.sum(self.data) }

pub fn BiostructvolumeCluster::mean(self : BiostructvolumeCluster) -> Double { @_common.mean(self.data) }

pub fn BiostructvolumeCluster::scale(self : BiostructvolumeCluster, f : Double) -> BiostructvolumeCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructvolumeCluster::add(self : BiostructvolumeCluster, other : BiostructvolumeCluster) -> BiostructvolumeCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructvolumeCluster::copy(self : BiostructvolumeCluster) -> BiostructvolumeCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructvolumeCluster::fill(self : BiostructvolumeCluster, v : Double) -> BiostructvolumeCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructvolumeCluster::min(self : BiostructvolumeCluster) -> Double { @_common.min(self.data) }

pub fn BiostructvolumeCluster::max(self : BiostructvolumeCluster) -> Double { @_common.max(self.data) }

pub fn BiostructvolumeCluster::to_string(self : BiostructvolumeCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructvolumeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_volume_model_make(size : Int) -> BiostructvolumeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructvolumeModel::len(self : BiostructvolumeModel) -> Int { self.size }

pub fn BiostructvolumeModel::get(self : BiostructvolumeModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructvolumeModel::set(self : BiostructvolumeModel, i : Int, v : Double) -> BiostructvolumeModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructvolumeModel::sum(self : BiostructvolumeModel) -> Double { @_common.sum(self.data) }

pub fn BiostructvolumeModel::mean(self : BiostructvolumeModel) -> Double { @_common.mean(self.data) }

pub fn BiostructvolumeModel::scale(self : BiostructvolumeModel, f : Double) -> BiostructvolumeModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructvolumeModel::add(self : BiostructvolumeModel, other : BiostructvolumeModel) -> BiostructvolumeModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructvolumeModel::copy(self : BiostructvolumeModel) -> BiostructvolumeModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructvolumeModel::fill(self : BiostructvolumeModel, v : Double) -> BiostructvolumeModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructvolumeModel::min(self : BiostructvolumeModel) -> Double { @_common.min(self.data) }

pub fn BiostructvolumeModel::max(self : BiostructvolumeModel) -> Double { @_common.max(self.data) }

pub fn BiostructvolumeModel::to_string(self : BiostructvolumeModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructvolumeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_volume_layer_make(size : Int) -> BiostructvolumeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructvolumeLayer::len(self : BiostructvolumeLayer) -> Int { self.size }

pub fn BiostructvolumeLayer::get(self : BiostructvolumeLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructvolumeLayer::set(self : BiostructvolumeLayer, i : Int, v : Double) -> BiostructvolumeLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructvolumeLayer::sum(self : BiostructvolumeLayer) -> Double { @_common.sum(self.data) }

pub fn BiostructvolumeLayer::mean(self : BiostructvolumeLayer) -> Double { @_common.mean(self.data) }

pub fn BiostructvolumeLayer::scale(self : BiostructvolumeLayer, f : Double) -> BiostructvolumeLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructvolumeLayer::add(self : BiostructvolumeLayer, other : BiostructvolumeLayer) -> BiostructvolumeLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructvolumeLayer::copy(self : BiostructvolumeLayer) -> BiostructvolumeLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructvolumeLayer::fill(self : BiostructvolumeLayer, v : Double) -> BiostructvolumeLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructvolumeLayer::min(self : BiostructvolumeLayer) -> Double { @_common.min(self.data) }

pub fn BiostructvolumeLayer::max(self : BiostructvolumeLayer) -> Double { @_common.max(self.data) }

pub fn BiostructvolumeLayer::to_string(self : BiostructvolumeLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructvolumeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_volume_buffer_make(size : Int) -> BiostructvolumeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructvolumeBuffer::len(self : BiostructvolumeBuffer) -> Int { self.size }

pub fn BiostructvolumeBuffer::get(self : BiostructvolumeBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructvolumeBuffer::set(self : BiostructvolumeBuffer, i : Int, v : Double) -> BiostructvolumeBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructvolumeBuffer::sum(self : BiostructvolumeBuffer) -> Double { @_common.sum(self.data) }

pub fn BiostructvolumeBuffer::mean(self : BiostructvolumeBuffer) -> Double { @_common.mean(self.data) }

pub fn BiostructvolumeBuffer::scale(self : BiostructvolumeBuffer, f : Double) -> BiostructvolumeBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructvolumeBuffer::add(self : BiostructvolumeBuffer, other : BiostructvolumeBuffer) -> BiostructvolumeBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructvolumeBuffer::copy(self : BiostructvolumeBuffer) -> BiostructvolumeBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructvolumeBuffer::fill(self : BiostructvolumeBuffer, v : Double) -> BiostructvolumeBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructvolumeBuffer::min(self : BiostructvolumeBuffer) -> Double { @_common.min(self.data) }

pub fn BiostructvolumeBuffer::max(self : BiostructvolumeBuffer) -> Double { @_common.max(self.data) }

pub fn BiostructvolumeBuffer::to_string(self : BiostructvolumeBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructvolumeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_volume_cursor_make(size : Int) -> BiostructvolumeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructvolumeCursor::len(self : BiostructvolumeCursor) -> Int { self.size }

pub fn BiostructvolumeCursor::get(self : BiostructvolumeCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructvolumeCursor::set(self : BiostructvolumeCursor, i : Int, v : Double) -> BiostructvolumeCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructvolumeCursor::sum(self : BiostructvolumeCursor) -> Double { @_common.sum(self.data) }

pub fn BiostructvolumeCursor::mean(self : BiostructvolumeCursor) -> Double { @_common.mean(self.data) }

pub fn BiostructvolumeCursor::scale(self : BiostructvolumeCursor, f : Double) -> BiostructvolumeCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructvolumeCursor::add(self : BiostructvolumeCursor, other : BiostructvolumeCursor) -> BiostructvolumeCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructvolumeCursor::copy(self : BiostructvolumeCursor) -> BiostructvolumeCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructvolumeCursor::fill(self : BiostructvolumeCursor, v : Double) -> BiostructvolumeCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructvolumeCursor::min(self : BiostructvolumeCursor) -> Double { @_common.min(self.data) }

pub fn BiostructvolumeCursor::max(self : BiostructvolumeCursor) -> Double { @_common.max(self.data) }

pub fn BiostructvolumeCursor::to_string(self : BiostructvolumeCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructvolumeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_volume_view_make(size : Int) -> BiostructvolumeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructvolumeView::len(self : BiostructvolumeView) -> Int { self.size }

pub fn BiostructvolumeView::get(self : BiostructvolumeView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructvolumeView::set(self : BiostructvolumeView, i : Int, v : Double) -> BiostructvolumeView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructvolumeView::sum(self : BiostructvolumeView) -> Double { @_common.sum(self.data) }

pub fn BiostructvolumeView::mean(self : BiostructvolumeView) -> Double { @_common.mean(self.data) }

pub fn BiostructvolumeView::scale(self : BiostructvolumeView, f : Double) -> BiostructvolumeView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructvolumeView::add(self : BiostructvolumeView, other : BiostructvolumeView) -> BiostructvolumeView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructvolumeView::copy(self : BiostructvolumeView) -> BiostructvolumeView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructvolumeView::fill(self : BiostructvolumeView, v : Double) -> BiostructvolumeView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructvolumeView::min(self : BiostructvolumeView) -> Double { @_common.min(self.data) }

pub fn BiostructvolumeView::max(self : BiostructvolumeView) -> Double { @_common.max(self.data) }

pub fn BiostructvolumeView::to_string(self : BiostructvolumeView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructvolumeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_volume_range_make(size : Int) -> BiostructvolumeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructvolumeRange::len(self : BiostructvolumeRange) -> Int { self.size }

pub fn BiostructvolumeRange::get(self : BiostructvolumeRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructvolumeRange::set(self : BiostructvolumeRange, i : Int, v : Double) -> BiostructvolumeRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructvolumeRange::sum(self : BiostructvolumeRange) -> Double { @_common.sum(self.data) }

pub fn BiostructvolumeRange::mean(self : BiostructvolumeRange) -> Double { @_common.mean(self.data) }

pub fn BiostructvolumeRange::scale(self : BiostructvolumeRange, f : Double) -> BiostructvolumeRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructvolumeRange::add(self : BiostructvolumeRange, other : BiostructvolumeRange) -> BiostructvolumeRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructvolumeRange::copy(self : BiostructvolumeRange) -> BiostructvolumeRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructvolumeRange::fill(self : BiostructvolumeRange, v : Double) -> BiostructvolumeRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructvolumeRange::min(self : BiostructvolumeRange) -> Double { @_common.min(self.data) }

pub fn BiostructvolumeRange::max(self : BiostructvolumeRange) -> Double { @_common.max(self.data) }

pub fn BiostructvolumeRange::to_string(self : BiostructvolumeRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BiostructvolumeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_volume_slice_make(size : Int) -> BiostructvolumeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BiostructvolumeSlice::len(self : BiostructvolumeSlice) -> Int { self.size }

pub fn BiostructvolumeSlice::get(self : BiostructvolumeSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BiostructvolumeSlice::set(self : BiostructvolumeSlice, i : Int, v : Double) -> BiostructvolumeSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BiostructvolumeSlice::sum(self : BiostructvolumeSlice) -> Double { @_common.sum(self.data) }

pub fn BiostructvolumeSlice::mean(self : BiostructvolumeSlice) -> Double { @_common.mean(self.data) }

pub fn BiostructvolumeSlice::scale(self : BiostructvolumeSlice, f : Double) -> BiostructvolumeSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BiostructvolumeSlice::add(self : BiostructvolumeSlice, other : BiostructvolumeSlice) -> BiostructvolumeSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BiostructvolumeSlice::copy(self : BiostructvolumeSlice) -> BiostructvolumeSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BiostructvolumeSlice::fill(self : BiostructvolumeSlice, v : Double) -> BiostructvolumeSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BiostructvolumeSlice::min(self : BiostructvolumeSlice) -> Double { @_common.min(self.data) }

pub fn BiostructvolumeSlice::max(self : BiostructvolumeSlice) -> Double { @_common.max(self.data) }

pub fn BiostructvolumeSlice::to_string(self : BiostructvolumeSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

