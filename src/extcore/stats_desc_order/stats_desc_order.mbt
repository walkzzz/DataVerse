///===
/// extcore/stats_desc_order

pub(all) struct StatsdescorderPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_desc_order_make_point(x : Double, y : Double) -> StatsdescorderPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_desc_order_make_point3(x : Double, y : Double, z : Double) -> StatsdescorderPoint {
  { x, y, z, label: 0 }
}

pub fn StatsdescorderPoint::x(self : StatsdescorderPoint) -> Double { self.x }

pub fn StatsdescorderPoint::y(self : StatsdescorderPoint) -> Double { self.y }

pub fn StatsdescorderPoint::z(self : StatsdescorderPoint) -> Double { self.z }

pub fn StatsdescorderPoint::label(self : StatsdescorderPoint) -> Int { self.label }

pub fn StatsdescorderPoint::dist(self : StatsdescorderPoint, other : StatsdescorderPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsdescorderPoint::add(self : StatsdescorderPoint, other : StatsdescorderPoint) -> StatsdescorderPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsdescorderPoint::sub(self : StatsdescorderPoint, other : StatsdescorderPoint) -> StatsdescorderPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsdescorderPoint::scale(self : StatsdescorderPoint, s : Double) -> StatsdescorderPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsdescorderPoint::dot(self : StatsdescorderPoint, other : StatsdescorderPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsdescorderPoint::cross(self : StatsdescorderPoint, other : StatsdescorderPoint) -> StatsdescorderPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsdescorderPoint::norm(self : StatsdescorderPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsdescorderPoint::normalize(self : StatsdescorderPoint) -> StatsdescorderPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdescorderPoint::negate(self : StatsdescorderPoint) -> StatsdescorderPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsdescorderPoint::mid(self : StatsdescorderPoint, other : StatsdescorderPoint) -> StatsdescorderPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsdescorderPoint::lerp(self : StatsdescorderPoint, other : StatsdescorderPoint, t : Double) -> StatsdescorderPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsdescorderPoint::to_string(self : StatsdescorderPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsdescorderSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_desc_order_make_series(vals : Array[Double], name : String) -> StatsdescorderSeries {
  { vals, name, meta: 0 }
}

pub fn StatsdescorderSeries::len(self : StatsdescorderSeries) -> Int { self.vals.length() }

pub fn StatsdescorderSeries::sum(self : StatsdescorderSeries) -> Double { @_common.sum(self.vals) }

pub fn StatsdescorderSeries::mean(self : StatsdescorderSeries) -> Double { @_common.mean(self.vals) }

pub fn StatsdescorderSeries::min(self : StatsdescorderSeries) -> Double { @_common.min(self.vals) }

pub fn StatsdescorderSeries::max(self : StatsdescorderSeries) -> Double { @_common.max(self.vals) }

pub fn StatsdescorderSeries::range(self : StatsdescorderSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsdescorderSeries::variance(self : StatsdescorderSeries) -> Double { @_common.variance(self.vals) }

pub fn StatsdescorderSeries::std(self : StatsdescorderSeries) -> Double { @_common.std(self.vals) }

pub fn StatsdescorderSeries::median(self : StatsdescorderSeries) -> Double { @_common.median(self.vals) }

pub fn StatsdescorderSeries::scale(self : StatsdescorderSeries, f : Double) -> StatsdescorderSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsdescorderSeries::add(self : StatsdescorderSeries, other : StatsdescorderSeries) -> StatsdescorderSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsdescorderSeries::sub(self : StatsdescorderSeries, other : StatsdescorderSeries) -> StatsdescorderSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsdescorderSeries::normalize(self : StatsdescorderSeries) -> StatsdescorderSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsdescorderSeries::cumsum(self : StatsdescorderSeries) -> StatsdescorderSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsdescorderSeries::to_string(self : StatsdescorderSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdescorderMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_desc_order_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdescorderMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_desc_order_matrix_identity(n : Int) -> StatsdescorderMatrix {
  let m = stats_desc_order_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsdescorderMatrix::get(self : StatsdescorderMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsdescorderMatrix::transpose(self : StatsdescorderMatrix) -> StatsdescorderMatrix {
  let result = stats_desc_order_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsdescorderMatrix::add(self : StatsdescorderMatrix, other : StatsdescorderMatrix) -> StatsdescorderMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_desc_order_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsdescorderMatrix::scale(self : StatsdescorderMatrix, s : Double) -> StatsdescorderMatrix {
  let result = stats_desc_order_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsdescorderMatrix::multiply(self : StatsdescorderMatrix, other : StatsdescorderMatrix) -> StatsdescorderMatrix {
  if self.cols != other.rows { return stats_desc_order_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_desc_order_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn StatsdescorderMatrix::trace(self : StatsdescorderMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsdescorderMatrix::det(self : StatsdescorderMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsdescorderMatrix::norm(self : StatsdescorderMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsdescorderMatrix::to_string(self : StatsdescorderMatrix) -> String {
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

pub(all) struct StatsdescorderVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_desc_order_make_vector(comps : Array[Double]) -> StatsdescorderVector {
  { comps, dim: comps.length() }
}

pub fn stats_desc_order_vector_zero(dim : Int) -> StatsdescorderVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsdescorderVector::add(self : StatsdescorderVector, other : StatsdescorderVector) -> StatsdescorderVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdescorderVector::sub(self : StatsdescorderVector, other : StatsdescorderVector) -> StatsdescorderVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdescorderVector::scale(self : StatsdescorderVector, s : Double) -> StatsdescorderVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsdescorderVector::dot(self : StatsdescorderVector, other : StatsdescorderVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsdescorderVector::norm(self : StatsdescorderVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsdescorderVector::normalize(self : StatsdescorderVector) -> StatsdescorderVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdescorderVector::dist(self : StatsdescorderVector, other : StatsdescorderVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsdescorderVector::to_string(self : StatsdescorderVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdescorderFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_order_frame_make(size : Int) -> StatsdescorderFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdescorderFrame::len(self : StatsdescorderFrame) -> Int { self.size }

pub fn StatsdescorderFrame::get(self : StatsdescorderFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdescorderFrame::set(self : StatsdescorderFrame, i : Int, v : Double) -> StatsdescorderFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdescorderFrame::sum(self : StatsdescorderFrame) -> Double { @_common.sum(self.data) }

pub fn StatsdescorderFrame::mean(self : StatsdescorderFrame) -> Double { @_common.mean(self.data) }

pub fn StatsdescorderFrame::scale(self : StatsdescorderFrame, f : Double) -> StatsdescorderFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdescorderFrame::add(self : StatsdescorderFrame, other : StatsdescorderFrame) -> StatsdescorderFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdescorderFrame::copy(self : StatsdescorderFrame) -> StatsdescorderFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdescorderFrame::fill(self : StatsdescorderFrame, v : Double) -> StatsdescorderFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdescorderFrame::min(self : StatsdescorderFrame) -> Double { @_common.min(self.data) }

pub fn StatsdescorderFrame::max(self : StatsdescorderFrame) -> Double { @_common.max(self.data) }

pub fn StatsdescorderFrame::to_string(self : StatsdescorderFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdescorderTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_order_table_make(size : Int) -> StatsdescorderTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdescorderTable::len(self : StatsdescorderTable) -> Int { self.size }

pub fn StatsdescorderTable::get(self : StatsdescorderTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdescorderTable::set(self : StatsdescorderTable, i : Int, v : Double) -> StatsdescorderTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdescorderTable::sum(self : StatsdescorderTable) -> Double { @_common.sum(self.data) }

pub fn StatsdescorderTable::mean(self : StatsdescorderTable) -> Double { @_common.mean(self.data) }

pub fn StatsdescorderTable::scale(self : StatsdescorderTable, f : Double) -> StatsdescorderTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdescorderTable::add(self : StatsdescorderTable, other : StatsdescorderTable) -> StatsdescorderTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdescorderTable::copy(self : StatsdescorderTable) -> StatsdescorderTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdescorderTable::fill(self : StatsdescorderTable, v : Double) -> StatsdescorderTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdescorderTable::min(self : StatsdescorderTable) -> Double { @_common.min(self.data) }

pub fn StatsdescorderTable::max(self : StatsdescorderTable) -> Double { @_common.max(self.data) }

pub fn StatsdescorderTable::to_string(self : StatsdescorderTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdescorderGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_order_graphn_make(size : Int) -> StatsdescorderGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdescorderGraphN::len(self : StatsdescorderGraphN) -> Int { self.size }

pub fn StatsdescorderGraphN::get(self : StatsdescorderGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdescorderGraphN::set(self : StatsdescorderGraphN, i : Int, v : Double) -> StatsdescorderGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdescorderGraphN::sum(self : StatsdescorderGraphN) -> Double { @_common.sum(self.data) }

pub fn StatsdescorderGraphN::mean(self : StatsdescorderGraphN) -> Double { @_common.mean(self.data) }

pub fn StatsdescorderGraphN::scale(self : StatsdescorderGraphN, f : Double) -> StatsdescorderGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdescorderGraphN::add(self : StatsdescorderGraphN, other : StatsdescorderGraphN) -> StatsdescorderGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdescorderGraphN::copy(self : StatsdescorderGraphN) -> StatsdescorderGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdescorderGraphN::fill(self : StatsdescorderGraphN, v : Double) -> StatsdescorderGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdescorderGraphN::min(self : StatsdescorderGraphN) -> Double { @_common.min(self.data) }

pub fn StatsdescorderGraphN::max(self : StatsdescorderGraphN) -> Double { @_common.max(self.data) }

pub fn StatsdescorderGraphN::to_string(self : StatsdescorderGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdescorderNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_order_node_make(size : Int) -> StatsdescorderNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdescorderNode::len(self : StatsdescorderNode) -> Int { self.size }

pub fn StatsdescorderNode::get(self : StatsdescorderNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdescorderNode::set(self : StatsdescorderNode, i : Int, v : Double) -> StatsdescorderNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdescorderNode::sum(self : StatsdescorderNode) -> Double { @_common.sum(self.data) }

pub fn StatsdescorderNode::mean(self : StatsdescorderNode) -> Double { @_common.mean(self.data) }

pub fn StatsdescorderNode::scale(self : StatsdescorderNode, f : Double) -> StatsdescorderNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdescorderNode::add(self : StatsdescorderNode, other : StatsdescorderNode) -> StatsdescorderNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdescorderNode::copy(self : StatsdescorderNode) -> StatsdescorderNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdescorderNode::fill(self : StatsdescorderNode, v : Double) -> StatsdescorderNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdescorderNode::min(self : StatsdescorderNode) -> Double { @_common.min(self.data) }

pub fn StatsdescorderNode::max(self : StatsdescorderNode) -> Double { @_common.max(self.data) }

pub fn StatsdescorderNode::to_string(self : StatsdescorderNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdescorderEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_order_edge_make(size : Int) -> StatsdescorderEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdescorderEdge::len(self : StatsdescorderEdge) -> Int { self.size }

pub fn StatsdescorderEdge::get(self : StatsdescorderEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdescorderEdge::set(self : StatsdescorderEdge, i : Int, v : Double) -> StatsdescorderEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdescorderEdge::sum(self : StatsdescorderEdge) -> Double { @_common.sum(self.data) }

pub fn StatsdescorderEdge::mean(self : StatsdescorderEdge) -> Double { @_common.mean(self.data) }

pub fn StatsdescorderEdge::scale(self : StatsdescorderEdge, f : Double) -> StatsdescorderEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdescorderEdge::add(self : StatsdescorderEdge, other : StatsdescorderEdge) -> StatsdescorderEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdescorderEdge::copy(self : StatsdescorderEdge) -> StatsdescorderEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdescorderEdge::fill(self : StatsdescorderEdge, v : Double) -> StatsdescorderEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdescorderEdge::min(self : StatsdescorderEdge) -> Double { @_common.min(self.data) }

pub fn StatsdescorderEdge::max(self : StatsdescorderEdge) -> Double { @_common.max(self.data) }

pub fn StatsdescorderEdge::to_string(self : StatsdescorderEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdescorderPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_order_path_make(size : Int) -> StatsdescorderPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdescorderPath::len(self : StatsdescorderPath) -> Int { self.size }

pub fn StatsdescorderPath::get(self : StatsdescorderPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdescorderPath::set(self : StatsdescorderPath, i : Int, v : Double) -> StatsdescorderPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdescorderPath::sum(self : StatsdescorderPath) -> Double { @_common.sum(self.data) }

pub fn StatsdescorderPath::mean(self : StatsdescorderPath) -> Double { @_common.mean(self.data) }

pub fn StatsdescorderPath::scale(self : StatsdescorderPath, f : Double) -> StatsdescorderPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdescorderPath::add(self : StatsdescorderPath, other : StatsdescorderPath) -> StatsdescorderPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdescorderPath::copy(self : StatsdescorderPath) -> StatsdescorderPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdescorderPath::fill(self : StatsdescorderPath, v : Double) -> StatsdescorderPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdescorderPath::min(self : StatsdescorderPath) -> Double { @_common.min(self.data) }

pub fn StatsdescorderPath::max(self : StatsdescorderPath) -> Double { @_common.max(self.data) }

pub fn StatsdescorderPath::to_string(self : StatsdescorderPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdescorderCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_order_cluster_make(size : Int) -> StatsdescorderCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdescorderCluster::len(self : StatsdescorderCluster) -> Int { self.size }

pub fn StatsdescorderCluster::get(self : StatsdescorderCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdescorderCluster::set(self : StatsdescorderCluster, i : Int, v : Double) -> StatsdescorderCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdescorderCluster::sum(self : StatsdescorderCluster) -> Double { @_common.sum(self.data) }

pub fn StatsdescorderCluster::mean(self : StatsdescorderCluster) -> Double { @_common.mean(self.data) }

pub fn StatsdescorderCluster::scale(self : StatsdescorderCluster, f : Double) -> StatsdescorderCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdescorderCluster::add(self : StatsdescorderCluster, other : StatsdescorderCluster) -> StatsdescorderCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdescorderCluster::copy(self : StatsdescorderCluster) -> StatsdescorderCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdescorderCluster::fill(self : StatsdescorderCluster, v : Double) -> StatsdescorderCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdescorderCluster::min(self : StatsdescorderCluster) -> Double { @_common.min(self.data) }

pub fn StatsdescorderCluster::max(self : StatsdescorderCluster) -> Double { @_common.max(self.data) }

pub fn StatsdescorderCluster::to_string(self : StatsdescorderCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdescorderModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_order_model_make(size : Int) -> StatsdescorderModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdescorderModel::len(self : StatsdescorderModel) -> Int { self.size }

pub fn StatsdescorderModel::get(self : StatsdescorderModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdescorderModel::set(self : StatsdescorderModel, i : Int, v : Double) -> StatsdescorderModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdescorderModel::sum(self : StatsdescorderModel) -> Double { @_common.sum(self.data) }

pub fn StatsdescorderModel::mean(self : StatsdescorderModel) -> Double { @_common.mean(self.data) }

pub fn StatsdescorderModel::scale(self : StatsdescorderModel, f : Double) -> StatsdescorderModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdescorderModel::add(self : StatsdescorderModel, other : StatsdescorderModel) -> StatsdescorderModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdescorderModel::copy(self : StatsdescorderModel) -> StatsdescorderModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdescorderModel::fill(self : StatsdescorderModel, v : Double) -> StatsdescorderModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdescorderModel::min(self : StatsdescorderModel) -> Double { @_common.min(self.data) }

pub fn StatsdescorderModel::max(self : StatsdescorderModel) -> Double { @_common.max(self.data) }

pub fn StatsdescorderModel::to_string(self : StatsdescorderModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdescorderLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_order_layer_make(size : Int) -> StatsdescorderLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdescorderLayer::len(self : StatsdescorderLayer) -> Int { self.size }

pub fn StatsdescorderLayer::get(self : StatsdescorderLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdescorderLayer::set(self : StatsdescorderLayer, i : Int, v : Double) -> StatsdescorderLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdescorderLayer::sum(self : StatsdescorderLayer) -> Double { @_common.sum(self.data) }

pub fn StatsdescorderLayer::mean(self : StatsdescorderLayer) -> Double { @_common.mean(self.data) }

pub fn StatsdescorderLayer::scale(self : StatsdescorderLayer, f : Double) -> StatsdescorderLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdescorderLayer::add(self : StatsdescorderLayer, other : StatsdescorderLayer) -> StatsdescorderLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdescorderLayer::copy(self : StatsdescorderLayer) -> StatsdescorderLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdescorderLayer::fill(self : StatsdescorderLayer, v : Double) -> StatsdescorderLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdescorderLayer::min(self : StatsdescorderLayer) -> Double { @_common.min(self.data) }

pub fn StatsdescorderLayer::max(self : StatsdescorderLayer) -> Double { @_common.max(self.data) }

pub fn StatsdescorderLayer::to_string(self : StatsdescorderLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdescorderBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_order_buffer_make(size : Int) -> StatsdescorderBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdescorderBuffer::len(self : StatsdescorderBuffer) -> Int { self.size }

pub fn StatsdescorderBuffer::get(self : StatsdescorderBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdescorderBuffer::set(self : StatsdescorderBuffer, i : Int, v : Double) -> StatsdescorderBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdescorderBuffer::sum(self : StatsdescorderBuffer) -> Double { @_common.sum(self.data) }

pub fn StatsdescorderBuffer::mean(self : StatsdescorderBuffer) -> Double { @_common.mean(self.data) }

pub fn StatsdescorderBuffer::scale(self : StatsdescorderBuffer, f : Double) -> StatsdescorderBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdescorderBuffer::add(self : StatsdescorderBuffer, other : StatsdescorderBuffer) -> StatsdescorderBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdescorderBuffer::copy(self : StatsdescorderBuffer) -> StatsdescorderBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdescorderBuffer::fill(self : StatsdescorderBuffer, v : Double) -> StatsdescorderBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdescorderBuffer::min(self : StatsdescorderBuffer) -> Double { @_common.min(self.data) }

pub fn StatsdescorderBuffer::max(self : StatsdescorderBuffer) -> Double { @_common.max(self.data) }

pub fn StatsdescorderBuffer::to_string(self : StatsdescorderBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdescorderCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_order_cursor_make(size : Int) -> StatsdescorderCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdescorderCursor::len(self : StatsdescorderCursor) -> Int { self.size }

pub fn StatsdescorderCursor::get(self : StatsdescorderCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdescorderCursor::set(self : StatsdescorderCursor, i : Int, v : Double) -> StatsdescorderCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdescorderCursor::sum(self : StatsdescorderCursor) -> Double { @_common.sum(self.data) }

pub fn StatsdescorderCursor::mean(self : StatsdescorderCursor) -> Double { @_common.mean(self.data) }

pub fn StatsdescorderCursor::scale(self : StatsdescorderCursor, f : Double) -> StatsdescorderCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdescorderCursor::add(self : StatsdescorderCursor, other : StatsdescorderCursor) -> StatsdescorderCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdescorderCursor::copy(self : StatsdescorderCursor) -> StatsdescorderCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdescorderCursor::fill(self : StatsdescorderCursor, v : Double) -> StatsdescorderCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdescorderCursor::min(self : StatsdescorderCursor) -> Double { @_common.min(self.data) }

pub fn StatsdescorderCursor::max(self : StatsdescorderCursor) -> Double { @_common.max(self.data) }

pub fn StatsdescorderCursor::to_string(self : StatsdescorderCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdescorderView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_order_view_make(size : Int) -> StatsdescorderView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdescorderView::len(self : StatsdescorderView) -> Int { self.size }

pub fn StatsdescorderView::get(self : StatsdescorderView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdescorderView::set(self : StatsdescorderView, i : Int, v : Double) -> StatsdescorderView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdescorderView::sum(self : StatsdescorderView) -> Double { @_common.sum(self.data) }

pub fn StatsdescorderView::mean(self : StatsdescorderView) -> Double { @_common.mean(self.data) }

pub fn StatsdescorderView::scale(self : StatsdescorderView, f : Double) -> StatsdescorderView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdescorderView::add(self : StatsdescorderView, other : StatsdescorderView) -> StatsdescorderView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdescorderView::copy(self : StatsdescorderView) -> StatsdescorderView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdescorderView::fill(self : StatsdescorderView, v : Double) -> StatsdescorderView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdescorderView::min(self : StatsdescorderView) -> Double { @_common.min(self.data) }

pub fn StatsdescorderView::max(self : StatsdescorderView) -> Double { @_common.max(self.data) }

pub fn StatsdescorderView::to_string(self : StatsdescorderView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdescorderRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_order_range_make(size : Int) -> StatsdescorderRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdescorderRange::len(self : StatsdescorderRange) -> Int { self.size }

pub fn StatsdescorderRange::get(self : StatsdescorderRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdescorderRange::set(self : StatsdescorderRange, i : Int, v : Double) -> StatsdescorderRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdescorderRange::sum(self : StatsdescorderRange) -> Double { @_common.sum(self.data) }

pub fn StatsdescorderRange::mean(self : StatsdescorderRange) -> Double { @_common.mean(self.data) }

pub fn StatsdescorderRange::scale(self : StatsdescorderRange, f : Double) -> StatsdescorderRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdescorderRange::add(self : StatsdescorderRange, other : StatsdescorderRange) -> StatsdescorderRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdescorderRange::copy(self : StatsdescorderRange) -> StatsdescorderRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdescorderRange::fill(self : StatsdescorderRange, v : Double) -> StatsdescorderRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdescorderRange::min(self : StatsdescorderRange) -> Double { @_common.min(self.data) }

pub fn StatsdescorderRange::max(self : StatsdescorderRange) -> Double { @_common.max(self.data) }

pub fn StatsdescorderRange::to_string(self : StatsdescorderRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsdescorderSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_order_slice_make(size : Int) -> StatsdescorderSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsdescorderSlice::len(self : StatsdescorderSlice) -> Int { self.size }

pub fn StatsdescorderSlice::get(self : StatsdescorderSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsdescorderSlice::set(self : StatsdescorderSlice, i : Int, v : Double) -> StatsdescorderSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsdescorderSlice::sum(self : StatsdescorderSlice) -> Double { @_common.sum(self.data) }

pub fn StatsdescorderSlice::mean(self : StatsdescorderSlice) -> Double { @_common.mean(self.data) }

pub fn StatsdescorderSlice::scale(self : StatsdescorderSlice, f : Double) -> StatsdescorderSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsdescorderSlice::add(self : StatsdescorderSlice, other : StatsdescorderSlice) -> StatsdescorderSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsdescorderSlice::copy(self : StatsdescorderSlice) -> StatsdescorderSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsdescorderSlice::fill(self : StatsdescorderSlice, v : Double) -> StatsdescorderSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsdescorderSlice::min(self : StatsdescorderSlice) -> Double { @_common.min(self.data) }

pub fn StatsdescorderSlice::max(self : StatsdescorderSlice) -> Double { @_common.max(self.data) }

pub fn StatsdescorderSlice::to_string(self : StatsdescorderSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

