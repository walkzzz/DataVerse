///===
/// extcore/crypto_sign_dsa

pub(all) struct CryptosigndsaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sign_dsa_make_point(x : Double, y : Double) -> CryptosigndsaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sign_dsa_make_point3(x : Double, y : Double, z : Double) -> CryptosigndsaPoint {
  { x, y, z, label: 0 }
}

pub fn CryptosigndsaPoint::x(self : CryptosigndsaPoint) -> Double { self.x }

pub fn CryptosigndsaPoint::y(self : CryptosigndsaPoint) -> Double { self.y }

pub fn CryptosigndsaPoint::z(self : CryptosigndsaPoint) -> Double { self.z }

pub fn CryptosigndsaPoint::label(self : CryptosigndsaPoint) -> Int { self.label }

pub fn CryptosigndsaPoint::dist(self : CryptosigndsaPoint, other : CryptosigndsaPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn CryptosigndsaPoint::add(self : CryptosigndsaPoint, other : CryptosigndsaPoint) -> CryptosigndsaPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn CryptosigndsaPoint::sub(self : CryptosigndsaPoint, other : CryptosigndsaPoint) -> CryptosigndsaPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn CryptosigndsaPoint::scale(self : CryptosigndsaPoint, s : Double) -> CryptosigndsaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn CryptosigndsaPoint::dot(self : CryptosigndsaPoint, other : CryptosigndsaPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn CryptosigndsaPoint::cross(self : CryptosigndsaPoint, other : CryptosigndsaPoint) -> CryptosigndsaPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn CryptosigndsaPoint::norm(self : CryptosigndsaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn CryptosigndsaPoint::normalize(self : CryptosigndsaPoint) -> CryptosigndsaPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosigndsaPoint::negate(self : CryptosigndsaPoint) -> CryptosigndsaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn CryptosigndsaPoint::mid(self : CryptosigndsaPoint, other : CryptosigndsaPoint) -> CryptosigndsaPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn CryptosigndsaPoint::lerp(self : CryptosigndsaPoint, other : CryptosigndsaPoint, t : Double) -> CryptosigndsaPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn CryptosigndsaPoint::to_string(self : CryptosigndsaPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct CryptosigndsaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sign_dsa_make_series(vals : Array[Double], name : String) -> CryptosigndsaSeries {
  { vals, name, meta: 0 }
}

pub fn CryptosigndsaSeries::len(self : CryptosigndsaSeries) -> Int { self.vals.length() }

pub fn CryptosigndsaSeries::sum(self : CryptosigndsaSeries) -> Double { @_common.sum(self.vals) }

pub fn CryptosigndsaSeries::mean(self : CryptosigndsaSeries) -> Double { @_common.mean(self.vals) }

pub fn CryptosigndsaSeries::min(self : CryptosigndsaSeries) -> Double { @_common.min(self.vals) }

pub fn CryptosigndsaSeries::max(self : CryptosigndsaSeries) -> Double { @_common.max(self.vals) }

pub fn CryptosigndsaSeries::range(self : CryptosigndsaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn CryptosigndsaSeries::variance(self : CryptosigndsaSeries) -> Double { @_common.variance(self.vals) }

pub fn CryptosigndsaSeries::std(self : CryptosigndsaSeries) -> Double { @_common.std(self.vals) }

pub fn CryptosigndsaSeries::median(self : CryptosigndsaSeries) -> Double { @_common.median(self.vals) }

pub fn CryptosigndsaSeries::scale(self : CryptosigndsaSeries, f : Double) -> CryptosigndsaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn CryptosigndsaSeries::add(self : CryptosigndsaSeries, other : CryptosigndsaSeries) -> CryptosigndsaSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn CryptosigndsaSeries::sub(self : CryptosigndsaSeries, other : CryptosigndsaSeries) -> CryptosigndsaSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn CryptosigndsaSeries::normalize(self : CryptosigndsaSeries) -> CryptosigndsaSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn CryptosigndsaSeries::cumsum(self : CryptosigndsaSeries) -> CryptosigndsaSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn CryptosigndsaSeries::to_string(self : CryptosigndsaSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosigndsaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sign_dsa_make_matrix(rows : Int, cols : Int, val : Double) -> CryptosigndsaMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn crypto_sign_dsa_matrix_identity(n : Int) -> CryptosigndsaMatrix {
  let m = crypto_sign_dsa_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn CryptosigndsaMatrix::get(self : CryptosigndsaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn CryptosigndsaMatrix::transpose(self : CryptosigndsaMatrix) -> CryptosigndsaMatrix {
  let result = crypto_sign_dsa_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn CryptosigndsaMatrix::add(self : CryptosigndsaMatrix, other : CryptosigndsaMatrix) -> CryptosigndsaMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_sign_dsa_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn CryptosigndsaMatrix::scale(self : CryptosigndsaMatrix, s : Double) -> CryptosigndsaMatrix {
  let result = crypto_sign_dsa_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn CryptosigndsaMatrix::multiply(self : CryptosigndsaMatrix, other : CryptosigndsaMatrix) -> CryptosigndsaMatrix {
  if self.cols != other.rows { return crypto_sign_dsa_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_sign_dsa_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn CryptosigndsaMatrix::trace(self : CryptosigndsaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn CryptosigndsaMatrix::det(self : CryptosigndsaMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn CryptosigndsaMatrix::norm(self : CryptosigndsaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn CryptosigndsaMatrix::to_string(self : CryptosigndsaMatrix) -> String {
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

pub(all) struct CryptosigndsaVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sign_dsa_make_vector(comps : Array[Double]) -> CryptosigndsaVector {
  { comps, dim: comps.length() }
}

pub fn crypto_sign_dsa_vector_zero(dim : Int) -> CryptosigndsaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn CryptosigndsaVector::add(self : CryptosigndsaVector, other : CryptosigndsaVector) -> CryptosigndsaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosigndsaVector::sub(self : CryptosigndsaVector, other : CryptosigndsaVector) -> CryptosigndsaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosigndsaVector::scale(self : CryptosigndsaVector, s : Double) -> CryptosigndsaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn CryptosigndsaVector::dot(self : CryptosigndsaVector, other : CryptosigndsaVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn CryptosigndsaVector::norm(self : CryptosigndsaVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn CryptosigndsaVector::normalize(self : CryptosigndsaVector) -> CryptosigndsaVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosigndsaVector::dist(self : CryptosigndsaVector, other : CryptosigndsaVector) -> Double {
  self.sub(other).norm()
}

pub fn CryptosigndsaVector::to_string(self : CryptosigndsaVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosigndsaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_dsa_frame_make(size : Int) -> CryptosigndsaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosigndsaFrame::len(self : CryptosigndsaFrame) -> Int { self.size }

pub fn CryptosigndsaFrame::get(self : CryptosigndsaFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosigndsaFrame::set(self : CryptosigndsaFrame, i : Int, v : Double) -> CryptosigndsaFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosigndsaFrame::sum(self : CryptosigndsaFrame) -> Double { @_common.sum(self.data) }

pub fn CryptosigndsaFrame::mean(self : CryptosigndsaFrame) -> Double { @_common.mean(self.data) }

pub fn CryptosigndsaFrame::scale(self : CryptosigndsaFrame, f : Double) -> CryptosigndsaFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosigndsaFrame::add(self : CryptosigndsaFrame, other : CryptosigndsaFrame) -> CryptosigndsaFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosigndsaFrame::copy(self : CryptosigndsaFrame) -> CryptosigndsaFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosigndsaFrame::fill(self : CryptosigndsaFrame, v : Double) -> CryptosigndsaFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosigndsaFrame::min(self : CryptosigndsaFrame) -> Double { @_common.min(self.data) }

pub fn CryptosigndsaFrame::max(self : CryptosigndsaFrame) -> Double { @_common.max(self.data) }

pub fn CryptosigndsaFrame::to_string(self : CryptosigndsaFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosigndsaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_dsa_table_make(size : Int) -> CryptosigndsaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosigndsaTable::len(self : CryptosigndsaTable) -> Int { self.size }

pub fn CryptosigndsaTable::get(self : CryptosigndsaTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosigndsaTable::set(self : CryptosigndsaTable, i : Int, v : Double) -> CryptosigndsaTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosigndsaTable::sum(self : CryptosigndsaTable) -> Double { @_common.sum(self.data) }

pub fn CryptosigndsaTable::mean(self : CryptosigndsaTable) -> Double { @_common.mean(self.data) }

pub fn CryptosigndsaTable::scale(self : CryptosigndsaTable, f : Double) -> CryptosigndsaTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosigndsaTable::add(self : CryptosigndsaTable, other : CryptosigndsaTable) -> CryptosigndsaTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosigndsaTable::copy(self : CryptosigndsaTable) -> CryptosigndsaTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosigndsaTable::fill(self : CryptosigndsaTable, v : Double) -> CryptosigndsaTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosigndsaTable::min(self : CryptosigndsaTable) -> Double { @_common.min(self.data) }

pub fn CryptosigndsaTable::max(self : CryptosigndsaTable) -> Double { @_common.max(self.data) }

pub fn CryptosigndsaTable::to_string(self : CryptosigndsaTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosigndsaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_dsa_graphn_make(size : Int) -> CryptosigndsaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosigndsaGraphN::len(self : CryptosigndsaGraphN) -> Int { self.size }

pub fn CryptosigndsaGraphN::get(self : CryptosigndsaGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosigndsaGraphN::set(self : CryptosigndsaGraphN, i : Int, v : Double) -> CryptosigndsaGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosigndsaGraphN::sum(self : CryptosigndsaGraphN) -> Double { @_common.sum(self.data) }

pub fn CryptosigndsaGraphN::mean(self : CryptosigndsaGraphN) -> Double { @_common.mean(self.data) }

pub fn CryptosigndsaGraphN::scale(self : CryptosigndsaGraphN, f : Double) -> CryptosigndsaGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosigndsaGraphN::add(self : CryptosigndsaGraphN, other : CryptosigndsaGraphN) -> CryptosigndsaGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosigndsaGraphN::copy(self : CryptosigndsaGraphN) -> CryptosigndsaGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosigndsaGraphN::fill(self : CryptosigndsaGraphN, v : Double) -> CryptosigndsaGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosigndsaGraphN::min(self : CryptosigndsaGraphN) -> Double { @_common.min(self.data) }

pub fn CryptosigndsaGraphN::max(self : CryptosigndsaGraphN) -> Double { @_common.max(self.data) }

pub fn CryptosigndsaGraphN::to_string(self : CryptosigndsaGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosigndsaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_dsa_node_make(size : Int) -> CryptosigndsaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosigndsaNode::len(self : CryptosigndsaNode) -> Int { self.size }

pub fn CryptosigndsaNode::get(self : CryptosigndsaNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosigndsaNode::set(self : CryptosigndsaNode, i : Int, v : Double) -> CryptosigndsaNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosigndsaNode::sum(self : CryptosigndsaNode) -> Double { @_common.sum(self.data) }

pub fn CryptosigndsaNode::mean(self : CryptosigndsaNode) -> Double { @_common.mean(self.data) }

pub fn CryptosigndsaNode::scale(self : CryptosigndsaNode, f : Double) -> CryptosigndsaNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosigndsaNode::add(self : CryptosigndsaNode, other : CryptosigndsaNode) -> CryptosigndsaNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosigndsaNode::copy(self : CryptosigndsaNode) -> CryptosigndsaNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosigndsaNode::fill(self : CryptosigndsaNode, v : Double) -> CryptosigndsaNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosigndsaNode::min(self : CryptosigndsaNode) -> Double { @_common.min(self.data) }

pub fn CryptosigndsaNode::max(self : CryptosigndsaNode) -> Double { @_common.max(self.data) }

pub fn CryptosigndsaNode::to_string(self : CryptosigndsaNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosigndsaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_dsa_edge_make(size : Int) -> CryptosigndsaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosigndsaEdge::len(self : CryptosigndsaEdge) -> Int { self.size }

pub fn CryptosigndsaEdge::get(self : CryptosigndsaEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosigndsaEdge::set(self : CryptosigndsaEdge, i : Int, v : Double) -> CryptosigndsaEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosigndsaEdge::sum(self : CryptosigndsaEdge) -> Double { @_common.sum(self.data) }

pub fn CryptosigndsaEdge::mean(self : CryptosigndsaEdge) -> Double { @_common.mean(self.data) }

pub fn CryptosigndsaEdge::scale(self : CryptosigndsaEdge, f : Double) -> CryptosigndsaEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosigndsaEdge::add(self : CryptosigndsaEdge, other : CryptosigndsaEdge) -> CryptosigndsaEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosigndsaEdge::copy(self : CryptosigndsaEdge) -> CryptosigndsaEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosigndsaEdge::fill(self : CryptosigndsaEdge, v : Double) -> CryptosigndsaEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosigndsaEdge::min(self : CryptosigndsaEdge) -> Double { @_common.min(self.data) }

pub fn CryptosigndsaEdge::max(self : CryptosigndsaEdge) -> Double { @_common.max(self.data) }

pub fn CryptosigndsaEdge::to_string(self : CryptosigndsaEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosigndsaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_dsa_path_make(size : Int) -> CryptosigndsaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosigndsaPath::len(self : CryptosigndsaPath) -> Int { self.size }

pub fn CryptosigndsaPath::get(self : CryptosigndsaPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosigndsaPath::set(self : CryptosigndsaPath, i : Int, v : Double) -> CryptosigndsaPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosigndsaPath::sum(self : CryptosigndsaPath) -> Double { @_common.sum(self.data) }

pub fn CryptosigndsaPath::mean(self : CryptosigndsaPath) -> Double { @_common.mean(self.data) }

pub fn CryptosigndsaPath::scale(self : CryptosigndsaPath, f : Double) -> CryptosigndsaPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosigndsaPath::add(self : CryptosigndsaPath, other : CryptosigndsaPath) -> CryptosigndsaPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosigndsaPath::copy(self : CryptosigndsaPath) -> CryptosigndsaPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosigndsaPath::fill(self : CryptosigndsaPath, v : Double) -> CryptosigndsaPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosigndsaPath::min(self : CryptosigndsaPath) -> Double { @_common.min(self.data) }

pub fn CryptosigndsaPath::max(self : CryptosigndsaPath) -> Double { @_common.max(self.data) }

pub fn CryptosigndsaPath::to_string(self : CryptosigndsaPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosigndsaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_dsa_cluster_make(size : Int) -> CryptosigndsaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosigndsaCluster::len(self : CryptosigndsaCluster) -> Int { self.size }

pub fn CryptosigndsaCluster::get(self : CryptosigndsaCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosigndsaCluster::set(self : CryptosigndsaCluster, i : Int, v : Double) -> CryptosigndsaCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosigndsaCluster::sum(self : CryptosigndsaCluster) -> Double { @_common.sum(self.data) }

pub fn CryptosigndsaCluster::mean(self : CryptosigndsaCluster) -> Double { @_common.mean(self.data) }

pub fn CryptosigndsaCluster::scale(self : CryptosigndsaCluster, f : Double) -> CryptosigndsaCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosigndsaCluster::add(self : CryptosigndsaCluster, other : CryptosigndsaCluster) -> CryptosigndsaCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosigndsaCluster::copy(self : CryptosigndsaCluster) -> CryptosigndsaCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosigndsaCluster::fill(self : CryptosigndsaCluster, v : Double) -> CryptosigndsaCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosigndsaCluster::min(self : CryptosigndsaCluster) -> Double { @_common.min(self.data) }

pub fn CryptosigndsaCluster::max(self : CryptosigndsaCluster) -> Double { @_common.max(self.data) }

pub fn CryptosigndsaCluster::to_string(self : CryptosigndsaCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosigndsaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_dsa_model_make(size : Int) -> CryptosigndsaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosigndsaModel::len(self : CryptosigndsaModel) -> Int { self.size }

pub fn CryptosigndsaModel::get(self : CryptosigndsaModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosigndsaModel::set(self : CryptosigndsaModel, i : Int, v : Double) -> CryptosigndsaModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosigndsaModel::sum(self : CryptosigndsaModel) -> Double { @_common.sum(self.data) }

pub fn CryptosigndsaModel::mean(self : CryptosigndsaModel) -> Double { @_common.mean(self.data) }

pub fn CryptosigndsaModel::scale(self : CryptosigndsaModel, f : Double) -> CryptosigndsaModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosigndsaModel::add(self : CryptosigndsaModel, other : CryptosigndsaModel) -> CryptosigndsaModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosigndsaModel::copy(self : CryptosigndsaModel) -> CryptosigndsaModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosigndsaModel::fill(self : CryptosigndsaModel, v : Double) -> CryptosigndsaModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosigndsaModel::min(self : CryptosigndsaModel) -> Double { @_common.min(self.data) }

pub fn CryptosigndsaModel::max(self : CryptosigndsaModel) -> Double { @_common.max(self.data) }

pub fn CryptosigndsaModel::to_string(self : CryptosigndsaModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosigndsaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_dsa_layer_make(size : Int) -> CryptosigndsaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosigndsaLayer::len(self : CryptosigndsaLayer) -> Int { self.size }

pub fn CryptosigndsaLayer::get(self : CryptosigndsaLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosigndsaLayer::set(self : CryptosigndsaLayer, i : Int, v : Double) -> CryptosigndsaLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosigndsaLayer::sum(self : CryptosigndsaLayer) -> Double { @_common.sum(self.data) }

pub fn CryptosigndsaLayer::mean(self : CryptosigndsaLayer) -> Double { @_common.mean(self.data) }

pub fn CryptosigndsaLayer::scale(self : CryptosigndsaLayer, f : Double) -> CryptosigndsaLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosigndsaLayer::add(self : CryptosigndsaLayer, other : CryptosigndsaLayer) -> CryptosigndsaLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosigndsaLayer::copy(self : CryptosigndsaLayer) -> CryptosigndsaLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosigndsaLayer::fill(self : CryptosigndsaLayer, v : Double) -> CryptosigndsaLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosigndsaLayer::min(self : CryptosigndsaLayer) -> Double { @_common.min(self.data) }

pub fn CryptosigndsaLayer::max(self : CryptosigndsaLayer) -> Double { @_common.max(self.data) }

pub fn CryptosigndsaLayer::to_string(self : CryptosigndsaLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosigndsaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_dsa_buffer_make(size : Int) -> CryptosigndsaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosigndsaBuffer::len(self : CryptosigndsaBuffer) -> Int { self.size }

pub fn CryptosigndsaBuffer::get(self : CryptosigndsaBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosigndsaBuffer::set(self : CryptosigndsaBuffer, i : Int, v : Double) -> CryptosigndsaBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosigndsaBuffer::sum(self : CryptosigndsaBuffer) -> Double { @_common.sum(self.data) }

pub fn CryptosigndsaBuffer::mean(self : CryptosigndsaBuffer) -> Double { @_common.mean(self.data) }

pub fn CryptosigndsaBuffer::scale(self : CryptosigndsaBuffer, f : Double) -> CryptosigndsaBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosigndsaBuffer::add(self : CryptosigndsaBuffer, other : CryptosigndsaBuffer) -> CryptosigndsaBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosigndsaBuffer::copy(self : CryptosigndsaBuffer) -> CryptosigndsaBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosigndsaBuffer::fill(self : CryptosigndsaBuffer, v : Double) -> CryptosigndsaBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosigndsaBuffer::min(self : CryptosigndsaBuffer) -> Double { @_common.min(self.data) }

pub fn CryptosigndsaBuffer::max(self : CryptosigndsaBuffer) -> Double { @_common.max(self.data) }

pub fn CryptosigndsaBuffer::to_string(self : CryptosigndsaBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosigndsaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_dsa_cursor_make(size : Int) -> CryptosigndsaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosigndsaCursor::len(self : CryptosigndsaCursor) -> Int { self.size }

pub fn CryptosigndsaCursor::get(self : CryptosigndsaCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosigndsaCursor::set(self : CryptosigndsaCursor, i : Int, v : Double) -> CryptosigndsaCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosigndsaCursor::sum(self : CryptosigndsaCursor) -> Double { @_common.sum(self.data) }

pub fn CryptosigndsaCursor::mean(self : CryptosigndsaCursor) -> Double { @_common.mean(self.data) }

pub fn CryptosigndsaCursor::scale(self : CryptosigndsaCursor, f : Double) -> CryptosigndsaCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosigndsaCursor::add(self : CryptosigndsaCursor, other : CryptosigndsaCursor) -> CryptosigndsaCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosigndsaCursor::copy(self : CryptosigndsaCursor) -> CryptosigndsaCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosigndsaCursor::fill(self : CryptosigndsaCursor, v : Double) -> CryptosigndsaCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosigndsaCursor::min(self : CryptosigndsaCursor) -> Double { @_common.min(self.data) }

pub fn CryptosigndsaCursor::max(self : CryptosigndsaCursor) -> Double { @_common.max(self.data) }

pub fn CryptosigndsaCursor::to_string(self : CryptosigndsaCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosigndsaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_dsa_view_make(size : Int) -> CryptosigndsaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosigndsaView::len(self : CryptosigndsaView) -> Int { self.size }

pub fn CryptosigndsaView::get(self : CryptosigndsaView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosigndsaView::set(self : CryptosigndsaView, i : Int, v : Double) -> CryptosigndsaView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosigndsaView::sum(self : CryptosigndsaView) -> Double { @_common.sum(self.data) }

pub fn CryptosigndsaView::mean(self : CryptosigndsaView) -> Double { @_common.mean(self.data) }

pub fn CryptosigndsaView::scale(self : CryptosigndsaView, f : Double) -> CryptosigndsaView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosigndsaView::add(self : CryptosigndsaView, other : CryptosigndsaView) -> CryptosigndsaView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosigndsaView::copy(self : CryptosigndsaView) -> CryptosigndsaView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosigndsaView::fill(self : CryptosigndsaView, v : Double) -> CryptosigndsaView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosigndsaView::min(self : CryptosigndsaView) -> Double { @_common.min(self.data) }

pub fn CryptosigndsaView::max(self : CryptosigndsaView) -> Double { @_common.max(self.data) }

pub fn CryptosigndsaView::to_string(self : CryptosigndsaView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosigndsaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_dsa_range_make(size : Int) -> CryptosigndsaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosigndsaRange::len(self : CryptosigndsaRange) -> Int { self.size }

pub fn CryptosigndsaRange::get(self : CryptosigndsaRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosigndsaRange::set(self : CryptosigndsaRange, i : Int, v : Double) -> CryptosigndsaRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosigndsaRange::sum(self : CryptosigndsaRange) -> Double { @_common.sum(self.data) }

pub fn CryptosigndsaRange::mean(self : CryptosigndsaRange) -> Double { @_common.mean(self.data) }

pub fn CryptosigndsaRange::scale(self : CryptosigndsaRange, f : Double) -> CryptosigndsaRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosigndsaRange::add(self : CryptosigndsaRange, other : CryptosigndsaRange) -> CryptosigndsaRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosigndsaRange::copy(self : CryptosigndsaRange) -> CryptosigndsaRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosigndsaRange::fill(self : CryptosigndsaRange, v : Double) -> CryptosigndsaRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosigndsaRange::min(self : CryptosigndsaRange) -> Double { @_common.min(self.data) }

pub fn CryptosigndsaRange::max(self : CryptosigndsaRange) -> Double { @_common.max(self.data) }

pub fn CryptosigndsaRange::to_string(self : CryptosigndsaRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosigndsaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_dsa_slice_make(size : Int) -> CryptosigndsaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosigndsaSlice::len(self : CryptosigndsaSlice) -> Int { self.size }

pub fn CryptosigndsaSlice::get(self : CryptosigndsaSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosigndsaSlice::set(self : CryptosigndsaSlice, i : Int, v : Double) -> CryptosigndsaSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosigndsaSlice::sum(self : CryptosigndsaSlice) -> Double { @_common.sum(self.data) }

pub fn CryptosigndsaSlice::mean(self : CryptosigndsaSlice) -> Double { @_common.mean(self.data) }

pub fn CryptosigndsaSlice::scale(self : CryptosigndsaSlice, f : Double) -> CryptosigndsaSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosigndsaSlice::add(self : CryptosigndsaSlice, other : CryptosigndsaSlice) -> CryptosigndsaSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosigndsaSlice::copy(self : CryptosigndsaSlice) -> CryptosigndsaSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosigndsaSlice::fill(self : CryptosigndsaSlice, v : Double) -> CryptosigndsaSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosigndsaSlice::min(self : CryptosigndsaSlice) -> Double { @_common.min(self.data) }

pub fn CryptosigndsaSlice::max(self : CryptosigndsaSlice) -> Double { @_common.max(self.data) }

pub fn CryptosigndsaSlice::to_string(self : CryptosigndsaSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

