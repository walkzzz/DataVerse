///===
/// extcore/signal_transform_radar

pub(all) struct SignaltransformradarPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_transform_radar_make_point(x : Double, y : Double) -> SignaltransformradarPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_transform_radar_make_point3(x : Double, y : Double, z : Double) -> SignaltransformradarPoint {
  { x, y, z, label: 0 }
}

pub fn SignaltransformradarPoint::x(self : SignaltransformradarPoint) -> Double { self.x }

pub fn SignaltransformradarPoint::y(self : SignaltransformradarPoint) -> Double { self.y }

pub fn SignaltransformradarPoint::z(self : SignaltransformradarPoint) -> Double { self.z }

pub fn SignaltransformradarPoint::label(self : SignaltransformradarPoint) -> Int { self.label }

pub fn SignaltransformradarPoint::dist(self : SignaltransformradarPoint, other : SignaltransformradarPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignaltransformradarPoint::add(self : SignaltransformradarPoint, other : SignaltransformradarPoint) -> SignaltransformradarPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignaltransformradarPoint::sub(self : SignaltransformradarPoint, other : SignaltransformradarPoint) -> SignaltransformradarPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignaltransformradarPoint::scale(self : SignaltransformradarPoint, s : Double) -> SignaltransformradarPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignaltransformradarPoint::dot(self : SignaltransformradarPoint, other : SignaltransformradarPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignaltransformradarPoint::cross(self : SignaltransformradarPoint, other : SignaltransformradarPoint) -> SignaltransformradarPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignaltransformradarPoint::norm(self : SignaltransformradarPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignaltransformradarPoint::normalize(self : SignaltransformradarPoint) -> SignaltransformradarPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignaltransformradarPoint::negate(self : SignaltransformradarPoint) -> SignaltransformradarPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignaltransformradarPoint::mid(self : SignaltransformradarPoint, other : SignaltransformradarPoint) -> SignaltransformradarPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignaltransformradarPoint::lerp(self : SignaltransformradarPoint, other : SignaltransformradarPoint, t : Double) -> SignaltransformradarPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignaltransformradarPoint::to_string(self : SignaltransformradarPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignaltransformradarSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_transform_radar_make_series(vals : Array[Double], name : String) -> SignaltransformradarSeries {
  { vals, name, meta: 0 }
}

pub fn SignaltransformradarSeries::len(self : SignaltransformradarSeries) -> Int { self.vals.length() }

pub fn SignaltransformradarSeries::sum(self : SignaltransformradarSeries) -> Double { @_common.sum(self.vals) }

pub fn SignaltransformradarSeries::mean(self : SignaltransformradarSeries) -> Double { @_common.mean(self.vals) }

pub fn SignaltransformradarSeries::min(self : SignaltransformradarSeries) -> Double { @_common.min(self.vals) }

pub fn SignaltransformradarSeries::max(self : SignaltransformradarSeries) -> Double { @_common.max(self.vals) }

pub fn SignaltransformradarSeries::range(self : SignaltransformradarSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignaltransformradarSeries::variance(self : SignaltransformradarSeries) -> Double { @_common.variance(self.vals) }

pub fn SignaltransformradarSeries::std(self : SignaltransformradarSeries) -> Double { @_common.std(self.vals) }

pub fn SignaltransformradarSeries::median(self : SignaltransformradarSeries) -> Double { @_common.median(self.vals) }

pub fn SignaltransformradarSeries::scale(self : SignaltransformradarSeries, f : Double) -> SignaltransformradarSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignaltransformradarSeries::add(self : SignaltransformradarSeries, other : SignaltransformradarSeries) -> SignaltransformradarSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignaltransformradarSeries::sub(self : SignaltransformradarSeries, other : SignaltransformradarSeries) -> SignaltransformradarSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignaltransformradarSeries::normalize(self : SignaltransformradarSeries) -> SignaltransformradarSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignaltransformradarSeries::cumsum(self : SignaltransformradarSeries) -> SignaltransformradarSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignaltransformradarSeries::to_string(self : SignaltransformradarSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignaltransformradarMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_transform_radar_make_matrix(rows : Int, cols : Int, val : Double) -> SignaltransformradarMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_transform_radar_matrix_identity(n : Int) -> SignaltransformradarMatrix {
  let m = signal_transform_radar_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignaltransformradarMatrix::get(self : SignaltransformradarMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignaltransformradarMatrix::transpose(self : SignaltransformradarMatrix) -> SignaltransformradarMatrix {
  let result = signal_transform_radar_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignaltransformradarMatrix::add(self : SignaltransformradarMatrix, other : SignaltransformradarMatrix) -> SignaltransformradarMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_transform_radar_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignaltransformradarMatrix::scale(self : SignaltransformradarMatrix, s : Double) -> SignaltransformradarMatrix {
  let result = signal_transform_radar_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignaltransformradarMatrix::multiply(self : SignaltransformradarMatrix, other : SignaltransformradarMatrix) -> SignaltransformradarMatrix {
  if self.cols != other.rows { return signal_transform_radar_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_transform_radar_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SignaltransformradarMatrix::trace(self : SignaltransformradarMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignaltransformradarMatrix::det(self : SignaltransformradarMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignaltransformradarMatrix::norm(self : SignaltransformradarMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignaltransformradarMatrix::to_string(self : SignaltransformradarMatrix) -> String {
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

pub(all) struct SignaltransformradarVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_transform_radar_make_vector(comps : Array[Double]) -> SignaltransformradarVector {
  { comps, dim: comps.length() }
}

pub fn signal_transform_radar_vector_zero(dim : Int) -> SignaltransformradarVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignaltransformradarVector::add(self : SignaltransformradarVector, other : SignaltransformradarVector) -> SignaltransformradarVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignaltransformradarVector::sub(self : SignaltransformradarVector, other : SignaltransformradarVector) -> SignaltransformradarVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignaltransformradarVector::scale(self : SignaltransformradarVector, s : Double) -> SignaltransformradarVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignaltransformradarVector::dot(self : SignaltransformradarVector, other : SignaltransformradarVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignaltransformradarVector::norm(self : SignaltransformradarVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignaltransformradarVector::normalize(self : SignaltransformradarVector) -> SignaltransformradarVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignaltransformradarVector::dist(self : SignaltransformradarVector, other : SignaltransformradarVector) -> Double {
  self.sub(other).norm()
}

pub fn SignaltransformradarVector::to_string(self : SignaltransformradarVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignaltransformradarFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_radar_frame_make(size : Int) -> SignaltransformradarFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformradarFrame::len(self : SignaltransformradarFrame) -> Int { self.size }

pub fn SignaltransformradarFrame::get(self : SignaltransformradarFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformradarFrame::set(self : SignaltransformradarFrame, i : Int, v : Double) -> SignaltransformradarFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformradarFrame::sum(self : SignaltransformradarFrame) -> Double { @_common.sum(self.data) }

pub fn SignaltransformradarFrame::mean(self : SignaltransformradarFrame) -> Double { @_common.mean(self.data) }

pub fn SignaltransformradarFrame::scale(self : SignaltransformradarFrame, f : Double) -> SignaltransformradarFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformradarFrame::add(self : SignaltransformradarFrame, other : SignaltransformradarFrame) -> SignaltransformradarFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformradarFrame::copy(self : SignaltransformradarFrame) -> SignaltransformradarFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformradarFrame::fill(self : SignaltransformradarFrame, v : Double) -> SignaltransformradarFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformradarFrame::min(self : SignaltransformradarFrame) -> Double { @_common.min(self.data) }

pub fn SignaltransformradarFrame::max(self : SignaltransformradarFrame) -> Double { @_common.max(self.data) }

pub fn SignaltransformradarFrame::to_string(self : SignaltransformradarFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformradarTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_radar_table_make(size : Int) -> SignaltransformradarTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformradarTable::len(self : SignaltransformradarTable) -> Int { self.size }

pub fn SignaltransformradarTable::get(self : SignaltransformradarTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformradarTable::set(self : SignaltransformradarTable, i : Int, v : Double) -> SignaltransformradarTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformradarTable::sum(self : SignaltransformradarTable) -> Double { @_common.sum(self.data) }

pub fn SignaltransformradarTable::mean(self : SignaltransformradarTable) -> Double { @_common.mean(self.data) }

pub fn SignaltransformradarTable::scale(self : SignaltransformradarTable, f : Double) -> SignaltransformradarTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformradarTable::add(self : SignaltransformradarTable, other : SignaltransformradarTable) -> SignaltransformradarTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformradarTable::copy(self : SignaltransformradarTable) -> SignaltransformradarTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformradarTable::fill(self : SignaltransformradarTable, v : Double) -> SignaltransformradarTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformradarTable::min(self : SignaltransformradarTable) -> Double { @_common.min(self.data) }

pub fn SignaltransformradarTable::max(self : SignaltransformradarTable) -> Double { @_common.max(self.data) }

pub fn SignaltransformradarTable::to_string(self : SignaltransformradarTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformradarGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_radar_graphn_make(size : Int) -> SignaltransformradarGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformradarGraphN::len(self : SignaltransformradarGraphN) -> Int { self.size }

pub fn SignaltransformradarGraphN::get(self : SignaltransformradarGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformradarGraphN::set(self : SignaltransformradarGraphN, i : Int, v : Double) -> SignaltransformradarGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformradarGraphN::sum(self : SignaltransformradarGraphN) -> Double { @_common.sum(self.data) }

pub fn SignaltransformradarGraphN::mean(self : SignaltransformradarGraphN) -> Double { @_common.mean(self.data) }

pub fn SignaltransformradarGraphN::scale(self : SignaltransformradarGraphN, f : Double) -> SignaltransformradarGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformradarGraphN::add(self : SignaltransformradarGraphN, other : SignaltransformradarGraphN) -> SignaltransformradarGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformradarGraphN::copy(self : SignaltransformradarGraphN) -> SignaltransformradarGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformradarGraphN::fill(self : SignaltransformradarGraphN, v : Double) -> SignaltransformradarGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformradarGraphN::min(self : SignaltransformradarGraphN) -> Double { @_common.min(self.data) }

pub fn SignaltransformradarGraphN::max(self : SignaltransformradarGraphN) -> Double { @_common.max(self.data) }

pub fn SignaltransformradarGraphN::to_string(self : SignaltransformradarGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformradarNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_radar_node_make(size : Int) -> SignaltransformradarNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformradarNode::len(self : SignaltransformradarNode) -> Int { self.size }

pub fn SignaltransformradarNode::get(self : SignaltransformradarNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformradarNode::set(self : SignaltransformradarNode, i : Int, v : Double) -> SignaltransformradarNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformradarNode::sum(self : SignaltransformradarNode) -> Double { @_common.sum(self.data) }

pub fn SignaltransformradarNode::mean(self : SignaltransformradarNode) -> Double { @_common.mean(self.data) }

pub fn SignaltransformradarNode::scale(self : SignaltransformradarNode, f : Double) -> SignaltransformradarNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformradarNode::add(self : SignaltransformradarNode, other : SignaltransformradarNode) -> SignaltransformradarNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformradarNode::copy(self : SignaltransformradarNode) -> SignaltransformradarNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformradarNode::fill(self : SignaltransformradarNode, v : Double) -> SignaltransformradarNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformradarNode::min(self : SignaltransformradarNode) -> Double { @_common.min(self.data) }

pub fn SignaltransformradarNode::max(self : SignaltransformradarNode) -> Double { @_common.max(self.data) }

pub fn SignaltransformradarNode::to_string(self : SignaltransformradarNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformradarEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_radar_edge_make(size : Int) -> SignaltransformradarEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformradarEdge::len(self : SignaltransformradarEdge) -> Int { self.size }

pub fn SignaltransformradarEdge::get(self : SignaltransformradarEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformradarEdge::set(self : SignaltransformradarEdge, i : Int, v : Double) -> SignaltransformradarEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformradarEdge::sum(self : SignaltransformradarEdge) -> Double { @_common.sum(self.data) }

pub fn SignaltransformradarEdge::mean(self : SignaltransformradarEdge) -> Double { @_common.mean(self.data) }

pub fn SignaltransformradarEdge::scale(self : SignaltransformradarEdge, f : Double) -> SignaltransformradarEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformradarEdge::add(self : SignaltransformradarEdge, other : SignaltransformradarEdge) -> SignaltransformradarEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformradarEdge::copy(self : SignaltransformradarEdge) -> SignaltransformradarEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformradarEdge::fill(self : SignaltransformradarEdge, v : Double) -> SignaltransformradarEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformradarEdge::min(self : SignaltransformradarEdge) -> Double { @_common.min(self.data) }

pub fn SignaltransformradarEdge::max(self : SignaltransformradarEdge) -> Double { @_common.max(self.data) }

pub fn SignaltransformradarEdge::to_string(self : SignaltransformradarEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformradarPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_radar_path_make(size : Int) -> SignaltransformradarPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformradarPath::len(self : SignaltransformradarPath) -> Int { self.size }

pub fn SignaltransformradarPath::get(self : SignaltransformradarPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformradarPath::set(self : SignaltransformradarPath, i : Int, v : Double) -> SignaltransformradarPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformradarPath::sum(self : SignaltransformradarPath) -> Double { @_common.sum(self.data) }

pub fn SignaltransformradarPath::mean(self : SignaltransformradarPath) -> Double { @_common.mean(self.data) }

pub fn SignaltransformradarPath::scale(self : SignaltransformradarPath, f : Double) -> SignaltransformradarPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformradarPath::add(self : SignaltransformradarPath, other : SignaltransformradarPath) -> SignaltransformradarPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformradarPath::copy(self : SignaltransformradarPath) -> SignaltransformradarPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformradarPath::fill(self : SignaltransformradarPath, v : Double) -> SignaltransformradarPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformradarPath::min(self : SignaltransformradarPath) -> Double { @_common.min(self.data) }

pub fn SignaltransformradarPath::max(self : SignaltransformradarPath) -> Double { @_common.max(self.data) }

pub fn SignaltransformradarPath::to_string(self : SignaltransformradarPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformradarCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_radar_cluster_make(size : Int) -> SignaltransformradarCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformradarCluster::len(self : SignaltransformradarCluster) -> Int { self.size }

pub fn SignaltransformradarCluster::get(self : SignaltransformradarCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformradarCluster::set(self : SignaltransformradarCluster, i : Int, v : Double) -> SignaltransformradarCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformradarCluster::sum(self : SignaltransformradarCluster) -> Double { @_common.sum(self.data) }

pub fn SignaltransformradarCluster::mean(self : SignaltransformradarCluster) -> Double { @_common.mean(self.data) }

pub fn SignaltransformradarCluster::scale(self : SignaltransformradarCluster, f : Double) -> SignaltransformradarCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformradarCluster::add(self : SignaltransformradarCluster, other : SignaltransformradarCluster) -> SignaltransformradarCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformradarCluster::copy(self : SignaltransformradarCluster) -> SignaltransformradarCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformradarCluster::fill(self : SignaltransformradarCluster, v : Double) -> SignaltransformradarCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformradarCluster::min(self : SignaltransformradarCluster) -> Double { @_common.min(self.data) }

pub fn SignaltransformradarCluster::max(self : SignaltransformradarCluster) -> Double { @_common.max(self.data) }

pub fn SignaltransformradarCluster::to_string(self : SignaltransformradarCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformradarModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_radar_model_make(size : Int) -> SignaltransformradarModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformradarModel::len(self : SignaltransformradarModel) -> Int { self.size }

pub fn SignaltransformradarModel::get(self : SignaltransformradarModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformradarModel::set(self : SignaltransformradarModel, i : Int, v : Double) -> SignaltransformradarModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformradarModel::sum(self : SignaltransformradarModel) -> Double { @_common.sum(self.data) }

pub fn SignaltransformradarModel::mean(self : SignaltransformradarModel) -> Double { @_common.mean(self.data) }

pub fn SignaltransformradarModel::scale(self : SignaltransformradarModel, f : Double) -> SignaltransformradarModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformradarModel::add(self : SignaltransformradarModel, other : SignaltransformradarModel) -> SignaltransformradarModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformradarModel::copy(self : SignaltransformradarModel) -> SignaltransformradarModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformradarModel::fill(self : SignaltransformradarModel, v : Double) -> SignaltransformradarModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformradarModel::min(self : SignaltransformradarModel) -> Double { @_common.min(self.data) }

pub fn SignaltransformradarModel::max(self : SignaltransformradarModel) -> Double { @_common.max(self.data) }

pub fn SignaltransformradarModel::to_string(self : SignaltransformradarModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformradarLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_radar_layer_make(size : Int) -> SignaltransformradarLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformradarLayer::len(self : SignaltransformradarLayer) -> Int { self.size }

pub fn SignaltransformradarLayer::get(self : SignaltransformradarLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformradarLayer::set(self : SignaltransformradarLayer, i : Int, v : Double) -> SignaltransformradarLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformradarLayer::sum(self : SignaltransformradarLayer) -> Double { @_common.sum(self.data) }

pub fn SignaltransformradarLayer::mean(self : SignaltransformradarLayer) -> Double { @_common.mean(self.data) }

pub fn SignaltransformradarLayer::scale(self : SignaltransformradarLayer, f : Double) -> SignaltransformradarLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformradarLayer::add(self : SignaltransformradarLayer, other : SignaltransformradarLayer) -> SignaltransformradarLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformradarLayer::copy(self : SignaltransformradarLayer) -> SignaltransformradarLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformradarLayer::fill(self : SignaltransformradarLayer, v : Double) -> SignaltransformradarLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformradarLayer::min(self : SignaltransformradarLayer) -> Double { @_common.min(self.data) }

pub fn SignaltransformradarLayer::max(self : SignaltransformradarLayer) -> Double { @_common.max(self.data) }

pub fn SignaltransformradarLayer::to_string(self : SignaltransformradarLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformradarBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_radar_buffer_make(size : Int) -> SignaltransformradarBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformradarBuffer::len(self : SignaltransformradarBuffer) -> Int { self.size }

pub fn SignaltransformradarBuffer::get(self : SignaltransformradarBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformradarBuffer::set(self : SignaltransformradarBuffer, i : Int, v : Double) -> SignaltransformradarBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformradarBuffer::sum(self : SignaltransformradarBuffer) -> Double { @_common.sum(self.data) }

pub fn SignaltransformradarBuffer::mean(self : SignaltransformradarBuffer) -> Double { @_common.mean(self.data) }

pub fn SignaltransformradarBuffer::scale(self : SignaltransformradarBuffer, f : Double) -> SignaltransformradarBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformradarBuffer::add(self : SignaltransformradarBuffer, other : SignaltransformradarBuffer) -> SignaltransformradarBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformradarBuffer::copy(self : SignaltransformradarBuffer) -> SignaltransformradarBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformradarBuffer::fill(self : SignaltransformradarBuffer, v : Double) -> SignaltransformradarBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformradarBuffer::min(self : SignaltransformradarBuffer) -> Double { @_common.min(self.data) }

pub fn SignaltransformradarBuffer::max(self : SignaltransformradarBuffer) -> Double { @_common.max(self.data) }

pub fn SignaltransformradarBuffer::to_string(self : SignaltransformradarBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformradarCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_radar_cursor_make(size : Int) -> SignaltransformradarCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformradarCursor::len(self : SignaltransformradarCursor) -> Int { self.size }

pub fn SignaltransformradarCursor::get(self : SignaltransformradarCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformradarCursor::set(self : SignaltransformradarCursor, i : Int, v : Double) -> SignaltransformradarCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformradarCursor::sum(self : SignaltransformradarCursor) -> Double { @_common.sum(self.data) }

pub fn SignaltransformradarCursor::mean(self : SignaltransformradarCursor) -> Double { @_common.mean(self.data) }

pub fn SignaltransformradarCursor::scale(self : SignaltransformradarCursor, f : Double) -> SignaltransformradarCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformradarCursor::add(self : SignaltransformradarCursor, other : SignaltransformradarCursor) -> SignaltransformradarCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformradarCursor::copy(self : SignaltransformradarCursor) -> SignaltransformradarCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformradarCursor::fill(self : SignaltransformradarCursor, v : Double) -> SignaltransformradarCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformradarCursor::min(self : SignaltransformradarCursor) -> Double { @_common.min(self.data) }

pub fn SignaltransformradarCursor::max(self : SignaltransformradarCursor) -> Double { @_common.max(self.data) }

pub fn SignaltransformradarCursor::to_string(self : SignaltransformradarCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformradarView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_radar_view_make(size : Int) -> SignaltransformradarView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformradarView::len(self : SignaltransformradarView) -> Int { self.size }

pub fn SignaltransformradarView::get(self : SignaltransformradarView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformradarView::set(self : SignaltransformradarView, i : Int, v : Double) -> SignaltransformradarView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformradarView::sum(self : SignaltransformradarView) -> Double { @_common.sum(self.data) }

pub fn SignaltransformradarView::mean(self : SignaltransformradarView) -> Double { @_common.mean(self.data) }

pub fn SignaltransformradarView::scale(self : SignaltransformradarView, f : Double) -> SignaltransformradarView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformradarView::add(self : SignaltransformradarView, other : SignaltransformradarView) -> SignaltransformradarView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformradarView::copy(self : SignaltransformradarView) -> SignaltransformradarView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformradarView::fill(self : SignaltransformradarView, v : Double) -> SignaltransformradarView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformradarView::min(self : SignaltransformradarView) -> Double { @_common.min(self.data) }

pub fn SignaltransformradarView::max(self : SignaltransformradarView) -> Double { @_common.max(self.data) }

pub fn SignaltransformradarView::to_string(self : SignaltransformradarView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformradarRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_radar_range_make(size : Int) -> SignaltransformradarRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformradarRange::len(self : SignaltransformradarRange) -> Int { self.size }

pub fn SignaltransformradarRange::get(self : SignaltransformradarRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformradarRange::set(self : SignaltransformradarRange, i : Int, v : Double) -> SignaltransformradarRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformradarRange::sum(self : SignaltransformradarRange) -> Double { @_common.sum(self.data) }

pub fn SignaltransformradarRange::mean(self : SignaltransformradarRange) -> Double { @_common.mean(self.data) }

pub fn SignaltransformradarRange::scale(self : SignaltransformradarRange, f : Double) -> SignaltransformradarRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformradarRange::add(self : SignaltransformradarRange, other : SignaltransformradarRange) -> SignaltransformradarRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformradarRange::copy(self : SignaltransformradarRange) -> SignaltransformradarRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformradarRange::fill(self : SignaltransformradarRange, v : Double) -> SignaltransformradarRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformradarRange::min(self : SignaltransformradarRange) -> Double { @_common.min(self.data) }

pub fn SignaltransformradarRange::max(self : SignaltransformradarRange) -> Double { @_common.max(self.data) }

pub fn SignaltransformradarRange::to_string(self : SignaltransformradarRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformradarSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_radar_slice_make(size : Int) -> SignaltransformradarSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformradarSlice::len(self : SignaltransformradarSlice) -> Int { self.size }

pub fn SignaltransformradarSlice::get(self : SignaltransformradarSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformradarSlice::set(self : SignaltransformradarSlice, i : Int, v : Double) -> SignaltransformradarSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformradarSlice::sum(self : SignaltransformradarSlice) -> Double { @_common.sum(self.data) }

pub fn SignaltransformradarSlice::mean(self : SignaltransformradarSlice) -> Double { @_common.mean(self.data) }

pub fn SignaltransformradarSlice::scale(self : SignaltransformradarSlice, f : Double) -> SignaltransformradarSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformradarSlice::add(self : SignaltransformradarSlice, other : SignaltransformradarSlice) -> SignaltransformradarSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformradarSlice::copy(self : SignaltransformradarSlice) -> SignaltransformradarSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformradarSlice::fill(self : SignaltransformradarSlice, v : Double) -> SignaltransformradarSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformradarSlice::min(self : SignaltransformradarSlice) -> Double { @_common.min(self.data) }

pub fn SignaltransformradarSlice::max(self : SignaltransformradarSlice) -> Double { @_common.max(self.data) }

pub fn SignaltransformradarSlice::to_string(self : SignaltransformradarSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

