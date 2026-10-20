///===
/// extcore/crypto_hash_whirlpool

pub(all) struct CryptohashwhirlpoolPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_hash_whirlpool_make_point(x : Double, y : Double) -> CryptohashwhirlpoolPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_hash_whirlpool_make_point3(x : Double, y : Double, z : Double) -> CryptohashwhirlpoolPoint {
  { x, y, z, label: 0 }
}

pub fn CryptohashwhirlpoolPoint::x(self : CryptohashwhirlpoolPoint) -> Double { self.x }

pub fn CryptohashwhirlpoolPoint::y(self : CryptohashwhirlpoolPoint) -> Double { self.y }

pub fn CryptohashwhirlpoolPoint::z(self : CryptohashwhirlpoolPoint) -> Double { self.z }

pub fn CryptohashwhirlpoolPoint::label(self : CryptohashwhirlpoolPoint) -> Int { self.label }

pub fn CryptohashwhirlpoolPoint::dist(self : CryptohashwhirlpoolPoint, other : CryptohashwhirlpoolPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn CryptohashwhirlpoolPoint::add(self : CryptohashwhirlpoolPoint, other : CryptohashwhirlpoolPoint) -> CryptohashwhirlpoolPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn CryptohashwhirlpoolPoint::sub(self : CryptohashwhirlpoolPoint, other : CryptohashwhirlpoolPoint) -> CryptohashwhirlpoolPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn CryptohashwhirlpoolPoint::scale(self : CryptohashwhirlpoolPoint, s : Double) -> CryptohashwhirlpoolPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn CryptohashwhirlpoolPoint::dot(self : CryptohashwhirlpoolPoint, other : CryptohashwhirlpoolPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn CryptohashwhirlpoolPoint::cross(self : CryptohashwhirlpoolPoint, other : CryptohashwhirlpoolPoint) -> CryptohashwhirlpoolPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn CryptohashwhirlpoolPoint::norm(self : CryptohashwhirlpoolPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn CryptohashwhirlpoolPoint::normalize(self : CryptohashwhirlpoolPoint) -> CryptohashwhirlpoolPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptohashwhirlpoolPoint::negate(self : CryptohashwhirlpoolPoint) -> CryptohashwhirlpoolPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn CryptohashwhirlpoolPoint::mid(self : CryptohashwhirlpoolPoint, other : CryptohashwhirlpoolPoint) -> CryptohashwhirlpoolPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn CryptohashwhirlpoolPoint::lerp(self : CryptohashwhirlpoolPoint, other : CryptohashwhirlpoolPoint, t : Double) -> CryptohashwhirlpoolPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn CryptohashwhirlpoolPoint::to_string(self : CryptohashwhirlpoolPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct CryptohashwhirlpoolSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_hash_whirlpool_make_series(vals : Array[Double], name : String) -> CryptohashwhirlpoolSeries {
  { vals, name, meta: 0 }
}

pub fn CryptohashwhirlpoolSeries::len(self : CryptohashwhirlpoolSeries) -> Int { self.vals.length() }

pub fn CryptohashwhirlpoolSeries::sum(self : CryptohashwhirlpoolSeries) -> Double { @_common.sum(self.vals) }

pub fn CryptohashwhirlpoolSeries::mean(self : CryptohashwhirlpoolSeries) -> Double { @_common.mean(self.vals) }

pub fn CryptohashwhirlpoolSeries::min(self : CryptohashwhirlpoolSeries) -> Double { @_common.min(self.vals) }

pub fn CryptohashwhirlpoolSeries::max(self : CryptohashwhirlpoolSeries) -> Double { @_common.max(self.vals) }

pub fn CryptohashwhirlpoolSeries::range(self : CryptohashwhirlpoolSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn CryptohashwhirlpoolSeries::variance(self : CryptohashwhirlpoolSeries) -> Double { @_common.variance(self.vals) }

pub fn CryptohashwhirlpoolSeries::std(self : CryptohashwhirlpoolSeries) -> Double { @_common.std(self.vals) }

pub fn CryptohashwhirlpoolSeries::median(self : CryptohashwhirlpoolSeries) -> Double { @_common.median(self.vals) }

pub fn CryptohashwhirlpoolSeries::scale(self : CryptohashwhirlpoolSeries, f : Double) -> CryptohashwhirlpoolSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn CryptohashwhirlpoolSeries::add(self : CryptohashwhirlpoolSeries, other : CryptohashwhirlpoolSeries) -> CryptohashwhirlpoolSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn CryptohashwhirlpoolSeries::sub(self : CryptohashwhirlpoolSeries, other : CryptohashwhirlpoolSeries) -> CryptohashwhirlpoolSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn CryptohashwhirlpoolSeries::normalize(self : CryptohashwhirlpoolSeries) -> CryptohashwhirlpoolSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn CryptohashwhirlpoolSeries::cumsum(self : CryptohashwhirlpoolSeries) -> CryptohashwhirlpoolSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn CryptohashwhirlpoolSeries::to_string(self : CryptohashwhirlpoolSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptohashwhirlpoolMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_hash_whirlpool_make_matrix(rows : Int, cols : Int, val : Double) -> CryptohashwhirlpoolMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_hash_whirlpool_matrix_identity(n : Int) -> CryptohashwhirlpoolMatrix {
  let m = crypto_hash_whirlpool_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn CryptohashwhirlpoolMatrix::get(self : CryptohashwhirlpoolMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn CryptohashwhirlpoolMatrix::transpose(self : CryptohashwhirlpoolMatrix) -> CryptohashwhirlpoolMatrix {
  let result = crypto_hash_whirlpool_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn CryptohashwhirlpoolMatrix::add(self : CryptohashwhirlpoolMatrix, other : CryptohashwhirlpoolMatrix) -> CryptohashwhirlpoolMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_hash_whirlpool_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn CryptohashwhirlpoolMatrix::scale(self : CryptohashwhirlpoolMatrix, s : Double) -> CryptohashwhirlpoolMatrix {
  let result = crypto_hash_whirlpool_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn CryptohashwhirlpoolMatrix::multiply(self : CryptohashwhirlpoolMatrix, other : CryptohashwhirlpoolMatrix) -> CryptohashwhirlpoolMatrix {
  if self.cols != other.rows { return crypto_hash_whirlpool_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_hash_whirlpool_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn CryptohashwhirlpoolMatrix::trace(self : CryptohashwhirlpoolMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn CryptohashwhirlpoolMatrix::det(self : CryptohashwhirlpoolMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn CryptohashwhirlpoolMatrix::norm(self : CryptohashwhirlpoolMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn CryptohashwhirlpoolMatrix::to_string(self : CryptohashwhirlpoolMatrix) -> String {
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

pub(all) struct CryptohashwhirlpoolVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_hash_whirlpool_make_vector(comps : Array[Double]) -> CryptohashwhirlpoolVector {
  { comps, dim: comps.length() }
}

pub fn crypto_hash_whirlpool_vector_zero(dim : Int) -> CryptohashwhirlpoolVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn CryptohashwhirlpoolVector::add(self : CryptohashwhirlpoolVector, other : CryptohashwhirlpoolVector) -> CryptohashwhirlpoolVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn CryptohashwhirlpoolVector::sub(self : CryptohashwhirlpoolVector, other : CryptohashwhirlpoolVector) -> CryptohashwhirlpoolVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn CryptohashwhirlpoolVector::scale(self : CryptohashwhirlpoolVector, s : Double) -> CryptohashwhirlpoolVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn CryptohashwhirlpoolVector::dot(self : CryptohashwhirlpoolVector, other : CryptohashwhirlpoolVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn CryptohashwhirlpoolVector::norm(self : CryptohashwhirlpoolVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn CryptohashwhirlpoolVector::normalize(self : CryptohashwhirlpoolVector) -> CryptohashwhirlpoolVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptohashwhirlpoolVector::dist(self : CryptohashwhirlpoolVector, other : CryptohashwhirlpoolVector) -> Double {
  self.sub(other).norm()
}

pub fn CryptohashwhirlpoolVector::to_string(self : CryptohashwhirlpoolVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptohashwhirlpoolFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_whirlpool_frame_make(size : Int) -> CryptohashwhirlpoolFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptohashwhirlpoolFrame::len(self : CryptohashwhirlpoolFrame) -> Int { self.size }

pub fn CryptohashwhirlpoolFrame::get(self : CryptohashwhirlpoolFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptohashwhirlpoolFrame::set(self : CryptohashwhirlpoolFrame, i : Int, v : Double) -> CryptohashwhirlpoolFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolFrame::sum(self : CryptohashwhirlpoolFrame) -> Double { @_common.sum(self.data) }

pub fn CryptohashwhirlpoolFrame::mean(self : CryptohashwhirlpoolFrame) -> Double { @_common.mean(self.data) }

pub fn CryptohashwhirlpoolFrame::scale(self : CryptohashwhirlpoolFrame, f : Double) -> CryptohashwhirlpoolFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolFrame::add(self : CryptohashwhirlpoolFrame, other : CryptohashwhirlpoolFrame) -> CryptohashwhirlpoolFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptohashwhirlpoolFrame::copy(self : CryptohashwhirlpoolFrame) -> CryptohashwhirlpoolFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolFrame::fill(self : CryptohashwhirlpoolFrame, v : Double) -> CryptohashwhirlpoolFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolFrame::min(self : CryptohashwhirlpoolFrame) -> Double { @_common.min(self.data) }

pub fn CryptohashwhirlpoolFrame::max(self : CryptohashwhirlpoolFrame) -> Double { @_common.max(self.data) }

pub fn CryptohashwhirlpoolFrame::to_string(self : CryptohashwhirlpoolFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptohashwhirlpoolTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_whirlpool_table_make(size : Int) -> CryptohashwhirlpoolTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptohashwhirlpoolTable::len(self : CryptohashwhirlpoolTable) -> Int { self.size }

pub fn CryptohashwhirlpoolTable::get(self : CryptohashwhirlpoolTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptohashwhirlpoolTable::set(self : CryptohashwhirlpoolTable, i : Int, v : Double) -> CryptohashwhirlpoolTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolTable::sum(self : CryptohashwhirlpoolTable) -> Double { @_common.sum(self.data) }

pub fn CryptohashwhirlpoolTable::mean(self : CryptohashwhirlpoolTable) -> Double { @_common.mean(self.data) }

pub fn CryptohashwhirlpoolTable::scale(self : CryptohashwhirlpoolTable, f : Double) -> CryptohashwhirlpoolTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolTable::add(self : CryptohashwhirlpoolTable, other : CryptohashwhirlpoolTable) -> CryptohashwhirlpoolTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptohashwhirlpoolTable::copy(self : CryptohashwhirlpoolTable) -> CryptohashwhirlpoolTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolTable::fill(self : CryptohashwhirlpoolTable, v : Double) -> CryptohashwhirlpoolTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolTable::min(self : CryptohashwhirlpoolTable) -> Double { @_common.min(self.data) }

pub fn CryptohashwhirlpoolTable::max(self : CryptohashwhirlpoolTable) -> Double { @_common.max(self.data) }

pub fn CryptohashwhirlpoolTable::to_string(self : CryptohashwhirlpoolTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptohashwhirlpoolGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_whirlpool_graphn_make(size : Int) -> CryptohashwhirlpoolGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptohashwhirlpoolGraphN::len(self : CryptohashwhirlpoolGraphN) -> Int { self.size }

pub fn CryptohashwhirlpoolGraphN::get(self : CryptohashwhirlpoolGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptohashwhirlpoolGraphN::set(self : CryptohashwhirlpoolGraphN, i : Int, v : Double) -> CryptohashwhirlpoolGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolGraphN::sum(self : CryptohashwhirlpoolGraphN) -> Double { @_common.sum(self.data) }

pub fn CryptohashwhirlpoolGraphN::mean(self : CryptohashwhirlpoolGraphN) -> Double { @_common.mean(self.data) }

pub fn CryptohashwhirlpoolGraphN::scale(self : CryptohashwhirlpoolGraphN, f : Double) -> CryptohashwhirlpoolGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolGraphN::add(self : CryptohashwhirlpoolGraphN, other : CryptohashwhirlpoolGraphN) -> CryptohashwhirlpoolGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptohashwhirlpoolGraphN::copy(self : CryptohashwhirlpoolGraphN) -> CryptohashwhirlpoolGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolGraphN::fill(self : CryptohashwhirlpoolGraphN, v : Double) -> CryptohashwhirlpoolGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolGraphN::min(self : CryptohashwhirlpoolGraphN) -> Double { @_common.min(self.data) }

pub fn CryptohashwhirlpoolGraphN::max(self : CryptohashwhirlpoolGraphN) -> Double { @_common.max(self.data) }

pub fn CryptohashwhirlpoolGraphN::to_string(self : CryptohashwhirlpoolGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptohashwhirlpoolNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_whirlpool_node_make(size : Int) -> CryptohashwhirlpoolNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptohashwhirlpoolNode::len(self : CryptohashwhirlpoolNode) -> Int { self.size }

pub fn CryptohashwhirlpoolNode::get(self : CryptohashwhirlpoolNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptohashwhirlpoolNode::set(self : CryptohashwhirlpoolNode, i : Int, v : Double) -> CryptohashwhirlpoolNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolNode::sum(self : CryptohashwhirlpoolNode) -> Double { @_common.sum(self.data) }

pub fn CryptohashwhirlpoolNode::mean(self : CryptohashwhirlpoolNode) -> Double { @_common.mean(self.data) }

pub fn CryptohashwhirlpoolNode::scale(self : CryptohashwhirlpoolNode, f : Double) -> CryptohashwhirlpoolNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolNode::add(self : CryptohashwhirlpoolNode, other : CryptohashwhirlpoolNode) -> CryptohashwhirlpoolNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptohashwhirlpoolNode::copy(self : CryptohashwhirlpoolNode) -> CryptohashwhirlpoolNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolNode::fill(self : CryptohashwhirlpoolNode, v : Double) -> CryptohashwhirlpoolNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolNode::min(self : CryptohashwhirlpoolNode) -> Double { @_common.min(self.data) }

pub fn CryptohashwhirlpoolNode::max(self : CryptohashwhirlpoolNode) -> Double { @_common.max(self.data) }

pub fn CryptohashwhirlpoolNode::to_string(self : CryptohashwhirlpoolNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptohashwhirlpoolEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_whirlpool_edge_make(size : Int) -> CryptohashwhirlpoolEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptohashwhirlpoolEdge::len(self : CryptohashwhirlpoolEdge) -> Int { self.size }

pub fn CryptohashwhirlpoolEdge::get(self : CryptohashwhirlpoolEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptohashwhirlpoolEdge::set(self : CryptohashwhirlpoolEdge, i : Int, v : Double) -> CryptohashwhirlpoolEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolEdge::sum(self : CryptohashwhirlpoolEdge) -> Double { @_common.sum(self.data) }

pub fn CryptohashwhirlpoolEdge::mean(self : CryptohashwhirlpoolEdge) -> Double { @_common.mean(self.data) }

pub fn CryptohashwhirlpoolEdge::scale(self : CryptohashwhirlpoolEdge, f : Double) -> CryptohashwhirlpoolEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolEdge::add(self : CryptohashwhirlpoolEdge, other : CryptohashwhirlpoolEdge) -> CryptohashwhirlpoolEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptohashwhirlpoolEdge::copy(self : CryptohashwhirlpoolEdge) -> CryptohashwhirlpoolEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolEdge::fill(self : CryptohashwhirlpoolEdge, v : Double) -> CryptohashwhirlpoolEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolEdge::min(self : CryptohashwhirlpoolEdge) -> Double { @_common.min(self.data) }

pub fn CryptohashwhirlpoolEdge::max(self : CryptohashwhirlpoolEdge) -> Double { @_common.max(self.data) }

pub fn CryptohashwhirlpoolEdge::to_string(self : CryptohashwhirlpoolEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptohashwhirlpoolPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_whirlpool_path_make(size : Int) -> CryptohashwhirlpoolPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptohashwhirlpoolPath::len(self : CryptohashwhirlpoolPath) -> Int { self.size }

pub fn CryptohashwhirlpoolPath::get(self : CryptohashwhirlpoolPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptohashwhirlpoolPath::set(self : CryptohashwhirlpoolPath, i : Int, v : Double) -> CryptohashwhirlpoolPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolPath::sum(self : CryptohashwhirlpoolPath) -> Double { @_common.sum(self.data) }

pub fn CryptohashwhirlpoolPath::mean(self : CryptohashwhirlpoolPath) -> Double { @_common.mean(self.data) }

pub fn CryptohashwhirlpoolPath::scale(self : CryptohashwhirlpoolPath, f : Double) -> CryptohashwhirlpoolPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolPath::add(self : CryptohashwhirlpoolPath, other : CryptohashwhirlpoolPath) -> CryptohashwhirlpoolPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptohashwhirlpoolPath::copy(self : CryptohashwhirlpoolPath) -> CryptohashwhirlpoolPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolPath::fill(self : CryptohashwhirlpoolPath, v : Double) -> CryptohashwhirlpoolPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolPath::min(self : CryptohashwhirlpoolPath) -> Double { @_common.min(self.data) }

pub fn CryptohashwhirlpoolPath::max(self : CryptohashwhirlpoolPath) -> Double { @_common.max(self.data) }

pub fn CryptohashwhirlpoolPath::to_string(self : CryptohashwhirlpoolPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptohashwhirlpoolCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_whirlpool_cluster_make(size : Int) -> CryptohashwhirlpoolCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptohashwhirlpoolCluster::len(self : CryptohashwhirlpoolCluster) -> Int { self.size }

pub fn CryptohashwhirlpoolCluster::get(self : CryptohashwhirlpoolCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptohashwhirlpoolCluster::set(self : CryptohashwhirlpoolCluster, i : Int, v : Double) -> CryptohashwhirlpoolCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolCluster::sum(self : CryptohashwhirlpoolCluster) -> Double { @_common.sum(self.data) }

pub fn CryptohashwhirlpoolCluster::mean(self : CryptohashwhirlpoolCluster) -> Double { @_common.mean(self.data) }

pub fn CryptohashwhirlpoolCluster::scale(self : CryptohashwhirlpoolCluster, f : Double) -> CryptohashwhirlpoolCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolCluster::add(self : CryptohashwhirlpoolCluster, other : CryptohashwhirlpoolCluster) -> CryptohashwhirlpoolCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptohashwhirlpoolCluster::copy(self : CryptohashwhirlpoolCluster) -> CryptohashwhirlpoolCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolCluster::fill(self : CryptohashwhirlpoolCluster, v : Double) -> CryptohashwhirlpoolCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolCluster::min(self : CryptohashwhirlpoolCluster) -> Double { @_common.min(self.data) }

pub fn CryptohashwhirlpoolCluster::max(self : CryptohashwhirlpoolCluster) -> Double { @_common.max(self.data) }

pub fn CryptohashwhirlpoolCluster::to_string(self : CryptohashwhirlpoolCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptohashwhirlpoolModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_whirlpool_model_make(size : Int) -> CryptohashwhirlpoolModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptohashwhirlpoolModel::len(self : CryptohashwhirlpoolModel) -> Int { self.size }

pub fn CryptohashwhirlpoolModel::get(self : CryptohashwhirlpoolModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptohashwhirlpoolModel::set(self : CryptohashwhirlpoolModel, i : Int, v : Double) -> CryptohashwhirlpoolModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolModel::sum(self : CryptohashwhirlpoolModel) -> Double { @_common.sum(self.data) }

pub fn CryptohashwhirlpoolModel::mean(self : CryptohashwhirlpoolModel) -> Double { @_common.mean(self.data) }

pub fn CryptohashwhirlpoolModel::scale(self : CryptohashwhirlpoolModel, f : Double) -> CryptohashwhirlpoolModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolModel::add(self : CryptohashwhirlpoolModel, other : CryptohashwhirlpoolModel) -> CryptohashwhirlpoolModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptohashwhirlpoolModel::copy(self : CryptohashwhirlpoolModel) -> CryptohashwhirlpoolModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolModel::fill(self : CryptohashwhirlpoolModel, v : Double) -> CryptohashwhirlpoolModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolModel::min(self : CryptohashwhirlpoolModel) -> Double { @_common.min(self.data) }

pub fn CryptohashwhirlpoolModel::max(self : CryptohashwhirlpoolModel) -> Double { @_common.max(self.data) }

pub fn CryptohashwhirlpoolModel::to_string(self : CryptohashwhirlpoolModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptohashwhirlpoolLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_whirlpool_layer_make(size : Int) -> CryptohashwhirlpoolLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptohashwhirlpoolLayer::len(self : CryptohashwhirlpoolLayer) -> Int { self.size }

pub fn CryptohashwhirlpoolLayer::get(self : CryptohashwhirlpoolLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptohashwhirlpoolLayer::set(self : CryptohashwhirlpoolLayer, i : Int, v : Double) -> CryptohashwhirlpoolLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolLayer::sum(self : CryptohashwhirlpoolLayer) -> Double { @_common.sum(self.data) }

pub fn CryptohashwhirlpoolLayer::mean(self : CryptohashwhirlpoolLayer) -> Double { @_common.mean(self.data) }

pub fn CryptohashwhirlpoolLayer::scale(self : CryptohashwhirlpoolLayer, f : Double) -> CryptohashwhirlpoolLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolLayer::add(self : CryptohashwhirlpoolLayer, other : CryptohashwhirlpoolLayer) -> CryptohashwhirlpoolLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptohashwhirlpoolLayer::copy(self : CryptohashwhirlpoolLayer) -> CryptohashwhirlpoolLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolLayer::fill(self : CryptohashwhirlpoolLayer, v : Double) -> CryptohashwhirlpoolLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolLayer::min(self : CryptohashwhirlpoolLayer) -> Double { @_common.min(self.data) }

pub fn CryptohashwhirlpoolLayer::max(self : CryptohashwhirlpoolLayer) -> Double { @_common.max(self.data) }

pub fn CryptohashwhirlpoolLayer::to_string(self : CryptohashwhirlpoolLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptohashwhirlpoolBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_whirlpool_buffer_make(size : Int) -> CryptohashwhirlpoolBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptohashwhirlpoolBuffer::len(self : CryptohashwhirlpoolBuffer) -> Int { self.size }

pub fn CryptohashwhirlpoolBuffer::get(self : CryptohashwhirlpoolBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptohashwhirlpoolBuffer::set(self : CryptohashwhirlpoolBuffer, i : Int, v : Double) -> CryptohashwhirlpoolBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolBuffer::sum(self : CryptohashwhirlpoolBuffer) -> Double { @_common.sum(self.data) }

pub fn CryptohashwhirlpoolBuffer::mean(self : CryptohashwhirlpoolBuffer) -> Double { @_common.mean(self.data) }

pub fn CryptohashwhirlpoolBuffer::scale(self : CryptohashwhirlpoolBuffer, f : Double) -> CryptohashwhirlpoolBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolBuffer::add(self : CryptohashwhirlpoolBuffer, other : CryptohashwhirlpoolBuffer) -> CryptohashwhirlpoolBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptohashwhirlpoolBuffer::copy(self : CryptohashwhirlpoolBuffer) -> CryptohashwhirlpoolBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolBuffer::fill(self : CryptohashwhirlpoolBuffer, v : Double) -> CryptohashwhirlpoolBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolBuffer::min(self : CryptohashwhirlpoolBuffer) -> Double { @_common.min(self.data) }

pub fn CryptohashwhirlpoolBuffer::max(self : CryptohashwhirlpoolBuffer) -> Double { @_common.max(self.data) }

pub fn CryptohashwhirlpoolBuffer::to_string(self : CryptohashwhirlpoolBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptohashwhirlpoolCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_whirlpool_cursor_make(size : Int) -> CryptohashwhirlpoolCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptohashwhirlpoolCursor::len(self : CryptohashwhirlpoolCursor) -> Int { self.size }

pub fn CryptohashwhirlpoolCursor::get(self : CryptohashwhirlpoolCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptohashwhirlpoolCursor::set(self : CryptohashwhirlpoolCursor, i : Int, v : Double) -> CryptohashwhirlpoolCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolCursor::sum(self : CryptohashwhirlpoolCursor) -> Double { @_common.sum(self.data) }

pub fn CryptohashwhirlpoolCursor::mean(self : CryptohashwhirlpoolCursor) -> Double { @_common.mean(self.data) }

pub fn CryptohashwhirlpoolCursor::scale(self : CryptohashwhirlpoolCursor, f : Double) -> CryptohashwhirlpoolCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolCursor::add(self : CryptohashwhirlpoolCursor, other : CryptohashwhirlpoolCursor) -> CryptohashwhirlpoolCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptohashwhirlpoolCursor::copy(self : CryptohashwhirlpoolCursor) -> CryptohashwhirlpoolCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolCursor::fill(self : CryptohashwhirlpoolCursor, v : Double) -> CryptohashwhirlpoolCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolCursor::min(self : CryptohashwhirlpoolCursor) -> Double { @_common.min(self.data) }

pub fn CryptohashwhirlpoolCursor::max(self : CryptohashwhirlpoolCursor) -> Double { @_common.max(self.data) }

pub fn CryptohashwhirlpoolCursor::to_string(self : CryptohashwhirlpoolCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptohashwhirlpoolView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_whirlpool_view_make(size : Int) -> CryptohashwhirlpoolView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptohashwhirlpoolView::len(self : CryptohashwhirlpoolView) -> Int { self.size }

pub fn CryptohashwhirlpoolView::get(self : CryptohashwhirlpoolView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptohashwhirlpoolView::set(self : CryptohashwhirlpoolView, i : Int, v : Double) -> CryptohashwhirlpoolView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolView::sum(self : CryptohashwhirlpoolView) -> Double { @_common.sum(self.data) }

pub fn CryptohashwhirlpoolView::mean(self : CryptohashwhirlpoolView) -> Double { @_common.mean(self.data) }

pub fn CryptohashwhirlpoolView::scale(self : CryptohashwhirlpoolView, f : Double) -> CryptohashwhirlpoolView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolView::add(self : CryptohashwhirlpoolView, other : CryptohashwhirlpoolView) -> CryptohashwhirlpoolView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptohashwhirlpoolView::copy(self : CryptohashwhirlpoolView) -> CryptohashwhirlpoolView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolView::fill(self : CryptohashwhirlpoolView, v : Double) -> CryptohashwhirlpoolView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolView::min(self : CryptohashwhirlpoolView) -> Double { @_common.min(self.data) }

pub fn CryptohashwhirlpoolView::max(self : CryptohashwhirlpoolView) -> Double { @_common.max(self.data) }

pub fn CryptohashwhirlpoolView::to_string(self : CryptohashwhirlpoolView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptohashwhirlpoolRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_whirlpool_range_make(size : Int) -> CryptohashwhirlpoolRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptohashwhirlpoolRange::len(self : CryptohashwhirlpoolRange) -> Int { self.size }

pub fn CryptohashwhirlpoolRange::get(self : CryptohashwhirlpoolRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptohashwhirlpoolRange::set(self : CryptohashwhirlpoolRange, i : Int, v : Double) -> CryptohashwhirlpoolRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolRange::sum(self : CryptohashwhirlpoolRange) -> Double { @_common.sum(self.data) }

pub fn CryptohashwhirlpoolRange::mean(self : CryptohashwhirlpoolRange) -> Double { @_common.mean(self.data) }

pub fn CryptohashwhirlpoolRange::scale(self : CryptohashwhirlpoolRange, f : Double) -> CryptohashwhirlpoolRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolRange::add(self : CryptohashwhirlpoolRange, other : CryptohashwhirlpoolRange) -> CryptohashwhirlpoolRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptohashwhirlpoolRange::copy(self : CryptohashwhirlpoolRange) -> CryptohashwhirlpoolRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolRange::fill(self : CryptohashwhirlpoolRange, v : Double) -> CryptohashwhirlpoolRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolRange::min(self : CryptohashwhirlpoolRange) -> Double { @_common.min(self.data) }

pub fn CryptohashwhirlpoolRange::max(self : CryptohashwhirlpoolRange) -> Double { @_common.max(self.data) }

pub fn CryptohashwhirlpoolRange::to_string(self : CryptohashwhirlpoolRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptohashwhirlpoolSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_whirlpool_slice_make(size : Int) -> CryptohashwhirlpoolSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptohashwhirlpoolSlice::len(self : CryptohashwhirlpoolSlice) -> Int { self.size }

pub fn CryptohashwhirlpoolSlice::get(self : CryptohashwhirlpoolSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptohashwhirlpoolSlice::set(self : CryptohashwhirlpoolSlice, i : Int, v : Double) -> CryptohashwhirlpoolSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolSlice::sum(self : CryptohashwhirlpoolSlice) -> Double { @_common.sum(self.data) }

pub fn CryptohashwhirlpoolSlice::mean(self : CryptohashwhirlpoolSlice) -> Double { @_common.mean(self.data) }

pub fn CryptohashwhirlpoolSlice::scale(self : CryptohashwhirlpoolSlice, f : Double) -> CryptohashwhirlpoolSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolSlice::add(self : CryptohashwhirlpoolSlice, other : CryptohashwhirlpoolSlice) -> CryptohashwhirlpoolSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptohashwhirlpoolSlice::copy(self : CryptohashwhirlpoolSlice) -> CryptohashwhirlpoolSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolSlice::fill(self : CryptohashwhirlpoolSlice, v : Double) -> CryptohashwhirlpoolSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptohashwhirlpoolSlice::min(self : CryptohashwhirlpoolSlice) -> Double { @_common.min(self.data) }

pub fn CryptohashwhirlpoolSlice::max(self : CryptohashwhirlpoolSlice) -> Double { @_common.max(self.data) }

pub fn CryptohashwhirlpoolSlice::to_string(self : CryptohashwhirlpoolSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

