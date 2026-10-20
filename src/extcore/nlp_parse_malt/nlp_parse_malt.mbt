///===
/// extcore/nlp_parse_malt

pub(all) struct NlpparsemaltPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_parse_malt_make_point(x : Double, y : Double) -> NlpparsemaltPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_parse_malt_make_point3(x : Double, y : Double, z : Double) -> NlpparsemaltPoint {
  { x, y, z, label: 0 }
}

pub fn NlpparsemaltPoint::x(self : NlpparsemaltPoint) -> Double { self.x }

pub fn NlpparsemaltPoint::y(self : NlpparsemaltPoint) -> Double { self.y }

pub fn NlpparsemaltPoint::z(self : NlpparsemaltPoint) -> Double { self.z }

pub fn NlpparsemaltPoint::label(self : NlpparsemaltPoint) -> Int { self.label }

pub fn NlpparsemaltPoint::dist(self : NlpparsemaltPoint, other : NlpparsemaltPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlpparsemaltPoint::add(self : NlpparsemaltPoint, other : NlpparsemaltPoint) -> NlpparsemaltPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlpparsemaltPoint::sub(self : NlpparsemaltPoint, other : NlpparsemaltPoint) -> NlpparsemaltPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlpparsemaltPoint::scale(self : NlpparsemaltPoint, s : Double) -> NlpparsemaltPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlpparsemaltPoint::dot(self : NlpparsemaltPoint, other : NlpparsemaltPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlpparsemaltPoint::cross(self : NlpparsemaltPoint, other : NlpparsemaltPoint) -> NlpparsemaltPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlpparsemaltPoint::norm(self : NlpparsemaltPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlpparsemaltPoint::normalize(self : NlpparsemaltPoint) -> NlpparsemaltPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpparsemaltPoint::negate(self : NlpparsemaltPoint) -> NlpparsemaltPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlpparsemaltPoint::mid(self : NlpparsemaltPoint, other : NlpparsemaltPoint) -> NlpparsemaltPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlpparsemaltPoint::lerp(self : NlpparsemaltPoint, other : NlpparsemaltPoint, t : Double) -> NlpparsemaltPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlpparsemaltPoint::to_string(self : NlpparsemaltPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlpparsemaltSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_parse_malt_make_series(vals : Array[Double], name : String) -> NlpparsemaltSeries {
  { vals, name, meta: 0 }
}

pub fn NlpparsemaltSeries::len(self : NlpparsemaltSeries) -> Int { self.vals.length() }

pub fn NlpparsemaltSeries::sum(self : NlpparsemaltSeries) -> Double { @_common.sum(self.vals) }

pub fn NlpparsemaltSeries::mean(self : NlpparsemaltSeries) -> Double { @_common.mean(self.vals) }

pub fn NlpparsemaltSeries::min(self : NlpparsemaltSeries) -> Double { @_common.min(self.vals) }

pub fn NlpparsemaltSeries::max(self : NlpparsemaltSeries) -> Double { @_common.max(self.vals) }

pub fn NlpparsemaltSeries::range(self : NlpparsemaltSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlpparsemaltSeries::variance(self : NlpparsemaltSeries) -> Double { @_common.variance(self.vals) }

pub fn NlpparsemaltSeries::std(self : NlpparsemaltSeries) -> Double { @_common.std(self.vals) }

pub fn NlpparsemaltSeries::median(self : NlpparsemaltSeries) -> Double { @_common.median(self.vals) }

pub fn NlpparsemaltSeries::scale(self : NlpparsemaltSeries, f : Double) -> NlpparsemaltSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlpparsemaltSeries::add(self : NlpparsemaltSeries, other : NlpparsemaltSeries) -> NlpparsemaltSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlpparsemaltSeries::sub(self : NlpparsemaltSeries, other : NlpparsemaltSeries) -> NlpparsemaltSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlpparsemaltSeries::normalize(self : NlpparsemaltSeries) -> NlpparsemaltSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlpparsemaltSeries::cumsum(self : NlpparsemaltSeries) -> NlpparsemaltSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlpparsemaltSeries::to_string(self : NlpparsemaltSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpparsemaltMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_parse_malt_make_matrix(rows : Int, cols : Int, val : Double) -> NlpparsemaltMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_parse_malt_matrix_identity(n : Int) -> NlpparsemaltMatrix {
  let m = nlp_parse_malt_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlpparsemaltMatrix::get(self : NlpparsemaltMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlpparsemaltMatrix::transpose(self : NlpparsemaltMatrix) -> NlpparsemaltMatrix {
  let result = nlp_parse_malt_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlpparsemaltMatrix::add(self : NlpparsemaltMatrix, other : NlpparsemaltMatrix) -> NlpparsemaltMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_parse_malt_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlpparsemaltMatrix::scale(self : NlpparsemaltMatrix, s : Double) -> NlpparsemaltMatrix {
  let result = nlp_parse_malt_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlpparsemaltMatrix::multiply(self : NlpparsemaltMatrix, other : NlpparsemaltMatrix) -> NlpparsemaltMatrix {
  if self.cols != other.rows { return nlp_parse_malt_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_parse_malt_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn NlpparsemaltMatrix::trace(self : NlpparsemaltMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlpparsemaltMatrix::det(self : NlpparsemaltMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlpparsemaltMatrix::norm(self : NlpparsemaltMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlpparsemaltMatrix::to_string(self : NlpparsemaltMatrix) -> String {
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

pub(all) struct NlpparsemaltVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_parse_malt_make_vector(comps : Array[Double]) -> NlpparsemaltVector {
  { comps, dim: comps.length() }
}

pub fn nlp_parse_malt_vector_zero(dim : Int) -> NlpparsemaltVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlpparsemaltVector::add(self : NlpparsemaltVector, other : NlpparsemaltVector) -> NlpparsemaltVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlpparsemaltVector::sub(self : NlpparsemaltVector, other : NlpparsemaltVector) -> NlpparsemaltVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlpparsemaltVector::scale(self : NlpparsemaltVector, s : Double) -> NlpparsemaltVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlpparsemaltVector::dot(self : NlpparsemaltVector, other : NlpparsemaltVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlpparsemaltVector::norm(self : NlpparsemaltVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlpparsemaltVector::normalize(self : NlpparsemaltVector) -> NlpparsemaltVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpparsemaltVector::dist(self : NlpparsemaltVector, other : NlpparsemaltVector) -> Double {
  self.sub(other).norm()
}

pub fn NlpparsemaltVector::to_string(self : NlpparsemaltVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpparsemaltFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_malt_frame_make(size : Int) -> NlpparsemaltFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsemaltFrame::len(self : NlpparsemaltFrame) -> Int { self.size }

pub fn NlpparsemaltFrame::get(self : NlpparsemaltFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsemaltFrame::set(self : NlpparsemaltFrame, i : Int, v : Double) -> NlpparsemaltFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsemaltFrame::sum(self : NlpparsemaltFrame) -> Double { @_common.sum(self.data) }

pub fn NlpparsemaltFrame::mean(self : NlpparsemaltFrame) -> Double { @_common.mean(self.data) }

pub fn NlpparsemaltFrame::scale(self : NlpparsemaltFrame, f : Double) -> NlpparsemaltFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsemaltFrame::add(self : NlpparsemaltFrame, other : NlpparsemaltFrame) -> NlpparsemaltFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsemaltFrame::copy(self : NlpparsemaltFrame) -> NlpparsemaltFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsemaltFrame::fill(self : NlpparsemaltFrame, v : Double) -> NlpparsemaltFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsemaltFrame::min(self : NlpparsemaltFrame) -> Double { @_common.min(self.data) }

pub fn NlpparsemaltFrame::max(self : NlpparsemaltFrame) -> Double { @_common.max(self.data) }

pub fn NlpparsemaltFrame::to_string(self : NlpparsemaltFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsemaltTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_malt_table_make(size : Int) -> NlpparsemaltTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsemaltTable::len(self : NlpparsemaltTable) -> Int { self.size }

pub fn NlpparsemaltTable::get(self : NlpparsemaltTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsemaltTable::set(self : NlpparsemaltTable, i : Int, v : Double) -> NlpparsemaltTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsemaltTable::sum(self : NlpparsemaltTable) -> Double { @_common.sum(self.data) }

pub fn NlpparsemaltTable::mean(self : NlpparsemaltTable) -> Double { @_common.mean(self.data) }

pub fn NlpparsemaltTable::scale(self : NlpparsemaltTable, f : Double) -> NlpparsemaltTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsemaltTable::add(self : NlpparsemaltTable, other : NlpparsemaltTable) -> NlpparsemaltTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsemaltTable::copy(self : NlpparsemaltTable) -> NlpparsemaltTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsemaltTable::fill(self : NlpparsemaltTable, v : Double) -> NlpparsemaltTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsemaltTable::min(self : NlpparsemaltTable) -> Double { @_common.min(self.data) }

pub fn NlpparsemaltTable::max(self : NlpparsemaltTable) -> Double { @_common.max(self.data) }

pub fn NlpparsemaltTable::to_string(self : NlpparsemaltTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsemaltGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_malt_graphn_make(size : Int) -> NlpparsemaltGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsemaltGraphN::len(self : NlpparsemaltGraphN) -> Int { self.size }

pub fn NlpparsemaltGraphN::get(self : NlpparsemaltGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsemaltGraphN::set(self : NlpparsemaltGraphN, i : Int, v : Double) -> NlpparsemaltGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsemaltGraphN::sum(self : NlpparsemaltGraphN) -> Double { @_common.sum(self.data) }

pub fn NlpparsemaltGraphN::mean(self : NlpparsemaltGraphN) -> Double { @_common.mean(self.data) }

pub fn NlpparsemaltGraphN::scale(self : NlpparsemaltGraphN, f : Double) -> NlpparsemaltGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsemaltGraphN::add(self : NlpparsemaltGraphN, other : NlpparsemaltGraphN) -> NlpparsemaltGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsemaltGraphN::copy(self : NlpparsemaltGraphN) -> NlpparsemaltGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsemaltGraphN::fill(self : NlpparsemaltGraphN, v : Double) -> NlpparsemaltGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsemaltGraphN::min(self : NlpparsemaltGraphN) -> Double { @_common.min(self.data) }

pub fn NlpparsemaltGraphN::max(self : NlpparsemaltGraphN) -> Double { @_common.max(self.data) }

pub fn NlpparsemaltGraphN::to_string(self : NlpparsemaltGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsemaltNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_malt_node_make(size : Int) -> NlpparsemaltNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsemaltNode::len(self : NlpparsemaltNode) -> Int { self.size }

pub fn NlpparsemaltNode::get(self : NlpparsemaltNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsemaltNode::set(self : NlpparsemaltNode, i : Int, v : Double) -> NlpparsemaltNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsemaltNode::sum(self : NlpparsemaltNode) -> Double { @_common.sum(self.data) }

pub fn NlpparsemaltNode::mean(self : NlpparsemaltNode) -> Double { @_common.mean(self.data) }

pub fn NlpparsemaltNode::scale(self : NlpparsemaltNode, f : Double) -> NlpparsemaltNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsemaltNode::add(self : NlpparsemaltNode, other : NlpparsemaltNode) -> NlpparsemaltNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsemaltNode::copy(self : NlpparsemaltNode) -> NlpparsemaltNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsemaltNode::fill(self : NlpparsemaltNode, v : Double) -> NlpparsemaltNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsemaltNode::min(self : NlpparsemaltNode) -> Double { @_common.min(self.data) }

pub fn NlpparsemaltNode::max(self : NlpparsemaltNode) -> Double { @_common.max(self.data) }

pub fn NlpparsemaltNode::to_string(self : NlpparsemaltNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsemaltEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_malt_edge_make(size : Int) -> NlpparsemaltEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsemaltEdge::len(self : NlpparsemaltEdge) -> Int { self.size }

pub fn NlpparsemaltEdge::get(self : NlpparsemaltEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsemaltEdge::set(self : NlpparsemaltEdge, i : Int, v : Double) -> NlpparsemaltEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsemaltEdge::sum(self : NlpparsemaltEdge) -> Double { @_common.sum(self.data) }

pub fn NlpparsemaltEdge::mean(self : NlpparsemaltEdge) -> Double { @_common.mean(self.data) }

pub fn NlpparsemaltEdge::scale(self : NlpparsemaltEdge, f : Double) -> NlpparsemaltEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsemaltEdge::add(self : NlpparsemaltEdge, other : NlpparsemaltEdge) -> NlpparsemaltEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsemaltEdge::copy(self : NlpparsemaltEdge) -> NlpparsemaltEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsemaltEdge::fill(self : NlpparsemaltEdge, v : Double) -> NlpparsemaltEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsemaltEdge::min(self : NlpparsemaltEdge) -> Double { @_common.min(self.data) }

pub fn NlpparsemaltEdge::max(self : NlpparsemaltEdge) -> Double { @_common.max(self.data) }

pub fn NlpparsemaltEdge::to_string(self : NlpparsemaltEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsemaltPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_malt_path_make(size : Int) -> NlpparsemaltPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsemaltPath::len(self : NlpparsemaltPath) -> Int { self.size }

pub fn NlpparsemaltPath::get(self : NlpparsemaltPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsemaltPath::set(self : NlpparsemaltPath, i : Int, v : Double) -> NlpparsemaltPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsemaltPath::sum(self : NlpparsemaltPath) -> Double { @_common.sum(self.data) }

pub fn NlpparsemaltPath::mean(self : NlpparsemaltPath) -> Double { @_common.mean(self.data) }

pub fn NlpparsemaltPath::scale(self : NlpparsemaltPath, f : Double) -> NlpparsemaltPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsemaltPath::add(self : NlpparsemaltPath, other : NlpparsemaltPath) -> NlpparsemaltPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsemaltPath::copy(self : NlpparsemaltPath) -> NlpparsemaltPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsemaltPath::fill(self : NlpparsemaltPath, v : Double) -> NlpparsemaltPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsemaltPath::min(self : NlpparsemaltPath) -> Double { @_common.min(self.data) }

pub fn NlpparsemaltPath::max(self : NlpparsemaltPath) -> Double { @_common.max(self.data) }

pub fn NlpparsemaltPath::to_string(self : NlpparsemaltPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsemaltCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_malt_cluster_make(size : Int) -> NlpparsemaltCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsemaltCluster::len(self : NlpparsemaltCluster) -> Int { self.size }

pub fn NlpparsemaltCluster::get(self : NlpparsemaltCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsemaltCluster::set(self : NlpparsemaltCluster, i : Int, v : Double) -> NlpparsemaltCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsemaltCluster::sum(self : NlpparsemaltCluster) -> Double { @_common.sum(self.data) }

pub fn NlpparsemaltCluster::mean(self : NlpparsemaltCluster) -> Double { @_common.mean(self.data) }

pub fn NlpparsemaltCluster::scale(self : NlpparsemaltCluster, f : Double) -> NlpparsemaltCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsemaltCluster::add(self : NlpparsemaltCluster, other : NlpparsemaltCluster) -> NlpparsemaltCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsemaltCluster::copy(self : NlpparsemaltCluster) -> NlpparsemaltCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsemaltCluster::fill(self : NlpparsemaltCluster, v : Double) -> NlpparsemaltCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsemaltCluster::min(self : NlpparsemaltCluster) -> Double { @_common.min(self.data) }

pub fn NlpparsemaltCluster::max(self : NlpparsemaltCluster) -> Double { @_common.max(self.data) }

pub fn NlpparsemaltCluster::to_string(self : NlpparsemaltCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsemaltModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_malt_model_make(size : Int) -> NlpparsemaltModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsemaltModel::len(self : NlpparsemaltModel) -> Int { self.size }

pub fn NlpparsemaltModel::get(self : NlpparsemaltModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsemaltModel::set(self : NlpparsemaltModel, i : Int, v : Double) -> NlpparsemaltModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsemaltModel::sum(self : NlpparsemaltModel) -> Double { @_common.sum(self.data) }

pub fn NlpparsemaltModel::mean(self : NlpparsemaltModel) -> Double { @_common.mean(self.data) }

pub fn NlpparsemaltModel::scale(self : NlpparsemaltModel, f : Double) -> NlpparsemaltModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsemaltModel::add(self : NlpparsemaltModel, other : NlpparsemaltModel) -> NlpparsemaltModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsemaltModel::copy(self : NlpparsemaltModel) -> NlpparsemaltModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsemaltModel::fill(self : NlpparsemaltModel, v : Double) -> NlpparsemaltModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsemaltModel::min(self : NlpparsemaltModel) -> Double { @_common.min(self.data) }

pub fn NlpparsemaltModel::max(self : NlpparsemaltModel) -> Double { @_common.max(self.data) }

pub fn NlpparsemaltModel::to_string(self : NlpparsemaltModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsemaltLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_malt_layer_make(size : Int) -> NlpparsemaltLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsemaltLayer::len(self : NlpparsemaltLayer) -> Int { self.size }

pub fn NlpparsemaltLayer::get(self : NlpparsemaltLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsemaltLayer::set(self : NlpparsemaltLayer, i : Int, v : Double) -> NlpparsemaltLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsemaltLayer::sum(self : NlpparsemaltLayer) -> Double { @_common.sum(self.data) }

pub fn NlpparsemaltLayer::mean(self : NlpparsemaltLayer) -> Double { @_common.mean(self.data) }

pub fn NlpparsemaltLayer::scale(self : NlpparsemaltLayer, f : Double) -> NlpparsemaltLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsemaltLayer::add(self : NlpparsemaltLayer, other : NlpparsemaltLayer) -> NlpparsemaltLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsemaltLayer::copy(self : NlpparsemaltLayer) -> NlpparsemaltLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsemaltLayer::fill(self : NlpparsemaltLayer, v : Double) -> NlpparsemaltLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsemaltLayer::min(self : NlpparsemaltLayer) -> Double { @_common.min(self.data) }

pub fn NlpparsemaltLayer::max(self : NlpparsemaltLayer) -> Double { @_common.max(self.data) }

pub fn NlpparsemaltLayer::to_string(self : NlpparsemaltLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsemaltBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_malt_buffer_make(size : Int) -> NlpparsemaltBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsemaltBuffer::len(self : NlpparsemaltBuffer) -> Int { self.size }

pub fn NlpparsemaltBuffer::get(self : NlpparsemaltBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsemaltBuffer::set(self : NlpparsemaltBuffer, i : Int, v : Double) -> NlpparsemaltBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsemaltBuffer::sum(self : NlpparsemaltBuffer) -> Double { @_common.sum(self.data) }

pub fn NlpparsemaltBuffer::mean(self : NlpparsemaltBuffer) -> Double { @_common.mean(self.data) }

pub fn NlpparsemaltBuffer::scale(self : NlpparsemaltBuffer, f : Double) -> NlpparsemaltBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsemaltBuffer::add(self : NlpparsemaltBuffer, other : NlpparsemaltBuffer) -> NlpparsemaltBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsemaltBuffer::copy(self : NlpparsemaltBuffer) -> NlpparsemaltBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsemaltBuffer::fill(self : NlpparsemaltBuffer, v : Double) -> NlpparsemaltBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsemaltBuffer::min(self : NlpparsemaltBuffer) -> Double { @_common.min(self.data) }

pub fn NlpparsemaltBuffer::max(self : NlpparsemaltBuffer) -> Double { @_common.max(self.data) }

pub fn NlpparsemaltBuffer::to_string(self : NlpparsemaltBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsemaltCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_malt_cursor_make(size : Int) -> NlpparsemaltCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsemaltCursor::len(self : NlpparsemaltCursor) -> Int { self.size }

pub fn NlpparsemaltCursor::get(self : NlpparsemaltCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsemaltCursor::set(self : NlpparsemaltCursor, i : Int, v : Double) -> NlpparsemaltCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsemaltCursor::sum(self : NlpparsemaltCursor) -> Double { @_common.sum(self.data) }

pub fn NlpparsemaltCursor::mean(self : NlpparsemaltCursor) -> Double { @_common.mean(self.data) }

pub fn NlpparsemaltCursor::scale(self : NlpparsemaltCursor, f : Double) -> NlpparsemaltCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsemaltCursor::add(self : NlpparsemaltCursor, other : NlpparsemaltCursor) -> NlpparsemaltCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsemaltCursor::copy(self : NlpparsemaltCursor) -> NlpparsemaltCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsemaltCursor::fill(self : NlpparsemaltCursor, v : Double) -> NlpparsemaltCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsemaltCursor::min(self : NlpparsemaltCursor) -> Double { @_common.min(self.data) }

pub fn NlpparsemaltCursor::max(self : NlpparsemaltCursor) -> Double { @_common.max(self.data) }

pub fn NlpparsemaltCursor::to_string(self : NlpparsemaltCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsemaltView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_malt_view_make(size : Int) -> NlpparsemaltView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsemaltView::len(self : NlpparsemaltView) -> Int { self.size }

pub fn NlpparsemaltView::get(self : NlpparsemaltView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsemaltView::set(self : NlpparsemaltView, i : Int, v : Double) -> NlpparsemaltView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsemaltView::sum(self : NlpparsemaltView) -> Double { @_common.sum(self.data) }

pub fn NlpparsemaltView::mean(self : NlpparsemaltView) -> Double { @_common.mean(self.data) }

pub fn NlpparsemaltView::scale(self : NlpparsemaltView, f : Double) -> NlpparsemaltView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsemaltView::add(self : NlpparsemaltView, other : NlpparsemaltView) -> NlpparsemaltView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsemaltView::copy(self : NlpparsemaltView) -> NlpparsemaltView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsemaltView::fill(self : NlpparsemaltView, v : Double) -> NlpparsemaltView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsemaltView::min(self : NlpparsemaltView) -> Double { @_common.min(self.data) }

pub fn NlpparsemaltView::max(self : NlpparsemaltView) -> Double { @_common.max(self.data) }

pub fn NlpparsemaltView::to_string(self : NlpparsemaltView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsemaltRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_malt_range_make(size : Int) -> NlpparsemaltRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsemaltRange::len(self : NlpparsemaltRange) -> Int { self.size }

pub fn NlpparsemaltRange::get(self : NlpparsemaltRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsemaltRange::set(self : NlpparsemaltRange, i : Int, v : Double) -> NlpparsemaltRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsemaltRange::sum(self : NlpparsemaltRange) -> Double { @_common.sum(self.data) }

pub fn NlpparsemaltRange::mean(self : NlpparsemaltRange) -> Double { @_common.mean(self.data) }

pub fn NlpparsemaltRange::scale(self : NlpparsemaltRange, f : Double) -> NlpparsemaltRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsemaltRange::add(self : NlpparsemaltRange, other : NlpparsemaltRange) -> NlpparsemaltRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsemaltRange::copy(self : NlpparsemaltRange) -> NlpparsemaltRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsemaltRange::fill(self : NlpparsemaltRange, v : Double) -> NlpparsemaltRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsemaltRange::min(self : NlpparsemaltRange) -> Double { @_common.min(self.data) }

pub fn NlpparsemaltRange::max(self : NlpparsemaltRange) -> Double { @_common.max(self.data) }

pub fn NlpparsemaltRange::to_string(self : NlpparsemaltRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsemaltSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_malt_slice_make(size : Int) -> NlpparsemaltSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsemaltSlice::len(self : NlpparsemaltSlice) -> Int { self.size }

pub fn NlpparsemaltSlice::get(self : NlpparsemaltSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsemaltSlice::set(self : NlpparsemaltSlice, i : Int, v : Double) -> NlpparsemaltSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsemaltSlice::sum(self : NlpparsemaltSlice) -> Double { @_common.sum(self.data) }

pub fn NlpparsemaltSlice::mean(self : NlpparsemaltSlice) -> Double { @_common.mean(self.data) }

pub fn NlpparsemaltSlice::scale(self : NlpparsemaltSlice, f : Double) -> NlpparsemaltSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsemaltSlice::add(self : NlpparsemaltSlice, other : NlpparsemaltSlice) -> NlpparsemaltSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsemaltSlice::copy(self : NlpparsemaltSlice) -> NlpparsemaltSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsemaltSlice::fill(self : NlpparsemaltSlice, v : Double) -> NlpparsemaltSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsemaltSlice::min(self : NlpparsemaltSlice) -> Double { @_common.min(self.data) }

pub fn NlpparsemaltSlice::max(self : NlpparsemaltSlice) -> Double { @_common.max(self.data) }

pub fn NlpparsemaltSlice::to_string(self : NlpparsemaltSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

