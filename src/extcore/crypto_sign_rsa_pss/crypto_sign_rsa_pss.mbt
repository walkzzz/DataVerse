///===
/// extcore/crypto_sign_rsa_pss

pub(all) struct CryptosignrsapssPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sign_rsa_pss_make_point(x : Double, y : Double) -> CryptosignrsapssPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sign_rsa_pss_make_point3(x : Double, y : Double, z : Double) -> CryptosignrsapssPoint {
  { x, y, z, label: 0 }
}

pub fn CryptosignrsapssPoint::x(self : CryptosignrsapssPoint) -> Double { self.x }

pub fn CryptosignrsapssPoint::y(self : CryptosignrsapssPoint) -> Double { self.y }

pub fn CryptosignrsapssPoint::z(self : CryptosignrsapssPoint) -> Double { self.z }

pub fn CryptosignrsapssPoint::label(self : CryptosignrsapssPoint) -> Int { self.label }

pub fn CryptosignrsapssPoint::dist(self : CryptosignrsapssPoint, other : CryptosignrsapssPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn CryptosignrsapssPoint::add(self : CryptosignrsapssPoint, other : CryptosignrsapssPoint) -> CryptosignrsapssPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn CryptosignrsapssPoint::sub(self : CryptosignrsapssPoint, other : CryptosignrsapssPoint) -> CryptosignrsapssPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn CryptosignrsapssPoint::scale(self : CryptosignrsapssPoint, s : Double) -> CryptosignrsapssPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn CryptosignrsapssPoint::dot(self : CryptosignrsapssPoint, other : CryptosignrsapssPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn CryptosignrsapssPoint::cross(self : CryptosignrsapssPoint, other : CryptosignrsapssPoint) -> CryptosignrsapssPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn CryptosignrsapssPoint::norm(self : CryptosignrsapssPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn CryptosignrsapssPoint::normalize(self : CryptosignrsapssPoint) -> CryptosignrsapssPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosignrsapssPoint::negate(self : CryptosignrsapssPoint) -> CryptosignrsapssPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn CryptosignrsapssPoint::mid(self : CryptosignrsapssPoint, other : CryptosignrsapssPoint) -> CryptosignrsapssPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn CryptosignrsapssPoint::lerp(self : CryptosignrsapssPoint, other : CryptosignrsapssPoint, t : Double) -> CryptosignrsapssPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn CryptosignrsapssPoint::to_string(self : CryptosignrsapssPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct CryptosignrsapssSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sign_rsa_pss_make_series(vals : Array[Double], name : String) -> CryptosignrsapssSeries {
  { vals, name, meta: 0 }
}

pub fn CryptosignrsapssSeries::len(self : CryptosignrsapssSeries) -> Int { self.vals.length() }

pub fn CryptosignrsapssSeries::sum(self : CryptosignrsapssSeries) -> Double { @_common.sum(self.vals) }

pub fn CryptosignrsapssSeries::mean(self : CryptosignrsapssSeries) -> Double { @_common.mean(self.vals) }

pub fn CryptosignrsapssSeries::min(self : CryptosignrsapssSeries) -> Double { @_common.min(self.vals) }

pub fn CryptosignrsapssSeries::max(self : CryptosignrsapssSeries) -> Double { @_common.max(self.vals) }

pub fn CryptosignrsapssSeries::range(self : CryptosignrsapssSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn CryptosignrsapssSeries::variance(self : CryptosignrsapssSeries) -> Double { @_common.variance(self.vals) }

pub fn CryptosignrsapssSeries::std(self : CryptosignrsapssSeries) -> Double { @_common.std(self.vals) }

pub fn CryptosignrsapssSeries::median(self : CryptosignrsapssSeries) -> Double { @_common.median(self.vals) }

pub fn CryptosignrsapssSeries::scale(self : CryptosignrsapssSeries, f : Double) -> CryptosignrsapssSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn CryptosignrsapssSeries::add(self : CryptosignrsapssSeries, other : CryptosignrsapssSeries) -> CryptosignrsapssSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn CryptosignrsapssSeries::sub(self : CryptosignrsapssSeries, other : CryptosignrsapssSeries) -> CryptosignrsapssSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn CryptosignrsapssSeries::normalize(self : CryptosignrsapssSeries) -> CryptosignrsapssSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn CryptosignrsapssSeries::cumsum(self : CryptosignrsapssSeries) -> CryptosignrsapssSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn CryptosignrsapssSeries::to_string(self : CryptosignrsapssSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosignrsapssMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sign_rsa_pss_make_matrix(rows : Int, cols : Int, val : Double) -> CryptosignrsapssMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn crypto_sign_rsa_pss_matrix_identity(n : Int) -> CryptosignrsapssMatrix {
  let m = crypto_sign_rsa_pss_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn CryptosignrsapssMatrix::get(self : CryptosignrsapssMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn CryptosignrsapssMatrix::transpose(self : CryptosignrsapssMatrix) -> CryptosignrsapssMatrix {
  let result = crypto_sign_rsa_pss_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn CryptosignrsapssMatrix::add(self : CryptosignrsapssMatrix, other : CryptosignrsapssMatrix) -> CryptosignrsapssMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_sign_rsa_pss_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn CryptosignrsapssMatrix::scale(self : CryptosignrsapssMatrix, s : Double) -> CryptosignrsapssMatrix {
  let result = crypto_sign_rsa_pss_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn CryptosignrsapssMatrix::multiply(self : CryptosignrsapssMatrix, other : CryptosignrsapssMatrix) -> CryptosignrsapssMatrix {
  if self.cols != other.rows { return crypto_sign_rsa_pss_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_sign_rsa_pss_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn CryptosignrsapssMatrix::trace(self : CryptosignrsapssMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn CryptosignrsapssMatrix::det(self : CryptosignrsapssMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn CryptosignrsapssMatrix::norm(self : CryptosignrsapssMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn CryptosignrsapssMatrix::to_string(self : CryptosignrsapssMatrix) -> String {
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

pub(all) struct CryptosignrsapssVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sign_rsa_pss_make_vector(comps : Array[Double]) -> CryptosignrsapssVector {
  { comps, dim: comps.length() }
}

pub fn crypto_sign_rsa_pss_vector_zero(dim : Int) -> CryptosignrsapssVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn CryptosignrsapssVector::add(self : CryptosignrsapssVector, other : CryptosignrsapssVector) -> CryptosignrsapssVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosignrsapssVector::sub(self : CryptosignrsapssVector, other : CryptosignrsapssVector) -> CryptosignrsapssVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosignrsapssVector::scale(self : CryptosignrsapssVector, s : Double) -> CryptosignrsapssVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn CryptosignrsapssVector::dot(self : CryptosignrsapssVector, other : CryptosignrsapssVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn CryptosignrsapssVector::norm(self : CryptosignrsapssVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn CryptosignrsapssVector::normalize(self : CryptosignrsapssVector) -> CryptosignrsapssVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosignrsapssVector::dist(self : CryptosignrsapssVector, other : CryptosignrsapssVector) -> Double {
  self.sub(other).norm()
}

pub fn CryptosignrsapssVector::to_string(self : CryptosignrsapssVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosignrsapssFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pss_frame_make(size : Int) -> CryptosignrsapssFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignrsapssFrame::len(self : CryptosignrsapssFrame) -> Int { self.size }

pub fn CryptosignrsapssFrame::get(self : CryptosignrsapssFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignrsapssFrame::set(self : CryptosignrsapssFrame, i : Int, v : Double) -> CryptosignrsapssFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssFrame::sum(self : CryptosignrsapssFrame) -> Double { @_common.sum(self.data) }

pub fn CryptosignrsapssFrame::mean(self : CryptosignrsapssFrame) -> Double { @_common.mean(self.data) }

pub fn CryptosignrsapssFrame::scale(self : CryptosignrsapssFrame, f : Double) -> CryptosignrsapssFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssFrame::add(self : CryptosignrsapssFrame, other : CryptosignrsapssFrame) -> CryptosignrsapssFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignrsapssFrame::copy(self : CryptosignrsapssFrame) -> CryptosignrsapssFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssFrame::fill(self : CryptosignrsapssFrame, v : Double) -> CryptosignrsapssFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssFrame::min(self : CryptosignrsapssFrame) -> Double { @_common.min(self.data) }

pub fn CryptosignrsapssFrame::max(self : CryptosignrsapssFrame) -> Double { @_common.max(self.data) }

pub fn CryptosignrsapssFrame::to_string(self : CryptosignrsapssFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapssTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pss_table_make(size : Int) -> CryptosignrsapssTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignrsapssTable::len(self : CryptosignrsapssTable) -> Int { self.size }

pub fn CryptosignrsapssTable::get(self : CryptosignrsapssTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignrsapssTable::set(self : CryptosignrsapssTable, i : Int, v : Double) -> CryptosignrsapssTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssTable::sum(self : CryptosignrsapssTable) -> Double { @_common.sum(self.data) }

pub fn CryptosignrsapssTable::mean(self : CryptosignrsapssTable) -> Double { @_common.mean(self.data) }

pub fn CryptosignrsapssTable::scale(self : CryptosignrsapssTable, f : Double) -> CryptosignrsapssTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssTable::add(self : CryptosignrsapssTable, other : CryptosignrsapssTable) -> CryptosignrsapssTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignrsapssTable::copy(self : CryptosignrsapssTable) -> CryptosignrsapssTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssTable::fill(self : CryptosignrsapssTable, v : Double) -> CryptosignrsapssTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssTable::min(self : CryptosignrsapssTable) -> Double { @_common.min(self.data) }

pub fn CryptosignrsapssTable::max(self : CryptosignrsapssTable) -> Double { @_common.max(self.data) }

pub fn CryptosignrsapssTable::to_string(self : CryptosignrsapssTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapssGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pss_graphn_make(size : Int) -> CryptosignrsapssGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignrsapssGraphN::len(self : CryptosignrsapssGraphN) -> Int { self.size }

pub fn CryptosignrsapssGraphN::get(self : CryptosignrsapssGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignrsapssGraphN::set(self : CryptosignrsapssGraphN, i : Int, v : Double) -> CryptosignrsapssGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssGraphN::sum(self : CryptosignrsapssGraphN) -> Double { @_common.sum(self.data) }

pub fn CryptosignrsapssGraphN::mean(self : CryptosignrsapssGraphN) -> Double { @_common.mean(self.data) }

pub fn CryptosignrsapssGraphN::scale(self : CryptosignrsapssGraphN, f : Double) -> CryptosignrsapssGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssGraphN::add(self : CryptosignrsapssGraphN, other : CryptosignrsapssGraphN) -> CryptosignrsapssGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignrsapssGraphN::copy(self : CryptosignrsapssGraphN) -> CryptosignrsapssGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssGraphN::fill(self : CryptosignrsapssGraphN, v : Double) -> CryptosignrsapssGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssGraphN::min(self : CryptosignrsapssGraphN) -> Double { @_common.min(self.data) }

pub fn CryptosignrsapssGraphN::max(self : CryptosignrsapssGraphN) -> Double { @_common.max(self.data) }

pub fn CryptosignrsapssGraphN::to_string(self : CryptosignrsapssGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapssNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pss_node_make(size : Int) -> CryptosignrsapssNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignrsapssNode::len(self : CryptosignrsapssNode) -> Int { self.size }

pub fn CryptosignrsapssNode::get(self : CryptosignrsapssNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignrsapssNode::set(self : CryptosignrsapssNode, i : Int, v : Double) -> CryptosignrsapssNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssNode::sum(self : CryptosignrsapssNode) -> Double { @_common.sum(self.data) }

pub fn CryptosignrsapssNode::mean(self : CryptosignrsapssNode) -> Double { @_common.mean(self.data) }

pub fn CryptosignrsapssNode::scale(self : CryptosignrsapssNode, f : Double) -> CryptosignrsapssNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssNode::add(self : CryptosignrsapssNode, other : CryptosignrsapssNode) -> CryptosignrsapssNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignrsapssNode::copy(self : CryptosignrsapssNode) -> CryptosignrsapssNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssNode::fill(self : CryptosignrsapssNode, v : Double) -> CryptosignrsapssNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssNode::min(self : CryptosignrsapssNode) -> Double { @_common.min(self.data) }

pub fn CryptosignrsapssNode::max(self : CryptosignrsapssNode) -> Double { @_common.max(self.data) }

pub fn CryptosignrsapssNode::to_string(self : CryptosignrsapssNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapssEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pss_edge_make(size : Int) -> CryptosignrsapssEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignrsapssEdge::len(self : CryptosignrsapssEdge) -> Int { self.size }

pub fn CryptosignrsapssEdge::get(self : CryptosignrsapssEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignrsapssEdge::set(self : CryptosignrsapssEdge, i : Int, v : Double) -> CryptosignrsapssEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssEdge::sum(self : CryptosignrsapssEdge) -> Double { @_common.sum(self.data) }

pub fn CryptosignrsapssEdge::mean(self : CryptosignrsapssEdge) -> Double { @_common.mean(self.data) }

pub fn CryptosignrsapssEdge::scale(self : CryptosignrsapssEdge, f : Double) -> CryptosignrsapssEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssEdge::add(self : CryptosignrsapssEdge, other : CryptosignrsapssEdge) -> CryptosignrsapssEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignrsapssEdge::copy(self : CryptosignrsapssEdge) -> CryptosignrsapssEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssEdge::fill(self : CryptosignrsapssEdge, v : Double) -> CryptosignrsapssEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssEdge::min(self : CryptosignrsapssEdge) -> Double { @_common.min(self.data) }

pub fn CryptosignrsapssEdge::max(self : CryptosignrsapssEdge) -> Double { @_common.max(self.data) }

pub fn CryptosignrsapssEdge::to_string(self : CryptosignrsapssEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapssPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pss_path_make(size : Int) -> CryptosignrsapssPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignrsapssPath::len(self : CryptosignrsapssPath) -> Int { self.size }

pub fn CryptosignrsapssPath::get(self : CryptosignrsapssPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignrsapssPath::set(self : CryptosignrsapssPath, i : Int, v : Double) -> CryptosignrsapssPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssPath::sum(self : CryptosignrsapssPath) -> Double { @_common.sum(self.data) }

pub fn CryptosignrsapssPath::mean(self : CryptosignrsapssPath) -> Double { @_common.mean(self.data) }

pub fn CryptosignrsapssPath::scale(self : CryptosignrsapssPath, f : Double) -> CryptosignrsapssPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssPath::add(self : CryptosignrsapssPath, other : CryptosignrsapssPath) -> CryptosignrsapssPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignrsapssPath::copy(self : CryptosignrsapssPath) -> CryptosignrsapssPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssPath::fill(self : CryptosignrsapssPath, v : Double) -> CryptosignrsapssPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssPath::min(self : CryptosignrsapssPath) -> Double { @_common.min(self.data) }

pub fn CryptosignrsapssPath::max(self : CryptosignrsapssPath) -> Double { @_common.max(self.data) }

pub fn CryptosignrsapssPath::to_string(self : CryptosignrsapssPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapssCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pss_cluster_make(size : Int) -> CryptosignrsapssCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignrsapssCluster::len(self : CryptosignrsapssCluster) -> Int { self.size }

pub fn CryptosignrsapssCluster::get(self : CryptosignrsapssCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignrsapssCluster::set(self : CryptosignrsapssCluster, i : Int, v : Double) -> CryptosignrsapssCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssCluster::sum(self : CryptosignrsapssCluster) -> Double { @_common.sum(self.data) }

pub fn CryptosignrsapssCluster::mean(self : CryptosignrsapssCluster) -> Double { @_common.mean(self.data) }

pub fn CryptosignrsapssCluster::scale(self : CryptosignrsapssCluster, f : Double) -> CryptosignrsapssCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssCluster::add(self : CryptosignrsapssCluster, other : CryptosignrsapssCluster) -> CryptosignrsapssCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignrsapssCluster::copy(self : CryptosignrsapssCluster) -> CryptosignrsapssCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssCluster::fill(self : CryptosignrsapssCluster, v : Double) -> CryptosignrsapssCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssCluster::min(self : CryptosignrsapssCluster) -> Double { @_common.min(self.data) }

pub fn CryptosignrsapssCluster::max(self : CryptosignrsapssCluster) -> Double { @_common.max(self.data) }

pub fn CryptosignrsapssCluster::to_string(self : CryptosignrsapssCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapssModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pss_model_make(size : Int) -> CryptosignrsapssModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignrsapssModel::len(self : CryptosignrsapssModel) -> Int { self.size }

pub fn CryptosignrsapssModel::get(self : CryptosignrsapssModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignrsapssModel::set(self : CryptosignrsapssModel, i : Int, v : Double) -> CryptosignrsapssModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssModel::sum(self : CryptosignrsapssModel) -> Double { @_common.sum(self.data) }

pub fn CryptosignrsapssModel::mean(self : CryptosignrsapssModel) -> Double { @_common.mean(self.data) }

pub fn CryptosignrsapssModel::scale(self : CryptosignrsapssModel, f : Double) -> CryptosignrsapssModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssModel::add(self : CryptosignrsapssModel, other : CryptosignrsapssModel) -> CryptosignrsapssModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignrsapssModel::copy(self : CryptosignrsapssModel) -> CryptosignrsapssModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssModel::fill(self : CryptosignrsapssModel, v : Double) -> CryptosignrsapssModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssModel::min(self : CryptosignrsapssModel) -> Double { @_common.min(self.data) }

pub fn CryptosignrsapssModel::max(self : CryptosignrsapssModel) -> Double { @_common.max(self.data) }

pub fn CryptosignrsapssModel::to_string(self : CryptosignrsapssModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapssLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pss_layer_make(size : Int) -> CryptosignrsapssLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignrsapssLayer::len(self : CryptosignrsapssLayer) -> Int { self.size }

pub fn CryptosignrsapssLayer::get(self : CryptosignrsapssLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignrsapssLayer::set(self : CryptosignrsapssLayer, i : Int, v : Double) -> CryptosignrsapssLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssLayer::sum(self : CryptosignrsapssLayer) -> Double { @_common.sum(self.data) }

pub fn CryptosignrsapssLayer::mean(self : CryptosignrsapssLayer) -> Double { @_common.mean(self.data) }

pub fn CryptosignrsapssLayer::scale(self : CryptosignrsapssLayer, f : Double) -> CryptosignrsapssLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssLayer::add(self : CryptosignrsapssLayer, other : CryptosignrsapssLayer) -> CryptosignrsapssLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignrsapssLayer::copy(self : CryptosignrsapssLayer) -> CryptosignrsapssLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssLayer::fill(self : CryptosignrsapssLayer, v : Double) -> CryptosignrsapssLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssLayer::min(self : CryptosignrsapssLayer) -> Double { @_common.min(self.data) }

pub fn CryptosignrsapssLayer::max(self : CryptosignrsapssLayer) -> Double { @_common.max(self.data) }

pub fn CryptosignrsapssLayer::to_string(self : CryptosignrsapssLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapssBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pss_buffer_make(size : Int) -> CryptosignrsapssBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignrsapssBuffer::len(self : CryptosignrsapssBuffer) -> Int { self.size }

pub fn CryptosignrsapssBuffer::get(self : CryptosignrsapssBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignrsapssBuffer::set(self : CryptosignrsapssBuffer, i : Int, v : Double) -> CryptosignrsapssBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssBuffer::sum(self : CryptosignrsapssBuffer) -> Double { @_common.sum(self.data) }

pub fn CryptosignrsapssBuffer::mean(self : CryptosignrsapssBuffer) -> Double { @_common.mean(self.data) }

pub fn CryptosignrsapssBuffer::scale(self : CryptosignrsapssBuffer, f : Double) -> CryptosignrsapssBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssBuffer::add(self : CryptosignrsapssBuffer, other : CryptosignrsapssBuffer) -> CryptosignrsapssBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignrsapssBuffer::copy(self : CryptosignrsapssBuffer) -> CryptosignrsapssBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssBuffer::fill(self : CryptosignrsapssBuffer, v : Double) -> CryptosignrsapssBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssBuffer::min(self : CryptosignrsapssBuffer) -> Double { @_common.min(self.data) }

pub fn CryptosignrsapssBuffer::max(self : CryptosignrsapssBuffer) -> Double { @_common.max(self.data) }

pub fn CryptosignrsapssBuffer::to_string(self : CryptosignrsapssBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapssCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pss_cursor_make(size : Int) -> CryptosignrsapssCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignrsapssCursor::len(self : CryptosignrsapssCursor) -> Int { self.size }

pub fn CryptosignrsapssCursor::get(self : CryptosignrsapssCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignrsapssCursor::set(self : CryptosignrsapssCursor, i : Int, v : Double) -> CryptosignrsapssCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssCursor::sum(self : CryptosignrsapssCursor) -> Double { @_common.sum(self.data) }

pub fn CryptosignrsapssCursor::mean(self : CryptosignrsapssCursor) -> Double { @_common.mean(self.data) }

pub fn CryptosignrsapssCursor::scale(self : CryptosignrsapssCursor, f : Double) -> CryptosignrsapssCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssCursor::add(self : CryptosignrsapssCursor, other : CryptosignrsapssCursor) -> CryptosignrsapssCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignrsapssCursor::copy(self : CryptosignrsapssCursor) -> CryptosignrsapssCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssCursor::fill(self : CryptosignrsapssCursor, v : Double) -> CryptosignrsapssCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssCursor::min(self : CryptosignrsapssCursor) -> Double { @_common.min(self.data) }

pub fn CryptosignrsapssCursor::max(self : CryptosignrsapssCursor) -> Double { @_common.max(self.data) }

pub fn CryptosignrsapssCursor::to_string(self : CryptosignrsapssCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapssView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pss_view_make(size : Int) -> CryptosignrsapssView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignrsapssView::len(self : CryptosignrsapssView) -> Int { self.size }

pub fn CryptosignrsapssView::get(self : CryptosignrsapssView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignrsapssView::set(self : CryptosignrsapssView, i : Int, v : Double) -> CryptosignrsapssView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssView::sum(self : CryptosignrsapssView) -> Double { @_common.sum(self.data) }

pub fn CryptosignrsapssView::mean(self : CryptosignrsapssView) -> Double { @_common.mean(self.data) }

pub fn CryptosignrsapssView::scale(self : CryptosignrsapssView, f : Double) -> CryptosignrsapssView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssView::add(self : CryptosignrsapssView, other : CryptosignrsapssView) -> CryptosignrsapssView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignrsapssView::copy(self : CryptosignrsapssView) -> CryptosignrsapssView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssView::fill(self : CryptosignrsapssView, v : Double) -> CryptosignrsapssView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssView::min(self : CryptosignrsapssView) -> Double { @_common.min(self.data) }

pub fn CryptosignrsapssView::max(self : CryptosignrsapssView) -> Double { @_common.max(self.data) }

pub fn CryptosignrsapssView::to_string(self : CryptosignrsapssView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapssRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pss_range_make(size : Int) -> CryptosignrsapssRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignrsapssRange::len(self : CryptosignrsapssRange) -> Int { self.size }

pub fn CryptosignrsapssRange::get(self : CryptosignrsapssRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignrsapssRange::set(self : CryptosignrsapssRange, i : Int, v : Double) -> CryptosignrsapssRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssRange::sum(self : CryptosignrsapssRange) -> Double { @_common.sum(self.data) }

pub fn CryptosignrsapssRange::mean(self : CryptosignrsapssRange) -> Double { @_common.mean(self.data) }

pub fn CryptosignrsapssRange::scale(self : CryptosignrsapssRange, f : Double) -> CryptosignrsapssRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssRange::add(self : CryptosignrsapssRange, other : CryptosignrsapssRange) -> CryptosignrsapssRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignrsapssRange::copy(self : CryptosignrsapssRange) -> CryptosignrsapssRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssRange::fill(self : CryptosignrsapssRange, v : Double) -> CryptosignrsapssRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssRange::min(self : CryptosignrsapssRange) -> Double { @_common.min(self.data) }

pub fn CryptosignrsapssRange::max(self : CryptosignrsapssRange) -> Double { @_common.max(self.data) }

pub fn CryptosignrsapssRange::to_string(self : CryptosignrsapssRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapssSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pss_slice_make(size : Int) -> CryptosignrsapssSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosignrsapssSlice::len(self : CryptosignrsapssSlice) -> Int { self.size }

pub fn CryptosignrsapssSlice::get(self : CryptosignrsapssSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosignrsapssSlice::set(self : CryptosignrsapssSlice, i : Int, v : Double) -> CryptosignrsapssSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssSlice::sum(self : CryptosignrsapssSlice) -> Double { @_common.sum(self.data) }

pub fn CryptosignrsapssSlice::mean(self : CryptosignrsapssSlice) -> Double { @_common.mean(self.data) }

pub fn CryptosignrsapssSlice::scale(self : CryptosignrsapssSlice, f : Double) -> CryptosignrsapssSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssSlice::add(self : CryptosignrsapssSlice, other : CryptosignrsapssSlice) -> CryptosignrsapssSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosignrsapssSlice::copy(self : CryptosignrsapssSlice) -> CryptosignrsapssSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssSlice::fill(self : CryptosignrsapssSlice, v : Double) -> CryptosignrsapssSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosignrsapssSlice::min(self : CryptosignrsapssSlice) -> Double { @_common.min(self.data) }

pub fn CryptosignrsapssSlice::max(self : CryptosignrsapssSlice) -> Double { @_common.max(self.data) }

pub fn CryptosignrsapssSlice::to_string(self : CryptosignrsapssSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

