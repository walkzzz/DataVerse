///===
/// extcore/crypto_hash_groestl

pub(all) struct CryptohashgroestlPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_hash_groestl_make_point(x : Double, y : Double) -> CryptohashgroestlPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_hash_groestl_make_point3(x : Double, y : Double, z : Double) -> CryptohashgroestlPoint {
  { x, y, z, label: 0 }
}

pub fn CryptohashgroestlPoint::x(self : CryptohashgroestlPoint) -> Double { self.x }

pub fn CryptohashgroestlPoint::y(self : CryptohashgroestlPoint) -> Double { self.y }

pub fn CryptohashgroestlPoint::z(self : CryptohashgroestlPoint) -> Double { self.z }

pub fn CryptohashgroestlPoint::label(self : CryptohashgroestlPoint) -> Int { self.label }

pub fn CryptohashgroestlPoint::dist(self : CryptohashgroestlPoint, other : CryptohashgroestlPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn CryptohashgroestlPoint::add(self : CryptohashgroestlPoint, other : CryptohashgroestlPoint) -> CryptohashgroestlPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn CryptohashgroestlPoint::sub(self : CryptohashgroestlPoint, other : CryptohashgroestlPoint) -> CryptohashgroestlPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn CryptohashgroestlPoint::scale(self : CryptohashgroestlPoint, s : Double) -> CryptohashgroestlPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn CryptohashgroestlPoint::dot(self : CryptohashgroestlPoint, other : CryptohashgroestlPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn CryptohashgroestlPoint::cross(self : CryptohashgroestlPoint, other : CryptohashgroestlPoint) -> CryptohashgroestlPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn CryptohashgroestlPoint::norm(self : CryptohashgroestlPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn CryptohashgroestlPoint::normalize(self : CryptohashgroestlPoint) -> CryptohashgroestlPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptohashgroestlPoint::negate(self : CryptohashgroestlPoint) -> CryptohashgroestlPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn CryptohashgroestlPoint::mid(self : CryptohashgroestlPoint, other : CryptohashgroestlPoint) -> CryptohashgroestlPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn CryptohashgroestlPoint::lerp(self : CryptohashgroestlPoint, other : CryptohashgroestlPoint, t : Double) -> CryptohashgroestlPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn CryptohashgroestlPoint::to_string(self : CryptohashgroestlPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct CryptohashgroestlSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_hash_groestl_make_series(vals : Array[Double], name : String) -> CryptohashgroestlSeries {
  { vals, name, meta: 0 }
}

pub fn CryptohashgroestlSeries::len(self : CryptohashgroestlSeries) -> Int { self.vals.length() }

pub fn CryptohashgroestlSeries::sum(self : CryptohashgroestlSeries) -> Double { @_common.sum(self.vals) }

pub fn CryptohashgroestlSeries::mean(self : CryptohashgroestlSeries) -> Double { @_common.mean(self.vals) }

pub fn CryptohashgroestlSeries::min(self : CryptohashgroestlSeries) -> Double { @_common.min(self.vals) }

pub fn CryptohashgroestlSeries::max(self : CryptohashgroestlSeries) -> Double { @_common.max(self.vals) }

pub fn CryptohashgroestlSeries::range(self : CryptohashgroestlSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn CryptohashgroestlSeries::variance(self : CryptohashgroestlSeries) -> Double { @_common.variance(self.vals) }

pub fn CryptohashgroestlSeries::std(self : CryptohashgroestlSeries) -> Double { @_common.std(self.vals) }

pub fn CryptohashgroestlSeries::median(self : CryptohashgroestlSeries) -> Double { @_common.median(self.vals) }

pub fn CryptohashgroestlSeries::scale(self : CryptohashgroestlSeries, f : Double) -> CryptohashgroestlSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn CryptohashgroestlSeries::add(self : CryptohashgroestlSeries, other : CryptohashgroestlSeries) -> CryptohashgroestlSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn CryptohashgroestlSeries::sub(self : CryptohashgroestlSeries, other : CryptohashgroestlSeries) -> CryptohashgroestlSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn CryptohashgroestlSeries::normalize(self : CryptohashgroestlSeries) -> CryptohashgroestlSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn CryptohashgroestlSeries::cumsum(self : CryptohashgroestlSeries) -> CryptohashgroestlSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn CryptohashgroestlSeries::to_string(self : CryptohashgroestlSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptohashgroestlMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_hash_groestl_make_matrix(rows : Int, cols : Int, val : Double) -> CryptohashgroestlMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_hash_groestl_matrix_identity(n : Int) -> CryptohashgroestlMatrix {
  let m = crypto_hash_groestl_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn CryptohashgroestlMatrix::get(self : CryptohashgroestlMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn CryptohashgroestlMatrix::transpose(self : CryptohashgroestlMatrix) -> CryptohashgroestlMatrix {
  let result = crypto_hash_groestl_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn CryptohashgroestlMatrix::add(self : CryptohashgroestlMatrix, other : CryptohashgroestlMatrix) -> CryptohashgroestlMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_hash_groestl_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn CryptohashgroestlMatrix::scale(self : CryptohashgroestlMatrix, s : Double) -> CryptohashgroestlMatrix {
  let result = crypto_hash_groestl_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn CryptohashgroestlMatrix::multiply(self : CryptohashgroestlMatrix, other : CryptohashgroestlMatrix) -> CryptohashgroestlMatrix {
  if self.cols != other.rows { return crypto_hash_groestl_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_hash_groestl_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn CryptohashgroestlMatrix::trace(self : CryptohashgroestlMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn CryptohashgroestlMatrix::det(self : CryptohashgroestlMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn CryptohashgroestlMatrix::norm(self : CryptohashgroestlMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn CryptohashgroestlMatrix::to_string(self : CryptohashgroestlMatrix) -> String {
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

pub(all) struct CryptohashgroestlVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_hash_groestl_make_vector(comps : Array[Double]) -> CryptohashgroestlVector {
  { comps, dim: comps.length() }
}

pub fn crypto_hash_groestl_vector_zero(dim : Int) -> CryptohashgroestlVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn CryptohashgroestlVector::add(self : CryptohashgroestlVector, other : CryptohashgroestlVector) -> CryptohashgroestlVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn CryptohashgroestlVector::sub(self : CryptohashgroestlVector, other : CryptohashgroestlVector) -> CryptohashgroestlVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn CryptohashgroestlVector::scale(self : CryptohashgroestlVector, s : Double) -> CryptohashgroestlVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn CryptohashgroestlVector::dot(self : CryptohashgroestlVector, other : CryptohashgroestlVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn CryptohashgroestlVector::norm(self : CryptohashgroestlVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn CryptohashgroestlVector::normalize(self : CryptohashgroestlVector) -> CryptohashgroestlVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptohashgroestlVector::dist(self : CryptohashgroestlVector, other : CryptohashgroestlVector) -> Double {
  self.sub(other).norm()
}

pub fn CryptohashgroestlVector::to_string(self : CryptohashgroestlVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptohashgroestlFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_groestl_frame_make(size : Int) -> CryptohashgroestlFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptohashgroestlFrame::len(self : CryptohashgroestlFrame) -> Int { self.size }

pub fn CryptohashgroestlFrame::get(self : CryptohashgroestlFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptohashgroestlFrame::set(self : CryptohashgroestlFrame, i : Int, v : Double) -> CryptohashgroestlFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlFrame::sum(self : CryptohashgroestlFrame) -> Double { @_common.sum(self.data) }

pub fn CryptohashgroestlFrame::mean(self : CryptohashgroestlFrame) -> Double { @_common.mean(self.data) }

pub fn CryptohashgroestlFrame::scale(self : CryptohashgroestlFrame, f : Double) -> CryptohashgroestlFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlFrame::add(self : CryptohashgroestlFrame, other : CryptohashgroestlFrame) -> CryptohashgroestlFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptohashgroestlFrame::copy(self : CryptohashgroestlFrame) -> CryptohashgroestlFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlFrame::fill(self : CryptohashgroestlFrame, v : Double) -> CryptohashgroestlFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlFrame::min(self : CryptohashgroestlFrame) -> Double { @_common.min(self.data) }

pub fn CryptohashgroestlFrame::max(self : CryptohashgroestlFrame) -> Double { @_common.max(self.data) }

pub fn CryptohashgroestlFrame::to_string(self : CryptohashgroestlFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptohashgroestlTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_groestl_table_make(size : Int) -> CryptohashgroestlTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptohashgroestlTable::len(self : CryptohashgroestlTable) -> Int { self.size }

pub fn CryptohashgroestlTable::get(self : CryptohashgroestlTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptohashgroestlTable::set(self : CryptohashgroestlTable, i : Int, v : Double) -> CryptohashgroestlTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlTable::sum(self : CryptohashgroestlTable) -> Double { @_common.sum(self.data) }

pub fn CryptohashgroestlTable::mean(self : CryptohashgroestlTable) -> Double { @_common.mean(self.data) }

pub fn CryptohashgroestlTable::scale(self : CryptohashgroestlTable, f : Double) -> CryptohashgroestlTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlTable::add(self : CryptohashgroestlTable, other : CryptohashgroestlTable) -> CryptohashgroestlTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptohashgroestlTable::copy(self : CryptohashgroestlTable) -> CryptohashgroestlTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlTable::fill(self : CryptohashgroestlTable, v : Double) -> CryptohashgroestlTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlTable::min(self : CryptohashgroestlTable) -> Double { @_common.min(self.data) }

pub fn CryptohashgroestlTable::max(self : CryptohashgroestlTable) -> Double { @_common.max(self.data) }

pub fn CryptohashgroestlTable::to_string(self : CryptohashgroestlTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptohashgroestlGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_groestl_graphn_make(size : Int) -> CryptohashgroestlGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptohashgroestlGraphN::len(self : CryptohashgroestlGraphN) -> Int { self.size }

pub fn CryptohashgroestlGraphN::get(self : CryptohashgroestlGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptohashgroestlGraphN::set(self : CryptohashgroestlGraphN, i : Int, v : Double) -> CryptohashgroestlGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlGraphN::sum(self : CryptohashgroestlGraphN) -> Double { @_common.sum(self.data) }

pub fn CryptohashgroestlGraphN::mean(self : CryptohashgroestlGraphN) -> Double { @_common.mean(self.data) }

pub fn CryptohashgroestlGraphN::scale(self : CryptohashgroestlGraphN, f : Double) -> CryptohashgroestlGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlGraphN::add(self : CryptohashgroestlGraphN, other : CryptohashgroestlGraphN) -> CryptohashgroestlGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptohashgroestlGraphN::copy(self : CryptohashgroestlGraphN) -> CryptohashgroestlGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlGraphN::fill(self : CryptohashgroestlGraphN, v : Double) -> CryptohashgroestlGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlGraphN::min(self : CryptohashgroestlGraphN) -> Double { @_common.min(self.data) }

pub fn CryptohashgroestlGraphN::max(self : CryptohashgroestlGraphN) -> Double { @_common.max(self.data) }

pub fn CryptohashgroestlGraphN::to_string(self : CryptohashgroestlGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptohashgroestlNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_groestl_node_make(size : Int) -> CryptohashgroestlNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptohashgroestlNode::len(self : CryptohashgroestlNode) -> Int { self.size }

pub fn CryptohashgroestlNode::get(self : CryptohashgroestlNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptohashgroestlNode::set(self : CryptohashgroestlNode, i : Int, v : Double) -> CryptohashgroestlNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlNode::sum(self : CryptohashgroestlNode) -> Double { @_common.sum(self.data) }

pub fn CryptohashgroestlNode::mean(self : CryptohashgroestlNode) -> Double { @_common.mean(self.data) }

pub fn CryptohashgroestlNode::scale(self : CryptohashgroestlNode, f : Double) -> CryptohashgroestlNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlNode::add(self : CryptohashgroestlNode, other : CryptohashgroestlNode) -> CryptohashgroestlNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptohashgroestlNode::copy(self : CryptohashgroestlNode) -> CryptohashgroestlNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlNode::fill(self : CryptohashgroestlNode, v : Double) -> CryptohashgroestlNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlNode::min(self : CryptohashgroestlNode) -> Double { @_common.min(self.data) }

pub fn CryptohashgroestlNode::max(self : CryptohashgroestlNode) -> Double { @_common.max(self.data) }

pub fn CryptohashgroestlNode::to_string(self : CryptohashgroestlNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptohashgroestlEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_groestl_edge_make(size : Int) -> CryptohashgroestlEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptohashgroestlEdge::len(self : CryptohashgroestlEdge) -> Int { self.size }

pub fn CryptohashgroestlEdge::get(self : CryptohashgroestlEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptohashgroestlEdge::set(self : CryptohashgroestlEdge, i : Int, v : Double) -> CryptohashgroestlEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlEdge::sum(self : CryptohashgroestlEdge) -> Double { @_common.sum(self.data) }

pub fn CryptohashgroestlEdge::mean(self : CryptohashgroestlEdge) -> Double { @_common.mean(self.data) }

pub fn CryptohashgroestlEdge::scale(self : CryptohashgroestlEdge, f : Double) -> CryptohashgroestlEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlEdge::add(self : CryptohashgroestlEdge, other : CryptohashgroestlEdge) -> CryptohashgroestlEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptohashgroestlEdge::copy(self : CryptohashgroestlEdge) -> CryptohashgroestlEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlEdge::fill(self : CryptohashgroestlEdge, v : Double) -> CryptohashgroestlEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlEdge::min(self : CryptohashgroestlEdge) -> Double { @_common.min(self.data) }

pub fn CryptohashgroestlEdge::max(self : CryptohashgroestlEdge) -> Double { @_common.max(self.data) }

pub fn CryptohashgroestlEdge::to_string(self : CryptohashgroestlEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptohashgroestlPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_groestl_path_make(size : Int) -> CryptohashgroestlPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptohashgroestlPath::len(self : CryptohashgroestlPath) -> Int { self.size }

pub fn CryptohashgroestlPath::get(self : CryptohashgroestlPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptohashgroestlPath::set(self : CryptohashgroestlPath, i : Int, v : Double) -> CryptohashgroestlPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlPath::sum(self : CryptohashgroestlPath) -> Double { @_common.sum(self.data) }

pub fn CryptohashgroestlPath::mean(self : CryptohashgroestlPath) -> Double { @_common.mean(self.data) }

pub fn CryptohashgroestlPath::scale(self : CryptohashgroestlPath, f : Double) -> CryptohashgroestlPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlPath::add(self : CryptohashgroestlPath, other : CryptohashgroestlPath) -> CryptohashgroestlPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptohashgroestlPath::copy(self : CryptohashgroestlPath) -> CryptohashgroestlPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlPath::fill(self : CryptohashgroestlPath, v : Double) -> CryptohashgroestlPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlPath::min(self : CryptohashgroestlPath) -> Double { @_common.min(self.data) }

pub fn CryptohashgroestlPath::max(self : CryptohashgroestlPath) -> Double { @_common.max(self.data) }

pub fn CryptohashgroestlPath::to_string(self : CryptohashgroestlPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptohashgroestlCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_groestl_cluster_make(size : Int) -> CryptohashgroestlCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptohashgroestlCluster::len(self : CryptohashgroestlCluster) -> Int { self.size }

pub fn CryptohashgroestlCluster::get(self : CryptohashgroestlCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptohashgroestlCluster::set(self : CryptohashgroestlCluster, i : Int, v : Double) -> CryptohashgroestlCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlCluster::sum(self : CryptohashgroestlCluster) -> Double { @_common.sum(self.data) }

pub fn CryptohashgroestlCluster::mean(self : CryptohashgroestlCluster) -> Double { @_common.mean(self.data) }

pub fn CryptohashgroestlCluster::scale(self : CryptohashgroestlCluster, f : Double) -> CryptohashgroestlCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlCluster::add(self : CryptohashgroestlCluster, other : CryptohashgroestlCluster) -> CryptohashgroestlCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptohashgroestlCluster::copy(self : CryptohashgroestlCluster) -> CryptohashgroestlCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlCluster::fill(self : CryptohashgroestlCluster, v : Double) -> CryptohashgroestlCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlCluster::min(self : CryptohashgroestlCluster) -> Double { @_common.min(self.data) }

pub fn CryptohashgroestlCluster::max(self : CryptohashgroestlCluster) -> Double { @_common.max(self.data) }

pub fn CryptohashgroestlCluster::to_string(self : CryptohashgroestlCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptohashgroestlModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_groestl_model_make(size : Int) -> CryptohashgroestlModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptohashgroestlModel::len(self : CryptohashgroestlModel) -> Int { self.size }

pub fn CryptohashgroestlModel::get(self : CryptohashgroestlModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptohashgroestlModel::set(self : CryptohashgroestlModel, i : Int, v : Double) -> CryptohashgroestlModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlModel::sum(self : CryptohashgroestlModel) -> Double { @_common.sum(self.data) }

pub fn CryptohashgroestlModel::mean(self : CryptohashgroestlModel) -> Double { @_common.mean(self.data) }

pub fn CryptohashgroestlModel::scale(self : CryptohashgroestlModel, f : Double) -> CryptohashgroestlModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlModel::add(self : CryptohashgroestlModel, other : CryptohashgroestlModel) -> CryptohashgroestlModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptohashgroestlModel::copy(self : CryptohashgroestlModel) -> CryptohashgroestlModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlModel::fill(self : CryptohashgroestlModel, v : Double) -> CryptohashgroestlModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlModel::min(self : CryptohashgroestlModel) -> Double { @_common.min(self.data) }

pub fn CryptohashgroestlModel::max(self : CryptohashgroestlModel) -> Double { @_common.max(self.data) }

pub fn CryptohashgroestlModel::to_string(self : CryptohashgroestlModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptohashgroestlLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_groestl_layer_make(size : Int) -> CryptohashgroestlLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptohashgroestlLayer::len(self : CryptohashgroestlLayer) -> Int { self.size }

pub fn CryptohashgroestlLayer::get(self : CryptohashgroestlLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptohashgroestlLayer::set(self : CryptohashgroestlLayer, i : Int, v : Double) -> CryptohashgroestlLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlLayer::sum(self : CryptohashgroestlLayer) -> Double { @_common.sum(self.data) }

pub fn CryptohashgroestlLayer::mean(self : CryptohashgroestlLayer) -> Double { @_common.mean(self.data) }

pub fn CryptohashgroestlLayer::scale(self : CryptohashgroestlLayer, f : Double) -> CryptohashgroestlLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlLayer::add(self : CryptohashgroestlLayer, other : CryptohashgroestlLayer) -> CryptohashgroestlLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptohashgroestlLayer::copy(self : CryptohashgroestlLayer) -> CryptohashgroestlLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlLayer::fill(self : CryptohashgroestlLayer, v : Double) -> CryptohashgroestlLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlLayer::min(self : CryptohashgroestlLayer) -> Double { @_common.min(self.data) }

pub fn CryptohashgroestlLayer::max(self : CryptohashgroestlLayer) -> Double { @_common.max(self.data) }

pub fn CryptohashgroestlLayer::to_string(self : CryptohashgroestlLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptohashgroestlBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_groestl_buffer_make(size : Int) -> CryptohashgroestlBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptohashgroestlBuffer::len(self : CryptohashgroestlBuffer) -> Int { self.size }

pub fn CryptohashgroestlBuffer::get(self : CryptohashgroestlBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptohashgroestlBuffer::set(self : CryptohashgroestlBuffer, i : Int, v : Double) -> CryptohashgroestlBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlBuffer::sum(self : CryptohashgroestlBuffer) -> Double { @_common.sum(self.data) }

pub fn CryptohashgroestlBuffer::mean(self : CryptohashgroestlBuffer) -> Double { @_common.mean(self.data) }

pub fn CryptohashgroestlBuffer::scale(self : CryptohashgroestlBuffer, f : Double) -> CryptohashgroestlBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlBuffer::add(self : CryptohashgroestlBuffer, other : CryptohashgroestlBuffer) -> CryptohashgroestlBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptohashgroestlBuffer::copy(self : CryptohashgroestlBuffer) -> CryptohashgroestlBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlBuffer::fill(self : CryptohashgroestlBuffer, v : Double) -> CryptohashgroestlBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlBuffer::min(self : CryptohashgroestlBuffer) -> Double { @_common.min(self.data) }

pub fn CryptohashgroestlBuffer::max(self : CryptohashgroestlBuffer) -> Double { @_common.max(self.data) }

pub fn CryptohashgroestlBuffer::to_string(self : CryptohashgroestlBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptohashgroestlCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_groestl_cursor_make(size : Int) -> CryptohashgroestlCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptohashgroestlCursor::len(self : CryptohashgroestlCursor) -> Int { self.size }

pub fn CryptohashgroestlCursor::get(self : CryptohashgroestlCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptohashgroestlCursor::set(self : CryptohashgroestlCursor, i : Int, v : Double) -> CryptohashgroestlCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlCursor::sum(self : CryptohashgroestlCursor) -> Double { @_common.sum(self.data) }

pub fn CryptohashgroestlCursor::mean(self : CryptohashgroestlCursor) -> Double { @_common.mean(self.data) }

pub fn CryptohashgroestlCursor::scale(self : CryptohashgroestlCursor, f : Double) -> CryptohashgroestlCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlCursor::add(self : CryptohashgroestlCursor, other : CryptohashgroestlCursor) -> CryptohashgroestlCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptohashgroestlCursor::copy(self : CryptohashgroestlCursor) -> CryptohashgroestlCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlCursor::fill(self : CryptohashgroestlCursor, v : Double) -> CryptohashgroestlCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlCursor::min(self : CryptohashgroestlCursor) -> Double { @_common.min(self.data) }

pub fn CryptohashgroestlCursor::max(self : CryptohashgroestlCursor) -> Double { @_common.max(self.data) }

pub fn CryptohashgroestlCursor::to_string(self : CryptohashgroestlCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptohashgroestlView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_groestl_view_make(size : Int) -> CryptohashgroestlView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptohashgroestlView::len(self : CryptohashgroestlView) -> Int { self.size }

pub fn CryptohashgroestlView::get(self : CryptohashgroestlView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptohashgroestlView::set(self : CryptohashgroestlView, i : Int, v : Double) -> CryptohashgroestlView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlView::sum(self : CryptohashgroestlView) -> Double { @_common.sum(self.data) }

pub fn CryptohashgroestlView::mean(self : CryptohashgroestlView) -> Double { @_common.mean(self.data) }

pub fn CryptohashgroestlView::scale(self : CryptohashgroestlView, f : Double) -> CryptohashgroestlView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlView::add(self : CryptohashgroestlView, other : CryptohashgroestlView) -> CryptohashgroestlView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptohashgroestlView::copy(self : CryptohashgroestlView) -> CryptohashgroestlView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlView::fill(self : CryptohashgroestlView, v : Double) -> CryptohashgroestlView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlView::min(self : CryptohashgroestlView) -> Double { @_common.min(self.data) }

pub fn CryptohashgroestlView::max(self : CryptohashgroestlView) -> Double { @_common.max(self.data) }

pub fn CryptohashgroestlView::to_string(self : CryptohashgroestlView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptohashgroestlRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_groestl_range_make(size : Int) -> CryptohashgroestlRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptohashgroestlRange::len(self : CryptohashgroestlRange) -> Int { self.size }

pub fn CryptohashgroestlRange::get(self : CryptohashgroestlRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptohashgroestlRange::set(self : CryptohashgroestlRange, i : Int, v : Double) -> CryptohashgroestlRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlRange::sum(self : CryptohashgroestlRange) -> Double { @_common.sum(self.data) }

pub fn CryptohashgroestlRange::mean(self : CryptohashgroestlRange) -> Double { @_common.mean(self.data) }

pub fn CryptohashgroestlRange::scale(self : CryptohashgroestlRange, f : Double) -> CryptohashgroestlRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlRange::add(self : CryptohashgroestlRange, other : CryptohashgroestlRange) -> CryptohashgroestlRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptohashgroestlRange::copy(self : CryptohashgroestlRange) -> CryptohashgroestlRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlRange::fill(self : CryptohashgroestlRange, v : Double) -> CryptohashgroestlRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlRange::min(self : CryptohashgroestlRange) -> Double { @_common.min(self.data) }

pub fn CryptohashgroestlRange::max(self : CryptohashgroestlRange) -> Double { @_common.max(self.data) }

pub fn CryptohashgroestlRange::to_string(self : CryptohashgroestlRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptohashgroestlSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_groestl_slice_make(size : Int) -> CryptohashgroestlSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptohashgroestlSlice::len(self : CryptohashgroestlSlice) -> Int { self.size }

pub fn CryptohashgroestlSlice::get(self : CryptohashgroestlSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptohashgroestlSlice::set(self : CryptohashgroestlSlice, i : Int, v : Double) -> CryptohashgroestlSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlSlice::sum(self : CryptohashgroestlSlice) -> Double { @_common.sum(self.data) }

pub fn CryptohashgroestlSlice::mean(self : CryptohashgroestlSlice) -> Double { @_common.mean(self.data) }

pub fn CryptohashgroestlSlice::scale(self : CryptohashgroestlSlice, f : Double) -> CryptohashgroestlSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlSlice::add(self : CryptohashgroestlSlice, other : CryptohashgroestlSlice) -> CryptohashgroestlSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptohashgroestlSlice::copy(self : CryptohashgroestlSlice) -> CryptohashgroestlSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlSlice::fill(self : CryptohashgroestlSlice, v : Double) -> CryptohashgroestlSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptohashgroestlSlice::min(self : CryptohashgroestlSlice) -> Double { @_common.min(self.data) }

pub fn CryptohashgroestlSlice::max(self : CryptohashgroestlSlice) -> Double { @_common.max(self.data) }

pub fn CryptohashgroestlSlice::to_string(self : CryptohashgroestlSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

