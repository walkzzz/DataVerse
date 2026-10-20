///===
/// extcore/crypto_asym_rsa

pub(all) struct CryptoasymrsaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_asym_rsa_make_point(x : Double, y : Double) -> CryptoasymrsaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_asym_rsa_make_point3(x : Double, y : Double, z : Double) -> CryptoasymrsaPoint {
  { x, y, z, label: 0 }
}

pub fn CryptoasymrsaPoint::x(self : CryptoasymrsaPoint) -> Double { self.x }

pub fn CryptoasymrsaPoint::y(self : CryptoasymrsaPoint) -> Double { self.y }

pub fn CryptoasymrsaPoint::z(self : CryptoasymrsaPoint) -> Double { self.z }

pub fn CryptoasymrsaPoint::label(self : CryptoasymrsaPoint) -> Int { self.label }

pub fn CryptoasymrsaPoint::dist(self : CryptoasymrsaPoint, other : CryptoasymrsaPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn CryptoasymrsaPoint::add(self : CryptoasymrsaPoint, other : CryptoasymrsaPoint) -> CryptoasymrsaPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn CryptoasymrsaPoint::sub(self : CryptoasymrsaPoint, other : CryptoasymrsaPoint) -> CryptoasymrsaPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn CryptoasymrsaPoint::scale(self : CryptoasymrsaPoint, s : Double) -> CryptoasymrsaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn CryptoasymrsaPoint::dot(self : CryptoasymrsaPoint, other : CryptoasymrsaPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn CryptoasymrsaPoint::cross(self : CryptoasymrsaPoint, other : CryptoasymrsaPoint) -> CryptoasymrsaPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn CryptoasymrsaPoint::norm(self : CryptoasymrsaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn CryptoasymrsaPoint::normalize(self : CryptoasymrsaPoint) -> CryptoasymrsaPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptoasymrsaPoint::negate(self : CryptoasymrsaPoint) -> CryptoasymrsaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn CryptoasymrsaPoint::mid(self : CryptoasymrsaPoint, other : CryptoasymrsaPoint) -> CryptoasymrsaPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn CryptoasymrsaPoint::lerp(self : CryptoasymrsaPoint, other : CryptoasymrsaPoint, t : Double) -> CryptoasymrsaPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn CryptoasymrsaPoint::to_string(self : CryptoasymrsaPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct CryptoasymrsaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_asym_rsa_make_series(vals : Array[Double], name : String) -> CryptoasymrsaSeries {
  { vals, name, meta: 0 }
}

pub fn CryptoasymrsaSeries::len(self : CryptoasymrsaSeries) -> Int { self.vals.length() }

pub fn CryptoasymrsaSeries::sum(self : CryptoasymrsaSeries) -> Double { @_common.sum(self.vals) }

pub fn CryptoasymrsaSeries::mean(self : CryptoasymrsaSeries) -> Double { @_common.mean(self.vals) }

pub fn CryptoasymrsaSeries::min(self : CryptoasymrsaSeries) -> Double { @_common.min(self.vals) }

pub fn CryptoasymrsaSeries::max(self : CryptoasymrsaSeries) -> Double { @_common.max(self.vals) }

pub fn CryptoasymrsaSeries::range(self : CryptoasymrsaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn CryptoasymrsaSeries::variance(self : CryptoasymrsaSeries) -> Double { @_common.variance(self.vals) }

pub fn CryptoasymrsaSeries::std(self : CryptoasymrsaSeries) -> Double { @_common.std(self.vals) }

pub fn CryptoasymrsaSeries::median(self : CryptoasymrsaSeries) -> Double { @_common.median(self.vals) }

pub fn CryptoasymrsaSeries::scale(self : CryptoasymrsaSeries, f : Double) -> CryptoasymrsaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn CryptoasymrsaSeries::add(self : CryptoasymrsaSeries, other : CryptoasymrsaSeries) -> CryptoasymrsaSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn CryptoasymrsaSeries::sub(self : CryptoasymrsaSeries, other : CryptoasymrsaSeries) -> CryptoasymrsaSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn CryptoasymrsaSeries::normalize(self : CryptoasymrsaSeries) -> CryptoasymrsaSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn CryptoasymrsaSeries::cumsum(self : CryptoasymrsaSeries) -> CryptoasymrsaSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn CryptoasymrsaSeries::to_string(self : CryptoasymrsaSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptoasymrsaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_asym_rsa_make_matrix(rows : Int, cols : Int, val : Double) -> CryptoasymrsaMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn crypto_asym_rsa_matrix_identity(n : Int) -> CryptoasymrsaMatrix {
  let m = crypto_asym_rsa_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn CryptoasymrsaMatrix::get(self : CryptoasymrsaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn CryptoasymrsaMatrix::transpose(self : CryptoasymrsaMatrix) -> CryptoasymrsaMatrix {
  let result = crypto_asym_rsa_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn CryptoasymrsaMatrix::add(self : CryptoasymrsaMatrix, other : CryptoasymrsaMatrix) -> CryptoasymrsaMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_asym_rsa_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn CryptoasymrsaMatrix::scale(self : CryptoasymrsaMatrix, s : Double) -> CryptoasymrsaMatrix {
  let result = crypto_asym_rsa_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn CryptoasymrsaMatrix::multiply(self : CryptoasymrsaMatrix, other : CryptoasymrsaMatrix) -> CryptoasymrsaMatrix {
  if self.cols != other.rows { return crypto_asym_rsa_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_asym_rsa_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn CryptoasymrsaMatrix::trace(self : CryptoasymrsaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn CryptoasymrsaMatrix::det(self : CryptoasymrsaMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn CryptoasymrsaMatrix::norm(self : CryptoasymrsaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn CryptoasymrsaMatrix::to_string(self : CryptoasymrsaMatrix) -> String {
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

pub(all) struct CryptoasymrsaVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_asym_rsa_make_vector(comps : Array[Double]) -> CryptoasymrsaVector {
  { comps, dim: comps.length() }
}

pub fn crypto_asym_rsa_vector_zero(dim : Int) -> CryptoasymrsaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn CryptoasymrsaVector::add(self : CryptoasymrsaVector, other : CryptoasymrsaVector) -> CryptoasymrsaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn CryptoasymrsaVector::sub(self : CryptoasymrsaVector, other : CryptoasymrsaVector) -> CryptoasymrsaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn CryptoasymrsaVector::scale(self : CryptoasymrsaVector, s : Double) -> CryptoasymrsaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn CryptoasymrsaVector::dot(self : CryptoasymrsaVector, other : CryptoasymrsaVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn CryptoasymrsaVector::norm(self : CryptoasymrsaVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn CryptoasymrsaVector::normalize(self : CryptoasymrsaVector) -> CryptoasymrsaVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptoasymrsaVector::dist(self : CryptoasymrsaVector, other : CryptoasymrsaVector) -> Double {
  self.sub(other).norm()
}

pub fn CryptoasymrsaVector::to_string(self : CryptoasymrsaVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptoasymrsaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_rsa_frame_make(size : Int) -> CryptoasymrsaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymrsaFrame::len(self : CryptoasymrsaFrame) -> Int { self.size }

pub fn CryptoasymrsaFrame::get(self : CryptoasymrsaFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymrsaFrame::set(self : CryptoasymrsaFrame, i : Int, v : Double) -> CryptoasymrsaFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaFrame::sum(self : CryptoasymrsaFrame) -> Double { @_common.sum(self.data) }

pub fn CryptoasymrsaFrame::mean(self : CryptoasymrsaFrame) -> Double { @_common.mean(self.data) }

pub fn CryptoasymrsaFrame::scale(self : CryptoasymrsaFrame, f : Double) -> CryptoasymrsaFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaFrame::add(self : CryptoasymrsaFrame, other : CryptoasymrsaFrame) -> CryptoasymrsaFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymrsaFrame::copy(self : CryptoasymrsaFrame) -> CryptoasymrsaFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaFrame::fill(self : CryptoasymrsaFrame, v : Double) -> CryptoasymrsaFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaFrame::min(self : CryptoasymrsaFrame) -> Double { @_common.min(self.data) }

pub fn CryptoasymrsaFrame::max(self : CryptoasymrsaFrame) -> Double { @_common.max(self.data) }

pub fn CryptoasymrsaFrame::to_string(self : CryptoasymrsaFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymrsaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_rsa_table_make(size : Int) -> CryptoasymrsaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymrsaTable::len(self : CryptoasymrsaTable) -> Int { self.size }

pub fn CryptoasymrsaTable::get(self : CryptoasymrsaTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymrsaTable::set(self : CryptoasymrsaTable, i : Int, v : Double) -> CryptoasymrsaTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaTable::sum(self : CryptoasymrsaTable) -> Double { @_common.sum(self.data) }

pub fn CryptoasymrsaTable::mean(self : CryptoasymrsaTable) -> Double { @_common.mean(self.data) }

pub fn CryptoasymrsaTable::scale(self : CryptoasymrsaTable, f : Double) -> CryptoasymrsaTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaTable::add(self : CryptoasymrsaTable, other : CryptoasymrsaTable) -> CryptoasymrsaTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymrsaTable::copy(self : CryptoasymrsaTable) -> CryptoasymrsaTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaTable::fill(self : CryptoasymrsaTable, v : Double) -> CryptoasymrsaTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaTable::min(self : CryptoasymrsaTable) -> Double { @_common.min(self.data) }

pub fn CryptoasymrsaTable::max(self : CryptoasymrsaTable) -> Double { @_common.max(self.data) }

pub fn CryptoasymrsaTable::to_string(self : CryptoasymrsaTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymrsaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_rsa_graphn_make(size : Int) -> CryptoasymrsaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymrsaGraphN::len(self : CryptoasymrsaGraphN) -> Int { self.size }

pub fn CryptoasymrsaGraphN::get(self : CryptoasymrsaGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymrsaGraphN::set(self : CryptoasymrsaGraphN, i : Int, v : Double) -> CryptoasymrsaGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaGraphN::sum(self : CryptoasymrsaGraphN) -> Double { @_common.sum(self.data) }

pub fn CryptoasymrsaGraphN::mean(self : CryptoasymrsaGraphN) -> Double { @_common.mean(self.data) }

pub fn CryptoasymrsaGraphN::scale(self : CryptoasymrsaGraphN, f : Double) -> CryptoasymrsaGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaGraphN::add(self : CryptoasymrsaGraphN, other : CryptoasymrsaGraphN) -> CryptoasymrsaGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymrsaGraphN::copy(self : CryptoasymrsaGraphN) -> CryptoasymrsaGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaGraphN::fill(self : CryptoasymrsaGraphN, v : Double) -> CryptoasymrsaGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaGraphN::min(self : CryptoasymrsaGraphN) -> Double { @_common.min(self.data) }

pub fn CryptoasymrsaGraphN::max(self : CryptoasymrsaGraphN) -> Double { @_common.max(self.data) }

pub fn CryptoasymrsaGraphN::to_string(self : CryptoasymrsaGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymrsaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_rsa_node_make(size : Int) -> CryptoasymrsaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymrsaNode::len(self : CryptoasymrsaNode) -> Int { self.size }

pub fn CryptoasymrsaNode::get(self : CryptoasymrsaNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymrsaNode::set(self : CryptoasymrsaNode, i : Int, v : Double) -> CryptoasymrsaNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaNode::sum(self : CryptoasymrsaNode) -> Double { @_common.sum(self.data) }

pub fn CryptoasymrsaNode::mean(self : CryptoasymrsaNode) -> Double { @_common.mean(self.data) }

pub fn CryptoasymrsaNode::scale(self : CryptoasymrsaNode, f : Double) -> CryptoasymrsaNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaNode::add(self : CryptoasymrsaNode, other : CryptoasymrsaNode) -> CryptoasymrsaNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymrsaNode::copy(self : CryptoasymrsaNode) -> CryptoasymrsaNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaNode::fill(self : CryptoasymrsaNode, v : Double) -> CryptoasymrsaNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaNode::min(self : CryptoasymrsaNode) -> Double { @_common.min(self.data) }

pub fn CryptoasymrsaNode::max(self : CryptoasymrsaNode) -> Double { @_common.max(self.data) }

pub fn CryptoasymrsaNode::to_string(self : CryptoasymrsaNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymrsaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_rsa_edge_make(size : Int) -> CryptoasymrsaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymrsaEdge::len(self : CryptoasymrsaEdge) -> Int { self.size }

pub fn CryptoasymrsaEdge::get(self : CryptoasymrsaEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymrsaEdge::set(self : CryptoasymrsaEdge, i : Int, v : Double) -> CryptoasymrsaEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaEdge::sum(self : CryptoasymrsaEdge) -> Double { @_common.sum(self.data) }

pub fn CryptoasymrsaEdge::mean(self : CryptoasymrsaEdge) -> Double { @_common.mean(self.data) }

pub fn CryptoasymrsaEdge::scale(self : CryptoasymrsaEdge, f : Double) -> CryptoasymrsaEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaEdge::add(self : CryptoasymrsaEdge, other : CryptoasymrsaEdge) -> CryptoasymrsaEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymrsaEdge::copy(self : CryptoasymrsaEdge) -> CryptoasymrsaEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaEdge::fill(self : CryptoasymrsaEdge, v : Double) -> CryptoasymrsaEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaEdge::min(self : CryptoasymrsaEdge) -> Double { @_common.min(self.data) }

pub fn CryptoasymrsaEdge::max(self : CryptoasymrsaEdge) -> Double { @_common.max(self.data) }

pub fn CryptoasymrsaEdge::to_string(self : CryptoasymrsaEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymrsaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_rsa_path_make(size : Int) -> CryptoasymrsaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymrsaPath::len(self : CryptoasymrsaPath) -> Int { self.size }

pub fn CryptoasymrsaPath::get(self : CryptoasymrsaPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymrsaPath::set(self : CryptoasymrsaPath, i : Int, v : Double) -> CryptoasymrsaPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaPath::sum(self : CryptoasymrsaPath) -> Double { @_common.sum(self.data) }

pub fn CryptoasymrsaPath::mean(self : CryptoasymrsaPath) -> Double { @_common.mean(self.data) }

pub fn CryptoasymrsaPath::scale(self : CryptoasymrsaPath, f : Double) -> CryptoasymrsaPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaPath::add(self : CryptoasymrsaPath, other : CryptoasymrsaPath) -> CryptoasymrsaPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymrsaPath::copy(self : CryptoasymrsaPath) -> CryptoasymrsaPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaPath::fill(self : CryptoasymrsaPath, v : Double) -> CryptoasymrsaPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaPath::min(self : CryptoasymrsaPath) -> Double { @_common.min(self.data) }

pub fn CryptoasymrsaPath::max(self : CryptoasymrsaPath) -> Double { @_common.max(self.data) }

pub fn CryptoasymrsaPath::to_string(self : CryptoasymrsaPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymrsaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_rsa_cluster_make(size : Int) -> CryptoasymrsaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymrsaCluster::len(self : CryptoasymrsaCluster) -> Int { self.size }

pub fn CryptoasymrsaCluster::get(self : CryptoasymrsaCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymrsaCluster::set(self : CryptoasymrsaCluster, i : Int, v : Double) -> CryptoasymrsaCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaCluster::sum(self : CryptoasymrsaCluster) -> Double { @_common.sum(self.data) }

pub fn CryptoasymrsaCluster::mean(self : CryptoasymrsaCluster) -> Double { @_common.mean(self.data) }

pub fn CryptoasymrsaCluster::scale(self : CryptoasymrsaCluster, f : Double) -> CryptoasymrsaCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaCluster::add(self : CryptoasymrsaCluster, other : CryptoasymrsaCluster) -> CryptoasymrsaCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymrsaCluster::copy(self : CryptoasymrsaCluster) -> CryptoasymrsaCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaCluster::fill(self : CryptoasymrsaCluster, v : Double) -> CryptoasymrsaCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaCluster::min(self : CryptoasymrsaCluster) -> Double { @_common.min(self.data) }

pub fn CryptoasymrsaCluster::max(self : CryptoasymrsaCluster) -> Double { @_common.max(self.data) }

pub fn CryptoasymrsaCluster::to_string(self : CryptoasymrsaCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymrsaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_rsa_model_make(size : Int) -> CryptoasymrsaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymrsaModel::len(self : CryptoasymrsaModel) -> Int { self.size }

pub fn CryptoasymrsaModel::get(self : CryptoasymrsaModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymrsaModel::set(self : CryptoasymrsaModel, i : Int, v : Double) -> CryptoasymrsaModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaModel::sum(self : CryptoasymrsaModel) -> Double { @_common.sum(self.data) }

pub fn CryptoasymrsaModel::mean(self : CryptoasymrsaModel) -> Double { @_common.mean(self.data) }

pub fn CryptoasymrsaModel::scale(self : CryptoasymrsaModel, f : Double) -> CryptoasymrsaModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaModel::add(self : CryptoasymrsaModel, other : CryptoasymrsaModel) -> CryptoasymrsaModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymrsaModel::copy(self : CryptoasymrsaModel) -> CryptoasymrsaModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaModel::fill(self : CryptoasymrsaModel, v : Double) -> CryptoasymrsaModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaModel::min(self : CryptoasymrsaModel) -> Double { @_common.min(self.data) }

pub fn CryptoasymrsaModel::max(self : CryptoasymrsaModel) -> Double { @_common.max(self.data) }

pub fn CryptoasymrsaModel::to_string(self : CryptoasymrsaModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymrsaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_rsa_layer_make(size : Int) -> CryptoasymrsaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymrsaLayer::len(self : CryptoasymrsaLayer) -> Int { self.size }

pub fn CryptoasymrsaLayer::get(self : CryptoasymrsaLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymrsaLayer::set(self : CryptoasymrsaLayer, i : Int, v : Double) -> CryptoasymrsaLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaLayer::sum(self : CryptoasymrsaLayer) -> Double { @_common.sum(self.data) }

pub fn CryptoasymrsaLayer::mean(self : CryptoasymrsaLayer) -> Double { @_common.mean(self.data) }

pub fn CryptoasymrsaLayer::scale(self : CryptoasymrsaLayer, f : Double) -> CryptoasymrsaLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaLayer::add(self : CryptoasymrsaLayer, other : CryptoasymrsaLayer) -> CryptoasymrsaLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymrsaLayer::copy(self : CryptoasymrsaLayer) -> CryptoasymrsaLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaLayer::fill(self : CryptoasymrsaLayer, v : Double) -> CryptoasymrsaLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaLayer::min(self : CryptoasymrsaLayer) -> Double { @_common.min(self.data) }

pub fn CryptoasymrsaLayer::max(self : CryptoasymrsaLayer) -> Double { @_common.max(self.data) }

pub fn CryptoasymrsaLayer::to_string(self : CryptoasymrsaLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymrsaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_rsa_buffer_make(size : Int) -> CryptoasymrsaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymrsaBuffer::len(self : CryptoasymrsaBuffer) -> Int { self.size }

pub fn CryptoasymrsaBuffer::get(self : CryptoasymrsaBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymrsaBuffer::set(self : CryptoasymrsaBuffer, i : Int, v : Double) -> CryptoasymrsaBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaBuffer::sum(self : CryptoasymrsaBuffer) -> Double { @_common.sum(self.data) }

pub fn CryptoasymrsaBuffer::mean(self : CryptoasymrsaBuffer) -> Double { @_common.mean(self.data) }

pub fn CryptoasymrsaBuffer::scale(self : CryptoasymrsaBuffer, f : Double) -> CryptoasymrsaBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaBuffer::add(self : CryptoasymrsaBuffer, other : CryptoasymrsaBuffer) -> CryptoasymrsaBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymrsaBuffer::copy(self : CryptoasymrsaBuffer) -> CryptoasymrsaBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaBuffer::fill(self : CryptoasymrsaBuffer, v : Double) -> CryptoasymrsaBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaBuffer::min(self : CryptoasymrsaBuffer) -> Double { @_common.min(self.data) }

pub fn CryptoasymrsaBuffer::max(self : CryptoasymrsaBuffer) -> Double { @_common.max(self.data) }

pub fn CryptoasymrsaBuffer::to_string(self : CryptoasymrsaBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymrsaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_rsa_cursor_make(size : Int) -> CryptoasymrsaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymrsaCursor::len(self : CryptoasymrsaCursor) -> Int { self.size }

pub fn CryptoasymrsaCursor::get(self : CryptoasymrsaCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymrsaCursor::set(self : CryptoasymrsaCursor, i : Int, v : Double) -> CryptoasymrsaCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaCursor::sum(self : CryptoasymrsaCursor) -> Double { @_common.sum(self.data) }

pub fn CryptoasymrsaCursor::mean(self : CryptoasymrsaCursor) -> Double { @_common.mean(self.data) }

pub fn CryptoasymrsaCursor::scale(self : CryptoasymrsaCursor, f : Double) -> CryptoasymrsaCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaCursor::add(self : CryptoasymrsaCursor, other : CryptoasymrsaCursor) -> CryptoasymrsaCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymrsaCursor::copy(self : CryptoasymrsaCursor) -> CryptoasymrsaCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaCursor::fill(self : CryptoasymrsaCursor, v : Double) -> CryptoasymrsaCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaCursor::min(self : CryptoasymrsaCursor) -> Double { @_common.min(self.data) }

pub fn CryptoasymrsaCursor::max(self : CryptoasymrsaCursor) -> Double { @_common.max(self.data) }

pub fn CryptoasymrsaCursor::to_string(self : CryptoasymrsaCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymrsaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_rsa_view_make(size : Int) -> CryptoasymrsaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymrsaView::len(self : CryptoasymrsaView) -> Int { self.size }

pub fn CryptoasymrsaView::get(self : CryptoasymrsaView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymrsaView::set(self : CryptoasymrsaView, i : Int, v : Double) -> CryptoasymrsaView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaView::sum(self : CryptoasymrsaView) -> Double { @_common.sum(self.data) }

pub fn CryptoasymrsaView::mean(self : CryptoasymrsaView) -> Double { @_common.mean(self.data) }

pub fn CryptoasymrsaView::scale(self : CryptoasymrsaView, f : Double) -> CryptoasymrsaView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaView::add(self : CryptoasymrsaView, other : CryptoasymrsaView) -> CryptoasymrsaView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymrsaView::copy(self : CryptoasymrsaView) -> CryptoasymrsaView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaView::fill(self : CryptoasymrsaView, v : Double) -> CryptoasymrsaView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaView::min(self : CryptoasymrsaView) -> Double { @_common.min(self.data) }

pub fn CryptoasymrsaView::max(self : CryptoasymrsaView) -> Double { @_common.max(self.data) }

pub fn CryptoasymrsaView::to_string(self : CryptoasymrsaView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymrsaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_rsa_range_make(size : Int) -> CryptoasymrsaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymrsaRange::len(self : CryptoasymrsaRange) -> Int { self.size }

pub fn CryptoasymrsaRange::get(self : CryptoasymrsaRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymrsaRange::set(self : CryptoasymrsaRange, i : Int, v : Double) -> CryptoasymrsaRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaRange::sum(self : CryptoasymrsaRange) -> Double { @_common.sum(self.data) }

pub fn CryptoasymrsaRange::mean(self : CryptoasymrsaRange) -> Double { @_common.mean(self.data) }

pub fn CryptoasymrsaRange::scale(self : CryptoasymrsaRange, f : Double) -> CryptoasymrsaRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaRange::add(self : CryptoasymrsaRange, other : CryptoasymrsaRange) -> CryptoasymrsaRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymrsaRange::copy(self : CryptoasymrsaRange) -> CryptoasymrsaRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaRange::fill(self : CryptoasymrsaRange, v : Double) -> CryptoasymrsaRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaRange::min(self : CryptoasymrsaRange) -> Double { @_common.min(self.data) }

pub fn CryptoasymrsaRange::max(self : CryptoasymrsaRange) -> Double { @_common.max(self.data) }

pub fn CryptoasymrsaRange::to_string(self : CryptoasymrsaRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymrsaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_rsa_slice_make(size : Int) -> CryptoasymrsaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymrsaSlice::len(self : CryptoasymrsaSlice) -> Int { self.size }

pub fn CryptoasymrsaSlice::get(self : CryptoasymrsaSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymrsaSlice::set(self : CryptoasymrsaSlice, i : Int, v : Double) -> CryptoasymrsaSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaSlice::sum(self : CryptoasymrsaSlice) -> Double { @_common.sum(self.data) }

pub fn CryptoasymrsaSlice::mean(self : CryptoasymrsaSlice) -> Double { @_common.mean(self.data) }

pub fn CryptoasymrsaSlice::scale(self : CryptoasymrsaSlice, f : Double) -> CryptoasymrsaSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaSlice::add(self : CryptoasymrsaSlice, other : CryptoasymrsaSlice) -> CryptoasymrsaSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymrsaSlice::copy(self : CryptoasymrsaSlice) -> CryptoasymrsaSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaSlice::fill(self : CryptoasymrsaSlice, v : Double) -> CryptoasymrsaSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymrsaSlice::min(self : CryptoasymrsaSlice) -> Double { @_common.min(self.data) }

pub fn CryptoasymrsaSlice::max(self : CryptoasymrsaSlice) -> Double { @_common.max(self.data) }

pub fn CryptoasymrsaSlice::to_string(self : CryptoasymrsaSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

