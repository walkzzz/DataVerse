///===
/// extcore/nlp_pos_hmm

pub(all) struct NlpposhmmPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_pos_hmm_make_point(x : Double, y : Double) -> NlpposhmmPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_pos_hmm_make_point3(x : Double, y : Double, z : Double) -> NlpposhmmPoint {
  { x, y, z, label: 0 }
}

pub fn NlpposhmmPoint::x(self : NlpposhmmPoint) -> Double { self.x }

pub fn NlpposhmmPoint::y(self : NlpposhmmPoint) -> Double { self.y }

pub fn NlpposhmmPoint::z(self : NlpposhmmPoint) -> Double { self.z }

pub fn NlpposhmmPoint::label(self : NlpposhmmPoint) -> Int { self.label }

pub fn NlpposhmmPoint::dist(self : NlpposhmmPoint, other : NlpposhmmPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlpposhmmPoint::add(self : NlpposhmmPoint, other : NlpposhmmPoint) -> NlpposhmmPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlpposhmmPoint::sub(self : NlpposhmmPoint, other : NlpposhmmPoint) -> NlpposhmmPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlpposhmmPoint::scale(self : NlpposhmmPoint, s : Double) -> NlpposhmmPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlpposhmmPoint::dot(self : NlpposhmmPoint, other : NlpposhmmPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlpposhmmPoint::cross(self : NlpposhmmPoint, other : NlpposhmmPoint) -> NlpposhmmPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlpposhmmPoint::norm(self : NlpposhmmPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlpposhmmPoint::normalize(self : NlpposhmmPoint) -> NlpposhmmPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpposhmmPoint::negate(self : NlpposhmmPoint) -> NlpposhmmPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlpposhmmPoint::mid(self : NlpposhmmPoint, other : NlpposhmmPoint) -> NlpposhmmPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlpposhmmPoint::lerp(self : NlpposhmmPoint, other : NlpposhmmPoint, t : Double) -> NlpposhmmPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlpposhmmPoint::to_string(self : NlpposhmmPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlpposhmmSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_pos_hmm_make_series(vals : Array[Double], name : String) -> NlpposhmmSeries {
  { vals, name, meta: 0 }
}

pub fn NlpposhmmSeries::len(self : NlpposhmmSeries) -> Int { self.vals.length() }

pub fn NlpposhmmSeries::sum(self : NlpposhmmSeries) -> Double { @_common.sum(self.vals) }

pub fn NlpposhmmSeries::mean(self : NlpposhmmSeries) -> Double { @_common.mean(self.vals) }

pub fn NlpposhmmSeries::min(self : NlpposhmmSeries) -> Double { @_common.min(self.vals) }

pub fn NlpposhmmSeries::max(self : NlpposhmmSeries) -> Double { @_common.max(self.vals) }

pub fn NlpposhmmSeries::range(self : NlpposhmmSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlpposhmmSeries::variance(self : NlpposhmmSeries) -> Double { @_common.variance(self.vals) }

pub fn NlpposhmmSeries::std(self : NlpposhmmSeries) -> Double { @_common.std(self.vals) }

pub fn NlpposhmmSeries::median(self : NlpposhmmSeries) -> Double { @_common.median(self.vals) }

pub fn NlpposhmmSeries::scale(self : NlpposhmmSeries, f : Double) -> NlpposhmmSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlpposhmmSeries::add(self : NlpposhmmSeries, other : NlpposhmmSeries) -> NlpposhmmSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlpposhmmSeries::sub(self : NlpposhmmSeries, other : NlpposhmmSeries) -> NlpposhmmSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlpposhmmSeries::normalize(self : NlpposhmmSeries) -> NlpposhmmSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlpposhmmSeries::cumsum(self : NlpposhmmSeries) -> NlpposhmmSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlpposhmmSeries::to_string(self : NlpposhmmSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpposhmmMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_pos_hmm_make_matrix(rows : Int, cols : Int, val : Double) -> NlpposhmmMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn nlp_pos_hmm_matrix_identity(n : Int) -> NlpposhmmMatrix {
  let m = nlp_pos_hmm_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlpposhmmMatrix::get(self : NlpposhmmMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlpposhmmMatrix::transpose(self : NlpposhmmMatrix) -> NlpposhmmMatrix {
  let result = nlp_pos_hmm_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlpposhmmMatrix::add(self : NlpposhmmMatrix, other : NlpposhmmMatrix) -> NlpposhmmMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_pos_hmm_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlpposhmmMatrix::scale(self : NlpposhmmMatrix, s : Double) -> NlpposhmmMatrix {
  let result = nlp_pos_hmm_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlpposhmmMatrix::multiply(self : NlpposhmmMatrix, other : NlpposhmmMatrix) -> NlpposhmmMatrix {
  if self.cols != other.rows { return nlp_pos_hmm_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_pos_hmm_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn NlpposhmmMatrix::trace(self : NlpposhmmMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlpposhmmMatrix::det(self : NlpposhmmMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlpposhmmMatrix::norm(self : NlpposhmmMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlpposhmmMatrix::to_string(self : NlpposhmmMatrix) -> String {
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

pub(all) struct NlpposhmmVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_pos_hmm_make_vector(comps : Array[Double]) -> NlpposhmmVector {
  { comps, dim: comps.length() }
}

pub fn nlp_pos_hmm_vector_zero(dim : Int) -> NlpposhmmVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlpposhmmVector::add(self : NlpposhmmVector, other : NlpposhmmVector) -> NlpposhmmVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlpposhmmVector::sub(self : NlpposhmmVector, other : NlpposhmmVector) -> NlpposhmmVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlpposhmmVector::scale(self : NlpposhmmVector, s : Double) -> NlpposhmmVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlpposhmmVector::dot(self : NlpposhmmVector, other : NlpposhmmVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlpposhmmVector::norm(self : NlpposhmmVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlpposhmmVector::normalize(self : NlpposhmmVector) -> NlpposhmmVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpposhmmVector::dist(self : NlpposhmmVector, other : NlpposhmmVector) -> Double {
  self.sub(other).norm()
}

pub fn NlpposhmmVector::to_string(self : NlpposhmmVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpposhmmFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_hmm_frame_make(size : Int) -> NlpposhmmFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposhmmFrame::len(self : NlpposhmmFrame) -> Int { self.size }

pub fn NlpposhmmFrame::get(self : NlpposhmmFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposhmmFrame::set(self : NlpposhmmFrame, i : Int, v : Double) -> NlpposhmmFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposhmmFrame::sum(self : NlpposhmmFrame) -> Double { @_common.sum(self.data) }

pub fn NlpposhmmFrame::mean(self : NlpposhmmFrame) -> Double { @_common.mean(self.data) }

pub fn NlpposhmmFrame::scale(self : NlpposhmmFrame, f : Double) -> NlpposhmmFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposhmmFrame::add(self : NlpposhmmFrame, other : NlpposhmmFrame) -> NlpposhmmFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposhmmFrame::copy(self : NlpposhmmFrame) -> NlpposhmmFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposhmmFrame::fill(self : NlpposhmmFrame, v : Double) -> NlpposhmmFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposhmmFrame::min(self : NlpposhmmFrame) -> Double { @_common.min(self.data) }

pub fn NlpposhmmFrame::max(self : NlpposhmmFrame) -> Double { @_common.max(self.data) }

pub fn NlpposhmmFrame::to_string(self : NlpposhmmFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposhmmTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_hmm_table_make(size : Int) -> NlpposhmmTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposhmmTable::len(self : NlpposhmmTable) -> Int { self.size }

pub fn NlpposhmmTable::get(self : NlpposhmmTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposhmmTable::set(self : NlpposhmmTable, i : Int, v : Double) -> NlpposhmmTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposhmmTable::sum(self : NlpposhmmTable) -> Double { @_common.sum(self.data) }

pub fn NlpposhmmTable::mean(self : NlpposhmmTable) -> Double { @_common.mean(self.data) }

pub fn NlpposhmmTable::scale(self : NlpposhmmTable, f : Double) -> NlpposhmmTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposhmmTable::add(self : NlpposhmmTable, other : NlpposhmmTable) -> NlpposhmmTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposhmmTable::copy(self : NlpposhmmTable) -> NlpposhmmTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposhmmTable::fill(self : NlpposhmmTable, v : Double) -> NlpposhmmTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposhmmTable::min(self : NlpposhmmTable) -> Double { @_common.min(self.data) }

pub fn NlpposhmmTable::max(self : NlpposhmmTable) -> Double { @_common.max(self.data) }

pub fn NlpposhmmTable::to_string(self : NlpposhmmTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposhmmGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_hmm_graphn_make(size : Int) -> NlpposhmmGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposhmmGraphN::len(self : NlpposhmmGraphN) -> Int { self.size }

pub fn NlpposhmmGraphN::get(self : NlpposhmmGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposhmmGraphN::set(self : NlpposhmmGraphN, i : Int, v : Double) -> NlpposhmmGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposhmmGraphN::sum(self : NlpposhmmGraphN) -> Double { @_common.sum(self.data) }

pub fn NlpposhmmGraphN::mean(self : NlpposhmmGraphN) -> Double { @_common.mean(self.data) }

pub fn NlpposhmmGraphN::scale(self : NlpposhmmGraphN, f : Double) -> NlpposhmmGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposhmmGraphN::add(self : NlpposhmmGraphN, other : NlpposhmmGraphN) -> NlpposhmmGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposhmmGraphN::copy(self : NlpposhmmGraphN) -> NlpposhmmGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposhmmGraphN::fill(self : NlpposhmmGraphN, v : Double) -> NlpposhmmGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposhmmGraphN::min(self : NlpposhmmGraphN) -> Double { @_common.min(self.data) }

pub fn NlpposhmmGraphN::max(self : NlpposhmmGraphN) -> Double { @_common.max(self.data) }

pub fn NlpposhmmGraphN::to_string(self : NlpposhmmGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposhmmNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_hmm_node_make(size : Int) -> NlpposhmmNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposhmmNode::len(self : NlpposhmmNode) -> Int { self.size }

pub fn NlpposhmmNode::get(self : NlpposhmmNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposhmmNode::set(self : NlpposhmmNode, i : Int, v : Double) -> NlpposhmmNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposhmmNode::sum(self : NlpposhmmNode) -> Double { @_common.sum(self.data) }

pub fn NlpposhmmNode::mean(self : NlpposhmmNode) -> Double { @_common.mean(self.data) }

pub fn NlpposhmmNode::scale(self : NlpposhmmNode, f : Double) -> NlpposhmmNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposhmmNode::add(self : NlpposhmmNode, other : NlpposhmmNode) -> NlpposhmmNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposhmmNode::copy(self : NlpposhmmNode) -> NlpposhmmNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposhmmNode::fill(self : NlpposhmmNode, v : Double) -> NlpposhmmNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposhmmNode::min(self : NlpposhmmNode) -> Double { @_common.min(self.data) }

pub fn NlpposhmmNode::max(self : NlpposhmmNode) -> Double { @_common.max(self.data) }

pub fn NlpposhmmNode::to_string(self : NlpposhmmNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposhmmEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_hmm_edge_make(size : Int) -> NlpposhmmEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposhmmEdge::len(self : NlpposhmmEdge) -> Int { self.size }

pub fn NlpposhmmEdge::get(self : NlpposhmmEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposhmmEdge::set(self : NlpposhmmEdge, i : Int, v : Double) -> NlpposhmmEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposhmmEdge::sum(self : NlpposhmmEdge) -> Double { @_common.sum(self.data) }

pub fn NlpposhmmEdge::mean(self : NlpposhmmEdge) -> Double { @_common.mean(self.data) }

pub fn NlpposhmmEdge::scale(self : NlpposhmmEdge, f : Double) -> NlpposhmmEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposhmmEdge::add(self : NlpposhmmEdge, other : NlpposhmmEdge) -> NlpposhmmEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposhmmEdge::copy(self : NlpposhmmEdge) -> NlpposhmmEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposhmmEdge::fill(self : NlpposhmmEdge, v : Double) -> NlpposhmmEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposhmmEdge::min(self : NlpposhmmEdge) -> Double { @_common.min(self.data) }

pub fn NlpposhmmEdge::max(self : NlpposhmmEdge) -> Double { @_common.max(self.data) }

pub fn NlpposhmmEdge::to_string(self : NlpposhmmEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposhmmPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_hmm_path_make(size : Int) -> NlpposhmmPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposhmmPath::len(self : NlpposhmmPath) -> Int { self.size }

pub fn NlpposhmmPath::get(self : NlpposhmmPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposhmmPath::set(self : NlpposhmmPath, i : Int, v : Double) -> NlpposhmmPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposhmmPath::sum(self : NlpposhmmPath) -> Double { @_common.sum(self.data) }

pub fn NlpposhmmPath::mean(self : NlpposhmmPath) -> Double { @_common.mean(self.data) }

pub fn NlpposhmmPath::scale(self : NlpposhmmPath, f : Double) -> NlpposhmmPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposhmmPath::add(self : NlpposhmmPath, other : NlpposhmmPath) -> NlpposhmmPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposhmmPath::copy(self : NlpposhmmPath) -> NlpposhmmPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposhmmPath::fill(self : NlpposhmmPath, v : Double) -> NlpposhmmPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposhmmPath::min(self : NlpposhmmPath) -> Double { @_common.min(self.data) }

pub fn NlpposhmmPath::max(self : NlpposhmmPath) -> Double { @_common.max(self.data) }

pub fn NlpposhmmPath::to_string(self : NlpposhmmPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposhmmCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_hmm_cluster_make(size : Int) -> NlpposhmmCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposhmmCluster::len(self : NlpposhmmCluster) -> Int { self.size }

pub fn NlpposhmmCluster::get(self : NlpposhmmCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposhmmCluster::set(self : NlpposhmmCluster, i : Int, v : Double) -> NlpposhmmCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposhmmCluster::sum(self : NlpposhmmCluster) -> Double { @_common.sum(self.data) }

pub fn NlpposhmmCluster::mean(self : NlpposhmmCluster) -> Double { @_common.mean(self.data) }

pub fn NlpposhmmCluster::scale(self : NlpposhmmCluster, f : Double) -> NlpposhmmCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposhmmCluster::add(self : NlpposhmmCluster, other : NlpposhmmCluster) -> NlpposhmmCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposhmmCluster::copy(self : NlpposhmmCluster) -> NlpposhmmCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposhmmCluster::fill(self : NlpposhmmCluster, v : Double) -> NlpposhmmCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposhmmCluster::min(self : NlpposhmmCluster) -> Double { @_common.min(self.data) }

pub fn NlpposhmmCluster::max(self : NlpposhmmCluster) -> Double { @_common.max(self.data) }

pub fn NlpposhmmCluster::to_string(self : NlpposhmmCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposhmmModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_hmm_model_make(size : Int) -> NlpposhmmModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposhmmModel::len(self : NlpposhmmModel) -> Int { self.size }

pub fn NlpposhmmModel::get(self : NlpposhmmModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposhmmModel::set(self : NlpposhmmModel, i : Int, v : Double) -> NlpposhmmModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposhmmModel::sum(self : NlpposhmmModel) -> Double { @_common.sum(self.data) }

pub fn NlpposhmmModel::mean(self : NlpposhmmModel) -> Double { @_common.mean(self.data) }

pub fn NlpposhmmModel::scale(self : NlpposhmmModel, f : Double) -> NlpposhmmModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposhmmModel::add(self : NlpposhmmModel, other : NlpposhmmModel) -> NlpposhmmModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposhmmModel::copy(self : NlpposhmmModel) -> NlpposhmmModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposhmmModel::fill(self : NlpposhmmModel, v : Double) -> NlpposhmmModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposhmmModel::min(self : NlpposhmmModel) -> Double { @_common.min(self.data) }

pub fn NlpposhmmModel::max(self : NlpposhmmModel) -> Double { @_common.max(self.data) }

pub fn NlpposhmmModel::to_string(self : NlpposhmmModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposhmmLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_hmm_layer_make(size : Int) -> NlpposhmmLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposhmmLayer::len(self : NlpposhmmLayer) -> Int { self.size }

pub fn NlpposhmmLayer::get(self : NlpposhmmLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposhmmLayer::set(self : NlpposhmmLayer, i : Int, v : Double) -> NlpposhmmLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposhmmLayer::sum(self : NlpposhmmLayer) -> Double { @_common.sum(self.data) }

pub fn NlpposhmmLayer::mean(self : NlpposhmmLayer) -> Double { @_common.mean(self.data) }

pub fn NlpposhmmLayer::scale(self : NlpposhmmLayer, f : Double) -> NlpposhmmLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposhmmLayer::add(self : NlpposhmmLayer, other : NlpposhmmLayer) -> NlpposhmmLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposhmmLayer::copy(self : NlpposhmmLayer) -> NlpposhmmLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposhmmLayer::fill(self : NlpposhmmLayer, v : Double) -> NlpposhmmLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposhmmLayer::min(self : NlpposhmmLayer) -> Double { @_common.min(self.data) }

pub fn NlpposhmmLayer::max(self : NlpposhmmLayer) -> Double { @_common.max(self.data) }

pub fn NlpposhmmLayer::to_string(self : NlpposhmmLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposhmmBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_hmm_buffer_make(size : Int) -> NlpposhmmBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposhmmBuffer::len(self : NlpposhmmBuffer) -> Int { self.size }

pub fn NlpposhmmBuffer::get(self : NlpposhmmBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposhmmBuffer::set(self : NlpposhmmBuffer, i : Int, v : Double) -> NlpposhmmBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposhmmBuffer::sum(self : NlpposhmmBuffer) -> Double { @_common.sum(self.data) }

pub fn NlpposhmmBuffer::mean(self : NlpposhmmBuffer) -> Double { @_common.mean(self.data) }

pub fn NlpposhmmBuffer::scale(self : NlpposhmmBuffer, f : Double) -> NlpposhmmBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposhmmBuffer::add(self : NlpposhmmBuffer, other : NlpposhmmBuffer) -> NlpposhmmBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposhmmBuffer::copy(self : NlpposhmmBuffer) -> NlpposhmmBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposhmmBuffer::fill(self : NlpposhmmBuffer, v : Double) -> NlpposhmmBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposhmmBuffer::min(self : NlpposhmmBuffer) -> Double { @_common.min(self.data) }

pub fn NlpposhmmBuffer::max(self : NlpposhmmBuffer) -> Double { @_common.max(self.data) }

pub fn NlpposhmmBuffer::to_string(self : NlpposhmmBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposhmmCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_hmm_cursor_make(size : Int) -> NlpposhmmCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposhmmCursor::len(self : NlpposhmmCursor) -> Int { self.size }

pub fn NlpposhmmCursor::get(self : NlpposhmmCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposhmmCursor::set(self : NlpposhmmCursor, i : Int, v : Double) -> NlpposhmmCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposhmmCursor::sum(self : NlpposhmmCursor) -> Double { @_common.sum(self.data) }

pub fn NlpposhmmCursor::mean(self : NlpposhmmCursor) -> Double { @_common.mean(self.data) }

pub fn NlpposhmmCursor::scale(self : NlpposhmmCursor, f : Double) -> NlpposhmmCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposhmmCursor::add(self : NlpposhmmCursor, other : NlpposhmmCursor) -> NlpposhmmCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposhmmCursor::copy(self : NlpposhmmCursor) -> NlpposhmmCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposhmmCursor::fill(self : NlpposhmmCursor, v : Double) -> NlpposhmmCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposhmmCursor::min(self : NlpposhmmCursor) -> Double { @_common.min(self.data) }

pub fn NlpposhmmCursor::max(self : NlpposhmmCursor) -> Double { @_common.max(self.data) }

pub fn NlpposhmmCursor::to_string(self : NlpposhmmCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposhmmView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_hmm_view_make(size : Int) -> NlpposhmmView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposhmmView::len(self : NlpposhmmView) -> Int { self.size }

pub fn NlpposhmmView::get(self : NlpposhmmView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposhmmView::set(self : NlpposhmmView, i : Int, v : Double) -> NlpposhmmView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposhmmView::sum(self : NlpposhmmView) -> Double { @_common.sum(self.data) }

pub fn NlpposhmmView::mean(self : NlpposhmmView) -> Double { @_common.mean(self.data) }

pub fn NlpposhmmView::scale(self : NlpposhmmView, f : Double) -> NlpposhmmView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposhmmView::add(self : NlpposhmmView, other : NlpposhmmView) -> NlpposhmmView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposhmmView::copy(self : NlpposhmmView) -> NlpposhmmView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposhmmView::fill(self : NlpposhmmView, v : Double) -> NlpposhmmView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposhmmView::min(self : NlpposhmmView) -> Double { @_common.min(self.data) }

pub fn NlpposhmmView::max(self : NlpposhmmView) -> Double { @_common.max(self.data) }

pub fn NlpposhmmView::to_string(self : NlpposhmmView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposhmmRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_hmm_range_make(size : Int) -> NlpposhmmRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposhmmRange::len(self : NlpposhmmRange) -> Int { self.size }

pub fn NlpposhmmRange::get(self : NlpposhmmRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposhmmRange::set(self : NlpposhmmRange, i : Int, v : Double) -> NlpposhmmRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposhmmRange::sum(self : NlpposhmmRange) -> Double { @_common.sum(self.data) }

pub fn NlpposhmmRange::mean(self : NlpposhmmRange) -> Double { @_common.mean(self.data) }

pub fn NlpposhmmRange::scale(self : NlpposhmmRange, f : Double) -> NlpposhmmRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposhmmRange::add(self : NlpposhmmRange, other : NlpposhmmRange) -> NlpposhmmRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposhmmRange::copy(self : NlpposhmmRange) -> NlpposhmmRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposhmmRange::fill(self : NlpposhmmRange, v : Double) -> NlpposhmmRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposhmmRange::min(self : NlpposhmmRange) -> Double { @_common.min(self.data) }

pub fn NlpposhmmRange::max(self : NlpposhmmRange) -> Double { @_common.max(self.data) }

pub fn NlpposhmmRange::to_string(self : NlpposhmmRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposhmmSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_hmm_slice_make(size : Int) -> NlpposhmmSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposhmmSlice::len(self : NlpposhmmSlice) -> Int { self.size }

pub fn NlpposhmmSlice::get(self : NlpposhmmSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposhmmSlice::set(self : NlpposhmmSlice, i : Int, v : Double) -> NlpposhmmSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposhmmSlice::sum(self : NlpposhmmSlice) -> Double { @_common.sum(self.data) }

pub fn NlpposhmmSlice::mean(self : NlpposhmmSlice) -> Double { @_common.mean(self.data) }

pub fn NlpposhmmSlice::scale(self : NlpposhmmSlice, f : Double) -> NlpposhmmSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposhmmSlice::add(self : NlpposhmmSlice, other : NlpposhmmSlice) -> NlpposhmmSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposhmmSlice::copy(self : NlpposhmmSlice) -> NlpposhmmSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposhmmSlice::fill(self : NlpposhmmSlice, v : Double) -> NlpposhmmSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposhmmSlice::min(self : NlpposhmmSlice) -> Double { @_common.min(self.data) }

pub fn NlpposhmmSlice::max(self : NlpposhmmSlice) -> Double { @_common.max(self.data) }

pub fn NlpposhmmSlice::to_string(self : NlpposhmmSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

