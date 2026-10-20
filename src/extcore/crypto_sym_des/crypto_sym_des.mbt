///===
/// extcore/crypto_sym_des

pub(all) struct CryptosymdesPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sym_des_make_point(x : Double, y : Double) -> CryptosymdesPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sym_des_make_point3(x : Double, y : Double, z : Double) -> CryptosymdesPoint {
  { x, y, z, label: 0 }
}

pub fn CryptosymdesPoint::x(self : CryptosymdesPoint) -> Double { self.x }

pub fn CryptosymdesPoint::y(self : CryptosymdesPoint) -> Double { self.y }

pub fn CryptosymdesPoint::z(self : CryptosymdesPoint) -> Double { self.z }

pub fn CryptosymdesPoint::label(self : CryptosymdesPoint) -> Int { self.label }

pub fn CryptosymdesPoint::dist(self : CryptosymdesPoint, other : CryptosymdesPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn CryptosymdesPoint::add(self : CryptosymdesPoint, other : CryptosymdesPoint) -> CryptosymdesPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn CryptosymdesPoint::sub(self : CryptosymdesPoint, other : CryptosymdesPoint) -> CryptosymdesPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn CryptosymdesPoint::scale(self : CryptosymdesPoint, s : Double) -> CryptosymdesPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn CryptosymdesPoint::dot(self : CryptosymdesPoint, other : CryptosymdesPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn CryptosymdesPoint::cross(self : CryptosymdesPoint, other : CryptosymdesPoint) -> CryptosymdesPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn CryptosymdesPoint::norm(self : CryptosymdesPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn CryptosymdesPoint::normalize(self : CryptosymdesPoint) -> CryptosymdesPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosymdesPoint::negate(self : CryptosymdesPoint) -> CryptosymdesPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn CryptosymdesPoint::mid(self : CryptosymdesPoint, other : CryptosymdesPoint) -> CryptosymdesPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn CryptosymdesPoint::lerp(self : CryptosymdesPoint, other : CryptosymdesPoint, t : Double) -> CryptosymdesPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn CryptosymdesPoint::to_string(self : CryptosymdesPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct CryptosymdesSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sym_des_make_series(vals : Array[Double], name : String) -> CryptosymdesSeries {
  { vals, name, meta: 0 }
}

pub fn CryptosymdesSeries::len(self : CryptosymdesSeries) -> Int { self.vals.length() }

pub fn CryptosymdesSeries::sum(self : CryptosymdesSeries) -> Double { @_common.sum(self.vals) }

pub fn CryptosymdesSeries::mean(self : CryptosymdesSeries) -> Double { @_common.mean(self.vals) }

pub fn CryptosymdesSeries::min(self : CryptosymdesSeries) -> Double { @_common.min(self.vals) }

pub fn CryptosymdesSeries::max(self : CryptosymdesSeries) -> Double { @_common.max(self.vals) }

pub fn CryptosymdesSeries::range(self : CryptosymdesSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn CryptosymdesSeries::variance(self : CryptosymdesSeries) -> Double { @_common.variance(self.vals) }

pub fn CryptosymdesSeries::std(self : CryptosymdesSeries) -> Double { @_common.std(self.vals) }

pub fn CryptosymdesSeries::median(self : CryptosymdesSeries) -> Double { @_common.median(self.vals) }

pub fn CryptosymdesSeries::scale(self : CryptosymdesSeries, f : Double) -> CryptosymdesSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn CryptosymdesSeries::add(self : CryptosymdesSeries, other : CryptosymdesSeries) -> CryptosymdesSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn CryptosymdesSeries::sub(self : CryptosymdesSeries, other : CryptosymdesSeries) -> CryptosymdesSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn CryptosymdesSeries::normalize(self : CryptosymdesSeries) -> CryptosymdesSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn CryptosymdesSeries::cumsum(self : CryptosymdesSeries) -> CryptosymdesSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn CryptosymdesSeries::to_string(self : CryptosymdesSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosymdesMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sym_des_make_matrix(rows : Int, cols : Int, val : Double) -> CryptosymdesMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_sym_des_matrix_identity(n : Int) -> CryptosymdesMatrix {
  let m = crypto_sym_des_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn CryptosymdesMatrix::get(self : CryptosymdesMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn CryptosymdesMatrix::transpose(self : CryptosymdesMatrix) -> CryptosymdesMatrix {
  let result = crypto_sym_des_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn CryptosymdesMatrix::add(self : CryptosymdesMatrix, other : CryptosymdesMatrix) -> CryptosymdesMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_sym_des_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn CryptosymdesMatrix::scale(self : CryptosymdesMatrix, s : Double) -> CryptosymdesMatrix {
  let result = crypto_sym_des_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn CryptosymdesMatrix::multiply(self : CryptosymdesMatrix, other : CryptosymdesMatrix) -> CryptosymdesMatrix {
  if self.cols != other.rows { return crypto_sym_des_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_sym_des_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn CryptosymdesMatrix::trace(self : CryptosymdesMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn CryptosymdesMatrix::det(self : CryptosymdesMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn CryptosymdesMatrix::norm(self : CryptosymdesMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn CryptosymdesMatrix::to_string(self : CryptosymdesMatrix) -> String {
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

pub(all) struct CryptosymdesVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sym_des_make_vector(comps : Array[Double]) -> CryptosymdesVector {
  { comps, dim: comps.length() }
}

pub fn crypto_sym_des_vector_zero(dim : Int) -> CryptosymdesVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn CryptosymdesVector::add(self : CryptosymdesVector, other : CryptosymdesVector) -> CryptosymdesVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosymdesVector::sub(self : CryptosymdesVector, other : CryptosymdesVector) -> CryptosymdesVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosymdesVector::scale(self : CryptosymdesVector, s : Double) -> CryptosymdesVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn CryptosymdesVector::dot(self : CryptosymdesVector, other : CryptosymdesVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn CryptosymdesVector::norm(self : CryptosymdesVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn CryptosymdesVector::normalize(self : CryptosymdesVector) -> CryptosymdesVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosymdesVector::dist(self : CryptosymdesVector, other : CryptosymdesVector) -> Double {
  self.sub(other).norm()
}

pub fn CryptosymdesVector::to_string(self : CryptosymdesVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosymdesFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_frame_make(size : Int) -> CryptosymdesFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymdesFrame::len(self : CryptosymdesFrame) -> Int { self.size }

pub fn CryptosymdesFrame::get(self : CryptosymdesFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymdesFrame::set(self : CryptosymdesFrame, i : Int, v : Double) -> CryptosymdesFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymdesFrame::sum(self : CryptosymdesFrame) -> Double { @_common.sum(self.data) }

pub fn CryptosymdesFrame::mean(self : CryptosymdesFrame) -> Double { @_common.mean(self.data) }

pub fn CryptosymdesFrame::scale(self : CryptosymdesFrame, f : Double) -> CryptosymdesFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymdesFrame::add(self : CryptosymdesFrame, other : CryptosymdesFrame) -> CryptosymdesFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymdesFrame::copy(self : CryptosymdesFrame) -> CryptosymdesFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymdesFrame::fill(self : CryptosymdesFrame, v : Double) -> CryptosymdesFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymdesFrame::min(self : CryptosymdesFrame) -> Double { @_common.min(self.data) }

pub fn CryptosymdesFrame::max(self : CryptosymdesFrame) -> Double { @_common.max(self.data) }

pub fn CryptosymdesFrame::to_string(self : CryptosymdesFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymdesTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_table_make(size : Int) -> CryptosymdesTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymdesTable::len(self : CryptosymdesTable) -> Int { self.size }

pub fn CryptosymdesTable::get(self : CryptosymdesTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymdesTable::set(self : CryptosymdesTable, i : Int, v : Double) -> CryptosymdesTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymdesTable::sum(self : CryptosymdesTable) -> Double { @_common.sum(self.data) }

pub fn CryptosymdesTable::mean(self : CryptosymdesTable) -> Double { @_common.mean(self.data) }

pub fn CryptosymdesTable::scale(self : CryptosymdesTable, f : Double) -> CryptosymdesTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymdesTable::add(self : CryptosymdesTable, other : CryptosymdesTable) -> CryptosymdesTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymdesTable::copy(self : CryptosymdesTable) -> CryptosymdesTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymdesTable::fill(self : CryptosymdesTable, v : Double) -> CryptosymdesTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymdesTable::min(self : CryptosymdesTable) -> Double { @_common.min(self.data) }

pub fn CryptosymdesTable::max(self : CryptosymdesTable) -> Double { @_common.max(self.data) }

pub fn CryptosymdesTable::to_string(self : CryptosymdesTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymdesGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_graphn_make(size : Int) -> CryptosymdesGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymdesGraphN::len(self : CryptosymdesGraphN) -> Int { self.size }

pub fn CryptosymdesGraphN::get(self : CryptosymdesGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymdesGraphN::set(self : CryptosymdesGraphN, i : Int, v : Double) -> CryptosymdesGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymdesGraphN::sum(self : CryptosymdesGraphN) -> Double { @_common.sum(self.data) }

pub fn CryptosymdesGraphN::mean(self : CryptosymdesGraphN) -> Double { @_common.mean(self.data) }

pub fn CryptosymdesGraphN::scale(self : CryptosymdesGraphN, f : Double) -> CryptosymdesGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymdesGraphN::add(self : CryptosymdesGraphN, other : CryptosymdesGraphN) -> CryptosymdesGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymdesGraphN::copy(self : CryptosymdesGraphN) -> CryptosymdesGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymdesGraphN::fill(self : CryptosymdesGraphN, v : Double) -> CryptosymdesGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymdesGraphN::min(self : CryptosymdesGraphN) -> Double { @_common.min(self.data) }

pub fn CryptosymdesGraphN::max(self : CryptosymdesGraphN) -> Double { @_common.max(self.data) }

pub fn CryptosymdesGraphN::to_string(self : CryptosymdesGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymdesNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_node_make(size : Int) -> CryptosymdesNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymdesNode::len(self : CryptosymdesNode) -> Int { self.size }

pub fn CryptosymdesNode::get(self : CryptosymdesNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymdesNode::set(self : CryptosymdesNode, i : Int, v : Double) -> CryptosymdesNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymdesNode::sum(self : CryptosymdesNode) -> Double { @_common.sum(self.data) }

pub fn CryptosymdesNode::mean(self : CryptosymdesNode) -> Double { @_common.mean(self.data) }

pub fn CryptosymdesNode::scale(self : CryptosymdesNode, f : Double) -> CryptosymdesNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymdesNode::add(self : CryptosymdesNode, other : CryptosymdesNode) -> CryptosymdesNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymdesNode::copy(self : CryptosymdesNode) -> CryptosymdesNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymdesNode::fill(self : CryptosymdesNode, v : Double) -> CryptosymdesNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymdesNode::min(self : CryptosymdesNode) -> Double { @_common.min(self.data) }

pub fn CryptosymdesNode::max(self : CryptosymdesNode) -> Double { @_common.max(self.data) }

pub fn CryptosymdesNode::to_string(self : CryptosymdesNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymdesEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_edge_make(size : Int) -> CryptosymdesEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymdesEdge::len(self : CryptosymdesEdge) -> Int { self.size }

pub fn CryptosymdesEdge::get(self : CryptosymdesEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymdesEdge::set(self : CryptosymdesEdge, i : Int, v : Double) -> CryptosymdesEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymdesEdge::sum(self : CryptosymdesEdge) -> Double { @_common.sum(self.data) }

pub fn CryptosymdesEdge::mean(self : CryptosymdesEdge) -> Double { @_common.mean(self.data) }

pub fn CryptosymdesEdge::scale(self : CryptosymdesEdge, f : Double) -> CryptosymdesEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymdesEdge::add(self : CryptosymdesEdge, other : CryptosymdesEdge) -> CryptosymdesEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymdesEdge::copy(self : CryptosymdesEdge) -> CryptosymdesEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymdesEdge::fill(self : CryptosymdesEdge, v : Double) -> CryptosymdesEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymdesEdge::min(self : CryptosymdesEdge) -> Double { @_common.min(self.data) }

pub fn CryptosymdesEdge::max(self : CryptosymdesEdge) -> Double { @_common.max(self.data) }

pub fn CryptosymdesEdge::to_string(self : CryptosymdesEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymdesPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_path_make(size : Int) -> CryptosymdesPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymdesPath::len(self : CryptosymdesPath) -> Int { self.size }

pub fn CryptosymdesPath::get(self : CryptosymdesPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymdesPath::set(self : CryptosymdesPath, i : Int, v : Double) -> CryptosymdesPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymdesPath::sum(self : CryptosymdesPath) -> Double { @_common.sum(self.data) }

pub fn CryptosymdesPath::mean(self : CryptosymdesPath) -> Double { @_common.mean(self.data) }

pub fn CryptosymdesPath::scale(self : CryptosymdesPath, f : Double) -> CryptosymdesPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymdesPath::add(self : CryptosymdesPath, other : CryptosymdesPath) -> CryptosymdesPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymdesPath::copy(self : CryptosymdesPath) -> CryptosymdesPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymdesPath::fill(self : CryptosymdesPath, v : Double) -> CryptosymdesPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymdesPath::min(self : CryptosymdesPath) -> Double { @_common.min(self.data) }

pub fn CryptosymdesPath::max(self : CryptosymdesPath) -> Double { @_common.max(self.data) }

pub fn CryptosymdesPath::to_string(self : CryptosymdesPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymdesCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_cluster_make(size : Int) -> CryptosymdesCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymdesCluster::len(self : CryptosymdesCluster) -> Int { self.size }

pub fn CryptosymdesCluster::get(self : CryptosymdesCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymdesCluster::set(self : CryptosymdesCluster, i : Int, v : Double) -> CryptosymdesCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymdesCluster::sum(self : CryptosymdesCluster) -> Double { @_common.sum(self.data) }

pub fn CryptosymdesCluster::mean(self : CryptosymdesCluster) -> Double { @_common.mean(self.data) }

pub fn CryptosymdesCluster::scale(self : CryptosymdesCluster, f : Double) -> CryptosymdesCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymdesCluster::add(self : CryptosymdesCluster, other : CryptosymdesCluster) -> CryptosymdesCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymdesCluster::copy(self : CryptosymdesCluster) -> CryptosymdesCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymdesCluster::fill(self : CryptosymdesCluster, v : Double) -> CryptosymdesCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymdesCluster::min(self : CryptosymdesCluster) -> Double { @_common.min(self.data) }

pub fn CryptosymdesCluster::max(self : CryptosymdesCluster) -> Double { @_common.max(self.data) }

pub fn CryptosymdesCluster::to_string(self : CryptosymdesCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymdesModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_model_make(size : Int) -> CryptosymdesModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymdesModel::len(self : CryptosymdesModel) -> Int { self.size }

pub fn CryptosymdesModel::get(self : CryptosymdesModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymdesModel::set(self : CryptosymdesModel, i : Int, v : Double) -> CryptosymdesModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymdesModel::sum(self : CryptosymdesModel) -> Double { @_common.sum(self.data) }

pub fn CryptosymdesModel::mean(self : CryptosymdesModel) -> Double { @_common.mean(self.data) }

pub fn CryptosymdesModel::scale(self : CryptosymdesModel, f : Double) -> CryptosymdesModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymdesModel::add(self : CryptosymdesModel, other : CryptosymdesModel) -> CryptosymdesModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymdesModel::copy(self : CryptosymdesModel) -> CryptosymdesModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymdesModel::fill(self : CryptosymdesModel, v : Double) -> CryptosymdesModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymdesModel::min(self : CryptosymdesModel) -> Double { @_common.min(self.data) }

pub fn CryptosymdesModel::max(self : CryptosymdesModel) -> Double { @_common.max(self.data) }

pub fn CryptosymdesModel::to_string(self : CryptosymdesModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymdesLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_layer_make(size : Int) -> CryptosymdesLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymdesLayer::len(self : CryptosymdesLayer) -> Int { self.size }

pub fn CryptosymdesLayer::get(self : CryptosymdesLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymdesLayer::set(self : CryptosymdesLayer, i : Int, v : Double) -> CryptosymdesLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymdesLayer::sum(self : CryptosymdesLayer) -> Double { @_common.sum(self.data) }

pub fn CryptosymdesLayer::mean(self : CryptosymdesLayer) -> Double { @_common.mean(self.data) }

pub fn CryptosymdesLayer::scale(self : CryptosymdesLayer, f : Double) -> CryptosymdesLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymdesLayer::add(self : CryptosymdesLayer, other : CryptosymdesLayer) -> CryptosymdesLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymdesLayer::copy(self : CryptosymdesLayer) -> CryptosymdesLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymdesLayer::fill(self : CryptosymdesLayer, v : Double) -> CryptosymdesLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymdesLayer::min(self : CryptosymdesLayer) -> Double { @_common.min(self.data) }

pub fn CryptosymdesLayer::max(self : CryptosymdesLayer) -> Double { @_common.max(self.data) }

pub fn CryptosymdesLayer::to_string(self : CryptosymdesLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymdesBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_buffer_make(size : Int) -> CryptosymdesBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymdesBuffer::len(self : CryptosymdesBuffer) -> Int { self.size }

pub fn CryptosymdesBuffer::get(self : CryptosymdesBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymdesBuffer::set(self : CryptosymdesBuffer, i : Int, v : Double) -> CryptosymdesBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymdesBuffer::sum(self : CryptosymdesBuffer) -> Double { @_common.sum(self.data) }

pub fn CryptosymdesBuffer::mean(self : CryptosymdesBuffer) -> Double { @_common.mean(self.data) }

pub fn CryptosymdesBuffer::scale(self : CryptosymdesBuffer, f : Double) -> CryptosymdesBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymdesBuffer::add(self : CryptosymdesBuffer, other : CryptosymdesBuffer) -> CryptosymdesBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymdesBuffer::copy(self : CryptosymdesBuffer) -> CryptosymdesBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymdesBuffer::fill(self : CryptosymdesBuffer, v : Double) -> CryptosymdesBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymdesBuffer::min(self : CryptosymdesBuffer) -> Double { @_common.min(self.data) }

pub fn CryptosymdesBuffer::max(self : CryptosymdesBuffer) -> Double { @_common.max(self.data) }

pub fn CryptosymdesBuffer::to_string(self : CryptosymdesBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymdesCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_cursor_make(size : Int) -> CryptosymdesCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymdesCursor::len(self : CryptosymdesCursor) -> Int { self.size }

pub fn CryptosymdesCursor::get(self : CryptosymdesCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymdesCursor::set(self : CryptosymdesCursor, i : Int, v : Double) -> CryptosymdesCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymdesCursor::sum(self : CryptosymdesCursor) -> Double { @_common.sum(self.data) }

pub fn CryptosymdesCursor::mean(self : CryptosymdesCursor) -> Double { @_common.mean(self.data) }

pub fn CryptosymdesCursor::scale(self : CryptosymdesCursor, f : Double) -> CryptosymdesCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymdesCursor::add(self : CryptosymdesCursor, other : CryptosymdesCursor) -> CryptosymdesCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymdesCursor::copy(self : CryptosymdesCursor) -> CryptosymdesCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymdesCursor::fill(self : CryptosymdesCursor, v : Double) -> CryptosymdesCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymdesCursor::min(self : CryptosymdesCursor) -> Double { @_common.min(self.data) }

pub fn CryptosymdesCursor::max(self : CryptosymdesCursor) -> Double { @_common.max(self.data) }

pub fn CryptosymdesCursor::to_string(self : CryptosymdesCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymdesView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_view_make(size : Int) -> CryptosymdesView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymdesView::len(self : CryptosymdesView) -> Int { self.size }

pub fn CryptosymdesView::get(self : CryptosymdesView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymdesView::set(self : CryptosymdesView, i : Int, v : Double) -> CryptosymdesView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymdesView::sum(self : CryptosymdesView) -> Double { @_common.sum(self.data) }

pub fn CryptosymdesView::mean(self : CryptosymdesView) -> Double { @_common.mean(self.data) }

pub fn CryptosymdesView::scale(self : CryptosymdesView, f : Double) -> CryptosymdesView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymdesView::add(self : CryptosymdesView, other : CryptosymdesView) -> CryptosymdesView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymdesView::copy(self : CryptosymdesView) -> CryptosymdesView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymdesView::fill(self : CryptosymdesView, v : Double) -> CryptosymdesView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymdesView::min(self : CryptosymdesView) -> Double { @_common.min(self.data) }

pub fn CryptosymdesView::max(self : CryptosymdesView) -> Double { @_common.max(self.data) }

pub fn CryptosymdesView::to_string(self : CryptosymdesView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymdesRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_range_make(size : Int) -> CryptosymdesRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymdesRange::len(self : CryptosymdesRange) -> Int { self.size }

pub fn CryptosymdesRange::get(self : CryptosymdesRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymdesRange::set(self : CryptosymdesRange, i : Int, v : Double) -> CryptosymdesRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymdesRange::sum(self : CryptosymdesRange) -> Double { @_common.sum(self.data) }

pub fn CryptosymdesRange::mean(self : CryptosymdesRange) -> Double { @_common.mean(self.data) }

pub fn CryptosymdesRange::scale(self : CryptosymdesRange, f : Double) -> CryptosymdesRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymdesRange::add(self : CryptosymdesRange, other : CryptosymdesRange) -> CryptosymdesRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymdesRange::copy(self : CryptosymdesRange) -> CryptosymdesRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymdesRange::fill(self : CryptosymdesRange, v : Double) -> CryptosymdesRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymdesRange::min(self : CryptosymdesRange) -> Double { @_common.min(self.data) }

pub fn CryptosymdesRange::max(self : CryptosymdesRange) -> Double { @_common.max(self.data) }

pub fn CryptosymdesRange::to_string(self : CryptosymdesRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymdesSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_slice_make(size : Int) -> CryptosymdesSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymdesSlice::len(self : CryptosymdesSlice) -> Int { self.size }

pub fn CryptosymdesSlice::get(self : CryptosymdesSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymdesSlice::set(self : CryptosymdesSlice, i : Int, v : Double) -> CryptosymdesSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymdesSlice::sum(self : CryptosymdesSlice) -> Double { @_common.sum(self.data) }

pub fn CryptosymdesSlice::mean(self : CryptosymdesSlice) -> Double { @_common.mean(self.data) }

pub fn CryptosymdesSlice::scale(self : CryptosymdesSlice, f : Double) -> CryptosymdesSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymdesSlice::add(self : CryptosymdesSlice, other : CryptosymdesSlice) -> CryptosymdesSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymdesSlice::copy(self : CryptosymdesSlice) -> CryptosymdesSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymdesSlice::fill(self : CryptosymdesSlice, v : Double) -> CryptosymdesSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymdesSlice::min(self : CryptosymdesSlice) -> Double { @_common.min(self.data) }

pub fn CryptosymdesSlice::max(self : CryptosymdesSlice) -> Double { @_common.max(self.data) }

pub fn CryptosymdesSlice::to_string(self : CryptosymdesSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

