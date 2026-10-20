///===
/// extcore/image_filter_gaussian

pub(all) struct ImagefiltergaussianPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_filter_gaussian_make_point(x : Double, y : Double) -> ImagefiltergaussianPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_filter_gaussian_make_point3(x : Double, y : Double, z : Double) -> ImagefiltergaussianPoint {
  { x, y, z, label: 0 }
}

pub fn ImagefiltergaussianPoint::x(self : ImagefiltergaussianPoint) -> Double { self.x }

pub fn ImagefiltergaussianPoint::y(self : ImagefiltergaussianPoint) -> Double { self.y }

pub fn ImagefiltergaussianPoint::z(self : ImagefiltergaussianPoint) -> Double { self.z }

pub fn ImagefiltergaussianPoint::label(self : ImagefiltergaussianPoint) -> Int { self.label }

pub fn ImagefiltergaussianPoint::dist(self : ImagefiltergaussianPoint, other : ImagefiltergaussianPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagefiltergaussianPoint::add(self : ImagefiltergaussianPoint, other : ImagefiltergaussianPoint) -> ImagefiltergaussianPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagefiltergaussianPoint::sub(self : ImagefiltergaussianPoint, other : ImagefiltergaussianPoint) -> ImagefiltergaussianPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagefiltergaussianPoint::scale(self : ImagefiltergaussianPoint, s : Double) -> ImagefiltergaussianPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagefiltergaussianPoint::dot(self : ImagefiltergaussianPoint, other : ImagefiltergaussianPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagefiltergaussianPoint::cross(self : ImagefiltergaussianPoint, other : ImagefiltergaussianPoint) -> ImagefiltergaussianPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagefiltergaussianPoint::norm(self : ImagefiltergaussianPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagefiltergaussianPoint::normalize(self : ImagefiltergaussianPoint) -> ImagefiltergaussianPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefiltergaussianPoint::negate(self : ImagefiltergaussianPoint) -> ImagefiltergaussianPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagefiltergaussianPoint::mid(self : ImagefiltergaussianPoint, other : ImagefiltergaussianPoint) -> ImagefiltergaussianPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagefiltergaussianPoint::lerp(self : ImagefiltergaussianPoint, other : ImagefiltergaussianPoint, t : Double) -> ImagefiltergaussianPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagefiltergaussianPoint::to_string(self : ImagefiltergaussianPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagefiltergaussianSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_filter_gaussian_make_series(vals : Array[Double], name : String) -> ImagefiltergaussianSeries {
  { vals, name, meta: 0 }
}

pub fn ImagefiltergaussianSeries::len(self : ImagefiltergaussianSeries) -> Int { self.vals.length() }

pub fn ImagefiltergaussianSeries::sum(self : ImagefiltergaussianSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagefiltergaussianSeries::mean(self : ImagefiltergaussianSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagefiltergaussianSeries::min(self : ImagefiltergaussianSeries) -> Double { @_common.min(self.vals) }

pub fn ImagefiltergaussianSeries::max(self : ImagefiltergaussianSeries) -> Double { @_common.max(self.vals) }

pub fn ImagefiltergaussianSeries::range(self : ImagefiltergaussianSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagefiltergaussianSeries::variance(self : ImagefiltergaussianSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagefiltergaussianSeries::std(self : ImagefiltergaussianSeries) -> Double { @_common.std(self.vals) }

pub fn ImagefiltergaussianSeries::median(self : ImagefiltergaussianSeries) -> Double { @_common.median(self.vals) }

pub fn ImagefiltergaussianSeries::scale(self : ImagefiltergaussianSeries, f : Double) -> ImagefiltergaussianSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagefiltergaussianSeries::add(self : ImagefiltergaussianSeries, other : ImagefiltergaussianSeries) -> ImagefiltergaussianSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagefiltergaussianSeries::sub(self : ImagefiltergaussianSeries, other : ImagefiltergaussianSeries) -> ImagefiltergaussianSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagefiltergaussianSeries::normalize(self : ImagefiltergaussianSeries) -> ImagefiltergaussianSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagefiltergaussianSeries::cumsum(self : ImagefiltergaussianSeries) -> ImagefiltergaussianSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagefiltergaussianSeries::to_string(self : ImagefiltergaussianSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefiltergaussianMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_filter_gaussian_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefiltergaussianMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn image_filter_gaussian_matrix_identity(n : Int) -> ImagefiltergaussianMatrix {
  let m = image_filter_gaussian_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagefiltergaussianMatrix::get(self : ImagefiltergaussianMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagefiltergaussianMatrix::transpose(self : ImagefiltergaussianMatrix) -> ImagefiltergaussianMatrix {
  let result = image_filter_gaussian_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagefiltergaussianMatrix::add(self : ImagefiltergaussianMatrix, other : ImagefiltergaussianMatrix) -> ImagefiltergaussianMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_filter_gaussian_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagefiltergaussianMatrix::scale(self : ImagefiltergaussianMatrix, s : Double) -> ImagefiltergaussianMatrix {
  let result = image_filter_gaussian_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagefiltergaussianMatrix::multiply(self : ImagefiltergaussianMatrix, other : ImagefiltergaussianMatrix) -> ImagefiltergaussianMatrix {
  if self.cols != other.rows { return image_filter_gaussian_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_filter_gaussian_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn ImagefiltergaussianMatrix::trace(self : ImagefiltergaussianMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagefiltergaussianMatrix::det(self : ImagefiltergaussianMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagefiltergaussianMatrix::norm(self : ImagefiltergaussianMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagefiltergaussianMatrix::to_string(self : ImagefiltergaussianMatrix) -> String {
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

pub(all) struct ImagefiltergaussianVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_filter_gaussian_make_vector(comps : Array[Double]) -> ImagefiltergaussianVector {
  { comps, dim: comps.length() }
}

pub fn image_filter_gaussian_vector_zero(dim : Int) -> ImagefiltergaussianVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagefiltergaussianVector::add(self : ImagefiltergaussianVector, other : ImagefiltergaussianVector) -> ImagefiltergaussianVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefiltergaussianVector::sub(self : ImagefiltergaussianVector, other : ImagefiltergaussianVector) -> ImagefiltergaussianVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefiltergaussianVector::scale(self : ImagefiltergaussianVector, s : Double) -> ImagefiltergaussianVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagefiltergaussianVector::dot(self : ImagefiltergaussianVector, other : ImagefiltergaussianVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagefiltergaussianVector::norm(self : ImagefiltergaussianVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagefiltergaussianVector::normalize(self : ImagefiltergaussianVector) -> ImagefiltergaussianVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefiltergaussianVector::dist(self : ImagefiltergaussianVector, other : ImagefiltergaussianVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagefiltergaussianVector::to_string(self : ImagefiltergaussianVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefiltergaussianFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gaussian_frame_make(size : Int) -> ImagefiltergaussianFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefiltergaussianFrame::len(self : ImagefiltergaussianFrame) -> Int { self.size }

pub fn ImagefiltergaussianFrame::get(self : ImagefiltergaussianFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefiltergaussianFrame::set(self : ImagefiltergaussianFrame, i : Int, v : Double) -> ImagefiltergaussianFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianFrame::sum(self : ImagefiltergaussianFrame) -> Double { @_common.sum(self.data) }

pub fn ImagefiltergaussianFrame::mean(self : ImagefiltergaussianFrame) -> Double { @_common.mean(self.data) }

pub fn ImagefiltergaussianFrame::scale(self : ImagefiltergaussianFrame, f : Double) -> ImagefiltergaussianFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianFrame::add(self : ImagefiltergaussianFrame, other : ImagefiltergaussianFrame) -> ImagefiltergaussianFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefiltergaussianFrame::copy(self : ImagefiltergaussianFrame) -> ImagefiltergaussianFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianFrame::fill(self : ImagefiltergaussianFrame, v : Double) -> ImagefiltergaussianFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianFrame::min(self : ImagefiltergaussianFrame) -> Double { @_common.min(self.data) }

pub fn ImagefiltergaussianFrame::max(self : ImagefiltergaussianFrame) -> Double { @_common.max(self.data) }

pub fn ImagefiltergaussianFrame::to_string(self : ImagefiltergaussianFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaussianTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gaussian_table_make(size : Int) -> ImagefiltergaussianTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefiltergaussianTable::len(self : ImagefiltergaussianTable) -> Int { self.size }

pub fn ImagefiltergaussianTable::get(self : ImagefiltergaussianTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefiltergaussianTable::set(self : ImagefiltergaussianTable, i : Int, v : Double) -> ImagefiltergaussianTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianTable::sum(self : ImagefiltergaussianTable) -> Double { @_common.sum(self.data) }

pub fn ImagefiltergaussianTable::mean(self : ImagefiltergaussianTable) -> Double { @_common.mean(self.data) }

pub fn ImagefiltergaussianTable::scale(self : ImagefiltergaussianTable, f : Double) -> ImagefiltergaussianTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianTable::add(self : ImagefiltergaussianTable, other : ImagefiltergaussianTable) -> ImagefiltergaussianTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefiltergaussianTable::copy(self : ImagefiltergaussianTable) -> ImagefiltergaussianTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianTable::fill(self : ImagefiltergaussianTable, v : Double) -> ImagefiltergaussianTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianTable::min(self : ImagefiltergaussianTable) -> Double { @_common.min(self.data) }

pub fn ImagefiltergaussianTable::max(self : ImagefiltergaussianTable) -> Double { @_common.max(self.data) }

pub fn ImagefiltergaussianTable::to_string(self : ImagefiltergaussianTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaussianGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gaussian_graphn_make(size : Int) -> ImagefiltergaussianGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefiltergaussianGraphN::len(self : ImagefiltergaussianGraphN) -> Int { self.size }

pub fn ImagefiltergaussianGraphN::get(self : ImagefiltergaussianGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefiltergaussianGraphN::set(self : ImagefiltergaussianGraphN, i : Int, v : Double) -> ImagefiltergaussianGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianGraphN::sum(self : ImagefiltergaussianGraphN) -> Double { @_common.sum(self.data) }

pub fn ImagefiltergaussianGraphN::mean(self : ImagefiltergaussianGraphN) -> Double { @_common.mean(self.data) }

pub fn ImagefiltergaussianGraphN::scale(self : ImagefiltergaussianGraphN, f : Double) -> ImagefiltergaussianGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianGraphN::add(self : ImagefiltergaussianGraphN, other : ImagefiltergaussianGraphN) -> ImagefiltergaussianGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefiltergaussianGraphN::copy(self : ImagefiltergaussianGraphN) -> ImagefiltergaussianGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianGraphN::fill(self : ImagefiltergaussianGraphN, v : Double) -> ImagefiltergaussianGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianGraphN::min(self : ImagefiltergaussianGraphN) -> Double { @_common.min(self.data) }

pub fn ImagefiltergaussianGraphN::max(self : ImagefiltergaussianGraphN) -> Double { @_common.max(self.data) }

pub fn ImagefiltergaussianGraphN::to_string(self : ImagefiltergaussianGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaussianNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gaussian_node_make(size : Int) -> ImagefiltergaussianNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefiltergaussianNode::len(self : ImagefiltergaussianNode) -> Int { self.size }

pub fn ImagefiltergaussianNode::get(self : ImagefiltergaussianNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefiltergaussianNode::set(self : ImagefiltergaussianNode, i : Int, v : Double) -> ImagefiltergaussianNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianNode::sum(self : ImagefiltergaussianNode) -> Double { @_common.sum(self.data) }

pub fn ImagefiltergaussianNode::mean(self : ImagefiltergaussianNode) -> Double { @_common.mean(self.data) }

pub fn ImagefiltergaussianNode::scale(self : ImagefiltergaussianNode, f : Double) -> ImagefiltergaussianNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianNode::add(self : ImagefiltergaussianNode, other : ImagefiltergaussianNode) -> ImagefiltergaussianNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefiltergaussianNode::copy(self : ImagefiltergaussianNode) -> ImagefiltergaussianNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianNode::fill(self : ImagefiltergaussianNode, v : Double) -> ImagefiltergaussianNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianNode::min(self : ImagefiltergaussianNode) -> Double { @_common.min(self.data) }

pub fn ImagefiltergaussianNode::max(self : ImagefiltergaussianNode) -> Double { @_common.max(self.data) }

pub fn ImagefiltergaussianNode::to_string(self : ImagefiltergaussianNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaussianEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gaussian_edge_make(size : Int) -> ImagefiltergaussianEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefiltergaussianEdge::len(self : ImagefiltergaussianEdge) -> Int { self.size }

pub fn ImagefiltergaussianEdge::get(self : ImagefiltergaussianEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefiltergaussianEdge::set(self : ImagefiltergaussianEdge, i : Int, v : Double) -> ImagefiltergaussianEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianEdge::sum(self : ImagefiltergaussianEdge) -> Double { @_common.sum(self.data) }

pub fn ImagefiltergaussianEdge::mean(self : ImagefiltergaussianEdge) -> Double { @_common.mean(self.data) }

pub fn ImagefiltergaussianEdge::scale(self : ImagefiltergaussianEdge, f : Double) -> ImagefiltergaussianEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianEdge::add(self : ImagefiltergaussianEdge, other : ImagefiltergaussianEdge) -> ImagefiltergaussianEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefiltergaussianEdge::copy(self : ImagefiltergaussianEdge) -> ImagefiltergaussianEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianEdge::fill(self : ImagefiltergaussianEdge, v : Double) -> ImagefiltergaussianEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianEdge::min(self : ImagefiltergaussianEdge) -> Double { @_common.min(self.data) }

pub fn ImagefiltergaussianEdge::max(self : ImagefiltergaussianEdge) -> Double { @_common.max(self.data) }

pub fn ImagefiltergaussianEdge::to_string(self : ImagefiltergaussianEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaussianPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gaussian_path_make(size : Int) -> ImagefiltergaussianPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefiltergaussianPath::len(self : ImagefiltergaussianPath) -> Int { self.size }

pub fn ImagefiltergaussianPath::get(self : ImagefiltergaussianPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefiltergaussianPath::set(self : ImagefiltergaussianPath, i : Int, v : Double) -> ImagefiltergaussianPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianPath::sum(self : ImagefiltergaussianPath) -> Double { @_common.sum(self.data) }

pub fn ImagefiltergaussianPath::mean(self : ImagefiltergaussianPath) -> Double { @_common.mean(self.data) }

pub fn ImagefiltergaussianPath::scale(self : ImagefiltergaussianPath, f : Double) -> ImagefiltergaussianPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianPath::add(self : ImagefiltergaussianPath, other : ImagefiltergaussianPath) -> ImagefiltergaussianPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefiltergaussianPath::copy(self : ImagefiltergaussianPath) -> ImagefiltergaussianPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianPath::fill(self : ImagefiltergaussianPath, v : Double) -> ImagefiltergaussianPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianPath::min(self : ImagefiltergaussianPath) -> Double { @_common.min(self.data) }

pub fn ImagefiltergaussianPath::max(self : ImagefiltergaussianPath) -> Double { @_common.max(self.data) }

pub fn ImagefiltergaussianPath::to_string(self : ImagefiltergaussianPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaussianCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gaussian_cluster_make(size : Int) -> ImagefiltergaussianCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefiltergaussianCluster::len(self : ImagefiltergaussianCluster) -> Int { self.size }

pub fn ImagefiltergaussianCluster::get(self : ImagefiltergaussianCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefiltergaussianCluster::set(self : ImagefiltergaussianCluster, i : Int, v : Double) -> ImagefiltergaussianCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianCluster::sum(self : ImagefiltergaussianCluster) -> Double { @_common.sum(self.data) }

pub fn ImagefiltergaussianCluster::mean(self : ImagefiltergaussianCluster) -> Double { @_common.mean(self.data) }

pub fn ImagefiltergaussianCluster::scale(self : ImagefiltergaussianCluster, f : Double) -> ImagefiltergaussianCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianCluster::add(self : ImagefiltergaussianCluster, other : ImagefiltergaussianCluster) -> ImagefiltergaussianCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefiltergaussianCluster::copy(self : ImagefiltergaussianCluster) -> ImagefiltergaussianCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianCluster::fill(self : ImagefiltergaussianCluster, v : Double) -> ImagefiltergaussianCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianCluster::min(self : ImagefiltergaussianCluster) -> Double { @_common.min(self.data) }

pub fn ImagefiltergaussianCluster::max(self : ImagefiltergaussianCluster) -> Double { @_common.max(self.data) }

pub fn ImagefiltergaussianCluster::to_string(self : ImagefiltergaussianCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaussianModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gaussian_model_make(size : Int) -> ImagefiltergaussianModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefiltergaussianModel::len(self : ImagefiltergaussianModel) -> Int { self.size }

pub fn ImagefiltergaussianModel::get(self : ImagefiltergaussianModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefiltergaussianModel::set(self : ImagefiltergaussianModel, i : Int, v : Double) -> ImagefiltergaussianModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianModel::sum(self : ImagefiltergaussianModel) -> Double { @_common.sum(self.data) }

pub fn ImagefiltergaussianModel::mean(self : ImagefiltergaussianModel) -> Double { @_common.mean(self.data) }

pub fn ImagefiltergaussianModel::scale(self : ImagefiltergaussianModel, f : Double) -> ImagefiltergaussianModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianModel::add(self : ImagefiltergaussianModel, other : ImagefiltergaussianModel) -> ImagefiltergaussianModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefiltergaussianModel::copy(self : ImagefiltergaussianModel) -> ImagefiltergaussianModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianModel::fill(self : ImagefiltergaussianModel, v : Double) -> ImagefiltergaussianModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianModel::min(self : ImagefiltergaussianModel) -> Double { @_common.min(self.data) }

pub fn ImagefiltergaussianModel::max(self : ImagefiltergaussianModel) -> Double { @_common.max(self.data) }

pub fn ImagefiltergaussianModel::to_string(self : ImagefiltergaussianModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaussianLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gaussian_layer_make(size : Int) -> ImagefiltergaussianLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefiltergaussianLayer::len(self : ImagefiltergaussianLayer) -> Int { self.size }

pub fn ImagefiltergaussianLayer::get(self : ImagefiltergaussianLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefiltergaussianLayer::set(self : ImagefiltergaussianLayer, i : Int, v : Double) -> ImagefiltergaussianLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianLayer::sum(self : ImagefiltergaussianLayer) -> Double { @_common.sum(self.data) }

pub fn ImagefiltergaussianLayer::mean(self : ImagefiltergaussianLayer) -> Double { @_common.mean(self.data) }

pub fn ImagefiltergaussianLayer::scale(self : ImagefiltergaussianLayer, f : Double) -> ImagefiltergaussianLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianLayer::add(self : ImagefiltergaussianLayer, other : ImagefiltergaussianLayer) -> ImagefiltergaussianLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefiltergaussianLayer::copy(self : ImagefiltergaussianLayer) -> ImagefiltergaussianLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianLayer::fill(self : ImagefiltergaussianLayer, v : Double) -> ImagefiltergaussianLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianLayer::min(self : ImagefiltergaussianLayer) -> Double { @_common.min(self.data) }

pub fn ImagefiltergaussianLayer::max(self : ImagefiltergaussianLayer) -> Double { @_common.max(self.data) }

pub fn ImagefiltergaussianLayer::to_string(self : ImagefiltergaussianLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaussianBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gaussian_buffer_make(size : Int) -> ImagefiltergaussianBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefiltergaussianBuffer::len(self : ImagefiltergaussianBuffer) -> Int { self.size }

pub fn ImagefiltergaussianBuffer::get(self : ImagefiltergaussianBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefiltergaussianBuffer::set(self : ImagefiltergaussianBuffer, i : Int, v : Double) -> ImagefiltergaussianBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianBuffer::sum(self : ImagefiltergaussianBuffer) -> Double { @_common.sum(self.data) }

pub fn ImagefiltergaussianBuffer::mean(self : ImagefiltergaussianBuffer) -> Double { @_common.mean(self.data) }

pub fn ImagefiltergaussianBuffer::scale(self : ImagefiltergaussianBuffer, f : Double) -> ImagefiltergaussianBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianBuffer::add(self : ImagefiltergaussianBuffer, other : ImagefiltergaussianBuffer) -> ImagefiltergaussianBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefiltergaussianBuffer::copy(self : ImagefiltergaussianBuffer) -> ImagefiltergaussianBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianBuffer::fill(self : ImagefiltergaussianBuffer, v : Double) -> ImagefiltergaussianBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianBuffer::min(self : ImagefiltergaussianBuffer) -> Double { @_common.min(self.data) }

pub fn ImagefiltergaussianBuffer::max(self : ImagefiltergaussianBuffer) -> Double { @_common.max(self.data) }

pub fn ImagefiltergaussianBuffer::to_string(self : ImagefiltergaussianBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaussianCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gaussian_cursor_make(size : Int) -> ImagefiltergaussianCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefiltergaussianCursor::len(self : ImagefiltergaussianCursor) -> Int { self.size }

pub fn ImagefiltergaussianCursor::get(self : ImagefiltergaussianCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefiltergaussianCursor::set(self : ImagefiltergaussianCursor, i : Int, v : Double) -> ImagefiltergaussianCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianCursor::sum(self : ImagefiltergaussianCursor) -> Double { @_common.sum(self.data) }

pub fn ImagefiltergaussianCursor::mean(self : ImagefiltergaussianCursor) -> Double { @_common.mean(self.data) }

pub fn ImagefiltergaussianCursor::scale(self : ImagefiltergaussianCursor, f : Double) -> ImagefiltergaussianCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianCursor::add(self : ImagefiltergaussianCursor, other : ImagefiltergaussianCursor) -> ImagefiltergaussianCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefiltergaussianCursor::copy(self : ImagefiltergaussianCursor) -> ImagefiltergaussianCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianCursor::fill(self : ImagefiltergaussianCursor, v : Double) -> ImagefiltergaussianCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianCursor::min(self : ImagefiltergaussianCursor) -> Double { @_common.min(self.data) }

pub fn ImagefiltergaussianCursor::max(self : ImagefiltergaussianCursor) -> Double { @_common.max(self.data) }

pub fn ImagefiltergaussianCursor::to_string(self : ImagefiltergaussianCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaussianView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gaussian_view_make(size : Int) -> ImagefiltergaussianView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefiltergaussianView::len(self : ImagefiltergaussianView) -> Int { self.size }

pub fn ImagefiltergaussianView::get(self : ImagefiltergaussianView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefiltergaussianView::set(self : ImagefiltergaussianView, i : Int, v : Double) -> ImagefiltergaussianView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianView::sum(self : ImagefiltergaussianView) -> Double { @_common.sum(self.data) }

pub fn ImagefiltergaussianView::mean(self : ImagefiltergaussianView) -> Double { @_common.mean(self.data) }

pub fn ImagefiltergaussianView::scale(self : ImagefiltergaussianView, f : Double) -> ImagefiltergaussianView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianView::add(self : ImagefiltergaussianView, other : ImagefiltergaussianView) -> ImagefiltergaussianView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefiltergaussianView::copy(self : ImagefiltergaussianView) -> ImagefiltergaussianView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianView::fill(self : ImagefiltergaussianView, v : Double) -> ImagefiltergaussianView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianView::min(self : ImagefiltergaussianView) -> Double { @_common.min(self.data) }

pub fn ImagefiltergaussianView::max(self : ImagefiltergaussianView) -> Double { @_common.max(self.data) }

pub fn ImagefiltergaussianView::to_string(self : ImagefiltergaussianView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaussianRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gaussian_range_make(size : Int) -> ImagefiltergaussianRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefiltergaussianRange::len(self : ImagefiltergaussianRange) -> Int { self.size }

pub fn ImagefiltergaussianRange::get(self : ImagefiltergaussianRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefiltergaussianRange::set(self : ImagefiltergaussianRange, i : Int, v : Double) -> ImagefiltergaussianRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianRange::sum(self : ImagefiltergaussianRange) -> Double { @_common.sum(self.data) }

pub fn ImagefiltergaussianRange::mean(self : ImagefiltergaussianRange) -> Double { @_common.mean(self.data) }

pub fn ImagefiltergaussianRange::scale(self : ImagefiltergaussianRange, f : Double) -> ImagefiltergaussianRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianRange::add(self : ImagefiltergaussianRange, other : ImagefiltergaussianRange) -> ImagefiltergaussianRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefiltergaussianRange::copy(self : ImagefiltergaussianRange) -> ImagefiltergaussianRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianRange::fill(self : ImagefiltergaussianRange, v : Double) -> ImagefiltergaussianRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianRange::min(self : ImagefiltergaussianRange) -> Double { @_common.min(self.data) }

pub fn ImagefiltergaussianRange::max(self : ImagefiltergaussianRange) -> Double { @_common.max(self.data) }

pub fn ImagefiltergaussianRange::to_string(self : ImagefiltergaussianRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaussianSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gaussian_slice_make(size : Int) -> ImagefiltergaussianSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ImagefiltergaussianSlice::len(self : ImagefiltergaussianSlice) -> Int { self.size }

pub fn ImagefiltergaussianSlice::get(self : ImagefiltergaussianSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ImagefiltergaussianSlice::set(self : ImagefiltergaussianSlice, i : Int, v : Double) -> ImagefiltergaussianSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianSlice::sum(self : ImagefiltergaussianSlice) -> Double { @_common.sum(self.data) }

pub fn ImagefiltergaussianSlice::mean(self : ImagefiltergaussianSlice) -> Double { @_common.mean(self.data) }

pub fn ImagefiltergaussianSlice::scale(self : ImagefiltergaussianSlice, f : Double) -> ImagefiltergaussianSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianSlice::add(self : ImagefiltergaussianSlice, other : ImagefiltergaussianSlice) -> ImagefiltergaussianSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ImagefiltergaussianSlice::copy(self : ImagefiltergaussianSlice) -> ImagefiltergaussianSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianSlice::fill(self : ImagefiltergaussianSlice, v : Double) -> ImagefiltergaussianSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ImagefiltergaussianSlice::min(self : ImagefiltergaussianSlice) -> Double { @_common.min(self.data) }

pub fn ImagefiltergaussianSlice::max(self : ImagefiltergaussianSlice) -> Double { @_common.max(self.data) }

pub fn ImagefiltergaussianSlice::to_string(self : ImagefiltergaussianSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

