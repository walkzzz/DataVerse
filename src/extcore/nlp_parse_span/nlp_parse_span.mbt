///===
/// extcore/nlp_parse_span

pub(all) struct NlpparsespanPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_parse_span_make_point(x : Double, y : Double) -> NlpparsespanPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_parse_span_make_point3(x : Double, y : Double, z : Double) -> NlpparsespanPoint {
  { x, y, z, label: 0 }
}

pub fn NlpparsespanPoint::x(self : NlpparsespanPoint) -> Double { self.x }

pub fn NlpparsespanPoint::y(self : NlpparsespanPoint) -> Double { self.y }

pub fn NlpparsespanPoint::z(self : NlpparsespanPoint) -> Double { self.z }

pub fn NlpparsespanPoint::label(self : NlpparsespanPoint) -> Int { self.label }

pub fn NlpparsespanPoint::dist(self : NlpparsespanPoint, other : NlpparsespanPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlpparsespanPoint::add(self : NlpparsespanPoint, other : NlpparsespanPoint) -> NlpparsespanPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlpparsespanPoint::sub(self : NlpparsespanPoint, other : NlpparsespanPoint) -> NlpparsespanPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlpparsespanPoint::scale(self : NlpparsespanPoint, s : Double) -> NlpparsespanPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlpparsespanPoint::dot(self : NlpparsespanPoint, other : NlpparsespanPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlpparsespanPoint::cross(self : NlpparsespanPoint, other : NlpparsespanPoint) -> NlpparsespanPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlpparsespanPoint::norm(self : NlpparsespanPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlpparsespanPoint::normalize(self : NlpparsespanPoint) -> NlpparsespanPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpparsespanPoint::negate(self : NlpparsespanPoint) -> NlpparsespanPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlpparsespanPoint::mid(self : NlpparsespanPoint, other : NlpparsespanPoint) -> NlpparsespanPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlpparsespanPoint::lerp(self : NlpparsespanPoint, other : NlpparsespanPoint, t : Double) -> NlpparsespanPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlpparsespanPoint::to_string(self : NlpparsespanPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlpparsespanSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_parse_span_make_series(vals : Array[Double], name : String) -> NlpparsespanSeries {
  { vals, name, meta: 0 }
}

pub fn NlpparsespanSeries::len(self : NlpparsespanSeries) -> Int { self.vals.length() }

pub fn NlpparsespanSeries::sum(self : NlpparsespanSeries) -> Double { @_common.sum(self.vals) }

pub fn NlpparsespanSeries::mean(self : NlpparsespanSeries) -> Double { @_common.mean(self.vals) }

pub fn NlpparsespanSeries::min(self : NlpparsespanSeries) -> Double { @_common.min(self.vals) }

pub fn NlpparsespanSeries::max(self : NlpparsespanSeries) -> Double { @_common.max(self.vals) }

pub fn NlpparsespanSeries::range(self : NlpparsespanSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlpparsespanSeries::variance(self : NlpparsespanSeries) -> Double { @_common.variance(self.vals) }

pub fn NlpparsespanSeries::std(self : NlpparsespanSeries) -> Double { @_common.std(self.vals) }

pub fn NlpparsespanSeries::median(self : NlpparsespanSeries) -> Double { @_common.median(self.vals) }

pub fn NlpparsespanSeries::scale(self : NlpparsespanSeries, f : Double) -> NlpparsespanSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlpparsespanSeries::add(self : NlpparsespanSeries, other : NlpparsespanSeries) -> NlpparsespanSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlpparsespanSeries::sub(self : NlpparsespanSeries, other : NlpparsespanSeries) -> NlpparsespanSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlpparsespanSeries::normalize(self : NlpparsespanSeries) -> NlpparsespanSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlpparsespanSeries::cumsum(self : NlpparsespanSeries) -> NlpparsespanSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlpparsespanSeries::to_string(self : NlpparsespanSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpparsespanMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_parse_span_make_matrix(rows : Int, cols : Int, val : Double) -> NlpparsespanMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn nlp_parse_span_matrix_identity(n : Int) -> NlpparsespanMatrix {
  let m = nlp_parse_span_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlpparsespanMatrix::get(self : NlpparsespanMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlpparsespanMatrix::transpose(self : NlpparsespanMatrix) -> NlpparsespanMatrix {
  let result = nlp_parse_span_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlpparsespanMatrix::add(self : NlpparsespanMatrix, other : NlpparsespanMatrix) -> NlpparsespanMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_parse_span_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlpparsespanMatrix::scale(self : NlpparsespanMatrix, s : Double) -> NlpparsespanMatrix {
  let result = nlp_parse_span_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlpparsespanMatrix::multiply(self : NlpparsespanMatrix, other : NlpparsespanMatrix) -> NlpparsespanMatrix {
  if self.cols != other.rows { return nlp_parse_span_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_parse_span_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn NlpparsespanMatrix::trace(self : NlpparsespanMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlpparsespanMatrix::det(self : NlpparsespanMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlpparsespanMatrix::norm(self : NlpparsespanMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlpparsespanMatrix::to_string(self : NlpparsespanMatrix) -> String {
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

pub(all) struct NlpparsespanVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_parse_span_make_vector(comps : Array[Double]) -> NlpparsespanVector {
  { comps, dim: comps.length() }
}

pub fn nlp_parse_span_vector_zero(dim : Int) -> NlpparsespanVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlpparsespanVector::add(self : NlpparsespanVector, other : NlpparsespanVector) -> NlpparsespanVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlpparsespanVector::sub(self : NlpparsespanVector, other : NlpparsespanVector) -> NlpparsespanVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlpparsespanVector::scale(self : NlpparsespanVector, s : Double) -> NlpparsespanVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlpparsespanVector::dot(self : NlpparsespanVector, other : NlpparsespanVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlpparsespanVector::norm(self : NlpparsespanVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlpparsespanVector::normalize(self : NlpparsespanVector) -> NlpparsespanVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpparsespanVector::dist(self : NlpparsespanVector, other : NlpparsespanVector) -> Double {
  self.sub(other).norm()
}

pub fn NlpparsespanVector::to_string(self : NlpparsespanVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpparsespanFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_span_frame_make(size : Int) -> NlpparsespanFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsespanFrame::len(self : NlpparsespanFrame) -> Int { self.size }

pub fn NlpparsespanFrame::get(self : NlpparsespanFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsespanFrame::set(self : NlpparsespanFrame, i : Int, v : Double) -> NlpparsespanFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsespanFrame::sum(self : NlpparsespanFrame) -> Double { @_common.sum(self.data) }

pub fn NlpparsespanFrame::mean(self : NlpparsespanFrame) -> Double { @_common.mean(self.data) }

pub fn NlpparsespanFrame::scale(self : NlpparsespanFrame, f : Double) -> NlpparsespanFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsespanFrame::add(self : NlpparsespanFrame, other : NlpparsespanFrame) -> NlpparsespanFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsespanFrame::copy(self : NlpparsespanFrame) -> NlpparsespanFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsespanFrame::fill(self : NlpparsespanFrame, v : Double) -> NlpparsespanFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsespanFrame::min(self : NlpparsespanFrame) -> Double { @_common.min(self.data) }

pub fn NlpparsespanFrame::max(self : NlpparsespanFrame) -> Double { @_common.max(self.data) }

pub fn NlpparsespanFrame::to_string(self : NlpparsespanFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsespanTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_span_table_make(size : Int) -> NlpparsespanTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsespanTable::len(self : NlpparsespanTable) -> Int { self.size }

pub fn NlpparsespanTable::get(self : NlpparsespanTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsespanTable::set(self : NlpparsespanTable, i : Int, v : Double) -> NlpparsespanTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsespanTable::sum(self : NlpparsespanTable) -> Double { @_common.sum(self.data) }

pub fn NlpparsespanTable::mean(self : NlpparsespanTable) -> Double { @_common.mean(self.data) }

pub fn NlpparsespanTable::scale(self : NlpparsespanTable, f : Double) -> NlpparsespanTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsespanTable::add(self : NlpparsespanTable, other : NlpparsespanTable) -> NlpparsespanTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsespanTable::copy(self : NlpparsespanTable) -> NlpparsespanTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsespanTable::fill(self : NlpparsespanTable, v : Double) -> NlpparsespanTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsespanTable::min(self : NlpparsespanTable) -> Double { @_common.min(self.data) }

pub fn NlpparsespanTable::max(self : NlpparsespanTable) -> Double { @_common.max(self.data) }

pub fn NlpparsespanTable::to_string(self : NlpparsespanTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsespanGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_span_graphn_make(size : Int) -> NlpparsespanGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsespanGraphN::len(self : NlpparsespanGraphN) -> Int { self.size }

pub fn NlpparsespanGraphN::get(self : NlpparsespanGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsespanGraphN::set(self : NlpparsespanGraphN, i : Int, v : Double) -> NlpparsespanGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsespanGraphN::sum(self : NlpparsespanGraphN) -> Double { @_common.sum(self.data) }

pub fn NlpparsespanGraphN::mean(self : NlpparsespanGraphN) -> Double { @_common.mean(self.data) }

pub fn NlpparsespanGraphN::scale(self : NlpparsespanGraphN, f : Double) -> NlpparsespanGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsespanGraphN::add(self : NlpparsespanGraphN, other : NlpparsespanGraphN) -> NlpparsespanGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsespanGraphN::copy(self : NlpparsespanGraphN) -> NlpparsespanGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsespanGraphN::fill(self : NlpparsespanGraphN, v : Double) -> NlpparsespanGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsespanGraphN::min(self : NlpparsespanGraphN) -> Double { @_common.min(self.data) }

pub fn NlpparsespanGraphN::max(self : NlpparsespanGraphN) -> Double { @_common.max(self.data) }

pub fn NlpparsespanGraphN::to_string(self : NlpparsespanGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsespanNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_span_node_make(size : Int) -> NlpparsespanNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsespanNode::len(self : NlpparsespanNode) -> Int { self.size }

pub fn NlpparsespanNode::get(self : NlpparsespanNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsespanNode::set(self : NlpparsespanNode, i : Int, v : Double) -> NlpparsespanNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsespanNode::sum(self : NlpparsespanNode) -> Double { @_common.sum(self.data) }

pub fn NlpparsespanNode::mean(self : NlpparsespanNode) -> Double { @_common.mean(self.data) }

pub fn NlpparsespanNode::scale(self : NlpparsespanNode, f : Double) -> NlpparsespanNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsespanNode::add(self : NlpparsespanNode, other : NlpparsespanNode) -> NlpparsespanNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsespanNode::copy(self : NlpparsespanNode) -> NlpparsespanNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsespanNode::fill(self : NlpparsespanNode, v : Double) -> NlpparsespanNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsespanNode::min(self : NlpparsespanNode) -> Double { @_common.min(self.data) }

pub fn NlpparsespanNode::max(self : NlpparsespanNode) -> Double { @_common.max(self.data) }

pub fn NlpparsespanNode::to_string(self : NlpparsespanNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsespanEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_span_edge_make(size : Int) -> NlpparsespanEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsespanEdge::len(self : NlpparsespanEdge) -> Int { self.size }

pub fn NlpparsespanEdge::get(self : NlpparsespanEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsespanEdge::set(self : NlpparsespanEdge, i : Int, v : Double) -> NlpparsespanEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsespanEdge::sum(self : NlpparsespanEdge) -> Double { @_common.sum(self.data) }

pub fn NlpparsespanEdge::mean(self : NlpparsespanEdge) -> Double { @_common.mean(self.data) }

pub fn NlpparsespanEdge::scale(self : NlpparsespanEdge, f : Double) -> NlpparsespanEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsespanEdge::add(self : NlpparsespanEdge, other : NlpparsespanEdge) -> NlpparsespanEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsespanEdge::copy(self : NlpparsespanEdge) -> NlpparsespanEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsespanEdge::fill(self : NlpparsespanEdge, v : Double) -> NlpparsespanEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsespanEdge::min(self : NlpparsespanEdge) -> Double { @_common.min(self.data) }

pub fn NlpparsespanEdge::max(self : NlpparsespanEdge) -> Double { @_common.max(self.data) }

pub fn NlpparsespanEdge::to_string(self : NlpparsespanEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsespanPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_span_path_make(size : Int) -> NlpparsespanPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsespanPath::len(self : NlpparsespanPath) -> Int { self.size }

pub fn NlpparsespanPath::get(self : NlpparsespanPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsespanPath::set(self : NlpparsespanPath, i : Int, v : Double) -> NlpparsespanPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsespanPath::sum(self : NlpparsespanPath) -> Double { @_common.sum(self.data) }

pub fn NlpparsespanPath::mean(self : NlpparsespanPath) -> Double { @_common.mean(self.data) }

pub fn NlpparsespanPath::scale(self : NlpparsespanPath, f : Double) -> NlpparsespanPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsespanPath::add(self : NlpparsespanPath, other : NlpparsespanPath) -> NlpparsespanPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsespanPath::copy(self : NlpparsespanPath) -> NlpparsespanPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsespanPath::fill(self : NlpparsespanPath, v : Double) -> NlpparsespanPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsespanPath::min(self : NlpparsespanPath) -> Double { @_common.min(self.data) }

pub fn NlpparsespanPath::max(self : NlpparsespanPath) -> Double { @_common.max(self.data) }

pub fn NlpparsespanPath::to_string(self : NlpparsespanPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsespanCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_span_cluster_make(size : Int) -> NlpparsespanCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsespanCluster::len(self : NlpparsespanCluster) -> Int { self.size }

pub fn NlpparsespanCluster::get(self : NlpparsespanCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsespanCluster::set(self : NlpparsespanCluster, i : Int, v : Double) -> NlpparsespanCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsespanCluster::sum(self : NlpparsespanCluster) -> Double { @_common.sum(self.data) }

pub fn NlpparsespanCluster::mean(self : NlpparsespanCluster) -> Double { @_common.mean(self.data) }

pub fn NlpparsespanCluster::scale(self : NlpparsespanCluster, f : Double) -> NlpparsespanCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsespanCluster::add(self : NlpparsespanCluster, other : NlpparsespanCluster) -> NlpparsespanCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsespanCluster::copy(self : NlpparsespanCluster) -> NlpparsespanCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsespanCluster::fill(self : NlpparsespanCluster, v : Double) -> NlpparsespanCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsespanCluster::min(self : NlpparsespanCluster) -> Double { @_common.min(self.data) }

pub fn NlpparsespanCluster::max(self : NlpparsespanCluster) -> Double { @_common.max(self.data) }

pub fn NlpparsespanCluster::to_string(self : NlpparsespanCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsespanModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_span_model_make(size : Int) -> NlpparsespanModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsespanModel::len(self : NlpparsespanModel) -> Int { self.size }

pub fn NlpparsespanModel::get(self : NlpparsespanModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsespanModel::set(self : NlpparsespanModel, i : Int, v : Double) -> NlpparsespanModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsespanModel::sum(self : NlpparsespanModel) -> Double { @_common.sum(self.data) }

pub fn NlpparsespanModel::mean(self : NlpparsespanModel) -> Double { @_common.mean(self.data) }

pub fn NlpparsespanModel::scale(self : NlpparsespanModel, f : Double) -> NlpparsespanModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsespanModel::add(self : NlpparsespanModel, other : NlpparsespanModel) -> NlpparsespanModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsespanModel::copy(self : NlpparsespanModel) -> NlpparsespanModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsespanModel::fill(self : NlpparsespanModel, v : Double) -> NlpparsespanModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsespanModel::min(self : NlpparsespanModel) -> Double { @_common.min(self.data) }

pub fn NlpparsespanModel::max(self : NlpparsespanModel) -> Double { @_common.max(self.data) }

pub fn NlpparsespanModel::to_string(self : NlpparsespanModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsespanLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_span_layer_make(size : Int) -> NlpparsespanLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsespanLayer::len(self : NlpparsespanLayer) -> Int { self.size }

pub fn NlpparsespanLayer::get(self : NlpparsespanLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsespanLayer::set(self : NlpparsespanLayer, i : Int, v : Double) -> NlpparsespanLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsespanLayer::sum(self : NlpparsespanLayer) -> Double { @_common.sum(self.data) }

pub fn NlpparsespanLayer::mean(self : NlpparsespanLayer) -> Double { @_common.mean(self.data) }

pub fn NlpparsespanLayer::scale(self : NlpparsespanLayer, f : Double) -> NlpparsespanLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsespanLayer::add(self : NlpparsespanLayer, other : NlpparsespanLayer) -> NlpparsespanLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsespanLayer::copy(self : NlpparsespanLayer) -> NlpparsespanLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsespanLayer::fill(self : NlpparsespanLayer, v : Double) -> NlpparsespanLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsespanLayer::min(self : NlpparsespanLayer) -> Double { @_common.min(self.data) }

pub fn NlpparsespanLayer::max(self : NlpparsespanLayer) -> Double { @_common.max(self.data) }

pub fn NlpparsespanLayer::to_string(self : NlpparsespanLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsespanBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_span_buffer_make(size : Int) -> NlpparsespanBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsespanBuffer::len(self : NlpparsespanBuffer) -> Int { self.size }

pub fn NlpparsespanBuffer::get(self : NlpparsespanBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsespanBuffer::set(self : NlpparsespanBuffer, i : Int, v : Double) -> NlpparsespanBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsespanBuffer::sum(self : NlpparsespanBuffer) -> Double { @_common.sum(self.data) }

pub fn NlpparsespanBuffer::mean(self : NlpparsespanBuffer) -> Double { @_common.mean(self.data) }

pub fn NlpparsespanBuffer::scale(self : NlpparsespanBuffer, f : Double) -> NlpparsespanBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsespanBuffer::add(self : NlpparsespanBuffer, other : NlpparsespanBuffer) -> NlpparsespanBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsespanBuffer::copy(self : NlpparsespanBuffer) -> NlpparsespanBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsespanBuffer::fill(self : NlpparsespanBuffer, v : Double) -> NlpparsespanBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsespanBuffer::min(self : NlpparsespanBuffer) -> Double { @_common.min(self.data) }

pub fn NlpparsespanBuffer::max(self : NlpparsespanBuffer) -> Double { @_common.max(self.data) }

pub fn NlpparsespanBuffer::to_string(self : NlpparsespanBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsespanCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_span_cursor_make(size : Int) -> NlpparsespanCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsespanCursor::len(self : NlpparsespanCursor) -> Int { self.size }

pub fn NlpparsespanCursor::get(self : NlpparsespanCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsespanCursor::set(self : NlpparsespanCursor, i : Int, v : Double) -> NlpparsespanCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsespanCursor::sum(self : NlpparsespanCursor) -> Double { @_common.sum(self.data) }

pub fn NlpparsespanCursor::mean(self : NlpparsespanCursor) -> Double { @_common.mean(self.data) }

pub fn NlpparsespanCursor::scale(self : NlpparsespanCursor, f : Double) -> NlpparsespanCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsespanCursor::add(self : NlpparsespanCursor, other : NlpparsespanCursor) -> NlpparsespanCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsespanCursor::copy(self : NlpparsespanCursor) -> NlpparsespanCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsespanCursor::fill(self : NlpparsespanCursor, v : Double) -> NlpparsespanCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsespanCursor::min(self : NlpparsespanCursor) -> Double { @_common.min(self.data) }

pub fn NlpparsespanCursor::max(self : NlpparsespanCursor) -> Double { @_common.max(self.data) }

pub fn NlpparsespanCursor::to_string(self : NlpparsespanCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsespanView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_span_view_make(size : Int) -> NlpparsespanView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsespanView::len(self : NlpparsespanView) -> Int { self.size }

pub fn NlpparsespanView::get(self : NlpparsespanView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsespanView::set(self : NlpparsespanView, i : Int, v : Double) -> NlpparsespanView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsespanView::sum(self : NlpparsespanView) -> Double { @_common.sum(self.data) }

pub fn NlpparsespanView::mean(self : NlpparsespanView) -> Double { @_common.mean(self.data) }

pub fn NlpparsespanView::scale(self : NlpparsespanView, f : Double) -> NlpparsespanView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsespanView::add(self : NlpparsespanView, other : NlpparsespanView) -> NlpparsespanView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsespanView::copy(self : NlpparsespanView) -> NlpparsespanView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsespanView::fill(self : NlpparsespanView, v : Double) -> NlpparsespanView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsespanView::min(self : NlpparsespanView) -> Double { @_common.min(self.data) }

pub fn NlpparsespanView::max(self : NlpparsespanView) -> Double { @_common.max(self.data) }

pub fn NlpparsespanView::to_string(self : NlpparsespanView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsespanRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_span_range_make(size : Int) -> NlpparsespanRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsespanRange::len(self : NlpparsespanRange) -> Int { self.size }

pub fn NlpparsespanRange::get(self : NlpparsespanRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsespanRange::set(self : NlpparsespanRange, i : Int, v : Double) -> NlpparsespanRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsespanRange::sum(self : NlpparsespanRange) -> Double { @_common.sum(self.data) }

pub fn NlpparsespanRange::mean(self : NlpparsespanRange) -> Double { @_common.mean(self.data) }

pub fn NlpparsespanRange::scale(self : NlpparsespanRange, f : Double) -> NlpparsespanRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsespanRange::add(self : NlpparsespanRange, other : NlpparsespanRange) -> NlpparsespanRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsespanRange::copy(self : NlpparsespanRange) -> NlpparsespanRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsespanRange::fill(self : NlpparsespanRange, v : Double) -> NlpparsespanRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsespanRange::min(self : NlpparsespanRange) -> Double { @_common.min(self.data) }

pub fn NlpparsespanRange::max(self : NlpparsespanRange) -> Double { @_common.max(self.data) }

pub fn NlpparsespanRange::to_string(self : NlpparsespanRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpparsespanSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_span_slice_make(size : Int) -> NlpparsespanSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpparsespanSlice::len(self : NlpparsespanSlice) -> Int { self.size }

pub fn NlpparsespanSlice::get(self : NlpparsespanSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpparsespanSlice::set(self : NlpparsespanSlice, i : Int, v : Double) -> NlpparsespanSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpparsespanSlice::sum(self : NlpparsespanSlice) -> Double { @_common.sum(self.data) }

pub fn NlpparsespanSlice::mean(self : NlpparsespanSlice) -> Double { @_common.mean(self.data) }

pub fn NlpparsespanSlice::scale(self : NlpparsespanSlice, f : Double) -> NlpparsespanSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpparsespanSlice::add(self : NlpparsespanSlice, other : NlpparsespanSlice) -> NlpparsespanSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpparsespanSlice::copy(self : NlpparsespanSlice) -> NlpparsespanSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpparsespanSlice::fill(self : NlpparsespanSlice, v : Double) -> NlpparsespanSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpparsespanSlice::min(self : NlpparsespanSlice) -> Double { @_common.min(self.data) }

pub fn NlpparsespanSlice::max(self : NlpparsespanSlice) -> Double { @_common.max(self.data) }

pub fn NlpparsespanSlice::to_string(self : NlpparsespanSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

