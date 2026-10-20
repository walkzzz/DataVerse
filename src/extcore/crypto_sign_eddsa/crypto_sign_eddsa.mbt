///===
/// extcore/crypto_sign_eddsa

pub(all) struct CryptosigneddsaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sign_eddsa_make_point(x : Double, y : Double) -> CryptosigneddsaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sign_eddsa_make_point3(x : Double, y : Double, z : Double) -> CryptosigneddsaPoint {
  { x, y, z, label: 0 }
}

pub fn CryptosigneddsaPoint::x(self : CryptosigneddsaPoint) -> Double { self.x }

pub fn CryptosigneddsaPoint::y(self : CryptosigneddsaPoint) -> Double { self.y }

pub fn CryptosigneddsaPoint::z(self : CryptosigneddsaPoint) -> Double { self.z }

pub fn CryptosigneddsaPoint::label(self : CryptosigneddsaPoint) -> Int { self.label }

pub fn CryptosigneddsaPoint::dist(self : CryptosigneddsaPoint, other : CryptosigneddsaPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn CryptosigneddsaPoint::add(self : CryptosigneddsaPoint, other : CryptosigneddsaPoint) -> CryptosigneddsaPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn CryptosigneddsaPoint::sub(self : CryptosigneddsaPoint, other : CryptosigneddsaPoint) -> CryptosigneddsaPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn CryptosigneddsaPoint::scale(self : CryptosigneddsaPoint, s : Double) -> CryptosigneddsaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn CryptosigneddsaPoint::dot(self : CryptosigneddsaPoint, other : CryptosigneddsaPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn CryptosigneddsaPoint::cross(self : CryptosigneddsaPoint, other : CryptosigneddsaPoint) -> CryptosigneddsaPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn CryptosigneddsaPoint::norm(self : CryptosigneddsaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn CryptosigneddsaPoint::normalize(self : CryptosigneddsaPoint) -> CryptosigneddsaPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosigneddsaPoint::negate(self : CryptosigneddsaPoint) -> CryptosigneddsaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn CryptosigneddsaPoint::mid(self : CryptosigneddsaPoint, other : CryptosigneddsaPoint) -> CryptosigneddsaPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn CryptosigneddsaPoint::lerp(self : CryptosigneddsaPoint, other : CryptosigneddsaPoint, t : Double) -> CryptosigneddsaPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn CryptosigneddsaPoint::to_string(self : CryptosigneddsaPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct CryptosigneddsaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sign_eddsa_make_series(vals : Array[Double], name : String) -> CryptosigneddsaSeries {
  { vals, name, meta: 0 }
}

pub fn CryptosigneddsaSeries::len(self : CryptosigneddsaSeries) -> Int { self.vals.length() }

pub fn CryptosigneddsaSeries::sum(self : CryptosigneddsaSeries) -> Double { @_common.sum(self.vals) }

pub fn CryptosigneddsaSeries::mean(self : CryptosigneddsaSeries) -> Double { @_common.mean(self.vals) }

pub fn CryptosigneddsaSeries::min(self : CryptosigneddsaSeries) -> Double { @_common.min(self.vals) }

pub fn CryptosigneddsaSeries::max(self : CryptosigneddsaSeries) -> Double { @_common.max(self.vals) }

pub fn CryptosigneddsaSeries::range(self : CryptosigneddsaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn CryptosigneddsaSeries::variance(self : CryptosigneddsaSeries) -> Double { @_common.variance(self.vals) }

pub fn CryptosigneddsaSeries::std(self : CryptosigneddsaSeries) -> Double { @_common.std(self.vals) }

pub fn CryptosigneddsaSeries::median(self : CryptosigneddsaSeries) -> Double { @_common.median(self.vals) }

pub fn CryptosigneddsaSeries::scale(self : CryptosigneddsaSeries, f : Double) -> CryptosigneddsaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn CryptosigneddsaSeries::add(self : CryptosigneddsaSeries, other : CryptosigneddsaSeries) -> CryptosigneddsaSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn CryptosigneddsaSeries::sub(self : CryptosigneddsaSeries, other : CryptosigneddsaSeries) -> CryptosigneddsaSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn CryptosigneddsaSeries::normalize(self : CryptosigneddsaSeries) -> CryptosigneddsaSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn CryptosigneddsaSeries::cumsum(self : CryptosigneddsaSeries) -> CryptosigneddsaSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn CryptosigneddsaSeries::to_string(self : CryptosigneddsaSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosigneddsaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sign_eddsa_make_matrix(rows : Int, cols : Int, val : Double) -> CryptosigneddsaMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn crypto_sign_eddsa_matrix_identity(n : Int) -> CryptosigneddsaMatrix {
  let m = crypto_sign_eddsa_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn CryptosigneddsaMatrix::get(self : CryptosigneddsaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn CryptosigneddsaMatrix::transpose(self : CryptosigneddsaMatrix) -> CryptosigneddsaMatrix {
  let result = crypto_sign_eddsa_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn CryptosigneddsaMatrix::add(self : CryptosigneddsaMatrix, other : CryptosigneddsaMatrix) -> CryptosigneddsaMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_sign_eddsa_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn CryptosigneddsaMatrix::scale(self : CryptosigneddsaMatrix, s : Double) -> CryptosigneddsaMatrix {
  let result = crypto_sign_eddsa_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn CryptosigneddsaMatrix::multiply(self : CryptosigneddsaMatrix, other : CryptosigneddsaMatrix) -> CryptosigneddsaMatrix {
  if self.cols != other.rows { return crypto_sign_eddsa_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_sign_eddsa_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn CryptosigneddsaMatrix::trace(self : CryptosigneddsaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn CryptosigneddsaMatrix::det(self : CryptosigneddsaMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn CryptosigneddsaMatrix::norm(self : CryptosigneddsaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn CryptosigneddsaMatrix::to_string(self : CryptosigneddsaMatrix) -> String {
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

pub(all) struct CryptosigneddsaVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sign_eddsa_make_vector(comps : Array[Double]) -> CryptosigneddsaVector {
  { comps, dim: comps.length() }
}

pub fn crypto_sign_eddsa_vector_zero(dim : Int) -> CryptosigneddsaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn CryptosigneddsaVector::add(self : CryptosigneddsaVector, other : CryptosigneddsaVector) -> CryptosigneddsaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosigneddsaVector::sub(self : CryptosigneddsaVector, other : CryptosigneddsaVector) -> CryptosigneddsaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosigneddsaVector::scale(self : CryptosigneddsaVector, s : Double) -> CryptosigneddsaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn CryptosigneddsaVector::dot(self : CryptosigneddsaVector, other : CryptosigneddsaVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn CryptosigneddsaVector::norm(self : CryptosigneddsaVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn CryptosigneddsaVector::normalize(self : CryptosigneddsaVector) -> CryptosigneddsaVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosigneddsaVector::dist(self : CryptosigneddsaVector, other : CryptosigneddsaVector) -> Double {
  self.sub(other).norm()
}

pub fn CryptosigneddsaVector::to_string(self : CryptosigneddsaVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosigneddsaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_eddsa_frame_make(size : Int) -> CryptosigneddsaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosigneddsaFrame::len(self : CryptosigneddsaFrame) -> Int { self.size }

pub fn CryptosigneddsaFrame::get(self : CryptosigneddsaFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosigneddsaFrame::set(self : CryptosigneddsaFrame, i : Int, v : Double) -> CryptosigneddsaFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaFrame::sum(self : CryptosigneddsaFrame) -> Double { @_common.sum(self.data) }

pub fn CryptosigneddsaFrame::mean(self : CryptosigneddsaFrame) -> Double { @_common.mean(self.data) }

pub fn CryptosigneddsaFrame::scale(self : CryptosigneddsaFrame, f : Double) -> CryptosigneddsaFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaFrame::add(self : CryptosigneddsaFrame, other : CryptosigneddsaFrame) -> CryptosigneddsaFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosigneddsaFrame::copy(self : CryptosigneddsaFrame) -> CryptosigneddsaFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaFrame::fill(self : CryptosigneddsaFrame, v : Double) -> CryptosigneddsaFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaFrame::min(self : CryptosigneddsaFrame) -> Double { @_common.min(self.data) }

pub fn CryptosigneddsaFrame::max(self : CryptosigneddsaFrame) -> Double { @_common.max(self.data) }

pub fn CryptosigneddsaFrame::to_string(self : CryptosigneddsaFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosigneddsaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_eddsa_table_make(size : Int) -> CryptosigneddsaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosigneddsaTable::len(self : CryptosigneddsaTable) -> Int { self.size }

pub fn CryptosigneddsaTable::get(self : CryptosigneddsaTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosigneddsaTable::set(self : CryptosigneddsaTable, i : Int, v : Double) -> CryptosigneddsaTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaTable::sum(self : CryptosigneddsaTable) -> Double { @_common.sum(self.data) }

pub fn CryptosigneddsaTable::mean(self : CryptosigneddsaTable) -> Double { @_common.mean(self.data) }

pub fn CryptosigneddsaTable::scale(self : CryptosigneddsaTable, f : Double) -> CryptosigneddsaTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaTable::add(self : CryptosigneddsaTable, other : CryptosigneddsaTable) -> CryptosigneddsaTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosigneddsaTable::copy(self : CryptosigneddsaTable) -> CryptosigneddsaTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaTable::fill(self : CryptosigneddsaTable, v : Double) -> CryptosigneddsaTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaTable::min(self : CryptosigneddsaTable) -> Double { @_common.min(self.data) }

pub fn CryptosigneddsaTable::max(self : CryptosigneddsaTable) -> Double { @_common.max(self.data) }

pub fn CryptosigneddsaTable::to_string(self : CryptosigneddsaTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosigneddsaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_eddsa_graphn_make(size : Int) -> CryptosigneddsaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosigneddsaGraphN::len(self : CryptosigneddsaGraphN) -> Int { self.size }

pub fn CryptosigneddsaGraphN::get(self : CryptosigneddsaGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosigneddsaGraphN::set(self : CryptosigneddsaGraphN, i : Int, v : Double) -> CryptosigneddsaGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaGraphN::sum(self : CryptosigneddsaGraphN) -> Double { @_common.sum(self.data) }

pub fn CryptosigneddsaGraphN::mean(self : CryptosigneddsaGraphN) -> Double { @_common.mean(self.data) }

pub fn CryptosigneddsaGraphN::scale(self : CryptosigneddsaGraphN, f : Double) -> CryptosigneddsaGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaGraphN::add(self : CryptosigneddsaGraphN, other : CryptosigneddsaGraphN) -> CryptosigneddsaGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosigneddsaGraphN::copy(self : CryptosigneddsaGraphN) -> CryptosigneddsaGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaGraphN::fill(self : CryptosigneddsaGraphN, v : Double) -> CryptosigneddsaGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaGraphN::min(self : CryptosigneddsaGraphN) -> Double { @_common.min(self.data) }

pub fn CryptosigneddsaGraphN::max(self : CryptosigneddsaGraphN) -> Double { @_common.max(self.data) }

pub fn CryptosigneddsaGraphN::to_string(self : CryptosigneddsaGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosigneddsaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_eddsa_node_make(size : Int) -> CryptosigneddsaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosigneddsaNode::len(self : CryptosigneddsaNode) -> Int { self.size }

pub fn CryptosigneddsaNode::get(self : CryptosigneddsaNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosigneddsaNode::set(self : CryptosigneddsaNode, i : Int, v : Double) -> CryptosigneddsaNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaNode::sum(self : CryptosigneddsaNode) -> Double { @_common.sum(self.data) }

pub fn CryptosigneddsaNode::mean(self : CryptosigneddsaNode) -> Double { @_common.mean(self.data) }

pub fn CryptosigneddsaNode::scale(self : CryptosigneddsaNode, f : Double) -> CryptosigneddsaNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaNode::add(self : CryptosigneddsaNode, other : CryptosigneddsaNode) -> CryptosigneddsaNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosigneddsaNode::copy(self : CryptosigneddsaNode) -> CryptosigneddsaNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaNode::fill(self : CryptosigneddsaNode, v : Double) -> CryptosigneddsaNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaNode::min(self : CryptosigneddsaNode) -> Double { @_common.min(self.data) }

pub fn CryptosigneddsaNode::max(self : CryptosigneddsaNode) -> Double { @_common.max(self.data) }

pub fn CryptosigneddsaNode::to_string(self : CryptosigneddsaNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosigneddsaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_eddsa_edge_make(size : Int) -> CryptosigneddsaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosigneddsaEdge::len(self : CryptosigneddsaEdge) -> Int { self.size }

pub fn CryptosigneddsaEdge::get(self : CryptosigneddsaEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosigneddsaEdge::set(self : CryptosigneddsaEdge, i : Int, v : Double) -> CryptosigneddsaEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaEdge::sum(self : CryptosigneddsaEdge) -> Double { @_common.sum(self.data) }

pub fn CryptosigneddsaEdge::mean(self : CryptosigneddsaEdge) -> Double { @_common.mean(self.data) }

pub fn CryptosigneddsaEdge::scale(self : CryptosigneddsaEdge, f : Double) -> CryptosigneddsaEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaEdge::add(self : CryptosigneddsaEdge, other : CryptosigneddsaEdge) -> CryptosigneddsaEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosigneddsaEdge::copy(self : CryptosigneddsaEdge) -> CryptosigneddsaEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaEdge::fill(self : CryptosigneddsaEdge, v : Double) -> CryptosigneddsaEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaEdge::min(self : CryptosigneddsaEdge) -> Double { @_common.min(self.data) }

pub fn CryptosigneddsaEdge::max(self : CryptosigneddsaEdge) -> Double { @_common.max(self.data) }

pub fn CryptosigneddsaEdge::to_string(self : CryptosigneddsaEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosigneddsaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_eddsa_path_make(size : Int) -> CryptosigneddsaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosigneddsaPath::len(self : CryptosigneddsaPath) -> Int { self.size }

pub fn CryptosigneddsaPath::get(self : CryptosigneddsaPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosigneddsaPath::set(self : CryptosigneddsaPath, i : Int, v : Double) -> CryptosigneddsaPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaPath::sum(self : CryptosigneddsaPath) -> Double { @_common.sum(self.data) }

pub fn CryptosigneddsaPath::mean(self : CryptosigneddsaPath) -> Double { @_common.mean(self.data) }

pub fn CryptosigneddsaPath::scale(self : CryptosigneddsaPath, f : Double) -> CryptosigneddsaPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaPath::add(self : CryptosigneddsaPath, other : CryptosigneddsaPath) -> CryptosigneddsaPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosigneddsaPath::copy(self : CryptosigneddsaPath) -> CryptosigneddsaPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaPath::fill(self : CryptosigneddsaPath, v : Double) -> CryptosigneddsaPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaPath::min(self : CryptosigneddsaPath) -> Double { @_common.min(self.data) }

pub fn CryptosigneddsaPath::max(self : CryptosigneddsaPath) -> Double { @_common.max(self.data) }

pub fn CryptosigneddsaPath::to_string(self : CryptosigneddsaPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosigneddsaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_eddsa_cluster_make(size : Int) -> CryptosigneddsaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosigneddsaCluster::len(self : CryptosigneddsaCluster) -> Int { self.size }

pub fn CryptosigneddsaCluster::get(self : CryptosigneddsaCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosigneddsaCluster::set(self : CryptosigneddsaCluster, i : Int, v : Double) -> CryptosigneddsaCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaCluster::sum(self : CryptosigneddsaCluster) -> Double { @_common.sum(self.data) }

pub fn CryptosigneddsaCluster::mean(self : CryptosigneddsaCluster) -> Double { @_common.mean(self.data) }

pub fn CryptosigneddsaCluster::scale(self : CryptosigneddsaCluster, f : Double) -> CryptosigneddsaCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaCluster::add(self : CryptosigneddsaCluster, other : CryptosigneddsaCluster) -> CryptosigneddsaCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosigneddsaCluster::copy(self : CryptosigneddsaCluster) -> CryptosigneddsaCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaCluster::fill(self : CryptosigneddsaCluster, v : Double) -> CryptosigneddsaCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaCluster::min(self : CryptosigneddsaCluster) -> Double { @_common.min(self.data) }

pub fn CryptosigneddsaCluster::max(self : CryptosigneddsaCluster) -> Double { @_common.max(self.data) }

pub fn CryptosigneddsaCluster::to_string(self : CryptosigneddsaCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosigneddsaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_eddsa_model_make(size : Int) -> CryptosigneddsaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosigneddsaModel::len(self : CryptosigneddsaModel) -> Int { self.size }

pub fn CryptosigneddsaModel::get(self : CryptosigneddsaModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosigneddsaModel::set(self : CryptosigneddsaModel, i : Int, v : Double) -> CryptosigneddsaModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaModel::sum(self : CryptosigneddsaModel) -> Double { @_common.sum(self.data) }

pub fn CryptosigneddsaModel::mean(self : CryptosigneddsaModel) -> Double { @_common.mean(self.data) }

pub fn CryptosigneddsaModel::scale(self : CryptosigneddsaModel, f : Double) -> CryptosigneddsaModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaModel::add(self : CryptosigneddsaModel, other : CryptosigneddsaModel) -> CryptosigneddsaModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosigneddsaModel::copy(self : CryptosigneddsaModel) -> CryptosigneddsaModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaModel::fill(self : CryptosigneddsaModel, v : Double) -> CryptosigneddsaModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaModel::min(self : CryptosigneddsaModel) -> Double { @_common.min(self.data) }

pub fn CryptosigneddsaModel::max(self : CryptosigneddsaModel) -> Double { @_common.max(self.data) }

pub fn CryptosigneddsaModel::to_string(self : CryptosigneddsaModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosigneddsaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_eddsa_layer_make(size : Int) -> CryptosigneddsaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosigneddsaLayer::len(self : CryptosigneddsaLayer) -> Int { self.size }

pub fn CryptosigneddsaLayer::get(self : CryptosigneddsaLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosigneddsaLayer::set(self : CryptosigneddsaLayer, i : Int, v : Double) -> CryptosigneddsaLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaLayer::sum(self : CryptosigneddsaLayer) -> Double { @_common.sum(self.data) }

pub fn CryptosigneddsaLayer::mean(self : CryptosigneddsaLayer) -> Double { @_common.mean(self.data) }

pub fn CryptosigneddsaLayer::scale(self : CryptosigneddsaLayer, f : Double) -> CryptosigneddsaLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaLayer::add(self : CryptosigneddsaLayer, other : CryptosigneddsaLayer) -> CryptosigneddsaLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosigneddsaLayer::copy(self : CryptosigneddsaLayer) -> CryptosigneddsaLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaLayer::fill(self : CryptosigneddsaLayer, v : Double) -> CryptosigneddsaLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaLayer::min(self : CryptosigneddsaLayer) -> Double { @_common.min(self.data) }

pub fn CryptosigneddsaLayer::max(self : CryptosigneddsaLayer) -> Double { @_common.max(self.data) }

pub fn CryptosigneddsaLayer::to_string(self : CryptosigneddsaLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosigneddsaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_eddsa_buffer_make(size : Int) -> CryptosigneddsaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosigneddsaBuffer::len(self : CryptosigneddsaBuffer) -> Int { self.size }

pub fn CryptosigneddsaBuffer::get(self : CryptosigneddsaBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosigneddsaBuffer::set(self : CryptosigneddsaBuffer, i : Int, v : Double) -> CryptosigneddsaBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaBuffer::sum(self : CryptosigneddsaBuffer) -> Double { @_common.sum(self.data) }

pub fn CryptosigneddsaBuffer::mean(self : CryptosigneddsaBuffer) -> Double { @_common.mean(self.data) }

pub fn CryptosigneddsaBuffer::scale(self : CryptosigneddsaBuffer, f : Double) -> CryptosigneddsaBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaBuffer::add(self : CryptosigneddsaBuffer, other : CryptosigneddsaBuffer) -> CryptosigneddsaBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosigneddsaBuffer::copy(self : CryptosigneddsaBuffer) -> CryptosigneddsaBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaBuffer::fill(self : CryptosigneddsaBuffer, v : Double) -> CryptosigneddsaBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaBuffer::min(self : CryptosigneddsaBuffer) -> Double { @_common.min(self.data) }

pub fn CryptosigneddsaBuffer::max(self : CryptosigneddsaBuffer) -> Double { @_common.max(self.data) }

pub fn CryptosigneddsaBuffer::to_string(self : CryptosigneddsaBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosigneddsaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_eddsa_cursor_make(size : Int) -> CryptosigneddsaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosigneddsaCursor::len(self : CryptosigneddsaCursor) -> Int { self.size }

pub fn CryptosigneddsaCursor::get(self : CryptosigneddsaCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosigneddsaCursor::set(self : CryptosigneddsaCursor, i : Int, v : Double) -> CryptosigneddsaCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaCursor::sum(self : CryptosigneddsaCursor) -> Double { @_common.sum(self.data) }

pub fn CryptosigneddsaCursor::mean(self : CryptosigneddsaCursor) -> Double { @_common.mean(self.data) }

pub fn CryptosigneddsaCursor::scale(self : CryptosigneddsaCursor, f : Double) -> CryptosigneddsaCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaCursor::add(self : CryptosigneddsaCursor, other : CryptosigneddsaCursor) -> CryptosigneddsaCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosigneddsaCursor::copy(self : CryptosigneddsaCursor) -> CryptosigneddsaCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaCursor::fill(self : CryptosigneddsaCursor, v : Double) -> CryptosigneddsaCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaCursor::min(self : CryptosigneddsaCursor) -> Double { @_common.min(self.data) }

pub fn CryptosigneddsaCursor::max(self : CryptosigneddsaCursor) -> Double { @_common.max(self.data) }

pub fn CryptosigneddsaCursor::to_string(self : CryptosigneddsaCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosigneddsaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_eddsa_view_make(size : Int) -> CryptosigneddsaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosigneddsaView::len(self : CryptosigneddsaView) -> Int { self.size }

pub fn CryptosigneddsaView::get(self : CryptosigneddsaView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosigneddsaView::set(self : CryptosigneddsaView, i : Int, v : Double) -> CryptosigneddsaView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaView::sum(self : CryptosigneddsaView) -> Double { @_common.sum(self.data) }

pub fn CryptosigneddsaView::mean(self : CryptosigneddsaView) -> Double { @_common.mean(self.data) }

pub fn CryptosigneddsaView::scale(self : CryptosigneddsaView, f : Double) -> CryptosigneddsaView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaView::add(self : CryptosigneddsaView, other : CryptosigneddsaView) -> CryptosigneddsaView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosigneddsaView::copy(self : CryptosigneddsaView) -> CryptosigneddsaView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaView::fill(self : CryptosigneddsaView, v : Double) -> CryptosigneddsaView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaView::min(self : CryptosigneddsaView) -> Double { @_common.min(self.data) }

pub fn CryptosigneddsaView::max(self : CryptosigneddsaView) -> Double { @_common.max(self.data) }

pub fn CryptosigneddsaView::to_string(self : CryptosigneddsaView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosigneddsaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_eddsa_range_make(size : Int) -> CryptosigneddsaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosigneddsaRange::len(self : CryptosigneddsaRange) -> Int { self.size }

pub fn CryptosigneddsaRange::get(self : CryptosigneddsaRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosigneddsaRange::set(self : CryptosigneddsaRange, i : Int, v : Double) -> CryptosigneddsaRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaRange::sum(self : CryptosigneddsaRange) -> Double { @_common.sum(self.data) }

pub fn CryptosigneddsaRange::mean(self : CryptosigneddsaRange) -> Double { @_common.mean(self.data) }

pub fn CryptosigneddsaRange::scale(self : CryptosigneddsaRange, f : Double) -> CryptosigneddsaRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaRange::add(self : CryptosigneddsaRange, other : CryptosigneddsaRange) -> CryptosigneddsaRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosigneddsaRange::copy(self : CryptosigneddsaRange) -> CryptosigneddsaRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaRange::fill(self : CryptosigneddsaRange, v : Double) -> CryptosigneddsaRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaRange::min(self : CryptosigneddsaRange) -> Double { @_common.min(self.data) }

pub fn CryptosigneddsaRange::max(self : CryptosigneddsaRange) -> Double { @_common.max(self.data) }

pub fn CryptosigneddsaRange::to_string(self : CryptosigneddsaRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosigneddsaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_eddsa_slice_make(size : Int) -> CryptosigneddsaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosigneddsaSlice::len(self : CryptosigneddsaSlice) -> Int { self.size }

pub fn CryptosigneddsaSlice::get(self : CryptosigneddsaSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosigneddsaSlice::set(self : CryptosigneddsaSlice, i : Int, v : Double) -> CryptosigneddsaSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaSlice::sum(self : CryptosigneddsaSlice) -> Double { @_common.sum(self.data) }

pub fn CryptosigneddsaSlice::mean(self : CryptosigneddsaSlice) -> Double { @_common.mean(self.data) }

pub fn CryptosigneddsaSlice::scale(self : CryptosigneddsaSlice, f : Double) -> CryptosigneddsaSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaSlice::add(self : CryptosigneddsaSlice, other : CryptosigneddsaSlice) -> CryptosigneddsaSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosigneddsaSlice::copy(self : CryptosigneddsaSlice) -> CryptosigneddsaSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaSlice::fill(self : CryptosigneddsaSlice, v : Double) -> CryptosigneddsaSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosigneddsaSlice::min(self : CryptosigneddsaSlice) -> Double { @_common.min(self.data) }

pub fn CryptosigneddsaSlice::max(self : CryptosigneddsaSlice) -> Double { @_common.max(self.data) }

pub fn CryptosigneddsaSlice::to_string(self : CryptosigneddsaSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

