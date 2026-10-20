///===
/// extcore/image_filter_bilateral

pub(all) struct ImagefilterbilateralPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_filter_bilateral_make_point(x : Double, y : Double) -> ImagefilterbilateralPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_filter_bilateral_make_point3(x : Double, y : Double, z : Double) -> ImagefilterbilateralPoint {
  { x, y, z, label: 0 }
}

pub fn ImagefilterbilateralPoint::x(self : ImagefilterbilateralPoint) -> Double { self.x }

pub fn ImagefilterbilateralPoint::y(self : ImagefilterbilateralPoint) -> Double { self.y }

pub fn ImagefilterbilateralPoint::z(self : ImagefilterbilateralPoint) -> Double { self.z }

pub fn ImagefilterbilateralPoint::label(self : ImagefilterbilateralPoint) -> Int { self.label }

pub fn ImagefilterbilateralPoint::dist(self : ImagefilterbilateralPoint, other : ImagefilterbilateralPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagefilterbilateralPoint::add(self : ImagefilterbilateralPoint, other : ImagefilterbilateralPoint) -> ImagefilterbilateralPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagefilterbilateralPoint::sub(self : ImagefilterbilateralPoint, other : ImagefilterbilateralPoint) -> ImagefilterbilateralPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagefilterbilateralPoint::scale(self : ImagefilterbilateralPoint, s : Double) -> ImagefilterbilateralPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagefilterbilateralPoint::dot(self : ImagefilterbilateralPoint, other : ImagefilterbilateralPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagefilterbilateralPoint::cross(self : ImagefilterbilateralPoint, other : ImagefilterbilateralPoint) -> ImagefilterbilateralPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagefilterbilateralPoint::norm(self : ImagefilterbilateralPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagefilterbilateralPoint::normalize(self : ImagefilterbilateralPoint) -> ImagefilterbilateralPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefilterbilateralPoint::negate(self : ImagefilterbilateralPoint) -> ImagefilterbilateralPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagefilterbilateralPoint::mid(self : ImagefilterbilateralPoint, other : ImagefilterbilateralPoint) -> ImagefilterbilateralPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagefilterbilateralPoint::lerp(self : ImagefilterbilateralPoint, other : ImagefilterbilateralPoint, t : Double) -> ImagefilterbilateralPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagefilterbilateralPoint::to_string(self : ImagefilterbilateralPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagefilterbilateralSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_filter_bilateral_make_series(vals : Array[Double], name : String) -> ImagefilterbilateralSeries {
  { vals, name, meta: 0 }
}

pub fn ImagefilterbilateralSeries::len(self : ImagefilterbilateralSeries) -> Int { self.vals.length() }

pub fn ImagefilterbilateralSeries::sum(self : ImagefilterbilateralSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagefilterbilateralSeries::mean(self : ImagefilterbilateralSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagefilterbilateralSeries::min(self : ImagefilterbilateralSeries) -> Double { @_common.min(self.vals) }

pub fn ImagefilterbilateralSeries::max(self : ImagefilterbilateralSeries) -> Double { @_common.max(self.vals) }

pub fn ImagefilterbilateralSeries::range(self : ImagefilterbilateralSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagefilterbilateralSeries::variance(self : ImagefilterbilateralSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagefilterbilateralSeries::std(self : ImagefilterbilateralSeries) -> Double { @_common.std(self.vals) }

pub fn ImagefilterbilateralSeries::median(self : ImagefilterbilateralSeries) -> Double { @_common.median(self.vals) }

pub fn ImagefilterbilateralSeries::scale(self : ImagefilterbilateralSeries, f : Double) -> ImagefilterbilateralSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagefilterbilateralSeries::add(self : ImagefilterbilateralSeries, other : ImagefilterbilateralSeries) -> ImagefilterbilateralSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagefilterbilateralSeries::sub(self : ImagefilterbilateralSeries, other : ImagefilterbilateralSeries) -> ImagefilterbilateralSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagefilterbilateralSeries::normalize(self : ImagefilterbilateralSeries) -> ImagefilterbilateralSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagefilterbilateralSeries::cumsum(self : ImagefilterbilateralSeries) -> ImagefilterbilateralSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagefilterbilateralSeries::to_string(self : ImagefilterbilateralSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefilterbilateralMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_filter_bilateral_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefilterbilateralMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_filter_bilateral_matrix_identity(n : Int) -> ImagefilterbilateralMatrix {
  let m = image_filter_bilateral_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagefilterbilateralMatrix::get(self : ImagefilterbilateralMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagefilterbilateralMatrix::transpose(self : ImagefilterbilateralMatrix) -> ImagefilterbilateralMatrix {
  let result = image_filter_bilateral_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagefilterbilateralMatrix::add(self : ImagefilterbilateralMatrix, other : ImagefilterbilateralMatrix) -> ImagefilterbilateralMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_filter_bilateral_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagefilterbilateralMatrix::scale(self : ImagefilterbilateralMatrix, s : Double) -> ImagefilterbilateralMatrix {
  let result = image_filter_bilateral_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagefilterbilateralMatrix::multiply(self : ImagefilterbilateralMatrix, other : ImagefilterbilateralMatrix) -> ImagefilterbilateralMatrix {
  if self.cols != other.rows { return image_filter_bilateral_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_filter_bilateral_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ImagefilterbilateralMatrix::trace(self : ImagefilterbilateralMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagefilterbilateralMatrix::det(self : ImagefilterbilateralMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagefilterbilateralMatrix::norm(self : ImagefilterbilateralMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagefilterbilateralMatrix::to_string(self : ImagefilterbilateralMatrix) -> String {
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

pub(all) struct ImagefilterbilateralVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_filter_bilateral_make_vector(comps : Array[Double]) -> ImagefilterbilateralVector {
  { comps, dim: comps.length() }
}

pub fn image_filter_bilateral_vector_zero(dim : Int) -> ImagefilterbilateralVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagefilterbilateralVector::add(self : ImagefilterbilateralVector, other : ImagefilterbilateralVector) -> ImagefilterbilateralVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefilterbilateralVector::sub(self : ImagefilterbilateralVector, other : ImagefilterbilateralVector) -> ImagefilterbilateralVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefilterbilateralVector::scale(self : ImagefilterbilateralVector, s : Double) -> ImagefilterbilateralVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagefilterbilateralVector::dot(self : ImagefilterbilateralVector, other : ImagefilterbilateralVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagefilterbilateralVector::norm(self : ImagefilterbilateralVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagefilterbilateralVector::normalize(self : ImagefilterbilateralVector) -> ImagefilterbilateralVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefilterbilateralVector::dist(self : ImagefilterbilateralVector, other : ImagefilterbilateralVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagefilterbilateralVector::to_string(self : ImagefilterbilateralVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefilterbilateralFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_bilateral_frame_make(size : Int) -> ImagefilterbilateralFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefilterbilateralFrame::len(self : ImagefilterbilateralFrame) -> Int { self.size }

pub fn ImagefilterbilateralFrame::get(self : ImagefilterbilateralFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefilterbilateralFrame::set(self : ImagefilterbilateralFrame, i : Int, v : Double) -> ImagefilterbilateralFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralFrame::sum(self : ImagefilterbilateralFrame) -> Double { @_common.sum(self.data) }

pub fn ImagefilterbilateralFrame::mean(self : ImagefilterbilateralFrame) -> Double { @_common.mean(self.data) }

pub fn ImagefilterbilateralFrame::scale(self : ImagefilterbilateralFrame, f : Double) -> ImagefilterbilateralFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralFrame::add(self : ImagefilterbilateralFrame, other : ImagefilterbilateralFrame) -> ImagefilterbilateralFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefilterbilateralFrame::copy(self : ImagefilterbilateralFrame) -> ImagefilterbilateralFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralFrame::fill(self : ImagefilterbilateralFrame, v : Double) -> ImagefilterbilateralFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralFrame::min(self : ImagefilterbilateralFrame) -> Double { @_common.min(self.data) }

pub fn ImagefilterbilateralFrame::max(self : ImagefilterbilateralFrame) -> Double { @_common.max(self.data) }

pub fn ImagefilterbilateralFrame::to_string(self : ImagefilterbilateralFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefilterbilateralTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_bilateral_table_make(size : Int) -> ImagefilterbilateralTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefilterbilateralTable::len(self : ImagefilterbilateralTable) -> Int { self.size }

pub fn ImagefilterbilateralTable::get(self : ImagefilterbilateralTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefilterbilateralTable::set(self : ImagefilterbilateralTable, i : Int, v : Double) -> ImagefilterbilateralTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralTable::sum(self : ImagefilterbilateralTable) -> Double { @_common.sum(self.data) }

pub fn ImagefilterbilateralTable::mean(self : ImagefilterbilateralTable) -> Double { @_common.mean(self.data) }

pub fn ImagefilterbilateralTable::scale(self : ImagefilterbilateralTable, f : Double) -> ImagefilterbilateralTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralTable::add(self : ImagefilterbilateralTable, other : ImagefilterbilateralTable) -> ImagefilterbilateralTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefilterbilateralTable::copy(self : ImagefilterbilateralTable) -> ImagefilterbilateralTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralTable::fill(self : ImagefilterbilateralTable, v : Double) -> ImagefilterbilateralTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralTable::min(self : ImagefilterbilateralTable) -> Double { @_common.min(self.data) }

pub fn ImagefilterbilateralTable::max(self : ImagefilterbilateralTable) -> Double { @_common.max(self.data) }

pub fn ImagefilterbilateralTable::to_string(self : ImagefilterbilateralTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefilterbilateralGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_bilateral_graphn_make(size : Int) -> ImagefilterbilateralGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefilterbilateralGraphN::len(self : ImagefilterbilateralGraphN) -> Int { self.size }

pub fn ImagefilterbilateralGraphN::get(self : ImagefilterbilateralGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefilterbilateralGraphN::set(self : ImagefilterbilateralGraphN, i : Int, v : Double) -> ImagefilterbilateralGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralGraphN::sum(self : ImagefilterbilateralGraphN) -> Double { @_common.sum(self.data) }

pub fn ImagefilterbilateralGraphN::mean(self : ImagefilterbilateralGraphN) -> Double { @_common.mean(self.data) }

pub fn ImagefilterbilateralGraphN::scale(self : ImagefilterbilateralGraphN, f : Double) -> ImagefilterbilateralGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralGraphN::add(self : ImagefilterbilateralGraphN, other : ImagefilterbilateralGraphN) -> ImagefilterbilateralGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefilterbilateralGraphN::copy(self : ImagefilterbilateralGraphN) -> ImagefilterbilateralGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralGraphN::fill(self : ImagefilterbilateralGraphN, v : Double) -> ImagefilterbilateralGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralGraphN::min(self : ImagefilterbilateralGraphN) -> Double { @_common.min(self.data) }

pub fn ImagefilterbilateralGraphN::max(self : ImagefilterbilateralGraphN) -> Double { @_common.max(self.data) }

pub fn ImagefilterbilateralGraphN::to_string(self : ImagefilterbilateralGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefilterbilateralNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_bilateral_node_make(size : Int) -> ImagefilterbilateralNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefilterbilateralNode::len(self : ImagefilterbilateralNode) -> Int { self.size }

pub fn ImagefilterbilateralNode::get(self : ImagefilterbilateralNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefilterbilateralNode::set(self : ImagefilterbilateralNode, i : Int, v : Double) -> ImagefilterbilateralNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralNode::sum(self : ImagefilterbilateralNode) -> Double { @_common.sum(self.data) }

pub fn ImagefilterbilateralNode::mean(self : ImagefilterbilateralNode) -> Double { @_common.mean(self.data) }

pub fn ImagefilterbilateralNode::scale(self : ImagefilterbilateralNode, f : Double) -> ImagefilterbilateralNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralNode::add(self : ImagefilterbilateralNode, other : ImagefilterbilateralNode) -> ImagefilterbilateralNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefilterbilateralNode::copy(self : ImagefilterbilateralNode) -> ImagefilterbilateralNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralNode::fill(self : ImagefilterbilateralNode, v : Double) -> ImagefilterbilateralNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralNode::min(self : ImagefilterbilateralNode) -> Double { @_common.min(self.data) }

pub fn ImagefilterbilateralNode::max(self : ImagefilterbilateralNode) -> Double { @_common.max(self.data) }

pub fn ImagefilterbilateralNode::to_string(self : ImagefilterbilateralNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefilterbilateralEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_bilateral_edge_make(size : Int) -> ImagefilterbilateralEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefilterbilateralEdge::len(self : ImagefilterbilateralEdge) -> Int { self.size }

pub fn ImagefilterbilateralEdge::get(self : ImagefilterbilateralEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefilterbilateralEdge::set(self : ImagefilterbilateralEdge, i : Int, v : Double) -> ImagefilterbilateralEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralEdge::sum(self : ImagefilterbilateralEdge) -> Double { @_common.sum(self.data) }

pub fn ImagefilterbilateralEdge::mean(self : ImagefilterbilateralEdge) -> Double { @_common.mean(self.data) }

pub fn ImagefilterbilateralEdge::scale(self : ImagefilterbilateralEdge, f : Double) -> ImagefilterbilateralEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralEdge::add(self : ImagefilterbilateralEdge, other : ImagefilterbilateralEdge) -> ImagefilterbilateralEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefilterbilateralEdge::copy(self : ImagefilterbilateralEdge) -> ImagefilterbilateralEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralEdge::fill(self : ImagefilterbilateralEdge, v : Double) -> ImagefilterbilateralEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralEdge::min(self : ImagefilterbilateralEdge) -> Double { @_common.min(self.data) }

pub fn ImagefilterbilateralEdge::max(self : ImagefilterbilateralEdge) -> Double { @_common.max(self.data) }

pub fn ImagefilterbilateralEdge::to_string(self : ImagefilterbilateralEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefilterbilateralPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_bilateral_path_make(size : Int) -> ImagefilterbilateralPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefilterbilateralPath::len(self : ImagefilterbilateralPath) -> Int { self.size }

pub fn ImagefilterbilateralPath::get(self : ImagefilterbilateralPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefilterbilateralPath::set(self : ImagefilterbilateralPath, i : Int, v : Double) -> ImagefilterbilateralPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralPath::sum(self : ImagefilterbilateralPath) -> Double { @_common.sum(self.data) }

pub fn ImagefilterbilateralPath::mean(self : ImagefilterbilateralPath) -> Double { @_common.mean(self.data) }

pub fn ImagefilterbilateralPath::scale(self : ImagefilterbilateralPath, f : Double) -> ImagefilterbilateralPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralPath::add(self : ImagefilterbilateralPath, other : ImagefilterbilateralPath) -> ImagefilterbilateralPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefilterbilateralPath::copy(self : ImagefilterbilateralPath) -> ImagefilterbilateralPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralPath::fill(self : ImagefilterbilateralPath, v : Double) -> ImagefilterbilateralPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralPath::min(self : ImagefilterbilateralPath) -> Double { @_common.min(self.data) }

pub fn ImagefilterbilateralPath::max(self : ImagefilterbilateralPath) -> Double { @_common.max(self.data) }

pub fn ImagefilterbilateralPath::to_string(self : ImagefilterbilateralPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefilterbilateralCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_bilateral_cluster_make(size : Int) -> ImagefilterbilateralCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefilterbilateralCluster::len(self : ImagefilterbilateralCluster) -> Int { self.size }

pub fn ImagefilterbilateralCluster::get(self : ImagefilterbilateralCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefilterbilateralCluster::set(self : ImagefilterbilateralCluster, i : Int, v : Double) -> ImagefilterbilateralCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralCluster::sum(self : ImagefilterbilateralCluster) -> Double { @_common.sum(self.data) }

pub fn ImagefilterbilateralCluster::mean(self : ImagefilterbilateralCluster) -> Double { @_common.mean(self.data) }

pub fn ImagefilterbilateralCluster::scale(self : ImagefilterbilateralCluster, f : Double) -> ImagefilterbilateralCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralCluster::add(self : ImagefilterbilateralCluster, other : ImagefilterbilateralCluster) -> ImagefilterbilateralCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefilterbilateralCluster::copy(self : ImagefilterbilateralCluster) -> ImagefilterbilateralCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralCluster::fill(self : ImagefilterbilateralCluster, v : Double) -> ImagefilterbilateralCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralCluster::min(self : ImagefilterbilateralCluster) -> Double { @_common.min(self.data) }

pub fn ImagefilterbilateralCluster::max(self : ImagefilterbilateralCluster) -> Double { @_common.max(self.data) }

pub fn ImagefilterbilateralCluster::to_string(self : ImagefilterbilateralCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefilterbilateralModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_bilateral_model_make(size : Int) -> ImagefilterbilateralModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefilterbilateralModel::len(self : ImagefilterbilateralModel) -> Int { self.size }

pub fn ImagefilterbilateralModel::get(self : ImagefilterbilateralModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefilterbilateralModel::set(self : ImagefilterbilateralModel, i : Int, v : Double) -> ImagefilterbilateralModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralModel::sum(self : ImagefilterbilateralModel) -> Double { @_common.sum(self.data) }

pub fn ImagefilterbilateralModel::mean(self : ImagefilterbilateralModel) -> Double { @_common.mean(self.data) }

pub fn ImagefilterbilateralModel::scale(self : ImagefilterbilateralModel, f : Double) -> ImagefilterbilateralModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralModel::add(self : ImagefilterbilateralModel, other : ImagefilterbilateralModel) -> ImagefilterbilateralModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefilterbilateralModel::copy(self : ImagefilterbilateralModel) -> ImagefilterbilateralModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralModel::fill(self : ImagefilterbilateralModel, v : Double) -> ImagefilterbilateralModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralModel::min(self : ImagefilterbilateralModel) -> Double { @_common.min(self.data) }

pub fn ImagefilterbilateralModel::max(self : ImagefilterbilateralModel) -> Double { @_common.max(self.data) }

pub fn ImagefilterbilateralModel::to_string(self : ImagefilterbilateralModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefilterbilateralLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_bilateral_layer_make(size : Int) -> ImagefilterbilateralLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefilterbilateralLayer::len(self : ImagefilterbilateralLayer) -> Int { self.size }

pub fn ImagefilterbilateralLayer::get(self : ImagefilterbilateralLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefilterbilateralLayer::set(self : ImagefilterbilateralLayer, i : Int, v : Double) -> ImagefilterbilateralLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralLayer::sum(self : ImagefilterbilateralLayer) -> Double { @_common.sum(self.data) }

pub fn ImagefilterbilateralLayer::mean(self : ImagefilterbilateralLayer) -> Double { @_common.mean(self.data) }

pub fn ImagefilterbilateralLayer::scale(self : ImagefilterbilateralLayer, f : Double) -> ImagefilterbilateralLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralLayer::add(self : ImagefilterbilateralLayer, other : ImagefilterbilateralLayer) -> ImagefilterbilateralLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefilterbilateralLayer::copy(self : ImagefilterbilateralLayer) -> ImagefilterbilateralLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralLayer::fill(self : ImagefilterbilateralLayer, v : Double) -> ImagefilterbilateralLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralLayer::min(self : ImagefilterbilateralLayer) -> Double { @_common.min(self.data) }

pub fn ImagefilterbilateralLayer::max(self : ImagefilterbilateralLayer) -> Double { @_common.max(self.data) }

pub fn ImagefilterbilateralLayer::to_string(self : ImagefilterbilateralLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefilterbilateralBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_bilateral_buffer_make(size : Int) -> ImagefilterbilateralBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefilterbilateralBuffer::len(self : ImagefilterbilateralBuffer) -> Int { self.size }

pub fn ImagefilterbilateralBuffer::get(self : ImagefilterbilateralBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefilterbilateralBuffer::set(self : ImagefilterbilateralBuffer, i : Int, v : Double) -> ImagefilterbilateralBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralBuffer::sum(self : ImagefilterbilateralBuffer) -> Double { @_common.sum(self.data) }

pub fn ImagefilterbilateralBuffer::mean(self : ImagefilterbilateralBuffer) -> Double { @_common.mean(self.data) }

pub fn ImagefilterbilateralBuffer::scale(self : ImagefilterbilateralBuffer, f : Double) -> ImagefilterbilateralBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralBuffer::add(self : ImagefilterbilateralBuffer, other : ImagefilterbilateralBuffer) -> ImagefilterbilateralBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefilterbilateralBuffer::copy(self : ImagefilterbilateralBuffer) -> ImagefilterbilateralBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralBuffer::fill(self : ImagefilterbilateralBuffer, v : Double) -> ImagefilterbilateralBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralBuffer::min(self : ImagefilterbilateralBuffer) -> Double { @_common.min(self.data) }

pub fn ImagefilterbilateralBuffer::max(self : ImagefilterbilateralBuffer) -> Double { @_common.max(self.data) }

pub fn ImagefilterbilateralBuffer::to_string(self : ImagefilterbilateralBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefilterbilateralCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_bilateral_cursor_make(size : Int) -> ImagefilterbilateralCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefilterbilateralCursor::len(self : ImagefilterbilateralCursor) -> Int { self.size }

pub fn ImagefilterbilateralCursor::get(self : ImagefilterbilateralCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefilterbilateralCursor::set(self : ImagefilterbilateralCursor, i : Int, v : Double) -> ImagefilterbilateralCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralCursor::sum(self : ImagefilterbilateralCursor) -> Double { @_common.sum(self.data) }

pub fn ImagefilterbilateralCursor::mean(self : ImagefilterbilateralCursor) -> Double { @_common.mean(self.data) }

pub fn ImagefilterbilateralCursor::scale(self : ImagefilterbilateralCursor, f : Double) -> ImagefilterbilateralCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralCursor::add(self : ImagefilterbilateralCursor, other : ImagefilterbilateralCursor) -> ImagefilterbilateralCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefilterbilateralCursor::copy(self : ImagefilterbilateralCursor) -> ImagefilterbilateralCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralCursor::fill(self : ImagefilterbilateralCursor, v : Double) -> ImagefilterbilateralCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralCursor::min(self : ImagefilterbilateralCursor) -> Double { @_common.min(self.data) }

pub fn ImagefilterbilateralCursor::max(self : ImagefilterbilateralCursor) -> Double { @_common.max(self.data) }

pub fn ImagefilterbilateralCursor::to_string(self : ImagefilterbilateralCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefilterbilateralView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_bilateral_view_make(size : Int) -> ImagefilterbilateralView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefilterbilateralView::len(self : ImagefilterbilateralView) -> Int { self.size }

pub fn ImagefilterbilateralView::get(self : ImagefilterbilateralView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefilterbilateralView::set(self : ImagefilterbilateralView, i : Int, v : Double) -> ImagefilterbilateralView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralView::sum(self : ImagefilterbilateralView) -> Double { @_common.sum(self.data) }

pub fn ImagefilterbilateralView::mean(self : ImagefilterbilateralView) -> Double { @_common.mean(self.data) }

pub fn ImagefilterbilateralView::scale(self : ImagefilterbilateralView, f : Double) -> ImagefilterbilateralView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralView::add(self : ImagefilterbilateralView, other : ImagefilterbilateralView) -> ImagefilterbilateralView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefilterbilateralView::copy(self : ImagefilterbilateralView) -> ImagefilterbilateralView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralView::fill(self : ImagefilterbilateralView, v : Double) -> ImagefilterbilateralView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralView::min(self : ImagefilterbilateralView) -> Double { @_common.min(self.data) }

pub fn ImagefilterbilateralView::max(self : ImagefilterbilateralView) -> Double { @_common.max(self.data) }

pub fn ImagefilterbilateralView::to_string(self : ImagefilterbilateralView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefilterbilateralRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_bilateral_range_make(size : Int) -> ImagefilterbilateralRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefilterbilateralRange::len(self : ImagefilterbilateralRange) -> Int { self.size }

pub fn ImagefilterbilateralRange::get(self : ImagefilterbilateralRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefilterbilateralRange::set(self : ImagefilterbilateralRange, i : Int, v : Double) -> ImagefilterbilateralRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralRange::sum(self : ImagefilterbilateralRange) -> Double { @_common.sum(self.data) }

pub fn ImagefilterbilateralRange::mean(self : ImagefilterbilateralRange) -> Double { @_common.mean(self.data) }

pub fn ImagefilterbilateralRange::scale(self : ImagefilterbilateralRange, f : Double) -> ImagefilterbilateralRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralRange::add(self : ImagefilterbilateralRange, other : ImagefilterbilateralRange) -> ImagefilterbilateralRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefilterbilateralRange::copy(self : ImagefilterbilateralRange) -> ImagefilterbilateralRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralRange::fill(self : ImagefilterbilateralRange, v : Double) -> ImagefilterbilateralRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralRange::min(self : ImagefilterbilateralRange) -> Double { @_common.min(self.data) }

pub fn ImagefilterbilateralRange::max(self : ImagefilterbilateralRange) -> Double { @_common.max(self.data) }

pub fn ImagefilterbilateralRange::to_string(self : ImagefilterbilateralRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefilterbilateralSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_bilateral_slice_make(size : Int) -> ImagefilterbilateralSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefilterbilateralSlice::len(self : ImagefilterbilateralSlice) -> Int { self.size }

pub fn ImagefilterbilateralSlice::get(self : ImagefilterbilateralSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefilterbilateralSlice::set(self : ImagefilterbilateralSlice, i : Int, v : Double) -> ImagefilterbilateralSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralSlice::sum(self : ImagefilterbilateralSlice) -> Double { @_common.sum(self.data) }

pub fn ImagefilterbilateralSlice::mean(self : ImagefilterbilateralSlice) -> Double { @_common.mean(self.data) }

pub fn ImagefilterbilateralSlice::scale(self : ImagefilterbilateralSlice, f : Double) -> ImagefilterbilateralSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralSlice::add(self : ImagefilterbilateralSlice, other : ImagefilterbilateralSlice) -> ImagefilterbilateralSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefilterbilateralSlice::copy(self : ImagefilterbilateralSlice) -> ImagefilterbilateralSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralSlice::fill(self : ImagefilterbilateralSlice, v : Double) -> ImagefilterbilateralSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefilterbilateralSlice::min(self : ImagefilterbilateralSlice) -> Double { @_common.min(self.data) }

pub fn ImagefilterbilateralSlice::max(self : ImagefilterbilateralSlice) -> Double { @_common.max(self.data) }

pub fn ImagefilterbilateralSlice::to_string(self : ImagefilterbilateralSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

