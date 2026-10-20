///===
/// extcore/crypto_sym_twofish

pub(all) struct CryptosymtwofishPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sym_twofish_make_point(x : Double, y : Double) -> CryptosymtwofishPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sym_twofish_make_point3(x : Double, y : Double, z : Double) -> CryptosymtwofishPoint {
  { x, y, z, label: 0 }
}

pub fn CryptosymtwofishPoint::x(self : CryptosymtwofishPoint) -> Double { self.x }

pub fn CryptosymtwofishPoint::y(self : CryptosymtwofishPoint) -> Double { self.y }

pub fn CryptosymtwofishPoint::z(self : CryptosymtwofishPoint) -> Double { self.z }

pub fn CryptosymtwofishPoint::label(self : CryptosymtwofishPoint) -> Int { self.label }

pub fn CryptosymtwofishPoint::dist(self : CryptosymtwofishPoint, other : CryptosymtwofishPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn CryptosymtwofishPoint::add(self : CryptosymtwofishPoint, other : CryptosymtwofishPoint) -> CryptosymtwofishPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn CryptosymtwofishPoint::sub(self : CryptosymtwofishPoint, other : CryptosymtwofishPoint) -> CryptosymtwofishPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn CryptosymtwofishPoint::scale(self : CryptosymtwofishPoint, s : Double) -> CryptosymtwofishPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn CryptosymtwofishPoint::dot(self : CryptosymtwofishPoint, other : CryptosymtwofishPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn CryptosymtwofishPoint::cross(self : CryptosymtwofishPoint, other : CryptosymtwofishPoint) -> CryptosymtwofishPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn CryptosymtwofishPoint::norm(self : CryptosymtwofishPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn CryptosymtwofishPoint::normalize(self : CryptosymtwofishPoint) -> CryptosymtwofishPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosymtwofishPoint::negate(self : CryptosymtwofishPoint) -> CryptosymtwofishPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn CryptosymtwofishPoint::mid(self : CryptosymtwofishPoint, other : CryptosymtwofishPoint) -> CryptosymtwofishPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn CryptosymtwofishPoint::lerp(self : CryptosymtwofishPoint, other : CryptosymtwofishPoint, t : Double) -> CryptosymtwofishPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn CryptosymtwofishPoint::to_string(self : CryptosymtwofishPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct CryptosymtwofishSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sym_twofish_make_series(vals : Array[Double], name : String) -> CryptosymtwofishSeries {
  { vals, name, meta: 0 }
}

pub fn CryptosymtwofishSeries::len(self : CryptosymtwofishSeries) -> Int { self.vals.length() }

pub fn CryptosymtwofishSeries::sum(self : CryptosymtwofishSeries) -> Double { @_common.sum(self.vals) }

pub fn CryptosymtwofishSeries::mean(self : CryptosymtwofishSeries) -> Double { @_common.mean(self.vals) }

pub fn CryptosymtwofishSeries::min(self : CryptosymtwofishSeries) -> Double { @_common.min(self.vals) }

pub fn CryptosymtwofishSeries::max(self : CryptosymtwofishSeries) -> Double { @_common.max(self.vals) }

pub fn CryptosymtwofishSeries::range(self : CryptosymtwofishSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn CryptosymtwofishSeries::variance(self : CryptosymtwofishSeries) -> Double { @_common.variance(self.vals) }

pub fn CryptosymtwofishSeries::std(self : CryptosymtwofishSeries) -> Double { @_common.std(self.vals) }

pub fn CryptosymtwofishSeries::median(self : CryptosymtwofishSeries) -> Double { @_common.median(self.vals) }

pub fn CryptosymtwofishSeries::scale(self : CryptosymtwofishSeries, f : Double) -> CryptosymtwofishSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn CryptosymtwofishSeries::add(self : CryptosymtwofishSeries, other : CryptosymtwofishSeries) -> CryptosymtwofishSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn CryptosymtwofishSeries::sub(self : CryptosymtwofishSeries, other : CryptosymtwofishSeries) -> CryptosymtwofishSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn CryptosymtwofishSeries::normalize(self : CryptosymtwofishSeries) -> CryptosymtwofishSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn CryptosymtwofishSeries::cumsum(self : CryptosymtwofishSeries) -> CryptosymtwofishSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn CryptosymtwofishSeries::to_string(self : CryptosymtwofishSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosymtwofishMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sym_twofish_make_matrix(rows : Int, cols : Int, val : Double) -> CryptosymtwofishMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_sym_twofish_matrix_identity(n : Int) -> CryptosymtwofishMatrix {
  let m = crypto_sym_twofish_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn CryptosymtwofishMatrix::get(self : CryptosymtwofishMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn CryptosymtwofishMatrix::transpose(self : CryptosymtwofishMatrix) -> CryptosymtwofishMatrix {
  let result = crypto_sym_twofish_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn CryptosymtwofishMatrix::add(self : CryptosymtwofishMatrix, other : CryptosymtwofishMatrix) -> CryptosymtwofishMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_sym_twofish_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn CryptosymtwofishMatrix::scale(self : CryptosymtwofishMatrix, s : Double) -> CryptosymtwofishMatrix {
  let result = crypto_sym_twofish_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn CryptosymtwofishMatrix::multiply(self : CryptosymtwofishMatrix, other : CryptosymtwofishMatrix) -> CryptosymtwofishMatrix {
  if self.cols != other.rows { return crypto_sym_twofish_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_sym_twofish_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn CryptosymtwofishMatrix::trace(self : CryptosymtwofishMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn CryptosymtwofishMatrix::det(self : CryptosymtwofishMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn CryptosymtwofishMatrix::norm(self : CryptosymtwofishMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn CryptosymtwofishMatrix::to_string(self : CryptosymtwofishMatrix) -> String {
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

pub(all) struct CryptosymtwofishVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sym_twofish_make_vector(comps : Array[Double]) -> CryptosymtwofishVector {
  { comps, dim: comps.length() }
}

pub fn crypto_sym_twofish_vector_zero(dim : Int) -> CryptosymtwofishVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn CryptosymtwofishVector::add(self : CryptosymtwofishVector, other : CryptosymtwofishVector) -> CryptosymtwofishVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosymtwofishVector::sub(self : CryptosymtwofishVector, other : CryptosymtwofishVector) -> CryptosymtwofishVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosymtwofishVector::scale(self : CryptosymtwofishVector, s : Double) -> CryptosymtwofishVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn CryptosymtwofishVector::dot(self : CryptosymtwofishVector, other : CryptosymtwofishVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn CryptosymtwofishVector::norm(self : CryptosymtwofishVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn CryptosymtwofishVector::normalize(self : CryptosymtwofishVector) -> CryptosymtwofishVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosymtwofishVector::dist(self : CryptosymtwofishVector, other : CryptosymtwofishVector) -> Double {
  self.sub(other).norm()
}

pub fn CryptosymtwofishVector::to_string(self : CryptosymtwofishVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosymtwofishFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_twofish_frame_make(size : Int) -> CryptosymtwofishFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymtwofishFrame::len(self : CryptosymtwofishFrame) -> Int { self.size }

pub fn CryptosymtwofishFrame::get(self : CryptosymtwofishFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymtwofishFrame::set(self : CryptosymtwofishFrame, i : Int, v : Double) -> CryptosymtwofishFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishFrame::sum(self : CryptosymtwofishFrame) -> Double { @_common.sum(self.data) }

pub fn CryptosymtwofishFrame::mean(self : CryptosymtwofishFrame) -> Double { @_common.mean(self.data) }

pub fn CryptosymtwofishFrame::scale(self : CryptosymtwofishFrame, f : Double) -> CryptosymtwofishFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishFrame::add(self : CryptosymtwofishFrame, other : CryptosymtwofishFrame) -> CryptosymtwofishFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymtwofishFrame::copy(self : CryptosymtwofishFrame) -> CryptosymtwofishFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishFrame::fill(self : CryptosymtwofishFrame, v : Double) -> CryptosymtwofishFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishFrame::min(self : CryptosymtwofishFrame) -> Double { @_common.min(self.data) }

pub fn CryptosymtwofishFrame::max(self : CryptosymtwofishFrame) -> Double { @_common.max(self.data) }

pub fn CryptosymtwofishFrame::to_string(self : CryptosymtwofishFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymtwofishTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_twofish_table_make(size : Int) -> CryptosymtwofishTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymtwofishTable::len(self : CryptosymtwofishTable) -> Int { self.size }

pub fn CryptosymtwofishTable::get(self : CryptosymtwofishTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymtwofishTable::set(self : CryptosymtwofishTable, i : Int, v : Double) -> CryptosymtwofishTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishTable::sum(self : CryptosymtwofishTable) -> Double { @_common.sum(self.data) }

pub fn CryptosymtwofishTable::mean(self : CryptosymtwofishTable) -> Double { @_common.mean(self.data) }

pub fn CryptosymtwofishTable::scale(self : CryptosymtwofishTable, f : Double) -> CryptosymtwofishTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishTable::add(self : CryptosymtwofishTable, other : CryptosymtwofishTable) -> CryptosymtwofishTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymtwofishTable::copy(self : CryptosymtwofishTable) -> CryptosymtwofishTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishTable::fill(self : CryptosymtwofishTable, v : Double) -> CryptosymtwofishTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishTable::min(self : CryptosymtwofishTable) -> Double { @_common.min(self.data) }

pub fn CryptosymtwofishTable::max(self : CryptosymtwofishTable) -> Double { @_common.max(self.data) }

pub fn CryptosymtwofishTable::to_string(self : CryptosymtwofishTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymtwofishGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_twofish_graphn_make(size : Int) -> CryptosymtwofishGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymtwofishGraphN::len(self : CryptosymtwofishGraphN) -> Int { self.size }

pub fn CryptosymtwofishGraphN::get(self : CryptosymtwofishGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymtwofishGraphN::set(self : CryptosymtwofishGraphN, i : Int, v : Double) -> CryptosymtwofishGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishGraphN::sum(self : CryptosymtwofishGraphN) -> Double { @_common.sum(self.data) }

pub fn CryptosymtwofishGraphN::mean(self : CryptosymtwofishGraphN) -> Double { @_common.mean(self.data) }

pub fn CryptosymtwofishGraphN::scale(self : CryptosymtwofishGraphN, f : Double) -> CryptosymtwofishGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishGraphN::add(self : CryptosymtwofishGraphN, other : CryptosymtwofishGraphN) -> CryptosymtwofishGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymtwofishGraphN::copy(self : CryptosymtwofishGraphN) -> CryptosymtwofishGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishGraphN::fill(self : CryptosymtwofishGraphN, v : Double) -> CryptosymtwofishGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishGraphN::min(self : CryptosymtwofishGraphN) -> Double { @_common.min(self.data) }

pub fn CryptosymtwofishGraphN::max(self : CryptosymtwofishGraphN) -> Double { @_common.max(self.data) }

pub fn CryptosymtwofishGraphN::to_string(self : CryptosymtwofishGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymtwofishNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_twofish_node_make(size : Int) -> CryptosymtwofishNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymtwofishNode::len(self : CryptosymtwofishNode) -> Int { self.size }

pub fn CryptosymtwofishNode::get(self : CryptosymtwofishNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymtwofishNode::set(self : CryptosymtwofishNode, i : Int, v : Double) -> CryptosymtwofishNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishNode::sum(self : CryptosymtwofishNode) -> Double { @_common.sum(self.data) }

pub fn CryptosymtwofishNode::mean(self : CryptosymtwofishNode) -> Double { @_common.mean(self.data) }

pub fn CryptosymtwofishNode::scale(self : CryptosymtwofishNode, f : Double) -> CryptosymtwofishNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishNode::add(self : CryptosymtwofishNode, other : CryptosymtwofishNode) -> CryptosymtwofishNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymtwofishNode::copy(self : CryptosymtwofishNode) -> CryptosymtwofishNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishNode::fill(self : CryptosymtwofishNode, v : Double) -> CryptosymtwofishNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishNode::min(self : CryptosymtwofishNode) -> Double { @_common.min(self.data) }

pub fn CryptosymtwofishNode::max(self : CryptosymtwofishNode) -> Double { @_common.max(self.data) }

pub fn CryptosymtwofishNode::to_string(self : CryptosymtwofishNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymtwofishEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_twofish_edge_make(size : Int) -> CryptosymtwofishEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymtwofishEdge::len(self : CryptosymtwofishEdge) -> Int { self.size }

pub fn CryptosymtwofishEdge::get(self : CryptosymtwofishEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymtwofishEdge::set(self : CryptosymtwofishEdge, i : Int, v : Double) -> CryptosymtwofishEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishEdge::sum(self : CryptosymtwofishEdge) -> Double { @_common.sum(self.data) }

pub fn CryptosymtwofishEdge::mean(self : CryptosymtwofishEdge) -> Double { @_common.mean(self.data) }

pub fn CryptosymtwofishEdge::scale(self : CryptosymtwofishEdge, f : Double) -> CryptosymtwofishEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishEdge::add(self : CryptosymtwofishEdge, other : CryptosymtwofishEdge) -> CryptosymtwofishEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymtwofishEdge::copy(self : CryptosymtwofishEdge) -> CryptosymtwofishEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishEdge::fill(self : CryptosymtwofishEdge, v : Double) -> CryptosymtwofishEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishEdge::min(self : CryptosymtwofishEdge) -> Double { @_common.min(self.data) }

pub fn CryptosymtwofishEdge::max(self : CryptosymtwofishEdge) -> Double { @_common.max(self.data) }

pub fn CryptosymtwofishEdge::to_string(self : CryptosymtwofishEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymtwofishPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_twofish_path_make(size : Int) -> CryptosymtwofishPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymtwofishPath::len(self : CryptosymtwofishPath) -> Int { self.size }

pub fn CryptosymtwofishPath::get(self : CryptosymtwofishPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymtwofishPath::set(self : CryptosymtwofishPath, i : Int, v : Double) -> CryptosymtwofishPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishPath::sum(self : CryptosymtwofishPath) -> Double { @_common.sum(self.data) }

pub fn CryptosymtwofishPath::mean(self : CryptosymtwofishPath) -> Double { @_common.mean(self.data) }

pub fn CryptosymtwofishPath::scale(self : CryptosymtwofishPath, f : Double) -> CryptosymtwofishPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishPath::add(self : CryptosymtwofishPath, other : CryptosymtwofishPath) -> CryptosymtwofishPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymtwofishPath::copy(self : CryptosymtwofishPath) -> CryptosymtwofishPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishPath::fill(self : CryptosymtwofishPath, v : Double) -> CryptosymtwofishPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishPath::min(self : CryptosymtwofishPath) -> Double { @_common.min(self.data) }

pub fn CryptosymtwofishPath::max(self : CryptosymtwofishPath) -> Double { @_common.max(self.data) }

pub fn CryptosymtwofishPath::to_string(self : CryptosymtwofishPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymtwofishCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_twofish_cluster_make(size : Int) -> CryptosymtwofishCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymtwofishCluster::len(self : CryptosymtwofishCluster) -> Int { self.size }

pub fn CryptosymtwofishCluster::get(self : CryptosymtwofishCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymtwofishCluster::set(self : CryptosymtwofishCluster, i : Int, v : Double) -> CryptosymtwofishCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishCluster::sum(self : CryptosymtwofishCluster) -> Double { @_common.sum(self.data) }

pub fn CryptosymtwofishCluster::mean(self : CryptosymtwofishCluster) -> Double { @_common.mean(self.data) }

pub fn CryptosymtwofishCluster::scale(self : CryptosymtwofishCluster, f : Double) -> CryptosymtwofishCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishCluster::add(self : CryptosymtwofishCluster, other : CryptosymtwofishCluster) -> CryptosymtwofishCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymtwofishCluster::copy(self : CryptosymtwofishCluster) -> CryptosymtwofishCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishCluster::fill(self : CryptosymtwofishCluster, v : Double) -> CryptosymtwofishCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishCluster::min(self : CryptosymtwofishCluster) -> Double { @_common.min(self.data) }

pub fn CryptosymtwofishCluster::max(self : CryptosymtwofishCluster) -> Double { @_common.max(self.data) }

pub fn CryptosymtwofishCluster::to_string(self : CryptosymtwofishCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymtwofishModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_twofish_model_make(size : Int) -> CryptosymtwofishModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymtwofishModel::len(self : CryptosymtwofishModel) -> Int { self.size }

pub fn CryptosymtwofishModel::get(self : CryptosymtwofishModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymtwofishModel::set(self : CryptosymtwofishModel, i : Int, v : Double) -> CryptosymtwofishModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishModel::sum(self : CryptosymtwofishModel) -> Double { @_common.sum(self.data) }

pub fn CryptosymtwofishModel::mean(self : CryptosymtwofishModel) -> Double { @_common.mean(self.data) }

pub fn CryptosymtwofishModel::scale(self : CryptosymtwofishModel, f : Double) -> CryptosymtwofishModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishModel::add(self : CryptosymtwofishModel, other : CryptosymtwofishModel) -> CryptosymtwofishModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymtwofishModel::copy(self : CryptosymtwofishModel) -> CryptosymtwofishModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishModel::fill(self : CryptosymtwofishModel, v : Double) -> CryptosymtwofishModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishModel::min(self : CryptosymtwofishModel) -> Double { @_common.min(self.data) }

pub fn CryptosymtwofishModel::max(self : CryptosymtwofishModel) -> Double { @_common.max(self.data) }

pub fn CryptosymtwofishModel::to_string(self : CryptosymtwofishModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymtwofishLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_twofish_layer_make(size : Int) -> CryptosymtwofishLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymtwofishLayer::len(self : CryptosymtwofishLayer) -> Int { self.size }

pub fn CryptosymtwofishLayer::get(self : CryptosymtwofishLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymtwofishLayer::set(self : CryptosymtwofishLayer, i : Int, v : Double) -> CryptosymtwofishLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishLayer::sum(self : CryptosymtwofishLayer) -> Double { @_common.sum(self.data) }

pub fn CryptosymtwofishLayer::mean(self : CryptosymtwofishLayer) -> Double { @_common.mean(self.data) }

pub fn CryptosymtwofishLayer::scale(self : CryptosymtwofishLayer, f : Double) -> CryptosymtwofishLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishLayer::add(self : CryptosymtwofishLayer, other : CryptosymtwofishLayer) -> CryptosymtwofishLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymtwofishLayer::copy(self : CryptosymtwofishLayer) -> CryptosymtwofishLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishLayer::fill(self : CryptosymtwofishLayer, v : Double) -> CryptosymtwofishLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishLayer::min(self : CryptosymtwofishLayer) -> Double { @_common.min(self.data) }

pub fn CryptosymtwofishLayer::max(self : CryptosymtwofishLayer) -> Double { @_common.max(self.data) }

pub fn CryptosymtwofishLayer::to_string(self : CryptosymtwofishLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymtwofishBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_twofish_buffer_make(size : Int) -> CryptosymtwofishBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymtwofishBuffer::len(self : CryptosymtwofishBuffer) -> Int { self.size }

pub fn CryptosymtwofishBuffer::get(self : CryptosymtwofishBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymtwofishBuffer::set(self : CryptosymtwofishBuffer, i : Int, v : Double) -> CryptosymtwofishBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishBuffer::sum(self : CryptosymtwofishBuffer) -> Double { @_common.sum(self.data) }

pub fn CryptosymtwofishBuffer::mean(self : CryptosymtwofishBuffer) -> Double { @_common.mean(self.data) }

pub fn CryptosymtwofishBuffer::scale(self : CryptosymtwofishBuffer, f : Double) -> CryptosymtwofishBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishBuffer::add(self : CryptosymtwofishBuffer, other : CryptosymtwofishBuffer) -> CryptosymtwofishBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymtwofishBuffer::copy(self : CryptosymtwofishBuffer) -> CryptosymtwofishBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishBuffer::fill(self : CryptosymtwofishBuffer, v : Double) -> CryptosymtwofishBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishBuffer::min(self : CryptosymtwofishBuffer) -> Double { @_common.min(self.data) }

pub fn CryptosymtwofishBuffer::max(self : CryptosymtwofishBuffer) -> Double { @_common.max(self.data) }

pub fn CryptosymtwofishBuffer::to_string(self : CryptosymtwofishBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymtwofishCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_twofish_cursor_make(size : Int) -> CryptosymtwofishCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymtwofishCursor::len(self : CryptosymtwofishCursor) -> Int { self.size }

pub fn CryptosymtwofishCursor::get(self : CryptosymtwofishCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymtwofishCursor::set(self : CryptosymtwofishCursor, i : Int, v : Double) -> CryptosymtwofishCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishCursor::sum(self : CryptosymtwofishCursor) -> Double { @_common.sum(self.data) }

pub fn CryptosymtwofishCursor::mean(self : CryptosymtwofishCursor) -> Double { @_common.mean(self.data) }

pub fn CryptosymtwofishCursor::scale(self : CryptosymtwofishCursor, f : Double) -> CryptosymtwofishCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishCursor::add(self : CryptosymtwofishCursor, other : CryptosymtwofishCursor) -> CryptosymtwofishCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymtwofishCursor::copy(self : CryptosymtwofishCursor) -> CryptosymtwofishCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishCursor::fill(self : CryptosymtwofishCursor, v : Double) -> CryptosymtwofishCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishCursor::min(self : CryptosymtwofishCursor) -> Double { @_common.min(self.data) }

pub fn CryptosymtwofishCursor::max(self : CryptosymtwofishCursor) -> Double { @_common.max(self.data) }

pub fn CryptosymtwofishCursor::to_string(self : CryptosymtwofishCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymtwofishView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_twofish_view_make(size : Int) -> CryptosymtwofishView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymtwofishView::len(self : CryptosymtwofishView) -> Int { self.size }

pub fn CryptosymtwofishView::get(self : CryptosymtwofishView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymtwofishView::set(self : CryptosymtwofishView, i : Int, v : Double) -> CryptosymtwofishView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishView::sum(self : CryptosymtwofishView) -> Double { @_common.sum(self.data) }

pub fn CryptosymtwofishView::mean(self : CryptosymtwofishView) -> Double { @_common.mean(self.data) }

pub fn CryptosymtwofishView::scale(self : CryptosymtwofishView, f : Double) -> CryptosymtwofishView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishView::add(self : CryptosymtwofishView, other : CryptosymtwofishView) -> CryptosymtwofishView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymtwofishView::copy(self : CryptosymtwofishView) -> CryptosymtwofishView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishView::fill(self : CryptosymtwofishView, v : Double) -> CryptosymtwofishView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishView::min(self : CryptosymtwofishView) -> Double { @_common.min(self.data) }

pub fn CryptosymtwofishView::max(self : CryptosymtwofishView) -> Double { @_common.max(self.data) }

pub fn CryptosymtwofishView::to_string(self : CryptosymtwofishView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymtwofishRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_twofish_range_make(size : Int) -> CryptosymtwofishRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymtwofishRange::len(self : CryptosymtwofishRange) -> Int { self.size }

pub fn CryptosymtwofishRange::get(self : CryptosymtwofishRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymtwofishRange::set(self : CryptosymtwofishRange, i : Int, v : Double) -> CryptosymtwofishRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishRange::sum(self : CryptosymtwofishRange) -> Double { @_common.sum(self.data) }

pub fn CryptosymtwofishRange::mean(self : CryptosymtwofishRange) -> Double { @_common.mean(self.data) }

pub fn CryptosymtwofishRange::scale(self : CryptosymtwofishRange, f : Double) -> CryptosymtwofishRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishRange::add(self : CryptosymtwofishRange, other : CryptosymtwofishRange) -> CryptosymtwofishRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymtwofishRange::copy(self : CryptosymtwofishRange) -> CryptosymtwofishRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishRange::fill(self : CryptosymtwofishRange, v : Double) -> CryptosymtwofishRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishRange::min(self : CryptosymtwofishRange) -> Double { @_common.min(self.data) }

pub fn CryptosymtwofishRange::max(self : CryptosymtwofishRange) -> Double { @_common.max(self.data) }

pub fn CryptosymtwofishRange::to_string(self : CryptosymtwofishRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymtwofishSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_twofish_slice_make(size : Int) -> CryptosymtwofishSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymtwofishSlice::len(self : CryptosymtwofishSlice) -> Int { self.size }

pub fn CryptosymtwofishSlice::get(self : CryptosymtwofishSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymtwofishSlice::set(self : CryptosymtwofishSlice, i : Int, v : Double) -> CryptosymtwofishSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishSlice::sum(self : CryptosymtwofishSlice) -> Double { @_common.sum(self.data) }

pub fn CryptosymtwofishSlice::mean(self : CryptosymtwofishSlice) -> Double { @_common.mean(self.data) }

pub fn CryptosymtwofishSlice::scale(self : CryptosymtwofishSlice, f : Double) -> CryptosymtwofishSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishSlice::add(self : CryptosymtwofishSlice, other : CryptosymtwofishSlice) -> CryptosymtwofishSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymtwofishSlice::copy(self : CryptosymtwofishSlice) -> CryptosymtwofishSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishSlice::fill(self : CryptosymtwofishSlice, v : Double) -> CryptosymtwofishSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymtwofishSlice::min(self : CryptosymtwofishSlice) -> Double { @_common.min(self.data) }

pub fn CryptosymtwofishSlice::max(self : CryptosymtwofishSlice) -> Double { @_common.max(self.data) }

pub fn CryptosymtwofishSlice::to_string(self : CryptosymtwofishSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

