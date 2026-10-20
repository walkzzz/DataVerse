///===
/// extcore/crypto_asym_elgamal

pub(all) struct CryptoasymelgamalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_asym_elgamal_make_point(x : Double, y : Double) -> CryptoasymelgamalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_asym_elgamal_make_point3(x : Double, y : Double, z : Double) -> CryptoasymelgamalPoint {
  { x, y, z, label: 0 }
}

pub fn CryptoasymelgamalPoint::x(self : CryptoasymelgamalPoint) -> Double { self.x }

pub fn CryptoasymelgamalPoint::y(self : CryptoasymelgamalPoint) -> Double { self.y }

pub fn CryptoasymelgamalPoint::z(self : CryptoasymelgamalPoint) -> Double { self.z }

pub fn CryptoasymelgamalPoint::label(self : CryptoasymelgamalPoint) -> Int { self.label }

pub fn CryptoasymelgamalPoint::dist(self : CryptoasymelgamalPoint, other : CryptoasymelgamalPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn CryptoasymelgamalPoint::add(self : CryptoasymelgamalPoint, other : CryptoasymelgamalPoint) -> CryptoasymelgamalPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn CryptoasymelgamalPoint::sub(self : CryptoasymelgamalPoint, other : CryptoasymelgamalPoint) -> CryptoasymelgamalPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn CryptoasymelgamalPoint::scale(self : CryptoasymelgamalPoint, s : Double) -> CryptoasymelgamalPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn CryptoasymelgamalPoint::dot(self : CryptoasymelgamalPoint, other : CryptoasymelgamalPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn CryptoasymelgamalPoint::cross(self : CryptoasymelgamalPoint, other : CryptoasymelgamalPoint) -> CryptoasymelgamalPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn CryptoasymelgamalPoint::norm(self : CryptoasymelgamalPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn CryptoasymelgamalPoint::normalize(self : CryptoasymelgamalPoint) -> CryptoasymelgamalPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptoasymelgamalPoint::negate(self : CryptoasymelgamalPoint) -> CryptoasymelgamalPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn CryptoasymelgamalPoint::mid(self : CryptoasymelgamalPoint, other : CryptoasymelgamalPoint) -> CryptoasymelgamalPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn CryptoasymelgamalPoint::lerp(self : CryptoasymelgamalPoint, other : CryptoasymelgamalPoint, t : Double) -> CryptoasymelgamalPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn CryptoasymelgamalPoint::to_string(self : CryptoasymelgamalPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct CryptoasymelgamalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_asym_elgamal_make_series(vals : Array[Double], name : String) -> CryptoasymelgamalSeries {
  { vals, name, meta: 0 }
}

pub fn CryptoasymelgamalSeries::len(self : CryptoasymelgamalSeries) -> Int { self.vals.length() }

pub fn CryptoasymelgamalSeries::sum(self : CryptoasymelgamalSeries) -> Double { @_common.sum(self.vals) }

pub fn CryptoasymelgamalSeries::mean(self : CryptoasymelgamalSeries) -> Double { @_common.mean(self.vals) }

pub fn CryptoasymelgamalSeries::min(self : CryptoasymelgamalSeries) -> Double { @_common.min(self.vals) }

pub fn CryptoasymelgamalSeries::max(self : CryptoasymelgamalSeries) -> Double { @_common.max(self.vals) }

pub fn CryptoasymelgamalSeries::range(self : CryptoasymelgamalSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn CryptoasymelgamalSeries::variance(self : CryptoasymelgamalSeries) -> Double { @_common.variance(self.vals) }

pub fn CryptoasymelgamalSeries::std(self : CryptoasymelgamalSeries) -> Double { @_common.std(self.vals) }

pub fn CryptoasymelgamalSeries::median(self : CryptoasymelgamalSeries) -> Double { @_common.median(self.vals) }

pub fn CryptoasymelgamalSeries::scale(self : CryptoasymelgamalSeries, f : Double) -> CryptoasymelgamalSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn CryptoasymelgamalSeries::add(self : CryptoasymelgamalSeries, other : CryptoasymelgamalSeries) -> CryptoasymelgamalSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn CryptoasymelgamalSeries::sub(self : CryptoasymelgamalSeries, other : CryptoasymelgamalSeries) -> CryptoasymelgamalSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn CryptoasymelgamalSeries::normalize(self : CryptoasymelgamalSeries) -> CryptoasymelgamalSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn CryptoasymelgamalSeries::cumsum(self : CryptoasymelgamalSeries) -> CryptoasymelgamalSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn CryptoasymelgamalSeries::to_string(self : CryptoasymelgamalSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptoasymelgamalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_asym_elgamal_make_matrix(rows : Int, cols : Int, val : Double) -> CryptoasymelgamalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_asym_elgamal_matrix_identity(n : Int) -> CryptoasymelgamalMatrix {
  let m = crypto_asym_elgamal_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn CryptoasymelgamalMatrix::get(self : CryptoasymelgamalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn CryptoasymelgamalMatrix::transpose(self : CryptoasymelgamalMatrix) -> CryptoasymelgamalMatrix {
  let result = crypto_asym_elgamal_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn CryptoasymelgamalMatrix::add(self : CryptoasymelgamalMatrix, other : CryptoasymelgamalMatrix) -> CryptoasymelgamalMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_asym_elgamal_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn CryptoasymelgamalMatrix::scale(self : CryptoasymelgamalMatrix, s : Double) -> CryptoasymelgamalMatrix {
  let result = crypto_asym_elgamal_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn CryptoasymelgamalMatrix::multiply(self : CryptoasymelgamalMatrix, other : CryptoasymelgamalMatrix) -> CryptoasymelgamalMatrix {
  if self.cols != other.rows { return crypto_asym_elgamal_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_asym_elgamal_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn CryptoasymelgamalMatrix::trace(self : CryptoasymelgamalMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn CryptoasymelgamalMatrix::det(self : CryptoasymelgamalMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn CryptoasymelgamalMatrix::norm(self : CryptoasymelgamalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn CryptoasymelgamalMatrix::to_string(self : CryptoasymelgamalMatrix) -> String {
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

pub(all) struct CryptoasymelgamalVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_asym_elgamal_make_vector(comps : Array[Double]) -> CryptoasymelgamalVector {
  { comps, dim: comps.length() }
}

pub fn crypto_asym_elgamal_vector_zero(dim : Int) -> CryptoasymelgamalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn CryptoasymelgamalVector::add(self : CryptoasymelgamalVector, other : CryptoasymelgamalVector) -> CryptoasymelgamalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn CryptoasymelgamalVector::sub(self : CryptoasymelgamalVector, other : CryptoasymelgamalVector) -> CryptoasymelgamalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn CryptoasymelgamalVector::scale(self : CryptoasymelgamalVector, s : Double) -> CryptoasymelgamalVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn CryptoasymelgamalVector::dot(self : CryptoasymelgamalVector, other : CryptoasymelgamalVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn CryptoasymelgamalVector::norm(self : CryptoasymelgamalVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn CryptoasymelgamalVector::normalize(self : CryptoasymelgamalVector) -> CryptoasymelgamalVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptoasymelgamalVector::dist(self : CryptoasymelgamalVector, other : CryptoasymelgamalVector) -> Double {
  self.sub(other).norm()
}

pub fn CryptoasymelgamalVector::to_string(self : CryptoasymelgamalVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptoasymelgamalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_elgamal_frame_make(size : Int) -> CryptoasymelgamalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymelgamalFrame::len(self : CryptoasymelgamalFrame) -> Int { self.size }

pub fn CryptoasymelgamalFrame::get(self : CryptoasymelgamalFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymelgamalFrame::set(self : CryptoasymelgamalFrame, i : Int, v : Double) -> CryptoasymelgamalFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalFrame::sum(self : CryptoasymelgamalFrame) -> Double { @_common.sum(self.data) }

pub fn CryptoasymelgamalFrame::mean(self : CryptoasymelgamalFrame) -> Double { @_common.mean(self.data) }

pub fn CryptoasymelgamalFrame::scale(self : CryptoasymelgamalFrame, f : Double) -> CryptoasymelgamalFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalFrame::add(self : CryptoasymelgamalFrame, other : CryptoasymelgamalFrame) -> CryptoasymelgamalFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymelgamalFrame::copy(self : CryptoasymelgamalFrame) -> CryptoasymelgamalFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalFrame::fill(self : CryptoasymelgamalFrame, v : Double) -> CryptoasymelgamalFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalFrame::min(self : CryptoasymelgamalFrame) -> Double { @_common.min(self.data) }

pub fn CryptoasymelgamalFrame::max(self : CryptoasymelgamalFrame) -> Double { @_common.max(self.data) }

pub fn CryptoasymelgamalFrame::to_string(self : CryptoasymelgamalFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymelgamalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_elgamal_table_make(size : Int) -> CryptoasymelgamalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymelgamalTable::len(self : CryptoasymelgamalTable) -> Int { self.size }

pub fn CryptoasymelgamalTable::get(self : CryptoasymelgamalTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymelgamalTable::set(self : CryptoasymelgamalTable, i : Int, v : Double) -> CryptoasymelgamalTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalTable::sum(self : CryptoasymelgamalTable) -> Double { @_common.sum(self.data) }

pub fn CryptoasymelgamalTable::mean(self : CryptoasymelgamalTable) -> Double { @_common.mean(self.data) }

pub fn CryptoasymelgamalTable::scale(self : CryptoasymelgamalTable, f : Double) -> CryptoasymelgamalTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalTable::add(self : CryptoasymelgamalTable, other : CryptoasymelgamalTable) -> CryptoasymelgamalTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymelgamalTable::copy(self : CryptoasymelgamalTable) -> CryptoasymelgamalTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalTable::fill(self : CryptoasymelgamalTable, v : Double) -> CryptoasymelgamalTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalTable::min(self : CryptoasymelgamalTable) -> Double { @_common.min(self.data) }

pub fn CryptoasymelgamalTable::max(self : CryptoasymelgamalTable) -> Double { @_common.max(self.data) }

pub fn CryptoasymelgamalTable::to_string(self : CryptoasymelgamalTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymelgamalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_elgamal_graphn_make(size : Int) -> CryptoasymelgamalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymelgamalGraphN::len(self : CryptoasymelgamalGraphN) -> Int { self.size }

pub fn CryptoasymelgamalGraphN::get(self : CryptoasymelgamalGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymelgamalGraphN::set(self : CryptoasymelgamalGraphN, i : Int, v : Double) -> CryptoasymelgamalGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalGraphN::sum(self : CryptoasymelgamalGraphN) -> Double { @_common.sum(self.data) }

pub fn CryptoasymelgamalGraphN::mean(self : CryptoasymelgamalGraphN) -> Double { @_common.mean(self.data) }

pub fn CryptoasymelgamalGraphN::scale(self : CryptoasymelgamalGraphN, f : Double) -> CryptoasymelgamalGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalGraphN::add(self : CryptoasymelgamalGraphN, other : CryptoasymelgamalGraphN) -> CryptoasymelgamalGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymelgamalGraphN::copy(self : CryptoasymelgamalGraphN) -> CryptoasymelgamalGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalGraphN::fill(self : CryptoasymelgamalGraphN, v : Double) -> CryptoasymelgamalGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalGraphN::min(self : CryptoasymelgamalGraphN) -> Double { @_common.min(self.data) }

pub fn CryptoasymelgamalGraphN::max(self : CryptoasymelgamalGraphN) -> Double { @_common.max(self.data) }

pub fn CryptoasymelgamalGraphN::to_string(self : CryptoasymelgamalGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymelgamalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_elgamal_node_make(size : Int) -> CryptoasymelgamalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymelgamalNode::len(self : CryptoasymelgamalNode) -> Int { self.size }

pub fn CryptoasymelgamalNode::get(self : CryptoasymelgamalNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymelgamalNode::set(self : CryptoasymelgamalNode, i : Int, v : Double) -> CryptoasymelgamalNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalNode::sum(self : CryptoasymelgamalNode) -> Double { @_common.sum(self.data) }

pub fn CryptoasymelgamalNode::mean(self : CryptoasymelgamalNode) -> Double { @_common.mean(self.data) }

pub fn CryptoasymelgamalNode::scale(self : CryptoasymelgamalNode, f : Double) -> CryptoasymelgamalNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalNode::add(self : CryptoasymelgamalNode, other : CryptoasymelgamalNode) -> CryptoasymelgamalNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymelgamalNode::copy(self : CryptoasymelgamalNode) -> CryptoasymelgamalNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalNode::fill(self : CryptoasymelgamalNode, v : Double) -> CryptoasymelgamalNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalNode::min(self : CryptoasymelgamalNode) -> Double { @_common.min(self.data) }

pub fn CryptoasymelgamalNode::max(self : CryptoasymelgamalNode) -> Double { @_common.max(self.data) }

pub fn CryptoasymelgamalNode::to_string(self : CryptoasymelgamalNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymelgamalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_elgamal_edge_make(size : Int) -> CryptoasymelgamalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymelgamalEdge::len(self : CryptoasymelgamalEdge) -> Int { self.size }

pub fn CryptoasymelgamalEdge::get(self : CryptoasymelgamalEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymelgamalEdge::set(self : CryptoasymelgamalEdge, i : Int, v : Double) -> CryptoasymelgamalEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalEdge::sum(self : CryptoasymelgamalEdge) -> Double { @_common.sum(self.data) }

pub fn CryptoasymelgamalEdge::mean(self : CryptoasymelgamalEdge) -> Double { @_common.mean(self.data) }

pub fn CryptoasymelgamalEdge::scale(self : CryptoasymelgamalEdge, f : Double) -> CryptoasymelgamalEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalEdge::add(self : CryptoasymelgamalEdge, other : CryptoasymelgamalEdge) -> CryptoasymelgamalEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymelgamalEdge::copy(self : CryptoasymelgamalEdge) -> CryptoasymelgamalEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalEdge::fill(self : CryptoasymelgamalEdge, v : Double) -> CryptoasymelgamalEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalEdge::min(self : CryptoasymelgamalEdge) -> Double { @_common.min(self.data) }

pub fn CryptoasymelgamalEdge::max(self : CryptoasymelgamalEdge) -> Double { @_common.max(self.data) }

pub fn CryptoasymelgamalEdge::to_string(self : CryptoasymelgamalEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymelgamalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_elgamal_path_make(size : Int) -> CryptoasymelgamalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymelgamalPath::len(self : CryptoasymelgamalPath) -> Int { self.size }

pub fn CryptoasymelgamalPath::get(self : CryptoasymelgamalPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymelgamalPath::set(self : CryptoasymelgamalPath, i : Int, v : Double) -> CryptoasymelgamalPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalPath::sum(self : CryptoasymelgamalPath) -> Double { @_common.sum(self.data) }

pub fn CryptoasymelgamalPath::mean(self : CryptoasymelgamalPath) -> Double { @_common.mean(self.data) }

pub fn CryptoasymelgamalPath::scale(self : CryptoasymelgamalPath, f : Double) -> CryptoasymelgamalPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalPath::add(self : CryptoasymelgamalPath, other : CryptoasymelgamalPath) -> CryptoasymelgamalPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymelgamalPath::copy(self : CryptoasymelgamalPath) -> CryptoasymelgamalPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalPath::fill(self : CryptoasymelgamalPath, v : Double) -> CryptoasymelgamalPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalPath::min(self : CryptoasymelgamalPath) -> Double { @_common.min(self.data) }

pub fn CryptoasymelgamalPath::max(self : CryptoasymelgamalPath) -> Double { @_common.max(self.data) }

pub fn CryptoasymelgamalPath::to_string(self : CryptoasymelgamalPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymelgamalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_elgamal_cluster_make(size : Int) -> CryptoasymelgamalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymelgamalCluster::len(self : CryptoasymelgamalCluster) -> Int { self.size }

pub fn CryptoasymelgamalCluster::get(self : CryptoasymelgamalCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymelgamalCluster::set(self : CryptoasymelgamalCluster, i : Int, v : Double) -> CryptoasymelgamalCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalCluster::sum(self : CryptoasymelgamalCluster) -> Double { @_common.sum(self.data) }

pub fn CryptoasymelgamalCluster::mean(self : CryptoasymelgamalCluster) -> Double { @_common.mean(self.data) }

pub fn CryptoasymelgamalCluster::scale(self : CryptoasymelgamalCluster, f : Double) -> CryptoasymelgamalCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalCluster::add(self : CryptoasymelgamalCluster, other : CryptoasymelgamalCluster) -> CryptoasymelgamalCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymelgamalCluster::copy(self : CryptoasymelgamalCluster) -> CryptoasymelgamalCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalCluster::fill(self : CryptoasymelgamalCluster, v : Double) -> CryptoasymelgamalCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalCluster::min(self : CryptoasymelgamalCluster) -> Double { @_common.min(self.data) }

pub fn CryptoasymelgamalCluster::max(self : CryptoasymelgamalCluster) -> Double { @_common.max(self.data) }

pub fn CryptoasymelgamalCluster::to_string(self : CryptoasymelgamalCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymelgamalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_elgamal_model_make(size : Int) -> CryptoasymelgamalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymelgamalModel::len(self : CryptoasymelgamalModel) -> Int { self.size }

pub fn CryptoasymelgamalModel::get(self : CryptoasymelgamalModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymelgamalModel::set(self : CryptoasymelgamalModel, i : Int, v : Double) -> CryptoasymelgamalModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalModel::sum(self : CryptoasymelgamalModel) -> Double { @_common.sum(self.data) }

pub fn CryptoasymelgamalModel::mean(self : CryptoasymelgamalModel) -> Double { @_common.mean(self.data) }

pub fn CryptoasymelgamalModel::scale(self : CryptoasymelgamalModel, f : Double) -> CryptoasymelgamalModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalModel::add(self : CryptoasymelgamalModel, other : CryptoasymelgamalModel) -> CryptoasymelgamalModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymelgamalModel::copy(self : CryptoasymelgamalModel) -> CryptoasymelgamalModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalModel::fill(self : CryptoasymelgamalModel, v : Double) -> CryptoasymelgamalModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalModel::min(self : CryptoasymelgamalModel) -> Double { @_common.min(self.data) }

pub fn CryptoasymelgamalModel::max(self : CryptoasymelgamalModel) -> Double { @_common.max(self.data) }

pub fn CryptoasymelgamalModel::to_string(self : CryptoasymelgamalModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymelgamalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_elgamal_layer_make(size : Int) -> CryptoasymelgamalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymelgamalLayer::len(self : CryptoasymelgamalLayer) -> Int { self.size }

pub fn CryptoasymelgamalLayer::get(self : CryptoasymelgamalLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymelgamalLayer::set(self : CryptoasymelgamalLayer, i : Int, v : Double) -> CryptoasymelgamalLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalLayer::sum(self : CryptoasymelgamalLayer) -> Double { @_common.sum(self.data) }

pub fn CryptoasymelgamalLayer::mean(self : CryptoasymelgamalLayer) -> Double { @_common.mean(self.data) }

pub fn CryptoasymelgamalLayer::scale(self : CryptoasymelgamalLayer, f : Double) -> CryptoasymelgamalLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalLayer::add(self : CryptoasymelgamalLayer, other : CryptoasymelgamalLayer) -> CryptoasymelgamalLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymelgamalLayer::copy(self : CryptoasymelgamalLayer) -> CryptoasymelgamalLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalLayer::fill(self : CryptoasymelgamalLayer, v : Double) -> CryptoasymelgamalLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalLayer::min(self : CryptoasymelgamalLayer) -> Double { @_common.min(self.data) }

pub fn CryptoasymelgamalLayer::max(self : CryptoasymelgamalLayer) -> Double { @_common.max(self.data) }

pub fn CryptoasymelgamalLayer::to_string(self : CryptoasymelgamalLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymelgamalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_elgamal_buffer_make(size : Int) -> CryptoasymelgamalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymelgamalBuffer::len(self : CryptoasymelgamalBuffer) -> Int { self.size }

pub fn CryptoasymelgamalBuffer::get(self : CryptoasymelgamalBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymelgamalBuffer::set(self : CryptoasymelgamalBuffer, i : Int, v : Double) -> CryptoasymelgamalBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalBuffer::sum(self : CryptoasymelgamalBuffer) -> Double { @_common.sum(self.data) }

pub fn CryptoasymelgamalBuffer::mean(self : CryptoasymelgamalBuffer) -> Double { @_common.mean(self.data) }

pub fn CryptoasymelgamalBuffer::scale(self : CryptoasymelgamalBuffer, f : Double) -> CryptoasymelgamalBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalBuffer::add(self : CryptoasymelgamalBuffer, other : CryptoasymelgamalBuffer) -> CryptoasymelgamalBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymelgamalBuffer::copy(self : CryptoasymelgamalBuffer) -> CryptoasymelgamalBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalBuffer::fill(self : CryptoasymelgamalBuffer, v : Double) -> CryptoasymelgamalBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalBuffer::min(self : CryptoasymelgamalBuffer) -> Double { @_common.min(self.data) }

pub fn CryptoasymelgamalBuffer::max(self : CryptoasymelgamalBuffer) -> Double { @_common.max(self.data) }

pub fn CryptoasymelgamalBuffer::to_string(self : CryptoasymelgamalBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymelgamalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_elgamal_cursor_make(size : Int) -> CryptoasymelgamalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymelgamalCursor::len(self : CryptoasymelgamalCursor) -> Int { self.size }

pub fn CryptoasymelgamalCursor::get(self : CryptoasymelgamalCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymelgamalCursor::set(self : CryptoasymelgamalCursor, i : Int, v : Double) -> CryptoasymelgamalCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalCursor::sum(self : CryptoasymelgamalCursor) -> Double { @_common.sum(self.data) }

pub fn CryptoasymelgamalCursor::mean(self : CryptoasymelgamalCursor) -> Double { @_common.mean(self.data) }

pub fn CryptoasymelgamalCursor::scale(self : CryptoasymelgamalCursor, f : Double) -> CryptoasymelgamalCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalCursor::add(self : CryptoasymelgamalCursor, other : CryptoasymelgamalCursor) -> CryptoasymelgamalCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymelgamalCursor::copy(self : CryptoasymelgamalCursor) -> CryptoasymelgamalCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalCursor::fill(self : CryptoasymelgamalCursor, v : Double) -> CryptoasymelgamalCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalCursor::min(self : CryptoasymelgamalCursor) -> Double { @_common.min(self.data) }

pub fn CryptoasymelgamalCursor::max(self : CryptoasymelgamalCursor) -> Double { @_common.max(self.data) }

pub fn CryptoasymelgamalCursor::to_string(self : CryptoasymelgamalCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymelgamalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_elgamal_view_make(size : Int) -> CryptoasymelgamalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymelgamalView::len(self : CryptoasymelgamalView) -> Int { self.size }

pub fn CryptoasymelgamalView::get(self : CryptoasymelgamalView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymelgamalView::set(self : CryptoasymelgamalView, i : Int, v : Double) -> CryptoasymelgamalView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalView::sum(self : CryptoasymelgamalView) -> Double { @_common.sum(self.data) }

pub fn CryptoasymelgamalView::mean(self : CryptoasymelgamalView) -> Double { @_common.mean(self.data) }

pub fn CryptoasymelgamalView::scale(self : CryptoasymelgamalView, f : Double) -> CryptoasymelgamalView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalView::add(self : CryptoasymelgamalView, other : CryptoasymelgamalView) -> CryptoasymelgamalView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymelgamalView::copy(self : CryptoasymelgamalView) -> CryptoasymelgamalView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalView::fill(self : CryptoasymelgamalView, v : Double) -> CryptoasymelgamalView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalView::min(self : CryptoasymelgamalView) -> Double { @_common.min(self.data) }

pub fn CryptoasymelgamalView::max(self : CryptoasymelgamalView) -> Double { @_common.max(self.data) }

pub fn CryptoasymelgamalView::to_string(self : CryptoasymelgamalView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymelgamalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_elgamal_range_make(size : Int) -> CryptoasymelgamalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymelgamalRange::len(self : CryptoasymelgamalRange) -> Int { self.size }

pub fn CryptoasymelgamalRange::get(self : CryptoasymelgamalRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymelgamalRange::set(self : CryptoasymelgamalRange, i : Int, v : Double) -> CryptoasymelgamalRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalRange::sum(self : CryptoasymelgamalRange) -> Double { @_common.sum(self.data) }

pub fn CryptoasymelgamalRange::mean(self : CryptoasymelgamalRange) -> Double { @_common.mean(self.data) }

pub fn CryptoasymelgamalRange::scale(self : CryptoasymelgamalRange, f : Double) -> CryptoasymelgamalRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalRange::add(self : CryptoasymelgamalRange, other : CryptoasymelgamalRange) -> CryptoasymelgamalRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymelgamalRange::copy(self : CryptoasymelgamalRange) -> CryptoasymelgamalRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalRange::fill(self : CryptoasymelgamalRange, v : Double) -> CryptoasymelgamalRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalRange::min(self : CryptoasymelgamalRange) -> Double { @_common.min(self.data) }

pub fn CryptoasymelgamalRange::max(self : CryptoasymelgamalRange) -> Double { @_common.max(self.data) }

pub fn CryptoasymelgamalRange::to_string(self : CryptoasymelgamalRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymelgamalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_elgamal_slice_make(size : Int) -> CryptoasymelgamalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymelgamalSlice::len(self : CryptoasymelgamalSlice) -> Int { self.size }

pub fn CryptoasymelgamalSlice::get(self : CryptoasymelgamalSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymelgamalSlice::set(self : CryptoasymelgamalSlice, i : Int, v : Double) -> CryptoasymelgamalSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalSlice::sum(self : CryptoasymelgamalSlice) -> Double { @_common.sum(self.data) }

pub fn CryptoasymelgamalSlice::mean(self : CryptoasymelgamalSlice) -> Double { @_common.mean(self.data) }

pub fn CryptoasymelgamalSlice::scale(self : CryptoasymelgamalSlice, f : Double) -> CryptoasymelgamalSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalSlice::add(self : CryptoasymelgamalSlice, other : CryptoasymelgamalSlice) -> CryptoasymelgamalSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymelgamalSlice::copy(self : CryptoasymelgamalSlice) -> CryptoasymelgamalSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalSlice::fill(self : CryptoasymelgamalSlice, v : Double) -> CryptoasymelgamalSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymelgamalSlice::min(self : CryptoasymelgamalSlice) -> Double { @_common.min(self.data) }

pub fn CryptoasymelgamalSlice::max(self : CryptoasymelgamalSlice) -> Double { @_common.max(self.data) }

pub fn CryptoasymelgamalSlice::to_string(self : CryptoasymelgamalSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

