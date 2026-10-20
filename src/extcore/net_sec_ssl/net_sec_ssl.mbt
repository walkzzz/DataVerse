///===
/// extcore/net_sec_ssl

pub(all) struct NetsecsslPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_sec_ssl_make_point(x : Double, y : Double) -> NetsecsslPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_sec_ssl_make_point3(x : Double, y : Double, z : Double) -> NetsecsslPoint {
  { x, y, z, label: 0 }
}

pub fn NetsecsslPoint::x(self : NetsecsslPoint) -> Double { self.x }

pub fn NetsecsslPoint::y(self : NetsecsslPoint) -> Double { self.y }

pub fn NetsecsslPoint::z(self : NetsecsslPoint) -> Double { self.z }

pub fn NetsecsslPoint::label(self : NetsecsslPoint) -> Int { self.label }

pub fn NetsecsslPoint::dist(self : NetsecsslPoint, other : NetsecsslPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetsecsslPoint::add(self : NetsecsslPoint, other : NetsecsslPoint) -> NetsecsslPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetsecsslPoint::sub(self : NetsecsslPoint, other : NetsecsslPoint) -> NetsecsslPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetsecsslPoint::scale(self : NetsecsslPoint, s : Double) -> NetsecsslPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetsecsslPoint::dot(self : NetsecsslPoint, other : NetsecsslPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetsecsslPoint::cross(self : NetsecsslPoint, other : NetsecsslPoint) -> NetsecsslPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetsecsslPoint::norm(self : NetsecsslPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetsecsslPoint::normalize(self : NetsecsslPoint) -> NetsecsslPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetsecsslPoint::negate(self : NetsecsslPoint) -> NetsecsslPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetsecsslPoint::mid(self : NetsecsslPoint, other : NetsecsslPoint) -> NetsecsslPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetsecsslPoint::lerp(self : NetsecsslPoint, other : NetsecsslPoint, t : Double) -> NetsecsslPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetsecsslPoint::to_string(self : NetsecsslPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetsecsslSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_sec_ssl_make_series(vals : Array[Double], name : String) -> NetsecsslSeries {
  { vals, name, meta: 0 }
}

pub fn NetsecsslSeries::len(self : NetsecsslSeries) -> Int { self.vals.length() }

pub fn NetsecsslSeries::sum(self : NetsecsslSeries) -> Double { @_common.sum(self.vals) }

pub fn NetsecsslSeries::mean(self : NetsecsslSeries) -> Double { @_common.mean(self.vals) }

pub fn NetsecsslSeries::min(self : NetsecsslSeries) -> Double { @_common.min(self.vals) }

pub fn NetsecsslSeries::max(self : NetsecsslSeries) -> Double { @_common.max(self.vals) }

pub fn NetsecsslSeries::range(self : NetsecsslSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetsecsslSeries::variance(self : NetsecsslSeries) -> Double { @_common.variance(self.vals) }

pub fn NetsecsslSeries::std(self : NetsecsslSeries) -> Double { @_common.std(self.vals) }

pub fn NetsecsslSeries::median(self : NetsecsslSeries) -> Double { @_common.median(self.vals) }

pub fn NetsecsslSeries::scale(self : NetsecsslSeries, f : Double) -> NetsecsslSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetsecsslSeries::add(self : NetsecsslSeries, other : NetsecsslSeries) -> NetsecsslSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetsecsslSeries::sub(self : NetsecsslSeries, other : NetsecsslSeries) -> NetsecsslSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetsecsslSeries::normalize(self : NetsecsslSeries) -> NetsecsslSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetsecsslSeries::cumsum(self : NetsecsslSeries) -> NetsecsslSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetsecsslSeries::to_string(self : NetsecsslSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetsecsslMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_sec_ssl_make_matrix(rows : Int, cols : Int, val : Double) -> NetsecsslMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_sec_ssl_matrix_identity(n : Int) -> NetsecsslMatrix {
  let m = net_sec_ssl_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetsecsslMatrix::get(self : NetsecsslMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetsecsslMatrix::transpose(self : NetsecsslMatrix) -> NetsecsslMatrix {
  let result = net_sec_ssl_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetsecsslMatrix::add(self : NetsecsslMatrix, other : NetsecsslMatrix) -> NetsecsslMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_sec_ssl_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetsecsslMatrix::scale(self : NetsecsslMatrix, s : Double) -> NetsecsslMatrix {
  let result = net_sec_ssl_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetsecsslMatrix::multiply(self : NetsecsslMatrix, other : NetsecsslMatrix) -> NetsecsslMatrix {
  if self.cols != other.rows { return net_sec_ssl_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_sec_ssl_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NetsecsslMatrix::trace(self : NetsecsslMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetsecsslMatrix::det(self : NetsecsslMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetsecsslMatrix::norm(self : NetsecsslMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetsecsslMatrix::to_string(self : NetsecsslMatrix) -> String {
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

pub(all) struct NetsecsslVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_sec_ssl_make_vector(comps : Array[Double]) -> NetsecsslVector {
  { comps, dim: comps.length() }
}

pub fn net_sec_ssl_vector_zero(dim : Int) -> NetsecsslVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetsecsslVector::add(self : NetsecsslVector, other : NetsecsslVector) -> NetsecsslVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetsecsslVector::sub(self : NetsecsslVector, other : NetsecsslVector) -> NetsecsslVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetsecsslVector::scale(self : NetsecsslVector, s : Double) -> NetsecsslVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetsecsslVector::dot(self : NetsecsslVector, other : NetsecsslVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetsecsslVector::norm(self : NetsecsslVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetsecsslVector::normalize(self : NetsecsslVector) -> NetsecsslVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetsecsslVector::dist(self : NetsecsslVector, other : NetsecsslVector) -> Double {
  self.sub(other).norm()
}

pub fn NetsecsslVector::to_string(self : NetsecsslVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetsecsslFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ssl_frame_make(size : Int) -> NetsecsslFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecsslFrame::len(self : NetsecsslFrame) -> Int { self.size }

pub fn NetsecsslFrame::get(self : NetsecsslFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecsslFrame::set(self : NetsecsslFrame, i : Int, v : Double) -> NetsecsslFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecsslFrame::sum(self : NetsecsslFrame) -> Double { @_common.sum(self.data) }

pub fn NetsecsslFrame::mean(self : NetsecsslFrame) -> Double { @_common.mean(self.data) }

pub fn NetsecsslFrame::scale(self : NetsecsslFrame, f : Double) -> NetsecsslFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecsslFrame::add(self : NetsecsslFrame, other : NetsecsslFrame) -> NetsecsslFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecsslFrame::copy(self : NetsecsslFrame) -> NetsecsslFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecsslFrame::fill(self : NetsecsslFrame, v : Double) -> NetsecsslFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecsslFrame::min(self : NetsecsslFrame) -> Double { @_common.min(self.data) }

pub fn NetsecsslFrame::max(self : NetsecsslFrame) -> Double { @_common.max(self.data) }

pub fn NetsecsslFrame::to_string(self : NetsecsslFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecsslTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ssl_table_make(size : Int) -> NetsecsslTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecsslTable::len(self : NetsecsslTable) -> Int { self.size }

pub fn NetsecsslTable::get(self : NetsecsslTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecsslTable::set(self : NetsecsslTable, i : Int, v : Double) -> NetsecsslTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecsslTable::sum(self : NetsecsslTable) -> Double { @_common.sum(self.data) }

pub fn NetsecsslTable::mean(self : NetsecsslTable) -> Double { @_common.mean(self.data) }

pub fn NetsecsslTable::scale(self : NetsecsslTable, f : Double) -> NetsecsslTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecsslTable::add(self : NetsecsslTable, other : NetsecsslTable) -> NetsecsslTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecsslTable::copy(self : NetsecsslTable) -> NetsecsslTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecsslTable::fill(self : NetsecsslTable, v : Double) -> NetsecsslTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecsslTable::min(self : NetsecsslTable) -> Double { @_common.min(self.data) }

pub fn NetsecsslTable::max(self : NetsecsslTable) -> Double { @_common.max(self.data) }

pub fn NetsecsslTable::to_string(self : NetsecsslTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecsslGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ssl_graphn_make(size : Int) -> NetsecsslGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecsslGraphN::len(self : NetsecsslGraphN) -> Int { self.size }

pub fn NetsecsslGraphN::get(self : NetsecsslGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecsslGraphN::set(self : NetsecsslGraphN, i : Int, v : Double) -> NetsecsslGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecsslGraphN::sum(self : NetsecsslGraphN) -> Double { @_common.sum(self.data) }

pub fn NetsecsslGraphN::mean(self : NetsecsslGraphN) -> Double { @_common.mean(self.data) }

pub fn NetsecsslGraphN::scale(self : NetsecsslGraphN, f : Double) -> NetsecsslGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecsslGraphN::add(self : NetsecsslGraphN, other : NetsecsslGraphN) -> NetsecsslGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecsslGraphN::copy(self : NetsecsslGraphN) -> NetsecsslGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecsslGraphN::fill(self : NetsecsslGraphN, v : Double) -> NetsecsslGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecsslGraphN::min(self : NetsecsslGraphN) -> Double { @_common.min(self.data) }

pub fn NetsecsslGraphN::max(self : NetsecsslGraphN) -> Double { @_common.max(self.data) }

pub fn NetsecsslGraphN::to_string(self : NetsecsslGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecsslNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ssl_node_make(size : Int) -> NetsecsslNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecsslNode::len(self : NetsecsslNode) -> Int { self.size }

pub fn NetsecsslNode::get(self : NetsecsslNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecsslNode::set(self : NetsecsslNode, i : Int, v : Double) -> NetsecsslNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecsslNode::sum(self : NetsecsslNode) -> Double { @_common.sum(self.data) }

pub fn NetsecsslNode::mean(self : NetsecsslNode) -> Double { @_common.mean(self.data) }

pub fn NetsecsslNode::scale(self : NetsecsslNode, f : Double) -> NetsecsslNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecsslNode::add(self : NetsecsslNode, other : NetsecsslNode) -> NetsecsslNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecsslNode::copy(self : NetsecsslNode) -> NetsecsslNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecsslNode::fill(self : NetsecsslNode, v : Double) -> NetsecsslNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecsslNode::min(self : NetsecsslNode) -> Double { @_common.min(self.data) }

pub fn NetsecsslNode::max(self : NetsecsslNode) -> Double { @_common.max(self.data) }

pub fn NetsecsslNode::to_string(self : NetsecsslNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecsslEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ssl_edge_make(size : Int) -> NetsecsslEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecsslEdge::len(self : NetsecsslEdge) -> Int { self.size }

pub fn NetsecsslEdge::get(self : NetsecsslEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecsslEdge::set(self : NetsecsslEdge, i : Int, v : Double) -> NetsecsslEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecsslEdge::sum(self : NetsecsslEdge) -> Double { @_common.sum(self.data) }

pub fn NetsecsslEdge::mean(self : NetsecsslEdge) -> Double { @_common.mean(self.data) }

pub fn NetsecsslEdge::scale(self : NetsecsslEdge, f : Double) -> NetsecsslEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecsslEdge::add(self : NetsecsslEdge, other : NetsecsslEdge) -> NetsecsslEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecsslEdge::copy(self : NetsecsslEdge) -> NetsecsslEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecsslEdge::fill(self : NetsecsslEdge, v : Double) -> NetsecsslEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecsslEdge::min(self : NetsecsslEdge) -> Double { @_common.min(self.data) }

pub fn NetsecsslEdge::max(self : NetsecsslEdge) -> Double { @_common.max(self.data) }

pub fn NetsecsslEdge::to_string(self : NetsecsslEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecsslPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ssl_path_make(size : Int) -> NetsecsslPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecsslPath::len(self : NetsecsslPath) -> Int { self.size }

pub fn NetsecsslPath::get(self : NetsecsslPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecsslPath::set(self : NetsecsslPath, i : Int, v : Double) -> NetsecsslPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecsslPath::sum(self : NetsecsslPath) -> Double { @_common.sum(self.data) }

pub fn NetsecsslPath::mean(self : NetsecsslPath) -> Double { @_common.mean(self.data) }

pub fn NetsecsslPath::scale(self : NetsecsslPath, f : Double) -> NetsecsslPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecsslPath::add(self : NetsecsslPath, other : NetsecsslPath) -> NetsecsslPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecsslPath::copy(self : NetsecsslPath) -> NetsecsslPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecsslPath::fill(self : NetsecsslPath, v : Double) -> NetsecsslPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecsslPath::min(self : NetsecsslPath) -> Double { @_common.min(self.data) }

pub fn NetsecsslPath::max(self : NetsecsslPath) -> Double { @_common.max(self.data) }

pub fn NetsecsslPath::to_string(self : NetsecsslPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecsslCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ssl_cluster_make(size : Int) -> NetsecsslCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecsslCluster::len(self : NetsecsslCluster) -> Int { self.size }

pub fn NetsecsslCluster::get(self : NetsecsslCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecsslCluster::set(self : NetsecsslCluster, i : Int, v : Double) -> NetsecsslCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecsslCluster::sum(self : NetsecsslCluster) -> Double { @_common.sum(self.data) }

pub fn NetsecsslCluster::mean(self : NetsecsslCluster) -> Double { @_common.mean(self.data) }

pub fn NetsecsslCluster::scale(self : NetsecsslCluster, f : Double) -> NetsecsslCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecsslCluster::add(self : NetsecsslCluster, other : NetsecsslCluster) -> NetsecsslCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecsslCluster::copy(self : NetsecsslCluster) -> NetsecsslCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecsslCluster::fill(self : NetsecsslCluster, v : Double) -> NetsecsslCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecsslCluster::min(self : NetsecsslCluster) -> Double { @_common.min(self.data) }

pub fn NetsecsslCluster::max(self : NetsecsslCluster) -> Double { @_common.max(self.data) }

pub fn NetsecsslCluster::to_string(self : NetsecsslCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecsslModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ssl_model_make(size : Int) -> NetsecsslModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecsslModel::len(self : NetsecsslModel) -> Int { self.size }

pub fn NetsecsslModel::get(self : NetsecsslModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecsslModel::set(self : NetsecsslModel, i : Int, v : Double) -> NetsecsslModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecsslModel::sum(self : NetsecsslModel) -> Double { @_common.sum(self.data) }

pub fn NetsecsslModel::mean(self : NetsecsslModel) -> Double { @_common.mean(self.data) }

pub fn NetsecsslModel::scale(self : NetsecsslModel, f : Double) -> NetsecsslModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecsslModel::add(self : NetsecsslModel, other : NetsecsslModel) -> NetsecsslModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecsslModel::copy(self : NetsecsslModel) -> NetsecsslModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecsslModel::fill(self : NetsecsslModel, v : Double) -> NetsecsslModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecsslModel::min(self : NetsecsslModel) -> Double { @_common.min(self.data) }

pub fn NetsecsslModel::max(self : NetsecsslModel) -> Double { @_common.max(self.data) }

pub fn NetsecsslModel::to_string(self : NetsecsslModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecsslLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ssl_layer_make(size : Int) -> NetsecsslLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecsslLayer::len(self : NetsecsslLayer) -> Int { self.size }

pub fn NetsecsslLayer::get(self : NetsecsslLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecsslLayer::set(self : NetsecsslLayer, i : Int, v : Double) -> NetsecsslLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecsslLayer::sum(self : NetsecsslLayer) -> Double { @_common.sum(self.data) }

pub fn NetsecsslLayer::mean(self : NetsecsslLayer) -> Double { @_common.mean(self.data) }

pub fn NetsecsslLayer::scale(self : NetsecsslLayer, f : Double) -> NetsecsslLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecsslLayer::add(self : NetsecsslLayer, other : NetsecsslLayer) -> NetsecsslLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecsslLayer::copy(self : NetsecsslLayer) -> NetsecsslLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecsslLayer::fill(self : NetsecsslLayer, v : Double) -> NetsecsslLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecsslLayer::min(self : NetsecsslLayer) -> Double { @_common.min(self.data) }

pub fn NetsecsslLayer::max(self : NetsecsslLayer) -> Double { @_common.max(self.data) }

pub fn NetsecsslLayer::to_string(self : NetsecsslLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecsslBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ssl_buffer_make(size : Int) -> NetsecsslBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecsslBuffer::len(self : NetsecsslBuffer) -> Int { self.size }

pub fn NetsecsslBuffer::get(self : NetsecsslBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecsslBuffer::set(self : NetsecsslBuffer, i : Int, v : Double) -> NetsecsslBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecsslBuffer::sum(self : NetsecsslBuffer) -> Double { @_common.sum(self.data) }

pub fn NetsecsslBuffer::mean(self : NetsecsslBuffer) -> Double { @_common.mean(self.data) }

pub fn NetsecsslBuffer::scale(self : NetsecsslBuffer, f : Double) -> NetsecsslBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecsslBuffer::add(self : NetsecsslBuffer, other : NetsecsslBuffer) -> NetsecsslBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecsslBuffer::copy(self : NetsecsslBuffer) -> NetsecsslBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecsslBuffer::fill(self : NetsecsslBuffer, v : Double) -> NetsecsslBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecsslBuffer::min(self : NetsecsslBuffer) -> Double { @_common.min(self.data) }

pub fn NetsecsslBuffer::max(self : NetsecsslBuffer) -> Double { @_common.max(self.data) }

pub fn NetsecsslBuffer::to_string(self : NetsecsslBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecsslCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ssl_cursor_make(size : Int) -> NetsecsslCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecsslCursor::len(self : NetsecsslCursor) -> Int { self.size }

pub fn NetsecsslCursor::get(self : NetsecsslCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecsslCursor::set(self : NetsecsslCursor, i : Int, v : Double) -> NetsecsslCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecsslCursor::sum(self : NetsecsslCursor) -> Double { @_common.sum(self.data) }

pub fn NetsecsslCursor::mean(self : NetsecsslCursor) -> Double { @_common.mean(self.data) }

pub fn NetsecsslCursor::scale(self : NetsecsslCursor, f : Double) -> NetsecsslCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecsslCursor::add(self : NetsecsslCursor, other : NetsecsslCursor) -> NetsecsslCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecsslCursor::copy(self : NetsecsslCursor) -> NetsecsslCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecsslCursor::fill(self : NetsecsslCursor, v : Double) -> NetsecsslCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecsslCursor::min(self : NetsecsslCursor) -> Double { @_common.min(self.data) }

pub fn NetsecsslCursor::max(self : NetsecsslCursor) -> Double { @_common.max(self.data) }

pub fn NetsecsslCursor::to_string(self : NetsecsslCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecsslView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ssl_view_make(size : Int) -> NetsecsslView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecsslView::len(self : NetsecsslView) -> Int { self.size }

pub fn NetsecsslView::get(self : NetsecsslView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecsslView::set(self : NetsecsslView, i : Int, v : Double) -> NetsecsslView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecsslView::sum(self : NetsecsslView) -> Double { @_common.sum(self.data) }

pub fn NetsecsslView::mean(self : NetsecsslView) -> Double { @_common.mean(self.data) }

pub fn NetsecsslView::scale(self : NetsecsslView, f : Double) -> NetsecsslView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecsslView::add(self : NetsecsslView, other : NetsecsslView) -> NetsecsslView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecsslView::copy(self : NetsecsslView) -> NetsecsslView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecsslView::fill(self : NetsecsslView, v : Double) -> NetsecsslView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecsslView::min(self : NetsecsslView) -> Double { @_common.min(self.data) }

pub fn NetsecsslView::max(self : NetsecsslView) -> Double { @_common.max(self.data) }

pub fn NetsecsslView::to_string(self : NetsecsslView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecsslRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ssl_range_make(size : Int) -> NetsecsslRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecsslRange::len(self : NetsecsslRange) -> Int { self.size }

pub fn NetsecsslRange::get(self : NetsecsslRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecsslRange::set(self : NetsecsslRange, i : Int, v : Double) -> NetsecsslRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecsslRange::sum(self : NetsecsslRange) -> Double { @_common.sum(self.data) }

pub fn NetsecsslRange::mean(self : NetsecsslRange) -> Double { @_common.mean(self.data) }

pub fn NetsecsslRange::scale(self : NetsecsslRange, f : Double) -> NetsecsslRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecsslRange::add(self : NetsecsslRange, other : NetsecsslRange) -> NetsecsslRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecsslRange::copy(self : NetsecsslRange) -> NetsecsslRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecsslRange::fill(self : NetsecsslRange, v : Double) -> NetsecsslRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecsslRange::min(self : NetsecsslRange) -> Double { @_common.min(self.data) }

pub fn NetsecsslRange::max(self : NetsecsslRange) -> Double { @_common.max(self.data) }

pub fn NetsecsslRange::to_string(self : NetsecsslRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecsslSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ssl_slice_make(size : Int) -> NetsecsslSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecsslSlice::len(self : NetsecsslSlice) -> Int { self.size }

pub fn NetsecsslSlice::get(self : NetsecsslSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecsslSlice::set(self : NetsecsslSlice, i : Int, v : Double) -> NetsecsslSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecsslSlice::sum(self : NetsecsslSlice) -> Double { @_common.sum(self.data) }

pub fn NetsecsslSlice::mean(self : NetsecsslSlice) -> Double { @_common.mean(self.data) }

pub fn NetsecsslSlice::scale(self : NetsecsslSlice, f : Double) -> NetsecsslSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecsslSlice::add(self : NetsecsslSlice, other : NetsecsslSlice) -> NetsecsslSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecsslSlice::copy(self : NetsecsslSlice) -> NetsecsslSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecsslSlice::fill(self : NetsecsslSlice, v : Double) -> NetsecsslSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecsslSlice::min(self : NetsecsslSlice) -> Double { @_common.min(self.data) }

pub fn NetsecsslSlice::max(self : NetsecsslSlice) -> Double { @_common.max(self.data) }

pub fn NetsecsslSlice::to_string(self : NetsecsslSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

