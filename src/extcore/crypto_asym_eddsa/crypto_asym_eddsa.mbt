///===
/// extcore/crypto_asym_eddsa

pub(all) struct CryptoasymeddsaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_asym_eddsa_make_point(x : Double, y : Double) -> CryptoasymeddsaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_asym_eddsa_make_point3(x : Double, y : Double, z : Double) -> CryptoasymeddsaPoint {
  { x, y, z, label: 0 }
}

pub fn CryptoasymeddsaPoint::x(self : CryptoasymeddsaPoint) -> Double { self.x }

pub fn CryptoasymeddsaPoint::y(self : CryptoasymeddsaPoint) -> Double { self.y }

pub fn CryptoasymeddsaPoint::z(self : CryptoasymeddsaPoint) -> Double { self.z }

pub fn CryptoasymeddsaPoint::label(self : CryptoasymeddsaPoint) -> Int { self.label }

pub fn CryptoasymeddsaPoint::dist(self : CryptoasymeddsaPoint, other : CryptoasymeddsaPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn CryptoasymeddsaPoint::add(self : CryptoasymeddsaPoint, other : CryptoasymeddsaPoint) -> CryptoasymeddsaPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn CryptoasymeddsaPoint::sub(self : CryptoasymeddsaPoint, other : CryptoasymeddsaPoint) -> CryptoasymeddsaPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn CryptoasymeddsaPoint::scale(self : CryptoasymeddsaPoint, s : Double) -> CryptoasymeddsaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn CryptoasymeddsaPoint::dot(self : CryptoasymeddsaPoint, other : CryptoasymeddsaPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn CryptoasymeddsaPoint::cross(self : CryptoasymeddsaPoint, other : CryptoasymeddsaPoint) -> CryptoasymeddsaPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn CryptoasymeddsaPoint::norm(self : CryptoasymeddsaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn CryptoasymeddsaPoint::normalize(self : CryptoasymeddsaPoint) -> CryptoasymeddsaPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptoasymeddsaPoint::negate(self : CryptoasymeddsaPoint) -> CryptoasymeddsaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn CryptoasymeddsaPoint::mid(self : CryptoasymeddsaPoint, other : CryptoasymeddsaPoint) -> CryptoasymeddsaPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn CryptoasymeddsaPoint::lerp(self : CryptoasymeddsaPoint, other : CryptoasymeddsaPoint, t : Double) -> CryptoasymeddsaPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn CryptoasymeddsaPoint::to_string(self : CryptoasymeddsaPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct CryptoasymeddsaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_asym_eddsa_make_series(vals : Array[Double], name : String) -> CryptoasymeddsaSeries {
  { vals, name, meta: 0 }
}

pub fn CryptoasymeddsaSeries::len(self : CryptoasymeddsaSeries) -> Int { self.vals.length() }

pub fn CryptoasymeddsaSeries::sum(self : CryptoasymeddsaSeries) -> Double { @_common.sum(self.vals) }

pub fn CryptoasymeddsaSeries::mean(self : CryptoasymeddsaSeries) -> Double { @_common.mean(self.vals) }

pub fn CryptoasymeddsaSeries::min(self : CryptoasymeddsaSeries) -> Double { @_common.min(self.vals) }

pub fn CryptoasymeddsaSeries::max(self : CryptoasymeddsaSeries) -> Double { @_common.max(self.vals) }

pub fn CryptoasymeddsaSeries::range(self : CryptoasymeddsaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn CryptoasymeddsaSeries::variance(self : CryptoasymeddsaSeries) -> Double { @_common.variance(self.vals) }

pub fn CryptoasymeddsaSeries::std(self : CryptoasymeddsaSeries) -> Double { @_common.std(self.vals) }

pub fn CryptoasymeddsaSeries::median(self : CryptoasymeddsaSeries) -> Double { @_common.median(self.vals) }

pub fn CryptoasymeddsaSeries::scale(self : CryptoasymeddsaSeries, f : Double) -> CryptoasymeddsaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn CryptoasymeddsaSeries::add(self : CryptoasymeddsaSeries, other : CryptoasymeddsaSeries) -> CryptoasymeddsaSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn CryptoasymeddsaSeries::sub(self : CryptoasymeddsaSeries, other : CryptoasymeddsaSeries) -> CryptoasymeddsaSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn CryptoasymeddsaSeries::normalize(self : CryptoasymeddsaSeries) -> CryptoasymeddsaSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn CryptoasymeddsaSeries::cumsum(self : CryptoasymeddsaSeries) -> CryptoasymeddsaSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn CryptoasymeddsaSeries::to_string(self : CryptoasymeddsaSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptoasymeddsaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_asym_eddsa_make_matrix(rows : Int, cols : Int, val : Double) -> CryptoasymeddsaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_asym_eddsa_matrix_identity(n : Int) -> CryptoasymeddsaMatrix {
  let m = crypto_asym_eddsa_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn CryptoasymeddsaMatrix::get(self : CryptoasymeddsaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn CryptoasymeddsaMatrix::transpose(self : CryptoasymeddsaMatrix) -> CryptoasymeddsaMatrix {
  let result = crypto_asym_eddsa_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn CryptoasymeddsaMatrix::add(self : CryptoasymeddsaMatrix, other : CryptoasymeddsaMatrix) -> CryptoasymeddsaMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_asym_eddsa_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn CryptoasymeddsaMatrix::scale(self : CryptoasymeddsaMatrix, s : Double) -> CryptoasymeddsaMatrix {
  let result = crypto_asym_eddsa_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn CryptoasymeddsaMatrix::multiply(self : CryptoasymeddsaMatrix, other : CryptoasymeddsaMatrix) -> CryptoasymeddsaMatrix {
  if self.cols != other.rows { return crypto_asym_eddsa_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_asym_eddsa_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn CryptoasymeddsaMatrix::trace(self : CryptoasymeddsaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn CryptoasymeddsaMatrix::det(self : CryptoasymeddsaMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn CryptoasymeddsaMatrix::norm(self : CryptoasymeddsaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn CryptoasymeddsaMatrix::to_string(self : CryptoasymeddsaMatrix) -> String {
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

pub(all) struct CryptoasymeddsaVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_asym_eddsa_make_vector(comps : Array[Double]) -> CryptoasymeddsaVector {
  { comps, dim: comps.length() }
}

pub fn crypto_asym_eddsa_vector_zero(dim : Int) -> CryptoasymeddsaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn CryptoasymeddsaVector::add(self : CryptoasymeddsaVector, other : CryptoasymeddsaVector) -> CryptoasymeddsaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn CryptoasymeddsaVector::sub(self : CryptoasymeddsaVector, other : CryptoasymeddsaVector) -> CryptoasymeddsaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn CryptoasymeddsaVector::scale(self : CryptoasymeddsaVector, s : Double) -> CryptoasymeddsaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn CryptoasymeddsaVector::dot(self : CryptoasymeddsaVector, other : CryptoasymeddsaVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn CryptoasymeddsaVector::norm(self : CryptoasymeddsaVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn CryptoasymeddsaVector::normalize(self : CryptoasymeddsaVector) -> CryptoasymeddsaVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptoasymeddsaVector::dist(self : CryptoasymeddsaVector, other : CryptoasymeddsaVector) -> Double {
  self.sub(other).norm()
}

pub fn CryptoasymeddsaVector::to_string(self : CryptoasymeddsaVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptoasymeddsaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_eddsa_frame_make(size : Int) -> CryptoasymeddsaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymeddsaFrame::len(self : CryptoasymeddsaFrame) -> Int { self.size }

pub fn CryptoasymeddsaFrame::get(self : CryptoasymeddsaFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymeddsaFrame::set(self : CryptoasymeddsaFrame, i : Int, v : Double) -> CryptoasymeddsaFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaFrame::sum(self : CryptoasymeddsaFrame) -> Double { @_common.sum(self.data) }

pub fn CryptoasymeddsaFrame::mean(self : CryptoasymeddsaFrame) -> Double { @_common.mean(self.data) }

pub fn CryptoasymeddsaFrame::scale(self : CryptoasymeddsaFrame, f : Double) -> CryptoasymeddsaFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaFrame::add(self : CryptoasymeddsaFrame, other : CryptoasymeddsaFrame) -> CryptoasymeddsaFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymeddsaFrame::copy(self : CryptoasymeddsaFrame) -> CryptoasymeddsaFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaFrame::fill(self : CryptoasymeddsaFrame, v : Double) -> CryptoasymeddsaFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaFrame::min(self : CryptoasymeddsaFrame) -> Double { @_common.min(self.data) }

pub fn CryptoasymeddsaFrame::max(self : CryptoasymeddsaFrame) -> Double { @_common.max(self.data) }

pub fn CryptoasymeddsaFrame::to_string(self : CryptoasymeddsaFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymeddsaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_eddsa_table_make(size : Int) -> CryptoasymeddsaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymeddsaTable::len(self : CryptoasymeddsaTable) -> Int { self.size }

pub fn CryptoasymeddsaTable::get(self : CryptoasymeddsaTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymeddsaTable::set(self : CryptoasymeddsaTable, i : Int, v : Double) -> CryptoasymeddsaTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaTable::sum(self : CryptoasymeddsaTable) -> Double { @_common.sum(self.data) }

pub fn CryptoasymeddsaTable::mean(self : CryptoasymeddsaTable) -> Double { @_common.mean(self.data) }

pub fn CryptoasymeddsaTable::scale(self : CryptoasymeddsaTable, f : Double) -> CryptoasymeddsaTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaTable::add(self : CryptoasymeddsaTable, other : CryptoasymeddsaTable) -> CryptoasymeddsaTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymeddsaTable::copy(self : CryptoasymeddsaTable) -> CryptoasymeddsaTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaTable::fill(self : CryptoasymeddsaTable, v : Double) -> CryptoasymeddsaTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaTable::min(self : CryptoasymeddsaTable) -> Double { @_common.min(self.data) }

pub fn CryptoasymeddsaTable::max(self : CryptoasymeddsaTable) -> Double { @_common.max(self.data) }

pub fn CryptoasymeddsaTable::to_string(self : CryptoasymeddsaTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymeddsaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_eddsa_graphn_make(size : Int) -> CryptoasymeddsaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymeddsaGraphN::len(self : CryptoasymeddsaGraphN) -> Int { self.size }

pub fn CryptoasymeddsaGraphN::get(self : CryptoasymeddsaGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymeddsaGraphN::set(self : CryptoasymeddsaGraphN, i : Int, v : Double) -> CryptoasymeddsaGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaGraphN::sum(self : CryptoasymeddsaGraphN) -> Double { @_common.sum(self.data) }

pub fn CryptoasymeddsaGraphN::mean(self : CryptoasymeddsaGraphN) -> Double { @_common.mean(self.data) }

pub fn CryptoasymeddsaGraphN::scale(self : CryptoasymeddsaGraphN, f : Double) -> CryptoasymeddsaGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaGraphN::add(self : CryptoasymeddsaGraphN, other : CryptoasymeddsaGraphN) -> CryptoasymeddsaGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymeddsaGraphN::copy(self : CryptoasymeddsaGraphN) -> CryptoasymeddsaGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaGraphN::fill(self : CryptoasymeddsaGraphN, v : Double) -> CryptoasymeddsaGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaGraphN::min(self : CryptoasymeddsaGraphN) -> Double { @_common.min(self.data) }

pub fn CryptoasymeddsaGraphN::max(self : CryptoasymeddsaGraphN) -> Double { @_common.max(self.data) }

pub fn CryptoasymeddsaGraphN::to_string(self : CryptoasymeddsaGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymeddsaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_eddsa_node_make(size : Int) -> CryptoasymeddsaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymeddsaNode::len(self : CryptoasymeddsaNode) -> Int { self.size }

pub fn CryptoasymeddsaNode::get(self : CryptoasymeddsaNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymeddsaNode::set(self : CryptoasymeddsaNode, i : Int, v : Double) -> CryptoasymeddsaNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaNode::sum(self : CryptoasymeddsaNode) -> Double { @_common.sum(self.data) }

pub fn CryptoasymeddsaNode::mean(self : CryptoasymeddsaNode) -> Double { @_common.mean(self.data) }

pub fn CryptoasymeddsaNode::scale(self : CryptoasymeddsaNode, f : Double) -> CryptoasymeddsaNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaNode::add(self : CryptoasymeddsaNode, other : CryptoasymeddsaNode) -> CryptoasymeddsaNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymeddsaNode::copy(self : CryptoasymeddsaNode) -> CryptoasymeddsaNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaNode::fill(self : CryptoasymeddsaNode, v : Double) -> CryptoasymeddsaNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaNode::min(self : CryptoasymeddsaNode) -> Double { @_common.min(self.data) }

pub fn CryptoasymeddsaNode::max(self : CryptoasymeddsaNode) -> Double { @_common.max(self.data) }

pub fn CryptoasymeddsaNode::to_string(self : CryptoasymeddsaNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymeddsaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_eddsa_edge_make(size : Int) -> CryptoasymeddsaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymeddsaEdge::len(self : CryptoasymeddsaEdge) -> Int { self.size }

pub fn CryptoasymeddsaEdge::get(self : CryptoasymeddsaEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymeddsaEdge::set(self : CryptoasymeddsaEdge, i : Int, v : Double) -> CryptoasymeddsaEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaEdge::sum(self : CryptoasymeddsaEdge) -> Double { @_common.sum(self.data) }

pub fn CryptoasymeddsaEdge::mean(self : CryptoasymeddsaEdge) -> Double { @_common.mean(self.data) }

pub fn CryptoasymeddsaEdge::scale(self : CryptoasymeddsaEdge, f : Double) -> CryptoasymeddsaEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaEdge::add(self : CryptoasymeddsaEdge, other : CryptoasymeddsaEdge) -> CryptoasymeddsaEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymeddsaEdge::copy(self : CryptoasymeddsaEdge) -> CryptoasymeddsaEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaEdge::fill(self : CryptoasymeddsaEdge, v : Double) -> CryptoasymeddsaEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaEdge::min(self : CryptoasymeddsaEdge) -> Double { @_common.min(self.data) }

pub fn CryptoasymeddsaEdge::max(self : CryptoasymeddsaEdge) -> Double { @_common.max(self.data) }

pub fn CryptoasymeddsaEdge::to_string(self : CryptoasymeddsaEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymeddsaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_eddsa_path_make(size : Int) -> CryptoasymeddsaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymeddsaPath::len(self : CryptoasymeddsaPath) -> Int { self.size }

pub fn CryptoasymeddsaPath::get(self : CryptoasymeddsaPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymeddsaPath::set(self : CryptoasymeddsaPath, i : Int, v : Double) -> CryptoasymeddsaPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaPath::sum(self : CryptoasymeddsaPath) -> Double { @_common.sum(self.data) }

pub fn CryptoasymeddsaPath::mean(self : CryptoasymeddsaPath) -> Double { @_common.mean(self.data) }

pub fn CryptoasymeddsaPath::scale(self : CryptoasymeddsaPath, f : Double) -> CryptoasymeddsaPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaPath::add(self : CryptoasymeddsaPath, other : CryptoasymeddsaPath) -> CryptoasymeddsaPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymeddsaPath::copy(self : CryptoasymeddsaPath) -> CryptoasymeddsaPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaPath::fill(self : CryptoasymeddsaPath, v : Double) -> CryptoasymeddsaPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaPath::min(self : CryptoasymeddsaPath) -> Double { @_common.min(self.data) }

pub fn CryptoasymeddsaPath::max(self : CryptoasymeddsaPath) -> Double { @_common.max(self.data) }

pub fn CryptoasymeddsaPath::to_string(self : CryptoasymeddsaPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymeddsaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_eddsa_cluster_make(size : Int) -> CryptoasymeddsaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymeddsaCluster::len(self : CryptoasymeddsaCluster) -> Int { self.size }

pub fn CryptoasymeddsaCluster::get(self : CryptoasymeddsaCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymeddsaCluster::set(self : CryptoasymeddsaCluster, i : Int, v : Double) -> CryptoasymeddsaCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaCluster::sum(self : CryptoasymeddsaCluster) -> Double { @_common.sum(self.data) }

pub fn CryptoasymeddsaCluster::mean(self : CryptoasymeddsaCluster) -> Double { @_common.mean(self.data) }

pub fn CryptoasymeddsaCluster::scale(self : CryptoasymeddsaCluster, f : Double) -> CryptoasymeddsaCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaCluster::add(self : CryptoasymeddsaCluster, other : CryptoasymeddsaCluster) -> CryptoasymeddsaCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymeddsaCluster::copy(self : CryptoasymeddsaCluster) -> CryptoasymeddsaCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaCluster::fill(self : CryptoasymeddsaCluster, v : Double) -> CryptoasymeddsaCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaCluster::min(self : CryptoasymeddsaCluster) -> Double { @_common.min(self.data) }

pub fn CryptoasymeddsaCluster::max(self : CryptoasymeddsaCluster) -> Double { @_common.max(self.data) }

pub fn CryptoasymeddsaCluster::to_string(self : CryptoasymeddsaCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymeddsaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_eddsa_model_make(size : Int) -> CryptoasymeddsaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymeddsaModel::len(self : CryptoasymeddsaModel) -> Int { self.size }

pub fn CryptoasymeddsaModel::get(self : CryptoasymeddsaModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymeddsaModel::set(self : CryptoasymeddsaModel, i : Int, v : Double) -> CryptoasymeddsaModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaModel::sum(self : CryptoasymeddsaModel) -> Double { @_common.sum(self.data) }

pub fn CryptoasymeddsaModel::mean(self : CryptoasymeddsaModel) -> Double { @_common.mean(self.data) }

pub fn CryptoasymeddsaModel::scale(self : CryptoasymeddsaModel, f : Double) -> CryptoasymeddsaModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaModel::add(self : CryptoasymeddsaModel, other : CryptoasymeddsaModel) -> CryptoasymeddsaModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymeddsaModel::copy(self : CryptoasymeddsaModel) -> CryptoasymeddsaModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaModel::fill(self : CryptoasymeddsaModel, v : Double) -> CryptoasymeddsaModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaModel::min(self : CryptoasymeddsaModel) -> Double { @_common.min(self.data) }

pub fn CryptoasymeddsaModel::max(self : CryptoasymeddsaModel) -> Double { @_common.max(self.data) }

pub fn CryptoasymeddsaModel::to_string(self : CryptoasymeddsaModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymeddsaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_eddsa_layer_make(size : Int) -> CryptoasymeddsaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymeddsaLayer::len(self : CryptoasymeddsaLayer) -> Int { self.size }

pub fn CryptoasymeddsaLayer::get(self : CryptoasymeddsaLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymeddsaLayer::set(self : CryptoasymeddsaLayer, i : Int, v : Double) -> CryptoasymeddsaLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaLayer::sum(self : CryptoasymeddsaLayer) -> Double { @_common.sum(self.data) }

pub fn CryptoasymeddsaLayer::mean(self : CryptoasymeddsaLayer) -> Double { @_common.mean(self.data) }

pub fn CryptoasymeddsaLayer::scale(self : CryptoasymeddsaLayer, f : Double) -> CryptoasymeddsaLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaLayer::add(self : CryptoasymeddsaLayer, other : CryptoasymeddsaLayer) -> CryptoasymeddsaLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymeddsaLayer::copy(self : CryptoasymeddsaLayer) -> CryptoasymeddsaLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaLayer::fill(self : CryptoasymeddsaLayer, v : Double) -> CryptoasymeddsaLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaLayer::min(self : CryptoasymeddsaLayer) -> Double { @_common.min(self.data) }

pub fn CryptoasymeddsaLayer::max(self : CryptoasymeddsaLayer) -> Double { @_common.max(self.data) }

pub fn CryptoasymeddsaLayer::to_string(self : CryptoasymeddsaLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymeddsaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_eddsa_buffer_make(size : Int) -> CryptoasymeddsaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymeddsaBuffer::len(self : CryptoasymeddsaBuffer) -> Int { self.size }

pub fn CryptoasymeddsaBuffer::get(self : CryptoasymeddsaBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymeddsaBuffer::set(self : CryptoasymeddsaBuffer, i : Int, v : Double) -> CryptoasymeddsaBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaBuffer::sum(self : CryptoasymeddsaBuffer) -> Double { @_common.sum(self.data) }

pub fn CryptoasymeddsaBuffer::mean(self : CryptoasymeddsaBuffer) -> Double { @_common.mean(self.data) }

pub fn CryptoasymeddsaBuffer::scale(self : CryptoasymeddsaBuffer, f : Double) -> CryptoasymeddsaBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaBuffer::add(self : CryptoasymeddsaBuffer, other : CryptoasymeddsaBuffer) -> CryptoasymeddsaBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymeddsaBuffer::copy(self : CryptoasymeddsaBuffer) -> CryptoasymeddsaBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaBuffer::fill(self : CryptoasymeddsaBuffer, v : Double) -> CryptoasymeddsaBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaBuffer::min(self : CryptoasymeddsaBuffer) -> Double { @_common.min(self.data) }

pub fn CryptoasymeddsaBuffer::max(self : CryptoasymeddsaBuffer) -> Double { @_common.max(self.data) }

pub fn CryptoasymeddsaBuffer::to_string(self : CryptoasymeddsaBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymeddsaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_eddsa_cursor_make(size : Int) -> CryptoasymeddsaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymeddsaCursor::len(self : CryptoasymeddsaCursor) -> Int { self.size }

pub fn CryptoasymeddsaCursor::get(self : CryptoasymeddsaCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymeddsaCursor::set(self : CryptoasymeddsaCursor, i : Int, v : Double) -> CryptoasymeddsaCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaCursor::sum(self : CryptoasymeddsaCursor) -> Double { @_common.sum(self.data) }

pub fn CryptoasymeddsaCursor::mean(self : CryptoasymeddsaCursor) -> Double { @_common.mean(self.data) }

pub fn CryptoasymeddsaCursor::scale(self : CryptoasymeddsaCursor, f : Double) -> CryptoasymeddsaCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaCursor::add(self : CryptoasymeddsaCursor, other : CryptoasymeddsaCursor) -> CryptoasymeddsaCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymeddsaCursor::copy(self : CryptoasymeddsaCursor) -> CryptoasymeddsaCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaCursor::fill(self : CryptoasymeddsaCursor, v : Double) -> CryptoasymeddsaCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaCursor::min(self : CryptoasymeddsaCursor) -> Double { @_common.min(self.data) }

pub fn CryptoasymeddsaCursor::max(self : CryptoasymeddsaCursor) -> Double { @_common.max(self.data) }

pub fn CryptoasymeddsaCursor::to_string(self : CryptoasymeddsaCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymeddsaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_eddsa_view_make(size : Int) -> CryptoasymeddsaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymeddsaView::len(self : CryptoasymeddsaView) -> Int { self.size }

pub fn CryptoasymeddsaView::get(self : CryptoasymeddsaView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymeddsaView::set(self : CryptoasymeddsaView, i : Int, v : Double) -> CryptoasymeddsaView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaView::sum(self : CryptoasymeddsaView) -> Double { @_common.sum(self.data) }

pub fn CryptoasymeddsaView::mean(self : CryptoasymeddsaView) -> Double { @_common.mean(self.data) }

pub fn CryptoasymeddsaView::scale(self : CryptoasymeddsaView, f : Double) -> CryptoasymeddsaView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaView::add(self : CryptoasymeddsaView, other : CryptoasymeddsaView) -> CryptoasymeddsaView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymeddsaView::copy(self : CryptoasymeddsaView) -> CryptoasymeddsaView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaView::fill(self : CryptoasymeddsaView, v : Double) -> CryptoasymeddsaView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaView::min(self : CryptoasymeddsaView) -> Double { @_common.min(self.data) }

pub fn CryptoasymeddsaView::max(self : CryptoasymeddsaView) -> Double { @_common.max(self.data) }

pub fn CryptoasymeddsaView::to_string(self : CryptoasymeddsaView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymeddsaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_eddsa_range_make(size : Int) -> CryptoasymeddsaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymeddsaRange::len(self : CryptoasymeddsaRange) -> Int { self.size }

pub fn CryptoasymeddsaRange::get(self : CryptoasymeddsaRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymeddsaRange::set(self : CryptoasymeddsaRange, i : Int, v : Double) -> CryptoasymeddsaRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaRange::sum(self : CryptoasymeddsaRange) -> Double { @_common.sum(self.data) }

pub fn CryptoasymeddsaRange::mean(self : CryptoasymeddsaRange) -> Double { @_common.mean(self.data) }

pub fn CryptoasymeddsaRange::scale(self : CryptoasymeddsaRange, f : Double) -> CryptoasymeddsaRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaRange::add(self : CryptoasymeddsaRange, other : CryptoasymeddsaRange) -> CryptoasymeddsaRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymeddsaRange::copy(self : CryptoasymeddsaRange) -> CryptoasymeddsaRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaRange::fill(self : CryptoasymeddsaRange, v : Double) -> CryptoasymeddsaRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaRange::min(self : CryptoasymeddsaRange) -> Double { @_common.min(self.data) }

pub fn CryptoasymeddsaRange::max(self : CryptoasymeddsaRange) -> Double { @_common.max(self.data) }

pub fn CryptoasymeddsaRange::to_string(self : CryptoasymeddsaRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymeddsaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_eddsa_slice_make(size : Int) -> CryptoasymeddsaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymeddsaSlice::len(self : CryptoasymeddsaSlice) -> Int { self.size }

pub fn CryptoasymeddsaSlice::get(self : CryptoasymeddsaSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymeddsaSlice::set(self : CryptoasymeddsaSlice, i : Int, v : Double) -> CryptoasymeddsaSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaSlice::sum(self : CryptoasymeddsaSlice) -> Double { @_common.sum(self.data) }

pub fn CryptoasymeddsaSlice::mean(self : CryptoasymeddsaSlice) -> Double { @_common.mean(self.data) }

pub fn CryptoasymeddsaSlice::scale(self : CryptoasymeddsaSlice, f : Double) -> CryptoasymeddsaSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaSlice::add(self : CryptoasymeddsaSlice, other : CryptoasymeddsaSlice) -> CryptoasymeddsaSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymeddsaSlice::copy(self : CryptoasymeddsaSlice) -> CryptoasymeddsaSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaSlice::fill(self : CryptoasymeddsaSlice, v : Double) -> CryptoasymeddsaSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymeddsaSlice::min(self : CryptoasymeddsaSlice) -> Double { @_common.min(self.data) }

pub fn CryptoasymeddsaSlice::max(self : CryptoasymeddsaSlice) -> Double { @_common.max(self.data) }

pub fn CryptoasymeddsaSlice::to_string(self : CryptoasymeddsaSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

