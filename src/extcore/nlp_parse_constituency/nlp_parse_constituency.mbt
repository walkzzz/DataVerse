///===
/// extcore/nlp_parse_constituency

pub(all) struct NlpparseconstituencyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_parse_constituency_make_point(x : Double, y : Double) -> NlpparseconstituencyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_parse_constituency_make_point3(x : Double, y : Double, z : Double) -> NlpparseconstituencyPoint {
  { x, y, z, label: 0 }
}

pub fn NlpparseconstituencyPoint::x(self : NlpparseconstituencyPoint) -> Double { self.x }

pub fn NlpparseconstituencyPoint::y(self : NlpparseconstituencyPoint) -> Double { self.y }

pub fn NlpparseconstituencyPoint::z(self : NlpparseconstituencyPoint) -> Double { self.z }

pub fn NlpparseconstituencyPoint::label(self : NlpparseconstituencyPoint) -> Int { self.label }

pub fn NlpparseconstituencyPoint::dist(self : NlpparseconstituencyPoint, other : NlpparseconstituencyPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlpparseconstituencyPoint::add(self : NlpparseconstituencyPoint, other : NlpparseconstituencyPoint) -> NlpparseconstituencyPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlpparseconstituencyPoint::sub(self : NlpparseconstituencyPoint, other : NlpparseconstituencyPoint) -> NlpparseconstituencyPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlpparseconstituencyPoint::scale(self : NlpparseconstituencyPoint, s : Double) -> NlpparseconstituencyPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlpparseconstituencyPoint::dot(self : NlpparseconstituencyPoint, other : NlpparseconstituencyPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlpparseconstituencyPoint::cross(self : NlpparseconstituencyPoint, other : NlpparseconstituencyPoint) -> NlpparseconstituencyPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlpparseconstituencyPoint::norm(self : NlpparseconstituencyPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlpparseconstituencyPoint::normalize(self : NlpparseconstituencyPoint) -> NlpparseconstituencyPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpparseconstituencyPoint::negate(self : NlpparseconstituencyPoint) -> NlpparseconstituencyPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlpparseconstituencyPoint::mid(self : NlpparseconstituencyPoint, other : NlpparseconstituencyPoint) -> NlpparseconstituencyPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlpparseconstituencyPoint::lerp(self : NlpparseconstituencyPoint, other : NlpparseconstituencyPoint, t : Double) -> NlpparseconstituencyPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlpparseconstituencyPoint::to_string(self : NlpparseconstituencyPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlpparseconstituencySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_parse_constituency_make_series(vals : Array[Double], name : String) -> NlpparseconstituencySeries {
  { vals, name, meta: 0 }
}

pub fn NlpparseconstituencySeries::len(self : NlpparseconstituencySeries) -> Int { self.vals.length() }

pub fn NlpparseconstituencySeries::sum(self : NlpparseconstituencySeries) -> Double { @_common.sum(self.vals) }

pub fn NlpparseconstituencySeries::mean(self : NlpparseconstituencySeries) -> Double { @_common.mean(self.vals) }

pub fn NlpparseconstituencySeries::min(self : NlpparseconstituencySeries) -> Double { @_common.min(self.vals) }

pub fn NlpparseconstituencySeries::max(self : NlpparseconstituencySeries) -> Double { @_common.max(self.vals) }

pub fn NlpparseconstituencySeries::range(self : NlpparseconstituencySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlpparseconstituencySeries::variance(self : NlpparseconstituencySeries) -> Double { @_common.variance(self.vals) }

pub fn NlpparseconstituencySeries::std(self : NlpparseconstituencySeries) -> Double { @_common.std(self.vals) }

pub fn NlpparseconstituencySeries::median(self : NlpparseconstituencySeries) -> Double { @_common.median(self.vals) }

pub fn NlpparseconstituencySeries::scale(self : NlpparseconstituencySeries, f : Double) -> NlpparseconstituencySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlpparseconstituencySeries::add(self : NlpparseconstituencySeries, other : NlpparseconstituencySeries) -> NlpparseconstituencySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlpparseconstituencySeries::sub(self : NlpparseconstituencySeries, other : NlpparseconstituencySeries) -> NlpparseconstituencySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlpparseconstituencySeries::normalize(self : NlpparseconstituencySeries) -> NlpparseconstituencySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlpparseconstituencySeries::cumsum(self : NlpparseconstituencySeries) -> NlpparseconstituencySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlpparseconstituencySeries::to_string(self : NlpparseconstituencySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpparseconstituencyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_parse_constituency_make_matrix(rows : Int, cols : Int, val : Double) -> NlpparseconstituencyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_parse_constituency_matrix_identity(n : Int) -> NlpparseconstituencyMatrix {
  let m = nlp_parse_constituency_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlpparseconstituencyMatrix::get(self : NlpparseconstituencyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlpparseconstituencyMatrix::transpose(self : NlpparseconstituencyMatrix) -> NlpparseconstituencyMatrix {
  let result = nlp_parse_constituency_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlpparseconstituencyMatrix::add(self : NlpparseconstituencyMatrix, other : NlpparseconstituencyMatrix) -> NlpparseconstituencyMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_parse_constituency_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlpparseconstituencyMatrix::scale(self : NlpparseconstituencyMatrix, s : Double) -> NlpparseconstituencyMatrix {
  let result = nlp_parse_constituency_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlpparseconstituencyMatrix::multiply(self : NlpparseconstituencyMatrix, other : NlpparseconstituencyMatrix) -> NlpparseconstituencyMatrix {
  if self.cols != other.rows { return nlp_parse_constituency_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_parse_constituency_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NlpparseconstituencyMatrix::trace(self : NlpparseconstituencyMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlpparseconstituencyMatrix::det(self : NlpparseconstituencyMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlpparseconstituencyMatrix::norm(self : NlpparseconstituencyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlpparseconstituencyMatrix::to_string(self : NlpparseconstituencyMatrix) -> String {
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

pub(all) struct NlpparseconstituencyVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_parse_constituency_make_vector(comps : Array[Double]) -> NlpparseconstituencyVector {
  { comps, dim: comps.length() }
}

pub fn nlp_parse_constituency_vector_zero(dim : Int) -> NlpparseconstituencyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlpparseconstituencyVector::add(self : NlpparseconstituencyVector, other : NlpparseconstituencyVector) -> NlpparseconstituencyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlpparseconstituencyVector::sub(self : NlpparseconstituencyVector, other : NlpparseconstituencyVector) -> NlpparseconstituencyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlpparseconstituencyVector::scale(self : NlpparseconstituencyVector, s : Double) -> NlpparseconstituencyVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlpparseconstituencyVector::dot(self : NlpparseconstituencyVector, other : NlpparseconstituencyVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlpparseconstituencyVector::norm(self : NlpparseconstituencyVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlpparseconstituencyVector::normalize(self : NlpparseconstituencyVector) -> NlpparseconstituencyVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpparseconstituencyVector::dist(self : NlpparseconstituencyVector, other : NlpparseconstituencyVector) -> Double {
  self.sub(other).norm()
}

pub fn NlpparseconstituencyVector::to_string(self : NlpparseconstituencyVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpparseconstituencyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_frame_make(size : Int) -> NlpparseconstituencyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparseconstituencyFrame::len(self : NlpparseconstituencyFrame) -> Int { self.size }

pub fn NlpparseconstituencyFrame::get(self : NlpparseconstituencyFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparseconstituencyFrame::set(self : NlpparseconstituencyFrame, i : Int, v : Double) -> NlpparseconstituencyFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyFrame::sum(self : NlpparseconstituencyFrame) -> Double { @_common.sum(self.data) }

pub fn NlpparseconstituencyFrame::mean(self : NlpparseconstituencyFrame) -> Double { @_common.mean(self.data) }

pub fn NlpparseconstituencyFrame::scale(self : NlpparseconstituencyFrame, f : Double) -> NlpparseconstituencyFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyFrame::add(self : NlpparseconstituencyFrame, other : NlpparseconstituencyFrame) -> NlpparseconstituencyFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparseconstituencyFrame::copy(self : NlpparseconstituencyFrame) -> NlpparseconstituencyFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyFrame::fill(self : NlpparseconstituencyFrame, v : Double) -> NlpparseconstituencyFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyFrame::min(self : NlpparseconstituencyFrame) -> Double { @_common.min(self.data) }

pub fn NlpparseconstituencyFrame::max(self : NlpparseconstituencyFrame) -> Double { @_common.max(self.data) }

pub fn NlpparseconstituencyFrame::to_string(self : NlpparseconstituencyFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_table_make(size : Int) -> NlpparseconstituencyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparseconstituencyTable::len(self : NlpparseconstituencyTable) -> Int { self.size }

pub fn NlpparseconstituencyTable::get(self : NlpparseconstituencyTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparseconstituencyTable::set(self : NlpparseconstituencyTable, i : Int, v : Double) -> NlpparseconstituencyTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyTable::sum(self : NlpparseconstituencyTable) -> Double { @_common.sum(self.data) }

pub fn NlpparseconstituencyTable::mean(self : NlpparseconstituencyTable) -> Double { @_common.mean(self.data) }

pub fn NlpparseconstituencyTable::scale(self : NlpparseconstituencyTable, f : Double) -> NlpparseconstituencyTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyTable::add(self : NlpparseconstituencyTable, other : NlpparseconstituencyTable) -> NlpparseconstituencyTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparseconstituencyTable::copy(self : NlpparseconstituencyTable) -> NlpparseconstituencyTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyTable::fill(self : NlpparseconstituencyTable, v : Double) -> NlpparseconstituencyTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyTable::min(self : NlpparseconstituencyTable) -> Double { @_common.min(self.data) }

pub fn NlpparseconstituencyTable::max(self : NlpparseconstituencyTable) -> Double { @_common.max(self.data) }

pub fn NlpparseconstituencyTable::to_string(self : NlpparseconstituencyTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_graphn_make(size : Int) -> NlpparseconstituencyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparseconstituencyGraphN::len(self : NlpparseconstituencyGraphN) -> Int { self.size }

pub fn NlpparseconstituencyGraphN::get(self : NlpparseconstituencyGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparseconstituencyGraphN::set(self : NlpparseconstituencyGraphN, i : Int, v : Double) -> NlpparseconstituencyGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyGraphN::sum(self : NlpparseconstituencyGraphN) -> Double { @_common.sum(self.data) }

pub fn NlpparseconstituencyGraphN::mean(self : NlpparseconstituencyGraphN) -> Double { @_common.mean(self.data) }

pub fn NlpparseconstituencyGraphN::scale(self : NlpparseconstituencyGraphN, f : Double) -> NlpparseconstituencyGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyGraphN::add(self : NlpparseconstituencyGraphN, other : NlpparseconstituencyGraphN) -> NlpparseconstituencyGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparseconstituencyGraphN::copy(self : NlpparseconstituencyGraphN) -> NlpparseconstituencyGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyGraphN::fill(self : NlpparseconstituencyGraphN, v : Double) -> NlpparseconstituencyGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyGraphN::min(self : NlpparseconstituencyGraphN) -> Double { @_common.min(self.data) }

pub fn NlpparseconstituencyGraphN::max(self : NlpparseconstituencyGraphN) -> Double { @_common.max(self.data) }

pub fn NlpparseconstituencyGraphN::to_string(self : NlpparseconstituencyGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_node_make(size : Int) -> NlpparseconstituencyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparseconstituencyNode::len(self : NlpparseconstituencyNode) -> Int { self.size }

pub fn NlpparseconstituencyNode::get(self : NlpparseconstituencyNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparseconstituencyNode::set(self : NlpparseconstituencyNode, i : Int, v : Double) -> NlpparseconstituencyNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyNode::sum(self : NlpparseconstituencyNode) -> Double { @_common.sum(self.data) }

pub fn NlpparseconstituencyNode::mean(self : NlpparseconstituencyNode) -> Double { @_common.mean(self.data) }

pub fn NlpparseconstituencyNode::scale(self : NlpparseconstituencyNode, f : Double) -> NlpparseconstituencyNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyNode::add(self : NlpparseconstituencyNode, other : NlpparseconstituencyNode) -> NlpparseconstituencyNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparseconstituencyNode::copy(self : NlpparseconstituencyNode) -> NlpparseconstituencyNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyNode::fill(self : NlpparseconstituencyNode, v : Double) -> NlpparseconstituencyNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyNode::min(self : NlpparseconstituencyNode) -> Double { @_common.min(self.data) }

pub fn NlpparseconstituencyNode::max(self : NlpparseconstituencyNode) -> Double { @_common.max(self.data) }

pub fn NlpparseconstituencyNode::to_string(self : NlpparseconstituencyNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_edge_make(size : Int) -> NlpparseconstituencyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparseconstituencyEdge::len(self : NlpparseconstituencyEdge) -> Int { self.size }

pub fn NlpparseconstituencyEdge::get(self : NlpparseconstituencyEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparseconstituencyEdge::set(self : NlpparseconstituencyEdge, i : Int, v : Double) -> NlpparseconstituencyEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyEdge::sum(self : NlpparseconstituencyEdge) -> Double { @_common.sum(self.data) }

pub fn NlpparseconstituencyEdge::mean(self : NlpparseconstituencyEdge) -> Double { @_common.mean(self.data) }

pub fn NlpparseconstituencyEdge::scale(self : NlpparseconstituencyEdge, f : Double) -> NlpparseconstituencyEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyEdge::add(self : NlpparseconstituencyEdge, other : NlpparseconstituencyEdge) -> NlpparseconstituencyEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparseconstituencyEdge::copy(self : NlpparseconstituencyEdge) -> NlpparseconstituencyEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyEdge::fill(self : NlpparseconstituencyEdge, v : Double) -> NlpparseconstituencyEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyEdge::min(self : NlpparseconstituencyEdge) -> Double { @_common.min(self.data) }

pub fn NlpparseconstituencyEdge::max(self : NlpparseconstituencyEdge) -> Double { @_common.max(self.data) }

pub fn NlpparseconstituencyEdge::to_string(self : NlpparseconstituencyEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_path_make(size : Int) -> NlpparseconstituencyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparseconstituencyPath::len(self : NlpparseconstituencyPath) -> Int { self.size }

pub fn NlpparseconstituencyPath::get(self : NlpparseconstituencyPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparseconstituencyPath::set(self : NlpparseconstituencyPath, i : Int, v : Double) -> NlpparseconstituencyPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyPath::sum(self : NlpparseconstituencyPath) -> Double { @_common.sum(self.data) }

pub fn NlpparseconstituencyPath::mean(self : NlpparseconstituencyPath) -> Double { @_common.mean(self.data) }

pub fn NlpparseconstituencyPath::scale(self : NlpparseconstituencyPath, f : Double) -> NlpparseconstituencyPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyPath::add(self : NlpparseconstituencyPath, other : NlpparseconstituencyPath) -> NlpparseconstituencyPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparseconstituencyPath::copy(self : NlpparseconstituencyPath) -> NlpparseconstituencyPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyPath::fill(self : NlpparseconstituencyPath, v : Double) -> NlpparseconstituencyPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyPath::min(self : NlpparseconstituencyPath) -> Double { @_common.min(self.data) }

pub fn NlpparseconstituencyPath::max(self : NlpparseconstituencyPath) -> Double { @_common.max(self.data) }

pub fn NlpparseconstituencyPath::to_string(self : NlpparseconstituencyPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_cluster_make(size : Int) -> NlpparseconstituencyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparseconstituencyCluster::len(self : NlpparseconstituencyCluster) -> Int { self.size }

pub fn NlpparseconstituencyCluster::get(self : NlpparseconstituencyCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparseconstituencyCluster::set(self : NlpparseconstituencyCluster, i : Int, v : Double) -> NlpparseconstituencyCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyCluster::sum(self : NlpparseconstituencyCluster) -> Double { @_common.sum(self.data) }

pub fn NlpparseconstituencyCluster::mean(self : NlpparseconstituencyCluster) -> Double { @_common.mean(self.data) }

pub fn NlpparseconstituencyCluster::scale(self : NlpparseconstituencyCluster, f : Double) -> NlpparseconstituencyCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyCluster::add(self : NlpparseconstituencyCluster, other : NlpparseconstituencyCluster) -> NlpparseconstituencyCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparseconstituencyCluster::copy(self : NlpparseconstituencyCluster) -> NlpparseconstituencyCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyCluster::fill(self : NlpparseconstituencyCluster, v : Double) -> NlpparseconstituencyCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyCluster::min(self : NlpparseconstituencyCluster) -> Double { @_common.min(self.data) }

pub fn NlpparseconstituencyCluster::max(self : NlpparseconstituencyCluster) -> Double { @_common.max(self.data) }

pub fn NlpparseconstituencyCluster::to_string(self : NlpparseconstituencyCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_model_make(size : Int) -> NlpparseconstituencyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparseconstituencyModel::len(self : NlpparseconstituencyModel) -> Int { self.size }

pub fn NlpparseconstituencyModel::get(self : NlpparseconstituencyModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparseconstituencyModel::set(self : NlpparseconstituencyModel, i : Int, v : Double) -> NlpparseconstituencyModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyModel::sum(self : NlpparseconstituencyModel) -> Double { @_common.sum(self.data) }

pub fn NlpparseconstituencyModel::mean(self : NlpparseconstituencyModel) -> Double { @_common.mean(self.data) }

pub fn NlpparseconstituencyModel::scale(self : NlpparseconstituencyModel, f : Double) -> NlpparseconstituencyModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyModel::add(self : NlpparseconstituencyModel, other : NlpparseconstituencyModel) -> NlpparseconstituencyModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparseconstituencyModel::copy(self : NlpparseconstituencyModel) -> NlpparseconstituencyModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyModel::fill(self : NlpparseconstituencyModel, v : Double) -> NlpparseconstituencyModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyModel::min(self : NlpparseconstituencyModel) -> Double { @_common.min(self.data) }

pub fn NlpparseconstituencyModel::max(self : NlpparseconstituencyModel) -> Double { @_common.max(self.data) }

pub fn NlpparseconstituencyModel::to_string(self : NlpparseconstituencyModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_layer_make(size : Int) -> NlpparseconstituencyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparseconstituencyLayer::len(self : NlpparseconstituencyLayer) -> Int { self.size }

pub fn NlpparseconstituencyLayer::get(self : NlpparseconstituencyLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparseconstituencyLayer::set(self : NlpparseconstituencyLayer, i : Int, v : Double) -> NlpparseconstituencyLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyLayer::sum(self : NlpparseconstituencyLayer) -> Double { @_common.sum(self.data) }

pub fn NlpparseconstituencyLayer::mean(self : NlpparseconstituencyLayer) -> Double { @_common.mean(self.data) }

pub fn NlpparseconstituencyLayer::scale(self : NlpparseconstituencyLayer, f : Double) -> NlpparseconstituencyLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyLayer::add(self : NlpparseconstituencyLayer, other : NlpparseconstituencyLayer) -> NlpparseconstituencyLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparseconstituencyLayer::copy(self : NlpparseconstituencyLayer) -> NlpparseconstituencyLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyLayer::fill(self : NlpparseconstituencyLayer, v : Double) -> NlpparseconstituencyLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyLayer::min(self : NlpparseconstituencyLayer) -> Double { @_common.min(self.data) }

pub fn NlpparseconstituencyLayer::max(self : NlpparseconstituencyLayer) -> Double { @_common.max(self.data) }

pub fn NlpparseconstituencyLayer::to_string(self : NlpparseconstituencyLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_buffer_make(size : Int) -> NlpparseconstituencyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparseconstituencyBuffer::len(self : NlpparseconstituencyBuffer) -> Int { self.size }

pub fn NlpparseconstituencyBuffer::get(self : NlpparseconstituencyBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparseconstituencyBuffer::set(self : NlpparseconstituencyBuffer, i : Int, v : Double) -> NlpparseconstituencyBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyBuffer::sum(self : NlpparseconstituencyBuffer) -> Double { @_common.sum(self.data) }

pub fn NlpparseconstituencyBuffer::mean(self : NlpparseconstituencyBuffer) -> Double { @_common.mean(self.data) }

pub fn NlpparseconstituencyBuffer::scale(self : NlpparseconstituencyBuffer, f : Double) -> NlpparseconstituencyBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyBuffer::add(self : NlpparseconstituencyBuffer, other : NlpparseconstituencyBuffer) -> NlpparseconstituencyBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparseconstituencyBuffer::copy(self : NlpparseconstituencyBuffer) -> NlpparseconstituencyBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyBuffer::fill(self : NlpparseconstituencyBuffer, v : Double) -> NlpparseconstituencyBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyBuffer::min(self : NlpparseconstituencyBuffer) -> Double { @_common.min(self.data) }

pub fn NlpparseconstituencyBuffer::max(self : NlpparseconstituencyBuffer) -> Double { @_common.max(self.data) }

pub fn NlpparseconstituencyBuffer::to_string(self : NlpparseconstituencyBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_cursor_make(size : Int) -> NlpparseconstituencyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparseconstituencyCursor::len(self : NlpparseconstituencyCursor) -> Int { self.size }

pub fn NlpparseconstituencyCursor::get(self : NlpparseconstituencyCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparseconstituencyCursor::set(self : NlpparseconstituencyCursor, i : Int, v : Double) -> NlpparseconstituencyCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyCursor::sum(self : NlpparseconstituencyCursor) -> Double { @_common.sum(self.data) }

pub fn NlpparseconstituencyCursor::mean(self : NlpparseconstituencyCursor) -> Double { @_common.mean(self.data) }

pub fn NlpparseconstituencyCursor::scale(self : NlpparseconstituencyCursor, f : Double) -> NlpparseconstituencyCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyCursor::add(self : NlpparseconstituencyCursor, other : NlpparseconstituencyCursor) -> NlpparseconstituencyCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparseconstituencyCursor::copy(self : NlpparseconstituencyCursor) -> NlpparseconstituencyCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyCursor::fill(self : NlpparseconstituencyCursor, v : Double) -> NlpparseconstituencyCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyCursor::min(self : NlpparseconstituencyCursor) -> Double { @_common.min(self.data) }

pub fn NlpparseconstituencyCursor::max(self : NlpparseconstituencyCursor) -> Double { @_common.max(self.data) }

pub fn NlpparseconstituencyCursor::to_string(self : NlpparseconstituencyCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_view_make(size : Int) -> NlpparseconstituencyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparseconstituencyView::len(self : NlpparseconstituencyView) -> Int { self.size }

pub fn NlpparseconstituencyView::get(self : NlpparseconstituencyView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparseconstituencyView::set(self : NlpparseconstituencyView, i : Int, v : Double) -> NlpparseconstituencyView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyView::sum(self : NlpparseconstituencyView) -> Double { @_common.sum(self.data) }

pub fn NlpparseconstituencyView::mean(self : NlpparseconstituencyView) -> Double { @_common.mean(self.data) }

pub fn NlpparseconstituencyView::scale(self : NlpparseconstituencyView, f : Double) -> NlpparseconstituencyView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyView::add(self : NlpparseconstituencyView, other : NlpparseconstituencyView) -> NlpparseconstituencyView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparseconstituencyView::copy(self : NlpparseconstituencyView) -> NlpparseconstituencyView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyView::fill(self : NlpparseconstituencyView, v : Double) -> NlpparseconstituencyView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyView::min(self : NlpparseconstituencyView) -> Double { @_common.min(self.data) }

pub fn NlpparseconstituencyView::max(self : NlpparseconstituencyView) -> Double { @_common.max(self.data) }

pub fn NlpparseconstituencyView::to_string(self : NlpparseconstituencyView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_range_make(size : Int) -> NlpparseconstituencyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparseconstituencyRange::len(self : NlpparseconstituencyRange) -> Int { self.size }

pub fn NlpparseconstituencyRange::get(self : NlpparseconstituencyRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparseconstituencyRange::set(self : NlpparseconstituencyRange, i : Int, v : Double) -> NlpparseconstituencyRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyRange::sum(self : NlpparseconstituencyRange) -> Double { @_common.sum(self.data) }

pub fn NlpparseconstituencyRange::mean(self : NlpparseconstituencyRange) -> Double { @_common.mean(self.data) }

pub fn NlpparseconstituencyRange::scale(self : NlpparseconstituencyRange, f : Double) -> NlpparseconstituencyRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyRange::add(self : NlpparseconstituencyRange, other : NlpparseconstituencyRange) -> NlpparseconstituencyRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparseconstituencyRange::copy(self : NlpparseconstituencyRange) -> NlpparseconstituencyRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyRange::fill(self : NlpparseconstituencyRange, v : Double) -> NlpparseconstituencyRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencyRange::min(self : NlpparseconstituencyRange) -> Double { @_common.min(self.data) }

pub fn NlpparseconstituencyRange::max(self : NlpparseconstituencyRange) -> Double { @_common.max(self.data) }

pub fn NlpparseconstituencyRange::to_string(self : NlpparseconstituencyRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_slice_make(size : Int) -> NlpparseconstituencySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparseconstituencySlice::len(self : NlpparseconstituencySlice) -> Int { self.size }

pub fn NlpparseconstituencySlice::get(self : NlpparseconstituencySlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparseconstituencySlice::set(self : NlpparseconstituencySlice, i : Int, v : Double) -> NlpparseconstituencySlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencySlice::sum(self : NlpparseconstituencySlice) -> Double { @_common.sum(self.data) }

pub fn NlpparseconstituencySlice::mean(self : NlpparseconstituencySlice) -> Double { @_common.mean(self.data) }

pub fn NlpparseconstituencySlice::scale(self : NlpparseconstituencySlice, f : Double) -> NlpparseconstituencySlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencySlice::add(self : NlpparseconstituencySlice, other : NlpparseconstituencySlice) -> NlpparseconstituencySlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparseconstituencySlice::copy(self : NlpparseconstituencySlice) -> NlpparseconstituencySlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencySlice::fill(self : NlpparseconstituencySlice, v : Double) -> NlpparseconstituencySlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparseconstituencySlice::min(self : NlpparseconstituencySlice) -> Double { @_common.min(self.data) }

pub fn NlpparseconstituencySlice::max(self : NlpparseconstituencySlice) -> Double { @_common.max(self.data) }

pub fn NlpparseconstituencySlice::to_string(self : NlpparseconstituencySlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

