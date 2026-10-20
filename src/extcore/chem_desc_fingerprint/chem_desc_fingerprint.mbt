///===
/// extcore/chem_desc_fingerprint

pub(all) struct ChemdescfingerprintPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_desc_fingerprint_make_point(x : Double, y : Double) -> ChemdescfingerprintPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_desc_fingerprint_make_point3(x : Double, y : Double, z : Double) -> ChemdescfingerprintPoint {
  { x, y, z, label: 0 }
}

pub fn ChemdescfingerprintPoint::x(self : ChemdescfingerprintPoint) -> Double { self.x }

pub fn ChemdescfingerprintPoint::y(self : ChemdescfingerprintPoint) -> Double { self.y }

pub fn ChemdescfingerprintPoint::z(self : ChemdescfingerprintPoint) -> Double { self.z }

pub fn ChemdescfingerprintPoint::label(self : ChemdescfingerprintPoint) -> Int { self.label }

pub fn ChemdescfingerprintPoint::dist(self : ChemdescfingerprintPoint, other : ChemdescfingerprintPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemdescfingerprintPoint::add(self : ChemdescfingerprintPoint, other : ChemdescfingerprintPoint) -> ChemdescfingerprintPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemdescfingerprintPoint::sub(self : ChemdescfingerprintPoint, other : ChemdescfingerprintPoint) -> ChemdescfingerprintPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemdescfingerprintPoint::scale(self : ChemdescfingerprintPoint, s : Double) -> ChemdescfingerprintPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemdescfingerprintPoint::dot(self : ChemdescfingerprintPoint, other : ChemdescfingerprintPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemdescfingerprintPoint::cross(self : ChemdescfingerprintPoint, other : ChemdescfingerprintPoint) -> ChemdescfingerprintPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemdescfingerprintPoint::norm(self : ChemdescfingerprintPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemdescfingerprintPoint::normalize(self : ChemdescfingerprintPoint) -> ChemdescfingerprintPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemdescfingerprintPoint::negate(self : ChemdescfingerprintPoint) -> ChemdescfingerprintPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemdescfingerprintPoint::mid(self : ChemdescfingerprintPoint, other : ChemdescfingerprintPoint) -> ChemdescfingerprintPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemdescfingerprintPoint::lerp(self : ChemdescfingerprintPoint, other : ChemdescfingerprintPoint, t : Double) -> ChemdescfingerprintPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemdescfingerprintPoint::to_string(self : ChemdescfingerprintPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemdescfingerprintSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_desc_fingerprint_make_series(vals : Array[Double], name : String) -> ChemdescfingerprintSeries {
  { vals, name, meta: 0 }
}

pub fn ChemdescfingerprintSeries::len(self : ChemdescfingerprintSeries) -> Int { self.vals.length() }

pub fn ChemdescfingerprintSeries::sum(self : ChemdescfingerprintSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemdescfingerprintSeries::mean(self : ChemdescfingerprintSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemdescfingerprintSeries::min(self : ChemdescfingerprintSeries) -> Double { @_common.min(self.vals) }

pub fn ChemdescfingerprintSeries::max(self : ChemdescfingerprintSeries) -> Double { @_common.max(self.vals) }

pub fn ChemdescfingerprintSeries::range(self : ChemdescfingerprintSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemdescfingerprintSeries::variance(self : ChemdescfingerprintSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemdescfingerprintSeries::std(self : ChemdescfingerprintSeries) -> Double { @_common.std(self.vals) }

pub fn ChemdescfingerprintSeries::median(self : ChemdescfingerprintSeries) -> Double { @_common.median(self.vals) }

pub fn ChemdescfingerprintSeries::scale(self : ChemdescfingerprintSeries, f : Double) -> ChemdescfingerprintSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemdescfingerprintSeries::add(self : ChemdescfingerprintSeries, other : ChemdescfingerprintSeries) -> ChemdescfingerprintSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemdescfingerprintSeries::sub(self : ChemdescfingerprintSeries, other : ChemdescfingerprintSeries) -> ChemdescfingerprintSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemdescfingerprintSeries::normalize(self : ChemdescfingerprintSeries) -> ChemdescfingerprintSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemdescfingerprintSeries::cumsum(self : ChemdescfingerprintSeries) -> ChemdescfingerprintSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemdescfingerprintSeries::to_string(self : ChemdescfingerprintSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemdescfingerprintMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_desc_fingerprint_make_matrix(rows : Int, cols : Int, val : Double) -> ChemdescfingerprintMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn chem_desc_fingerprint_matrix_identity(n : Int) -> ChemdescfingerprintMatrix {
  let m = chem_desc_fingerprint_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemdescfingerprintMatrix::get(self : ChemdescfingerprintMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemdescfingerprintMatrix::transpose(self : ChemdescfingerprintMatrix) -> ChemdescfingerprintMatrix {
  let result = chem_desc_fingerprint_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemdescfingerprintMatrix::add(self : ChemdescfingerprintMatrix, other : ChemdescfingerprintMatrix) -> ChemdescfingerprintMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_desc_fingerprint_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemdescfingerprintMatrix::scale(self : ChemdescfingerprintMatrix, s : Double) -> ChemdescfingerprintMatrix {
  let result = chem_desc_fingerprint_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemdescfingerprintMatrix::multiply(self : ChemdescfingerprintMatrix, other : ChemdescfingerprintMatrix) -> ChemdescfingerprintMatrix {
  if self.cols != other.rows { return chem_desc_fingerprint_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_desc_fingerprint_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn ChemdescfingerprintMatrix::trace(self : ChemdescfingerprintMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemdescfingerprintMatrix::det(self : ChemdescfingerprintMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemdescfingerprintMatrix::norm(self : ChemdescfingerprintMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemdescfingerprintMatrix::to_string(self : ChemdescfingerprintMatrix) -> String {
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

pub(all) struct ChemdescfingerprintVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_desc_fingerprint_make_vector(comps : Array[Double]) -> ChemdescfingerprintVector {
  { comps, dim: comps.length() }
}

pub fn chem_desc_fingerprint_vector_zero(dim : Int) -> ChemdescfingerprintVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemdescfingerprintVector::add(self : ChemdescfingerprintVector, other : ChemdescfingerprintVector) -> ChemdescfingerprintVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemdescfingerprintVector::sub(self : ChemdescfingerprintVector, other : ChemdescfingerprintVector) -> ChemdescfingerprintVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemdescfingerprintVector::scale(self : ChemdescfingerprintVector, s : Double) -> ChemdescfingerprintVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemdescfingerprintVector::dot(self : ChemdescfingerprintVector, other : ChemdescfingerprintVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemdescfingerprintVector::norm(self : ChemdescfingerprintVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemdescfingerprintVector::normalize(self : ChemdescfingerprintVector) -> ChemdescfingerprintVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemdescfingerprintVector::dist(self : ChemdescfingerprintVector, other : ChemdescfingerprintVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemdescfingerprintVector::to_string(self : ChemdescfingerprintVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemdescfingerprintFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fingerprint_frame_make(size : Int) -> ChemdescfingerprintFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescfingerprintFrame::len(self : ChemdescfingerprintFrame) -> Int { self.size }

pub fn ChemdescfingerprintFrame::get(self : ChemdescfingerprintFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescfingerprintFrame::set(self : ChemdescfingerprintFrame, i : Int, v : Double) -> ChemdescfingerprintFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintFrame::sum(self : ChemdescfingerprintFrame) -> Double { @_common.sum(self.data) }

pub fn ChemdescfingerprintFrame::mean(self : ChemdescfingerprintFrame) -> Double { @_common.mean(self.data) }

pub fn ChemdescfingerprintFrame::scale(self : ChemdescfingerprintFrame, f : Double) -> ChemdescfingerprintFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintFrame::add(self : ChemdescfingerprintFrame, other : ChemdescfingerprintFrame) -> ChemdescfingerprintFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescfingerprintFrame::copy(self : ChemdescfingerprintFrame) -> ChemdescfingerprintFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintFrame::fill(self : ChemdescfingerprintFrame, v : Double) -> ChemdescfingerprintFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintFrame::min(self : ChemdescfingerprintFrame) -> Double { @_common.min(self.data) }

pub fn ChemdescfingerprintFrame::max(self : ChemdescfingerprintFrame) -> Double { @_common.max(self.data) }

pub fn ChemdescfingerprintFrame::to_string(self : ChemdescfingerprintFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescfingerprintTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fingerprint_table_make(size : Int) -> ChemdescfingerprintTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescfingerprintTable::len(self : ChemdescfingerprintTable) -> Int { self.size }

pub fn ChemdescfingerprintTable::get(self : ChemdescfingerprintTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescfingerprintTable::set(self : ChemdescfingerprintTable, i : Int, v : Double) -> ChemdescfingerprintTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintTable::sum(self : ChemdescfingerprintTable) -> Double { @_common.sum(self.data) }

pub fn ChemdescfingerprintTable::mean(self : ChemdescfingerprintTable) -> Double { @_common.mean(self.data) }

pub fn ChemdescfingerprintTable::scale(self : ChemdescfingerprintTable, f : Double) -> ChemdescfingerprintTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintTable::add(self : ChemdescfingerprintTable, other : ChemdescfingerprintTable) -> ChemdescfingerprintTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescfingerprintTable::copy(self : ChemdescfingerprintTable) -> ChemdescfingerprintTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintTable::fill(self : ChemdescfingerprintTable, v : Double) -> ChemdescfingerprintTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintTable::min(self : ChemdescfingerprintTable) -> Double { @_common.min(self.data) }

pub fn ChemdescfingerprintTable::max(self : ChemdescfingerprintTable) -> Double { @_common.max(self.data) }

pub fn ChemdescfingerprintTable::to_string(self : ChemdescfingerprintTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescfingerprintGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fingerprint_graphn_make(size : Int) -> ChemdescfingerprintGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescfingerprintGraphN::len(self : ChemdescfingerprintGraphN) -> Int { self.size }

pub fn ChemdescfingerprintGraphN::get(self : ChemdescfingerprintGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescfingerprintGraphN::set(self : ChemdescfingerprintGraphN, i : Int, v : Double) -> ChemdescfingerprintGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintGraphN::sum(self : ChemdescfingerprintGraphN) -> Double { @_common.sum(self.data) }

pub fn ChemdescfingerprintGraphN::mean(self : ChemdescfingerprintGraphN) -> Double { @_common.mean(self.data) }

pub fn ChemdescfingerprintGraphN::scale(self : ChemdescfingerprintGraphN, f : Double) -> ChemdescfingerprintGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintGraphN::add(self : ChemdescfingerprintGraphN, other : ChemdescfingerprintGraphN) -> ChemdescfingerprintGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescfingerprintGraphN::copy(self : ChemdescfingerprintGraphN) -> ChemdescfingerprintGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintGraphN::fill(self : ChemdescfingerprintGraphN, v : Double) -> ChemdescfingerprintGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintGraphN::min(self : ChemdescfingerprintGraphN) -> Double { @_common.min(self.data) }

pub fn ChemdescfingerprintGraphN::max(self : ChemdescfingerprintGraphN) -> Double { @_common.max(self.data) }

pub fn ChemdescfingerprintGraphN::to_string(self : ChemdescfingerprintGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescfingerprintNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fingerprint_node_make(size : Int) -> ChemdescfingerprintNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescfingerprintNode::len(self : ChemdescfingerprintNode) -> Int { self.size }

pub fn ChemdescfingerprintNode::get(self : ChemdescfingerprintNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescfingerprintNode::set(self : ChemdescfingerprintNode, i : Int, v : Double) -> ChemdescfingerprintNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintNode::sum(self : ChemdescfingerprintNode) -> Double { @_common.sum(self.data) }

pub fn ChemdescfingerprintNode::mean(self : ChemdescfingerprintNode) -> Double { @_common.mean(self.data) }

pub fn ChemdescfingerprintNode::scale(self : ChemdescfingerprintNode, f : Double) -> ChemdescfingerprintNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintNode::add(self : ChemdescfingerprintNode, other : ChemdescfingerprintNode) -> ChemdescfingerprintNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescfingerprintNode::copy(self : ChemdescfingerprintNode) -> ChemdescfingerprintNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintNode::fill(self : ChemdescfingerprintNode, v : Double) -> ChemdescfingerprintNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintNode::min(self : ChemdescfingerprintNode) -> Double { @_common.min(self.data) }

pub fn ChemdescfingerprintNode::max(self : ChemdescfingerprintNode) -> Double { @_common.max(self.data) }

pub fn ChemdescfingerprintNode::to_string(self : ChemdescfingerprintNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescfingerprintEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fingerprint_edge_make(size : Int) -> ChemdescfingerprintEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescfingerprintEdge::len(self : ChemdescfingerprintEdge) -> Int { self.size }

pub fn ChemdescfingerprintEdge::get(self : ChemdescfingerprintEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescfingerprintEdge::set(self : ChemdescfingerprintEdge, i : Int, v : Double) -> ChemdescfingerprintEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintEdge::sum(self : ChemdescfingerprintEdge) -> Double { @_common.sum(self.data) }

pub fn ChemdescfingerprintEdge::mean(self : ChemdescfingerprintEdge) -> Double { @_common.mean(self.data) }

pub fn ChemdescfingerprintEdge::scale(self : ChemdescfingerprintEdge, f : Double) -> ChemdescfingerprintEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintEdge::add(self : ChemdescfingerprintEdge, other : ChemdescfingerprintEdge) -> ChemdescfingerprintEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescfingerprintEdge::copy(self : ChemdescfingerprintEdge) -> ChemdescfingerprintEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintEdge::fill(self : ChemdescfingerprintEdge, v : Double) -> ChemdescfingerprintEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintEdge::min(self : ChemdescfingerprintEdge) -> Double { @_common.min(self.data) }

pub fn ChemdescfingerprintEdge::max(self : ChemdescfingerprintEdge) -> Double { @_common.max(self.data) }

pub fn ChemdescfingerprintEdge::to_string(self : ChemdescfingerprintEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescfingerprintPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fingerprint_path_make(size : Int) -> ChemdescfingerprintPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescfingerprintPath::len(self : ChemdescfingerprintPath) -> Int { self.size }

pub fn ChemdescfingerprintPath::get(self : ChemdescfingerprintPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescfingerprintPath::set(self : ChemdescfingerprintPath, i : Int, v : Double) -> ChemdescfingerprintPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintPath::sum(self : ChemdescfingerprintPath) -> Double { @_common.sum(self.data) }

pub fn ChemdescfingerprintPath::mean(self : ChemdescfingerprintPath) -> Double { @_common.mean(self.data) }

pub fn ChemdescfingerprintPath::scale(self : ChemdescfingerprintPath, f : Double) -> ChemdescfingerprintPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintPath::add(self : ChemdescfingerprintPath, other : ChemdescfingerprintPath) -> ChemdescfingerprintPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescfingerprintPath::copy(self : ChemdescfingerprintPath) -> ChemdescfingerprintPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintPath::fill(self : ChemdescfingerprintPath, v : Double) -> ChemdescfingerprintPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintPath::min(self : ChemdescfingerprintPath) -> Double { @_common.min(self.data) }

pub fn ChemdescfingerprintPath::max(self : ChemdescfingerprintPath) -> Double { @_common.max(self.data) }

pub fn ChemdescfingerprintPath::to_string(self : ChemdescfingerprintPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescfingerprintCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fingerprint_cluster_make(size : Int) -> ChemdescfingerprintCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescfingerprintCluster::len(self : ChemdescfingerprintCluster) -> Int { self.size }

pub fn ChemdescfingerprintCluster::get(self : ChemdescfingerprintCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescfingerprintCluster::set(self : ChemdescfingerprintCluster, i : Int, v : Double) -> ChemdescfingerprintCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintCluster::sum(self : ChemdescfingerprintCluster) -> Double { @_common.sum(self.data) }

pub fn ChemdescfingerprintCluster::mean(self : ChemdescfingerprintCluster) -> Double { @_common.mean(self.data) }

pub fn ChemdescfingerprintCluster::scale(self : ChemdescfingerprintCluster, f : Double) -> ChemdescfingerprintCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintCluster::add(self : ChemdescfingerprintCluster, other : ChemdescfingerprintCluster) -> ChemdescfingerprintCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescfingerprintCluster::copy(self : ChemdescfingerprintCluster) -> ChemdescfingerprintCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintCluster::fill(self : ChemdescfingerprintCluster, v : Double) -> ChemdescfingerprintCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintCluster::min(self : ChemdescfingerprintCluster) -> Double { @_common.min(self.data) }

pub fn ChemdescfingerprintCluster::max(self : ChemdescfingerprintCluster) -> Double { @_common.max(self.data) }

pub fn ChemdescfingerprintCluster::to_string(self : ChemdescfingerprintCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescfingerprintModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fingerprint_model_make(size : Int) -> ChemdescfingerprintModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescfingerprintModel::len(self : ChemdescfingerprintModel) -> Int { self.size }

pub fn ChemdescfingerprintModel::get(self : ChemdescfingerprintModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescfingerprintModel::set(self : ChemdescfingerprintModel, i : Int, v : Double) -> ChemdescfingerprintModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintModel::sum(self : ChemdescfingerprintModel) -> Double { @_common.sum(self.data) }

pub fn ChemdescfingerprintModel::mean(self : ChemdescfingerprintModel) -> Double { @_common.mean(self.data) }

pub fn ChemdescfingerprintModel::scale(self : ChemdescfingerprintModel, f : Double) -> ChemdescfingerprintModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintModel::add(self : ChemdescfingerprintModel, other : ChemdescfingerprintModel) -> ChemdescfingerprintModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescfingerprintModel::copy(self : ChemdescfingerprintModel) -> ChemdescfingerprintModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintModel::fill(self : ChemdescfingerprintModel, v : Double) -> ChemdescfingerprintModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintModel::min(self : ChemdescfingerprintModel) -> Double { @_common.min(self.data) }

pub fn ChemdescfingerprintModel::max(self : ChemdescfingerprintModel) -> Double { @_common.max(self.data) }

pub fn ChemdescfingerprintModel::to_string(self : ChemdescfingerprintModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescfingerprintLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fingerprint_layer_make(size : Int) -> ChemdescfingerprintLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescfingerprintLayer::len(self : ChemdescfingerprintLayer) -> Int { self.size }

pub fn ChemdescfingerprintLayer::get(self : ChemdescfingerprintLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescfingerprintLayer::set(self : ChemdescfingerprintLayer, i : Int, v : Double) -> ChemdescfingerprintLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintLayer::sum(self : ChemdescfingerprintLayer) -> Double { @_common.sum(self.data) }

pub fn ChemdescfingerprintLayer::mean(self : ChemdescfingerprintLayer) -> Double { @_common.mean(self.data) }

pub fn ChemdescfingerprintLayer::scale(self : ChemdescfingerprintLayer, f : Double) -> ChemdescfingerprintLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintLayer::add(self : ChemdescfingerprintLayer, other : ChemdescfingerprintLayer) -> ChemdescfingerprintLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescfingerprintLayer::copy(self : ChemdescfingerprintLayer) -> ChemdescfingerprintLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintLayer::fill(self : ChemdescfingerprintLayer, v : Double) -> ChemdescfingerprintLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintLayer::min(self : ChemdescfingerprintLayer) -> Double { @_common.min(self.data) }

pub fn ChemdescfingerprintLayer::max(self : ChemdescfingerprintLayer) -> Double { @_common.max(self.data) }

pub fn ChemdescfingerprintLayer::to_string(self : ChemdescfingerprintLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescfingerprintBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fingerprint_buffer_make(size : Int) -> ChemdescfingerprintBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescfingerprintBuffer::len(self : ChemdescfingerprintBuffer) -> Int { self.size }

pub fn ChemdescfingerprintBuffer::get(self : ChemdescfingerprintBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescfingerprintBuffer::set(self : ChemdescfingerprintBuffer, i : Int, v : Double) -> ChemdescfingerprintBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintBuffer::sum(self : ChemdescfingerprintBuffer) -> Double { @_common.sum(self.data) }

pub fn ChemdescfingerprintBuffer::mean(self : ChemdescfingerprintBuffer) -> Double { @_common.mean(self.data) }

pub fn ChemdescfingerprintBuffer::scale(self : ChemdescfingerprintBuffer, f : Double) -> ChemdescfingerprintBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintBuffer::add(self : ChemdescfingerprintBuffer, other : ChemdescfingerprintBuffer) -> ChemdescfingerprintBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescfingerprintBuffer::copy(self : ChemdescfingerprintBuffer) -> ChemdescfingerprintBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintBuffer::fill(self : ChemdescfingerprintBuffer, v : Double) -> ChemdescfingerprintBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintBuffer::min(self : ChemdescfingerprintBuffer) -> Double { @_common.min(self.data) }

pub fn ChemdescfingerprintBuffer::max(self : ChemdescfingerprintBuffer) -> Double { @_common.max(self.data) }

pub fn ChemdescfingerprintBuffer::to_string(self : ChemdescfingerprintBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescfingerprintCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fingerprint_cursor_make(size : Int) -> ChemdescfingerprintCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescfingerprintCursor::len(self : ChemdescfingerprintCursor) -> Int { self.size }

pub fn ChemdescfingerprintCursor::get(self : ChemdescfingerprintCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescfingerprintCursor::set(self : ChemdescfingerprintCursor, i : Int, v : Double) -> ChemdescfingerprintCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintCursor::sum(self : ChemdescfingerprintCursor) -> Double { @_common.sum(self.data) }

pub fn ChemdescfingerprintCursor::mean(self : ChemdescfingerprintCursor) -> Double { @_common.mean(self.data) }

pub fn ChemdescfingerprintCursor::scale(self : ChemdescfingerprintCursor, f : Double) -> ChemdescfingerprintCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintCursor::add(self : ChemdescfingerprintCursor, other : ChemdescfingerprintCursor) -> ChemdescfingerprintCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescfingerprintCursor::copy(self : ChemdescfingerprintCursor) -> ChemdescfingerprintCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintCursor::fill(self : ChemdescfingerprintCursor, v : Double) -> ChemdescfingerprintCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintCursor::min(self : ChemdescfingerprintCursor) -> Double { @_common.min(self.data) }

pub fn ChemdescfingerprintCursor::max(self : ChemdescfingerprintCursor) -> Double { @_common.max(self.data) }

pub fn ChemdescfingerprintCursor::to_string(self : ChemdescfingerprintCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescfingerprintView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fingerprint_view_make(size : Int) -> ChemdescfingerprintView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescfingerprintView::len(self : ChemdescfingerprintView) -> Int { self.size }

pub fn ChemdescfingerprintView::get(self : ChemdescfingerprintView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescfingerprintView::set(self : ChemdescfingerprintView, i : Int, v : Double) -> ChemdescfingerprintView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintView::sum(self : ChemdescfingerprintView) -> Double { @_common.sum(self.data) }

pub fn ChemdescfingerprintView::mean(self : ChemdescfingerprintView) -> Double { @_common.mean(self.data) }

pub fn ChemdescfingerprintView::scale(self : ChemdescfingerprintView, f : Double) -> ChemdescfingerprintView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintView::add(self : ChemdescfingerprintView, other : ChemdescfingerprintView) -> ChemdescfingerprintView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescfingerprintView::copy(self : ChemdescfingerprintView) -> ChemdescfingerprintView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintView::fill(self : ChemdescfingerprintView, v : Double) -> ChemdescfingerprintView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintView::min(self : ChemdescfingerprintView) -> Double { @_common.min(self.data) }

pub fn ChemdescfingerprintView::max(self : ChemdescfingerprintView) -> Double { @_common.max(self.data) }

pub fn ChemdescfingerprintView::to_string(self : ChemdescfingerprintView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescfingerprintRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fingerprint_range_make(size : Int) -> ChemdescfingerprintRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescfingerprintRange::len(self : ChemdescfingerprintRange) -> Int { self.size }

pub fn ChemdescfingerprintRange::get(self : ChemdescfingerprintRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescfingerprintRange::set(self : ChemdescfingerprintRange, i : Int, v : Double) -> ChemdescfingerprintRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintRange::sum(self : ChemdescfingerprintRange) -> Double { @_common.sum(self.data) }

pub fn ChemdescfingerprintRange::mean(self : ChemdescfingerprintRange) -> Double { @_common.mean(self.data) }

pub fn ChemdescfingerprintRange::scale(self : ChemdescfingerprintRange, f : Double) -> ChemdescfingerprintRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintRange::add(self : ChemdescfingerprintRange, other : ChemdescfingerprintRange) -> ChemdescfingerprintRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescfingerprintRange::copy(self : ChemdescfingerprintRange) -> ChemdescfingerprintRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintRange::fill(self : ChemdescfingerprintRange, v : Double) -> ChemdescfingerprintRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintRange::min(self : ChemdescfingerprintRange) -> Double { @_common.min(self.data) }

pub fn ChemdescfingerprintRange::max(self : ChemdescfingerprintRange) -> Double { @_common.max(self.data) }

pub fn ChemdescfingerprintRange::to_string(self : ChemdescfingerprintRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescfingerprintSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fingerprint_slice_make(size : Int) -> ChemdescfingerprintSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescfingerprintSlice::len(self : ChemdescfingerprintSlice) -> Int { self.size }

pub fn ChemdescfingerprintSlice::get(self : ChemdescfingerprintSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescfingerprintSlice::set(self : ChemdescfingerprintSlice, i : Int, v : Double) -> ChemdescfingerprintSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintSlice::sum(self : ChemdescfingerprintSlice) -> Double { @_common.sum(self.data) }

pub fn ChemdescfingerprintSlice::mean(self : ChemdescfingerprintSlice) -> Double { @_common.mean(self.data) }

pub fn ChemdescfingerprintSlice::scale(self : ChemdescfingerprintSlice, f : Double) -> ChemdescfingerprintSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintSlice::add(self : ChemdescfingerprintSlice, other : ChemdescfingerprintSlice) -> ChemdescfingerprintSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescfingerprintSlice::copy(self : ChemdescfingerprintSlice) -> ChemdescfingerprintSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintSlice::fill(self : ChemdescfingerprintSlice, v : Double) -> ChemdescfingerprintSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescfingerprintSlice::min(self : ChemdescfingerprintSlice) -> Double { @_common.min(self.data) }

pub fn ChemdescfingerprintSlice::max(self : ChemdescfingerprintSlice) -> Double { @_common.max(self.data) }

pub fn ChemdescfingerprintSlice::to_string(self : ChemdescfingerprintSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

