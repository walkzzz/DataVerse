///===
/// extcore/ds_heap_pairing

pub(all) struct DsheappairingPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_heap_pairing_make_point(x : Double, y : Double) -> DsheappairingPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_heap_pairing_make_point3(x : Double, y : Double, z : Double) -> DsheappairingPoint {
  { x, y, z, label: 0 }
}

pub fn DsheappairingPoint::x(self : DsheappairingPoint) -> Double { self.x }

pub fn DsheappairingPoint::y(self : DsheappairingPoint) -> Double { self.y }

pub fn DsheappairingPoint::z(self : DsheappairingPoint) -> Double { self.z }

pub fn DsheappairingPoint::label(self : DsheappairingPoint) -> Int { self.label }

pub fn DsheappairingPoint::dist(self : DsheappairingPoint, other : DsheappairingPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DsheappairingPoint::add(self : DsheappairingPoint, other : DsheappairingPoint) -> DsheappairingPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DsheappairingPoint::sub(self : DsheappairingPoint, other : DsheappairingPoint) -> DsheappairingPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DsheappairingPoint::scale(self : DsheappairingPoint, s : Double) -> DsheappairingPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DsheappairingPoint::dot(self : DsheappairingPoint, other : DsheappairingPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DsheappairingPoint::cross(self : DsheappairingPoint, other : DsheappairingPoint) -> DsheappairingPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DsheappairingPoint::norm(self : DsheappairingPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DsheappairingPoint::normalize(self : DsheappairingPoint) -> DsheappairingPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsheappairingPoint::negate(self : DsheappairingPoint) -> DsheappairingPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DsheappairingPoint::mid(self : DsheappairingPoint, other : DsheappairingPoint) -> DsheappairingPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DsheappairingPoint::lerp(self : DsheappairingPoint, other : DsheappairingPoint, t : Double) -> DsheappairingPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DsheappairingPoint::to_string(self : DsheappairingPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DsheappairingSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_heap_pairing_make_series(vals : Array[Double], name : String) -> DsheappairingSeries {
  { vals, name, meta: 0 }
}

pub fn DsheappairingSeries::len(self : DsheappairingSeries) -> Int { self.vals.length() }

pub fn DsheappairingSeries::sum(self : DsheappairingSeries) -> Double { @_common.sum(self.vals) }

pub fn DsheappairingSeries::mean(self : DsheappairingSeries) -> Double { @_common.mean(self.vals) }

pub fn DsheappairingSeries::min(self : DsheappairingSeries) -> Double { @_common.min(self.vals) }

pub fn DsheappairingSeries::max(self : DsheappairingSeries) -> Double { @_common.max(self.vals) }

pub fn DsheappairingSeries::range(self : DsheappairingSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DsheappairingSeries::variance(self : DsheappairingSeries) -> Double { @_common.variance(self.vals) }

pub fn DsheappairingSeries::std(self : DsheappairingSeries) -> Double { @_common.std(self.vals) }

pub fn DsheappairingSeries::median(self : DsheappairingSeries) -> Double { @_common.median(self.vals) }

pub fn DsheappairingSeries::scale(self : DsheappairingSeries, f : Double) -> DsheappairingSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DsheappairingSeries::add(self : DsheappairingSeries, other : DsheappairingSeries) -> DsheappairingSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DsheappairingSeries::sub(self : DsheappairingSeries, other : DsheappairingSeries) -> DsheappairingSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DsheappairingSeries::normalize(self : DsheappairingSeries) -> DsheappairingSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DsheappairingSeries::cumsum(self : DsheappairingSeries) -> DsheappairingSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DsheappairingSeries::to_string(self : DsheappairingSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsheappairingMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_heap_pairing_make_matrix(rows : Int, cols : Int, val : Double) -> DsheappairingMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_heap_pairing_matrix_identity(n : Int) -> DsheappairingMatrix {
  let m = ds_heap_pairing_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DsheappairingMatrix::get(self : DsheappairingMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DsheappairingMatrix::transpose(self : DsheappairingMatrix) -> DsheappairingMatrix {
  let result = ds_heap_pairing_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DsheappairingMatrix::add(self : DsheappairingMatrix, other : DsheappairingMatrix) -> DsheappairingMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_heap_pairing_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DsheappairingMatrix::scale(self : DsheappairingMatrix, s : Double) -> DsheappairingMatrix {
  let result = ds_heap_pairing_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DsheappairingMatrix::multiply(self : DsheappairingMatrix, other : DsheappairingMatrix) -> DsheappairingMatrix {
  if self.cols != other.rows { return ds_heap_pairing_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_heap_pairing_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DsheappairingMatrix::trace(self : DsheappairingMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DsheappairingMatrix::det(self : DsheappairingMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DsheappairingMatrix::norm(self : DsheappairingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DsheappairingMatrix::to_string(self : DsheappairingMatrix) -> String {
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

pub(all) struct DsheappairingVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_heap_pairing_make_vector(comps : Array[Double]) -> DsheappairingVector {
  { comps, dim: comps.length() }
}

pub fn ds_heap_pairing_vector_zero(dim : Int) -> DsheappairingVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DsheappairingVector::add(self : DsheappairingVector, other : DsheappairingVector) -> DsheappairingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DsheappairingVector::sub(self : DsheappairingVector, other : DsheappairingVector) -> DsheappairingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DsheappairingVector::scale(self : DsheappairingVector, s : Double) -> DsheappairingVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DsheappairingVector::dot(self : DsheappairingVector, other : DsheappairingVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DsheappairingVector::norm(self : DsheappairingVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DsheappairingVector::normalize(self : DsheappairingVector) -> DsheappairingVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsheappairingVector::dist(self : DsheappairingVector, other : DsheappairingVector) -> Double {
  self.sub(other).norm()
}

pub fn DsheappairingVector::to_string(self : DsheappairingVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsheappairingFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_pairing_frame_make(size : Int) -> DsheappairingFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheappairingFrame::len(self : DsheappairingFrame) -> Int { self.size }

pub fn DsheappairingFrame::get(self : DsheappairingFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheappairingFrame::set(self : DsheappairingFrame, i : Int, v : Double) -> DsheappairingFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheappairingFrame::sum(self : DsheappairingFrame) -> Double { @_common.sum(self.data) }

pub fn DsheappairingFrame::mean(self : DsheappairingFrame) -> Double { @_common.mean(self.data) }

pub fn DsheappairingFrame::scale(self : DsheappairingFrame, f : Double) -> DsheappairingFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheappairingFrame::add(self : DsheappairingFrame, other : DsheappairingFrame) -> DsheappairingFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheappairingFrame::copy(self : DsheappairingFrame) -> DsheappairingFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheappairingFrame::fill(self : DsheappairingFrame, v : Double) -> DsheappairingFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheappairingFrame::min(self : DsheappairingFrame) -> Double { @_common.min(self.data) }

pub fn DsheappairingFrame::max(self : DsheappairingFrame) -> Double { @_common.max(self.data) }

pub fn DsheappairingFrame::to_string(self : DsheappairingFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheappairingTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_pairing_table_make(size : Int) -> DsheappairingTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheappairingTable::len(self : DsheappairingTable) -> Int { self.size }

pub fn DsheappairingTable::get(self : DsheappairingTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheappairingTable::set(self : DsheappairingTable, i : Int, v : Double) -> DsheappairingTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheappairingTable::sum(self : DsheappairingTable) -> Double { @_common.sum(self.data) }

pub fn DsheappairingTable::mean(self : DsheappairingTable) -> Double { @_common.mean(self.data) }

pub fn DsheappairingTable::scale(self : DsheappairingTable, f : Double) -> DsheappairingTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheappairingTable::add(self : DsheappairingTable, other : DsheappairingTable) -> DsheappairingTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheappairingTable::copy(self : DsheappairingTable) -> DsheappairingTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheappairingTable::fill(self : DsheappairingTable, v : Double) -> DsheappairingTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheappairingTable::min(self : DsheappairingTable) -> Double { @_common.min(self.data) }

pub fn DsheappairingTable::max(self : DsheappairingTable) -> Double { @_common.max(self.data) }

pub fn DsheappairingTable::to_string(self : DsheappairingTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheappairingGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_pairing_graphn_make(size : Int) -> DsheappairingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheappairingGraphN::len(self : DsheappairingGraphN) -> Int { self.size }

pub fn DsheappairingGraphN::get(self : DsheappairingGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheappairingGraphN::set(self : DsheappairingGraphN, i : Int, v : Double) -> DsheappairingGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheappairingGraphN::sum(self : DsheappairingGraphN) -> Double { @_common.sum(self.data) }

pub fn DsheappairingGraphN::mean(self : DsheappairingGraphN) -> Double { @_common.mean(self.data) }

pub fn DsheappairingGraphN::scale(self : DsheappairingGraphN, f : Double) -> DsheappairingGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheappairingGraphN::add(self : DsheappairingGraphN, other : DsheappairingGraphN) -> DsheappairingGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheappairingGraphN::copy(self : DsheappairingGraphN) -> DsheappairingGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheappairingGraphN::fill(self : DsheappairingGraphN, v : Double) -> DsheappairingGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheappairingGraphN::min(self : DsheappairingGraphN) -> Double { @_common.min(self.data) }

pub fn DsheappairingGraphN::max(self : DsheappairingGraphN) -> Double { @_common.max(self.data) }

pub fn DsheappairingGraphN::to_string(self : DsheappairingGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheappairingNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_pairing_node_make(size : Int) -> DsheappairingNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheappairingNode::len(self : DsheappairingNode) -> Int { self.size }

pub fn DsheappairingNode::get(self : DsheappairingNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheappairingNode::set(self : DsheappairingNode, i : Int, v : Double) -> DsheappairingNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheappairingNode::sum(self : DsheappairingNode) -> Double { @_common.sum(self.data) }

pub fn DsheappairingNode::mean(self : DsheappairingNode) -> Double { @_common.mean(self.data) }

pub fn DsheappairingNode::scale(self : DsheappairingNode, f : Double) -> DsheappairingNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheappairingNode::add(self : DsheappairingNode, other : DsheappairingNode) -> DsheappairingNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheappairingNode::copy(self : DsheappairingNode) -> DsheappairingNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheappairingNode::fill(self : DsheappairingNode, v : Double) -> DsheappairingNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheappairingNode::min(self : DsheappairingNode) -> Double { @_common.min(self.data) }

pub fn DsheappairingNode::max(self : DsheappairingNode) -> Double { @_common.max(self.data) }

pub fn DsheappairingNode::to_string(self : DsheappairingNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheappairingEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_pairing_edge_make(size : Int) -> DsheappairingEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheappairingEdge::len(self : DsheappairingEdge) -> Int { self.size }

pub fn DsheappairingEdge::get(self : DsheappairingEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheappairingEdge::set(self : DsheappairingEdge, i : Int, v : Double) -> DsheappairingEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheappairingEdge::sum(self : DsheappairingEdge) -> Double { @_common.sum(self.data) }

pub fn DsheappairingEdge::mean(self : DsheappairingEdge) -> Double { @_common.mean(self.data) }

pub fn DsheappairingEdge::scale(self : DsheappairingEdge, f : Double) -> DsheappairingEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheappairingEdge::add(self : DsheappairingEdge, other : DsheappairingEdge) -> DsheappairingEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheappairingEdge::copy(self : DsheappairingEdge) -> DsheappairingEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheappairingEdge::fill(self : DsheappairingEdge, v : Double) -> DsheappairingEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheappairingEdge::min(self : DsheappairingEdge) -> Double { @_common.min(self.data) }

pub fn DsheappairingEdge::max(self : DsheappairingEdge) -> Double { @_common.max(self.data) }

pub fn DsheappairingEdge::to_string(self : DsheappairingEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheappairingPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_pairing_path_make(size : Int) -> DsheappairingPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheappairingPath::len(self : DsheappairingPath) -> Int { self.size }

pub fn DsheappairingPath::get(self : DsheappairingPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheappairingPath::set(self : DsheappairingPath, i : Int, v : Double) -> DsheappairingPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheappairingPath::sum(self : DsheappairingPath) -> Double { @_common.sum(self.data) }

pub fn DsheappairingPath::mean(self : DsheappairingPath) -> Double { @_common.mean(self.data) }

pub fn DsheappairingPath::scale(self : DsheappairingPath, f : Double) -> DsheappairingPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheappairingPath::add(self : DsheappairingPath, other : DsheappairingPath) -> DsheappairingPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheappairingPath::copy(self : DsheappairingPath) -> DsheappairingPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheappairingPath::fill(self : DsheappairingPath, v : Double) -> DsheappairingPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheappairingPath::min(self : DsheappairingPath) -> Double { @_common.min(self.data) }

pub fn DsheappairingPath::max(self : DsheappairingPath) -> Double { @_common.max(self.data) }

pub fn DsheappairingPath::to_string(self : DsheappairingPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheappairingCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_pairing_cluster_make(size : Int) -> DsheappairingCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheappairingCluster::len(self : DsheappairingCluster) -> Int { self.size }

pub fn DsheappairingCluster::get(self : DsheappairingCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheappairingCluster::set(self : DsheappairingCluster, i : Int, v : Double) -> DsheappairingCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheappairingCluster::sum(self : DsheappairingCluster) -> Double { @_common.sum(self.data) }

pub fn DsheappairingCluster::mean(self : DsheappairingCluster) -> Double { @_common.mean(self.data) }

pub fn DsheappairingCluster::scale(self : DsheappairingCluster, f : Double) -> DsheappairingCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheappairingCluster::add(self : DsheappairingCluster, other : DsheappairingCluster) -> DsheappairingCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheappairingCluster::copy(self : DsheappairingCluster) -> DsheappairingCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheappairingCluster::fill(self : DsheappairingCluster, v : Double) -> DsheappairingCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheappairingCluster::min(self : DsheappairingCluster) -> Double { @_common.min(self.data) }

pub fn DsheappairingCluster::max(self : DsheappairingCluster) -> Double { @_common.max(self.data) }

pub fn DsheappairingCluster::to_string(self : DsheappairingCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheappairingModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_pairing_model_make(size : Int) -> DsheappairingModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheappairingModel::len(self : DsheappairingModel) -> Int { self.size }

pub fn DsheappairingModel::get(self : DsheappairingModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheappairingModel::set(self : DsheappairingModel, i : Int, v : Double) -> DsheappairingModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheappairingModel::sum(self : DsheappairingModel) -> Double { @_common.sum(self.data) }

pub fn DsheappairingModel::mean(self : DsheappairingModel) -> Double { @_common.mean(self.data) }

pub fn DsheappairingModel::scale(self : DsheappairingModel, f : Double) -> DsheappairingModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheappairingModel::add(self : DsheappairingModel, other : DsheappairingModel) -> DsheappairingModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheappairingModel::copy(self : DsheappairingModel) -> DsheappairingModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheappairingModel::fill(self : DsheappairingModel, v : Double) -> DsheappairingModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheappairingModel::min(self : DsheappairingModel) -> Double { @_common.min(self.data) }

pub fn DsheappairingModel::max(self : DsheappairingModel) -> Double { @_common.max(self.data) }

pub fn DsheappairingModel::to_string(self : DsheappairingModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheappairingLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_pairing_layer_make(size : Int) -> DsheappairingLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheappairingLayer::len(self : DsheappairingLayer) -> Int { self.size }

pub fn DsheappairingLayer::get(self : DsheappairingLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheappairingLayer::set(self : DsheappairingLayer, i : Int, v : Double) -> DsheappairingLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheappairingLayer::sum(self : DsheappairingLayer) -> Double { @_common.sum(self.data) }

pub fn DsheappairingLayer::mean(self : DsheappairingLayer) -> Double { @_common.mean(self.data) }

pub fn DsheappairingLayer::scale(self : DsheappairingLayer, f : Double) -> DsheappairingLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheappairingLayer::add(self : DsheappairingLayer, other : DsheappairingLayer) -> DsheappairingLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheappairingLayer::copy(self : DsheappairingLayer) -> DsheappairingLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheappairingLayer::fill(self : DsheappairingLayer, v : Double) -> DsheappairingLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheappairingLayer::min(self : DsheappairingLayer) -> Double { @_common.min(self.data) }

pub fn DsheappairingLayer::max(self : DsheappairingLayer) -> Double { @_common.max(self.data) }

pub fn DsheappairingLayer::to_string(self : DsheappairingLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheappairingBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_pairing_buffer_make(size : Int) -> DsheappairingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheappairingBuffer::len(self : DsheappairingBuffer) -> Int { self.size }

pub fn DsheappairingBuffer::get(self : DsheappairingBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheappairingBuffer::set(self : DsheappairingBuffer, i : Int, v : Double) -> DsheappairingBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheappairingBuffer::sum(self : DsheappairingBuffer) -> Double { @_common.sum(self.data) }

pub fn DsheappairingBuffer::mean(self : DsheappairingBuffer) -> Double { @_common.mean(self.data) }

pub fn DsheappairingBuffer::scale(self : DsheappairingBuffer, f : Double) -> DsheappairingBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheappairingBuffer::add(self : DsheappairingBuffer, other : DsheappairingBuffer) -> DsheappairingBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheappairingBuffer::copy(self : DsheappairingBuffer) -> DsheappairingBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheappairingBuffer::fill(self : DsheappairingBuffer, v : Double) -> DsheappairingBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheappairingBuffer::min(self : DsheappairingBuffer) -> Double { @_common.min(self.data) }

pub fn DsheappairingBuffer::max(self : DsheappairingBuffer) -> Double { @_common.max(self.data) }

pub fn DsheappairingBuffer::to_string(self : DsheappairingBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheappairingCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_pairing_cursor_make(size : Int) -> DsheappairingCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheappairingCursor::len(self : DsheappairingCursor) -> Int { self.size }

pub fn DsheappairingCursor::get(self : DsheappairingCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheappairingCursor::set(self : DsheappairingCursor, i : Int, v : Double) -> DsheappairingCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheappairingCursor::sum(self : DsheappairingCursor) -> Double { @_common.sum(self.data) }

pub fn DsheappairingCursor::mean(self : DsheappairingCursor) -> Double { @_common.mean(self.data) }

pub fn DsheappairingCursor::scale(self : DsheappairingCursor, f : Double) -> DsheappairingCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheappairingCursor::add(self : DsheappairingCursor, other : DsheappairingCursor) -> DsheappairingCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheappairingCursor::copy(self : DsheappairingCursor) -> DsheappairingCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheappairingCursor::fill(self : DsheappairingCursor, v : Double) -> DsheappairingCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheappairingCursor::min(self : DsheappairingCursor) -> Double { @_common.min(self.data) }

pub fn DsheappairingCursor::max(self : DsheappairingCursor) -> Double { @_common.max(self.data) }

pub fn DsheappairingCursor::to_string(self : DsheappairingCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheappairingView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_pairing_view_make(size : Int) -> DsheappairingView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheappairingView::len(self : DsheappairingView) -> Int { self.size }

pub fn DsheappairingView::get(self : DsheappairingView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheappairingView::set(self : DsheappairingView, i : Int, v : Double) -> DsheappairingView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheappairingView::sum(self : DsheappairingView) -> Double { @_common.sum(self.data) }

pub fn DsheappairingView::mean(self : DsheappairingView) -> Double { @_common.mean(self.data) }

pub fn DsheappairingView::scale(self : DsheappairingView, f : Double) -> DsheappairingView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheappairingView::add(self : DsheappairingView, other : DsheappairingView) -> DsheappairingView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheappairingView::copy(self : DsheappairingView) -> DsheappairingView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheappairingView::fill(self : DsheappairingView, v : Double) -> DsheappairingView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheappairingView::min(self : DsheappairingView) -> Double { @_common.min(self.data) }

pub fn DsheappairingView::max(self : DsheappairingView) -> Double { @_common.max(self.data) }

pub fn DsheappairingView::to_string(self : DsheappairingView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheappairingRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_pairing_range_make(size : Int) -> DsheappairingRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheappairingRange::len(self : DsheappairingRange) -> Int { self.size }

pub fn DsheappairingRange::get(self : DsheappairingRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheappairingRange::set(self : DsheappairingRange, i : Int, v : Double) -> DsheappairingRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheappairingRange::sum(self : DsheappairingRange) -> Double { @_common.sum(self.data) }

pub fn DsheappairingRange::mean(self : DsheappairingRange) -> Double { @_common.mean(self.data) }

pub fn DsheappairingRange::scale(self : DsheappairingRange, f : Double) -> DsheappairingRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheappairingRange::add(self : DsheappairingRange, other : DsheappairingRange) -> DsheappairingRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheappairingRange::copy(self : DsheappairingRange) -> DsheappairingRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheappairingRange::fill(self : DsheappairingRange, v : Double) -> DsheappairingRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheappairingRange::min(self : DsheappairingRange) -> Double { @_common.min(self.data) }

pub fn DsheappairingRange::max(self : DsheappairingRange) -> Double { @_common.max(self.data) }

pub fn DsheappairingRange::to_string(self : DsheappairingRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheappairingSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_pairing_slice_make(size : Int) -> DsheappairingSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheappairingSlice::len(self : DsheappairingSlice) -> Int { self.size }

pub fn DsheappairingSlice::get(self : DsheappairingSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheappairingSlice::set(self : DsheappairingSlice, i : Int, v : Double) -> DsheappairingSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheappairingSlice::sum(self : DsheappairingSlice) -> Double { @_common.sum(self.data) }

pub fn DsheappairingSlice::mean(self : DsheappairingSlice) -> Double { @_common.mean(self.data) }

pub fn DsheappairingSlice::scale(self : DsheappairingSlice, f : Double) -> DsheappairingSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheappairingSlice::add(self : DsheappairingSlice, other : DsheappairingSlice) -> DsheappairingSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheappairingSlice::copy(self : DsheappairingSlice) -> DsheappairingSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheappairingSlice::fill(self : DsheappairingSlice, v : Double) -> DsheappairingSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheappairingSlice::min(self : DsheappairingSlice) -> Double { @_common.min(self.data) }

pub fn DsheappairingSlice::max(self : DsheappairingSlice) -> Double { @_common.max(self.data) }

pub fn DsheappairingSlice::to_string(self : DsheappairingSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

