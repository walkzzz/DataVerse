///===
/// extcore/net_sec_rate_limit

pub(all) struct NetsecratelimitPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_sec_rate_limit_make_point(x : Double, y : Double) -> NetsecratelimitPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_sec_rate_limit_make_point3(x : Double, y : Double, z : Double) -> NetsecratelimitPoint {
  { x, y, z, label: 0 }
}

pub fn NetsecratelimitPoint::x(self : NetsecratelimitPoint) -> Double { self.x }

pub fn NetsecratelimitPoint::y(self : NetsecratelimitPoint) -> Double { self.y }

pub fn NetsecratelimitPoint::z(self : NetsecratelimitPoint) -> Double { self.z }

pub fn NetsecratelimitPoint::label(self : NetsecratelimitPoint) -> Int { self.label }

pub fn NetsecratelimitPoint::dist(self : NetsecratelimitPoint, other : NetsecratelimitPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetsecratelimitPoint::add(self : NetsecratelimitPoint, other : NetsecratelimitPoint) -> NetsecratelimitPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetsecratelimitPoint::sub(self : NetsecratelimitPoint, other : NetsecratelimitPoint) -> NetsecratelimitPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetsecratelimitPoint::scale(self : NetsecratelimitPoint, s : Double) -> NetsecratelimitPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetsecratelimitPoint::dot(self : NetsecratelimitPoint, other : NetsecratelimitPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetsecratelimitPoint::cross(self : NetsecratelimitPoint, other : NetsecratelimitPoint) -> NetsecratelimitPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetsecratelimitPoint::norm(self : NetsecratelimitPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetsecratelimitPoint::normalize(self : NetsecratelimitPoint) -> NetsecratelimitPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetsecratelimitPoint::negate(self : NetsecratelimitPoint) -> NetsecratelimitPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetsecratelimitPoint::mid(self : NetsecratelimitPoint, other : NetsecratelimitPoint) -> NetsecratelimitPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetsecratelimitPoint::lerp(self : NetsecratelimitPoint, other : NetsecratelimitPoint, t : Double) -> NetsecratelimitPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetsecratelimitPoint::to_string(self : NetsecratelimitPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetsecratelimitSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_sec_rate_limit_make_series(vals : Array[Double], name : String) -> NetsecratelimitSeries {
  { vals, name, meta: 0 }
}

pub fn NetsecratelimitSeries::len(self : NetsecratelimitSeries) -> Int { self.vals.length() }

pub fn NetsecratelimitSeries::sum(self : NetsecratelimitSeries) -> Double { @_common.sum(self.vals) }

pub fn NetsecratelimitSeries::mean(self : NetsecratelimitSeries) -> Double { @_common.mean(self.vals) }

pub fn NetsecratelimitSeries::min(self : NetsecratelimitSeries) -> Double { @_common.min(self.vals) }

pub fn NetsecratelimitSeries::max(self : NetsecratelimitSeries) -> Double { @_common.max(self.vals) }

pub fn NetsecratelimitSeries::range(self : NetsecratelimitSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetsecratelimitSeries::variance(self : NetsecratelimitSeries) -> Double { @_common.variance(self.vals) }

pub fn NetsecratelimitSeries::std(self : NetsecratelimitSeries) -> Double { @_common.std(self.vals) }

pub fn NetsecratelimitSeries::median(self : NetsecratelimitSeries) -> Double { @_common.median(self.vals) }

pub fn NetsecratelimitSeries::scale(self : NetsecratelimitSeries, f : Double) -> NetsecratelimitSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetsecratelimitSeries::add(self : NetsecratelimitSeries, other : NetsecratelimitSeries) -> NetsecratelimitSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetsecratelimitSeries::sub(self : NetsecratelimitSeries, other : NetsecratelimitSeries) -> NetsecratelimitSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetsecratelimitSeries::normalize(self : NetsecratelimitSeries) -> NetsecratelimitSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetsecratelimitSeries::cumsum(self : NetsecratelimitSeries) -> NetsecratelimitSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetsecratelimitSeries::to_string(self : NetsecratelimitSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetsecratelimitMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_sec_rate_limit_make_matrix(rows : Int, cols : Int, val : Double) -> NetsecratelimitMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_sec_rate_limit_matrix_identity(n : Int) -> NetsecratelimitMatrix {
  let m = net_sec_rate_limit_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetsecratelimitMatrix::get(self : NetsecratelimitMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetsecratelimitMatrix::transpose(self : NetsecratelimitMatrix) -> NetsecratelimitMatrix {
  let result = net_sec_rate_limit_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetsecratelimitMatrix::add(self : NetsecratelimitMatrix, other : NetsecratelimitMatrix) -> NetsecratelimitMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_sec_rate_limit_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetsecratelimitMatrix::scale(self : NetsecratelimitMatrix, s : Double) -> NetsecratelimitMatrix {
  let result = net_sec_rate_limit_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetsecratelimitMatrix::multiply(self : NetsecratelimitMatrix, other : NetsecratelimitMatrix) -> NetsecratelimitMatrix {
  if self.cols != other.rows { return net_sec_rate_limit_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_sec_rate_limit_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn NetsecratelimitMatrix::trace(self : NetsecratelimitMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetsecratelimitMatrix::det(self : NetsecratelimitMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetsecratelimitMatrix::norm(self : NetsecratelimitMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetsecratelimitMatrix::to_string(self : NetsecratelimitMatrix) -> String {
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

pub(all) struct NetsecratelimitVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_sec_rate_limit_make_vector(comps : Array[Double]) -> NetsecratelimitVector {
  { comps, dim: comps.length() }
}

pub fn net_sec_rate_limit_vector_zero(dim : Int) -> NetsecratelimitVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetsecratelimitVector::add(self : NetsecratelimitVector, other : NetsecratelimitVector) -> NetsecratelimitVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetsecratelimitVector::sub(self : NetsecratelimitVector, other : NetsecratelimitVector) -> NetsecratelimitVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetsecratelimitVector::scale(self : NetsecratelimitVector, s : Double) -> NetsecratelimitVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetsecratelimitVector::dot(self : NetsecratelimitVector, other : NetsecratelimitVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetsecratelimitVector::norm(self : NetsecratelimitVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetsecratelimitVector::normalize(self : NetsecratelimitVector) -> NetsecratelimitVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetsecratelimitVector::dist(self : NetsecratelimitVector, other : NetsecratelimitVector) -> Double {
  self.sub(other).norm()
}

pub fn NetsecratelimitVector::to_string(self : NetsecratelimitVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetsecratelimitFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_rate_limit_frame_make(size : Int) -> NetsecratelimitFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecratelimitFrame::len(self : NetsecratelimitFrame) -> Int { self.size }

pub fn NetsecratelimitFrame::get(self : NetsecratelimitFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecratelimitFrame::set(self : NetsecratelimitFrame, i : Int, v : Double) -> NetsecratelimitFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecratelimitFrame::sum(self : NetsecratelimitFrame) -> Double { @_common.sum(self.data) }

pub fn NetsecratelimitFrame::mean(self : NetsecratelimitFrame) -> Double { @_common.mean(self.data) }

pub fn NetsecratelimitFrame::scale(self : NetsecratelimitFrame, f : Double) -> NetsecratelimitFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecratelimitFrame::add(self : NetsecratelimitFrame, other : NetsecratelimitFrame) -> NetsecratelimitFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecratelimitFrame::copy(self : NetsecratelimitFrame) -> NetsecratelimitFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecratelimitFrame::fill(self : NetsecratelimitFrame, v : Double) -> NetsecratelimitFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecratelimitFrame::min(self : NetsecratelimitFrame) -> Double { @_common.min(self.data) }

pub fn NetsecratelimitFrame::max(self : NetsecratelimitFrame) -> Double { @_common.max(self.data) }

pub fn NetsecratelimitFrame::to_string(self : NetsecratelimitFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecratelimitTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_rate_limit_table_make(size : Int) -> NetsecratelimitTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecratelimitTable::len(self : NetsecratelimitTable) -> Int { self.size }

pub fn NetsecratelimitTable::get(self : NetsecratelimitTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecratelimitTable::set(self : NetsecratelimitTable, i : Int, v : Double) -> NetsecratelimitTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecratelimitTable::sum(self : NetsecratelimitTable) -> Double { @_common.sum(self.data) }

pub fn NetsecratelimitTable::mean(self : NetsecratelimitTable) -> Double { @_common.mean(self.data) }

pub fn NetsecratelimitTable::scale(self : NetsecratelimitTable, f : Double) -> NetsecratelimitTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecratelimitTable::add(self : NetsecratelimitTable, other : NetsecratelimitTable) -> NetsecratelimitTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecratelimitTable::copy(self : NetsecratelimitTable) -> NetsecratelimitTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecratelimitTable::fill(self : NetsecratelimitTable, v : Double) -> NetsecratelimitTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecratelimitTable::min(self : NetsecratelimitTable) -> Double { @_common.min(self.data) }

pub fn NetsecratelimitTable::max(self : NetsecratelimitTable) -> Double { @_common.max(self.data) }

pub fn NetsecratelimitTable::to_string(self : NetsecratelimitTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecratelimitGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_rate_limit_graphn_make(size : Int) -> NetsecratelimitGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecratelimitGraphN::len(self : NetsecratelimitGraphN) -> Int { self.size }

pub fn NetsecratelimitGraphN::get(self : NetsecratelimitGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecratelimitGraphN::set(self : NetsecratelimitGraphN, i : Int, v : Double) -> NetsecratelimitGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecratelimitGraphN::sum(self : NetsecratelimitGraphN) -> Double { @_common.sum(self.data) }

pub fn NetsecratelimitGraphN::mean(self : NetsecratelimitGraphN) -> Double { @_common.mean(self.data) }

pub fn NetsecratelimitGraphN::scale(self : NetsecratelimitGraphN, f : Double) -> NetsecratelimitGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecratelimitGraphN::add(self : NetsecratelimitGraphN, other : NetsecratelimitGraphN) -> NetsecratelimitGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecratelimitGraphN::copy(self : NetsecratelimitGraphN) -> NetsecratelimitGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecratelimitGraphN::fill(self : NetsecratelimitGraphN, v : Double) -> NetsecratelimitGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecratelimitGraphN::min(self : NetsecratelimitGraphN) -> Double { @_common.min(self.data) }

pub fn NetsecratelimitGraphN::max(self : NetsecratelimitGraphN) -> Double { @_common.max(self.data) }

pub fn NetsecratelimitGraphN::to_string(self : NetsecratelimitGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecratelimitNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_rate_limit_node_make(size : Int) -> NetsecratelimitNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecratelimitNode::len(self : NetsecratelimitNode) -> Int { self.size }

pub fn NetsecratelimitNode::get(self : NetsecratelimitNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecratelimitNode::set(self : NetsecratelimitNode, i : Int, v : Double) -> NetsecratelimitNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecratelimitNode::sum(self : NetsecratelimitNode) -> Double { @_common.sum(self.data) }

pub fn NetsecratelimitNode::mean(self : NetsecratelimitNode) -> Double { @_common.mean(self.data) }

pub fn NetsecratelimitNode::scale(self : NetsecratelimitNode, f : Double) -> NetsecratelimitNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecratelimitNode::add(self : NetsecratelimitNode, other : NetsecratelimitNode) -> NetsecratelimitNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecratelimitNode::copy(self : NetsecratelimitNode) -> NetsecratelimitNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecratelimitNode::fill(self : NetsecratelimitNode, v : Double) -> NetsecratelimitNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecratelimitNode::min(self : NetsecratelimitNode) -> Double { @_common.min(self.data) }

pub fn NetsecratelimitNode::max(self : NetsecratelimitNode) -> Double { @_common.max(self.data) }

pub fn NetsecratelimitNode::to_string(self : NetsecratelimitNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecratelimitEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_rate_limit_edge_make(size : Int) -> NetsecratelimitEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecratelimitEdge::len(self : NetsecratelimitEdge) -> Int { self.size }

pub fn NetsecratelimitEdge::get(self : NetsecratelimitEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecratelimitEdge::set(self : NetsecratelimitEdge, i : Int, v : Double) -> NetsecratelimitEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecratelimitEdge::sum(self : NetsecratelimitEdge) -> Double { @_common.sum(self.data) }

pub fn NetsecratelimitEdge::mean(self : NetsecratelimitEdge) -> Double { @_common.mean(self.data) }

pub fn NetsecratelimitEdge::scale(self : NetsecratelimitEdge, f : Double) -> NetsecratelimitEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecratelimitEdge::add(self : NetsecratelimitEdge, other : NetsecratelimitEdge) -> NetsecratelimitEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecratelimitEdge::copy(self : NetsecratelimitEdge) -> NetsecratelimitEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecratelimitEdge::fill(self : NetsecratelimitEdge, v : Double) -> NetsecratelimitEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecratelimitEdge::min(self : NetsecratelimitEdge) -> Double { @_common.min(self.data) }

pub fn NetsecratelimitEdge::max(self : NetsecratelimitEdge) -> Double { @_common.max(self.data) }

pub fn NetsecratelimitEdge::to_string(self : NetsecratelimitEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecratelimitPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_rate_limit_path_make(size : Int) -> NetsecratelimitPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecratelimitPath::len(self : NetsecratelimitPath) -> Int { self.size }

pub fn NetsecratelimitPath::get(self : NetsecratelimitPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecratelimitPath::set(self : NetsecratelimitPath, i : Int, v : Double) -> NetsecratelimitPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecratelimitPath::sum(self : NetsecratelimitPath) -> Double { @_common.sum(self.data) }

pub fn NetsecratelimitPath::mean(self : NetsecratelimitPath) -> Double { @_common.mean(self.data) }

pub fn NetsecratelimitPath::scale(self : NetsecratelimitPath, f : Double) -> NetsecratelimitPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecratelimitPath::add(self : NetsecratelimitPath, other : NetsecratelimitPath) -> NetsecratelimitPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecratelimitPath::copy(self : NetsecratelimitPath) -> NetsecratelimitPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecratelimitPath::fill(self : NetsecratelimitPath, v : Double) -> NetsecratelimitPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecratelimitPath::min(self : NetsecratelimitPath) -> Double { @_common.min(self.data) }

pub fn NetsecratelimitPath::max(self : NetsecratelimitPath) -> Double { @_common.max(self.data) }

pub fn NetsecratelimitPath::to_string(self : NetsecratelimitPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecratelimitCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_rate_limit_cluster_make(size : Int) -> NetsecratelimitCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecratelimitCluster::len(self : NetsecratelimitCluster) -> Int { self.size }

pub fn NetsecratelimitCluster::get(self : NetsecratelimitCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecratelimitCluster::set(self : NetsecratelimitCluster, i : Int, v : Double) -> NetsecratelimitCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecratelimitCluster::sum(self : NetsecratelimitCluster) -> Double { @_common.sum(self.data) }

pub fn NetsecratelimitCluster::mean(self : NetsecratelimitCluster) -> Double { @_common.mean(self.data) }

pub fn NetsecratelimitCluster::scale(self : NetsecratelimitCluster, f : Double) -> NetsecratelimitCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecratelimitCluster::add(self : NetsecratelimitCluster, other : NetsecratelimitCluster) -> NetsecratelimitCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecratelimitCluster::copy(self : NetsecratelimitCluster) -> NetsecratelimitCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecratelimitCluster::fill(self : NetsecratelimitCluster, v : Double) -> NetsecratelimitCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecratelimitCluster::min(self : NetsecratelimitCluster) -> Double { @_common.min(self.data) }

pub fn NetsecratelimitCluster::max(self : NetsecratelimitCluster) -> Double { @_common.max(self.data) }

pub fn NetsecratelimitCluster::to_string(self : NetsecratelimitCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecratelimitModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_rate_limit_model_make(size : Int) -> NetsecratelimitModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecratelimitModel::len(self : NetsecratelimitModel) -> Int { self.size }

pub fn NetsecratelimitModel::get(self : NetsecratelimitModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecratelimitModel::set(self : NetsecratelimitModel, i : Int, v : Double) -> NetsecratelimitModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecratelimitModel::sum(self : NetsecratelimitModel) -> Double { @_common.sum(self.data) }

pub fn NetsecratelimitModel::mean(self : NetsecratelimitModel) -> Double { @_common.mean(self.data) }

pub fn NetsecratelimitModel::scale(self : NetsecratelimitModel, f : Double) -> NetsecratelimitModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecratelimitModel::add(self : NetsecratelimitModel, other : NetsecratelimitModel) -> NetsecratelimitModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecratelimitModel::copy(self : NetsecratelimitModel) -> NetsecratelimitModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecratelimitModel::fill(self : NetsecratelimitModel, v : Double) -> NetsecratelimitModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecratelimitModel::min(self : NetsecratelimitModel) -> Double { @_common.min(self.data) }

pub fn NetsecratelimitModel::max(self : NetsecratelimitModel) -> Double { @_common.max(self.data) }

pub fn NetsecratelimitModel::to_string(self : NetsecratelimitModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecratelimitLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_rate_limit_layer_make(size : Int) -> NetsecratelimitLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecratelimitLayer::len(self : NetsecratelimitLayer) -> Int { self.size }

pub fn NetsecratelimitLayer::get(self : NetsecratelimitLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecratelimitLayer::set(self : NetsecratelimitLayer, i : Int, v : Double) -> NetsecratelimitLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecratelimitLayer::sum(self : NetsecratelimitLayer) -> Double { @_common.sum(self.data) }

pub fn NetsecratelimitLayer::mean(self : NetsecratelimitLayer) -> Double { @_common.mean(self.data) }

pub fn NetsecratelimitLayer::scale(self : NetsecratelimitLayer, f : Double) -> NetsecratelimitLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecratelimitLayer::add(self : NetsecratelimitLayer, other : NetsecratelimitLayer) -> NetsecratelimitLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecratelimitLayer::copy(self : NetsecratelimitLayer) -> NetsecratelimitLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecratelimitLayer::fill(self : NetsecratelimitLayer, v : Double) -> NetsecratelimitLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecratelimitLayer::min(self : NetsecratelimitLayer) -> Double { @_common.min(self.data) }

pub fn NetsecratelimitLayer::max(self : NetsecratelimitLayer) -> Double { @_common.max(self.data) }

pub fn NetsecratelimitLayer::to_string(self : NetsecratelimitLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecratelimitBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_rate_limit_buffer_make(size : Int) -> NetsecratelimitBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecratelimitBuffer::len(self : NetsecratelimitBuffer) -> Int { self.size }

pub fn NetsecratelimitBuffer::get(self : NetsecratelimitBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecratelimitBuffer::set(self : NetsecratelimitBuffer, i : Int, v : Double) -> NetsecratelimitBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecratelimitBuffer::sum(self : NetsecratelimitBuffer) -> Double { @_common.sum(self.data) }

pub fn NetsecratelimitBuffer::mean(self : NetsecratelimitBuffer) -> Double { @_common.mean(self.data) }

pub fn NetsecratelimitBuffer::scale(self : NetsecratelimitBuffer, f : Double) -> NetsecratelimitBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecratelimitBuffer::add(self : NetsecratelimitBuffer, other : NetsecratelimitBuffer) -> NetsecratelimitBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecratelimitBuffer::copy(self : NetsecratelimitBuffer) -> NetsecratelimitBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecratelimitBuffer::fill(self : NetsecratelimitBuffer, v : Double) -> NetsecratelimitBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecratelimitBuffer::min(self : NetsecratelimitBuffer) -> Double { @_common.min(self.data) }

pub fn NetsecratelimitBuffer::max(self : NetsecratelimitBuffer) -> Double { @_common.max(self.data) }

pub fn NetsecratelimitBuffer::to_string(self : NetsecratelimitBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecratelimitCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_rate_limit_cursor_make(size : Int) -> NetsecratelimitCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecratelimitCursor::len(self : NetsecratelimitCursor) -> Int { self.size }

pub fn NetsecratelimitCursor::get(self : NetsecratelimitCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecratelimitCursor::set(self : NetsecratelimitCursor, i : Int, v : Double) -> NetsecratelimitCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecratelimitCursor::sum(self : NetsecratelimitCursor) -> Double { @_common.sum(self.data) }

pub fn NetsecratelimitCursor::mean(self : NetsecratelimitCursor) -> Double { @_common.mean(self.data) }

pub fn NetsecratelimitCursor::scale(self : NetsecratelimitCursor, f : Double) -> NetsecratelimitCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecratelimitCursor::add(self : NetsecratelimitCursor, other : NetsecratelimitCursor) -> NetsecratelimitCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecratelimitCursor::copy(self : NetsecratelimitCursor) -> NetsecratelimitCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecratelimitCursor::fill(self : NetsecratelimitCursor, v : Double) -> NetsecratelimitCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecratelimitCursor::min(self : NetsecratelimitCursor) -> Double { @_common.min(self.data) }

pub fn NetsecratelimitCursor::max(self : NetsecratelimitCursor) -> Double { @_common.max(self.data) }

pub fn NetsecratelimitCursor::to_string(self : NetsecratelimitCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecratelimitView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_rate_limit_view_make(size : Int) -> NetsecratelimitView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecratelimitView::len(self : NetsecratelimitView) -> Int { self.size }

pub fn NetsecratelimitView::get(self : NetsecratelimitView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecratelimitView::set(self : NetsecratelimitView, i : Int, v : Double) -> NetsecratelimitView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecratelimitView::sum(self : NetsecratelimitView) -> Double { @_common.sum(self.data) }

pub fn NetsecratelimitView::mean(self : NetsecratelimitView) -> Double { @_common.mean(self.data) }

pub fn NetsecratelimitView::scale(self : NetsecratelimitView, f : Double) -> NetsecratelimitView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecratelimitView::add(self : NetsecratelimitView, other : NetsecratelimitView) -> NetsecratelimitView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecratelimitView::copy(self : NetsecratelimitView) -> NetsecratelimitView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecratelimitView::fill(self : NetsecratelimitView, v : Double) -> NetsecratelimitView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecratelimitView::min(self : NetsecratelimitView) -> Double { @_common.min(self.data) }

pub fn NetsecratelimitView::max(self : NetsecratelimitView) -> Double { @_common.max(self.data) }

pub fn NetsecratelimitView::to_string(self : NetsecratelimitView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecratelimitRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_rate_limit_range_make(size : Int) -> NetsecratelimitRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecratelimitRange::len(self : NetsecratelimitRange) -> Int { self.size }

pub fn NetsecratelimitRange::get(self : NetsecratelimitRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecratelimitRange::set(self : NetsecratelimitRange, i : Int, v : Double) -> NetsecratelimitRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecratelimitRange::sum(self : NetsecratelimitRange) -> Double { @_common.sum(self.data) }

pub fn NetsecratelimitRange::mean(self : NetsecratelimitRange) -> Double { @_common.mean(self.data) }

pub fn NetsecratelimitRange::scale(self : NetsecratelimitRange, f : Double) -> NetsecratelimitRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecratelimitRange::add(self : NetsecratelimitRange, other : NetsecratelimitRange) -> NetsecratelimitRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecratelimitRange::copy(self : NetsecratelimitRange) -> NetsecratelimitRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecratelimitRange::fill(self : NetsecratelimitRange, v : Double) -> NetsecratelimitRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecratelimitRange::min(self : NetsecratelimitRange) -> Double { @_common.min(self.data) }

pub fn NetsecratelimitRange::max(self : NetsecratelimitRange) -> Double { @_common.max(self.data) }

pub fn NetsecratelimitRange::to_string(self : NetsecratelimitRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecratelimitSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_rate_limit_slice_make(size : Int) -> NetsecratelimitSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecratelimitSlice::len(self : NetsecratelimitSlice) -> Int { self.size }

pub fn NetsecratelimitSlice::get(self : NetsecratelimitSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecratelimitSlice::set(self : NetsecratelimitSlice, i : Int, v : Double) -> NetsecratelimitSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecratelimitSlice::sum(self : NetsecratelimitSlice) -> Double { @_common.sum(self.data) }

pub fn NetsecratelimitSlice::mean(self : NetsecratelimitSlice) -> Double { @_common.mean(self.data) }

pub fn NetsecratelimitSlice::scale(self : NetsecratelimitSlice, f : Double) -> NetsecratelimitSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecratelimitSlice::add(self : NetsecratelimitSlice, other : NetsecratelimitSlice) -> NetsecratelimitSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecratelimitSlice::copy(self : NetsecratelimitSlice) -> NetsecratelimitSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecratelimitSlice::fill(self : NetsecratelimitSlice, v : Double) -> NetsecratelimitSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecratelimitSlice::min(self : NetsecratelimitSlice) -> Double { @_common.min(self.data) }

pub fn NetsecratelimitSlice::max(self : NetsecratelimitSlice) -> Double { @_common.max(self.data) }

pub fn NetsecratelimitSlice::to_string(self : NetsecratelimitSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

